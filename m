Return-Path: <SRS0=S2At=YJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E8C9FA3728
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Oct 2019 15:20:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 42B612067D
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Oct 2019 15:20:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="H2TT2wss"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2393282AbfJPPUV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 16 Oct 2019 11:20:21 -0400
Received: from mail-oi1-f194.google.com ([209.85.167.194]:46835 "EHLO
        mail-oi1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731530AbfJPPUU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Oct 2019 11:20:20 -0400
Received: by mail-oi1-f194.google.com with SMTP id k25so20334654oiw.13
        for <linux-kernel@vger.kernel.org>; Wed, 16 Oct 2019 08:20:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:reply-to:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=Hg//TZrhBsTy9D87m/T6t9gxtTCE+xcZuR7rP4e2SMY=;
        b=H2TT2wssG/M4CGPptijE6fYDUwf6g02pfVhn2pLyGTct7/HPxBRUoc7o0wYy4masnz
         puxOhemptI0TnB1Gk2dbdiI8v1Z1jhViNl/rhVYsWhNJauqCZcXyx/loBdg73ER910jF
         9JI6iLelAXAgp/mqa0NsYUC6GAvq97L62s7oB1XeMtZ32mhjQPj/PFUjUo7y2AVvDd0n
         QKJmLeVwWQ/UWIjxfakQD+LqvVt4nmGvLPGuM0n64E/BYo0+xneHRD0owdjiccLcAClN
         2vMyt43umiFBp9GBuJxIN2X7YanifU34H1pCuNbYm17q+S/dUB8EYAU2s+mItkqu7Ux2
         foSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :reply-to:references:mime-version:content-disposition
         :content-transfer-encoding:in-reply-to:user-agent;
        bh=Hg//TZrhBsTy9D87m/T6t9gxtTCE+xcZuR7rP4e2SMY=;
        b=rW+7W8qbSrKKApUTmngd8kDxaCQ0ajI09dDOYRDKC2N8XVT/feJySop7+UK76MDSJm
         Vpi13vGXzxoHqEX12S6uV1GwCQT/zu+BHuj75vrnIAp/Kt/aM1fEadgzr4Oj1yPQf7Lk
         YcxQe/gy6EScqWeqz5vm6xdIgbsk8NiY8N2DLIdqh7c8dv3CQh49UABygPxnss2ZRhfI
         GUYUjyBtTi4Ltjn+Iy8zvDcxrXZ7VCu2HhWNYQPkP96L82wf/jQ1kS28IxOcXLUBurvS
         xbgk6QsHmywjD1NAhcRC+8SMhVX00g+q3Gf0idwIoOkb/duFR9HsIEoHbnfD1nObxDbT
         XSxg==
X-Gm-Message-State: APjAAAXsDfAltmaekzrnYstikXQrh1AabuvwCAuCxDmPKT/9918Ln/Ov
        O0a/0PUM0KQmWGMEyjmpyQ==
X-Google-Smtp-Source: APXvYqw29TSLm5lXfqhgqJ4rgsbwSamu6EsD2YQAkOS+jHJBw4/SftqEt/3cn7iBZ7a/ahH0VVTfAQ==
X-Received: by 2002:a54:4582:: with SMTP id z2mr4069134oib.140.1571239219494;
        Wed, 16 Oct 2019 08:20:19 -0700 (PDT)
Received: from serve.minyard.net (serve.minyard.net. [2001:470:b8f6:1b::1])
        by smtp.gmail.com with ESMTPSA id k2sm7449649oih.38.2019.10.16.08.20.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Oct 2019 08:20:18 -0700 (PDT)
Received: from t560 (unknown [192.168.27.180])
        by serve.minyard.net (Postfix) with ESMTPSA id 49C4A180056;
        Wed, 16 Oct 2019 15:20:18 +0000 (UTC)
Date:   Wed, 16 Oct 2019 10:20:17 -0500
From:   Corey Minyard <minyard@acm.org>
To:     =?utf-8?Q?C=C3=A9dric?= Le Goater <clg@kaod.org>
Cc:     YueHaibing <yuehaibing@huawei.com>, arnd@arndb.de,
        gregkh@linuxfoundation.org,
        openipmi-developer@lists.sourceforge.net,
        linux-kernel@vger.kernel.org,
        Alistair Popple <alistair@popple.id.au>
Subject: Re: [PATCH -next] ipmi: bt-bmc: use devm_platform_ioremap_resource()
 to simplify code
Message-ID: <20191016152017.GO14232@t560>
Reply-To: minyard@acm.org
References: <20191016092131.23096-1-yuehaibing@huawei.com>
 <20191016141936.GN14232@t560>
 <789af3ff-9ed8-5869-05c4-9cfb2ac5e9d5@kaod.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <789af3ff-9ed8-5869-05c4-9cfb2ac5e9d5@kaod.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 16, 2019 at 04:41:07PM +0200, Cédric Le Goater wrote:
> On 16/10/2019 16:19, Corey Minyard wrote:
> > On Wed, Oct 16, 2019 at 05:21:31PM +0800, YueHaibing wrote:
> >> Use devm_platform_ioremap_resource() to simplify the code a bit.
> >> This is detected by coccinelle.
> > 
> > Adding the module author and others. I can't see a reason to not do
> > this.
> 
> yes. Looks good to me.
> 
> Reviewed-by: Cédric Le Goater <clg@kaod.org>

Queued for next merge window, unless someone protests.

-corey

> 
> Thanks,
> 
> C.
> 
> > -corey
> > 
> >>
> >> Signed-off-by: YueHaibing <yuehaibing@huawei.com>
> >> ---
> >>  drivers/char/ipmi/bt-bmc.c | 4 +---
> >>  1 file changed, 1 insertion(+), 3 deletions(-)
> >>
> >> diff --git a/drivers/char/ipmi/bt-bmc.c b/drivers/char/ipmi/bt-bmc.c
> >> index 40b9927..d36aeac 100644
> >> --- a/drivers/char/ipmi/bt-bmc.c
> >> +++ b/drivers/char/ipmi/bt-bmc.c
> >> @@ -444,15 +444,13 @@ static int bt_bmc_probe(struct platform_device *pdev)
> >>  
> >>  	bt_bmc->map = syscon_node_to_regmap(pdev->dev.parent->of_node);
> >>  	if (IS_ERR(bt_bmc->map)) {
> >> -		struct resource *res;
> >>  		void __iomem *base;
> >>  
> >>  		/*
> >>  		 * Assume it's not the MFD-based devicetree description, in
> >>  		 * which case generate a regmap ourselves
> >>  		 */
> >> -		res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
> >> -		base = devm_ioremap_resource(&pdev->dev, res);
> >> +		base = devm_platform_ioremap_resource(pdev, 0);
> >>  		if (IS_ERR(base))
> >>  			return PTR_ERR(base);
> >>  
> >> -- 
> >> 2.7.4
> >>
> >>
> 
