Return-Path: <SRS0=lMFC=TN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D0E8C04AB1
	for <linux-kernel@archiver.kernel.org>; Mon, 13 May 2019 09:16:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E3F3D20989
	for <linux-kernel@archiver.kernel.org>; Mon, 13 May 2019 09:16:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="JKM4PKuC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728423AbfEMJQF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 13 May 2019 05:16:05 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:41699 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728386AbfEMJQD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 May 2019 05:16:03 -0400
Received: by mail-wr1-f68.google.com with SMTP id d12so14308636wrm.8
        for <linux-kernel@vger.kernel.org>; Mon, 13 May 2019 02:16:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=j6faxotKxNMmgIEg0wYpwPSJedZIS/jOCkKVr0/VGHk=;
        b=JKM4PKuCaOCDQfqA2xTNlavdxZlkF6bf304MnUe0AK98cMu+YsZwoEHHU6Gyb4MCxh
         MyV/8q/FLiltE2V7/QmvqWD58wtNQAi+MqKau9cxNs++gp9kk1lZtKX7elvt6+hoaPQi
         iHAkXMaBlqmE8VwHd2IZ6vow0QMtJhXvZ22yyMTBkiOhlve1+7YgopfkXZVtQrZoj4UG
         g9qc0sgf/IZHiXDEqz0avtcAFw43pGN79pIHdntZZs4J1KR05bmJ187h2JCToaUhzoyF
         M3vl4pLd8Jsmn+ai1iKRftj9doEFEuxccpB0Gi5WM/PxHAGdHmkzC7cct+Cat/P1EpKo
         jOaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=j6faxotKxNMmgIEg0wYpwPSJedZIS/jOCkKVr0/VGHk=;
        b=Kl8Nhlmkmx2Z8STqUMhA5NH0xEO43dh+K5vP72yJdRuwihbjs43TPQIfeqZ6zVrohH
         x9IXPnjXIaKlFlOAF+QThKdSMPrdBpJgpjL4cB2vEDmJ+RqsQYpcB3YbPKSzE7hUT4Wp
         Zqo8FUEs9eTsm65+BbtgCGZlNWw5s6jSOIF7strv/bPQb5eJpgfoUjmiC+Dy4ag7Lot4
         H9fvbR9BbEB8BMl6ItaE2d/W5EAVrnIPAVy4/gmv3g2rrg+++lkRWJ1gDkrfKlHIZnNT
         /5VQRGcAchEcuBKowCmSsESX3WyYuVXOWbXi5OMPu7lLznvKxakNK1RH7osO0GWcGTtW
         TEPg==
X-Gm-Message-State: APjAAAVLgt+J9BICouwQoQcR8Oh9ALDEqdvTEV0fU5szNz4B6Eqqt/Oy
        0fcIi4LErQDdBjd2tan0JjQovA==
X-Google-Smtp-Source: APXvYqzC09Q1cp1hmohfvhqGnWmyH+vzmsbzRdbFtc8M6lKAhRHTZLjSeXHo1+LmemD8Qh/4HPS08Q==
X-Received: by 2002:a5d:6912:: with SMTP id t18mr5102548wru.17.1557738962449;
        Mon, 13 May 2019 02:16:02 -0700 (PDT)
Received: from bender.baylibre.local (lmontsouris-657-1-212-31.w90-63.abo.wanadoo.fr. [90.63.244.31])
        by smtp.gmail.com with ESMTPSA id g10sm10795091wrq.2.2019.05.13.02.16.00
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 13 May 2019 02:16:01 -0700 (PDT)
From:   Neil Armstrong <narmstrong@baylibre.com>
To:     ulf.hansson@linaro.org, khilman@baylibre.com
Cc:     baylibre-upstreaming@groups.io,
        Neil Armstrong <narmstrong@baylibre.com>,
        linux-mmc@vger.kernel.org, linux-amlogic@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH 3/3] arm64: dts: meson-g12a: add ddr-access-quirk property to SDIO controller
Date:   Mon, 13 May 2019 11:15:48 +0200
Message-Id: <20190513091548.16674-4-narmstrong@baylibre.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190513091548.16674-1-narmstrong@baylibre.com>
References: <20190513091548.16674-1-narmstrong@baylibre.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The Amlogic G12A SDIO Controller has a bug preventing direct DDR access,
mark this specific controller with the amlogic,ddr-access-quirk property.

Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
---
 arch/arm64/boot/dts/amlogic/meson-g12a.dtsi | 1 +
 1 file changed, 1 insertion(+)

Kevin, the MMC node hasn't been sent yet, when the quirk bindings is
accepted, we will directly send the MMC modes with this property.

Nei

diff --git a/arch/arm64/boot/dts/amlogic/meson-g12a.dtsi b/arch/arm64/boot/dts/amlogic/meson-g12a.dtsi
index 5cbfca00f5cf..d8b3441f0c45 100644
--- a/arch/arm64/boot/dts/amlogic/meson-g12a.dtsi
+++ b/arch/arm64/boot/dts/amlogic/meson-g12a.dtsi
@@ -1061,6 +1061,7 @@
 				 <&clkc CLKID_FCLK_DIV2>;
 			clock-names = "core", "clkin0", "clkin1";
 			resets = <&reset RESET_SD_EMMC_A>;
+			amlogic,ddr-access-quirk;
 		};
 
 		sd_emmc_b: sd@ffe05000 {
-- 
2.21.0

