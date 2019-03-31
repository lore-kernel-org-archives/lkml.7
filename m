Return-Path: <SRS0=KwB+=SC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 44A04C43381
	for <linux-kernel@archiver.kernel.org>; Sun, 31 Mar 2019 04:04:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0DB8021726
	for <linux-kernel@archiver.kernel.org>; Sun, 31 Mar 2019 04:04:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=flygoat.com header.i=@flygoat.com header.b="Q+TG51nn"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726033AbfCaEEJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 31 Mar 2019 00:04:09 -0400
Received: from forward101j.mail.yandex.net ([5.45.198.241]:41929 "EHLO
        forward101j.mail.yandex.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725773AbfCaEEJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 31 Mar 2019 00:04:09 -0400
Received: from mxback3g.mail.yandex.net (mxback3g.mail.yandex.net [IPv6:2a02:6b8:0:1472:2741:0:8b7:164])
        by forward101j.mail.yandex.net (Yandex) with ESMTP id 87D701BE0BB7;
        Sun, 31 Mar 2019 07:04:06 +0300 (MSK)
Received: from smtp1p.mail.yandex.net (smtp1p.mail.yandex.net [2a02:6b8:0:1472:2741:0:8b6:6])
        by mxback3g.mail.yandex.net (nwsmtp/Yandex) with ESMTP id U9es6GWzs9-46YWkvE9;
        Sun, 31 Mar 2019 07:04:06 +0300
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=flygoat.com; s=mail; t=1554005046;
        bh=rXfSe2c0jV3noKNJtUrkF8xDC0ypYc6N7Nk6a4uoKOU=;
        h=In-Reply-To:From:To:Subject:Cc:Date:References:Message-ID;
        b=Q+TG51nnGIzswbcSWQ2QSaj+D9ZWEnxM3hp/M1Oyo1f2zQzcCxGgVFuHkGMKU/d7N
         8yyI7mQDWId9RgrXyN3GNza5xeMXCC806UUVPx3b8XKEyVW+zvlMym/qxT85/19ZfQ
         L/L/YryMQFlKXaA6HAp/muUDizDZdAtjgAu1xY38=
Authentication-Results: mxback3g.mail.yandex.net; dkim=pass header.i=@flygoat.com
Received: by smtp1p.mail.yandex.net (nwsmtp/Yandex) with ESMTPSA id cZavlAg2Bi-41hmQepj;
        Sun, 31 Mar 2019 07:04:04 +0300
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (Client certificate not present)
Subject: Re: [PATCH v2] irqchip/irq-ls1x: Missing error code in
 ls1x_intc_of_init()
To:     Dan Carpenter <dan.carpenter@oracle.com>,
        Marc Zyngier <marc.zyngier@arm.com>
Cc:     Jason Cooper <jason@lakedaemon.net>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org,
        Mukesh Ojha <mojha@codeaurora.org>
References: <20190329062136.GQ32613@kadam>
From:   Jiaxun Yang <jiaxun.yang@flygoat.com>
Message-ID: <10aca36f-bb1c-0eae-76ab-e4d47632f02c@flygoat.com>
Date:   Sun, 31 Mar 2019 12:03:59 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.1
MIME-Version: 1.0
In-Reply-To: <20190329062136.GQ32613@kadam>
Content-Type: text/plain; charset=gbk; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Acked-by: Jiaxun Yang <jiaxun.yang@flygoat.com>

Thanks!

--

Jiaxun Yang

ÔÚ 2019/3/29 14:21, Dan Carpenter Ð´µÀ:
> Currently, when irq_domain_add_linear() fails, the error code does not
> get so it returns zero which is wrong.  Fix it by setting appropriate
> error code.
>
> Fixes: 9e543e22e204 ("irqchip: Add driver for Loongson-1 interrupt controller")
> Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
> Reviewed-by: Mukesh Ojha <mojha@codeaurora.org>
> ---
> V2: Improve the commit message
>
>   drivers/irqchip/irq-ls1x.c | 1 +
>   1 file changed, 1 insertion(+)
>
> diff --git a/drivers/irqchip/irq-ls1x.c b/drivers/irqchip/irq-ls1x.c
> index 86b72fbd3b45..353111a10413 100644
> --- a/drivers/irqchip/irq-ls1x.c
> +++ b/drivers/irqchip/irq-ls1x.c
> @@ -130,6 +130,7 @@ static int __init ls1x_intc_of_init(struct device_node *node,
>   					     NULL);
>   	if (!priv->domain) {
>   		pr_err("ls1x-irq: cannot add IRQ domain\n");
> +		err = -ENOMEM;
>   		goto out_iounmap;
>   	}
>   
