Return-Path: <SRS0=lMFC=TN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 131C7C04AA7
	for <linux-kernel@archiver.kernel.org>; Mon, 13 May 2019 10:27:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D628221473
	for <linux-kernel@archiver.kernel.org>; Mon, 13 May 2019 10:27:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="h0OBTYFr"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728342AbfEMK1S (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 13 May 2019 06:27:18 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:35932 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727132AbfEMK1Q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 May 2019 06:27:16 -0400
Received: by mail-pf1-f195.google.com with SMTP id v80so6976564pfa.3
        for <linux-kernel@vger.kernel.org>; Mon, 13 May 2019 03:27:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=kAtmxaN6VL8SaJjLVBAIa2oOTmks0i73BjWVVNPw1co=;
        b=h0OBTYFrrYnkwJ7tmLK1zCJdRKwMLmvRflQHkiA4fdS9QTn0F+HSX5o+czHd6lKUsW
         aLrCGJmIpBju44J+nBAAzZlKmSaiBrJg4QensONmvuEIUCVpkhzZxvDQXKvAzGGxBTll
         9l7W4iLeZZnpK1ZbVrUPW5Ipe/ms2A7w2aqs4TTCZMerw8f2tcPP7EzvRldkWq8fenCn
         jYSeP0+I8kbO0ovJ3FMvsLBS34E9OfAOkMR2InNg7tmZFkYVbIZmSXYRj8mtnof9UmCI
         MA7DmRgnSPhvl01i9J6i4tR5Q1dKMek7CG8KiPiQyP1wcuOSUxn6f21h7s+qc55B6nS6
         Eugw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=kAtmxaN6VL8SaJjLVBAIa2oOTmks0i73BjWVVNPw1co=;
        b=P5UyQ2kDLNOUjoL4OavBC1/vnzyDXwj6SktzCJwbWBW/OiLe8suDzzRHuuNHfQJKoc
         wyuQUvMYAPhSeDl4I2CkkfYrhHqcjPvc1RTP9pk420p0FZmhmSZg0w0ekOs2fkt3WqcE
         iPGOto0KkOKQTzZFXCOu59UOswKUXUAkKwiBj010gl2dHSAa+PjUxB3/kfEegLcWFSou
         2H+7EIeX5VJ3s3xnTHKlfh+u92mSHVO7BnH9wxDvDpTq+RhDVITlUNOmajrNyhj78Ucv
         1BrNtpCkzVxIXmAyaPgBBHRJl1pfbwx5dFuEvFFu0wdOi66i7E+mHgKgH9+Gklqt8BRD
         mMwA==
X-Gm-Message-State: APjAAAUBZJwTUHNilexqWex/vhvP2Q9mEs1CX61lFCQXFO9I5PbJTy4d
        ++L/WCU27NUxF6fk1kTG+lc=
X-Google-Smtp-Source: APXvYqzAkgyb1cqJZ6kvmvZ/AQINiOwFDYwBRdl+cQCKLWIHd5wVqzP6rHfQD0tk8DkNlpSHS5UGXw==
X-Received: by 2002:a63:4852:: with SMTP id x18mr16356386pgk.14.1557743235990;
        Mon, 13 May 2019 03:27:15 -0700 (PDT)
Received: from bnva-HP-Pavilion-g6-Notebook-PC.domain.name ([117.248.72.152])
        by smtp.gmail.com with ESMTPSA id r124sm11773487pgr.91.2019.05.13.03.27.12
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 13 May 2019 03:27:15 -0700 (PDT)
From:   Vandana BN <bnvandana@gmail.com>
To:     gregkh@linuxfoundation.org, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org, lukas.bulwahn@gmail.com
Cc:     skhan@linuxfoundation.org,
        linux-kernel-mentees@lists.linuxfoundation.org,
        Vandana BN <bnvandana@gmail.com>
Subject: [PATCH v3 5/8] Staging: kpc2000: kpc_dma: Resolve checkpath errors Macros in paranthesis & trailing statements on next line.
Date:   Mon, 13 May 2019 15:56:19 +0530
Message-Id: <20190513102622.22398-5-bnvandana@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190513102622.22398-1-bnvandana@gmail.com>
References: <20190510193833.1051-1-bnvandana@gmail.com>
 <20190513102622.22398-1-bnvandana@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch fixes below errors reported by checkpath
ERROR: Macros with complex values should be enclosed in parentheses
CHECK: Prefer using the BIT macro
ERROR: trailing statements should be on next line
ERROR: trailing statements should be on next line
---
v2 - split changes to multiple patches
v3 - edit commit message
---

Signed-off-by: Vandana BN <bnvandana@gmail.com>
---
 drivers/staging/kpc2000/kpc_dma/kpc_dma_driver.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/drivers/staging/kpc2000/kpc_dma/kpc_dma_driver.c b/drivers/staging/kpc2000/kpc_dma/kpc_dma_driver.c
index 0b8dcf046136..e996ced77bd6 100644
--- a/drivers/staging/kpc2000/kpc_dma/kpc_dma_driver.c
+++ b/drivers/staging/kpc2000/kpc_dma/kpc_dma_driver.c
@@ -14,7 +14,7 @@ MODULE_LICENSE("GPL");
 MODULE_AUTHOR("Matt.Sickler@daktronics.com");
 
 #define KPC_DMA_CHAR_MAJOR    UNNAMED_MAJOR
-#define KPC_DMA_NUM_MINORS    1 << MINORBITS
+#define KPC_DMA_NUM_MINORS    BIT(MINORBITS)
 static DEFINE_MUTEX(kpc_dma_mtx);
 static int assigned_major_num;
 static LIST_HEAD(kpc_dma_list);
@@ -55,9 +55,11 @@ static ssize_t  show_engine_regs(struct device *dev, struct device_attribute *at
 {
 	struct kpc_dma_device *ldev;
 	struct platform_device *pldev = to_platform_device(dev);
-	if (!pldev) return 0;
+	if (!pldev)
+		return 0;
 	ldev = platform_get_drvdata(pldev);
-	if (!ldev) return 0;
+	if (!ldev)
+		return 0;
 
 	return scnprintf(buf, PAGE_SIZE,
 		"EngineControlStatus      = 0x%08x\n"
-- 
2.17.1

