Return-Path: <SRS0=OvUS=X5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BEE18C4360C
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Oct 2019 18:58:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 96A652133F
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Oct 2019 18:58:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="sO1FMEKy"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729193AbfJDS65 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 4 Oct 2019 14:58:57 -0400
Received: from mail-io1-f67.google.com ([209.85.166.67]:42790 "EHLO
        mail-io1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725775AbfJDS64 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Oct 2019 14:58:56 -0400
Received: by mail-io1-f67.google.com with SMTP id n197so15738004iod.9;
        Fri, 04 Oct 2019 11:58:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=kXHET19Vk3ufWjPl9i1yNVAiht7vLl0NnWpu74eHgeU=;
        b=sO1FMEKyJTjFPQcT+L/dKuFzkgo57xekEfRmImYpxXqhSLbLZq3myaxr0l5m+/As5I
         KVp6eO7y1xFSP0u/UB6mwbeJrItmyVT+p2yBx3+m0y0OcoC9ES0mW7gP8Iw44ntYnWdr
         L6oFVYrSst1MzUSXjmAvQTq991IE+HccFFbYQnfZ7Nv0eikSKx+7X8if/KHnx3EO4/6l
         F/5DoyS5mVYBhEdpbz9vzNXlBww+GY1oEcVvrgGvs/CerJlfs+4HA+Oe16tIuXeDC6DL
         8BmX5hI/pHpxoIluGvhNRlH/t20NqfhwtYi7/IuAISlcu7WPnfBAOcz0LQlu+d0kR6bg
         +I9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=kXHET19Vk3ufWjPl9i1yNVAiht7vLl0NnWpu74eHgeU=;
        b=jS7JqNUQRmvYj8LTTRhpdkgK4aMJpEIu76brlBNkrpdLkzbOjKYB9BvBnQW0vmWF22
         wwrC6K8t1no3owW/YKCalsvrnF5j3M6iGeoqnh4DRm9IAr58JQlrQetw7VfOA8TXq6Yu
         dvT9yJf2HEA7d1u+jEdz8drctk8VgumKv+2/7mhesoT95kLmO/AMZzOlreYQ5QsPrak5
         KbfsjolSEEfeXVwkcVpn8krJ7W/MGWL6tvZqqdcqyEF+w+K7YxL0OFUV9L56jThjH70f
         oX/OYHUTGwjxJLVf/PD6+tg5qxiS/fV+f9VL5IeO1gSUZORi8uhcelGWMZ5HFzzcWXnm
         xZMQ==
X-Gm-Message-State: APjAAAXnLHMFYubFRDEv048VVabxpbPksQ52btz6+5XduFfT85/FREho
        O1kUfx3vZ6uRX/rV8u7SH8i7bL0uEGY=
X-Google-Smtp-Source: APXvYqyPeetbm4o4ZccCpbFyoCJhYovBEFhTHkb31+QBJFPrTzJueRzkUOiLinOxqUk5c3x0b8V/Xg==
X-Received: by 2002:a02:bb8f:: with SMTP id g15mr7167749jan.110.1570215535345;
        Fri, 04 Oct 2019 11:58:55 -0700 (PDT)
Received: from cs-dulles.cs.umn.edu (cs-dulles.cs.umn.edu. [128.101.35.54])
        by smtp.googlemail.com with ESMTPSA id c8sm3377684ile.9.2019.10.04.11.58.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Oct 2019 11:58:54 -0700 (PDT)
From:   Navid Emamdoost <navid.emamdoost@gmail.com>
Cc:     emamd001@umn.edu, kjlu@umn.edu, smccaman@umn.edu,
        Navid Emamdoost <navid.emamdoost@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] of: unittest: fix memory leak in unittest_data_add
Date:   Fri,  4 Oct 2019 13:58:43 -0500
Message-Id: <20191004185847.14074-1-navid.emamdoost@gmail.com>
X-Mailer: git-send-email 2.17.1
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In unittest_data_add, a copy buffer is created via kmemdup. This buffer
is leaked if of_fdt_unflatten_tree fails. The release for the
unittest_data buffer is added.

Fixes: b951f9dc7f25 ("Enabling OF selftest to run without machine's devicetree")
Signed-off-by: Navid Emamdoost <navid.emamdoost@gmail.com>
---
 drivers/of/unittest.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/of/unittest.c b/drivers/of/unittest.c
index 480a21e2ed39..92e895d86458 100644
--- a/drivers/of/unittest.c
+++ b/drivers/of/unittest.c
@@ -1207,6 +1207,7 @@ static int __init unittest_data_add(void)
 	of_fdt_unflatten_tree(unittest_data, NULL, &unittest_data_node);
 	if (!unittest_data_node) {
 		pr_warn("%s: No tree to attach; not running tests\n", __func__);
+		kfree(unittest_data);
 		return -ENODATA;
 	}
 
-- 
2.17.1

