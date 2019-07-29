Return-Path: <SRS0=K9bG=V2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9CAF6C7618E
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jul 2019 15:14:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7482F21655
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jul 2019 15:14:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bwRQRbSz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728737AbfG2POX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Jul 2019 11:14:23 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:40410 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726197AbfG2POW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Jul 2019 11:14:22 -0400
Received: by mail-pf1-f196.google.com with SMTP id p184so28187623pfp.7
        for <linux-kernel@vger.kernel.org>; Mon, 29 Jul 2019 08:14:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ID3S8AXMaqtPd62+34tqU+I1K0sOrkCK8bonK/JaG1E=;
        b=bwRQRbSzvwE3OKuWwSi4Minic0ZtZcaBDU7DYRPLNzeTAghIwyhd55QnlibgdAPiHH
         PDQA/qN+TwhHa/4KNIh6pII9/Qs0PUwS3ctw++P88wFXXLaeFBdVIkH8jP4i15yHF23T
         2aSgUFnvF0+mmKhBn0QvmUXHXTf2IJa+6qmvJZzanVsHdrRs0WdXZgaDgdQ1ophmZB0G
         P4ocTQ3Ld+6ggzTZuSZlvoL45/xvU2ttcOtuWe0Yp0SPfrY65fZZ5uRy1fdKNXFEh+Tt
         FmT2ZAgxnM03PmaEELkpY45q6+lQkvF3sBPbpHEXU8QvmX9qlahZGIc3csRgDS68qg/D
         DOWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ID3S8AXMaqtPd62+34tqU+I1K0sOrkCK8bonK/JaG1E=;
        b=X/eEqBEzeF3TEJmhOKYFvP7aFw94nM9aOV5Oo5fG+2VMleYQxmFg0uYrC080A1H076
         /9xr8bZIp+0RK08Uf5cpom3R+i/ELs/dKlmNz0aluwJBYgBZlr75KF5ARpyTlE7ucVk0
         MVgHe01VAfg0e7oKhQh/+QY1RP/keIXb9wsLkBwQgU6uJwH4nsUeW44kgw4bHFYZSwq2
         oixY3+krtZbcGsOSVp/s6XhGubX9mGvEtidxfZkMaxQFyNFfVmgesjzkBwx6lXNiGago
         gz9NKVGxzu+8NgBnjdFQIjWKbM9Y0SAmi027NcMMSSAsi0QOJe4C6bxQFYkOR5RwtJLF
         98AA==
X-Gm-Message-State: APjAAAWa4TocMCuXUGxssB2PimiUbY+jWIY2QLmImLd5rxW7BaVCsQG4
        //FLp6sVjplwaaAkYY3hRl8=
X-Google-Smtp-Source: APXvYqyxOpnuo6B46j6hiILBzbb8bZpVvSU/EkvTH0t/U8btGjZnuqiCdoQ6+7qTGZCU2KpsQUJISA==
X-Received: by 2002:a65:6081:: with SMTP id t1mr106125219pgu.9.1564413262031;
        Mon, 29 Jul 2019 08:14:22 -0700 (PDT)
Received: from suzukaze.ipads-lab.se.sjtu.edu.cn ([89.31.126.54])
        by smtp.gmail.com with ESMTPSA id a12sm104957041pje.3.2019.07.29.08.14.19
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Mon, 29 Jul 2019 08:14:21 -0700 (PDT)
From:   Chuhong Yuan <hslester96@gmail.com>
Cc:     Christoph Hellwig <hch@lst.de>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Robin Murphy <robin.murphy@arm.com>,
        iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org,
        Chuhong Yuan <hslester96@gmail.com>
Subject: [PATCH 03/12] dma-debug: Replace strncmp with str_has_prefix
Date:   Mon, 29 Jul 2019 23:14:16 +0800
Message-Id: <20190729151416.9388-1-hslester96@gmail.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

strncmp(str, const, len) is error-prone.
We had better use newly introduced
str_has_prefix() instead of it.

Signed-off-by: Chuhong Yuan <hslester96@gmail.com>
---
 kernel/dma/debug.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/dma/debug.c b/kernel/dma/debug.c
index 099002d84f46..0f9e1aba3e1a 100644
--- a/kernel/dma/debug.c
+++ b/kernel/dma/debug.c
@@ -970,7 +970,7 @@ static __init int dma_debug_cmdline(char *str)
 	if (!str)
 		return -EINVAL;
 
-	if (strncmp(str, "off", 3) == 0) {
+	if (str_has_prefix(str, "off")) {
 		pr_info("debugging disabled on kernel command line\n");
 		global_disable = true;
 	}
-- 
2.20.1

