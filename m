Return-Path: <SRS0=Exau=WQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 82074C3A5A0
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Aug 2019 02:05:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4FBDC214DA
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Aug 2019 02:05:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JKIc5WUZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728943AbfHTCF6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 19 Aug 2019 22:05:58 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:38791 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728615AbfHTCF6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Aug 2019 22:05:58 -0400
Received: by mail-pf1-f194.google.com with SMTP id o70so2337431pfg.5;
        Mon, 19 Aug 2019 19:05:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ieUpGElE7X0EHL/AsKR0HOPyzEa7QNRNTAYrXPio4rM=;
        b=JKIc5WUZGSdxQ72vPG13+a1sKtJlMNBRamNiM+x+OdJn6RZZff3TFywwRWv2zlSOol
         YNTTfAo8Upd0gBFMbvSJx/eMAydW6SXTpTcnJgJwi1KFOl6XFxFrHyNZcwp6Xdq6CQYx
         GqcIRT+xVsmI85TPj/zuYo9qgU//mhfDc0njrKqPrZmhzyQT1MlKjAlOaMe4gP5rivw/
         PXsqzqirHq17Q8WLmhY1Y7XqjvY4qsWKhOq+UwpHlftLAo9FzJYxl0LDApUSIQke63T7
         Pjk20XR+5KGzA8zTcSh5WD6RSYLDHxtJImz9h2uZLKkyTtWEoA1W/1KuxWLTtSzViRpI
         SrvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ieUpGElE7X0EHL/AsKR0HOPyzEa7QNRNTAYrXPio4rM=;
        b=ivnYQ6paeHjKC6wup2PB8cGTYKk6nYy0YF4pvdBz8cOCUqsuFtalMs6MEpCZrDxqLE
         pdgY6c7dGqc3/dnxvcqP+22atJng31UwUH/HOTOLPHhSzvTIgpozGqeW2QKi+7hSRZ5X
         Kcrp/MNFypcCey8iFt5zTMfGTURdhXCeIj2TYBTZqr/w7cakkbO2yYonNBc2Zwk9DfAZ
         lnyyAr0lPcRSQ7oOhDLn7tPkCkPLJXlqOmVLJimjikwofRoR0GiKR4xYj9fhgnFzpI24
         24MuCduNAyOhk6FnePwKvWAgKL9WBvJSOTjMMUgrh20UhYQuqkvXagQy1Y1WIBXsuKNp
         PAwA==
X-Gm-Message-State: APjAAAUwkYzznyTIEJLwjeVP7wYAinQbe3t5oZIj4ynzCMT3oplTvAD4
        gFTLfpcxKPz62ZuiFkOVp1w=
X-Google-Smtp-Source: APXvYqyhY12pn8C5nG+pZUGsw//GF7vZdEFgwS9twoy0uKk0HK4WsE3SLdm8D34AovMASU8q5jolwg==
X-Received: by 2002:a63:b60b:: with SMTP id j11mr11061916pgf.283.1566266757357;
        Mon, 19 Aug 2019 19:05:57 -0700 (PDT)
Received: from gli-arch.genesyslogic.com.tw ([122.146.30.3])
        by smtp.gmail.com with ESMTPSA id l4sm13532741pjq.9.2019.08.19.19.05.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Aug 2019 19:05:56 -0700 (PDT)
From:   Ben Chuang <benchuanggli@gmail.com>
To:     adrian.hunter@intel.com, ulf.hansson@linaro.org
Cc:     linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org,
        johnsonm@danlj.org, ben.chuang@genesyslogic.com.tw,
        Ben Chuang <benchuanggli@gmail.com>
Subject: [PATCH V5 0/4] Add Genesys Logic GL975x support
Date:   Tue, 20 Aug 2019 10:05:48 +0800
Message-Id: <20190820020548.8164-1-benchuanggli@gmail.com>
X-Mailer: git-send-email 2.22.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ben Chuang <ben.chuang@genesyslogic.com.tw>

The patches modify internal clock setup to match SD Host Controller
Simplified Specifications 4.20 and support Genesys Logic GL9750/
GL9755 support.

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

Ben Chuang (4):
  mmc: sdhci: Change timeout of loop for checking internal clock stable
  mmc: sdhci: Add PLL Enable support to internal clock setup
  PCI: Add Genesys Logic, Inc. Vendor ID
  mmc: host: sdhci-pci: Add Genesys Logic GL975x support

 drivers/mmc/host/Makefile         |   2 +-
 drivers/mmc/host/sdhci-pci-core.c |   2 +
 drivers/mmc/host/sdhci-pci-gli.c  | 381 ++++++++++++++++++++++++++++++
 drivers/mmc/host/sdhci-pci.h      |   5 +
 drivers/mmc/host/sdhci.c          |  27 ++-
 drivers/mmc/host/sdhci.h          |   1 +
 include/linux/pci_ids.h           |   2 +
 7 files changed, 417 insertions(+), 3 deletions(-)
 create mode 100644 drivers/mmc/host/sdhci-pci-gli.c

-- 
2.22.1

