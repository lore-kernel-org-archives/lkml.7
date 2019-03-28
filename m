Return-Path: <SRS0=Qu8K=R7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 50E57C10F03
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Mar 2019 14:42:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1CBEF217F9
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Mar 2019 14:42:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="hUSldJAm";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="X6+tZn3I"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726394AbfC1Omc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Mar 2019 10:42:32 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:42952 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725849AbfC1Omc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Mar 2019 10:42:32 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id C2D196081E; Thu, 28 Mar 2019 14:42:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1553784151;
        bh=MxIzjwF0zOz4CrvFXQXsuTAFud6du+puEKPPnimGtEE=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=hUSldJAm+caPOwVz/e4DnIinWKRNr0Jc7goIofi8A9aXHO8es7i9ByCBzeDJqlB4g
         ENWu+cMYDcQ44TyLVdzWP7LBbariSYh8lVZhBynEbiRUDreuYXRyeLIYd8KrAH623E
         JWXahtRukFUtU80dL21YrtLL/KnErrBWfT+Wp1NQ=
Received: from [10.204.79.83] (blr-c-bdr-fw-01_globalnat_allzones-outside.qualcomm.com [103.229.19.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: mojha@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id D9DBA602FC;
        Thu, 28 Mar 2019 14:42:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1553784143;
        bh=MxIzjwF0zOz4CrvFXQXsuTAFud6du+puEKPPnimGtEE=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=X6+tZn3II3keTGwjC3KnD7WL8IMu8WVoTnSWzlIlJu8WdQq7n3ak037ccqpbd+hFZ
         TNInhpAAJ4VGT27YbubS/n6YgDHK9V7mnOG9xT5spxVXG/Fjwsmw560uGTwp8QlV59
         Paid2d7SUN2TeuWTc2ObGpwxIarv29il6ipmUoOI=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org D9DBA602FC
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=mojha@codeaurora.org
Subject: Re: [PATCH] MIPS: SGI-IP27: Fix use of unchecked pointer in
 shutdown_bridge_irq
To:     Thomas Bogendoerfer <tbogendoerfer@suse.de>,
        Ralf Baechle <ralf@linux-mips.org>,
        Paul Burton <paul.burton@mips.com>,
        James Hogan <jhogan@kernel.org>, linux-mips@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Dan Carpenter <dan.carpenter@oracle.com>
References: <20190328133745.26506-1-tbogendoerfer@suse.de>
From:   Mukesh Ojha <mojha@codeaurora.org>
Message-ID: <1050e38e-c6e5-167e-fdf1-c60a3928ea72@codeaurora.org>
Date:   Thu, 28 Mar 2019 20:12:16 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190328133745.26506-1-tbogendoerfer@suse.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 3/28/2019 7:07 PM, Thomas Bogendoerfer wrote:
> smatch complaint:
>
>      arch/mips/sgi-ip27/ip27-irq.c:123 shutdown_bridge_irq()
>      warn: variable dereferenced before check 'hd' (see line 121)
>
> Fix it by removing local variable and use hd->pin directly.
>
> Fixes: 69a07a41d908 ("MIPS: SGI-IP27: rework HUB interrupts")
> Reported-by: Dan Carpenter <dan.carpenter@oracle.com>
> Signed-off-by: Thomas Bogendoerfer <tbogendoerfer@suse.de>


Reviewed-by: Mukesh Ojha <mojha@codeaurora.org>

-Mukesh

> ---
>   arch/mips/sgi-ip27/ip27-irq.c | 3 +--
>   1 file changed, 1 insertion(+), 2 deletions(-)
>
> diff --git a/arch/mips/sgi-ip27/ip27-irq.c b/arch/mips/sgi-ip27/ip27-irq.c
> index 710a59764b01..a32f843cdbe0 100644
> --- a/arch/mips/sgi-ip27/ip27-irq.c
> +++ b/arch/mips/sgi-ip27/ip27-irq.c
> @@ -118,7 +118,6 @@ static void shutdown_bridge_irq(struct irq_data *d)
>   {
>   	struct hub_irq_data *hd = irq_data_get_irq_chip_data(d);
>   	struct bridge_controller *bc;
> -	int pin = hd->pin;
>   
>   	if (!hd)
>   		return;
> @@ -126,7 +125,7 @@ static void shutdown_bridge_irq(struct irq_data *d)
>   	disable_hub_irq(d);
>   
>   	bc = hd->bc;
> -	bridge_clr(bc, b_int_enable, (1 << pin));
> +	bridge_clr(bc, b_int_enable, (1 << hd->pin));
>   	bridge_read(bc, b_wid_tflush);
>   }
>   
