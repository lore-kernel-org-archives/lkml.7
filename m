Return-Path: <SRS0=cV2B=UC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 20949C04AB5
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Jun 2019 10:04:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DDB8128070
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Jun 2019 10:04:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="rPw9psU0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728113AbfFCKEB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Jun 2019 06:04:01 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:38144 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725974AbfFCKEA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Jun 2019 06:04:00 -0400
Received: by mail-wr1-f66.google.com with SMTP id d18so11369236wrs.5
        for <linux-kernel@vger.kernel.org>; Mon, 03 Jun 2019 03:03:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=lz9OcKEPelvnCTb/4HXbu+GQFwOtM8R/fqmIrzaf034=;
        b=rPw9psU0swuxQ2q59Mun4xuZGqhb6XWh+KB/ARBwpCrMc6WEKYooJQtgv+frptln59
         Pj2CNCp5FMqHvmnUoaWb8uNQGwu1NcyISOH72PTAY+8u31iMcrBvTsxQ75y/xj3sXO9r
         gpBomJX9dOdqQI8rgkf2OFUUzEjRv71LOh+2Y41ZOST6g98PnhT9ijtBswPTzDi9+dnw
         qYpuGTq+EHW6yxXBeFaOckcTJAP6sIqTJrK7uKWI8hTTmaAz0XFhnZHhXdj4euRrtMFJ
         h8gdXxlKXW59NgQxO9nZF9eYYSzVExNizaRWWJeG+vc9MwOaWnkRsWbGg9tWwLEis+aP
         w2TQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=lz9OcKEPelvnCTb/4HXbu+GQFwOtM8R/fqmIrzaf034=;
        b=EUESkTmF2alVBhwhkjwrrZaDUjKZTJugtBTgIKXIZXSkeROIb0Pxm+8IAPhoCuwZgf
         qWgOI2HoRO6hTIpkhYTFhcsEG+2zEqu7cdXofvUEsgewItZzI4GQoXKUq8RfsBQwgMiQ
         hxQ+vNh5G3KMKD3ZA559OBD1TlPUsDDivJ/pY1iFHz9oX76KmkzfoZTsfIMYUpF2P0RM
         j5+AmPQNozR9s6gzO97lvN+SspAFGsho+ueqmAeGdAHYlSPbwBqFWoRlGM55E3Qe3CEM
         waC6GJ3S0fJtWpl53G6Y9tklvIlcWwNyy/6/KQJizhzAylrF8Bfr7gzumVxBqhDBdfrS
         qrow==
X-Gm-Message-State: APjAAAXigdwVx/isDcONThb6ijOLmY7n2lW+lI+OG/zT3fIFYaZj5wX3
        1A/HG9ChkAAaco0IeuseaAsA3A==
X-Google-Smtp-Source: APXvYqys8eAbHlKxvZAv6SoAZtOgdOJvJkrgQOulcdQqFHoUWUcyiOOCeYEecwvO+6qn0qRh85UPYQ==
X-Received: by 2002:adf:eb45:: with SMTP id u5mr1827103wrn.38.1559556239004;
        Mon, 03 Jun 2019 03:03:59 -0700 (PDT)
Received: from bender.baylibre.local (lmontsouris-657-1-212-31.w90-63.abo.wanadoo.fr. [90.63.244.31])
        by smtp.gmail.com with ESMTPSA id o3sm11282098wrv.94.2019.06.03.03.03.58
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 03 Jun 2019 03:03:58 -0700 (PDT)
From:   Neil Armstrong <narmstrong@baylibre.com>
To:     khilman@baylibre.com
Cc:     linux-amlogic@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Neil Armstrong <narmstrong@baylibre.com>
Subject: [PATCH 0/4] arm64: dts: meson-g12a: mmc updates
Date:   Mon,  3 Jun 2019 12:03:53 +0200
Message-Id: <20190603100357.16799-1-narmstrong@baylibre.com>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patchset :
- adds the SDIO controller node using the dram-access-quirk
- adds SDCard, eMMC & SDIO support to X96
- Add SDIO support to SEI510

Guillaume La Roque (1):
  arm64: dts: meson-g12a-x96-max: add support for sdcard and emmc

Jerome Brunet (1):
  arm64: dts: meson: g12a: add SDIO controller

Neil Armstrong (2):
  arm64: dts: meson-g12a-x96-max: Enable Wifi SDIO Module
  arm64: dts: meson-g12a-sei510: Enable Wifi SDIO module

 .../boot/dts/amlogic/meson-g12a-sei510.dts    | 48 ++++++++++
 .../boot/dts/amlogic/meson-g12a-x96-max.dts   | 88 +++++++++++++++++++
 arch/arm64/boot/dts/amlogic/meson-g12a.dtsi   | 37 ++++++++
 3 files changed, 173 insertions(+)

-- 
2.21.0

