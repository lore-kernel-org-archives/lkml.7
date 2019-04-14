Return-Path: <SRS0=avfD=SQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3CC89C10F13
	for <linux-kernel@archiver.kernel.org>; Sun, 14 Apr 2019 12:48:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 093B02084E
	for <linux-kernel@archiver.kernel.org>; Sun, 14 Apr 2019 12:48:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ingics-com.20150623.gappssmtp.com header.i=@ingics-com.20150623.gappssmtp.com header.b="fpJ66nFI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726392AbfDNMsd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 14 Apr 2019 08:48:33 -0400
Received: from mail-pl1-f193.google.com ([209.85.214.193]:39837 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725805AbfDNMsc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 14 Apr 2019 08:48:32 -0400
Received: by mail-pl1-f193.google.com with SMTP id a96so7253748pla.6
        for <linux-kernel@vger.kernel.org>; Sun, 14 Apr 2019 05:48:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ingics-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id;
        bh=HwUBrhnUTzJfmI0zyLxkjidG3lS1bXWYm/DzwHsH33A=;
        b=fpJ66nFIsQofFNa7gUWz/9NqNaq/K12lXeSqCnE6bmfQL5ERqjDjupjW+noYzHEUPn
         VBdGGTdG71L1i7cXqZ9+Y0DGy6SFKbvs5T/GhhkE+cveR/xFqwbtAhZ6VFLT9rNmLgAx
         3939c6xvk0KIhO21i0M06ftcSPOib4yXQz3YVsflWtdAU1gt1POLA3B8E9T0slsizdFW
         C5PB+Wy5vbRjCC2MuKgrzwoxbesWGVQ9ecGT4AW+vDCJT7oiji9X/UiueZH3uZJHQfio
         awVzZAhXDVx7c/MO8m2LDJ6vcrFSxUznxdHzlyd5R34F/UvaDTT4HfWgGz9olkyYfUPu
         wBHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=HwUBrhnUTzJfmI0zyLxkjidG3lS1bXWYm/DzwHsH33A=;
        b=W7k5a2BD22HTYhGbrOAlufYNSlhFvk2Ob+pc/5OR+5PKbsfWwJfrqv3WdWN3XUVsyh
         Gt8A5SAGXMUFyXQtu4LcPpltIPOMLcK9cpZu+7jnasZ2S73nv53bk/kZTAqTIY2aIK9W
         RkPbx5QDK9g7+CFvv0YoWj8+ZfSQTyqH6mFq77uEpoLXu3OJV/7uugVv3bsmkKCoqXqZ
         yLaRUBqlqQfRjrOHdxDiXBTVPAuyQdeqX5IbSEFClHoCBjbtJBkedCNTM2f7f/62fUCf
         k3ijsyJvw7D2KROjJ5F7nwuOovv+J1y4cojTHRQXjhbqUzBWtyJXXghQU5z5V8xIlxDs
         Q+BQ==
X-Gm-Message-State: APjAAAXmadUBtAxuzaXNpWJdwpiPRbR0R5K+5MO34YaWWBrS9rEDPQYo
        E0q7HfJ0qE+pY2c7uk/tOJW+Zw==
X-Google-Smtp-Source: APXvYqxOu0sTmmRP1Qmf85HyU6qjOBSp7vR1bSP5m4/kT/01wms+MXgZLpCFc+HluRPRJfgp/sTxQA==
X-Received: by 2002:a17:902:581:: with SMTP id f1mr28062052plf.304.1555246111593;
        Sun, 14 Apr 2019 05:48:31 -0700 (PDT)
Received: from localhost.localdomain (118-171-129-145.dynamic-ip.hinet.net. [118.171.129.145])
        by smtp.gmail.com with ESMTPSA id h10sm71271288pfj.79.2019.04.14.05.48.27
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 14 Apr 2019 05:48:30 -0700 (PDT)
From:   Axel Lin <axel.lin@ingics.com>
To:     Mark Brown <broonie@kernel.org>
Cc:     Kyungmin Park <kyungmin.park@samsung.com>,
        MyungJoo Ham <myungjoo.ham@samsung.com>,
        Lukasz Majewski <l.majewski@samsung.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        linux-kernel@vger.kernel.org, Axel Lin <axel.lin@ingics.com>
Subject: [PATCH 1/2] regulator: max8998: Constify regulator_ops
Date:   Sun, 14 Apr 2019 20:48:17 +0800
Message-Id: <20190414124818.28161-1-axel.lin@ingics.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

These regulator_ops variables never need to be modified, make them const so
compiler can put them to .rodata.

Signed-off-by: Axel Lin <axel.lin@ingics.com>
---
 drivers/regulator/max8998.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/regulator/max8998.c b/drivers/regulator/max8998.c
index 271bb736f3f5..43b69ebd086b 100644
--- a/drivers/regulator/max8998.c
+++ b/drivers/regulator/max8998.c
@@ -427,7 +427,7 @@ static int max8998_set_voltage_buck_time_sel(struct regulator_dev *rdev,
 	return 0;
 }
 
-static struct regulator_ops max8998_ldo_ops = {
+static const struct regulator_ops max8998_ldo_ops = {
 	.list_voltage		= regulator_list_voltage_linear,
 	.map_voltage		= regulator_map_voltage_linear,
 	.is_enabled		= max8998_ldo_is_enabled,
@@ -437,7 +437,7 @@ static struct regulator_ops max8998_ldo_ops = {
 	.set_voltage_sel	= max8998_set_voltage_ldo_sel,
 };
 
-static struct regulator_ops max8998_buck_ops = {
+static const struct regulator_ops max8998_buck_ops = {
 	.list_voltage		= regulator_list_voltage_linear,
 	.map_voltage		= regulator_map_voltage_linear,
 	.is_enabled		= max8998_ldo_is_enabled,
@@ -448,7 +448,7 @@ static struct regulator_ops max8998_buck_ops = {
 	.set_voltage_time_sel	= max8998_set_voltage_buck_time_sel,
 };
 
-static struct regulator_ops max8998_others_ops = {
+static const struct regulator_ops max8998_others_ops = {
 	.is_enabled		= max8998_ldo_is_enabled,
 	.enable			= max8998_ldo_enable,
 	.disable		= max8998_ldo_disable,
-- 
2.17.1

