Return-Path: <SRS0=WcLH=XI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1781C4CEC5
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Sep 2019 13:12:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 79A10214AF
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Sep 2019 13:12:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1568380344;
	bh=vGkcWfiiWQ1j7YnmnHuFuBBtdJCQ5N2mzF/sJmjPv2A=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=nGjbIwnRyWQbRqUd0c8wnPrMkjVsmafi93aw76pSoKVUaH+aXSqlQdrWqkLogHHe2
	 ufKEzA9KfA5DPpriDfV5WszmtZRYPP75bBFqoiI7YnnJYeteMvf48gJjlXDcl9ANx2
	 bKM09kY9rZAdZiQGB06zJNbN0PNiZ3XEPlL5xUoE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389135AbfIMNMX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 13 Sep 2019 09:12:23 -0400
Received: from mail.kernel.org ([198.145.29.99]:37734 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388518AbfIMNMU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Sep 2019 09:12:20 -0400
Received: from localhost (unknown [104.132.45.99])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5B2CA20640;
        Fri, 13 Sep 2019 13:12:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1568380338;
        bh=vGkcWfiiWQ1j7YnmnHuFuBBtdJCQ5N2mzF/sJmjPv2A=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=FgFyb9WNQwMXRCBiGqE1AYFS1rgRVVuVP1a4lPT8Zr2hNkKibwmiPUItQRB6n/LE4
         gvfbXvArbiaz6GoIJ3nzAqCZ3Y0EsQ0F2uPZMF/RscTIYO4ULQf0Q7BPZ4k0x/RbX/
         iOXIrf5Fs4gMZDljDMJOcsHgDDxE96J0Tpe5ea3A=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Hans Verkuil <hans.verkuil@cisco.com>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 032/190] media: cec: remove cec-edid.c
Date:   Fri, 13 Sep 2019 14:04:47 +0100
Message-Id: <20190913130602.206456160@linuxfoundation.org>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20190913130559.669563815@linuxfoundation.org>
References: <20190913130559.669563815@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[ Upstream commit f94d463f1b7f83d465ed77521821583dbcdaa3c5 ]

Move cec_get_edid_phys_addr() to cec-adap.c. It's not worth keeping
a separate source for this.

Signed-off-by: Hans Verkuil <hans.verkuil@cisco.com>
Cc: <stable@vger.kernel.org>      # for v4.17 and up
Signed-off-by: Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/media/cec/Makefile   |  2 +-
 drivers/media/cec/cec-adap.c | 13 +++++++++++++
 drivers/media/cec/cec-edid.c | 24 ------------------------
 3 files changed, 14 insertions(+), 25 deletions(-)
 delete mode 100644 drivers/media/cec/cec-edid.c

diff --git a/drivers/media/cec/Makefile b/drivers/media/cec/Makefile
index 29a2ab9e77c5d..ad8677d8c8967 100644
--- a/drivers/media/cec/Makefile
+++ b/drivers/media/cec/Makefile
@@ -1,5 +1,5 @@
 # SPDX-License-Identifier: GPL-2.0
-cec-objs := cec-core.o cec-adap.o cec-api.o cec-edid.o
+cec-objs := cec-core.o cec-adap.o cec-api.o
 
 ifeq ($(CONFIG_CEC_NOTIFIER),y)
   cec-objs += cec-notifier.o
diff --git a/drivers/media/cec/cec-adap.c b/drivers/media/cec/cec-adap.c
index a7ea27d2aa8ef..4a15d53f659ec 100644
--- a/drivers/media/cec/cec-adap.c
+++ b/drivers/media/cec/cec-adap.c
@@ -62,6 +62,19 @@ static unsigned int cec_log_addr2dev(const struct cec_adapter *adap, u8 log_addr
 	return adap->log_addrs.primary_device_type[i < 0 ? 0 : i];
 }
 
+u16 cec_get_edid_phys_addr(const u8 *edid, unsigned int size,
+			   unsigned int *offset)
+{
+	unsigned int loc = cec_get_edid_spa_location(edid, size);
+
+	if (offset)
+		*offset = loc;
+	if (loc == 0)
+		return CEC_PHYS_ADDR_INVALID;
+	return (edid[loc] << 8) | edid[loc + 1];
+}
+EXPORT_SYMBOL_GPL(cec_get_edid_phys_addr);
+
 /*
  * Queue a new event for this filehandle. If ts == 0, then set it
  * to the current time.
diff --git a/drivers/media/cec/cec-edid.c b/drivers/media/cec/cec-edid.c
deleted file mode 100644
index e2f54eec08294..0000000000000
--- a/drivers/media/cec/cec-edid.c
+++ /dev/null
@@ -1,24 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0-only
-/*
- * cec-edid - HDMI Consumer Electronics Control EDID & CEC helper functions
- *
- * Copyright 2016 Cisco Systems, Inc. and/or its affiliates. All rights reserved.
- */
-
-#include <linux/module.h>
-#include <linux/kernel.h>
-#include <linux/types.h>
-#include <media/cec.h>
-
-u16 cec_get_edid_phys_addr(const u8 *edid, unsigned int size,
-			   unsigned int *offset)
-{
-	unsigned int loc = cec_get_edid_spa_location(edid, size);
-
-	if (offset)
-		*offset = loc;
-	if (loc == 0)
-		return CEC_PHYS_ADDR_INVALID;
-	return (edid[loc] << 8) | edid[loc + 1];
-}
-EXPORT_SYMBOL_GPL(cec_get_edid_phys_addr);
-- 
2.20.1



