Return-Path: <SRS0=lq4r=TU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3616DC04AAC
	for <linux-kernel@archiver.kernel.org>; Mon, 20 May 2019 14:35:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0B1AD213F2
	for <linux-kernel@archiver.kernel.org>; Mon, 20 May 2019 14:35:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="PmFsDusz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389909AbfETOf5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 May 2019 10:35:57 -0400
Received: from mail-wm1-f51.google.com ([209.85.128.51]:50632 "EHLO
        mail-wm1-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730966AbfETOf4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 May 2019 10:35:56 -0400
Received: by mail-wm1-f51.google.com with SMTP id f204so13595290wme.0
        for <linux-kernel@vger.kernel.org>; Mon, 20 May 2019 07:35:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ejqilo1yto88LxSnrCJSQqgQ1iaCyh2m+KasJchWoQA=;
        b=PmFsDuszt8zbmDWBibaKVcHa3d90eVt4oIYeL7/WxtMyAqEGQbecyxivNB16FD1jmy
         OHpQWFInSxzYr3AAThREgWvzyqMI+SaJxcNBwZBcoBFeIvDMoe9HlOmkrBc15EgKVUuH
         Tt/f5FbDD7obeidLvSTYxokhRD4N4rjLqyXCMK9q6nxvsWr2H+mR/VgFUWGiEyrhHSes
         0FEtNlU63uUSmpRlQnApY+moyhJO2/ZlPc6SoHNLxHaqZAn+wKTgAivHht17C3UHos0w
         wHHcfwtKgT8Wee7OkOXAKp5LRgzqbXgCUN6XreuRrzjTg93nK43V3yQwDGibXoIvkOJn
         nhQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ejqilo1yto88LxSnrCJSQqgQ1iaCyh2m+KasJchWoQA=;
        b=Q1z2qnNByBQkgY4M5LfBSrokaB3bNOb5whdHXmHC3CxodXa2hubwdmCqR2Ak2+kZOe
         /3PlqlL7fGOq55ZVGXptCzCElbybYsFfxswZaJRT4IB6BbwSOilR471r+Fn6whsLddpM
         fJhOofAMLP3RS2r7EjuWr4MghazhFlHUNupF8f/7K07Feru+iXgbr9RT6ifZzGobZPKD
         RynYvls7rnPK/KbsvJ1R422bVshtWUrdpyN+EUqys/uP9RpLbxTAb9BJKRDA5lf1UYDe
         eO/dFCM5NFnlVhvaD1AehWV7xWnJ86vznrWz0ayQIIr+NRlqmwP2T+X8i9keN0aI8/io
         Iegw==
X-Gm-Message-State: APjAAAUVaEpuInLKHL8Ea9r5+mCDBSxhMRLcF6RgtqSh4QpgzsKFopH6
        trSDqdbkhU+UriFsF6giIDppPg==
X-Google-Smtp-Source: APXvYqzCnbrhWCGv6z19ZfaxyrIPmjh819MAp3NfOSe8oAbofCIxL969Y+24vhzKZK1CnQnZkZVN6A==
X-Received: by 2002:a1c:7312:: with SMTP id d18mr12188411wmb.147.1558362954239;
        Mon, 20 May 2019 07:35:54 -0700 (PDT)
Received: from bender.baylibre.local (lmontsouris-657-1-212-31.w90-63.abo.wanadoo.fr. [90.63.244.31])
        by smtp.gmail.com with ESMTPSA id j13sm14042591wru.78.2019.05.20.07.35.53
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 20 May 2019 07:35:53 -0700 (PDT)
From:   Neil Armstrong <narmstrong@baylibre.com>
To:     kishon@ti.com
Cc:     linux-amlogic@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Neil Armstrong <narmstrong@baylibre.com>
Subject: [PATCH 0/2] phy: amlogic: update with SPDX Licence identifier
Date:   Mon, 20 May 2019 16:35:49 +0200
Message-Id: <20190520143551.2330-1-narmstrong@baylibre.com>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Update the SPDX Licence identifier for the Amlogic Meson8b and GXL PHY
drivers.

Neil Armstrong (2):
  phy: amlogic: phy-meson-gxl-usb2: update with SPDX Licence identifier
  phy: amlogic: phy-meson8b-usb2: update with SPDX Licence identifier

 drivers/phy/amlogic/phy-meson-gxl-usb2.c | 8 +-------
 drivers/phy/amlogic/phy-meson8b-usb2.c   | 8 +-------
 2 files changed, 2 insertions(+), 14 deletions(-)

-- 
2.21.0

