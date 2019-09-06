Return-Path: <SRS0=GGWy=XB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6A733C43331
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Sep 2019 17:17:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3CF1A208C3
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Sep 2019 17:17:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alien8.de header.i=@alien8.de header.b="Sq1EshMb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406011AbfIFRRY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 6 Sep 2019 13:17:24 -0400
Received: from mail.skyhub.de ([5.9.137.197]:35874 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1733278AbfIFRRX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Sep 2019 13:17:23 -0400
Received: from zn.tnic (p200300EC2F0B9E00A12ADCB2AAAA451F.dip0.t-ipconnect.de [IPv6:2003:ec:2f0b:9e00:a12a:dcb2:aaaa:451f])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 07C531EC094F;
        Fri,  6 Sep 2019 19:17:22 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1567790242;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=DrItdgOwfueRiUWCUUuY7oRWF0Gci3i+6hFy85DBwzA=;
        b=Sq1EshMbCOXHbkKUAcE9HSUjqyLIuuEALX45VjE7MGs3qQ2P+ze6xON+60wK/hAJ0DD4rd
        msj/qiZfkMs/biLhpYBp0eV/RVgBZb1t1KKDUUMcOrk0QrUAEk8imGAIzz6oTqYT3H/+yb
        2UVgFwQw2LR20KzNdO4XGfJGj8AbnFM=
Date:   Fri, 6 Sep 2019 19:17:20 +0200
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
Message-ID: <20190906171720.GM19008@zn.tnic>
References: <20190905072029.GB19246@zn.tnic>
 <20190905194044.GA3663@otc-nc-03>
 <alpine.DEB.2.21.1909052316130.1902@nanos.tec.linutronix.de>
 <20190905222706.GA4422@otc-nc-03>
 <alpine.DEB.2.21.1909061431330.1902@nanos.tec.linutronix.de>
 <20190906144039.GA29569@sventech.com>
 <20190906151617.GE19008@zn.tnic>
 <20190906154618.GB29569@sventech.com>
 <20190906161735.GH19008@zn.tnic>
 <20190906165207.GC29569@sventech.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190906165207.GC29569@sventech.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 06, 2019 at 09:52:07AM -0700, Johannes Erdfelt wrote:
> That doesn't mean that late loading isn't still useful.

If it weren't useful, it would've been gone a long time ago. No one is
arguing whether it is useful or not.

> Just as I can't know for sure that every future microcode update will be
> safely late loadable, you can't know for sure that every future microcode
> update won't be safely late loadable.

Well, you know what can happen so good luck, I guess.

> We do use other techniques as well particularly when it's not time
> sensitive.

So you reboot or not? Do you do reboot-similar techniques where you can
potentially do early microcode loading too?

> It very much makes it right because it's still a tool that can be used
> safely in the right cases. Just because it can't be used 100% of the time
> (even if it is close to that in practice) doesn't make it magically unsafe
> either.

As I said, good luck with that. It's not like you haven't been warned
about what can happen.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
