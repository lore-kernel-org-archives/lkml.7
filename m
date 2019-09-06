Return-Path: <SRS0=GGWy=XB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BE907C43331
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Sep 2019 16:17:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 991AB21906
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Sep 2019 16:17:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alien8.de header.i=@alien8.de header.b="f2/tDhYJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730469AbfIFQRs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 6 Sep 2019 12:17:48 -0400
Received: from mail.skyhub.de ([5.9.137.197]:55568 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727805AbfIFQRr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Sep 2019 12:17:47 -0400
Received: from zn.tnic (p200300EC2F0B9E0090E54EFB2576D755.dip0.t-ipconnect.de [IPv6:2003:ec:2f0b:9e00:90e5:4efb:2576:d755])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id DC9731EC02FE;
        Fri,  6 Sep 2019 18:17:41 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1567786662;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=ML7AhYICUM+rkVSAqtRuyuzZIuUuSKwVdQWOYwnukpQ=;
        b=f2/tDhYJpGW1B2R1WMpnXM5eN/+fuxaJPcXGTgHFXs2ZQ2+tOrW9i5sYt857sqkY1yBePw
        vZu9+f2eYjLiBohLc4r8vYD+Zv13N3FRGz70XRJpnVjxKf7Kr222FkIF0ObxAxKW7/pseE
        WKqYiKh6fw5TqyzHY3zRwNOEWAX4EOY=
Date:   Fri, 6 Sep 2019 18:17:35 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Johannes Erdfelt <johannes@erdfelt.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        "Raj, Ashok" <ashok.raj@intel.com>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        Mihai Carabas <mihai.carabas@oracle.com>,
        "H. Peter Anvin" <hpa@zytor.com>, Ingo Molnar <mingo@redhat.com>,
        Jon Grimm <Jon.Grimm@amd.com>, kanth.ghatraju@oracle.com,
        konrad.wilk@oracle.com, patrick.colp@oracle.com,
        Tom Lendacky <thomas.lendacky@amd.com>,
        x86-ml <x86@kernel.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] x86/microcode: Add an option to reload microcode even if
 revision is unchanged
Message-ID: <20190906161735.GH19008@zn.tnic>
References: <D8A3D2BD-1FD4-4183-8663-3EF02A6099F3@alien8.de>
 <20190905002132.GA26568@otc-nc-03>
 <20190905072029.GB19246@zn.tnic>
 <20190905194044.GA3663@otc-nc-03>
 <alpine.DEB.2.21.1909052316130.1902@nanos.tec.linutronix.de>
 <20190905222706.GA4422@otc-nc-03>
 <alpine.DEB.2.21.1909061431330.1902@nanos.tec.linutronix.de>
 <20190906144039.GA29569@sventech.com>
 <20190906151617.GE19008@zn.tnic>
 <20190906154618.GB29569@sventech.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190906154618.GB29569@sventech.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 06, 2019 at 08:46:18AM -0700, Johannes Erdfelt wrote:
> That said, we very much rely on late microcode loading and it has helped
> us and our customers significantly.

You do realize that you rely on an update method which *won't* work in
all possible cases and then you *will* have to reboot if the microcode
patching *must* happen early, do you?

> It's really easy to say "fix your infrastructure" when you're not
> running that infrastructure.

I'm not saying you should fix your infrastructure now - I'm saying you
should keep that in mind when thinking whether to rely more on late
loading or not. Who knows, maybe newer generation machines in the fleet
could do load balancing, live migration, whatever fancy new cloud stuff
it is, to facilitate a proper reboot.

Or someone could rewrite arch/x86/ to rediscover new features upon a
microcode reload or a feature disabling. And do that in a clean way. Who
knows...

> Reboots suck. Customers hate it. Operations hates it. When you get into
> the number of hosts we have, you run into all kinds of weird failure
> scenarios. (What do you mean that the NIC that was working just fine
> before the reboot is no longer seen on the PCI bus?)

Yeah, I've heard all the stories.

> The more reboots we can avoid, the better it is for us and our
> customers.

So how do you update the kernels on those machines? Or you live-patch in
the new functionality too?

> I understand that it could be unsafe to late load some rare microcode
> updates (theoretical or not). However, that is certainly the exception.
> We have done this multiple times on our fleet and we plan to continue
> doing so in the future.

The fact that it has worked for you does not make it right. It won't
magically become safe, as tglx said.

But since you do custom development, you should be fine, it seems.

Practically speaking, late loading probably won't disappear as it is
being used apparently. Just don't expect that it will get "extended" if
that extension brings with itself fallout and duct tape fixes left and
right.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
