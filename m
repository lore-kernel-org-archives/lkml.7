Return-Path: <SRS0=J8hU=TI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B4E86C04A6B
	for <linux-kernel@archiver.kernel.org>; Wed,  8 May 2019 16:41:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 88B86216F4
	for <linux-kernel@archiver.kernel.org>; Wed,  8 May 2019 16:41:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="GcFcfdz9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728454AbfEHQlB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 May 2019 12:41:01 -0400
Received: from mail-yw1-f66.google.com ([209.85.161.66]:37243 "EHLO
        mail-yw1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727560AbfEHQk7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 May 2019 12:40:59 -0400
Received: by mail-yw1-f66.google.com with SMTP id 186so7925639ywo.4
        for <linux-kernel@vger.kernel.org>; Wed, 08 May 2019 09:40:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=Xa6DtNP/MsKA3xKlWUlfMOa1BuQnbHXWgUsbk88eqkY=;
        b=GcFcfdz920X4hAX7aP+vIaiyEOWH4ow01gaSLiNFw/lkDgzf3WlT0694nzdDi/gyFN
         Fc8v+7pLhnyHv2+P+5XPjJnwYWdmqdr85JV9OFtuv496D5IUyQgG7lZpBoCeTxt53pw7
         PXnXA/FoWK1dK4Mwg211m0vncobkAkEZctTw4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=Xa6DtNP/MsKA3xKlWUlfMOa1BuQnbHXWgUsbk88eqkY=;
        b=r3ZvKtwQvuuBJ/lxVVgg3/JEGjGXFw2qaUGOSOL1Z25lSMK2zmQmlnbDwYwJZOALem
         Hb6VDYqM4rxsOoin8+8bZ8sZQy0Uvp16rkvbvcq5bGsOWxBPcNOW3yrE84jJthOnpRhq
         QmzYf1B/cKpTDLLVKUCLWXSvj+90XtuEelj0ku9lB4knSWNmEozJN46Hy2n3Jujc4oW/
         gAXsDv9jtKwtK/CafyrzqomFMUqDh6EsvEL/ExeXyXSCRh1iMhLAabTysVQo6hgNb3/a
         VvzIWEnSNq+kMXVlrIhrKvj5eDaJxLpFTeRAStEHqRibJo4vmxcOjZjnjuj3riXFziUf
         Wd5A==
X-Gm-Message-State: APjAAAXk4b6uDlm+E0A39JVgQhK8vizePHBv2AbsLc9tNe+iiTk5V3oI
        FvgmxWtL1fKPnHGQ1RDXTGz2VQ==
X-Google-Smtp-Source: APXvYqwwQ/ZXbeVOvDJBMAyLP+sfNNNFUcrgESJuSZJO2anvG8yUMgG4YKbZW8WAbZQhc+gylFARBQ==
X-Received: by 2002:a81:2717:: with SMTP id n23mr12899509ywn.511.1557333658983;
        Wed, 08 May 2019 09:40:58 -0700 (PDT)
Received: from lbrmn-lnxub113.broadcom.net ([192.19.228.250])
        by smtp.gmail.com with ESMTPSA id u6sm4671081ywl.71.2019.05.08.09.40.56
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 08 May 2019 09:40:58 -0700 (PDT)
From:   Scott Branden <scott.branden@broadcom.com>
To:     Adrian Hunter <adrian.hunter@intel.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Ray Jui <rjui@broadcom.com>,
        Scott Branden <sbranden@broadcom.com>,
        Stefan Wahren <stefan.wahren@i2se.com>
Cc:     BCM Kernel Feedback <bcm-kernel-feedback-list@broadcom.com>,
        linux-mmc@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, Trac Hoang <trac.hoang@broadcom.com>,
        stable@vger.kernel.org, Scott Branden <scott.branden@broadcom.com>
Subject: [PATCH v2 1/2] mmc: sdhci-iproc: cygnus: Set NO_HISPD bit to fix HS50 data hold time problem
Date:   Wed,  8 May 2019 09:40:43 -0700
Message-Id: <20190508164044.22451-2-scott.branden@broadcom.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190508164044.22451-1-scott.branden@broadcom.com>
References: <20190508164044.22451-1-scott.branden@broadcom.com>
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

Cc: stable@vger.kernel.org # v4.12+
Signed-off-by: Trac Hoang <trac.hoang@broadcom.com>
Signed-off-by: Scott Branden <scott.branden@broadcom.com>
Acked-by: Adrian Hunter <adrian.hunter@intel.com>
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

