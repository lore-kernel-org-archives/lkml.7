Return-Path: <SRS0=pEez=U2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B244AC48BD7
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Jun 2019 17:43:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 831A820644
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Jun 2019 17:43:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="f+UKG+O4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727103AbfF0Rn2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Jun 2019 13:43:28 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:34104 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726561AbfF0Rn0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jun 2019 13:43:26 -0400
Received: by mail-pg1-f194.google.com with SMTP id p10so1355614pgn.1;
        Thu, 27 Jun 2019 10:43:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=5yXtCY8+SUxwVe8KOeKy/jAD6fDiQgSV/PqCOT/7qso=;
        b=f+UKG+O4/Rxj5mwHBxO2vSuKFB5Jbwqy+gAXw/tRLQ24V4c+1nRp1pK3GVV8/kunBr
         XBbE5+y+3ugm94S4HF3cyhnfzYHwKHn63wAThdv/cn/wTWK4fcWFCnjXLSWBFP76S7AQ
         v5gpeCj2430jpnMH7ycFJOgnQJUFpmGhIF2T/TP2M7YecU28G7McurxHyyqflnaBzlSP
         D4RBfB5FRfJ6+RLAbK49cbdE3kFhh+Xjrq0SUQbUMONGJBb6BlPpdoAsyfMyw3UUzbmh
         tZRzbjrHm5IUwz31ebloD3Jkmge6him6jrNznLJSskqmCM5Dm3CwYDqkN2N8kqPK+5+J
         uhMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=5yXtCY8+SUxwVe8KOeKy/jAD6fDiQgSV/PqCOT/7qso=;
        b=lOVO4LhXKBcjefWlNapLdV/H6J0Uug/mvyw8UmyiKrIFtW8yuQUNabkpbpWJfki+HB
         9N9V/7sLY374bVFFzsxEOGVCv/NHQy+RUoKAxiMolUsmYI3dBUQKE6+ww2g02uopG41s
         7tKXishjSzCdSsq99EF10sTnMKg+9HCC4jRklE7Ah3ZHhbfaD6q2Q3FHiMT+Bu+oeqj6
         1khMPuu1DuNAv50hvm4tuCL4nrxYtd4bMPzbrWV9m+xXnAT5VGSR5ly74B9hZV8+7C3j
         rHkn2XIJE7RkMXWft7oSlycHVQPRVin3UVyz1WU12gTrAUpJ6alMYM+fJD2SRtqTpiq8
         06Bw==
X-Gm-Message-State: APjAAAXgEMm+XUrolSUXynNpIoHR6aRSGYqywtHyD8BAZEF60cBQOrff
        Rv79TPJNzyxhLH30d8eRslY=
X-Google-Smtp-Source: APXvYqwXKxyNpqDNq5O1I8zhK3VRQ+kC4YusxJsOH6nHnsvGEoCXhd8/wGlKIzp3uyjhYIZxoAqZ+w==
X-Received: by 2002:a63:4518:: with SMTP id s24mr4953313pga.123.1561657405805;
        Thu, 27 Jun 2019 10:43:25 -0700 (PDT)
Received: from hfq-skylake.ipads-lab.se.sjtu.edu.cn ([202.120.40.82])
        by smtp.googlemail.com with ESMTPSA id y17sm3056052pfe.148.2019.06.27.10.43.23
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 27 Jun 2019 10:43:25 -0700 (PDT)
From:   Fuqian Huang <huangfq.daxian@gmail.com>
Cc:     Fuqian Huang <huangfq.daxian@gmail.com>,
        QLogic-Storage-Upstream@cavium.com,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 55/87] scsi: qedf: replace vmalloc and memset with vzalloc
Date:   Fri, 28 Jun 2019 01:43:15 +0800
Message-Id: <20190627174315.5042-1-huangfq.daxian@gmail.com>
X-Mailer: git-send-email 2.11.0
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

vmalloc + memset(0) -> vzalloc

Signed-off-by: Fuqian Huang <huangfq.daxian@gmail.com>
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
2.11.0

