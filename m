Return-Path: <SRS0=21RF=YY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0AB62CA9ECE
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Oct 2019 09:36:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D146D2086D
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Oct 2019 09:36:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=endlessm-com.20150623.gappssmtp.com header.i=@endlessm-com.20150623.gappssmtp.com header.b="JdLYApaH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727201AbfJaJgA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 31 Oct 2019 05:36:00 -0400
Received: from mail-pl1-f195.google.com ([209.85.214.195]:46377 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727176AbfJaJgA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Oct 2019 05:36:00 -0400
Received: by mail-pl1-f195.google.com with SMTP id q21so2449082plr.13
        for <linux-kernel@vger.kernel.org>; Thu, 31 Oct 2019 02:35:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=endlessm-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=DpBkpuyfEz89me+buFs+WwtT8XRjvBF3yFBftzqlsQk=;
        b=JdLYApaHHSdUFo4j1OUWJrbghTLy5sNyEB5YolVD7rb4pjkaCXORZ6YsgpbuJrlo/V
         tvEBmGb12tib+aqhP4RKjJlaJURPv05T12dWome0EoDMZk6g2GiuCOLpyreiYTFdP8bq
         +xMNuDjKk97ONXGcpxwQQ2atL3vymdgSlRC2fqUwrH3+/m605N+EH8wvpFfCfltDOyEh
         AlAVWF4FLDs9arQtYXkNFDNZyzLcnc68HEV4e5RUxtvpfuXI5feUTnUgM5YwuURQfidK
         W1Ct8JUM3rdyYYHN2IYoDYqXYZLhWkIn+uZ3HuSvTlU4m/K1RMEm/URF2xTfWTUYBXYx
         xciw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=DpBkpuyfEz89me+buFs+WwtT8XRjvBF3yFBftzqlsQk=;
        b=Lq0IcTiWdGosviR/jFT4lIkOYwZGd8/lYARk1JFEth/s4n2cI4DZseJYEWGeM/GFHk
         cFH/w3xflbbwgJXB3h8wbg+7/ga7gU3jSETUq557r9Vc/Ph+e97UjwS6hhZSYioknkqt
         mW1mYs1e1kic50YbuxIQZsRXw5qfdgx6xjZZVN4In3zdwFnmoYIzvxbAVJQvwukZYYf8
         DTIZHv8/WeGesWTZ/8KYfQY4IJ2G0fFxgWRUZXUH/5yrzsOZl329FjvkUFdfwda6Vrhg
         6DL4Mxq//0rb0fFLl9jCldjXCms7qDcpMVtJtfLbf2VLGcjUYTEzqZNbNRHYe7vp+2+r
         5/Ig==
X-Gm-Message-State: APjAAAU0bZebVeGnZ+WqbwRig77ZxMcwZYIgKiDb7Ru3LwSKLKk9sJBR
        +H5ZxPKZ0/9+d8UZQGoRSBbnaw==
X-Google-Smtp-Source: APXvYqwnFWHm7nPbOa+XzFm1q9aR2vjbqEZF/KUN16CVmZa8X1+clj8plDglCup4NMBtOxDqkW3Y3A==
X-Received: by 2002:a17:902:9347:: with SMTP id g7mr5320801plp.291.1572514557950;
        Thu, 31 Oct 2019 02:35:57 -0700 (PDT)
Received: from starnight.endlessm-sf.com (123-204-46-122.static.seed.net.tw. [123.204.46.122])
        by smtp.gmail.com with ESMTPSA id b23sm5240079pju.16.2019.10.31.02.35.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 31 Oct 2019 02:35:57 -0700 (PDT)
From:   Jian-Hong Pan <jian-hong@endlessm.com>
To:     Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@fb.com>,
        Christoph Hellwig <hch@lst.de>,
        Sagi Grimberg <sagi@grimberg.me>,
        Bjorn Helgaas <helgaas@kernel.org>
Cc:     linux-nvme@lists.infradead.org, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux@endlessm.com,
        Jian-Hong Pan <jian-hong@endlessm.com>, stable@vger.kernel.org
Subject: [PATCH v2] Revert "nvme: Add quirk for Kingston NVME SSD running FW E8FK11.T"
Date:   Thu, 31 Oct 2019 17:34:09 +0800
Message-Id: <20191031093408.9322-1-jian-hong@endlessm.com>
X-Mailer: git-send-email 2.23.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Since commit 253eaf4faaaa ("PCI/MSI: Fix incorrect MSI-X masking on
resume") is merged, we can revert the previous quirk now.

This reverts commit 19ea025e1d28c629b369c3532a85b3df478cc5c6.

Fixes: 19ea025e1d28 ("nvme: Add quirk for Kingston NVME SSD running FW E8FK11.T")
Buglink: https://bugzilla.kernel.org/show_bug.cgi?id=204887
Signed-off-by: Jian-Hong Pan <jian-hong@endlessm.com>
Cc: stable@vger.kernel.org
---
v2:
  Re-send for mailing failure

 drivers/nvme/host/core.c | 10 ----------
 1 file changed, 10 deletions(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index fa7ba09dca77..94bfbee1e5f7 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -2404,16 +2404,6 @@ static const struct nvme_core_quirk_entry core_quirks[] = {
 		.vid = 0x14a4,
 		.fr = "22301111",
 		.quirks = NVME_QUIRK_SIMPLE_SUSPEND,
-	},
-	{
-		/*
-		 * This Kingston E8FK11.T firmware version has no interrupt
-		 * after resume with actions related to suspend to idle
-		 * https://bugzilla.kernel.org/show_bug.cgi?id=204887
-		 */
-		.vid = 0x2646,
-		.fr = "E8FK11.T",
-		.quirks = NVME_QUIRK_SIMPLE_SUSPEND,
 	}
 };
 
-- 
2.23.0

