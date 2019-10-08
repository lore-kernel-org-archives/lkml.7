Return-Path: <SRS0=XKeO=YB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8FE07C4360C
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Oct 2019 15:22:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6971D21835
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Oct 2019 15:22:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LxWHWWPt"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727695AbfJHPWX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 8 Oct 2019 11:22:23 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:33286 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725989AbfJHPWW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Oct 2019 11:22:22 -0400
Received: by mail-pg1-f194.google.com with SMTP id i76so3266593pgc.0;
        Tue, 08 Oct 2019 08:22:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=5xG5+Oo4v56broIMM5QcJnniRtbmiITyPIf1BAToKSM=;
        b=LxWHWWPt/9zyDaMu1ossPkJ9HjPAC1NyyhZ6+hxjyqWqa7qPe/7o/EUWxIbOeYPYyF
         DhLHV1iDfhjC4AvJe6l4Xf3Lg3O5G0xvZu5P8V2QxxFzDSM5QlU8qM8Paf77rTM1QDZH
         Pur/VSO9b1ySCCooA1vjxJEC9DBCcTBSAhQ8BS4TqRwRPZaFQHEQWIteg/POvUGUWV1z
         Yyogky43qesIfN306gTbb9RBTRSGI57ylTzUM7LF3RIDM09RuCoettDtskFgRL/xppO1
         ATLDOs3+23muNWz6MJ+gNbZXI+1xKiQLcT9M9u2U9E3RFKSyaYVIwcOLq11GTU91iTOE
         UiHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=5xG5+Oo4v56broIMM5QcJnniRtbmiITyPIf1BAToKSM=;
        b=kKuS8Sav2yuCFJejyZc1MAOUqDEbxPLLLUQ3WFf3XCw6QNxvu7Mn1V0VGFNVwWDVYO
         pbhsC/9jbsRbNUJftGhsaTEkwAqJY5UH9n13R9HpY/dTdKzWY6yJSfJ5rOA3tEsUkJ73
         TZPtRZL3MnFGNKdEOO8JX0qlRBwepONNuungNkfeUQiHF6SkFM4NhLnbrOiRF9CJneQd
         T/cRAl07xz5owODnYbIPWfZXAHGy8WiKoGD9BpnECdQoOyGC600UPXzFxpTz669YUbgc
         o+gvhHusrqMNYpUR1PoPb9MBNBeKR29WBNCzS3NONDY0VqB+N4kWm89lXMNJCk3Rw428
         YdvA==
X-Gm-Message-State: APjAAAUMSzrNNyeDLCPLldEN2aHl2uN7mNNmdQOS3MXEHpKiEZTNOoNS
        GVJCTqgPy0pxAguXMRx6VPkE9yfd
X-Google-Smtp-Source: APXvYqwG0opyl2Jzr9fUsA5iU6FFnLT8RzhIHRu23ziC2eGOTMlrC3RKZlWVf638whB95iFQFRZvcQ==
X-Received: by 2002:aa7:8e8d:: with SMTP id a13mr34579207pfr.44.1570548141978;
        Tue, 08 Oct 2019 08:22:21 -0700 (PDT)
Received: from localhost ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id u4sm17620405pfu.177.2019.10.08.08.22.20
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 08 Oct 2019 08:22:21 -0700 (PDT)
Date:   Tue, 8 Oct 2019 08:22:20 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Michal Simek <michal.simek@xilinx.com>
Cc:     linux-kernel@vger.kernel.org, monstr@monstr.eu, git@xilinx.com,
        Wim Van Sebroeck <wim@linux-watchdog.org>,
        linux-watchdog@vger.kernel.org
Subject: Re: [PATCH] watchdog: cadence: Do not show error in case of deferred
 probe
Message-ID: <20191008152220.GB15540@roeck-us.net>
References: <d3e295d5ba79f453b4aa4128c4fa63fbd6c16920.1570544944.git.michal.simek@xilinx.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d3e295d5ba79f453b4aa4128c4fa63fbd6c16920.1570544944.git.michal.simek@xilinx.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 08, 2019 at 04:29:10PM +0200, Michal Simek wrote:
> There is no reason to show error message if clocks are not ready yet.
> 
> Signed-off-by: Michal Simek <michal.simek@xilinx.com>

Reviewed-by: Guenter Roeck <linux@roeck-us.net>

> ---
> 
>  drivers/watchdog/cadence_wdt.c | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/watchdog/cadence_wdt.c b/drivers/watchdog/cadence_wdt.c
> index 76d855ce25f3..672b184da875 100644
> --- a/drivers/watchdog/cadence_wdt.c
> +++ b/drivers/watchdog/cadence_wdt.c
> @@ -335,8 +335,10 @@ static int cdns_wdt_probe(struct platform_device *pdev)
>  
>  	wdt->clk = devm_clk_get(dev, NULL);
>  	if (IS_ERR(wdt->clk)) {
> -		dev_err(dev, "input clock not found\n");
> -		return PTR_ERR(wdt->clk);
> +		ret = PTR_ERR(wdt->clk);
> +		if (ret != -EPROBE_DEFER)
> +			dev_err(dev, "input clock not found\n");
> +		return ret;
>  	}
>  
>  	ret = clk_prepare_enable(wdt->clk);
> -- 
> 2.17.1
> 
