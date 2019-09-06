Return-Path: <SRS0=GGWy=XB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6E73C43331
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Sep 2019 14:05:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7C2E2208C3
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Sep 2019 14:05:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FjxI57jI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392582AbfIFOFx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 6 Sep 2019 10:05:53 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:45028 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729719AbfIFOFv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Sep 2019 10:05:51 -0400
Received: by mail-wr1-f67.google.com with SMTP id 30so6701593wrk.11;
        Fri, 06 Sep 2019 07:05:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=YhOPiGQ/jKMfAKNMmBIBmilg3dwIp+IShaOpXqxWprg=;
        b=FjxI57jI6z0XPsMkktNq3JpEyfAjsH53bwf7ysTuNIDKxiHvFK9CWMakQdziG6QSXg
         /4kn9zNNpDKtusr+UVNL1ITjHOZ5Abmb+g2ErAiWIUiSJXWgJpo7nsJspE7WNZEDmIbf
         OcXX6vIsGNb9E8MJZbTw/9+6Zvc6NQ4vMgKFnjslN5XJFBxIHZ9fVc5o/3cwK7zU/AH2
         sh7pzhElxBpPxFj61sWwAOYILB+WnlUSxUbmZlJL7Tj2g8x9NnDV6B2i16CuYcl35RbW
         lAHpzEykJcI69j0BW7NWuyluAsy1Pf12NlAULs8krx3jjoZ6YlgOp0TMwFqebdRi9GKb
         ng5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=YhOPiGQ/jKMfAKNMmBIBmilg3dwIp+IShaOpXqxWprg=;
        b=GQ4oWgpTlTbciRvtvY214opWHgzni/icDv/EHU9+r3VahIYay19VtRhtLJZMNv+2Bo
         5+h1NcBknO1aob5MV7KBAVqTUAzBHc/5yWFWihXRJAa98YG6jKL9gyQ0kjCpboaZKCOJ
         6UXlyXKa5oStB5L59PQbQDXy8nigLznzCuq9Dle9EIeCUYU0Ae3Q38nzXlPEieXxrJl9
         RUkFw7+jCiHFDvlsyhiqzznU4d0MCKc24ERnKN4OYnmrr3Qms2vcd+tldG2RkYF7YZr/
         qhyMxjIVWEHdXttxY6W8+W0Iys1GKJ2I0HLVuRQxL90snq4JwKCpj/16pHI+uNizvoBq
         7MFw==
X-Gm-Message-State: APjAAAXD3geY6Fa5dox+UO4bFIjxrXQONImWVXdAynNKG5MHR57mLqnF
        nHaVoI8nSWuWxWHrm8F0IOA=
X-Google-Smtp-Source: APXvYqyour3/+Klmag/nD1xyNEEijuh9OxYfZsVW8R9vEdtv/6UIzhNd9mDLPuW0JOIbs21O/mlgFQ==
X-Received: by 2002:adf:dec8:: with SMTP id i8mr7527923wrn.286.1567778749916;
        Fri, 06 Sep 2019 07:05:49 -0700 (PDT)
Received: from localhost.localdomain ([94.204.252.234])
        by smtp.gmail.com with ESMTPSA id e20sm7480542wrc.34.2019.09.06.07.05.47
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 06 Sep 2019 07:05:49 -0700 (PDT)
From:   Christian Hewitt <christianshewitt@gmail.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Kevin Hilman <khilman@baylibre.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     Chrisitian Hewitt <christianshewitt@gmail.com>,
        Oleg Ivanov <balbes-150@yandex.ru>
Subject: [PATCH v3 0/3] arm64: meson-g12b: Add support for the Ugoos AM6
Date:   Fri,  6 Sep 2019 18:04:56 +0400
Message-Id: <1567778699-59231-1-git-send-email-christianshewitt@gmail.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patchset adds support for the Ugoos AM6, an Android STB based on
the Amlogic W400 reference design with the S922X chipset.

v2: correction of minor nits

v3: address regulator and GPIO corrections from Neil Armstrong (using
schematic excerpts from Ugoos) and related v2 comments from Martin
Blumenstingle. Add acks on patches 1/2 from Rob Herring.

Christian Hewitt (3):
  dt-bindings: Add vendor prefix for Ugoos
  dt-bindings: arm: amlogic: Add support for the Ugoos AM6
  arm64: dts: meson-g12b-ugoos-am6: add initial device-tree

 Documentation/devicetree/bindings/arm/amlogic.yaml |   1 +
 .../devicetree/bindings/vendor-prefixes.yaml       |   2 +
 arch/arm64/boot/dts/amlogic/Makefile               |   1 +
 .../boot/dts/amlogic/meson-g12b-ugoos-am6.dts      | 557 +++++++++++++++++++++
 4 files changed, 561 insertions(+)
 create mode 100644 arch/arm64/boot/dts/amlogic/meson-g12b-ugoos-am6.dts

-- 
2.7.4

