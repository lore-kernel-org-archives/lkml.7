Return-Path: <SRS0=P610=TX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B07CC282DD
	for <linux-kernel@archiver.kernel.org>; Thu, 23 May 2019 11:36:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5B1E12133D
	for <linux-kernel@archiver.kernel.org>; Thu, 23 May 2019 11:36:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nikanor-nu.20150623.gappssmtp.com header.i=@nikanor-nu.20150623.gappssmtp.com header.b="TMvdn7xc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730617AbfEWLgn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 May 2019 07:36:43 -0400
Received: from mail-lf1-f67.google.com ([209.85.167.67]:41869 "EHLO
        mail-lf1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730536AbfEWLgj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 May 2019 07:36:39 -0400
Received: by mail-lf1-f67.google.com with SMTP id d8so4133579lfb.8
        for <linux-kernel@vger.kernel.org>; Thu, 23 May 2019 04:36:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=nikanor-nu.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=MJHlb98iV+GM9XlIrpWxfJz2ZoU6bw1KMTEUx+60/Yg=;
        b=TMvdn7xctw+9ZYYFLSHI5X0IPHuS6ULfXL6OGJpp7YKerduzsasgHRvoV8YSzH7pLi
         DcdyM0mwYfqJ2Kz1YEE2cgNhpdOlvXrpZg2+8oQFsl71kRtA4qdNY/NzxDVNaOcCBKga
         Q/h+nAe1YbMOj3z7ykwVkiWoNl/IueieBMtQZd40eROgRErJ8e1n0VkO4+hKzIG9s+xw
         WT2Tzo5YFU8LeIZ9k12syB2oChn75iFCkFHr7BRhObEfR5xZIxiTa97P8MRDjqMzCNVg
         JNlksdByIAwYwNXrSqmN7TiQVJ0TNn7Vt6K37mFbG/2tCJ3JX+9MU1W7b4dlsdb/mSXd
         eYOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=MJHlb98iV+GM9XlIrpWxfJz2ZoU6bw1KMTEUx+60/Yg=;
        b=ko/kzgeN8HEeoZBhev98gj9o4ZkBu1pr3WAj6HB0CtbpA14jsDVfTFUFsdQuOZ3zhW
         ZuTNKZ9bFRnHkvPYtPq/64X88Dh0NaK4E4Qttt4MtHE2vYMpg7p14rYrIwohsYyJhR1G
         63DTuBj8JS6djk6kbRbdB1xclyvyNyHbsOqmeOp0fRZOKH0xb1cj7yICQSTlrCQM+knX
         1UxBCmUym0EVvjsHS9RDfDrN/ZCyqeXNohnBDV9q2wXRFSokB3J4ApdcuFcl59Tl3jYm
         /kdQwyeKVRxxkbA7DKnqn5lxqc+R+nzPDom9u00liHLSmPjAMzZtoDoZAb4hdtUfE5s2
         FIng==
X-Gm-Message-State: APjAAAUiWzjIK+N1hwI5F8Rm7S8+jQBdOz0s1evaTOcCO+YI2m+IVSpd
        oyXZYBLYQf37KPALVCw2QGtrSQ==
X-Google-Smtp-Source: APXvYqyr+o5eF9TWfPRRhx6N2bZ5E0N4BNK0RwpISn93FvemTxAYrG3szTxF/4PK/BT8rFJp2EC/lQ==
X-Received: by 2002:ac2:48ad:: with SMTP id u13mr17873682lfg.60.1558611397360;
        Thu, 23 May 2019 04:36:37 -0700 (PDT)
Received: from dev.nikanor.nu (78-72-133-4-no161.tbcn.telia.com. [78.72.133.4])
        by smtp.gmail.com with ESMTPSA id d68sm5269287lfg.23.2019.05.23.04.36.36
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 23 May 2019 04:36:36 -0700 (PDT)
From:   =?UTF-8?q?Simon=20Sandstr=C3=B6m?= <simon@nikanor.nu>
To:     gregkh@linuxfoundation.org
Cc:     simon@nikanor.nu, jeremy@azazel.net, dan.carpenter@oracle.com,
        devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org
Subject: [PATCH 7/8] staging: kpc2000: remove unnecessary braces in cell_probe.c
Date:   Thu, 23 May 2019 13:36:12 +0200
Message-Id: <20190523113613.28342-8-simon@nikanor.nu>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190523113613.28342-1-simon@nikanor.nu>
References: <20190523113613.28342-1-simon@nikanor.nu>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fixes checkpatch.pl warnings "braces {} are not necessary for single
statement blocks".

Signed-off-by: Simon Sandström <simon@nikanor.nu>
---
 drivers/staging/kpc2000/kpc2000/cell_probe.c | 11 ++++-------
 1 file changed, 4 insertions(+), 7 deletions(-)

diff --git a/drivers/staging/kpc2000/kpc2000/cell_probe.c b/drivers/staging/kpc2000/kpc2000/cell_probe.c
index 8d9254db9498..b1ce1e715d9a 100644
--- a/drivers/staging/kpc2000/kpc2000/cell_probe.c
+++ b/drivers/staging/kpc2000/kpc2000/cell_probe.c
@@ -273,11 +273,10 @@ int kuio_irqcontrol(struct uio_info *uioinfo, s32 irq_on)
 
 	mutex_lock(&pcard->sem);
 	mask = readq(pcard->sysinfo_regs_base + REG_INTERRUPT_MASK);
-	if (irq_on) {
+	if (irq_on)
 		mask &= ~(1 << (kudev->cte.irq_base_num));
-	} else {
+	else
 		mask |= (1 << (kudev->cte.irq_base_num));
-	}
 	writeq(mask, pcard->sysinfo_regs_base + REG_INTERRUPT_MASK);
 	mutex_unlock(&pcard->sem);
 
@@ -433,12 +432,10 @@ int  kp2000_probe_cores(struct kp2000_device *pcard)
 		read_val = readq(pcard->sysinfo_regs_base + ((pcard->core_table_offset + i) * 8));
 		parse_core_table_entry(&cte, read_val, pcard->core_table_rev);
 		dbg_cte(pcard, &cte);
-		if (cte.type > highest_core_id) {
+		if (cte.type > highest_core_id)
 			highest_core_id = cte.type;
-		}
-		if (cte.type == KP_CORE_ID_INVALID) {
+		if (cte.type == KP_CORE_ID_INVALID)
 			dev_info(&pcard->pdev->dev, "Found Invalid core: %016llx\n", read_val);
-		}
 	}
 	// Then, iterate over the possible core types.
 	for (current_type_id = 1 ; current_type_id <= highest_core_id ; current_type_id++) {
-- 
2.20.1

