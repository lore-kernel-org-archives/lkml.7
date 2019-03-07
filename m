Return-Path: <SRS0=uyI7=RK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4952CC43381
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Mar 2019 15:13:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1281420851
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Mar 2019 15:13:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="ivTODnx0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726414AbfCGPNq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 Mar 2019 10:13:46 -0500
Received: from mail-wr1-f65.google.com ([209.85.221.65]:42791 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726172AbfCGPNq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Mar 2019 10:13:46 -0500
Received: by mail-wr1-f65.google.com with SMTP id r5so17851299wrg.9
        for <linux-kernel@vger.kernel.org>; Thu, 07 Mar 2019 07:13:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=pg+tmE0/Z75mCfveAvM/iSy2/1VA6GIsTsQb1/i8Fmc=;
        b=ivTODnx05Jwq8Tge97c136GqTjLUNY9NNosdIO4VBbrAUhD4I3kJMitN9FsyRMhRyq
         ih5MiYkHaD7pjepYkQmNUfThd6P7JiZYsqMRwx+HaI4NTzRw8k3tLFiQpL3RojE/D2F3
         tC10RKf6OTwf4ADyPgvt+OGHspx9HLKU74I/uMecBnUO/A6y4SJueyOMEkjF1Qy3gpSt
         j61iv0+TCg1xZLbDk2NhmDtfvjgc81F+UGXEZbB2I4K8XoN6ul2hpkW8ByH/v9MNKOVt
         vQTp/iVECSRuKugLyNo4t3IZz3x7nyK+er5g/eD1bN/KxIIYa5Gk1CRdGTupHB7z0cGt
         pg8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=pg+tmE0/Z75mCfveAvM/iSy2/1VA6GIsTsQb1/i8Fmc=;
        b=Fe70TACAv1fOvVg/ZNSyZerqkFAk2nqUMx9OXBlMTg1CHJo8UgNWgOZMIigR7X/Ze1
         +6CQLfgYtyNtrdMVguJu7oNgh02bv/Clu1gZbS69IqfGuicbJ4TFFK1A/j+quCHKP7Fd
         UhPd3rXJI4yXTRdAgny1DiDCWpFh/tIikbDDSQGESckpIm9Tgef7yZgRafDpcZK1apUN
         TDespz+a6NXPCCxvkruJqCDU//gBDZ1eCZZ7cLrzRwl5pMMvLLxm2P0FOr7Ro+iv4Kca
         AZQns2nBkFlqr/hODw34QM+rFvaZpoesXl705kvnConvRegIYu7efXuFPHPsJxKvrPw6
         Pa5Q==
X-Gm-Message-State: APjAAAUp9O4CFuQKHhkBP+V2/sjH9bGH4gs5w/djszAqHsws2B+RY1lD
        4EPNgClK1QqrfcyaDQpl07wOyg==
X-Google-Smtp-Source: APXvYqyWcBJe8v2hNPdJJElmsq7WkAq9Dlugx/fJY9OzeO2bPobuLGH/IgZdJ7s39zc6aW3dA+3QbA==
X-Received: by 2002:adf:f305:: with SMTP id i5mr7006705wro.161.1551971623984;
        Thu, 07 Mar 2019 07:13:43 -0800 (PST)
Received: from bender.baylibre.local (lmontsouris-657-1-212-31.w90-63.abo.wanadoo.fr. [90.63.244.31])
        by smtp.gmail.com with ESMTPSA id r15sm5756563wrt.37.2019.03.07.07.13.43
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 07 Mar 2019 07:13:43 -0800 (PST)
From:   Neil Armstrong <narmstrong@baylibre.com>
To:     khilman@baylibre.com
Cc:     Neil Armstrong <narmstrong@baylibre.com>,
        linux-amlogic@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH 0/9] arm64: dts: g12a: Add peripherals
Date:   Thu,  7 Mar 2019 16:13:32 +0100
Message-Id: <20190307151342.7381-1-narmstrong@baylibre.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add following peripherals :
- AO Clock + Reset Controller
- AO Secure Node, used for chipid
- Pinctrl
- UARTs
- SAR-ADC
- USB
- Mali GPU

USB depends on the PCIE clock and missing Reset bindings.

SARADC, USB & Mali GPU bindings are yet to be merged but are
in review.

Jerome Brunet (3):
  arm64: dts: meson: g12a: add pinctrl support controllers
  arm64: dts: meson: g12a: add uart_ao_a pinctrl
  arm64: dts: meson: g12a: add reset controller

Neil Armstrong (6):
  arm64: dts: meson: g12a: Add AO Clock + Reset Controller support
  arm64: dts: meson: g12a: Add AO Secure node
  arm64: dts: meson: g12a: Add UART A, B & C nodes and pins
  arm64: dts: meson: g12a: Add SAR ADC node
  arm64: dts: meson: g12a: Add G12A USB nodes
  arm64: dts: meson: g12a: Add mali-g31 gpu node

 .../boot/dts/amlogic/meson-g12a-u200.dts      |   2 +
 arch/arm64/boot/dts/amlogic/meson-g12a.dtsi   | 290 ++++++++++++++++++
 2 files changed, 292 insertions(+)

-- 
2.20.1

