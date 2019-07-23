Return-Path: <SRS0=aq1k=VU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE7CCC7618E
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jul 2019 11:10:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ACA36223A0
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jul 2019 11:10:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hOKunxsA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389267AbfGWLKz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Jul 2019 07:10:55 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:41984 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731838AbfGWLKz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Jul 2019 07:10:55 -0400
Received: by mail-pg1-f196.google.com with SMTP id t132so19256688pgb.9;
        Tue, 23 Jul 2019 04:10:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=C7BHhulFR1p2fpuSJS5AyFuCRwwQBw3M6w71QuYYn7o=;
        b=hOKunxsAnGgZZc00D/DgYI5m/ZVwEOaQgfvXavvbKxPZt4U68doqSgstSlMYIl+XfI
         dJOJY0G/IyT8hM8U7clxbH65gY8cqVh3C4c3E6ymRfpLF+GcuJbTpBkwuzy4CPGuAqK/
         CetIec+lh33EILsznyJvZGc8l93XTM1N/sajXDZebOgJCH4RiwV7hWvnxQH/DEk4rkJY
         GCA4AOBFnqeDnWSIOQa6AtW+Ck26tBSUxMaGKzpFastIkBG165E7hmy361YUViNR9Tl0
         pMDYaN/XYhvDAbYKX53LP4poE8F0O7FjWi2qBnceiNzTtm5sBs6ou4ga2mHYTTcCQ+rn
         Rs3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=C7BHhulFR1p2fpuSJS5AyFuCRwwQBw3M6w71QuYYn7o=;
        b=k1yKTaBzp65NJoCajedB4FVimmGDUJGl70uq/HllmyLK9ycb425xpk8LPIouTqlqtK
         orXFHYVohrPkzt9z1Ki1XwcukCLId89e825WV2o0g/32Nuq/ndAoR/iw6t2XZ5ej0bKd
         YvDKmbbLISO6DOt+QlJbXUQO4hChGrzMGVdoa0OnEUUV0xAqYiWxw6QSi+vGk87MhEWE
         g1WQd++PQ6K4LjIny7z/8nzL2r79MeHJMXPJvEz1RuzZNfxjL3MgxdBkLVJ8C1hOjE+w
         b1O06CEacLEpsDRNAWJDqSkniBuM7mfRjCq/rCyVvbidAp3sIKcwFHDpYS+GpuO/DuaA
         3AKQ==
X-Gm-Message-State: APjAAAU8NidzISg7vSYSvSxAWCVygTxmpUun2oaALCnrPXVK6o+oN2XL
        k+NtErpr8n6ydV+NCkuRegs=
X-Google-Smtp-Source: APXvYqx+1gTSH7WvKWtA4QtKsOjbm/zVH3YNrMgh0tTmFkg18NX61FQPz7fxfKD4bSt10xrNyI8wfA==
X-Received: by 2002:a62:e710:: with SMTP id s16mr5403082pfh.183.1563880254560;
        Tue, 23 Jul 2019 04:10:54 -0700 (PDT)
Received: from suzukaze.ipads-lab.se.sjtu.edu.cn ([89.31.126.54])
        by smtp.gmail.com with ESMTPSA id y11sm46675248pfb.119.2019.07.23.04.10.52
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Tue, 23 Jul 2019 04:10:54 -0700 (PDT)
From:   Chuhong Yuan <hslester96@gmail.com>
Cc:     Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        Jiri Kosina <jikos@kernel.org>,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>,
        linux-input@vger.kernel.org, linux-kernel@vger.kernel.org,
        Chuhong Yuan <hslester96@gmail.com>
Subject: [PATCH] HID: intel-ish-hid: Use dev_get_drvdata where possible
Date:   Tue, 23 Jul 2019 19:10:49 +0800
Message-Id: <20190723111049.11067-1-hslester96@gmail.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Instead of using to_pci_dev + pci_get_drvdata,
use dev_get_drvdata to make code simpler.

Signed-off-by: Chuhong Yuan <hslester96@gmail.com>
---
 drivers/hid/intel-ish-hid/ipc/pci-ish.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/hid/intel-ish-hid/ipc/pci-ish.c b/drivers/hid/intel-ish-hid/ipc/pci-ish.c
index aa80b4d3b740..7047c14516c9 100644
--- a/drivers/hid/intel-ish-hid/ipc/pci-ish.c
+++ b/drivers/hid/intel-ish-hid/ipc/pci-ish.c
@@ -204,8 +204,7 @@ static struct device __maybe_unused *ish_resume_device;
  */
 static void __maybe_unused ish_resume_handler(struct work_struct *work)
 {
-	struct pci_dev *pdev = to_pci_dev(ish_resume_device);
-	struct ishtp_device *dev = pci_get_drvdata(pdev);
+	struct ishtp_device *dev = dev_get_drvdata(ish_resume_device);
 	uint32_t fwsts;
 	int ret;
 
-- 
2.20.1

