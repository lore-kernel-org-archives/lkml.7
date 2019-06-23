Return-Path: <SRS0=VFBv=UW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5A9E6C43613
	for <linux-kernel@archiver.kernel.org>; Sun, 23 Jun 2019 11:02:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 262CE20663
	for <linux-kernel@archiver.kernel.org>; Sun, 23 Jun 2019 11:02:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726516AbfFWLBh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 23 Jun 2019 07:01:37 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:33198 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726350AbfFWLBh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 23 Jun 2019 07:01:37 -0400
Received: from p5b06daab.dip0.t-ipconnect.de ([91.6.218.171] helo=nanos)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1hezZw-0007TA-3t; Sun, 23 Jun 2019 12:18:32 +0200
Date:   Sun, 23 Jun 2019 12:18:26 +0200 (CEST)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     "Sverdlin, Alexander (Nokia - DE/Ulm)" <alexander.sverdlin@nokia.com>
cc:     "x86@kernel.org" <x86@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Jason Vas Dias <jason.vas.dias@gmail.com>,
        Andy Lutomirski <luto@kernel.org>
Subject: Re: [PATCH v3 1/2] x86/vdso: Move mult and shift into struct
 vgtod_ts
In-Reply-To: <20190605144116.28553-2-alexander.sverdlin@nokia.com>
Message-ID: <alpine.DEB.2.21.1906231008170.32342@nanos.tec.linutronix.de>
References: <20190605144116.28553-1-alexander.sverdlin@nokia.com> <20190605144116.28553-2-alexander.sverdlin@nokia.com>
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

Alexander,

On Wed, 5 Jun 2019, Sverdlin, Alexander (Nokia - DE/Ulm) wrote:

> From: Alexander Sverdlin <alexander.sverdlin@nokia.com>
> 
> This is a preparation for CLOCK_MONOTONIC_RAW vDSO implementation.
> Coincidentally it had a slight performance improvement as well:
> 
> ---- Test code ----
>  #include <errno.h>
>  #include <stdio.h>
>  #include <stdlib.h>
>  #include <time.h>
>  #include <unistd.h>
> 
>  #define CLOCK_TYPE CLOCK_MONOTONIC_RAW
>  #define DURATION_SEC 10
> 
> int main(int argc, char **argv)
> {
> 	struct timespec t, end;
> 	unsigned long long cnt = 0;
> 
> 	clock_gettime(CLOCK_TYPE, &end);
> 	end.tv_sec += DURATION_SEC;
> 
> 	do {
> 		clock_gettime(CLOCK_TYPE, &t);
> 		++cnt;
> 	} while (t.tv_sec < end.tv_sec || t.tv_nsec < end.tv_nsec);
> 
> 	dprintf(STDOUT_FILENO, "%llu", cnt);
> 
> 	return EXIT_SUCCESS;
> }
> -------------------
> 
> The results from the above test program:
> 
> Clock                   Before  After   Diff
> -----                   ------  -----   ----
> CLOCK_MONOTONIC         355.5M  359.6M  +1%
> CLOCK_REALTIME          355.5M  359.6M  +1%

Been there done that. But the results of the micro benchmark above have to
be taken with a grain of salt.

Let's look at the cache side effects of this change:

Before:

struct vsyscall_gtod_data {
	unsigned int               seq;                  /*     0     4 */
	int                        vclock_mode;          /*     4     4 */
	u64                        cycle_last;           /*     8     8 */
	u64                        mask;                 /*    16     8 */
	u32                        mult;                 /*    24     4 */
	u32                        shift;                /*    28     4 */
	struct vgtod_ts            basetime[12];         /*    32   192 */
	/* --- cacheline 3 boundary (192 bytes) was 32 bytes ago --- */
	int                        tz_minuteswest;       /*   224     4 */
	int                        tz_dsttime;           /*   228     4 */

	/* size: 232, cachelines: 4, members: 9 */
	/* last cacheline: 40 bytes */
};

After:

struct vsyscall_gtod_data {
	unsigned int               seq;                  /*     0     4 */
	int                        vclock_mode;          /*     4     4 */
	u64                        cycle_last;           /*     8     8 */
	u64                        mask;                 /*    16     8 */
	struct vgtod_ts            basetime[12];         /*    24   288 */
	/* --- cacheline 4 boundary (256 bytes) was 56 bytes ago --- */
	int                        tz_minuteswest;       /*   312     4 */
	int                        tz_dsttime;           /*   316     4 */

	/* size: 320, cachelines: 5, members: 7 */
};

So the interesting change is here:

	struct vgtod_ts            basetime[12];         /*    32   192 */

vs.

	struct vgtod_ts            basetime[12];         /*    24   288 */

In the original version struct vgtod_ts occupies 16 bytes in the modified
version it has 24 bytes. As a consequence:

	CLOCK				Before		After
	data->basetime[CLOCK_REALTIME]	32 .. 47	24 .. 47
	data->basetime[CLOCK_MONOTONIC]	48 .. 63	48 .. 71

That means that the CLOCK_MONOTONIC storage now overlaps into a second
cache line. CLOCK_MONOTONIC is widely used.

Of course on a micro benchmark this does not matter at all, but in real
world use cases which care about cache pressure it does.

Another thing is that just adding some small computation to the benchmark
loop makes the advantage of the modified version go away and it becomes
slightly slower.

On a real world application which is a cache heavy and uses CLOCK MONOTONIC
extensivly I can observe a significant L1 miss increase (%2) with the
modified version.

Now there is something else which is interesting:

On a guest (pvclock) I can observe with your benchmark:

 Before:

	MONO  cnt: 576.7
	REAL  cnt: 576.6

 After: 

 	MONO  cnt: 577.1
	REAL  cnt: 577.0

But on a (different) host:

 Before:

       MONO   cnt: 353.9
       REAL   cnt: 354.4

 After:

       MONO   cnt: 347.9
       REAL   cnt: 347.1

Yuck!

So this is really sensitive and I'm inclined not to do that due to the
cache line side effect.

The alternative solution for this is what Vincenzo has in his unified VDSO
patch series:

  https://lkml.kernel.org/r/20190621095252.32307-1-vincenzo.frascino@arm.com

It leaves the data struct unmodified and has a separate array for the raw
clock. That does not have the side effects at all.

I'm in the process of merging that series and I actually adapted your
scheme to the new unified infrastructure where it has exactly the same
effects as with your original patches against the x86 version.

Thanks,

	tglx
