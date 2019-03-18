Return-Path: <SRS0=xYIU=RV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 463E1C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Mar 2019 16:52:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1AA8720863
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Mar 2019 16:52:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="mLxXSrXQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727481AbfCRQwj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Mar 2019 12:52:39 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:44646 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726808AbfCRQwi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Mar 2019 12:52:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        Content-Type:In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:
        Subject:Sender:Reply-To:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=kIa5uHf+mmh6TW7PHc1mcPDhci+SVQrfxyM8ZvWJXF0=; b=mLxXSrXQacsOh28lImZVF2+5b
        0jWCAsnO43xVzAJKl4enyV2ivrzzO+SOfHveNbPh6S6N4tUKk0um8n917Q0HV18HchE1Bk0D0DzLd
        jV52Y8sRMdSwQLyaTqPlVhl3bkLKL8wxVRAGDq/PVX6us/CE9BMfE+6mROGQa4f/4FlY3zvk6o74V
        fpoM/Gx9jFL3p5fF3nb3fCafjWjFPMtyZKfyAxdLgOcJ/Pbonc1CZEYBX29PuLe/QkcTAWTFUtmki
        81D4zUp7D6Ns9TrZIb9I0Tyb7j59Wg0NmuiOemmkDrK8FKCy2mBPDPxt0+TLUHDRUetLDMecaRZ02
        SRYfb64Qw==;
Received: from static-50-53-52-16.bvtn.or.frontiernet.net ([50.53.52.16] helo=midway.dunlab)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1h5vV8-0006VY-Ap; Mon, 18 Mar 2019 16:52:38 +0000
Subject: Re: [PATCH] Add code to support USBIP Project for Windows
To:     VizXu <xujiweigo@163.com>, valentina.manea.m@gmail.com
Cc:     shuah@kernel.org, gregkh@linuxfoundation.org,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
References: <1552927048-15857-1-git-send-email-xujiweigo@163.com>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <bc5c3cdb-2fa8-ba99-5bc8-31a367c1e040@infradead.org>
Date:   Mon, 18 Mar 2019 09:52:34 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.1
MIME-Version: 1.0
In-Reply-To: <1552927048-15857-1-git-send-email-xujiweigo@163.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/18/19 9:37 AM, VizXu wrote:
> Signed-off-by: VizXu <xujiweigo@163.com>
> ---
>  drivers/usb/usbip/stub_dev.c     |  4 ++++
>  drivers/usb/usbip/stub_rx.c      | 37 +++++++++++++++++++++++++++++++++++++
>  drivers/usb/usbip/usbip_common.h | 16 ++++++++++++++++
>  3 files changed, 57 insertions(+)
> 

> diff --git a/drivers/usb/usbip/usbip_common.h b/drivers/usb/usbip/usbip_common.h
> index bf8afe9..b5189e6 100644
> --- a/drivers/usb/usbip/usbip_common.h
> +++ b/drivers/usb/usbip/usbip_common.h
> @@ -122,6 +122,17 @@ extern struct device_attribute dev_attr_usbip_debug;
>  #define USBIP_DIR_IN	0x01
>  
>  /**

This comment block is not kernel-doc notation so it should not begin
with /**.

> +* Support USBIP project for Windows: http://usbip.sourceforge.net/
> +*	The configuration is not initialized after an USB device bound in Linux
> +* 	and that would make Linux kernel crash if usbip.exe attach it.
> +*	I've analysized this process with wireshark and found that usbip.exe

	     analyzed

> +*	would not "SET CONFIGURATION Request". I suppose the process of loading
> +*	a USB device is different between Linux and Windows.
> +*	Make a usb_set_configuration at the first time would fix this issue.
> +*/
> +#define SUPPORT_WIN
> +
> +/**
>   * struct usbip_header_basic - data pertinent to every request
>   * @command: the usbip request type
>   * @seqnum: sequential number that identifies requests; incremented per
> @@ -257,6 +268,11 @@ struct usbip_device {
>  	spinlock_t lock;
>  
>  	int sockfd;
> +
> +#ifdef SUPPORT_WIN
> +	bool is_configured;
> +#endif
> +
>  	struct socket *tcp_socket;
>  
>  	struct task_struct *tcp_rx;
> 


-- 
~Randy
