Return-Path: <SRS0=uyI7=RK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1AFD1C43381
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Mar 2019 07:03:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D6F25204FD
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Mar 2019 07:03:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="GAcbn1VN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726441AbfCGHDk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 Mar 2019 02:03:40 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:55912 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726015AbfCGHDk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Mar 2019 02:03:40 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=2c7hHy3T2/5/U+27qiO8O6Q8deKGP/F9LM0AP4sc/CY=; b=GAcbn1VNUkKM1ozuGq5GECPAD
        o/X80OQejAaNzBiHymljcR8HlI16xkOPXFGl+bwUMft8D/RbpaqGJC4RZjo0U6MmtJYqH3AF9LhO3
        tvIbGuZlTNDVAIqtga2TVUG5hFTFUIHOFYR26cU7pFqQEnrZfxcrbMRYt13sxZ3NOxF/yt7QURLZI
        rVwYU6YkY3I+ZHiACX1jLs/sx/4xsf92m1CSK0NfIVNv064Y9xO5LaicYI4rDKh4OSTQhMpmgnuuF
        bU8WNbKhovEVxFhPSpFwkwrYXlmzfzEIIA228SXbU7Re0dB7SBOr5ZEPxI67KNpp+gq2AwnrBKmXF
        wAjQRTDZQ==;
Received: from dvhart by bombadil.infradead.org with local (Exim 4.90_1 #2 (Red Hat Linux))
        id 1h1n46-0004DI-AQ; Thu, 07 Mar 2019 07:03:38 +0000
Date:   Wed, 6 Mar 2019 23:03:36 -0800
From:   Darren Hart <dvhart@infradead.org>
To:     "Enrico Weigelt, metux IT consult" <lkml@metux.net>
Cc:     Andy Shevchenko <andy.shevchenko@gmail.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Andy Shevchenko <andy@infradead.org>,
        Linus Walleij <linusw@kernel.org>,
        Enrico Weigelt <info@metux.net>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        Platform Driver <platform-driver-x86@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        linux-kbuild@vger.kernel.org
Subject: Re: [PATCH 2/3] x86: apuv2: fix input dependencies
Message-ID: <20190307070336.GI44339@wrath>
References: <20190304201930.1622839-1-arnd@arndb.de>
 <20190304201930.1622839-2-arnd@arndb.de>
 <a94c3c6a-481e-96a5-74e1-8c3299c74129@metux.net>
 <CAK8P3a0vdhCTNTF-K0mXjRWkPvv0qr3nf_52=8n6zTa7p3ELLw@mail.gmail.com>
 <54a7d035-155f-c47b-1db1-acb851b3aec6@metux.net>
 <CAHp75Vcd0eNCBtxb1huMBGFF9JXmropHv2YA1eh-yK3iMFfuFQ@mail.gmail.com>
 <82c978b2-e9c4-e178-e4b7-621729c2cee4@metux.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <82c978b2-e9c4-e178-e4b7-621729c2cee4@metux.net>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 07, 2019 at 01:10:13AM +0100, Enrico Weigelt, metux IT consult wrote:
> On 05.03.19 14:56, Andy Shevchenko wrote:
> > 
> > Darren gave a talk about merging kernel configs to get something like
> > you want to.
> > This tool is quite long already lying around. merge_config.sh in your
> > kernel source tree.
> 
> Yes, that's similar to how some distros (eg. yocto) do it.
> 

I wrote merge_config.sh to replace and simplify some of the yocto
tooling. With merge_config upstream, Yocto now uses it directly.

> But my requirements are a bit more complex:
> 
> In my final meta-config, I just wanna say:
> 
> * i have board A (possibly multiple boards)
> * i need features X, Y, Z (eg. eth, display, can, ext4, acl, ...)
> 
> And that shall be all to generate a minimal config for exactly those
> requirements.

That's also the goal of the Yocto configuration fragments, and is
possible with merge_config with a set of defined fragments.

> 
> Doing that by just putting config snippets together, quickly turns into
> a maintenance hell. At least you'd need recursive dependencies and some
> if/else logic.
> 
> That's why I've written kmct:
> 
> https://github.com/metux/kmct

I had a look, the README could benefit from a basic usage example.
Digging through it further, it appears that you are creating yaml files
which contain CONFIGs. The problem with this in my opinion is these are
kernel version specific, so you know have a lot of boiler plate yaml
wrapping kernel version specific CONFIG options which will slowly get
out of sync over time. This is the usual argument for keeping config
fragments together with the kernel - and why we do that in arch/*/config
for example.

Perhaps I'm missing your desired workflow though. I tend to find the
options I need and record them in a fragment, and save it off for later
to quickly be able to "make defconfig fragA.config fragB.config" etc. Is
what you're trying to do different?

-- 
Darren Hart
VMware Open Source Technology Center
