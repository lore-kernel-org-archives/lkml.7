Return-Path: <SRS0=GGWy=XB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 344A4C43331
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Sep 2019 15:16:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0C59620650
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Sep 2019 15:16:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alien8.de header.i=@alien8.de header.b="TyjZRjF9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389919AbfIFPQZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 6 Sep 2019 11:16:25 -0400
Received: from mail.skyhub.de ([5.9.137.197]:45194 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731375AbfIFPQY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Sep 2019 11:16:24 -0400
Received: from zn.tnic (p200300EC2F0B9E0090E54EFB2576D755.dip0.t-ipconnect.de [IPv6:2003:ec:2f0b:9e00:90e5:4efb:2576:d755])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 7B6161EC026F;
        Fri,  6 Sep 2019 17:16:23 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1567782983;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=xtqqJP9qgOBqusRl0nB2ylpdvT7PGPaJczjzdM0nC58=;
        b=TyjZRjF9IFxnR3mLOuVc73dRHgCkt9gn6f+hrix7Wf4Vv7Jpanf1by6D5bS8QezcDS8cZS
        kmN/qrwhiLlxazxvl7KAHMl/2g4sPkiv6S0ZYxEX3jUx5/rRIWJLi9drAgYOzU+3BxOl+U
        W91XaLuRZ6nfh6NKa/2ve90/8bcsVL0=
Date:   Fri, 6 Sep 2019 17:16:17 +0200
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
Message-ID: <20190906151617.GE19008@zn.tnic>
References: <20190903164630.GF11641@zn.tnic>
 <41cee473-321c-2758-032a-ccf0f01359dc@oracle.com>
 <D8A3D2BD-1FD4-4183-8663-3EF02A6099F3@alien8.de>
 <20190905002132.GA26568@otc-nc-03>
 <20190905072029.GB19246@zn.tnic>
 <20190905194044.GA3663@otc-nc-03>
 <alpine.DEB.2.21.1909052316130.1902@nanos.tec.linutronix.de>
 <20190905222706.GA4422@otc-nc-03>
 <alpine.DEB.2.21.1909061431330.1902@nanos.tec.linutronix.de>
 <20190906144039.GA29569@sventech.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190906144039.GA29569@sventech.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 06, 2019 at 07:40:39AM -0700, Johannes Erdfelt wrote:
> You say that switching of CPU feature bits is problematic, but adding
> new features should result only in a warning ("x86/CPU: CPU features
> have changed after loading microcode, but might not take effect.").

That's the only sane thing we can do ATM - warn the user to reboot.

> Removing a CPU feature bit could be problematic. Other than HLE being
> removed on Haswell (which the kernel shouldn't use anyway), have there
> been any other cases?

I hope there aren't. There are cases, however, where late loading cannot
fix an issue, like paging on some old Atoms. And then you *must* do
early loading or stick it in the BIOS. But we all know how the latter
works in practice.

> I ask because we have successfully used late microcode loading on tens
> of thousands of hosts.

How do you deal with all the mitigations microcode loaded late?

> I'm a bit worried to see that there is a push to remove a feature that
> we currently rely on.

I'd love to remove it. And the fact that people rely on it more instead
of fixing their infrastructure to reboot machines and do early microcode
updates is making it worse. Microcode update should be batched with
kernel updates and that's it. They happen normally once-twice per year -
except the last two years but the last two years are not normal anyway
- and done. No need to do some crazy CPUID features reloading dances in
the kernel and making sure cores will see the updated paths and so on.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
