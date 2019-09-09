Return-Path: <SRS0=hqT0=XE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F07FC4740A
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Sep 2019 15:02:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 33DB52086D
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Sep 2019 15:02:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kYLKHoHw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732935AbfIIPCU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Sep 2019 11:02:20 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:35683 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726932AbfIIPCU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Sep 2019 11:02:20 -0400
Received: by mail-wm1-f66.google.com with SMTP id n10so15122865wmj.0;
        Mon, 09 Sep 2019 08:02:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=hz2LLAs1cNin8+Ffsd99n/VCZu9MKmEH6kess00jubE=;
        b=kYLKHoHw1+FdpSAoZzgikfbFo4aHSD51QuWxTqCKhwqj3oiheEFX+WJYtWCKXssu02
         hgshnQvzqDW6oYrgdphx07wtfGM8lDdRbRvsPsExSMMNYRdVOpVxjx6VtYTdIQvH6PN3
         98yBv7dEucrqRlXp+ndBEpQelQyanNmQza5dRg6BDmMSI0Mxory2upSb10YDzOdXYOtl
         CF3/rOTbY/8MQb5xEJjRkR2JFAMtv8lOL1LFmY+HDPss6uk+qekUOa/Yi1jL1aZ3YGqP
         Lglhg0dARlwzBtOnieW7qwhqKhDoIlwCTAh9DojPChQ+HReemA5EMLoJZSWJDnkudBsn
         px8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=hz2LLAs1cNin8+Ffsd99n/VCZu9MKmEH6kess00jubE=;
        b=HYY9hy5ar5evH2mIc5Dg6zlwtOPhQMNCov0UhuVfwaM6vSGcVDx0W+cXaZVEDD1oG0
         HOnG4IsRS+uIXAEOXB9RlzWhXUwETOG6So4Xx5C80Vw47q63xMFv3+M0VVAbU86gvP7u
         4wF6lNDJbvP1SDESrCUGKlwT6b7aSzaOk238PB7IEqmc7mKTwyne3+Gma0KpxquW/KTj
         Keq/EzwAb+gTlgstZPECd/Qu5i6RHmbA/Og+YVKGrMqlsty+9D+3GJerE+q9O+y0WsKk
         eQZocIrqNmz0Ry5qiPXwcbhZF+0YTec6r2qafCN6Gu7m6NLb2Y1bXW+Idu0yf3U5P3NF
         Ozrw==
X-Gm-Message-State: APjAAAW//ZxZ2CZ032CKFX6k1ndqVuzBeaPJzkpSpPC8a19cQWiCNQ4w
        wwHNR258Pu5oqwppUUYFmP4=
X-Google-Smtp-Source: APXvYqxuVkRXu5Dx4fweA5WFPPS8e3xjqSXDcwP0Si25TxUEBUwQkdppodEEW3Bh9ipx6K8IG31EeA==
X-Received: by 2002:a05:600c:259:: with SMTP id 25mr18717914wmj.158.1568041337964;
        Mon, 09 Sep 2019 08:02:17 -0700 (PDT)
Received: from localhost.localdomain ([94.204.252.234])
        by smtp.gmail.com with ESMTPSA id s26sm27755397wrs.63.2019.09.09.08.02.15
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 09 Sep 2019 08:02:17 -0700 (PDT)
From:   Christian Hewitt <christianshewitt@gmail.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Kevin Hilman <khilman@baylibre.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     Chrisitian Hewitt <christianshewitt@gmail.com>
Subject: [PATCH 0/6] arm64: meson-gx: misc fixes and updates
Date:   Mon,  9 Sep 2019 19:01:21 +0400
Message-Id: <1568041287-7805-1-git-send-email-christianshewitt@gmail.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patchset:

- Fixes bluetooth on Khadas VIM2
- Fixes bluetooth on Khadas VIM
- Fixes GPIO key dt on Khadas VIM
- Updates model for AML-S805X-CC
- Updates model/compatible for AML-S905X-CC

Christian Hewitt (6):
  arm64: dts: meson-gxl-s905x-khadas-vim: fix gpio-keys-polled node
  arm64: dts: meson-gxl-s905x-khadas-vim: fix uart_A bluetooth node
  arm64: dts: meson-gxm-khadas-vim2: fix uart_A bluetooth node
  arm64: dts: meson: libretech-ac: update model description
  dt-bindings: arm: amlogic: update libretech-cc compatible
  arm64: dts: meson: libretech-cc: update model and compatible

 Documentation/devicetree/bindings/arm/amlogic.yaml           | 2 +-
 arch/arm64/boot/dts/amlogic/meson-gxl-s805x-libretech-ac.dts | 2 +-
 arch/arm64/boot/dts/amlogic/meson-gxl-s905x-khadas-vim.dts   | 7 ++++---
 arch/arm64/boot/dts/amlogic/meson-gxl-s905x-libretech-cc.dts | 5 +++--
 arch/arm64/boot/dts/amlogic/meson-gxm-khadas-vim2.dts        | 3 +++
 5 files changed, 12 insertions(+), 7 deletions(-)

-- 
2.7.4

