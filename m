Return-Path: <SRS0=Qu8K=R7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 808EAC43381
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Mar 2019 08:09:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4DDC220700
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Mar 2019 08:09:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="uVzWOlp9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726445AbfC1IJY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Mar 2019 04:09:24 -0400
Received: from mail-yw1-f65.google.com ([209.85.161.65]:43698 "EHLO
        mail-yw1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725875AbfC1IJY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Mar 2019 04:09:24 -0400
Received: by mail-yw1-f65.google.com with SMTP id j66so14513189ywc.10
        for <linux-kernel@vger.kernel.org>; Thu, 28 Mar 2019 01:09:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=LHqLKNTIA5la1d0oaHZ8dzFklAu+FDtykMdG66fjQlU=;
        b=uVzWOlp9Q5eq141zhClpRPW9itTi6tU9zpgWNnP8zu3wyNbf1Adf0ydG2jdfBlkHQ8
         oAHoNqmlFUWgv8dgg75oUrh5ORGYzV5gy7xV7sWvBUQCFJcreYe0UnK1m7v4P0YSGm6Y
         jQD5/5NZKsjZmeQEELpeywgu19vFUk87lYT0kh4WlVQ/RkM9lMbnB5tiLvmnfBQ4oQpM
         6gXJ27hYAvCBf52b8K1h7DMQr6++M5XQZKfGeHXnRbwcyc6j67yuLfm1KGY/1D+ZiMzP
         TO8X5wuaNcQDHV8rfAkeU6hL9Ow6xcMr2yWQHaB9jc6nU700ReydTqgURWkeQ37vJXEl
         00Dw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=LHqLKNTIA5la1d0oaHZ8dzFklAu+FDtykMdG66fjQlU=;
        b=k9ApO5w6i7zK9cckCxw75Nc7DMFN8UXBpr5M0IMiIPVR5EuP9aeXBaddh8ZSlghXUt
         eEexasBguX7rKaUrWhHePP7YpBTvg5oOC/64trQyekRi7wbv2HRaqtox3S+mxZlk5wgv
         ls9ct0cbkL81P07o+ezHIZ/GmdnS5F3Xiv5ijlRxsZxtLyJnmHaOG9/InK49je2eJFFl
         DyuneHPhPZvc65fWipIeh39UPh0DrQsHCK4tv5y2rShGOUTydoEaWswbVL5LfYBWsDOU
         gCTIa1py1jbE7yaVuNNEQuVL984VFeJrABveiiMk9bmYLinwJ7rHfbvE0XATIbm3pOPo
         NXyg==
X-Gm-Message-State: APjAAAV7NclHjeL66gtTx4Krwbb4oLmt/k1LKabw5O/rClgG7ABZirQU
        7/eCVMdYH6fVNYGXzwKj5sA=
X-Google-Smtp-Source: APXvYqwfcRaUTPxq/SFoiIRr1AmlZDrEbRDMU8VqSbW8DYV7zbpIw0aJ7MhcqtqnfGKVTLHoPZt+uQ==
X-Received: by 2002:a81:2e0d:: with SMTP id u13mr34242894ywu.405.1553760563420;
        Thu, 28 Mar 2019 01:09:23 -0700 (PDT)
Received: from localhost.localdomain ([191.101.9.198])
        by smtp.gmail.com with ESMTPSA id t206sm7507063ywt.109.2019.03.28.01.09.22
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 28 Mar 2019 01:09:22 -0700 (PDT)
From:   Bo YU <tsu.yubo@gmail.com>
To:     l.stach@pengutronix.de, linux+etnaviv@armlinux.org.uk,
        christian.gmeiner@gmail.com, airlied@linux.ie, daniel@ffwll.ch,
        linux-kernel@vger.kernel.org
Cc:     Bo YU <tsu.yubo@gmail.com>, etnaviv@lists.freedesktop.org,
        dri-devel@lists.freedesktop.org, yuzibode@126.com
Subject: [PATCH v2] drm: etnaviv: fix strncpy sizeof argument
Date:   Thu, 28 Mar 2019 04:09:18 -0400
Message-Id: <20190328080918.9290-1-tsu.yubo@gmail.com>
X-Mailer: git-send-email 2.11.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Calling strncpy with a maximum size argument of 64 bytes on destination
array "domain->name" of size 64 bytes might leave the destination string
unterminated.

Detected by CoverityScan, CID# 1443992:  Memory - illegal accesses (BUFFER_SIZE_WARNING)

Fixes: 9e2c2e2730126 (drm/etnaviv: add infrastructure to query perf counter)
Signed-off-by: Bo YU <tsu.yubo@gmail.com>
---
v2: accroding to Russell's suggestion, replace strncpy with strlcpy
---
 drivers/gpu/drm/etnaviv/etnaviv_perfmon.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/etnaviv/etnaviv_perfmon.c b/drivers/gpu/drm/etnaviv/etnaviv_perfmon.c
index 4227a4006c34..ce178f23e86a 100644
--- a/drivers/gpu/drm/etnaviv/etnaviv_perfmon.c
+++ b/drivers/gpu/drm/etnaviv/etnaviv_perfmon.c
@@ -414,7 +414,7 @@ int etnaviv_pm_query_dom(struct etnaviv_gpu *gpu,
 
 	domain->id = domain->iter;
 	domain->nr_signals = dom->nr_signals;
-	strncpy(domain->name, dom->name, sizeof(domain->name));
+	strlcpy(domain->name, dom->name, sizeof(domain->name));
 
 	domain->iter++;
 	if (domain->iter == meta->nr_domains)
-- 
2.11.0

