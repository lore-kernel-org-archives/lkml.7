Return-Path: <SRS0=FHjv=VA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7EB6CC06513
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Jul 2019 16:33:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 57EE4218A0
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Jul 2019 16:33:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SuR+z0zE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727303AbfGCQdE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Jul 2019 12:33:04 -0400
Received: from mail-pl1-f195.google.com ([209.85.214.195]:46816 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727074AbfGCQdD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Jul 2019 12:33:03 -0400
Received: by mail-pl1-f195.google.com with SMTP id e5so1508247pls.13
        for <linux-kernel@vger.kernel.org>; Wed, 03 Jul 2019 09:33:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=U7KSbZIhaI28wnIT5bzgBGt1Q6Og12wRpCuvNg/mCho=;
        b=SuR+z0zEL42DlQqsaZg4I77ZHO23CdkuuS0IYMLMM5r1xCGUmMXrQGfULOJS0e3C5x
         LL1OFtttNT+fGHqqnAhYDpGJ1nriG+ZdxgKfYIXHSQCz5kh2VGtkWgYdECgRGmPdiSIP
         joM+GMZO1KRAa/T8dJGAcLRwrr7gAD2d4WCb1ylDNsvVb/yvjXMWhTlD6h0S1dvbRG6U
         OVmaqQhjb9rHFunHzdTLAfkNZknlE0NvnveoqT9NbTmlgJJQU8rDNFCrZ48NsDQ75fhm
         B34cJJeuDMLJx2EocFIKZK0OhsYnXbqSvp4/9gOy/9wvxMD2WDxDXEkOSvHbhIa4Bu7s
         rIog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=U7KSbZIhaI28wnIT5bzgBGt1Q6Og12wRpCuvNg/mCho=;
        b=A0owsWLhVIvS4z8Z3V6zoe2UAnXWQd9a04Nuk/b1rUusXrTE90oEDae5oMk+DVq4dW
         CoH6D08vTCBz8OwUXh4SD5l4AyFzXGMHYNQ8GOEa0uu2UiKhGWIZzB5cZmyWHOwuNoh5
         3eoQIsAaKuyWSIKiqDQTN4QRbkanOPMhzwD+JyiaVVmz3FGxQ6UxJ021A2UpbF/2DCKz
         RtobusDH4oAlLS9hImnUSixF1YxsdjsStPZoImJK7Qg65G+GtLZxXSRUK32QU8Jtuish
         YpCCrkUEVF4PppIwcg2S9opZCt+u808VexxWmzAnMspPYzqkhVVIU2WoFdOIpUl5XDXO
         ViUg==
X-Gm-Message-State: APjAAAVz4WDx9KY6cviDKBcmac0Yyxs8Pl6VtqRAkftg19VrkYANWJWE
        AeUTpQGhr0Gg5wVnr/uHlZE=
X-Google-Smtp-Source: APXvYqwbrzW2FI+ZK5kK9MhgSRlCP5sMz7ugl/FEXCALhFLjfcVqRMbBxoh61G97a73wSChRTzwoOQ==
X-Received: by 2002:a17:902:8c83:: with SMTP id t3mr42878572plo.93.1562171583217;
        Wed, 03 Jul 2019 09:33:03 -0700 (PDT)
Received: from hfq-skylake.ipads-lab.se.sjtu.edu.cn ([202.120.40.82])
        by smtp.googlemail.com with ESMTPSA id a18sm2319954pjq.0.2019.07.03.09.32.59
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 03 Jul 2019 09:33:02 -0700 (PDT)
From:   Fuqian Huang <huangfq.daxian@gmail.com>
Cc:     Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        Liam Girdwood <liam.r.girdwood@linux.intel.com>,
        Jie Yang <yang.jie@linux.intel.com>,
        Mark Brown <broonie@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org,
        Fuqian Huang <huangfq.daxian@gmail.com>
Subject: [PATCH v2 35/35] sound/soc/intel: Use kmemdup rather than duplicating its implementation
Date:   Thu,  4 Jul 2019 00:32:51 +0800
Message-Id: <20190703163251.1075-1-huangfq.daxian@gmail.com>
X-Mailer: git-send-email 2.11.0
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

kmemdup is introduced to duplicate a region of memory in a neat way.
Rather than kmalloc/kzalloc + memcpy, which the programmer needs to
write the size twice (sometimes lead to mistakes), kmemdup improves
readability, leads to smaller code and also reduce the chances of mistakes.
Suggestion to use kmemdup rather than using kmalloc/kzalloc + memcpy.

Signed-off-by: Fuqian Huang <huangfq.daxian@gmail.com>
---
Changes in v2:
  - Fix a typo in commit message (memset -> memcpy)
  - Split into two patches

 sound/soc/intel/atom/sst/sst_loader.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/sound/soc/intel/atom/sst/sst_loader.c b/sound/soc/intel/atom/sst/sst_loader.c
index ce11c36848c4..cc95af35c060 100644
--- a/sound/soc/intel/atom/sst/sst_loader.c
+++ b/sound/soc/intel/atom/sst/sst_loader.c
@@ -288,14 +288,13 @@ static int sst_cache_and_parse_fw(struct intel_sst_drv *sst,
 {
 	int retval = 0;
 
-	sst->fw_in_mem = kzalloc(fw->size, GFP_KERNEL);
+	sst->fw_in_mem = kmemdup(fw->data, fw->size, GFP_KERNEL);
 	if (!sst->fw_in_mem) {
 		retval = -ENOMEM;
 		goto end_release;
 	}
 	dev_dbg(sst->dev, "copied fw to %p", sst->fw_in_mem);
 	dev_dbg(sst->dev, "phys: %lx", (unsigned long)virt_to_phys(sst->fw_in_mem));
-	memcpy(sst->fw_in_mem, fw->data, fw->size);
 	retval = sst_parse_fw_memcpy(sst, fw->size, &sst->memcpy_list);
 	if (retval) {
 		dev_err(sst->dev, "Failed to parse fw\n");
-- 
2.11.0

