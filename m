Return-Path: <SRS0=bMiL=T7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2150FC28CC0
	for <linux-kernel@archiver.kernel.org>; Fri, 31 May 2019 02:15:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E7A02261E8
	for <linux-kernel@archiver.kernel.org>; Fri, 31 May 2019 02:15:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="i1iz3ubo"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726610AbfEaCPR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 May 2019 22:15:17 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:59782 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726509AbfEaCPQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 May 2019 22:15:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        Content-Type:In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:
        Subject:Sender:Reply-To:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=zCkx6eSXnZ5ux9ABK0SMiffXGoJkIH1FMytbxhPwmkU=; b=i1iz3ubo+pzo8/9rIiWcX2DwK
        C7MRIRw6XgI3dAcNwe6iJ3JFfyE5x5uwKayo5I7AM1n8rtegbdZlBxSXCl0lrHv/cpKaKe9WEb0er
        IMf1FiuMGHipO3As5n0TPYiqoU88k/e+NIkH0x1pzYRUsNeIqxgvBbLaeMG72gxmX7a1FTx/s8zuO
        OmRZn3sOamfVtTsE9aOQUM7wDeLfDKb85i0flHh/lLXvNpeuiCGUM61VUMXM9cl++Ic7meaXfYDGe
        kkRTbH9WfBxXoxcpqiStPA1NkNTBOqwQ1SfgrzjuX3PRTu76x9/FAi31tO7uUsIagsai5iPbdj7Cz
        9+FQKpOiQ==;
Received: from static-50-53-52-16.bvtn.or.frontiernet.net ([50.53.52.16] helo=midway.dunlab)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1hWX4e-0006u3-1T; Fri, 31 May 2019 02:15:16 +0000
Subject: Re: [PATCH] firmware_loader: fix build without sysctl
To:     Matteo Croce <mcroce@redhat.com>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Cc:     Luis Chamberlain <mcgrof@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org
References: <20190531012649.31797-1-mcroce@redhat.com>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <dbc00eaa-c6e9-45b2-7232-5af35fdea113@infradead.org>
Date:   Thu, 30 May 2019 19:15:15 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190531012649.31797-1-mcroce@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/30/19 6:26 PM, Matteo Croce wrote:
> firmware_config_table has references to the sysctl code which
> triggers a build failure when CONFIG_PROC_SYSCTL is not set:
> 
>     ld: drivers/base/firmware_loader/fallback_table.o:(.data+0x30): undefined reference to `sysctl_vals'
>     ld: drivers/base/firmware_loader/fallback_table.o:(.data+0x38): undefined reference to `sysctl_vals'
>     ld: drivers/base/firmware_loader/fallback_table.o:(.data+0x70): undefined reference to `sysctl_vals'
>     ld: drivers/base/firmware_loader/fallback_table.o:(.data+0x78): undefined reference to `sysctl_vals'
> 
> Put the firmware_config_table struct under #ifdef CONFIG_PROC_SYSCTL.
> 
> Fixes: 6a33853c5773 ("proc/sysctl: add shared variables for range check")
> Reported-by: Randy Dunlap <rdunlap@infradead.org>
> Signed-off-by: Matteo Croce <mcroce@redhat.com>

Works for me.

Acked-by: Randy Dunlap <rdunlap@infradead.org> # build-tested

Thanks.

> ---
>  drivers/base/firmware_loader/fallback_table.c | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/drivers/base/firmware_loader/fallback_table.c b/drivers/base/firmware_loader/fallback_table.c
> index 58d4a1263480..18d646777fb9 100644
> --- a/drivers/base/firmware_loader/fallback_table.c
> +++ b/drivers/base/firmware_loader/fallback_table.c
> @@ -23,6 +23,8 @@ struct firmware_fallback_config fw_fallback_config = {
>  };
>  EXPORT_SYMBOL_GPL(fw_fallback_config);
>  
> +#ifdef CONFIG_PROC_SYSCTL
> +
>  struct ctl_table firmware_config_table[] = {
>  	{
>  		.procname	= "force_sysfs_fallback",
> @@ -45,3 +47,5 @@ struct ctl_table firmware_config_table[] = {
>  	{ }
>  };
>  EXPORT_SYMBOL_GPL(firmware_config_table);
> +
> +#endif
> 


-- 
~Randy
