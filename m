Return-Path: <SRS0=/BZh=RY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 24F8CC43381
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Mar 2019 12:01:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E86B021915
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Mar 2019 12:01:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ingics-com.20150623.gappssmtp.com header.i=@ingics-com.20150623.gappssmtp.com header.b="nmSiY12D"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728049AbfCUMBF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Mar 2019 08:01:05 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:32841 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725985AbfCUMBC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Mar 2019 08:01:02 -0400
Received: by mail-pg1-f194.google.com with SMTP id b12so4077377pgk.0
        for <linux-kernel@vger.kernel.org>; Thu, 21 Mar 2019 05:01:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ingics-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=TR/Ou2zwfjvvN7Sy4bS1OUimm20DLap/4ewGftvK3nM=;
        b=nmSiY12D/RMMzIR/7A/c5V9B6nlV7ego7SS6xnYBYJLdaQTAy8a41LQXntcRdFuhi2
         mCAzu4LTgsWlx2qmroMf/U42blSN7GvXkmZIUacJiejyQRpmE26YB8uLnxLA4SNjw8OB
         pPs1OSjSwpMhDqM3PUjirhZXHriJy0s5PIeFsB5oq+Kpr1ERBEchEYjSoYNBdfHsrnL6
         eaEiX8i8QQFhndHLauaHoNzvY67fCKOa5m3JgCCw1fMJbB4LiKVK0tyzPFvmwsyiMrka
         G7gRSniqPldlaotr5EXYN8Rm6gCcnXp9sfgmvr+J4n/zIK5GGV8HNVl35v3GrP4V33yI
         yB0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=TR/Ou2zwfjvvN7Sy4bS1OUimm20DLap/4ewGftvK3nM=;
        b=FdTnhjxLwbHUap/Q5UPqLNKNpQ7LQo18eScH6ac3A3lTmamKoPtbHEMi8hHtocRTYS
         2R1O7qTbUF6bEbQA4I0UeslxOSAJU+3Cmw/cp59P2DHKHhnyX80AgbuDJd3qRjlyhtdf
         +N0zw346jvHBfqxNfEQd9HIGOdknCeM1bf8a35hPvais3Uzt09xn2He8S0g6vX58vPut
         bSGlE6yl+Ts3QCNTFyDn6JistQsN813Y42Alpg4jnJH9m7q2bYXa90K6FLZtqQzomMRU
         Dt1u+wupLb5MUiWp94CIlx1xt2UKWwm5+KimywouvIHN+FVvffEHTaG/n52RXaJWoufr
         2CzA==
X-Gm-Message-State: APjAAAXeWW6zZOcSv4ecJ6/e4QgVtdcVPQH0hAY8K1V6BndZ/4l28p7+
        W18rBYhBkCS3Ki6r2KmBb7h+Bg==
X-Google-Smtp-Source: APXvYqyjV1uHTfKdOyoS+oGfTnOjZ7QFJSLEX2snSFDammqccQE4E1n/RZt5zlJCCGSIJqivVSXrMw==
X-Received: by 2002:a62:3347:: with SMTP id z68mr2999682pfz.76.1553169661986;
        Thu, 21 Mar 2019 05:01:01 -0700 (PDT)
Received: from localhost.localdomain (118-171-142-96.dynamic-ip.hinet.net. [118.171.142.96])
        by smtp.gmail.com with ESMTPSA id 71sm8256258pgc.23.2019.03.21.05.00.58
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 21 Mar 2019 05:01:01 -0700 (PDT)
From:   Axel Lin <axel.lin@ingics.com>
To:     Mark Brown <broonie@kernel.org>
Cc:     Liam Girdwood <lgirdwood@gmail.com>, linux-kernel@vger.kernel.org,
        Laxman Dewangan <ldewangan@nvidia.com>,
        Venkat Reddy Talla <vreddytalla@nvidia.com>,
        Axel Lin <axel.lin@ingics.com>
Subject: [PATCH 2/2] regulator: tps65132: Constify tps65132_regulator_ops and tps_regs_desc
Date:   Thu, 21 Mar 2019 20:00:38 +0800
Message-Id: <20190321120038.12013-2-axel.lin@ingics.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190321120038.12013-1-axel.lin@ingics.com>
References: <20190321120038.12013-1-axel.lin@ingics.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The tps65132_regulator_ops and tps_regs_desc never need to be modified,
make them const so compiler can put them to .rodata.

Signed-off-by: Axel Lin <axel.lin@ingics.com>
---
 drivers/regulator/tps65132-regulator.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/regulator/tps65132-regulator.c b/drivers/regulator/tps65132-regulator.c
index 1f627e161b99..6e22f5ebba2e 100644
--- a/drivers/regulator/tps65132-regulator.c
+++ b/drivers/regulator/tps65132-regulator.c
@@ -117,7 +117,7 @@ static int tps65132_regulator_is_enabled(struct regulator_dev *rdev)
 	return 1;
 }
 
-static struct regulator_ops tps65132_regulator_ops = {
+static const struct regulator_ops tps65132_regulator_ops = {
 	.enable = tps65132_regulator_enable,
 	.disable = tps65132_regulator_disable,
 	.is_enabled = tps65132_regulator_is_enabled,
@@ -193,7 +193,7 @@ static int tps65132_of_parse_cb(struct device_node *np,
 		.owner = THIS_MODULE,			\
 	}
 
-static struct regulator_desc tps_regs_desc[TPS65132_MAX_REGULATORS] = {
+static const struct regulator_desc tps_regs_desc[TPS65132_MAX_REGULATORS] = {
 	TPS65132_REGULATOR_DESC(VPOS, outp),
 	TPS65132_REGULATOR_DESC(VNEG, outn),
 };
-- 
2.17.1

