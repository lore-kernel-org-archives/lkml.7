Return-Path: <SRS0=lq4r=TU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 34B61C04AB4
	for <linux-kernel@archiver.kernel.org>; Mon, 20 May 2019 03:24:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F2A132082C
	for <linux-kernel@archiver.kernel.org>; Mon, 20 May 2019 03:24:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PT40jLcY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730036AbfETDYI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 19 May 2019 23:24:08 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:37977 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728932AbfETDYH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 May 2019 23:24:07 -0400
Received: by mail-pg1-f193.google.com with SMTP id j26so6056905pgl.5;
        Sun, 19 May 2019 20:24:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=8lynjc9FImYn3DS1nNlFKZK9eba4zI8O5MGLVIpLl4U=;
        b=PT40jLcY25cxWe9jUc2043282okhendavje06zKTnAmi0FzyAAAre32s7o/Pu5VMNt
         qlA+PxKsNv8lIq9PmvnJtTkWKzzESHi6HftLWRG6VrIOGSa1Zn0lRpiGuz2Q/gIBDBaE
         zsriR/4YcsTERCM3L/OBj+96aN12nZruKRSoKaa54mD/6T8wAAtkdnJ3dZHcOrhStsC5
         r+jw47uL2Y17t5IjJoJ54y7u6HcKzaCV/vMEhI7YDROcTWP3ucOIHSCR4DRL8mFcj4Jd
         k41X4OGhL+U1kkDaUb0FJcUpIUn+SBY0xDfY37SgVQ3R4tgqA5KfKbZVav45fHodZnHC
         xcSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=8lynjc9FImYn3DS1nNlFKZK9eba4zI8O5MGLVIpLl4U=;
        b=Zw+/GQyOdLyl+W9OG1259HMoC31VtVK744EpNx9JmjT0EVEUWH2gLOjmZusotodm5m
         ELSWSwNIj0yOgoW1tQ5TwOGFmhypZoKMmKFiii0l5+JtmoOXogca20A5+PRt3k5ho3il
         6t4j6sFoCx29gcyh+t2kokdCRhjeGdZPPCiSfCD6SWM0jus+BhQomTT6s3FRyZ6S6op5
         JKLcLWKbiv25vfFVjrKLJbuorw75qbx9E1vEPSZ+1FBO2fwcx5yDagW1JavlqvFEsCCx
         8lYW9R/1JJqVA0CijMH2bq6V984S3b3VbCsOSzpyCGIUys5RBFBm9cf8MDyl0kA7aB+B
         mwZw==
X-Gm-Message-State: APjAAAXE1Eb8rn/eN6mxrdiPv80YAWeUt9VdzZoEGd2y/ompbAUPnQE1
        f+S3A5tj6BCwuRxCQL5VEK0=
X-Google-Smtp-Source: APXvYqyCZT0pmKBNeTy1hX617tFwAmlnRw184XgWnkTGtOBmuOjMleyAZL2FGjRqQIQyMRsZMUyttw==
X-Received: by 2002:a62:7608:: with SMTP id r8mr76407314pfc.190.1558322647205;
        Sun, 19 May 2019 20:24:07 -0700 (PDT)
Received: from localhost ([43.224.245.181])
        by smtp.gmail.com with ESMTPSA id i7sm11977259pfo.19.2019.05.19.20.24.06
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 19 May 2019 20:24:06 -0700 (PDT)
From:   Weitao Hou <houweitaoo@gmail.com>
To:     jinpu.wang@profitbricks.com, lindar_liu@usish.com,
        jejb@linux.ibm.com, martin.petersen@oracle.com
Cc:     linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org,
        Weitao Hou <houweitaoo@gmail.com>
Subject: [PATCH] scsi: fix typos in code comments
Date:   Mon, 20 May 2019 11:24:03 +0800
Message-Id: <20190520032403.12513-1-houweitaoo@gmail.com>
X-Mailer: git-send-email 2.18.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

fix abord to abort

Signed-off-by: Weitao Hou <houweitaoo@gmail.com>
---
 drivers/scsi/pm8001/pm8001_sas.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/scsi/pm8001/pm8001_sas.c b/drivers/scsi/pm8001/pm8001_sas.c
index 88eef3b18e41..3de57c5a3299 100644
--- a/drivers/scsi/pm8001/pm8001_sas.c
+++ b/drivers/scsi/pm8001/pm8001_sas.c
@@ -1181,7 +1181,7 @@ int pm8001_query_task(struct sas_task *task)
 	return rc;
 }
 
-/*  mandatory SAM-3, still need free task/ccb info, abord the specified task */
+/*  mandatory SAM-3, still need free task/ccb info, abort the specified task */
 int pm8001_abort_task(struct sas_task *task)
 {
 	unsigned long flags;
-- 
2.18.0

