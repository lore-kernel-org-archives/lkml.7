Return-Path: <SRS0=/o37=YT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A7742CA9EB9
	for <linux-kernel@archiver.kernel.org>; Sat, 26 Oct 2019 23:52:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7779420684
	for <linux-kernel@archiver.kernel.org>; Sat, 26 Oct 2019 23:52:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IOKlTvve"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726643AbfJZXwU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 26 Oct 2019 19:52:20 -0400
Received: from mail-qt1-f195.google.com ([209.85.160.195]:45348 "EHLO
        mail-qt1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726505AbfJZXwT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 26 Oct 2019 19:52:19 -0400
Received: by mail-qt1-f195.google.com with SMTP id c21so9015840qtj.12
        for <linux-kernel@vger.kernel.org>; Sat, 26 Oct 2019 16:52:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=7j+uiU//QQeYCq1CG42LPhKjQKtwoWPeb2LyyIljXks=;
        b=IOKlTvveHUbhXtgHNFBXvqdBfrUvS9CmCgMfpoFNJeKu9XaXVGZAijRqLAy5NyrY9d
         vPLv+nYcoTKVN6tYWYClv8SJMPo3QJcugXdmezjslmF5baou9yoE3spxGfKgE7cjDspU
         YOM/3BrePyMTk7PrrBuu7jUrcXMadq4kTMWVx9xGWcgjc10dyB8WgeTwq0Y36QUZuCw1
         3EkyGOoHIHpBIsxc6uXdfTnTjTynVqQne7aZjxYKcI16MV/YwYzNhbrICrc59RVln20G
         H5biSihRpz89ybv+KwFFDjm61yTb/5OwGr7ajPO96NGBPSS8wKIJPpE972FtqV54Igic
         S9vw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=7j+uiU//QQeYCq1CG42LPhKjQKtwoWPeb2LyyIljXks=;
        b=QT7vFFoEVRFGZuDBW/ZcnBPAZ7hE9ifS944UBP0Vy10EV4Aq4mlw0B+lXBtruEjpZ0
         5eQeMN2hkCzkyYfHqpggWqstHKPh3mnfLt20JTlydEcEvCuXvYgQiONdvHY8CrLDLrpE
         p1ff/3PyzLAXssM6ZM5XOzK08uo+CG8A6Jl4XeaTJAxRcMUQstZvumgnd8UyyhS90vre
         M5b1jWyZNQRVFEWU7kRGwXvH6cBsaXLJFJ3B2BS4/fAFtSwE3PAuHJBNcMAB5y2V1VBl
         BGRjXhVOtx/NNqQw0fqq3Amayc6Gw4O/Rz2gQ4Q5A8svz+15zRGpJhuIedfUKW7KatEX
         WQVg==
X-Gm-Message-State: APjAAAWCh+tMyQRoyOqsZb8C9BmQ32kfvg5GeX/2myyJr+1DFWI39Cpr
        /z5JQATfyBt6V3+nYhJGHtI=
X-Google-Smtp-Source: APXvYqx9fS+RbEgRlNhkUNkao5B6fT+Y4Wq4G+HBziDFwkvZKzRz3KaKA0qOwathSf5RxlwgiMc7RQ==
X-Received: by 2002:ac8:34f3:: with SMTP id x48mr10944037qtb.223.1572133938564;
        Sat, 26 Oct 2019 16:52:18 -0700 (PDT)
Received: from cristiane-Inspiron-5420 ([131.100.148.220])
        by smtp.gmail.com with ESMTPSA id u43sm4080154qte.19.2019.10.26.16.52.16
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 26 Oct 2019 16:52:18 -0700 (PDT)
Date:   Sat, 26 Oct 2019 20:52:14 -0300
From:   Cristiane Naves <cristianenavescardoso09@gmail.com>
To:     outreachy-kernel@googlegroups.com
Cc:     Sven Van Asbroeck <TheSven73@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org
Subject: [PATCH] staging: fieldbus: anybuss: use
 devm_platform_ioremap_resource helper
Message-ID: <20191026235214.GA11702@cristiane-Inspiron-5420>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use devm_platform_ioremap_resource helper which wraps
platform_get_resource() and devm_ioremap_resource() together. Issue
found by coccicheck.

Signed-off-by: Cristiane Naves <cristianenavescardoso09@gmail.com>
---
 drivers/staging/fieldbus/anybuss/arcx-anybus.c | 8 ++------
 1 file changed, 2 insertions(+), 6 deletions(-)

diff --git a/drivers/staging/fieldbus/anybuss/arcx-anybus.c b/drivers/staging/fieldbus/anybuss/arcx-anybus.c
index 2ecffa4..5b8d0ba 100644
--- a/drivers/staging/fieldbus/anybuss/arcx-anybus.c
+++ b/drivers/staging/fieldbus/anybuss/arcx-anybus.c
@@ -127,12 +127,10 @@ static const struct regmap_config arcx_regmap_cfg = {
 static struct regmap *create_parallel_regmap(struct platform_device *pdev,
 					     int idx)
 {
-	struct resource *res;
 	void __iomem *base;
 	struct device *dev = &pdev->dev;
 
-	res = platform_get_resource(pdev, IORESOURCE_MEM, idx + 1);
-	base = devm_ioremap_resource(dev, res);
+	base = devm_platform_ioremap_resource(pdev, idx + 1);
 	if (IS_ERR(base))
 		return ERR_CAST(base);
 	return devm_regmap_init_mmio(dev, base, &arcx_regmap_cfg);
@@ -230,7 +228,6 @@ static int controller_probe(struct platform_device *pdev)
 	struct regulator_config config = { };
 	struct regulator_dev *regulator;
 	int err, id;
-	struct resource *res;
 	struct anybuss_host *host;
 	u8 status1, cap;
 
@@ -244,8 +241,7 @@ static int controller_probe(struct platform_device *pdev)
 		return PTR_ERR(cd->reset_gpiod);
 
 	/* CPLD control memory, sits at index 0 */
-	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
-	cd->cpld_base = devm_ioremap_resource(dev, res);
+	cd->cpld_base = devm_platform_ioremap_resource(pdev, 0);
 	if (IS_ERR(cd->cpld_base)) {
 		dev_err(dev,
 			"failed to map cpld base address\n");
-- 
2.7.4

