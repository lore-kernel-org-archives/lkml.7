Return-Path: <SRS0=hO5d=UX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8F924C43613
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Jun 2019 09:40:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 636B72054F
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Jun 2019 09:40:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728285AbfFXJkG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Jun 2019 05:40:06 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:35467 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725881AbfFXJkF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jun 2019 05:40:05 -0400
Received: from p5b06daab.dip0.t-ipconnect.de ([91.6.218.171] helo=nanos)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1hfLSF-0003z0-5T; Mon, 24 Jun 2019 11:40:03 +0200
Date:   Mon, 24 Jun 2019 11:40:02 +0200 (CEST)
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
In-Reply-To: <df6b6311-ac67-857f-5a81-aee4eabd9f47@nokia.com>
Message-ID: <alpine.DEB.2.21.1906241135450.32342@nanos.tec.linutronix.de>
References: <20190605144116.28553-1-alexander.sverdlin@nokia.com> <20190605144116.28553-2-alexander.sverdlin@nokia.com> <alpine.DEB.2.21.1906231008170.32342@nanos.tec.linutronix.de> <df6b6311-ac67-857f-5a81-aee4eabd9f47@nokia.com>
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

On Mon, 24 Jun 2019, Sverdlin, Alexander (Nokia - DE/Ulm) wrote:
> On 23/06/2019 12:18, Thomas Gleixner wrote:
> > The alternative solution for this is what Vincenzo has in his unified VDSO
> > patch series:
> > 
> >   https://lkml.kernel.org/r/20190621095252.32307-1-vincenzo.frascino@arm.com
> > 
> > It leaves the data struct unmodified and has a separate array for the raw
> > clock. That does not have the side effects at all.
> > 
> > I'm in the process of merging that series and I actually adapted your
> > scheme to the new unified infrastructure where it has exactly the same
> > effects as with your original patches against the x86 version.
> 
> please let me know if I need to rework [2/2] based on some not-yet-published
> branch of yours.

I've pushed it out now to

     git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git timers/vdso

The generic VDSO library has the support for RAW already with that separate
array. Testing would be welcomed!

Feel free to experiment with moving mult/shift again. Maybe you find a way
to mitigate the effects and make it all magically faster. :)

Thanks,

	tglx
