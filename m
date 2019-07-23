Return-Path: <SRS0=aq1k=VU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D7049C76194
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jul 2019 11:49:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B0306218A0
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jul 2019 11:49:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YQXvudmh"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387701AbfGWLt6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Jul 2019 07:49:58 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:40597 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729103AbfGWLt6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Jul 2019 07:49:58 -0400
Received: by mail-pg1-f195.google.com with SMTP id w10so19319566pgj.7;
        Tue, 23 Jul 2019 04:49:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=DGvbd2q6eGtnWqAZsNzO8Yn4NZ3NS3NJ9Bz/BH58Y+c=;
        b=YQXvudmhXOHyhL2x/1WiQQqxEMf+Cr9awQOk0uSKa0PW3zkpfkEvG+ukhVkjCv7u6S
         PG15yQbkRc97wV1/bJwd8xfn9s5dGb25jWrX8Qci3QVQJkWE1T0UtR/HWKk6JHzkt18z
         gDbmxDaPCSuqzAhpT67rYjNetdTR0QL4itRE1Dx8iSW+GL5i89gIEzaqdjH0XQY38aFB
         w2cEmQyQSHOo20dyVuoVNO7UDs3LfHFs/eshwn7a3Hrtj14KyblIVMlf9kcFAMNxRdLc
         We+Pm1wokR3Md1bg7Gk2IZJ2Pe7jkhdfhhY5WUssXvc43deigQ1zcszBT9SXbg779A3g
         QTJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=DGvbd2q6eGtnWqAZsNzO8Yn4NZ3NS3NJ9Bz/BH58Y+c=;
        b=lkKMAf571eEa8rdXFzZto2q/9+PJGgVoyZtNom5FhbACt/QNK8/2Z8UpSrU1i1GzOo
         6kUaRwbUn4fffZHTUu5NJYfvoQQWBTeTjDCmaqN7WE4rpli8oCbEAulgf/LidzPplHJ/
         25+lHT9NuphPwh62JaaSH2OKsw68dJErEMEpUanr9lm7my2XH82BYr3CzcA6sLOhG3VW
         frjg9Ay0CMiFfz8O/vWhRUtojCzaXvyI4qo086eLdk8xvEShby/cr3KlJpRHobCdZnnv
         BXlYNe59NPkm6+CwDIhYhBytDbxX7hewaqFGapVdUTTmNhNLvuhVSupkTALfpug3doXW
         lbYw==
X-Gm-Message-State: APjAAAXc0C/oAIZIQ2aqed+N5vgJ6TRtTpdUotv3STTjeHRhXFv70180
        f0xv5KZtjdG6AaCiIH8PpIU=
X-Google-Smtp-Source: APXvYqz+ywXLdq7r79WSZpl2EnS/xxpoiuDtZ47hComJ7Gc+pjlazHcIOeIvSdu2h1TWB6LLmdsoBg==
X-Received: by 2002:a17:90a:26e4:: with SMTP id m91mr82196367pje.93.1563882597619;
        Tue, 23 Jul 2019 04:49:57 -0700 (PDT)
Received: from suzukaze.ipads-lab.se.sjtu.edu.cn ([89.31.126.54])
        by smtp.gmail.com with ESMTPSA id s5sm16985795pfm.97.2019.07.23.04.49.55
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Tue, 23 Jul 2019 04:49:57 -0700 (PDT)
From:   Chuhong Yuan <hslester96@gmail.com>
Cc:     "David S . Miller" <davem@davemloft.net>,
        linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org,
        Chuhong Yuan <hslester96@gmail.com>
Subject: [PATCH] ide: Use dev_get_drvdata where possible
Date:   Tue, 23 Jul 2019 19:49:52 +0800
Message-Id: <20190723114952.18483-1-hslester96@gmail.com>
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
 drivers/ide/siimage.c   | 3 +--
 drivers/ide/via82cxxx.c | 3 +--
 2 files changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/ide/siimage.c b/drivers/ide/siimage.c
index 57eea5a9047f..c4b20f350b84 100644
--- a/drivers/ide/siimage.c
+++ b/drivers/ide/siimage.c
@@ -648,8 +648,7 @@ static void sil_quirkproc(ide_drive_t *drive)
 
 static void init_iops_siimage(ide_hwif_t *hwif)
 {
-	struct pci_dev *dev = to_pci_dev(hwif->dev);
-	struct ide_host *host = pci_get_drvdata(dev);
+	struct ide_host *host = dev_get_drvdata(hwif->dev);
 
 	hwif->hwif_data = NULL;
 
diff --git a/drivers/ide/via82cxxx.c b/drivers/ide/via82cxxx.c
index 977cb00398b0..63a3aca506fc 100644
--- a/drivers/ide/via82cxxx.c
+++ b/drivers/ide/via82cxxx.c
@@ -175,8 +175,7 @@ static void via_set_speed(ide_hwif_t *hwif, u8 dn, struct ide_timing *timing)
 static void via_set_drive(ide_hwif_t *hwif, ide_drive_t *drive)
 {
 	ide_drive_t *peer = ide_get_pair_dev(drive);
-	struct pci_dev *dev = to_pci_dev(hwif->dev);
-	struct ide_host *host = pci_get_drvdata(dev);
+	struct ide_host *host = dev_get_drvdata(hwif->dev);
 	struct via82cxxx_dev *vdev = host->host_priv;
 	struct ide_timing t, p;
 	unsigned int T, UT;
-- 
2.20.1

