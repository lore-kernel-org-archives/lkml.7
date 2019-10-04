Return-Path: <SRS0=OvUS=X5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 53ACBC47404
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Oct 2019 23:10:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 27C0C222C0
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Oct 2019 23:10:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="uh8tbv6F"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731606AbfJDXKj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 4 Oct 2019 19:10:39 -0400
Received: from mail-pl1-f193.google.com ([209.85.214.193]:46790 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731515AbfJDXK3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Oct 2019 19:10:29 -0400
Received: by mail-pl1-f193.google.com with SMTP id q24so3789484plr.13
        for <linux-kernel@vger.kernel.org>; Fri, 04 Oct 2019 16:10:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=sTz6nyg/advJIHntHVaaSCimDTaVYqsOmP4OveuoExU=;
        b=uh8tbv6FBWgRU1Hs/xPQuSapOx08gQpOnktegtniodTDgIT1ZHHTEZLiwQQXp8D13I
         nj3IyAudwNlXUbyO4DaVwIHdYXNpjxppQNEUzp5N19GYNfInN1rE0+nzqmgOCfL1a40u
         zWgjtPobEP3zE3qzgHtizQ383fQIl3IaHVsbKSNVoA/qpxx1C7TuzgRGdE7G0oZ9OncV
         VMQa98fm1HhHpwNeY5DEzgv3QSSMRfFl7i6pj+sIEXLCF3moVLqn6Lhr8ArR1d/2DpoC
         hyjOl8aG+mfOaZYz2jEyYhAEVBBYG7avDPKp7mGq0WvdDrtpqJ55447QdCooeC/D+89A
         MWjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=sTz6nyg/advJIHntHVaaSCimDTaVYqsOmP4OveuoExU=;
        b=Vy8UbYlf0p+moVX5XfLpiH890M//cfLgbYHVkMVgrbWExOS833fu84G0VkQhBGeVlb
         eA9mdt9zBuHvJGNf95mB5b3NuwbfOjRReuyvrXqc1nmcre9cLRqBYw95xR51QpE1ztuo
         CbFKL2DLfQbQD6DF5WeAS+0wySRSTDBQkQq7XJg74OM7QC3f1YKJSg1kJH+cqaLBD1rZ
         ESJ3fOxH87GEXYNWxQ3pK12KEOzU+MoOtdLNQJJ3w45ELznuQkcLj9YJXmxqonHMU07M
         u15LkCZXB7k+1IBsbEayYclIIt4fQYkYMy5JErrxb3klQoViBwxv6XSTno5gtJa+HBff
         YQJw==
X-Gm-Message-State: APjAAAUdMlpku7eCiAaifq8yzCbqDuVVuxg8n25bRXs6EeKxbEYJJ8dY
        Ue506+3LzDi6CXqP8HPiVtGXcDkf
X-Google-Smtp-Source: APXvYqw7LJ2rTn96J12AST+hg2ekZuCE8wKMpn1PCkkdk45zOOE1at6c2qRqvW0cjDasyM4swa42dw==
X-Received: by 2002:a17:902:bd48:: with SMTP id b8mr17794742plx.19.1570230628432;
        Fri, 04 Oct 2019 16:10:28 -0700 (PDT)
Received: from dtor-ws.mtv.corp.google.com ([2620:15c:202:201:3adc:b08c:7acc:b325])
        by smtp.gmail.com with ESMTPSA id o9sm7406542pfp.67.2019.10.04.16.10.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Oct 2019 16:10:27 -0700 (PDT)
From:   Dmitry Torokhov <dmitry.torokhov@gmail.com>
To:     Mark Brown <broonie@kernel.org>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        linux-kernel@vger.kernel.org, Liam Girdwood <lgirdwood@gmail.com>
Subject: [PATCH 6/7] regulator: tps65132: switch to using devm_fwnode_gpiod_get()
Date:   Fri,  4 Oct 2019 16:10:16 -0700
Message-Id: <20191004231017.130290-7-dmitry.torokhov@gmail.com>
X-Mailer: git-send-email 2.23.0.581.g78d2f28ef7-goog
In-Reply-To: <20191004231017.130290-1-dmitry.torokhov@gmail.com>
References: <20191004231017.130290-1-dmitry.torokhov@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

devm_fwnode_get_index_gpiod_from_child() is going away as the name is
too unwieldy, let's switch to using the new devm_fwnode_gpiod_get().

Note that we no longer need to check for NULL as devm_fwnode_gpiod_get()
will return -ENOENT if GPIO is missing.

Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
---

 drivers/regulator/tps65132-regulator.c | 17 ++++++++++-------
 1 file changed, 10 insertions(+), 7 deletions(-)

diff --git a/drivers/regulator/tps65132-regulator.c b/drivers/regulator/tps65132-regulator.c
index e302bd01a084..7b0e38f8d627 100644
--- a/drivers/regulator/tps65132-regulator.c
+++ b/drivers/regulator/tps65132-regulator.c
@@ -136,9 +136,10 @@ static int tps65132_of_parse_cb(struct device_node *np,
 	struct tps65132_reg_pdata *rpdata = &tps->reg_pdata[desc->id];
 	int ret;
 
-	rpdata->en_gpiod = devm_fwnode_get_index_gpiod_from_child(tps->dev,
-					"enable", 0, &np->fwnode, 0, "enable");
-	if (IS_ERR_OR_NULL(rpdata->en_gpiod)) {
+	rpdata->en_gpiod = devm_fwnode_gpiod_get(tps->dev, of_fwnode_handle(np),
+						 "enable", GPIOD_ASIS,
+						 "enable");
+	if (IS_ERR(rpdata->en_gpiod)) {
 		ret = PTR_ERR(rpdata->en_gpiod);
 
 		/* Ignore the error other than probe defer */
@@ -147,10 +148,12 @@ static int tps65132_of_parse_cb(struct device_node *np,
 		return 0;
 	}
 
-	rpdata->act_dis_gpiod = devm_fwnode_get_index_gpiod_from_child(
-					tps->dev, "active-discharge", 0,
-					&np->fwnode, 0, "active-discharge");
-	if (IS_ERR_OR_NULL(rpdata->act_dis_gpiod)) {
+	rpdata->act_dis_gpiod = devm_fwnode_gpiod_get(tps->dev,
+						      of_fwnode_handle(np),
+						      "active-discharge",
+						      GPIOD_ASIS,
+						      "active-discharge");
+	if (IS_ERR(rpdata->act_dis_gpiod)) {
 		ret = PTR_ERR(rpdata->act_dis_gpiod);
 
 		/* Ignore the error other than probe defer */
-- 
2.23.0.581.g78d2f28ef7-goog

