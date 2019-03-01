Return-Path: <SRS0=6SCO=RE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51D2FC43381
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Mar 2019 19:21:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1D54020857
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Mar 2019 19:21:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="dccVq6fx"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726029AbfCATVL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 1 Mar 2019 14:21:11 -0500
Received: from mail-pg1-f196.google.com ([209.85.215.196]:45341 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725290AbfCATVK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Mar 2019 14:21:10 -0500
Received: by mail-pg1-f196.google.com with SMTP id y4so11853776pgc.12
        for <linux-kernel@vger.kernel.org>; Fri, 01 Mar 2019 11:21:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Bh+ETkiiTEM9DPgPs93YJIIhntvj0zOxzHrzRn9ZNlU=;
        b=dccVq6fxyimPdbeOmAtQvmhKQ0MMgagJpcj3brz9S8hcAXo5IGGpIwch1KBWroCQ/V
         K2272JJRrnbE/6yPe7P67EeVmIOckulUJ6UHh5xbPGbUoAviTnIq2Ws14iw/YRRGlDCT
         pRkM/zBJW37Ig+sSW1XKjj+RdlQo91eSWd7GM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Bh+ETkiiTEM9DPgPs93YJIIhntvj0zOxzHrzRn9ZNlU=;
        b=lH22p568u5mHDmh6RkXfolnLTgv+U6cFAY/qQL97cJDeBtdZdDRJRpVQPFdBoTG69x
         aCo8EmsuQahq5s7gstYWe86EBzvXsHl1VAZModvg0x9bicvdh/wTYhgnLPyy5drEYSfL
         3l3nW+o1mwZjB7jb3Gd6rtSNBjezfAC4nuDditBATvnyPdEHdD/j+BtypmFy9IGlrPA+
         gIFoafkcybPIq5wuDttIp2myU2xDzLZuyaESAXGNpEFSqEmZNPpLBQyOVBEkYZ0z64JX
         AE3em/KBHFQ4ddhcXfFtAMbsHMRbe4vp4PqN8e4AAoKeHHoh0FI3kswK+wTDByjKiE2e
         +mVQ==
X-Gm-Message-State: APjAAAWIM2mKtwiSokYZ2b7db2kcmZBh2xMtOeAKSxRaS4MxI6+RHqzU
        207b4BcBFHG+H6+K4YOvHKmFbg==
X-Google-Smtp-Source: APXvYqyvLKfHxCAc3Nsh/lmDYeMe4nake8xavMDr3WoP619cLGHLKkNe8zwTFwA07FePN6Mla2906g==
X-Received: by 2002:a65:4147:: with SMTP id x7mr6409494pgp.54.1551468069411;
        Fri, 01 Mar 2019 11:21:09 -0800 (PST)
Received: from tictac2.mtv.corp.google.com ([2620:15c:202:1:24fa:e766:52c9:e3b2])
        by smtp.gmail.com with ESMTPSA id e9sm45176866pfh.42.2019.03.01.11.21.08
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 01 Mar 2019 11:21:08 -0800 (PST)
From:   Douglas Anderson <dianders@chromium.org>
To:     Joerg Roedel <joro@8bytes.org>, Will Deacon <will.deacon@arm.com>,
        Robin Murphy <robin.murphy@arm.com>
Cc:     linux-arm-msm@vger.kernel.org,
        Vivek Gautam <vivek.gautam@codeaurora.org>,
        Rob Clark <robdclark@gmail.com>, evgreen@chromium.org,
        tfiga@chromium.org, Douglas Anderson <dianders@chromium.org>,
        linux-kernel@vger.kernel.org, iommu@lists.linux-foundation.org,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH v2] iommu/arm-smmu: Break insecure users by disabling bypass by default
Date:   Fri,  1 Mar 2019 11:20:17 -0800
Message-Id: <20190301192017.39770-1-dianders@chromium.org>
X-Mailer: git-send-email 2.21.0.352.gf09ad66450-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If you're bisecting why your peripherals stopped working, it's
probably this CL.  Specifically if you see this in your dmesg:
  Unexpected global fault, this could be serious
