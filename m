Return-Path: <SRS0=avfD=SQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CBF80C10F13
	for <linux-kernel@archiver.kernel.org>; Sun, 14 Apr 2019 10:53:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9AA9120848
	for <linux-kernel@archiver.kernel.org>; Sun, 14 Apr 2019 10:53:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726533AbfDNKxh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 14 Apr 2019 06:53:37 -0400
Received: from Galois.linutronix.de ([146.0.238.70]:42576 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725807AbfDNKxg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 14 Apr 2019 06:53:36 -0400
Received: from pd9ef12d2.dip0.t-ipconnect.de ([217.239.18.210] helo=nanos)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1hFclR-0001QF-Ig; Sun, 14 Apr 2019 12:53:33 +0200
Date:   Sun, 14 Apr 2019 12:53:32 +0200 (CEST)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Huw Davies <huw@codeweavers.com>
cc:     linux kernel <linux-kernel@vger.kernel.org>,
        Andy Lutomirski <luto@kernel.org>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>
Subject: Re: [PATCH 2/3] x86/vdso: Allow clock specific mult and shift
 values
In-Reply-To: <20190411101205.10006-3-huw@codeweavers.com>
Message-ID: <alpine.DEB.2.21.1904141229380.4917@nanos.tec.linutronix.de>
References: <20190411101205.10006-1-huw@codeweavers.com> <20190411101205.10006-3-huw@codeweavers.com>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 11 Apr 2019, Huw Davies wrote:

CC+: Vincenzo Frascino who is working on the generic VDSO.

> This will allow clocks with different mult and shift values,
> e.g. CLOCK_MONOTONIC_RAW, to be supported in the vDSO.
> 
> The coarse clocks do not require these data so the values are not
> copied for these clocks.
> 
> One could add potential new values of mult and shift alongside the
> existing values in struct vsyscall_gtod_data, but it seems more
> natural to group them with the actual clock data in the basetime array
> at the expense of a few more cycles in update_vsyscall().

The few cycles are one thing. Did you verify that this does not change the
cache layout for CLOCK_MONOTONIC and CLOCK_REALTIME? Let's look:

>  struct vgtod_ts {
>  	u64		sec;
>  	u64		nsec;
> +	u32		mult;
> +	u32		shift;
>  };
>  
>  #define VGTOD_BASES	(CLOCK_TAI + 1)
> @@ -40,8 +42,6 @@ struct vsyscall_gtod_data {
>  
>  	int		vclock_mode;
>  	u64		cycle_last;
> -	u32		mult;
> -	u32		shift;
>  
>  	struct vgtod_ts	basetime[VGTOD_BASES];

The current state is:

struct vsyscall_gtod_data {
	unsigned int               seq;                  /*     0     4 */
	int                        vclock_mode;          /*     4     4 */
	u64                        cycle_last;           /*     8     8 */
	u64                        mask;                 /*    16     8 */
	u32                        mult;                 /*    24     4 */
	u32                        shift;                /*    28     4 */
	struct vgtod_ts            basetime[12];         /*    32   192 */

       basetime[CLOCK_REALTIME]		32 .. 47
       basetime[CLOCK_MONOTONIC]	48 .. 63

So with your change it looks like this:

struct vsyscall_gtod_data {
	unsigned int               seq;                  /*     0     4 */
	int                        vclock_mode;          /*     4     4 */
	u64                        cycle_last;           /*     8     8 */
	struct vgtod_ts            basetime[12];         /*    16   288 */

which makes

       basetime[CLOCK_REALTIME]		16 .. 39
       basetime[CLOCK_MONOTONIC]	40 .. 63

So it stays in the same cache line, but as we move the VDSO to generic
code, the mask field needs to stay and this will make basetime[CLOCK_MONOTONIC] 
overlap into the next cache line.

See https://lkml.kernel.org/r/alpine.DEB.2.21.1902231727060.1666@nanos.tec.linutronix.de
for an alternate solution to this problem, which avoids this and just gives
CLOCK_MONOTONIC_RAW a separate storage space alltogether.

Thanks,

	tglx

