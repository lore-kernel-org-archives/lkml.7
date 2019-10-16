Return-Path: <SRS0=S2At=YJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F546FA3728
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Oct 2019 14:19:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E7E0C218DE
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Oct 2019 14:19:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kmVGKFBV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2393920AbfJPOTl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 16 Oct 2019 10:19:41 -0400
Received: from mail-ot1-f66.google.com ([209.85.210.66]:39791 "EHLO
        mail-ot1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730937AbfJPOTl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Oct 2019 10:19:41 -0400
Received: by mail-ot1-f66.google.com with SMTP id s22so20278666otr.6
        for <linux-kernel@vger.kernel.org>; Wed, 16 Oct 2019 07:19:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:reply-to:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=oRCJA7Fo6qKgPkycGt7GDX3KsXKekLnt+bCZAb1lUvQ=;
        b=kmVGKFBVSltBLVc5IdxfR70Sn9KD+16oQYLZrmvIB3fFsxTG878Z9MXJHt/QkP+cBq
         u4NmLTBDMgJi0dqbv0HCu6F0VDZnayXCP9Y2lXENq0zImZQQXGsFTky4BIO359avKJGm
         /tIVJbLgv4fJW7jBAxYakqwUHVE3nDQCN7P2HLBxNXasgP/+fhHV9DE3oID4FyzKbiis
         rce8MS/NxTZsem3AdWsoHE7i5g3SiucIaMahTWiQhnNgeXs/rp613JzaoYgzdp0QPB2r
         SlVY6MohzNoTmohNZf8e/S/4DRLNHdEcj3h6dvlFQX2+8XO1LYDBSefU9NB5DzwoPXIL
         fD9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :reply-to:references:mime-version:content-disposition:in-reply-to
         :user-agent;
        bh=oRCJA7Fo6qKgPkycGt7GDX3KsXKekLnt+bCZAb1lUvQ=;
        b=srZ+HAElgyEIGtaY0a54Yu/EnsPae+QKtSnxBjhkpwK0ttic06esiCkn8HL4n7kP2I
         7MhzyUTTMJst/PDELUDY+heA2XjUOi7k+mrp2F+V8XI4VXdHt3spesnZ4lDtWa0Ac7p2
         bNtn8mHPq4CZ++9imUu6MzyEoaUqnGrLiqZ4JvbkbX8cN7EEtqVSo8fmPaxXPNYKQ7VD
         f4A21M74e08xPItXtLY++85j3Wg7G0OPWazC9QLDwIt+lQbivgzm6S0omOh+TokHELAO
         /pH8XbaUKcs8Y92t4A5BKfS4TWrCt4TBzvtoaQ4iymNq6MKvdAxLsN+md2cEZO44jaaD
         Q7iw==
X-Gm-Message-State: APjAAAWWOWbibcmMgJ/x9tZlRjR59WLdiwiPRdLGeWG0LAFlEHH7G6Z7
        WJ+myEuPapMwqJCxjL3jlQ==
X-Google-Smtp-Source: APXvYqzsMQ8sg5gTyK6Tys4TFflwQcD2kmByJ78d7v7u2pMPuFKF96PL0pWTxDbBatC8ov4NW2yxPw==
X-Received: by 2002:a9d:30c1:: with SMTP id r1mr1816638otg.91.1571235578921;
        Wed, 16 Oct 2019 07:19:38 -0700 (PDT)
Received: from serve.minyard.net ([47.184.136.59])
        by smtp.gmail.com with ESMTPSA id 91sm7752566otn.36.2019.10.16.07.19.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Oct 2019 07:19:38 -0700 (PDT)
Received: from t560 (unknown [192.168.27.180])
        by serve.minyard.net (Postfix) with ESMTPSA id 6C59D180056;
        Wed, 16 Oct 2019 14:19:37 +0000 (UTC)
Date:   Wed, 16 Oct 2019 09:19:36 -0500
From:   Corey Minyard <minyard@acm.org>
To:     YueHaibing <yuehaibing@huawei.com>
Cc:     arnd@arndb.de, gregkh@linuxfoundation.org,
        openipmi-developer@lists.sourceforge.net,
        linux-kernel@vger.kernel.org,
        Alistair Popple <alistair@popple.id.au>,
        =?utf-8?Q?C=C3=A9dric?= Le Goater <clg@kaod.org>
Subject: Re: [PATCH -next] ipmi: bt-bmc: use devm_platform_ioremap_resource()
 to simplify code
Message-ID: <20191016141936.GN14232@t560>
Reply-To: minyard@acm.org
References: <20191016092131.23096-1-yuehaibing@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191016092131.23096-1-yuehaibing@huawei.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 16, 2019 at 05:21:31PM +0800, YueHaibing wrote:
> Use devm_platform_ioremap_resource() to simplify the code a bit.
> This is detected by coccinelle.

Adding the module author and others. I can't see a reason to not do
this.

-corey

> 
> Signed-off-by: YueHaibing <yuehaibing@huawei.com>
> ---
>  drivers/char/ipmi/bt-bmc.c | 4 +---
>  1 file changed, 1 insertion(+), 3 deletions(-)
> 
> diff --git a/drivers/char/ipmi/bt-bmc.c b/drivers/char/ipmi/bt-bmc.c
> index 40b9927..d36aeac 100644
> --- a/drivers/char/ipmi/bt-bmc.c
> +++ b/drivers/char/ipmi/bt-bmc.c
> @@ -444,15 +444,13 @@ static int bt_bmc_probe(struct platform_device *pdev)
>  
>  	bt_bmc->map = syscon_node_to_regmap(pdev->dev.parent->of_node);
>  	if (IS_ERR(bt_bmc->map)) {
> -		struct resource *res;
>  		void __iomem *base;
>  
>  		/*
>  		 * Assume it's not the MFD-based devicetree description, in
>  		 * which case generate a regmap ourselves
>  		 */
> -		res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
> -		base = devm_ioremap_resource(&pdev->dev, res);
> +		base = devm_platform_ioremap_resource(pdev, 0);
>  		if (IS_ERR(base))
>  			return PTR_ERR(base);
>  
> -- 
> 2.7.4
> 
> 
