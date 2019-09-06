Return-Path: <SRS0=GGWy=XB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8906BC43331
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Sep 2019 02:30:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 866162082C
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Sep 2019 02:30:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fAyXrBd+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389933AbfIFCaI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 5 Sep 2019 22:30:08 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:42451 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1733236AbfIFCaH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Sep 2019 22:30:07 -0400
Received: by mail-pf1-f195.google.com with SMTP id w22so3256083pfi.9;
        Thu, 05 Sep 2019 19:30:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=2G0yOXrVPAYh7NmJFpbd/e4r0uPBCVHqetFGLzHPmbU=;
        b=fAyXrBd+ZLzH+0G/vsc+aNSrYnX3hRHuFlnGBE9NEfkoM0uIkbfvfJmVFbOY9bi0CX
         spTrVa/kYzhVEPen64VqqytRXdbEDJrhDWbeaDYifIJnE18u0Da2OcqKZVHHs7O8Spuf
         Da+pah1Ikon7spjSbb8wSsWOT2/zundMGErh1VN0NGnQSYsxMMAER6Yvx+rC0h760aPf
         xoe0RcRVDU8Oux4N65mJ2ByuZzWVccUNqmjExj7vCnkn8RUzXc4vekAbtscrLMrNV0bA
         t7LpS3K1XrcASnbUHeEz1hhYDHxE11zsXtXW2VBqvoqki04+7+zXRUqSAFWtlfiUBadG
         RItQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=2G0yOXrVPAYh7NmJFpbd/e4r0uPBCVHqetFGLzHPmbU=;
        b=ZGTeM5EgwyypPvcQdd0WSF5MPr01z5/b1lAU5fJbBZgQOMigtR4evTkpG3204AeCa3
         Bh2tXw3RkmNUwz0X13cIqzdArrlkNCsY7b48oED2yawOVXoxyZRQAxht+N/1djagNgOg
         wafLBuIjathv+gHcm4HAjEPzEoT/cgdHskL6+uuzpdoWmwIKGAY4QezQ/iKL2QuJKdxn
         6uMhPOeiNhqY+JhJzzMYOM44Zp+NgvhSSrewIOHDa/vN3Sn7Y22wBK0jwSosrbF9n5n0
         oAFqcWH5LD923eE8vtar49QmD09DCN85Nl1PYX/PL3Y330BAuUdpRSESq8Df7ImCFneP
         nQIg==
X-Gm-Message-State: APjAAAU3oj+8KCQ9M03qIMkdro+Wtjico8Ck0zJeyX+XatW8ddfiGHef
        Z0S3/kXm0RsfvqfMb9Ryk1c=
X-Google-Smtp-Source: APXvYqxGafpQ9wruTnkLR5krKJyzG/Y4xSEmd8WFmEnycydknxTmkQtMTNYyl3lsTQ4qp8Pv+lENVQ==
X-Received: by 2002:a65:52ca:: with SMTP id z10mr6149814pgp.424.1567737007130;
        Thu, 05 Sep 2019 19:30:07 -0700 (PDT)
Received: from gli-arch.genesyslogic.com.tw (60-251-58-169.HINET-IP.hinet.net. [60.251.58.169])
        by smtp.gmail.com with ESMTPSA id s186sm5344330pfb.126.2019.09.05.19.30.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Sep 2019 19:30:06 -0700 (PDT)
From:   Ben Chuang <benchuanggli@gmail.com>
To:     adrian.hunter@intel.com, ulf.hansson@linaro.org
Cc:     linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org,
        johnsonm@danlj.org, ben.chuang@genesyslogic.com.tw,
        Ben Chuang <benchuanggli@gmail.com>
Subject: [PATCH V8 0/5] Add Genesys Logic GL975x support
Date:   Fri,  6 Sep 2019 10:29:41 +0800
Message-Id: <cover.1567734321.git.benchuanggli@gmail.com>
X-Mailer: git-send-email 2.23.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ben Chuang <ben.chuang@genesyslogic.com.tw>

The patches modify internal clock setup to match SD Host Controller
Simplified Specifications 4.20 and support Genesys Logic GL9750/GL9755
chipsets.

v8:
 refine codes in sdhci-gli-pci.c
 - remove duplicate assignment 
 - remove redundant delay
 - use '!!'(not not) logical operator to refine the true/false condition
 - check end condition after outter loop
 - add comments for delay 5ms in sdhci_gli_voltage_switch()
 - merge two logical conditions to one line

v7:
 - remove condition define CONFIG_MMC_SDHCI_IO_ACCESSORS from sdhci-pci-gli.c
 - making the accessors(MMC_SDHCI_IO_ACCESSORS) always available when selecting
   MMC_SDHCI_PCI in Kconfig

V6:
 - export sdhci_abot_tuning() function symbol
 - use C-style comments
 - use BIT, FIELD_{GET,PREP} and GENMASK to define bit fields of register
 - use host->ops->platform_execute_tuning instead of mmc->ops->execute_tuning
 - call sdhci_reset() instead of duplicating the code in sdhci_gl9750_reset
 - remove .hw_reset 
 - use condition define CONFIG_MMC_SDHCI_IO_ACCESSORS for read_l

V5:
 - add "change timeout of loop .." to a patch
 - fix typo "verndor" to "vendor"

V4:
 - change name from sdhci_gli_reset to sdhci_gl9750_reset
 - fix sdhci_reset to sdhci_gl9750_reset in sdhci_gl9750_ops
 - fix sdhci_gli_reset to sdhci_reset in sdhci_gl9755_ops
 
V3:
 - change usleep_range to udelay
 - add Genesys Logic PCI Vendor ID to a patch
 - separate the Genesys Logic specific part to a patch

V2:
 - change udelay to usleep_range

Ben Chuang (5):
  mmc: sdhci: Change timeout of loop for checking internal clock stable
  mmc: sdhci: Add PLL Enable support to internal clock setup
  PCI: Add Genesys Logic, Inc. Vendor ID
  mmc: sdhci: Export sdhci_abort_tuning function symbol
  mmc: host: sdhci-pci: Add Genesys Logic GL975x support

 drivers/mmc/host/Kconfig          |   1 +
 drivers/mmc/host/Makefile         |   2 +-
 drivers/mmc/host/sdhci-pci-core.c |   2 +
 drivers/mmc/host/sdhci-pci-gli.c  | 355 ++++++++++++++++++++++++++++++
 drivers/mmc/host/sdhci-pci.h      |   5 +
 drivers/mmc/host/sdhci.c          |  30 ++-
 drivers/mmc/host/sdhci.h          |   2 +
 include/linux/pci_ids.h           |   2 +
 8 files changed, 395 insertions(+), 4 deletions(-)
 create mode 100644 drivers/mmc/host/sdhci-pci-gli.c

-- 
2.23.0

