Return-Path: <SRS0=pEez=U2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC22BC48BD7
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Jun 2019 17:46:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 89AD32086D
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Jun 2019 17:46:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BCtDioW4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726725AbfF0Rq0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Jun 2019 13:46:26 -0400
Received: from mail-pl1-f196.google.com ([209.85.214.196]:40151 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726540AbfF0RqZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jun 2019 13:46:25 -0400
Received: by mail-pl1-f196.google.com with SMTP id a93so1688390pla.7;
        Thu, 27 Jun 2019 10:46:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=PIRPhI/UMnvi08tcprrRrj6ERaBMz8yibtguFMM+LZU=;
        b=BCtDioW4dEpvPLoJf3TTXi+A7STbvxDOR+CivoGxs1TOGswespN6j0/TugrsFlHGML
         yfWDjKKtGlTm5vC2WEKtg+6T7dtga+O7PkZhxEirr7PdSsjCnCDCqdsbVZQoJgtSYBGK
         fetg679xQIQM/WnstgMP50wgO8UmyXH95YcKQp+SFqil2yrzIFlNGrtqa0zEkqglF7I4
         rmR+oqNPfUzO4ZqX+neyoPGQObCyHrLE4jL832/5Eh53vvmua2uixAOA6H9fQXRnvNQr
         0fofAiO3i1JEC7GBqX0RpeHT9S8XHWSyhntKLc6Wo824Y0VpaUfSMyL7S5O6iZI2RkIz
         thgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=PIRPhI/UMnvi08tcprrRrj6ERaBMz8yibtguFMM+LZU=;
        b=Cnjq8weZoVU9VdQEPzhT2CyY9S4ffXuoA4dlmPDycugPsun15TssqfHOBDtHDAgTmc
         fitqOUTIpx6S/U0fNa4xAXxJ3zuUIhs4inBIjmC5JWDABeWeR1xICHPoqki4RNOHrLAY
         9wAA8YKKDhalk8m9+Ca31Mhst9x+EEqQslO/UHVGRXKcMjJ88z4Or1xTqXddS4aCF0oB
         JlzNwtVes79cO97fuv0moLXR9DgDUhQwWhcqbvjxoH3Ixtgp7/qfkCTQBhNUMR9s9ewG
         PMh/0b2ST0mJE0okO2Oisj/lTbBnpFcj4N9DYsZZrsbBIxYAd3gn0wFaPNeWEWdiKwir
         1zNA==
X-Gm-Message-State: APjAAAXxu7j+7uInNv6fNjN0NYoRzuwkxkOxeZjQXfbgFf4rmdZZrUON
        HShEDQUcJmt6Pov8uKQqoSE=
X-Google-Smtp-Source: APXvYqw17O07SCOj8UceZp3DgyEdO56/1F6KUbC0eBBxKuzwbpMiaPsKtg/aeYIyTf41ZnxkCutoFQ==
X-Received: by 2002:a17:902:8207:: with SMTP id x7mr6046456pln.63.1561657584494;
        Thu, 27 Jun 2019 10:46:24 -0700 (PDT)
Received: from hfq-skylake.ipads-lab.se.sjtu.edu.cn ([202.120.40.82])
        by smtp.googlemail.com with ESMTPSA id e188sm4453637pfh.99.2019.06.27.10.46.22
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 27 Jun 2019 10:46:24 -0700 (PDT)
From:   Fuqian Huang <huangfq.daxian@gmail.com>
Cc:     Fuqian Huang <huangfq.daxian@gmail.com>,
        Adam Radford <aradford@gmail.com>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 71/87] scsi: 3w-xxxx: remove memset after dma_alloc_coherent
Date:   Fri, 28 Jun 2019 01:46:12 +0800
Message-Id: <20190627174612.6366-1-huangfq.daxian@gmail.com>
X-Mailer: git-send-email 2.11.0
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In commit af7ddd8a627c
("Merge tag 'dma-mapping-4.21' of git://git.infradead.org/users/hch/dma-mapping"),
dma_alloc_coherent has already zeroed the memory.
So memset is not needed.

Signed-off-by: Fuqian Huang <huangfq.daxian@gmail.com>
---
 drivers/scsi/3w-9xxx.c | 2 --
 drivers/scsi/3w-xxxx.c | 2 --
 2 files changed, 4 deletions(-)

diff --git a/drivers/scsi/3w-9xxx.c b/drivers/scsi/3w-9xxx.c
index 3337b1e80412..da17d9104e6b 100644
--- a/drivers/scsi/3w-9xxx.c
+++ b/drivers/scsi/3w-9xxx.c
@@ -534,8 +534,6 @@ static int twa_allocate_memory(TW_Device_Extension *tw_dev, int size, int which)
 		goto out;
 	}
 
-	memset(cpu_addr, 0, size*TW_Q_LENGTH);
-
 	for (i = 0; i < TW_Q_LENGTH; i++) {
 		switch(which) {
 		case 0:
diff --git a/drivers/scsi/3w-xxxx.c b/drivers/scsi/3w-xxxx.c
index 2b1e0d503020..26703ef52a2e 100644
--- a/drivers/scsi/3w-xxxx.c
+++ b/drivers/scsi/3w-xxxx.c
@@ -848,8 +848,6 @@ static int tw_allocate_memory(TW_Device_Extension *tw_dev, int size, int which)
 		return 1;
 	}
 
-	memset(cpu_addr, 0, size*TW_Q_LENGTH);
-
 	for (i=0;i<TW_Q_LENGTH;i++) {
 		switch(which) {
 		case 0:
-- 
2.11.0

