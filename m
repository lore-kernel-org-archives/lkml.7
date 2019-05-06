Return-Path: <SRS0=ecL9=TG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 79943C04A6B
	for <linux-kernel@archiver.kernel.org>; Mon,  6 May 2019 17:01:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 48936205ED
	for <linux-kernel@archiver.kernel.org>; Mon,  6 May 2019 17:01:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="RdGeecv8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727066AbfEFRBh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 May 2019 13:01:37 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:43027 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727021AbfEFRBg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 May 2019 13:01:36 -0400
Received: by mail-pg1-f194.google.com with SMTP id t22so6738615pgi.10
        for <linux-kernel@vger.kernel.org>; Mon, 06 May 2019 10:01:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=zm81FW3KcENXa+XgLOmWMC1Drv2h8huE0OlhIp7SLHw=;
        b=RdGeecv84dfagcFaBy4oZ8KX4YElvSCjgZ4wewEOn11JljodjvXlkDUiIVZwXtqxJ8
         SGycem6z7VwK/vXBklKJf0c5MRxBr4efE+k1J9U3I6eaHpraVQFRuTJFGElKI9V/elBe
         II6qQdUp0itHcwyvDHxXEp5ZOlY9zDetY/CDk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=zm81FW3KcENXa+XgLOmWMC1Drv2h8huE0OlhIp7SLHw=;
        b=HaopiQfNHdBaZFrXViyk7zaK9VKGfxCEARl/+P4reGLg9xzH78AYln/VQeM6Tibuz3
         nbniQQxBx6CD3GZt1M8KDuWhAGOtFBhhCUVOn5lE2bzzYN01foKDJSbwFSXtmANIeCcD
         CG3Py/qC42GR/oQ78BSyqkd3Q9daRjMFJ0NPbCRwb2AAfygwMUkbuU8Y5gzJZ3bZ20xI
         fHxTdW815on2WZg+6LuIsMyhyvCBDm+iKKqGhWD1Wa/uCZ8Eo/1WTgljlgfNY3X/eHET
         g9E8dKfyXSnw7ICRSwtBBlV+7o91CsndP7QGmDC/+u4eAJGyt3j+FCDhFJgArmFm0v4Z
         9LoA==
X-Gm-Message-State: APjAAAU2EkBhH0ImnWEqJmlFkwWZmc/W0zcIFWH232mPnNQjT1wymG/J
        eXRDrRz3nCj87OyJiAwn5hq7yw==
X-Google-Smtp-Source: APXvYqwvaQXC+Zr1EWpDHk8e2qxSkU9qk1E9SvIbRABldfphC9oNl/iAN5jE6MiK12SrGhU7LRMB3A==
X-Received: by 2002:a63:a18:: with SMTP id 24mr32875692pgk.332.1557162094885;
        Mon, 06 May 2019 10:01:34 -0700 (PDT)
Received: from lbrmn-lnxub113.broadcom.net ([192.19.228.250])
        by smtp.gmail.com with ESMTPSA id l23sm4555644pgh.68.2019.05.06.10.01.31
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 06 May 2019 10:01:34 -0700 (PDT)
From:   Scott Branden <scott.branden@broadcom.com>
To:     Adrian Hunter <adrian.hunter@intel.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Ray Jui <rjui@broadcom.com>,
        Scott Branden <sbranden@broadcom.com>,
        Stefan Wahren <stefan.wahren@i2se.com>
Cc:     BCM Kernel Feedback <bcm-kernel-feedback-list@broadcom.com>,
        linux-mmc@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, Trac Hoang <trac.hoang@broadcom.com>,
        Scott Branden <scott.branden@broadcom.com>
Subject: [PATCH 1/2] mmc: sdhci-iproc: cygnus: Set NO_HISPD bit to fix HS50 data hold time problem
Date:   Mon,  6 May 2019 10:01:14 -0700
Message-Id: <20190506170115.10840-2-scott.branden@broadcom.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190506170115.10840-1-scott.branden@broadcom.com>
References: <20190506170115.10840-1-scott.branden@broadcom.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Trac Hoang <trac.hoang@broadcom.com>

The iproc host eMMC/SD controller hold time does not meet the
specification in the HS50 mode. This problem can be mitigated
by disabling the HISPD bit; thus forcing the controller output
data to be driven on the falling clock edges rather than the
rising clock edges.

This change applies only to the Cygnus platform.

Fixes: c833e92bbb60 ("mmc: sdhci-iproc: support standard byte register accesses")
Signed-off-by: Trac Hoang <trac.hoang@broadcom.com>
Signed-off-by: Scott Branden <scott.branden@broadcom.com>
---
 drivers/mmc/host/sdhci-iproc.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/mmc/host/sdhci-iproc.c b/drivers/mmc/host/sdhci-iproc.c
index 9d12c06c7fd6..9d4071c41c94 100644
--- a/drivers/mmc/host/sdhci-iproc.c
+++ b/drivers/mmc/host/sdhci-iproc.c
@@ -196,7 +196,8 @@ static const struct sdhci_ops sdhci_iproc_32only_ops = {
 };
 
 static const struct sdhci_pltfm_data sdhci_iproc_cygnus_pltfm_data = {
-	.quirks = SDHCI_QUIRK_DATA_TIMEOUT_USES_SDCLK,
+	.quirks = SDHCI_QUIRK_DATA_TIMEOUT_USES_SDCLK |
+		  SDHCI_QUIRK_NO_HISPD_BIT,
 	.quirks2 = SDHCI_QUIRK2_ACMD23_BROKEN | SDHCI_QUIRK2_HOST_OFF_CARD_ON,
 	.ops = &sdhci_iproc_32only_ops,
 };
-- 
2.17.1

