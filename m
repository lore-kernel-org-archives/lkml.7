Return-Path: <SRS0=7jSw=YF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A2350C4360C
	for <linux-kernel@archiver.kernel.org>; Sat, 12 Oct 2019 15:36:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 70464206A1
	for <linux-kernel@archiver.kernel.org>; Sat, 12 Oct 2019 15:36:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1570894576;
	bh=wOO9dT/+1DpyPCBDo9cRL6tqlwKchXOKgpUHSlZujCY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=SVLEHaZ+qic8m0pL8FKo68EBzr8y3Huaf3DxfoIHGQ7DIlhOrm57WMa1OUl8uS9zm
	 6zONobCSRK6v1twixHRALwoMKVR/UFo9Hly0LmPN9HMDhBsYJDQBcbaZJf6flGT2X9
	 jmzgU+za4s/35lj/X06WYMHey3Z7ZGXKMDrOPQBw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729406AbfJLPdB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 12 Oct 2019 11:33:01 -0400
Received: from mail.kernel.org ([198.145.29.99]:42776 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727642AbfJLPdA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 12 Oct 2019 11:33:00 -0400
Received: from localhost (unknown [62.119.166.9])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C90E22087E;
        Sat, 12 Oct 2019 15:32:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1570894380;
        bh=wOO9dT/+1DpyPCBDo9cRL6tqlwKchXOKgpUHSlZujCY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=USFRwIu0nUIYtJeUjApTVxq620Mc3myFOIARiUXmGVUFFwfzjAhEfBKx6ol9kiOkH
         HpvxbKNJCoJt2Vxllw3RTlylLbniCaSuChNSRP3dMfR5Ajadlxhuz9q/e1K1SFXSUu
         +PRDXslnhfQnQrmj3Lk6W2mOATdG5AJRtZlLlPbs=
Date:   Sat, 12 Oct 2019 17:32:45 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     zhong jiang <zhongjiang@huawei.com>
Cc:     Jerome.Pouiller@silabs.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] staging: wfx: fix an undefined reference error when
 CONFIG_MMC=m
Message-ID: <20191012153245.GA2155778@kroah.com>
References: <1570877693-52711-1-git-send-email-zhongjiang@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1570877693-52711-1-git-send-email-zhongjiang@huawei.com>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Oct 12, 2019 at 06:54:53PM +0800, zhong jiang wrote:
> I hit the following error when compile the kernel.
> 
> drivers/staging/wfx/main.o: In function `wfx_core_init':
> /home/z00352263/linux-next/linux-next/drivers/staging/wfx/main.c:488: undefined reference to `sdio_register_driver'
> drivers/staging/wfx/main.o: In function `wfx_core_exit':
> /home/z00352263/linux-next/linux-next/drivers/staging/wfx/main.c:496: undefined reference to `sdio_unregister_driver'
> drivers/staging/wfx/main.o:(.debug_addr+0x1a8): undefined reference to `sdio_register_driver'
> drivers/staging/wfx/main.o:(.debug_addr+0x6f0): undefined reference to `sdio_unregister_driver'
> 
> Signed-off-by: zhong jiang <zhongjiang@huawei.com>
> ---
> v2->v3:
>     We'd better not use #ifdef in .c file to use IS_ENABLED instead.
> 
> v1->v2:
>     We should prefer to current dependencies rather than force to enable. 
> 
>  drivers/staging/wfx/Makefile | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/staging/wfx/Makefile b/drivers/staging/wfx/Makefile
> index 0d9c1ed..77d68b7 100644
> --- a/drivers/staging/wfx/Makefile
> +++ b/drivers/staging/wfx/Makefile
> @@ -19,6 +19,6 @@ wfx-y := \
>  	sta.o \
>  	debug.o
>  wfx-$(CONFIG_SPI) += bus_spi.o
> -wfx-$(subst m,y,$(CONFIG_MMC)) += bus_sdio.o
> +wfx-$(CONFIG_MMC) += bus_sdio.o
>  
>  obj-$(CONFIG_WFX) += wfx.o

How does this change any of the existing logic?  What does this really
change to solve the issue?  I thought you were going to fix this up as I
suggested in my last email?

thanks,

greg k-h
