Return-Path: <SRS0=WmnE=2X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 53FC9C3276E
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Jan 2020 23:14:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2971721835
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Jan 2020 23:14:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Nxptlg01"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727297AbgABXOt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 Jan 2020 18:14:49 -0500
Received: from mail-wm1-f65.google.com ([209.85.128.65]:33339 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726121AbgABXOs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Jan 2020 18:14:48 -0500
Received: by mail-wm1-f65.google.com with SMTP id d139so5866401wmd.0;
        Thu, 02 Jan 2020 15:14:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=KIhQOqEe7EmmQGE/mkr/xtA4d+4/jOmGUgTZDhxFJXw=;
        b=Nxptlg01yX+CNwhEMLeFiWfYuPDjJhRqRaljQa0cqonHGZkufwmL/N5FBev4z6Pb28
         WjL145tIb1igsQzmsU7NYTZY/jtKeL4GOwIJ148ucviQyCsyGtk0N+7jeoHcelNCM6dC
         R3z65FdeskvymbGWrdQOnGdy9aUytSk6SmatHO9UdoNhBReKb8jJAQPsPFc2i2FI+mhg
         /1ojXlRAidKvWaOJRQ7orSZbDJYXyZZR77udPSv+Vm9f9FSOwMfVdF0yMbRrLUSwiRdv
         oA0kF4YYVUEuHMgiFxJaSiVKwY2UgKayu0ABg/A0/YXajWa04qqucIdg2ESO2ejx0gMk
         LITw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=KIhQOqEe7EmmQGE/mkr/xtA4d+4/jOmGUgTZDhxFJXw=;
        b=IVQq7iCrTKliTTintgDbQcmZKHx3/WA/dNWccTuyekIz7PIOSw+wZFlwSGR7lua9Gr
         mQ4XzBHva8Dv8aMXlT9UbwSUNMTklCJNwa8yph9hOaMxa/IvUxL0sEthygas/fSeGVMN
         S+5fQbOOXJRPNcaL2qCF/BDPEwUbaOcT/RkNrAN2AwOJEMo9AoQHBcRzSli3KfNqBgut
         EOjpTOVqIdEIDV+wu6pGEy9ejJnW8OLNeHXBTwvr+yCqX91bzHAiywd+R6kPZCCePRjH
         yPzKWlVXtKVPx4iU6kOKPRuOs60s4uOLPZvnMZ30o8f3xWuZK9A702WxCb18TAD+Twt9
         qxSA==
X-Gm-Message-State: APjAAAVN0wQGYdmMlmbEQiGR6Xjy8oifowoKzumcdyV0dyZEwgvtgsui
        8hkfKbLc9hg9U+SHg6N0X+CVb8uX
X-Google-Smtp-Source: APXvYqy7lGzUcji2+wbHLwiEZiPkKTrJ9CoCPhvioi+YnSYV1R2H9gBNAJc92ACnCCfWLxPFR52/Bg==
X-Received: by 2002:a7b:c386:: with SMTP id s6mr15700620wmj.105.1578006885873;
        Thu, 02 Jan 2020 15:14:45 -0800 (PST)
Received: from fainelli-desktop.igp.broadcom.net ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id i10sm58214711wru.16.2020.01.02.15.14.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Jan 2020 15:14:45 -0800 (PST)
From:   Florian Fainelli <f.fainelli@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     Florian Fainelli <f.fainelli@gmail.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Rob Herring <robh@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        bcm-kernel-feedback-list@broadcom.com (maintainer:BROADCOM BCM7XXX ARM
        ARCHITECTURE),
        devicetree@vger.kernel.org (open list:OPEN FIRMWARE AND FLATTENED
        DEVICE TREE BINDINGS),
        linux-arm-kernel@lists.infradead.org (moderated list:BROADCOM BCM7XXX
        ARM ARCHITECTURE), Jim Quinlan <jim2101024@gmail.com>
Subject: [PATCH v2 0/2] reset: Add Broadcom STB RESCAL reset controller
Date:   Thu,  2 Jan 2020 15:14:33 -0800
Message-Id: <20200102231435.21703-1-f.fainelli@gmail.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Philipp,

This patch series adds support for the BCM7216 RESCAL reset controller
which is necessary to initialize SATA and PCIe0/1 on that chip.

Please let us know if you have any comments. Thanks!

Changes in v2:

- binding document is in YAML format per Rob's suggestion
- indented bit definitions the same way for all definitions
- moved reset logic to the .reset() callback
- removed the XOR operation which is not necessary after clarifying with
  Jim that this was not necessary
- use readl_poll_timeout()

Jim Quinlan (2):
  dt-bindings: reset: Document BCM7216 RESCAL reset controller
  reset: Add Broadcom STB RESCAL reset controller

 .../reset/brcm,bcm7216-pcie-sata-rescal.yaml  |  37 ++++++
 drivers/reset/Kconfig                         |   7 ++
 drivers/reset/Makefile                        |   1 +
 drivers/reset/reset-brcmstb-rescal.c          | 110 ++++++++++++++++++
 4 files changed, 155 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/reset/brcm,bcm7216-pcie-sata-rescal.yaml
 create mode 100644 drivers/reset/reset-brcmstb-rescal.c

-- 
2.17.1