...then it's almost certainly this CL.

Running your IOMMU-enabled peripherals with the IOMMU in bypass mode
is insecure and effectively disables the protection they provide.
There are few reasons to allow unmatched stream bypass, and even fewer
good ones.

This patch starts the transition over to make it much harder to run
your system insecurely.  Expected steps:

1. By default disable bypass (so anyone insecure will notice) but make
   it easy for someone to re-enable bypass with just a KConfig change.
   That's this patch.

2. After people have had a little time to come to grips with the fact
   that they need to set their IOMMUs properly and have had time to
   dig into how to do this, the KConfig will be eliminated and bypass
   will simply be disabled.  Folks who are truly upset and still
   haven't fixed their system can either figure out how to add
   'arm-smmu.disable_bypass=n' to their command line or revert the
   patch in their own private kernel.  Of course these folks will be
   less secure.

Suggested-by: Robin Murphy <robin.murphy@arm.com>
Signed-off-by: Douglas Anderson <dianders@chromium.org>
---

Changes in v2:
- Flipped default to 'yes' and changed comments a lot.

 drivers/iommu/Kconfig    | 25 +++++++++++++++++++++++++
 drivers/iommu/arm-smmu.c |  3 ++-
 2 files changed, 27 insertions(+), 1 deletion(-)

diff --git a/drivers/iommu/Kconfig b/drivers/iommu/Kconfig
index 1ca1fa107b21..a4210672804a 100644
--- a/drivers/iommu/Kconfig
+++ b/drivers/iommu/Kconfig
@@ -359,6 +359,31 @@ config ARM_SMMU
 	  Say Y here if your SoC includes an IOMMU device implementing
 	  the ARM SMMU architecture.
 
+config ARM_SMMU_DISABLE_BYPASS_BY_DEFAULT
+	bool "Default to disabling bypass on ARM SMMU v1 and v2"
+	depends on ARM_SMMU
+	default y
+	help
+	  Say Y here to (by default) disable bypass streams such that
+	  incoming transactions from devices that are not attached to
+	  an iommu domain will report an abort back to the device and
+	  will not be allowed to pass through the SMMU.
+
+	  Any old kernels that existed before this KConfig was
+	  introduced would default to _allowing_ bypass (AKA the
+	  equivalent of NO for this config).  However the default for
+	  this option is YES because the old behavior is insecure.
+
+	  There are few reasons to allow unmatched stream bypass, and
+	  even fewer good ones.  If saying YES here breaks your board
+	  you should work on fixing your board.  This KConfig option
+	  is expected to be removed in the future and we'll simply
+	  hardcode the bypass disable in the code.
+
+	  NOTE: the kernel command line parameter
+	  'arm-smmu.disable_bypass' will continue to override this
+	  config.
+
 config ARM_SMMU_V3
 	bool "ARM Ltd. System MMU Version 3 (SMMUv3) Support"
 	depends on ARM64
diff --git a/drivers/iommu/arm-smmu.c b/drivers/iommu/arm-smmu.c
index 045d93884164..930c07635956 100644
--- a/drivers/iommu/arm-smmu.c
+++ b/drivers/iommu/arm-smmu.c
@@ -110,7 +110,8 @@ static int force_stage;
 module_param(force_stage, int, S_IRUGO);
 MODULE_PARM_DESC(force_stage,
 	"Force SMMU mappings to be installed at a particular stage of translation. A value of '1' or '2' forces the corresponding stage. All other values are ignored (i.e. no stage is forced). Note that selecting a specific stage will disable support for nested translation.");
-static bool disable_bypass;
+static bool disable_bypass =
+	IS_ENABLED(CONFIG_ARM_SMMU_DISABLE_BYPASS_BY_DEFAULT);
 module_param(disable_bypass, bool, S_IRUGO);
 MODULE_PARM_DESC(disable_bypass,
 	"Disable bypass streams such that incoming transactions from devices that are not attached to an iommu domain will report an abort back to the device and will not be allowed to pass through the SMMU.");
-- 
2.21.0.352.gf09ad66450-goog

