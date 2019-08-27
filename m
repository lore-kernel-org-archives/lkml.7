Return-Path: <SRS0=qJmF=WX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 710EAC3A59F
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Aug 2019 00:32:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 27EA1206BB
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Aug 2019 00:32:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Q6qysXwn"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727867AbfH0AcY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 26 Aug 2019 20:32:24 -0400
Received: from mail-pl1-f195.google.com ([209.85.214.195]:41225 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726944AbfH0AcX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Aug 2019 20:32:23 -0400
Received: by mail-pl1-f195.google.com with SMTP id m9so10845064pls.8;
        Mon, 26 Aug 2019 17:32:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=FmTDIjwDZHURui17fbI3myXwISZRJiWLOpeT3PDq78E=;
        b=Q6qysXwnEsq0MbkI5H+rhc+AmTTkSvZvcv31cIDjG+ioedc3t5tsklkg7YdbQG46+6
         NQvQYlKTCPRox6rZUSVijO9S5mshnzMIyQDZVvHvod5CEzWKdqM753K8FjLougCjlRSw
         ZG3whp/D/KYU41hZXU+JXZBn/9TLAqYS2BlHs0+sDHWl9rb7vpLoxwBkMQj9xUzDeAWY
         9Hla7mdleRxAzaxZtY+PeEKU/2qY031WXxxvDlaq2XIBqlNcvqM/CdqlE1jGCT0N8dJs
         jTzUACCZzC487qsfg+f62p2vXVYTQK+7xouzWI8uYPhKmYA3u12Xp3OpX7JjSlZSzAWp
         HH+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=FmTDIjwDZHURui17fbI3myXwISZRJiWLOpeT3PDq78E=;
        b=ffQZRGbcrNoVq11BLqfL1yky5TfUzolGLNZC9hG/6AIL0gMwQsN2gj4Edn74FH6O4w
         fCpclQ9CQ4QigfXrHzfqnYRCeojgXo5C31ChVjKh++xlFAtKn2lhATvujftdHVyzX7uI
         mIDQ7wRyzD0ByVJh+Zuv9VGCwqYoj8LR0cHub/Rm47UZss004obpp23w1HayRygXj9iS
         Kx9GMl6bXuGOowaoyNEPpy1OT2XbNnAUqtjDyimgPIzhkYYiBVERlJe+FObQpt3V6UD0
         jd9PchH17ccHPD2H7WeuyGr0PfVNA52BiBJUuXGHzzxPqu6WNy+nvs0XBNJ5EecOtGWQ
         IesQ==
X-Gm-Message-State: APjAAAX1Oix+DYQLdmdExpqh0hognCHgZug2vZzIDUR0ItxlYLO73qX4
        fRO0CrWzHGUQZ1wlGjEw2Ek=
X-Google-Smtp-Source: APXvYqy6tMie3j70EM7AFKQC1q1kYd5llzYaAOx293SFYDiDDQiHBPi3k9C1OIm3nPHi17PdCZokJA==
X-Received: by 2002:a17:902:ac87:: with SMTP id h7mr6415689plr.36.1566865943117;
        Mon, 26 Aug 2019 17:32:23 -0700 (PDT)
Received: from gli-arch.genesyslogic.com.tw (60-251-58-169.HINET-IP.hinet.net. [60.251.58.169])
        by smtp.gmail.com with ESMTPSA id n128sm11554471pfn.46.2019.08.26.17.32.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Aug 2019 17:32:22 -0700 (PDT)
From:   Ben Chuang <benchuanggli@gmail.com>
To:     adrian.hunter@intel.com, ulf.hansson@linaro.org
Cc:     linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org,
        johnsonm@danlj.org, ben.chuang@genesyslogic.com.tw,
        Ben Chuang <benchuanggli@gmail.com>
Subject: [PATCH V6 0/5] Add Genesys Logic GL975x support
Date:   Tue, 27 Aug 2019 08:31:45 +0800
Message-Id: <20190827003145.2249-1-benchuanggli@gmail.com>
X-Mailer: git-send-email 2.22.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ben Chuang <ben.chuang@genesyslogic.com.tw>

The patches modify internal clock setup to match SD Host Controller
Simplified Specifications 4.20 and support Genesys Logic GL9750/GL9755 chipsets.

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

 drivers/mmc/host/Makefile         |   2 +-
 drivers/mmc/host/sdhci-pci-core.c |   2 +
 drivers/mmc/host/sdhci-pci-gli.c  | 354 ++++++++++++++++++++++++++++++
 drivers/mmc/host/sdhci-pci.h      |   5 +
 drivers/mmc/host/sdhci.c          |  30 ++-
 drivers/mmc/host/sdhci.h          |   2 +
 include/linux/pci_ids.h           |   2 +
 7 files changed, 393 insertions(+), 4 deletions(-)
 create mode 100644 drivers/mmc/host/sdhci-pci-gli.c

-- 
2.22.1

