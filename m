Return-Path: <SRS0=Ybdz=SI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F068AC282DC
	for <linux-kernel@archiver.kernel.org>; Sat,  6 Apr 2019 12:45:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A78B02087F
	for <linux-kernel@archiver.kernel.org>; Sat,  6 Apr 2019 12:45:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Q5+e+1E8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726588AbfDFMpT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 6 Apr 2019 08:45:19 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:51927 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726404AbfDFMpT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 6 Apr 2019 08:45:19 -0400
Received: by mail-wm1-f67.google.com with SMTP id 4so9359494wmf.1
        for <linux-kernel@vger.kernel.org>; Sat, 06 Apr 2019 05:45:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=iM8HLuVEuHM1fdSaY7zF3RRQTKGJvRtx3WKPLC61vyI=;
        b=Q5+e+1E8oUr4rDdDRwoM4W56dp4R7+IopEFxgBw+a/PfTK2Vz5LsvyqG+H4aDFXJgz
         61fJiEY35XcTAtYLKXMcraUykTGwGd8jvzYf/jX6JR/oJyA98gO6ifVY9GH9eIp1bfUu
         eKLxKh6Dk8nitKMNgHXAmARNCpkUf2LOqpje9aCc8VyD9xRAyEomhARjfzgtB1oRKn2l
         /0GLm0qfqdw0PttjbQjk6+bPOkZPe4jOFZqYfwfJ9hSgVfDkgN5h0HJU1xkwcoIMdAvd
         7f66YcByslhOv4TgjYOMbcyuQJ3NArCUPSTwynXxjFcOLp7s8gRCacxsu+yubELo/D05
         jEIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=iM8HLuVEuHM1fdSaY7zF3RRQTKGJvRtx3WKPLC61vyI=;
        b=P2V0+H39GW0nn4meQBoShJL3bSysUIq+dZdWNKjzuG1jAgkf/vPlRz7fY+5ABkNIAC
         0vvbDFG9qmWCHHTHaOerDWQGvGRB71iBo6zChyuG8CCHVn21JouJSTDCzd/NK5GKl0tf
         +cX1Fz69HU2jw+MvhJZRRQIYrxC4ExH4LEyF8hOJhn5WnHUu41GK2SQZWOW5AwejoKet
         MrJf/m1J/UINoukJ+sUyP7RPDj+8iBtES1eVd348/5DYc8nNQBBXalXq1kaGF3mJ7Xet
         MvG8+amyOQNuGGXlzuQfvC7N2HFuHQnb0u+Wav9trmyOZnjHDfxgK/LzDcyQEpqowOfd
         KTEA==
X-Gm-Message-State: APjAAAW24uUZYqfHITSaW3yzoVCg6EipgcNANagGQQhuV2RnFnJ2I54A
        pbdeewhWkLXEtTcxh4w9jAUCAJhx
X-Google-Smtp-Source: APXvYqxa1W2H1pxDCI8KDDFZgt5Y9Xd2xGGuV7uTFBwW8GPCQP9pbD2v06Dk+YriXKDDuj4hfMVLMg==
X-Received: by 2002:a1c:f504:: with SMTP id t4mr10578593wmh.121.1554554716705;
        Sat, 06 Apr 2019 05:45:16 -0700 (PDT)
Received: from ogabbay-VM.habana-labs.com ([31.154.190.6])
        by smtp.gmail.com with ESMTPSA id f15sm29230576wru.21.2019.04.06.05.45.15
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 06 Apr 2019 05:45:15 -0700 (PDT)
From:   Oded Gabbay <oded.gabbay@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     gregkh@linuxfoundation.org
Subject: [PATCH 3/3] habanalabs: prevent device PTE read/write during hard-reset
Date:   Sat,  6 Apr 2019 15:45:11 +0300
Message-Id: <20190406124511.7535-3-oded.gabbay@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190406124511.7535-1-oded.gabbay@gmail.com>
References: <20190406124511.7535-1-oded.gabbay@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

During hard-reset, contexts are closed as part of the tear-down process.
After a context is closed, the driver cleans up the page tables of that
context in the device's DRAM. This action is both dangerous and
unnecessary.

It is unnecessary, because the device is going through a hard-reset, which
means the device's DRAM contents are no longer valid and the device's MMU
is being reset.

It is dangerous, because if the hard-reset came as a result of a PCI
freeze, this action may cause the entire host machine to hang.

Therefore, prevent all device PTE updates when a hard-reset operation is
pending.

Signed-off-by: Oded Gabbay <oded.gabbay@gmail.com>
---
 drivers/misc/habanalabs/goya/goya.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/misc/habanalabs/goya/goya.c b/drivers/misc/habanalabs/goya/goya.c
index 2bef21bcbe1e..bde11fc2c251 100644
--- a/drivers/misc/habanalabs/goya/goya.c
+++ b/drivers/misc/habanalabs/goya/goya.c
@@ -4057,6 +4057,9 @@ static u64 goya_read_pte(struct hl_device *hdev, u64 addr)
 {
 	struct goya_device *goya = hdev->asic_specific;
 
+	if (hdev->hard_reset_pending)
+		return U64_MAX;
+
 	return readq(hdev->pcie_bar[DDR_BAR_ID] +
 			(addr - goya->ddr_bar_cur_addr));
 }
@@ -4065,6 +4068,9 @@ static void goya_write_pte(struct hl_device *hdev, u64 addr, u64 val)
 {
 	struct goya_device *goya = hdev->asic_specific;
 
+	if (hdev->hard_reset_pending)
+		return;
+
 	writeq(val, hdev->pcie_bar[DDR_BAR_ID] +
 			(addr - goya->ddr_bar_cur_addr));
 }
-- 
2.17.1

