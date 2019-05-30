Return-Path: <SRS0=Dgga=T6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 09A62C46460
	for <linux-kernel@archiver.kernel.org>; Thu, 30 May 2019 14:21:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D549325A87
	for <linux-kernel@archiver.kernel.org>; Thu, 30 May 2019 14:21:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="Ep0dCWxj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726960AbfE3OVj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 May 2019 10:21:39 -0400
Received: from smtprelay-out1.synopsys.com ([198.182.61.142]:46746 "EHLO
        smtprelay-out1.synopsys.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726045AbfE3OVi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 May 2019 10:21:38 -0400
Received: from mailhost.synopsys.com (dc2-mailhost2.synopsys.com [10.12.135.162])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        by smtprelay-out1.synopsys.com (Postfix) with ESMTPS id AFE20C015A;
        Thu, 30 May 2019 14:21:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1559226080; bh=DY27FoYJr/ZVzjiCMtlyZWv20rpQnHng7lH0kaf5j28=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=Ep0dCWxjYCNNF/xvhaRDeOYxQs1R8sfukPkJIxxJa1+n6XbR6er5C3di5awqSiN+7
         /X8JGRRij1i8YhHU+GDO6VWqHu3MJF87Fl7iXNuMctlG8+qv6Zd+xAhaxsa9KtszSL
         nrdcnaaw+eOHbDJ1HoKW48i16zHe8lk4sQov8YwREcTvGTxWhEm6tbhb1UoTrzQ/Ja
         Jwx3t7cSRA9S6dUX8R7Bu+jvP+1CtBlfGVzfIgByH9tcNjs1u8IoC0Re3l2sCaMfAR
         s3wtkppNzGuvtujOJbzZT4d5JLsCX3NmQChcnuCpOVCVXFtKfXC4HcKVAVDCIf4XFz
         hsiBKXBPRSE0Q==
Received: from [10.116.70.206] (hminas-7480.internal.synopsys.com [10.116.70.206])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mailhost.synopsys.com (Postfix) with ESMTPSA id 37520A0093;
        Thu, 30 May 2019 14:21:35 +0000 (UTC)
Subject: Re: [PATCH] Revert "usb: dwc2: host: Setting qtd to NULL after
 freeing it"
To:     Guenter Roeck <linux@roeck-us.net>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        John Youn <John.Youn@synopsys.com>,
        Felipe Balbi <felipe.balbi@linux.intel.com>
References: <1559163283-2429-1-git-send-email-linux@roeck-us.net>
From:   Minas Harutyunyan <Minas.Harutyunyan@synopsys.com>
Message-ID: <1dcd53ee-7557-1974-1aea-33555e1fc67e@synopsys.com>
Date:   Thu, 30 May 2019 18:21:34 +0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <1559163283-2429-1-git-send-email-linux@roeck-us.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/30/2019 12:55 AM, Guenter Roeck wrote:
> This reverts commit b0d659022e5c96ee5c4bd62d22d3da2d66de306b.
> 
> The reverted commit does nothing but adding two unnecessary lines
> of code.  It sets a local variable to NULL in two functions, but
> that variable is not used anywhere in the rest of those functions.
> This is just confusing, so let's remove it.
> 
> Cc: Vardan Mikayelyan <mvardan@synopsys.com>
> Cc: John Youn <johnyoun@synopsys.com>
> Cc: Douglas Anderson <dianders@chromiun.org>
> Cc: Felipe Balbi <felipe.balbi@linux.intel.com>
> Signed-off-by: Guenter Roeck <linux@roeck-us.net>

Acked-by: Minas Harutyunyan <hminas@synopsys.com>


> ---
>   drivers/usb/dwc2/hcd.c | 1 -
>   drivers/usb/dwc2/hcd.h | 1 -
>   2 files changed, 2 deletions(-)
> 
> diff --git a/drivers/usb/dwc2/hcd.c b/drivers/usb/dwc2/hcd.c
> index b50ec3714fd8..bca64b0d4d15 100644
> --- a/drivers/usb/dwc2/hcd.c
> +++ b/drivers/usb/dwc2/hcd.c
> @@ -4676,7 +4676,6 @@ static int _dwc2_hcd_urb_enqueue(struct usb_hcd *hcd, struct urb *urb,
>   	spin_unlock_irqrestore(&hsotg->lock, flags);
>   	urb->hcpriv = NULL;
>   	kfree(qtd);
> -	qtd = NULL;
>   fail1:
>   	if (qh_allocated) {
>   		struct dwc2_qtd *qtd2, *qtd2_tmp;
> diff --git a/drivers/usb/dwc2/hcd.h b/drivers/usb/dwc2/hcd.h
> index c089ffa1f0a8..f6bc48432b04 100644
> --- a/drivers/usb/dwc2/hcd.h
> +++ b/drivers/usb/dwc2/hcd.h
> @@ -574,7 +574,6 @@ static inline void dwc2_hcd_qtd_unlink_and_free(struct dwc2_hsotg *hsotg,
>   {
>   	list_del(&qtd->qtd_list_entry);
>   	kfree(qtd);
> -	qtd = NULL;
>   }
>   
>   /* Descriptor DMA support functions */
> 

