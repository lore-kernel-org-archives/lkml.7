Return-Path: <SRS0=hO5d=UX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5369C43613
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Jun 2019 11:47:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 99EF820820
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Jun 2019 11:47:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1561376868;
	bh=EHCIrE5dWZz7UIHv3Mt0UGdPFK98b1UEAL4km+gAnRM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=Yc0IzxHd/8UFD85odbI4EGNdzH4ai3qzWalwlkBg/7WOF75TRCuGirSqIHt7o0Eqx
	 cro7ein5VD2TnCNf4ZZfLiDXUzpDwORaH+LrTWJHKDF8TgIAjSh6OJ3NBZj8NAwUxM
	 7ZKThM5uMd0lXOrrW+BEE2UvUHIoUOxieTmiySR8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729825AbfFXLrr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Jun 2019 07:47:47 -0400
Received: from mail.kernel.org ([198.145.29.99]:59654 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726334AbfFXLrr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jun 2019 07:47:47 -0400
Received: from willie-the-truck (236.31.169.217.in-addr.arpa [217.169.31.236])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 17BFF20674;
        Mon, 24 Jun 2019 11:47:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1561376866;
        bh=EHCIrE5dWZz7UIHv3Mt0UGdPFK98b1UEAL4km+gAnRM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=JpzEg3oNYpbs1copvvpNgzJoG/DGjPL1JheCElUYYb3Kyfn6ZY3vMNpnIO7zdr5bM
         YstNnwaddGcQvaxeMAMks8QR4gCvCw/200+rSeXlQ6FfEQpvgEqbY/D8jDmA2ARNd2
         NOMmlmCjjxArVHgQKI7rGxrmQ7BczUbloPCy59gQ=
Date:   Mon, 24 Jun 2019 12:47:41 +0100
From:   Will Deacon <will@kernel.org>
To:     Vicente Bergas <vicencb@gmail.com>
Cc:     Al Viro <viro@zeniv.linux.org.uk>, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>
Subject: Re: d_lookup: Unable to handle kernel paging request
Message-ID: <20190624114741.i542cb3wbhfbk4q4@willie-the-truck>
References: <20190522135331.GM17978@ZenIV.linux.org.uk>
 <bdc8b245-afca-4662-99e2-a082f25fc927@gmail.com>
 <20190522162945.GN17978@ZenIV.linux.org.uk>
 <10192e43-c21d-44e4-915d-bf77a50c22c4@gmail.com>
 <20190618183548.GB17978@ZenIV.linux.org.uk>
 <bf2b3aa6-bda1-43f1-9a01-e4ad3df81c0b@gmail.com>
 <20190619162802.GF17978@ZenIV.linux.org.uk>
 <bc774f6b-711e-4a20-ad85-c282f9761392@gmail.com>
 <20190619170940.GG17978@ZenIV.linux.org.uk>
 <cd84de0e-909e-4117-a20a-6cde42079267@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cd84de0e-909e-4117-a20a-6cde42079267@gmail.com>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jun 22, 2019 at 08:02:19PM +0200, Vicente Bergas wrote:
> Hi Al,
> i think have a hint of what is going on.
> With the last kernel built with your sentinels at hlist_bl_*lock
> it is very easy to reproduce the issue.
> In fact it is so unstable that i had to connect a serial port
> in order to save the kernel trace.
> Unfortunately all the traces are at different addresses and
> your sentinel did not trigger.
> 
> Now i am writing this email from that same buggy kernel, which is
> v5.2-rc5-224-gbed3c0d84e7e.
> 
> The difference is that I changed the bootloader.
> Before was booting 5.1.12 and kexec into this one.
> Now booting from u-boot into this one.
> I will continue booting with u-boot for some time to be sure it is
> stable and confirm this is the cause.
> 
> In case it is, who is the most probable offender?
> the kernel before kexec or the kernel after?

Has kexec ever worked reliably on this board? If you used to kexec
successfully, then we can try to hunt down the regression using memtest.
If you kexec into a problematic kernel with CONFIG_MEMTEST=y and pass
"memtest=17" on the command-line, it will hopefully reveal any active
memory corruption.

My first thought is that there is ongoing DMA which corrupts the dentry
hash. The rk3399 SoC also has an IOMMU, which could contribute to the fun
if it's not shutdown correctly (i.e. if it enters bypass mode).

> The original report was sent to you because you appeared as the maintainer
> of fs/dcache.c, which appeared on the trace. Should this be redirected
> somewhere else now?

linux-arm-kernel@lists.infradead.org

Probably worth adding Heiko Stuebner <heiko@sntech.de> to cc.

Will
