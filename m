Return-Path: <SRS0=Pa1K=VP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 535B4C76191
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Jul 2019 08:18:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 238B12173B
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Jul 2019 08:18:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HtvtQx53"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389446AbfGRISu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Jul 2019 04:18:50 -0400
Received: from mail-pl1-f193.google.com ([209.85.214.193]:34872 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726397AbfGRISu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Jul 2019 04:18:50 -0400
Received: by mail-pl1-f193.google.com with SMTP id w24so13481060plp.2;
        Thu, 18 Jul 2019 01:18:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=11mjxUgmlKpFT65Qn2eRET8NgzSw6D9B85VQzs3KMfo=;
        b=HtvtQx53myfqvYkQHosyY0m2p2GWHSgJJFqxDjRNT3U1hCs+p/fPZ89zb5atB9tEHk
         upOI07pZfj0LpeDY79dNU+aDhdiMhF2PuuZ9ecJHPFs7P6E3BGj5WWeYyuZM0Csf/Npd
         wTJq85Ysb2fGCQNjrp+6WDjrjbBonUxrMZnAdQeklgBldQHRe5jppXfpjvKKeHcB0bSt
         PkzVzGTgWBcF0I44iDTR/dLI13Iz77Iav2txppTF+8e34wwtKdz0Cea78dER1cWCLjiL
         zBrTPRwFNYIIIW0NYoH2gqsIxMjf1SbqEF1cSUJKRVh5IhW9GDveHDWeGEvcBHfQMm5z
         KvyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=11mjxUgmlKpFT65Qn2eRET8NgzSw6D9B85VQzs3KMfo=;
        b=Bak/pQjPa5hXCqo9oUSkLnNVoHCDyNip7QbC5pluWbryevJ4gMsbdhllCl8Fs2irnw
         jvK6jy9fWVMQYQnyfoWbZ30ub+4TndOke7JlbA/Wmv+eBvF9ySk8HYTDvCxNYe5Ua5rw
         vlYcAAm6cycGYtRulP1whbz++zv5K0e7sClovEvUlUXPCSI98onB/M5huKyW5tbYHWQu
         qa2kF/XJCC6YWhdVtOjLvOiGfw9j8b9s75O79EaTmLG5fmV++gqcioDoW6BkN37KVSYF
         EA7vOTKkQM10ALZTH5elAwmR6i4hc35xGXUzJ5045skXO9hCQQypHgeH6If7jArEtwG/
         9LuA==
X-Gm-Message-State: APjAAAVz9mIptoM5z6QW9zyO/Vtg/yY/KYgmzvODe7FT/gmR4dF0UPZd
        0nGALvFqPvFa4FyA2P8TLrY=
X-Google-Smtp-Source: APXvYqxQjMJEfvJGrhGFiRueAoYUztOJhNxXAleug7p9acbsgKYgBHkrzTU/a9kvRRQPAFedi8jUWg==
X-Received: by 2002:a17:902:9a42:: with SMTP id x2mr49146527plv.106.1563437929386;
        Thu, 18 Jul 2019 01:18:49 -0700 (PDT)
Received: from hfq-skylake.ipads-lab.se.sjtu.edu.cn ([202.120.40.82])
        by smtp.googlemail.com with ESMTPSA id l4sm26669847pff.50.2019.07.18.01.18.46
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 18 Jul 2019 01:18:48 -0700 (PDT)
From:   Chuhong Yuan <hslester96@gmail.com>
Cc:     QLogic-Storage-Upstream@cavium.com,
        "James E . J . Bottomley" <jejb@linux.ibm.com>,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org,
        Chuhong Yuan <hslester96@gmail.com>
Subject: [PATCH 3/3] scsi: qedf: Replace vmalloc + memset with vzalloc
Date:   Thu, 18 Jul 2019 16:18:32 +0800
Message-Id: <20190718081832.28808-1-hslester96@gmail.com>
X-Mailer: git-send-email 2.11.0
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use vzalloc instead of using vmalloc to allocate memory
and then zeroing it with memset 0.
This simplifies the code.

Signed-off-by: Chuhong Yuan <hslester96@gmail.com>
---
 drivers/scsi/qedf/qedf_dbg.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/scsi/qedf/qedf_dbg.c b/drivers/scsi/qedf/qedf_dbg.c
index e0387e495261..0d2aed82882a 100644
--- a/drivers/scsi/qedf/qedf_dbg.c
+++ b/drivers/scsi/qedf/qedf_dbg.c
@@ -106,11 +106,10 @@ qedf_dbg_info(struct qedf_dbg_ctx *qedf, const char *func, u32 line,
 int
 qedf_alloc_grc_dump_buf(u8 **buf, uint32_t len)
 {
-		*buf = vmalloc(len);
+		*buf = vzalloc(len);
 		if (!(*buf))
 			return -ENOMEM;
 
-		memset(*buf, 0, len);
 		return 0;
 }
 
-- 
2.20.1

