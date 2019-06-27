Return-Path: <SRS0=pEez=U2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7A754C48BD6
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Jun 2019 12:07:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4DE832080C
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Jun 2019 12:07:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726857AbfF0MHp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Jun 2019 08:07:45 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:53461 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726375AbfF0MHo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jun 2019 08:07:44 -0400
Received: from p5b06daab.dip0.t-ipconnect.de ([91.6.218.171] helo=nanos)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1hgTBl-0001oS-BO; Thu, 27 Jun 2019 14:07:41 +0200
Date:   Thu, 27 Jun 2019 14:07:40 +0200 (CEST)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     "Sverdlin, Alexander (Nokia - DE/Ulm)" <alexander.sverdlin@nokia.com>
cc:     "x86@kernel.org" <x86@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Jason Vas Dias <jason.vas.dias@gmail.com>,
        Andy Lutomirski <luto@kernel.org>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>
Subject: Re: [PATCH v3 1/2] x86/vdso: Move mult and shift into struct
 vgtod_ts
In-Reply-To: <01ab4388-f259-e801-8c8a-f39b5abcfb52@nokia.com>
Message-ID: <alpine.DEB.2.21.1906271405400.32342@nanos.tec.linutronix.de>
References: <20190605144116.28553-1-alexander.sverdlin@nokia.com> <20190605144116.28553-2-alexander.sverdlin@nokia.com> <alpine.DEB.2.21.1906231008170.32342@nanos.tec.linutronix.de> <df6b6311-ac67-857f-5a81-aee4eabd9f47@nokia.com>
 <alpine.DEB.2.21.1906241135450.32342@nanos.tec.linutronix.de> <01ab4388-f259-e801-8c8a-f39b5abcfb52@nokia.com>
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

On Thu, 27 Jun 2019, Sverdlin, Alexander (Nokia - DE/Ulm) wrote:

> On 24/06/2019 11:40, Thomas Gleixner wrote:
> >>> The alternative solution for this is what Vincenzo has in his unified VDSO
> >>> patch series:
> >>>
> >>>   https://lkml.kernel.org/r/20190621095252.32307-1-vincenzo.frascino@arm.com
> >>>
> >>> It leaves the data struct unmodified and has a separate array for the raw
> >>> clock. That does not have the side effects at all.
> >>>
> >>> I'm in the process of merging that series and I actually adapted your
> >>> scheme to the new unified infrastructure where it has exactly the same
> >>> effects as with your original patches against the x86 version.
> >> please let me know if I need to rework [2/2] based on some not-yet-published
> >> branch of yours.
> > I've pushed it out now to
> > 
> >      git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git timers/vdso
> > 
> > The generic VDSO library has the support for RAW already with that separate
> > array. Testing would be welcomed!
> 
> Thanks for your and Vincenzo's efforts!
> I've applied the series onto 5.2.0-rc6 and did a quick test on a bare x86_64 and
> for me it looks good:

Did you use the git tree? If not, it would be interesting to have a test
against that as well because that's the final version.

> Number of clock_gettime() calls in 10 seconds:
> 
> 		Before		After		Diff
> MONOTONIC	152404300	200825950	+32%
> MONOTONIC_RAW	38804788	198765053	+412%
> REALTIME	151672619	201371468	+33%

The increase for mono and realtime is impressive. Which CPU is that?

Thanks,

	tglx
