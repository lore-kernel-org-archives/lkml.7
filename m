Return-Path: <SRS0=P610=TX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2F76FC282E3
	for <linux-kernel@archiver.kernel.org>; Thu, 23 May 2019 12:51:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F3B4821019
	for <linux-kernel@archiver.kernel.org>; Thu, 23 May 2019 12:51:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nikanor-nu.20150623.gappssmtp.com header.i=@nikanor-nu.20150623.gappssmtp.com header.b="RTWvTOJu"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730925AbfEWMv5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 May 2019 08:51:57 -0400
Received: from mail-lf1-f65.google.com ([209.85.167.65]:39128 "EHLO
        mail-lf1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730840AbfEWMvz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 May 2019 08:51:55 -0400
Received: by mail-lf1-f65.google.com with SMTP id f1so4305221lfl.6
        for <linux-kernel@vger.kernel.org>; Thu, 23 May 2019 05:51:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=nikanor-nu.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=cmxGKCFyPergLFN6my5Zqlqk+0D5Lu46awJGNCLYahs=;
        b=RTWvTOJuIsuOMDqYjM8ums32pA/hz/JGZqBD17Mh/2WaYfUICKi90NVmmOaTu4A3Vr
         oWVhkqn1UhRT1yhrplmPeF2ib5RRln1nMfiDjAKzDFNmXbuj5x6KrEd+/+qtblenIIfX
         Ek3cWYtJzwr4aFvzfkf/GPnJkUl/nVVPpUC3jlm8sUMRmOKy+F7H5D55gmINVaq3fEb/
         AL4vmabWOCTuUB46lex1MjsU2zhFAO7bascxfOSB/ii8pWXrDbBoU0ZIRV8bwnPKzXbt
         dFL8TPCQ9kzSpVLV6Lcq/KHkz06SJnQ0yjhyYV4B5ItIefm+WzC+nqI15GgxKZubws/d
         5AIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=cmxGKCFyPergLFN6my5Zqlqk+0D5Lu46awJGNCLYahs=;
        b=s9sKehpz+uqLcf5ApqLqLF2PJJPtidXDYg4kGvjYQC5y72Hkg/6rst2eGxv1p1a4pV
         0EA2+/FK5DYWe7Er2kH1gNMGIOsz15L2NdsA+gubFa0KL0hlzS2YN/bwIIgQ7ioltElc
         RtocaprAbCmkwsMc30wn59thgleHqIrLCW9vYWm79hckz74ah6WigQ6qAlWnazgG2XZz
         O8qvjqWDv+NIZ2FhqNp4aBxx7EYZ9MjSYy+ajnAJseGmNpuaV+QJh3ELTTjATMPurM2V
         oRj0kRRf4CKLUlx5WY/HF5rCKpurP3FJzzieNz9z+B6DkAUlZ6abMTAQfaZRCBiSI6C+
         XJ9Q==
X-Gm-Message-State: APjAAAWw7Bx7PpmyqEdtjCPZTvSGiipa5htxuEtO4LmT7F4eNmK6sQPs
        TXx/Pp1axOvLxkHiEPM4eqLYcg==
X-Google-Smtp-Source: APXvYqzz+UTMWVRnZkCdQghH+qd6irHIR5rssJgu3cTwEzdxUXlnohTCCxg7G3eoswqgazxw1vr1Jw==
X-Received: by 2002:ac2:5935:: with SMTP id v21mr5765891lfi.117.1558615913165;
        Thu, 23 May 2019 05:51:53 -0700 (PDT)
Received: from dev.nikanor.nu (78-72-133-4-no161.tbcn.telia.com. [78.72.133.4])
        by smtp.gmail.com with ESMTPSA id c19sm5947154lfi.69.2019.05.23.05.51.52
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 23 May 2019 05:51:52 -0700 (PDT)
From:   =?UTF-8?q?Simon=20Sandstr=C3=B6m?= <simon@nikanor.nu>
To:     gregkh@linuxfoundation.org
Cc:     simon@nikanor.nu, jeremy@azazel.net, dan.carpenter@oracle.com,
        devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 7/9] staging: kpc2000: remove unnecessary braces in cell_probe.c
Date:   Thu, 23 May 2019 14:51:41 +0200
Message-Id: <20190523125143.32511-8-simon@nikanor.nu>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190523125143.32511-1-simon@nikanor.nu>
References: <20190523125143.32511-1-simon@nikanor.nu>
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
index caf48256aa2e..682d61da5369 100644
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
 
@@ -432,12 +431,10 @@ int  kp2000_probe_cores(struct kp2000_device *pcard)
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

