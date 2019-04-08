Return-Path: <SRS0=N68d=SK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9CB0BC10F14
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Apr 2019 21:43:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 67E7A21841
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Apr 2019 21:43:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rYZEMZFg"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727164AbfDHVnU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Apr 2019 17:43:20 -0400
Received: from mail-lj1-f193.google.com ([209.85.208.193]:36315 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726188AbfDHVnP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Apr 2019 17:43:15 -0400
Received: by mail-lj1-f193.google.com with SMTP id r24so888106ljg.3;
        Mon, 08 Apr 2019 14:43:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ina1sug/tV7DpNodQARtmW1O98Az5HmyxzHtxFz5C9Q=;
        b=rYZEMZFg+74Q9FodscmpozPnMJuIdLHxCJndLHe2yscN20QYNhLv/YdqkTQS+tG1i4
         thcQYHx9arols07rgNbhTqeur93BE8OVhWgFYmn/pu6gF2U8Kr3ONa1kFw97n75JDlF/
         k7wq0tJS5yHvzIzsAuojmP4zHKmKBVf5bxJA3AUMiRJcx79eJCyxo8uTT9U43cL9oRYA
         8XqXQfwnGNBT9fzIGFErRQkzkDK3djby9+vo7euW3e3vwW7v1JkAHaPzBMq22biqcumC
         n4FvK9aBgth/X3uaEMBdHE+xmwNPGAaLjKuIGN2bsoRiOnzknJE7KSn5sJdIENdwqxEB
         xp1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ina1sug/tV7DpNodQARtmW1O98Az5HmyxzHtxFz5C9Q=;
        b=W8OA242bo0aP+RRg/9/1y3C2aRlGJBupnffYCAFGhSEkLBTw0odxgOf5VOX8EevIEH
         kjUE+wt5QMtSwNpZnyjGEi9YVmMGmNngBUL8ILBp2HE5ojPEuksalBtU0XnlQjq4KzKv
         PnnjVkdcoYCiJXeA84ONsqZMBme6hUIC35Q1I30zGz3MCI3XQ5km365QrjycnoDeUfTc
         CiLy8/kT0lI1Bok73kZo6oum031LzwEHjaUFnQtqtx8hYyFMnzFootD6VA7Iq3IMwLNW
         NggZUoRTJwz9qzZ2VZFQoeK5k7Gshc7fTnYw5Nv7wD+D9dC2yyBUPC2PQfv5+1ogpnkE
         biyg==
X-Gm-Message-State: APjAAAXf4XgpuuvN4IsFshFkZCy1dw8nZzfU6xnPEz7Gjl4sEJSa+Pzv
        ksjb9GqPVpeyGr838LU/yTE=
X-Google-Smtp-Source: APXvYqxUKZ8HkAowwwJVw6qY9IRGO66+uJ1o+tPgFTPL4mO4y/5S4k1evlo5zb2J0WPbkIvVRf7FYw==
X-Received: by 2002:a2e:9ec3:: with SMTP id h3mr1550336ljk.131.1554759793535;
        Mon, 08 Apr 2019 14:43:13 -0700 (PDT)
Received: from z50.gdansk-morena.vectranet.pl (109241207190.gdansk.vectranet.pl. [109.241.207.190])
        by smtp.gmail.com with ESMTPSA id j6sm5286048ljc.0.2019.04.08.14.43.12
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 08 Apr 2019 14:43:12 -0700 (PDT)
From:   Janusz Krzysztofik <jmkrzyszt@gmail.com>
To:     Mauro Carvalho Chehab <mchehab@kernel.org>
Cc:     Sakari Ailus <sakari.ailus@linux.intel.com>,
        Hans Verkuil <hans.verkuil@cisco.com>,
        linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        stable@vger.kernel.org, Janusz Krzysztofik <jmkrzyszt@gmail.com>
Subject: [PATCH 06/14] media: ov6650: Fix unverified pad IDs accepted by .get/set_selectioon()
Date:   Mon,  8 Apr 2019 23:42:34 +0200
Message-Id: <20190408214242.9603-7-jmkrzyszt@gmail.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190408214242.9603-1-jmkrzyszt@gmail.com>
References: <20190408214242.9603-1-jmkrzyszt@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit 10d5509c8d50 ("[media] v4l2: remove g/s_crop from video ops")
converted former ov6650_g/s_crop() video operation callbacks to
ov6650_get/set_selection() pad operation callbacks.  However, the new
functions don't verify correctness of pad IDs passed in user arguments.
Fix it.

Even if pad ID arguments are not actually used in those functions,
assumed to be 0, always return -EINVAL if an operation on an invalid
(non-zero) pad is requested by a user.

Fixes: 10d5509c8d50 ("[media] v4l2: remove g/s_crop from video ops")
Signed-off-by: Janusz Krzysztofik <jmkrzyszt@gmail.com>
Cc: stable@vger.kernel.org
---
 drivers/media/i2c/ov6650.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/media/i2c/ov6650.c b/drivers/media/i2c/ov6650.c
index d72fcf56930a..5df81dec06ae 100644
--- a/drivers/media/i2c/ov6650.c
+++ b/drivers/media/i2c/ov6650.c
@@ -444,6 +444,9 @@ static int ov6650_get_selection(struct v4l2_subdev *sd,
 	struct i2c_client *client = v4l2_get_subdevdata(sd);
 	struct ov6650 *priv = to_ov6650(client);
 
+	if (sel->pad)
+		return -EINVAL;
+
 	if (sel->which != V4L2_SUBDEV_FORMAT_ACTIVE)
 		return -EINVAL;
 
@@ -471,6 +474,9 @@ static int ov6650_set_selection(struct v4l2_subdev *sd,
 	struct v4l2_rect rect = sel->r;
 	int ret;
 
+	if (sel->pad)
+		return -EINVAL;
+
 	if (sel->which != V4L2_SUBDEV_FORMAT_ACTIVE ||
 	    sel->target != V4L2_SEL_TGT_CROP)
 		return -EINVAL;
-- 
2.21.0

