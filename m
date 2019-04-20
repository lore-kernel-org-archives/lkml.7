Return-Path: <SRS0=ruH4=SW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 43588C282E3
	for <linux-kernel@archiver.kernel.org>; Sat, 20 Apr 2019 07:20:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 085B021855
	for <linux-kernel@archiver.kernel.org>; Sat, 20 Apr 2019 07:20:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ingics-com.20150623.gappssmtp.com header.i=@ingics-com.20150623.gappssmtp.com header.b="zyN+cMzE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727457AbfDTHUO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 20 Apr 2019 03:20:14 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:40259 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725911AbfDTHUO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 20 Apr 2019 03:20:14 -0400
Received: by mail-pf1-f196.google.com with SMTP id c207so3450986pfc.7
        for <linux-kernel@vger.kernel.org>; Sat, 20 Apr 2019 00:20:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ingics-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id;
        bh=5LKmp5wLYO59C//hsUATdkaUoT6x7+Vp058K6VeHKQE=;
        b=zyN+cMzE17Y25b6+RmGUP2Je0CdG7pU1gzp8IdtTBgOysKAMg8uZ0ON5GeKHYGsKrL
         k0RPPiDTceEbYKOfROA+7ATnkamkh2dQoD+Qt8uzK6tvevwLOfCW8652powQ43dFM7ck
         8RHDFlw2/VS7IPr5fWFAjzHI3dqbrJ5WCiUe5y0yNvApoD7rxWUUa5aaoCnW/9R8PSMe
         /VAYnqTN391J2bJ2UX1aqs0G9oHqP2xW+SRkwUUK48B1WFfpSvh8D3lcmlH1NCoKYYHE
         c976UKzLZspIaDZddvW0WuGcRYuBh0dOryxjCvQDEaSaJ6vRIcTgcjdB2J0V3P2ezeWP
         xfNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=5LKmp5wLYO59C//hsUATdkaUoT6x7+Vp058K6VeHKQE=;
        b=eslJGdZH99cHfXQdNf/rb4v9cRB4yKdFfPRboZfxzlw4Sn5sxECCF73QfDCsB4cELg
         5gyDgccnQHAsbl/d8e7nKxnvbc7U3kXTYheukbFE4iEmKSWDagWp2gVUusFSnnxzXxsF
         s+tek6Q5UAW4uQX9YKX17KWKyv/E7KYZKcQf+clwV5OgxJSX3BT+WtaQzbwJjo58ma++
         N175EudQxnKe6MndthRNs5XGmlKQN4zqZpZF9Bd6uPpx6Y1VU3RsoDnGu9+MHNZV8SLD
         vzQAaKPs/O9jwZYYz3EA3M3st4sKP//8sfCglbA1Q/1c7xAWE3zux2HOIGuU/p5OYTtp
         WSWw==
X-Gm-Message-State: APjAAAV0rdfDGwdehWoy82iugkXdp5D9kYodca3d4jti3vUSv5cr6mXo
        p30oez0CpJfgrmOThviOzJJYJA==
X-Google-Smtp-Source: APXvYqwx5rX3C0AAWerSo/kjav3aYgVK9/Es/+BwwBfs2800l4C1J+DBZsqYzunShIrSj4gLA0GFwg==
X-Received: by 2002:a63:521c:: with SMTP id g28mr7874044pgb.431.1555744813571;
        Sat, 20 Apr 2019 00:20:13 -0700 (PDT)
Received: from localhost.localdomain (36-239-215-67.dynamic-ip.hinet.net. [36.239.215.67])
        by smtp.gmail.com with ESMTPSA id g10sm7661852pgq.54.2019.04.20.00.20.10
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 20 Apr 2019 00:20:12 -0700 (PDT)
From:   Axel Lin <axel.lin@ingics.com>
To:     Mark Brown <broonie@kernel.org>
Cc:     Gyungoh Yoo <gyungoh@gmail.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        linux-kernel@vger.kernel.org, Axel Lin <axel.lin@ingics.com>
Subject: [PATCH 1/2] regulator: sky81452: Constify sky81452_reg_ops
Date:   Sat, 20 Apr 2019 15:20:00 +0800
Message-Id: <20190420072001.16900-1-axel.lin@ingics.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

sky81452_reg_ops is never changed, make it const.

Signed-off-by: Axel Lin <axel.lin@ingics.com>
---
 drivers/regulator/sky81452-regulator.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/regulator/sky81452-regulator.c b/drivers/regulator/sky81452-regulator.c
index 647860611916..eb2b60968a1a 100644
--- a/drivers/regulator/sky81452-regulator.c
+++ b/drivers/regulator/sky81452-regulator.c
@@ -34,7 +34,7 @@
 #define SKY81452_LEN	0x40
 #define SKY81452_LOUT	0x1F
 
-static struct regulator_ops sky81452_reg_ops = {
+static const struct regulator_ops sky81452_reg_ops = {
 	.list_voltage = regulator_list_voltage_linear_range,
 	.map_voltage = regulator_map_voltage_linear_range,
 	.get_voltage_sel = regulator_get_voltage_sel_regmap,
-- 
2.17.1

