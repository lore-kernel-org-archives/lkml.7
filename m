Return-Path: <SRS0=2dYc=UG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3A5B2C468BC
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Jun 2019 17:35:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 16D41208C3
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Jun 2019 17:35:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AZX6GDj6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731557AbfFGRfh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Jun 2019 13:35:37 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:41595 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728998AbfFGRfg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Jun 2019 13:35:36 -0400
Received: by mail-pg1-f196.google.com with SMTP id 83so1508517pgg.8;
        Fri, 07 Jun 2019 10:35:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=d8Zhil16cCklev3Hhi9oIiyQQGrl2e9GqmCCwrtiXdk=;
        b=AZX6GDj6WfsIb1ibf7l1wAescvlPCsTMwGSKgulKl6tlJiq8ZgOKFU/hL+Z+WT5ife
         s8pK0rO7uXRdEOJV1uBl9qft27qSxNTwoGhxKVeguOn3h+Pi+7HP5IIbtWyyyLiOB4tL
         5ZhdjOGdP5k0DPBDH38spUPUfzPWY/XkQBMkISY5mchqc4Bl9AKT6X3RK8WxI9XsOhXw
         ojNl/REyAvrlewhCdOMkQ0i4ivrtqjjDqTygitDkx3GB7OmibJ5/9JCQ4dpJi6Bd9FZ7
         ANWn+vlBglvp4EgG3hnQCIOZWVp26YrfxRj0ctfhOlbPU9LMzeVmEYYHEibi49VrZfSZ
         ko1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition
         :content-transfer-encoding:in-reply-to:user-agent;
        bh=d8Zhil16cCklev3Hhi9oIiyQQGrl2e9GqmCCwrtiXdk=;
        b=f73WbxDKlP6FrYyaxvKZMWwQi4QrCq5+peWhgQdpHyleqqxy85chIZFlMbvu7b8Xpq
         3hG15/1cUAvSRSyqzcezxTrLlqAJ9uxzbBhiM+gPJRzuc7r9mjmVVv3D2vLnioKu05SW
         5ZhlBt9jxB+zYLuBzUxtuEw78H5/AcqFoma4v1yaaRkFtNQ+eX+SrphKl9nN/VzaEcZb
         iRCcY/EtBRsRmIEpYIU1zvkJOVIt+Eq/6Uf5SNWCjz6FI6iifYgpoJ/I/AnVTid8Rynk
         gQRD7u5Wy+4bbn0ohb4pf7qfczNkirmL/W3vMPTITuSyMxNxvRCEV6OIw4hR4kyB14f5
         irtA==
X-Gm-Message-State: APjAAAXe+/mtSXz3s9cz1hDpJ/h1GBtKya76fmH2q6+1U/Wl599ADVLd
        F2hfwMC/6mjy5ytIK5HSCsc=
X-Google-Smtp-Source: APXvYqye3uhb0jhDnBYaj8BRcBNlfbyR8esY3incoxAlfXi7sx2TjFLkz9Hiah13kkAa+WVq2sq6eg==
X-Received: by 2002:a62:1692:: with SMTP id 140mr58660048pfw.166.1559928936179;
        Fri, 07 Jun 2019 10:35:36 -0700 (PDT)
Received: from localhost ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id e184sm7419799pfa.169.2019.06.07.10.35.35
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 07 Jun 2019 10:35:35 -0700 (PDT)
Date:   Fri, 7 Jun 2019 10:35:34 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     =?iso-8859-1?Q?Cl=E9ment_P=E9ron?= <peron.clem@gmail.com>
Cc:     Wim Van Sebroeck <wim@linux-watchdog.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Chen-Yu Tsai <wens@csie.org>, linux-watchdog@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 1/4] dt-bindings: watchdog: add Allwinner H6 watchdog
Message-ID: <20190607173534.GA14933@roeck-us.net>
References: <20190523151050.27302-1-peron.clem@gmail.com>
 <20190523151050.27302-2-peron.clem@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190523151050.27302-2-peron.clem@gmail.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 23, 2019 at 05:10:47PM +0200, Clément Péron wrote:
> Allwinner H6 has a similar watchdog as the A64 which is already
> a compatible of the A31.
> 
> This commit add the H6 compatible.
> 
> Signed-off-by: Clément Péron <peron.clem@gmail.com>
> Reviewed-by: Rob Herring <robh@kernel.org>

Reviewed-by: Guenter Roeck <linux@roeck-us.net>

> ---
>  Documentation/devicetree/bindings/watchdog/sunxi-wdt.txt | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/Documentation/devicetree/bindings/watchdog/sunxi-wdt.txt b/Documentation/devicetree/bindings/watchdog/sunxi-wdt.txt
> index 46055254e8dd..e65198d82a2b 100644
> --- a/Documentation/devicetree/bindings/watchdog/sunxi-wdt.txt
> +++ b/Documentation/devicetree/bindings/watchdog/sunxi-wdt.txt
> @@ -6,6 +6,7 @@ Required properties:
>  	"allwinner,sun4i-a10-wdt"
>  	"allwinner,sun6i-a31-wdt"
>  	"allwinner,sun50i-a64-wdt","allwinner,sun6i-a31-wdt"
> +	"allwinner,sun50i-h6-wdt","allwinner,sun6i-a31-wdt"
>  	"allwinner,suniv-f1c100s-wdt", "allwinner,sun4i-a10-wdt"
>  - reg : Specifies base physical address and size of the registers.
>  
