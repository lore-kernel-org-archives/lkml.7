Return-Path: <SRS0=2Nly=TJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 61E87C04AB1
	for <linux-kernel@archiver.kernel.org>; Thu,  9 May 2019 17:24:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2D9902084E
	for <linux-kernel@archiver.kernel.org>; Thu,  9 May 2019 17:24:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="NLbenTRu"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726858AbfEIRYp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 May 2019 13:24:45 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:44476 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726806AbfEIRYk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 May 2019 13:24:40 -0400
Received: by mail-pf1-f193.google.com with SMTP id g9so1650863pfo.11
        for <linux-kernel@vger.kernel.org>; Thu, 09 May 2019 10:24:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=Wx8gaoHC5MOYV389XtnYNdY7stPe/BwS11WRGJ3X0jU=;
        b=NLbenTRuAo/KwttyYdSfiYeHTl8s02uccdxHkJwJLM2aY7TwvWQqlzRs0z8yANQP8R
         khMAKyxuFZJpgqgeNYGcHLqu5JE1xjX9RHiBh3YBz9oyDSgkjkxUuCIXX01cR7/10nQI
         rodbcT1oFhD5khMY98DrmTSlWUYOKTkyTYnlE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=Wx8gaoHC5MOYV389XtnYNdY7stPe/BwS11WRGJ3X0jU=;
        b=Z+aVTOiRxHAFifj+11abTZeBaJdrkpSp/Sz8/YDejzGFNCD9cqWOgOk6nD0YQhSeot
         K7D1N2PqblCu09BuP5w/ZeHFkM/PLMvbiBSxOW+NMCrFDsPkW4yUZXtAEvF8+7ONGA4Z
         1tE6t0D6H8xH3Glba2+FD/FpLRzcuhy7/yz+6K8CZG+tyNsE4+x750zx0dRux85Gn0ym
         Wjqzq8nBuhKFNoO5fmRkBJ0Zd0Ofy4IHm9ApU6+uf84eNj0zf1C5wzFcrG3vv3NbE5Do
         BSvBWOrCKPXp5MZB46R9XK7pqOjpaPHO3OYnKCU2mhwp07tNILm++TtYcrm5HbFkmt9t
         eJ4g==
X-Gm-Message-State: APjAAAVlE7/T2R609pp1r9FtQSOlY4Yh4Srnn3Pr4Jfrk4Wkc5e5vkbN
        UqF+HDd/H/W69My1DRG8awjl0Q==
X-Google-Smtp-Source: APXvYqwYqy8L9x/EoYgEU/4wY9WEr7lylwmLPU9640H1GKytWxa+mGBeQ/ZgM4Ryo2yw8qrfa7yERw==
X-Received: by 2002:aa7:9116:: with SMTP id 22mr6898551pfh.165.1557422679753;
        Thu, 09 May 2019 10:24:39 -0700 (PDT)
Received: from lbrmn-lnxub113.broadcom.net ([192.19.228.250])
        by smtp.gmail.com with ESMTPSA id m8sm3989699pgn.59.2019.05.09.10.24.37
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 09 May 2019 10:24:39 -0700 (PDT)
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
Subject: [PATCH v3 2/2] mmc: sdhci-iproc: Set NO_HISPD bit to fix HS50 data hold time problem
Date:   Thu,  9 May 2019 10:24:27 -0700
Message-Id: <20190509172427.17835-3-scott.branden@broadcom.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190509172427.17835-1-scott.branden@broadcom.com>
References: <20190509172427.17835-1-scott.branden@broadcom.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Trac Hoang <trac.hoang@broadcom.com>

The iproc host eMMC/SD controller hold time does not meet the
specification in the HS50 mode.  This problem can be mitigated
by disabling the HISPD bit; thus forcing the controller output
data to be driven on the falling clock edges rather than the
rising clock edges.

Stable tag (v4.12+) chosen to assist stable kernel maintainers so that
the change does not produce merge conflicts backporting to older kernel
versions. In reality, the timing bug existed since the driver was first
introduced but there is no need for this driver to be supported in kernel
versions that old.

Cc: stable@vger.kernel.org # v4.12+
Signed-off-by: Trac Hoang <trac.hoang@broadcom.com>
Signed-off-by: Scott Branden <scott.branden@broadcom.com>
Acked-by: Adrian Hunter <adrian.hunter@intel.com>
---
 drivers/mmc/host/sdhci-iproc.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/mmc/host/sdhci-iproc.c b/drivers/mmc/host/sdhci-iproc.c
index 9d4071c41c94..2feb4ef32035 100644
--- a/drivers/mmc/host/sdhci-iproc.c
+++ b/drivers/mmc/host/sdhci-iproc.c
@@ -220,7 +220,8 @@ static const struct sdhci_iproc_data iproc_cygnus_data = {
 
 static const struct sdhci_pltfm_data sdhci_iproc_pltfm_data = {
 	.quirks = SDHCI_QUIRK_DATA_TIMEOUT_USES_SDCLK |
-		  SDHCI_QUIRK_MULTIBLOCK_READ_ACMD12,
+		  SDHCI_QUIRK_MULTIBLOCK_READ_ACMD12 |
+		  SDHCI_QUIRK_NO_HISPD_BIT,
 	.quirks2 = SDHCI_QUIRK2_ACMD23_BROKEN,
 	.ops = &sdhci_iproc_ops,
 };
-- 
2.17.1

