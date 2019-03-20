Return-Path: <SRS0=4Jrr=RX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 68FBCC43381
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Mar 2019 15:58:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2B8952184D
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Mar 2019 15:58:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=umn.edu header.i=@umn.edu header.b="m8ZSAKD5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726839AbfCTP6A (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Mar 2019 11:58:00 -0400
Received: from mta-p8.oit.umn.edu ([134.84.196.208]:58038 "EHLO
        mta-p8.oit.umn.edu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726295AbfCTP6A (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Mar 2019 11:58:00 -0400
Received: from localhost (unknown [127.0.0.1])
        by mta-p8.oit.umn.edu (Postfix) with ESMTP id B7799C13
        for <linux-kernel@vger.kernel.org>; Wed, 20 Mar 2019 15:57:58 +0000 (UTC)
X-Virus-Scanned: amavisd-new at umn.edu
Received: from mta-p8.oit.umn.edu ([127.0.0.1])
        by localhost (mta-p8.oit.umn.edu [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id zjAeV2tgR3B3 for <linux-kernel@vger.kernel.org>;
        Wed, 20 Mar 2019 10:57:58 -0500 (CDT)
Received: from mail-io1-f71.google.com (mail-io1-f71.google.com [209.85.166.71])
        (using TLSv1.2 with cipher AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mta-p8.oit.umn.edu (Postfix) with ESMTPS id 8B3CC1CB
        for <linux-kernel@vger.kernel.org>; Wed, 20 Mar 2019 10:57:58 -0500 (CDT)
Received: by mail-io1-f71.google.com with SMTP id n23so2439049ioj.10
        for <linux-kernel@vger.kernel.org>; Wed, 20 Mar 2019 08:57:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=umn.edu; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=BsTWEMeQpm0rXxnzkq/mdbD+H/fVZxCYwwAUQ3LTiOQ=;
        b=m8ZSAKD54rUF2BqCxZuDalLkQtzLwqeWgGq6Y2XnGx5/cdLT0tct6TMyw+BiZmJ6xF
         /VEcKB/0zQIq69JFUVjHcEiIjSwg7Sh4iyTfBTTtu4Za4/v+PIGXzx3Ak78XY7imt0Tn
         43cgCKoB5TsImofsUIOnk+7hW7iJfSJTjHM8wtVBU4MIrPT7eN/gk6ytYNleS3rQjWyP
         tzZZcCXbFDhtCwkTY6GGwb37eEQcxHTaujWpNX0UvubMPWzU9yRjviTp8NNhIJGeVQuz
         vdHdZcybY0I/WvOA1G3XV4SgaX3zuxaNN2qcGmqWbv+dETizzjb2LXf+MylqMX08PMlZ
         MqqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=BsTWEMeQpm0rXxnzkq/mdbD+H/fVZxCYwwAUQ3LTiOQ=;
        b=eZxcdVlMSLbKhs/80S6PRCEWnu6sWKIIjI5BX0Ofpg0ITEbAdT/gXdJoGn4h2ZBrQL
         ZLa7jmPwI1d9VcsxQ5qTaSD6YHVR+j52fQqSYnjbNimMgrGXKfWiE1BV6fOWeNg8A3qj
         +SzvqgQgYZH2tcLyPjqk7dVvKAyPa49I4OEO0C9v5u0215146U8XKKWuXkK8UJpIcqpE
         JlJyHy6RmThB5IZZnof50xwzY2BLcS1GpUDl1Q+GgJkI36pEqYhZoh8GDZW8UsgCogka
         HtQNWduYl0qfziJRrcUlw4Udfe5mdWbuas8QUfV5yvSNb4dBqsm9KUsOI0+EeHSpQSD+
         BvWg==
X-Gm-Message-State: APjAAAUou5LxJFOwJJLzbkEAqoYrdaGl3M1lrAIXzQD/qJK180k2jBlf
        lSZOOIPoprGg60TmZpvGX9BlpebUbUTqZu1JgLmChTCE5QKRNxBEtuUx4qJWkWj6DJ7GgaQ3nJj
        /Ek153X7nTjs2IyjirhNje+wIrUWO
X-Received: by 2002:a24:7908:: with SMTP id z8mr5866812itc.16.1553097477955;
        Wed, 20 Mar 2019 08:57:57 -0700 (PDT)
X-Google-Smtp-Source: APXvYqyU3TvuVOfrl4FnFbr693hRG05Up+Oz9edhNv9JuDCNrOmpAr5Nc6xCH1wuM+rTGdTAtUUY5A==
X-Received: by 2002:a24:7908:: with SMTP id z8mr5866802itc.16.1553097477746;
        Wed, 20 Mar 2019 08:57:57 -0700 (PDT)
Received: from cs-u-syssec1.dtc.umn.edu (cs-u-syssec1.cs.umn.edu. [128.101.106.66])
        by smtp.gmail.com with ESMTPSA id q133sm1278726itb.19.2019.03.20.08.57.56
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 20 Mar 2019 08:57:57 -0700 (PDT)
From:   Aditya Pakki <pakki001@umn.edu>
To:     pakki001@umn.edu
Cc:     kjlu@umn.edu, Andreas Noever <andreas.noever@gmail.com>,
        Michael Jamet <michael.jamet@intel.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Yehezkel Bernat <YehezkelShB@gmail.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2] thunderbolt: Fix to check for kmemdup failure
Date:   Wed, 20 Mar 2019 10:57:54 -0500
Message-Id: <20190320155754.29731-1-pakki001@umn.edu>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Memory allocated via kmemdup might fail and return a NULL pointer.
This patch adds a check on the return value of kmemdup and passes the
error upstream.

Signed-off-by: Aditya Pakki <pakki001@umn.edu>

---
v1: Missed check on tb_sw_read, suggested by Mukesh
---
 drivers/thunderbolt/switch.c | 22 ++++++++++++++++------
 1 file changed, 16 insertions(+), 6 deletions(-)

diff --git a/drivers/thunderbolt/switch.c b/drivers/thunderbolt/switch.c
index cd96994dc094..504365d46827 100644
--- a/drivers/thunderbolt/switch.c
+++ b/drivers/thunderbolt/switch.c
@@ -1294,13 +1294,14 @@ int tb_switch_configure(struct tb_switch *sw)
 	return tb_plug_events_active(sw, true);
 }
 
-static void tb_switch_set_uuid(struct tb_switch *sw)
+static int tb_switch_set_uuid(struct tb_switch *sw)
 {
 	u32 uuid[4];
-	int cap;
+	int cap, ret;
 
+	ret = 0;
 	if (sw->uuid)
-		return;
+		return ret;
 
 	/*
 	 * The newer controllers include fused UUID as part of link
@@ -1308,7 +1309,9 @@ static void tb_switch_set_uuid(struct tb_switch *sw)
 	 */
 	cap = tb_switch_find_vse_cap(sw, TB_VSE_CAP_LINK_CONTROLLER);
 	if (cap > 0) {
-		tb_sw_read(sw, uuid, TB_CFG_SWITCH, cap + 3, 4);
+		ret = tb_sw_read(sw, uuid, TB_CFG_SWITCH, cap + 3, 4);
+		if (ret)
+			return ret;
 	} else {
 		/*
 		 * ICM generates UUID based on UID and fills the upper
@@ -1323,6 +1326,9 @@ static void tb_switch_set_uuid(struct tb_switch *sw)
 	}
 
 	sw->uuid = kmemdup(uuid, sizeof(uuid), GFP_KERNEL);
+	if (!sw->uuid)
+		ret = -ENOMEM;
+	return ret;
 }
 
 static int tb_switch_add_dma_port(struct tb_switch *sw)
@@ -1372,7 +1378,9 @@ static int tb_switch_add_dma_port(struct tb_switch *sw)
 
 	if (status) {
 		tb_sw_info(sw, "switch flash authentication failed\n");
-		tb_switch_set_uuid(sw);
+		ret = tb_switch_set_uuid(sw);
+		if (ret)
+			return ret;
 		nvm_set_auth_status(sw, status);
 	}
 
@@ -1422,7 +1430,9 @@ int tb_switch_add(struct tb_switch *sw)
 		}
 		tb_sw_dbg(sw, "uid: %#llx\n", sw->uid);
 
-		tb_switch_set_uuid(sw);
+		ret = tb_switch_set_uuid(sw);
+		if (ret)
+			return ret;
 
 		for (i = 0; i <= sw->config.max_port_number; i++) {
 			if (sw->ports[i].disabled) {
-- 
2.17.1

