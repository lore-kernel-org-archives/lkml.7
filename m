Return-Path: <SRS0=BPXs=SN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9070C10F13
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Apr 2019 23:03:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7EA9E2146F
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Apr 2019 23:03:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QkNdHvQ1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727070AbfDKXD2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Apr 2019 19:03:28 -0400
Received: from mail-lf1-f65.google.com ([209.85.167.65]:36223 "EHLO
        mail-lf1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726646AbfDKXD1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Apr 2019 19:03:27 -0400
Received: by mail-lf1-f65.google.com with SMTP id u17so5988780lfi.3;
        Thu, 11 Apr 2019 16:03:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=gwm5SnpDy6D4hA096gXdnd+aI7PO95jM/+hrKDWG/1w=;
        b=QkNdHvQ1NodDtt4p24g+u5jrAZasBfGxIo9FHPGt3ncK4+gLPaW0XedXyiWEgMN4dc
         G1vOh1Oj+ANcezBQRfxx6f03GVrLNcl4Ojlq+q1jOVxVW7orqdMeXa5JtWSKcVhU0NG6
         MBSF72VbxA0b/dwltPk93X7Gl8et3ql8aKkmPQaggtVip0e/RJhdN0flGE5QPImOFksH
         NGdQkKwfC2wBlrQtEY1T7he1oGzCICTD0c9UqQXbNNIeSPFnmla+1PFAEnAX1WyPWLab
         lCLyJCcQjaXShxlxTMX9oYJfZFn3vJKF1iTQ3g37TNPE4J6xcptgjzjgEtsOxN1vchVF
         P9uQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=gwm5SnpDy6D4hA096gXdnd+aI7PO95jM/+hrKDWG/1w=;
        b=gAbS2ssONtBBl4IDt87yh5mD58aLg5UP89Ndyv9X2q8kn6S2GlnkMJB4qU7BOQTH9j
         XGhP/wRin3FkDm8qhggbJrVUdI3ltKQfo7Z4DycQ65cBletTOdeWJW5jxdFdPP+kKRPW
         nxeeYMkHtyFI6mc9NQgdqh52oLaiS4OJhuBzW6mSDeCenLTZSy2pHofKvVfnMV1T083x
         +AJEWkcRCbg+Gz0/kiBF2CM3NNkt9yyoEXFvuHx7D11awSgMgZ13XIf2PaISolWbARmK
         hTUf3moX6l2Vr2MzA4ssJUYlp4G5r0oBZXK834hpuwDG4Q4Uf9/mwDmnaXWLW+ZgHzzO
         LXxg==
X-Gm-Message-State: APjAAAUGfF2xbvpB9O+71LZWgPL8fSrTg6ORDuc48Py4Xk8jPQUCOYox
        nJJqKdeUEPKc72y51/uUTYo=
X-Google-Smtp-Source: APXvYqw+Ko3I21scaI/v25i5BAa3HQ6fB6G5uTljzUPHQsoLnHiNKYNN5n1VhJoVwJIDy0uBatzccg==
X-Received: by 2002:ac2:4a86:: with SMTP id l6mr18452334lfp.51.1555023805432;
        Thu, 11 Apr 2019 16:03:25 -0700 (PDT)
Received: from localhost.localdomain (ppp94-29-35-107.pppoe.spdop.ru. [94.29.35.107])
        by smtp.gmail.com with ESMTPSA id u19sm7764486lfg.74.2019.04.11.16.03.24
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 11 Apr 2019 16:03:24 -0700 (PDT)
From:   Dmitry Osipenko <digetx@gmail.com>
To:     Peter De Schrijver <pdeschrijver@nvidia.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Joseph Lo <josephl@nvidia.com>
Cc:     devicetree@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v1 0/3] memory: Introduce NVIDIA Tegra30 EMC driver
Date:   Fri, 12 Apr 2019 02:02:18 +0300
Message-Id: <20190411230221.31362-1-digetx@gmail.com>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

This patchset adds driver for the External Memory Controller of NVIDIA
Tegra30 SoC's. It performs memory hardware configuration that is required
for changing DRAM frequency, thus providing facility for the memory
frequency scaling on Tegra30. The memory scaling was tested using the
Tegra's devfreq driver which is available in upstream, it dynamically
changes memory clock rate based on memory clients activity.

Dmitry Osipenko (3):
  dt-bindings: memory: Add binding for NVIDIA Tegra30 External Memory
    Controller
  memory: tegra: Introduce Tegra30 EMC driver
  ARM: dts: tegra30: Add External Memory Controller node

 .../memory-controllers/nvidia,tegra30-emc.txt |  257 ++++
 arch/arm/boot/dts/tegra30.dtsi                |   11 +
 drivers/memory/tegra/Kconfig                  |   10 +
 drivers/memory/tegra/Makefile                 |    1 +
 drivers/memory/tegra/mc.c                     |    3 -
 drivers/memory/tegra/mc.h                     |   30 +-
 drivers/memory/tegra/tegra30-emc.c            | 1106 +++++++++++++++++
 drivers/memory/tegra/tegra30.c                |   44 +
 8 files changed, 1450 insertions(+), 12 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/memory-controllers/nvidia,tegra30-emc.txt
 create mode 100644 drivers/memory/tegra/tegra30-emc.c

-- 
2.21.0

