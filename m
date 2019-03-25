Return-Path: <SRS0=yZjE=R4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 62F4AC43381
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Mar 2019 21:25:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 34FC220848
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Mar 2019 21:25:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=umn.edu header.i=@umn.edu header.b="pv00D3Lw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730738AbfCYVZ3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Mar 2019 17:25:29 -0400
Received: from mta-p5.oit.umn.edu ([134.84.196.205]:58268 "EHLO
        mta-p5.oit.umn.edu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730199AbfCYVZ1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Mar 2019 17:25:27 -0400
Received: from localhost (unknown [127.0.0.1])
        by mta-p5.oit.umn.edu (Postfix) with ESMTP id C1E3C9D7
        for <linux-kernel@vger.kernel.org>; Mon, 25 Mar 2019 21:25:25 +0000 (UTC)
X-Virus-Scanned: amavisd-new at umn.edu
Received: from mta-p5.oit.umn.edu ([127.0.0.1])
        by localhost (mta-p5.oit.umn.edu [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id 5fmbAbsxdaS9 for <linux-kernel@vger.kernel.org>;
        Mon, 25 Mar 2019 16:25:25 -0500 (CDT)
Received: from mail-it1-f200.google.com (mail-it1-f200.google.com [209.85.166.200])
        (using TLSv1.2 with cipher AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mta-p5.oit.umn.edu (Postfix) with ESMTPS id 96CC6863
        for <linux-kernel@vger.kernel.org>; Mon, 25 Mar 2019 16:25:25 -0500 (CDT)
Received: by mail-it1-f200.google.com with SMTP id v193so3791489itv.9
        for <linux-kernel@vger.kernel.org>; Mon, 25 Mar 2019 14:25:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=umn.edu; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=3U671EtTZpOqkVrkynE1lDoal+7jnSwJUUteoPHc1Fw=;
        b=pv00D3LwTocJMAQnyQvhPSZmTEuqZdVv2wFn9aFtwjf6kp+vwgZpmqTVusBWvx+m0R
         2MqW6w8iHhayi6kYzIyuSueej6yc8fWiFlJifW96I80Ei4QMHsh58oGEIPCoJS9xpwh5
         lnDYfkEzdKs/9CtRIRtxN8a4KKgyjivQKyYc8B5gHmx/8zsvHsQvtxKVwx3AwDkeFqK4
         xMUighvm04NudQFbPW5A5K08mO3OZVYDtNFoqjjdOrGgQqnKYI1IRn5pWXvC3nUfqUN3
         PtDpXPTvSL5/s6Mgv2BKiGlLcfynAq2Yd7EKMeXxWqh4w73uO/tMCchxM1UxqWMcfZmf
         qB8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=3U671EtTZpOqkVrkynE1lDoal+7jnSwJUUteoPHc1Fw=;
        b=NF542x3Unj+hy5ec4YMf0DYPEnDs9ytBsaEJjN+02VjdCXwufszmdIcq50yvgEL/Km
         UxGSVZb2DN0FsptAfDheojceBca14lqJvTDh90OxPgqa2MWufCbjYKzlWb1HBHuJV260
         ZPyOztlYbskc/ho3LrV7Y02rKBLrGGorRNSdqBc0y2AMCw7TnmhRn47WU1SSCKIofOQm
         K5WsQfuF87tDlWNspwjX0TX/vDTtpEaAwBoxLkLz1EbjoGD5rSay0KFjX82/JdDo2LlK
         9FDGxNfSCobFwJJPMqE9jFtztKtx2nPWaoTc8JyPJrH7oYillCS9rnqsTsxLFxXWYxZ3
         FseA==
X-Gm-Message-State: APjAAAXzcj6m11RnG4VZdsFPb3Vkv+dsSZd0zVcnKnIY21CRd8CPIbl8
        BzESkCZtBpECx+rEvtkZ2lIaVQpU+KzjLX2HL/SZj4mBxt/GhipS3yLg49E2x/3IY4L35meN7nU
        bsesBa09zt3+ezf/whMwJR99attX1
X-Received: by 2002:a24:8986:: with SMTP id s128mr823600itd.165.1553549125242;
        Mon, 25 Mar 2019 14:25:25 -0700 (PDT)
X-Google-Smtp-Source: APXvYqyhB6MQ3+4APE6JP0tFjnoifp940LTAjTTMXetuXBHoRetTjhf3ybyy6UwSK/Y+ZJ4d0HUTOg==
X-Received: by 2002:a24:8986:: with SMTP id s128mr823587itd.165.1553549125056;
        Mon, 25 Mar 2019 14:25:25 -0700 (PDT)
Received: from cs-u-syssec1.dtc.umn.edu (cs-u-syssec1.cs.umn.edu. [128.101.106.66])
        by smtp.gmail.com with ESMTPSA id k18sm7878611iob.60.2019.03.25.14.25.24
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 25 Mar 2019 14:25:24 -0700 (PDT)
From:   Aditya Pakki <pakki001@umn.edu>
To:     pakki001@umn.edu
Cc:     kjlu@umn.edu, Andreas Noever <andreas.noever@gmail.com>,
        Michael Jamet <michael.jamet@intel.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Yehezkel Bernat <YehezkelShB@gmail.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v3] thunderbolt: Fix to check the return value of kmemdup
Date:   Mon, 25 Mar 2019 16:25:22 -0500
Message-Id: <20190325212523.11799-1-pakki001@umn.edu>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

uuid in add_switch is allocted via kmemdup which can fail. The patch
logs the error and cleans up the allocated memory for switch.

Signed-off-by: Aditya Pakki <pakki001@umn.edu>

---
v2: replace WARN_ONCE with tb_sw_warn, as suggested by Mika
v1: Change warn_once to return after clean up.
---
 drivers/thunderbolt/icm.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/thunderbolt/icm.c b/drivers/thunderbolt/icm.c
index e3fc920af682..8b7f9131e9d1 100644
--- a/drivers/thunderbolt/icm.c
+++ b/drivers/thunderbolt/icm.c
@@ -473,6 +473,11 @@ static void add_switch(struct tb_switch *parent_sw, u64 route,
 		goto out;
 
 	sw->uuid = kmemdup(uuid, sizeof(*uuid), GFP_KERNEL);
+	if (!sw->uuid) {
+		tb_sw_warn(sw, "cannot allocate memory for switch\n");
+		tb_switch_put(sw);
+		goto out;
+	}
 	sw->connection_id = connection_id;
 	sw->connection_key = connection_key;
 	sw->link = link;
-- 
2.17.1

