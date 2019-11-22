Return-Path: <SRS0=i7el=ZO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 344C5C432C0
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Nov 2019 11:05:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 017792075E
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Nov 2019 11:05:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1574420720;
	bh=aAogisomJAHBocZEBIP1KMLQHK4sE4B/orKaVsSdVfE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=2J5EOYiKs2YlA4RFosC3vbc+WvkHSvS0NbqR7lHffmRCrE6U0QyBnWEvBitmIK/cW
	 QlCem5Y2ycdadRQCri1sz+GBIb2hWzYArKOWlfBIU6j1chF7GPJe1WRsd2dibPbtwZ
	 z69NnM12J05Hp6h1CY6YnCAAwpfFlqEsm9jtPJRA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731693AbfKVLFS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Nov 2019 06:05:18 -0500
Received: from mail.kernel.org ([198.145.29.99]:60842 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731237AbfKVLFP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Nov 2019 06:05:15 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4F29620840;
        Fri, 22 Nov 2019 11:05:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1574420714;
        bh=aAogisomJAHBocZEBIP1KMLQHK4sE4B/orKaVsSdVfE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=cdZDUWX7ZwJaDeLW0QW4o+wIz//tG+Sk9N0/qrmYdO8tNAYRdddEDt9gawRU/1fVz
         O/1r6haYp8xk9qwlJTxFgLlI95PkVSUGqI6CQbZq4zqJCfCjKSu4gAzx/g4Aj+dD4V
         AkvgoQaDctjGvRj9r4muIX+Mymed8PgJ7U8g7k50=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Guenter Roeck <linux@roeck-us.net>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 200/220] hwmon: (nct6775) Fix names of DIMM temperature sources
Date:   Fri, 22 Nov 2019 11:29:25 +0100
Message-Id: <20191122100928.306823890@linuxfoundation.org>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20191122100912.732983531@linuxfoundation.org>
References: <20191122100912.732983531@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Guenter Roeck <linux@roeck-us.net>

[ Upstream commit 3be8c9d103534fadc72b3e174613f37aa19fa423 ]

For NCT6795D and NCT6796D, the DIMM temperature sources are named
"Agent[01] Dimm [01]" per datasheet. Match names in datasheets to
avoid confusion.

Signed-off-by: Guenter Roeck <linux@roeck-us.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/hwmon/nct6775.c | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/drivers/hwmon/nct6775.c b/drivers/hwmon/nct6775.c
index eba692cddbdee..559101a1c1367 100644
--- a/drivers/hwmon/nct6775.c
+++ b/drivers/hwmon/nct6775.c
@@ -704,10 +704,10 @@ static const char *const nct6795_temp_label[] = {
 	"PCH_CHIP_TEMP",
 	"PCH_CPU_TEMP",
 	"PCH_MCH_TEMP",
-	"PCH_DIM0_TEMP",
-	"PCH_DIM1_TEMP",
-	"PCH_DIM2_TEMP",
-	"PCH_DIM3_TEMP",
+	"Agent0 Dimm0",
+	"Agent0 Dimm1",
+	"Agent1 Dimm0",
+	"Agent1 Dimm1",
 	"BYTE_TEMP0",
 	"BYTE_TEMP1",
 	"PECI Agent 0 Calibration",
@@ -742,10 +742,10 @@ static const char *const nct6796_temp_label[] = {
 	"PCH_CHIP_TEMP",
 	"PCH_CPU_TEMP",
 	"PCH_MCH_TEMP",
-	"PCH_DIM0_TEMP",
-	"PCH_DIM1_TEMP",
-	"PCH_DIM2_TEMP",
-	"PCH_DIM3_TEMP",
+	"Agent0 Dimm0",
+	"Agent0 Dimm1",
+	"Agent1 Dimm0",
+	"Agent1 Dimm1",
 	"BYTE_TEMP0",
 	"BYTE_TEMP1",
 	"PECI Agent 0 Calibration",
-- 
2.20.1



