Return-Path: <SRS0=DLm5=TA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5C148C43219
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Apr 2019 11:14:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 22FEE2080C
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Apr 2019 11:14:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ingics-com.20150623.gappssmtp.com header.i=@ingics-com.20150623.gappssmtp.com header.b="0VFgT2UU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727447AbfD3LOP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Apr 2019 07:14:15 -0400
Received: from mail-pl1-f193.google.com ([209.85.214.193]:40139 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727343AbfD3LON (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Apr 2019 07:14:13 -0400
Received: by mail-pl1-f193.google.com with SMTP id b3so6556623plr.7
        for <linux-kernel@vger.kernel.org>; Tue, 30 Apr 2019 04:14:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ingics-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=93nOeDc6cG8HdR3cTlY9QFZg3HcO9zAylAua28W6fm0=;
        b=0VFgT2UUcxCZUkSZ7gjLvVH9Sq12ah3nUypogmMWUkBi20BRKTfero8EOIC2wRHPV4
         Yumo+dYpIQReJgLQlaZVxzHYpxUg58tZ6GxTTn2gN6nE4+K+3FPWRvZTI1NyYQd4oYuC
         8yvT6E+2D8x7HLXyfL5xT3LeCjO4E4Xqq3aD/P2vbk9JhR3bU/bgewlv45FuxSAuf5vF
         WFyJpDZU/G7KPO5yZpmRyr472seityG6HAX9DCAL8nfrZgEDXW9679V2RYo+AR1A7iEb
         8E7MxD0ZEex8NrqgFTJR4noKnS8LE/5xu4JqjnT2m6YzmjEzXj1G6bSW0PToyfmmNBZR
         b9tw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=93nOeDc6cG8HdR3cTlY9QFZg3HcO9zAylAua28W6fm0=;
        b=VFGjJXNrTtlEqVPjhqgajeaYZ0lTsVScljOql4HX7vW3AWb2LJpjj99H5rjEimQuDK
         hC8YBvJBkHw4HHEVL2lNWAc0U2smIa3alxMBiW8izgJduZMMlnpHE56zx6uWOiloclzm
         Ob1QpV64AJSqzZ7rtrlZupGX1fL00QxGFP2XSeqzmCf+PZ0pPzQciKJCONNLKNIp/1K/
         q6i4ssa8dVgEcV1ZIIRPVQp2Qxflvbqys/+Ve33OpERYibhaC4ZEPDHZ9biGBC8j9pJS
         Vlak6psOSGidaCHCF6Oub4N+WnZlX6Ki5aIHZL4tWFJkzKjnVNUFhk1wDFpv71wUHhOM
         b/Bg==
X-Gm-Message-State: APjAAAX0dVC1kdvASQqC+kDQIkMOYWx7IfTAC0w96GxJ4Pe+EvZzjbYx
        Z3CZ1lTE2rCV/VWSgpJTi6zeW8j/llw=
X-Google-Smtp-Source: APXvYqzx8upJKuZ/vglAUPkB7GGT5EhiN2WbZja5DOWIxrSgZchCGQhHHiiHmf2z/ZCZNJkRsmmN8A==
X-Received: by 2002:a17:902:2:: with SMTP id 2mr69281379pla.61.1556622853094;
        Tue, 30 Apr 2019 04:14:13 -0700 (PDT)
Received: from localhost.localdomain (36-239-226-61.dynamic-ip.hinet.net. [36.239.226.61])
        by smtp.gmail.com with ESMTPSA id b14sm45483887pfi.92.2019.04.30.04.14.10
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 30 Apr 2019 04:14:12 -0700 (PDT)
From:   Axel Lin <axel.lin@ingics.com>
To:     Mark Brown <broonie@kernel.org>
Cc:     Pascal Paillet <p.paillet@st.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        linux-kernel@vger.kernel.org, Axel Lin <axel.lin@ingics.com>
Subject: [PATCH 2/2] regulator: stm32-pwr: Remove unneeded .min_uV and .list_volage
Date:   Tue, 30 Apr 2019 19:13:46 +0800
Message-Id: <20190430111346.23427-2-axel.lin@ingics.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190430111346.23427-1-axel.lin@ingics.com>
References: <20190430111346.23427-1-axel.lin@ingics.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

For fixed regulator, setting .n_voltages = 1 and .fixed_uV is enough,
no need to set .min_uV and .list_volage.

Signed-off-by: Axel Lin <axel.lin@ingics.com>
---
 drivers/regulator/stm32-pwr.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/regulator/stm32-pwr.c b/drivers/regulator/stm32-pwr.c
index 8bd15e4d2cea..e0e627b0106e 100644
--- a/drivers/regulator/stm32-pwr.c
+++ b/drivers/regulator/stm32-pwr.c
@@ -102,7 +102,6 @@ static int stm32_pwr_reg_disable(struct regulator_dev *rdev)
 }
 
 static const struct regulator_ops stm32_pwr_reg_ops = {
-	.list_voltage	= regulator_list_voltage_linear,
 	.enable		= stm32_pwr_reg_enable,
 	.disable	= stm32_pwr_reg_disable,
 	.is_enabled	= stm32_pwr_reg_is_enabled,
@@ -115,7 +114,6 @@ static const struct regulator_ops stm32_pwr_reg_ops = {
 		.of_match = of_match_ptr(_name), \
 		.n_voltages = 1, \
 		.type = REGULATOR_VOLTAGE, \
-		.min_uV = _volt, \
 		.fixed_uV = _volt, \
 		.ops = &stm32_pwr_reg_ops, \
 		.enable_mask = _en, \
-- 
2.17.1

