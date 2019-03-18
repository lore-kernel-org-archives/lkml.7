Return-Path: <SRS0=xYIU=RV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21D05C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Mar 2019 22:44:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E1E452085A
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Mar 2019 22:44:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=umn.edu header.i=@umn.edu header.b="FUnnLa4Y"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727205AbfCRWoZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Mar 2019 18:44:25 -0400
Received: from mta-p7.oit.umn.edu ([134.84.196.207]:45886 "EHLO
        mta-p7.oit.umn.edu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726809AbfCRWoY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Mar 2019 18:44:24 -0400
Received: from localhost (unknown [127.0.0.1])
        by mta-p7.oit.umn.edu (Postfix) with ESMTP id DBED66F6
        for <linux-kernel@vger.kernel.org>; Mon, 18 Mar 2019 22:44:22 +0000 (UTC)
X-Virus-Scanned: amavisd-new at umn.edu
Received: from mta-p7.oit.umn.edu ([127.0.0.1])
        by localhost (mta-p7.oit.umn.edu [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id TmmPrdc47TmQ for <linux-kernel@vger.kernel.org>;
        Mon, 18 Mar 2019 17:44:22 -0500 (CDT)
Received: from mail-io1-f72.google.com (mail-io1-f72.google.com [209.85.166.72])
        (using TLSv1.2 with cipher AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mta-p7.oit.umn.edu (Postfix) with ESMTPS id B2F01A64
        for <linux-kernel@vger.kernel.org>; Mon, 18 Mar 2019 17:44:22 -0500 (CDT)
Received: by mail-io1-f72.google.com with SMTP id u22so14767496iof.4
        for <linux-kernel@vger.kernel.org>; Mon, 18 Mar 2019 15:44:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=umn.edu; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=Gr00tDxsMLD5Uq6fmMH1LS/9W/sBJO/LhZTXCHbaVak=;
        b=FUnnLa4YZ+5GzWPA0oHTGwz2ZoQPPv2+QkRBIZB8oKLWmEM4HQukeSZlcBy0cU1nJM
         Y0WMVKn7UV2kt5WJCTyjVYJYY1k6tlrNWk6gnAsM62i3a7Lg75kK0iada1cjA/qLKcwc
         +izgToMOYczHXr3t+DuKF0A0fVS+EXWenAwDRH5zcCzCKQjyAtc7R8Lf8PR3NhI2O3hw
         HZTOmuBOUQ0TtsD1XiTMDvlwdQk6m5p9+MP8kMBTp4RDiha/HKLp9MzA3euEOwUL3Khk
         icj3LQc87UgC+MOpafrrgXdFQpodi40+luLIo60/DXWWoSo22RoCyeHgBzD6yDqVfQv0
         Nl3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=Gr00tDxsMLD5Uq6fmMH1LS/9W/sBJO/LhZTXCHbaVak=;
        b=QZGMNirTkBvhu8+hDuPkRirX3mNjDxZoNoK9aLVXvJtT3xHntvxZ5liPsRTv/LfbpH
         iewuKDh5+Al0BqZh9jm8pxCg/13LJXLEAMhd2HEEHZCfvBawxIchZar5sWeF6XB0fxWv
         aWvM+u3f/stL7CWoqwHQRGXfcT8P268b4oc3hpZeFYEz64Jwm0nsL60EcrVaqVFkqlrA
         ysvNEe1EwFi/3RVHfUavIAIeYv7OgPta10WpL0qLkcEXfr/LAgzKPOCtv+QxU9KG2tmg
         0ga9D8zLgTbydw8XddtAE+LXM8MNjWTYeLqUj5tMj4xq4mu0hW8mSZie5l6X6Xov4RLj
         GRTg==
X-Gm-Message-State: APjAAAXQT5MxVb6mwtVa178QCJZqzyYTMU8bgJJIZK6JK98e1tPLEoxq
        cSDd3s2UfEHxjv721r4+KD9SlSyhKYN56QcO+wmkYeF1ck167cmn6A52Cxc3l2PlWxQ0r1GouTy
        PY5E2EK6geGwyLzrP1dpC+34rlj5J
X-Received: by 2002:a5e:8f08:: with SMTP id c8mr12878660iok.102.1552949062368;
        Mon, 18 Mar 2019 15:44:22 -0700 (PDT)
X-Google-Smtp-Source: APXvYqzea2IxN4dux3VPilVRlXVFOwvq1YNztX0Nz9AmMb6Xp81dgDnuktcadrEFKxj0mH2o8akWOQ==
X-Received: by 2002:a5e:8f08:: with SMTP id c8mr12878652iok.102.1552949062194;
        Mon, 18 Mar 2019 15:44:22 -0700 (PDT)
Received: from lenovo-1.hsd1.mn.comcast.net (c-73-242-25-233.hsd1.mn.comcast.net. [73.242.25.233])
        by smtp.googlemail.com with ESMTPSA id k4sm460442itc.32.2019.03.18.15.44.21
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 18 Mar 2019 15:44:21 -0700 (PDT)
From:   Aditya Pakki <pakki001@umn.edu>
To:     pakki001@um.edu
Cc:     kjlu@umn.edu, Aditya Pakki <pakki001@umn.edu>,
        Andreas Noever <andreas.noever@gmail.com>,
        Michael Jamet <michael.jamet@intel.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Yehezkel Bernat <YehezkelShB@gmail.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH] thunderbolt: Fix to check for kmemdup failure
Date:   Mon, 18 Mar 2019 17:44:17 -0500
Message-Id: <20190318224417.7500-1-pakki001@umn.edu>
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
 drivers/thunderbolt/switch.c | 15 +++++++++++----
 1 file changed, 11 insertions(+), 4 deletions(-)

diff --git a/drivers/thunderbolt/switch.c b/drivers/thunderbolt/switch.c
index cd96994dc094..c05d77073ee7 100644
--- a/drivers/thunderbolt/switch.c
+++ b/drivers/thunderbolt/switch.c
@@ -1294,13 +1294,13 @@ int tb_switch_configure(struct tb_switch *sw)
 	return tb_plug_events_active(sw, true);
 }
 
-static void tb_switch_set_uuid(struct tb_switch *sw)
+static int tb_switch_set_uuid(struct tb_switch *sw)
 {
 	u32 uuid[4];
 	int cap;
 
 	if (sw->uuid)
-		return;
+		return 0;
 
 	/*
 	 * The newer controllers include fused UUID as part of link
@@ -1323,6 +1323,9 @@ static void tb_switch_set_uuid(struct tb_switch *sw)
 	}
 
 	sw->uuid = kmemdup(uuid, sizeof(uuid), GFP_KERNEL);
+	if (!sw->uuid)
+		return -ENOMEM;
+	return 0;
 }
 
 static int tb_switch_add_dma_port(struct tb_switch *sw)
@@ -1372,7 +1375,9 @@ static int tb_switch_add_dma_port(struct tb_switch *sw)
 
 	if (status) {
 		tb_sw_info(sw, "switch flash authentication failed\n");
-		tb_switch_set_uuid(sw);
+		ret = tb_switch_set_uuid(sw);
+		if (ret)
+			return ret;
 		nvm_set_auth_status(sw, status);
 	}
 
@@ -1422,7 +1427,9 @@ int tb_switch_add(struct tb_switch *sw)
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

