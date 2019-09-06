Return-Path: <SRS0=GGWy=XB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E6B92C43331
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Sep 2019 17:10:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 01DE520693
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Sep 2019 17:10:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alien8.de header.i=@alien8.de header.b="S+tNW9LH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391025AbfIFRKW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 6 Sep 2019 13:10:22 -0400
Received: from mail.skyhub.de ([5.9.137.197]:34846 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732683AbfIFRKV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Sep 2019 13:10:21 -0400
Received: from zn.tnic (p200300EC2F0B9E0090E54EFB2576D755.dip0.t-ipconnect.de [IPv6:2003:ec:2f0b:9e00:90e5:4efb:2576:d755])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id A5BDF1EC0528;
        Fri,  6 Sep 2019 19:10:20 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1567789820;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=ujq/9wwVKbYtmT1d+l0p4TYSlaAZEGl0EoXsFpFQqYM=;
        b=S+tNW9LHWpv9f+hX8imI5dbvKLO/tx1sEQsEeej/9vtDM6OzS2tGH7Ap8p5UZcNPV3J0aS
        GJsmjdBBBv/caVvbRmLP8i2XDhaG6YOWUU91n7pAjhlX3Pek66+FJKpW9I3gm7vgw5UNSc
        G/C9gQSmCJ2twqnCueYan/nG/+7bNzU=
Date:   Fri, 6 Sep 2019 19:10:12 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
Cc:     Johannes Erdfelt <johannes@erdfelt.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        "Raj, Ashok" <ashok.raj@intel.com>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        Mihai Carabas <mihai.carabas@oracle.com>,
        "H. Peter Anvin" <hpa@zytor.com>, Ingo Molnar <mingo@redhat.com>,
        Jon Grimm <Jon.Grimm@amd.com>, kanth.ghatraju@oracle.com,
        patrick.colp@oracle.com, Tom Lendacky <thomas.lendacky@amd.com>,
        x86-ml <x86@kernel.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] x86/microcode: Add an option to reload microcode even if
 revision is unchanged
Message-ID: <20190906171012.GK19008@zn.tnic>
References: <20190905072029.GB19246@zn.tnic>
 <20190905194044.GA3663@otc-nc-03>
 <alpine.DEB.2.21.1909052316130.1902@nanos.tec.linutronix.de>
 <20190905222706.GA4422@otc-nc-03>
 <alpine.DEB.2.21.1909061431330.1902@nanos.tec.linutronix.de>
 <20190906144039.GA29569@sventech.com>
 <20190906151617.GE19008@zn.tnic>
 <20190906154618.GB29569@sventech.com>
 <20190906161735.GH19008@zn.tnic>
 <20190906164353.GB2840@char.us.oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190906164353.GB2840@char.us.oracle.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 06, 2019 at 12:43:53PM -0400, Konrad Rzeszutek Wilk wrote:
> Do you have insights on the best way to restructure the code for this?

Well, I only started thinking about this when you guys brought it on and
you were actually serious about it. :)

So IINM, this is one of the livepatch problems where the universe before
the patching and after the patching needs to be consistent, so to speak.

But how do you handle the case where feature detection has happened, a
bunch of code is active now and running because the feature is there and
then you disable that feature and all that code does what? And what do
you tell the user programs which are using it?

Sounds a lot like a reboot to me. :-P

Was the code programmed with the ability to be gracefully disabled at
any point in time, in mind? I doubt that. I don't think any of the CPU
feature supporting code has been programmed to be disabled at arbitrary
points in time.

Now, can you do something like suspend the CPUs, disable some
features and resume them and make them re-detect it all again and act
accordingly?

Sure, we do some of that but not comprehensively...

So my gut feeling is this is just the tip of the iceberg and the devil
is in the detail and all sorts of similar proverbs.

Best guess would be, try to do it and see what kinds of problems you
encounter and try to fix them cleanly. I betcha you'll be busy a long
time...

:-)

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
