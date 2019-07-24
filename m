Return-Path: <SRS0=3iFO=VV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5EFDFC76186
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jul 2019 03:04:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 312B82238C
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jul 2019 03:04:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LDv72/k2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726370AbfGXDEi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Jul 2019 23:04:38 -0400
Received: from mail-pl1-f194.google.com ([209.85.214.194]:42619 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725497AbfGXDEh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Jul 2019 23:04:37 -0400
Received: by mail-pl1-f194.google.com with SMTP id ay6so21410277plb.9;
        Tue, 23 Jul 2019 20:04:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=C+6xPWbKb+rzs9gL8dKhkZHnt63Mc+KjKpEAUD1XKXc=;
        b=LDv72/k2qPCZcb1tWTreRVLJ0FcFDpJC3LrkiY9RuDaY5XmspfU/00LSWgbmfu9iPK
         maRsd4A/ATKcUF9++wP6coouKh9NGaBIQStK92snWIpPv3/ZsK6vBHV9V5Arfn4+++pg
         Vdjr3ElKOgoMppqBlPR8OdspmYjEVPzt3y6oJi7yCPk77ZpfC0fEXXFHi80qfG8fsggr
         vM/kwtVXxl8qP+3DJsWTDDqEY/NHzWGoiHFtjC9nXcpkjKfC3byy4/a5lK6dw4JO52Lb
         PBqacHActl2Bu/87K9MSviBBl1pOyX2L5O1a5Uy0QFnXN7TOTmUR5kGKZ8/6jKzziJ1y
         npog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=C+6xPWbKb+rzs9gL8dKhkZHnt63Mc+KjKpEAUD1XKXc=;
        b=diTz46VKik+sv1ut/pRnd/sptI1Ui3WHqoToo0D7jalB2K9G12v+IlQhscS1/JtUCG
         ++K0vm64OuxgLBQuXBUNnE110W/ZV+jJ79Lt+uyZ3q6kUtuqm/p+31aX8LjbTI3L/ZYi
         kEodnZ6Lq1IIQ5t7XHvRl/ZJlMgb9KiMatX2TFCxlbFsjvLky1YLy7sQm5ulJ4heGOy8
         FdtW4pN87FGzbrxBZ3MT2xGgsYQdevHq8fIv++N74UckO3Xiho/I4Q2CbIYbMhA8nS8V
         +9U0/veehH3CuGxRpSDqUWalAAAMLPWJG40Na+7prOMsVyNEeBkbwT52NvbR9GAMh1gj
         l+ww==
X-Gm-Message-State: APjAAAVjsfX/hoDQ19o6KirsQlEXqOYbjb7B9q9v0BQ6ivYR/80CKGEC
        JyIFyJpqQyz7HuzKSuADxZ0=
X-Google-Smtp-Source: APXvYqxFwq/W7GEYnlkZ1NUqVfHzrdBkaAyomBjCgr+0+Pxoj3FusJY8DDE5rFWWtSTsmFcTdc0W/A==
X-Received: by 2002:a17:902:be0a:: with SMTP id r10mr78943136pls.51.1563937477077;
        Tue, 23 Jul 2019 20:04:37 -0700 (PDT)
Received: from oslab.tsinghua.edu.cn ([2402:f000:4:72:808::3ca])
        by smtp.gmail.com with ESMTPSA id k3sm30713560pgq.92.2019.07.23.20.04.35
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 23 Jul 2019 20:04:36 -0700 (PDT)
From:   Jia-Ju Bai <baijiaju1990@gmail.com>
To:     axboe@kernel.dk
Cc:     linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jia-Ju Bai <baijiaju1990@gmail.com>
Subject: [PATCH] ata: libata-core: Fix possible null-pointer dereferences in ata_host_alloc_pinfo()
Date:   Wed, 24 Jul 2019 11:04:30 +0800
Message-Id: <20190724030430.27788-1-baijiaju1990@gmail.com>
X-Mailer: git-send-email 2.17.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In ata_host_alloc_pinfo(), when ppi[j] is NULL (line 6184), pi is NULL.
In this case, pi is used on lines 6187-6195:
    ap->pio_mask = pi->pio_mask;
    ap->mwdma_mask = pi->mwdma_mask;
    ...
Thus, possible null-pointer dereferences may occur.

To fix these possible bugs, when ppi[j] is NULL, the loop continues, and
"j++" is moved to the loop's regulator.

These bugs are found by a static analysis tool STCheck written by us.

Signed-off-by: Jia-Ju Bai <baijiaju1990@gmail.com>
---
 drivers/ata/libata-core.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/ata/libata-core.c b/drivers/ata/libata-core.c
index 28c492be0a57..dabfa50dfbbe 100644
--- a/drivers/ata/libata-core.c
+++ b/drivers/ata/libata-core.c
@@ -6178,11 +6178,13 @@ struct ata_host *ata_host_alloc_pinfo(struct device *dev,
 	if (!host)
 		return NULL;
 
-	for (i = 0, j = 0, pi = NULL; i < host->n_ports; i++) {
+	for (i = 0, j = 0, pi = NULL; i < host->n_ports; i++, j++) {
 		struct ata_port *ap = host->ports[i];
 
 		if (ppi[j])
-			pi = ppi[j++];
+			pi = ppi[j];
+		else
+			continue;
 
 		ap->pio_mask = pi->pio_mask;
 		ap->mwdma_mask = pi->mwdma_mask;
-- 
2.17.0

