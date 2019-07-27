Return-Path: <SRS0=tJqY=VY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96F1EC76186
	for <linux-kernel@archiver.kernel.org>; Sat, 27 Jul 2019 19:47:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 533F22064A
	for <linux-kernel@archiver.kernel.org>; Sat, 27 Jul 2019 19:47:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="Q6OtNLAb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388246AbfG0TrK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 27 Jul 2019 15:47:10 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:34321 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387890AbfG0TrJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 27 Jul 2019 15:47:09 -0400
Received: by mail-wm1-f66.google.com with SMTP id w9so40222254wmd.1
        for <linux-kernel@vger.kernel.org>; Sat, 27 Jul 2019 12:47:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=G+3WZjP7t2c3MrxGBkykjVbFHd8lOWzlUy5DQ+uWLUE=;
        b=Q6OtNLAbEJJib3vgdqU0w3Hbvmi7fV5CHysk66nylrKE58lqu1BtdTnDU1VCIiQRey
         Ygjmy2MQ+DRtmHsSXu9ItrEKM2vCi37kAj3ML0SPsgES8Jj8SUFoCkyZApz/eZ+wxu8C
         N6lD/VfJyZTU2QzS7iOqtKBhjgtybFoPqmUG7c/QU1WbObojh4iF/L7VRhDYGcyFz07f
         4wSjkx9t+Bk65HenKqzVQqitsOJB1eDLlUUbTGVRqUg1LQvkgyOTSoKYMjhl7SfdvAqI
         eDwu65ReG9R9pS45jsxZfPu02JfaSXtQwcp+PDbcTrJnaclCQ6z/L+m10H3TgbnJnhIt
         OrxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=G+3WZjP7t2c3MrxGBkykjVbFHd8lOWzlUy5DQ+uWLUE=;
        b=Xjfymd4vg5vIElEOrqk+fexa4M6/qMndWjoeCHBh7P3s1/cBL7kKcCKxAcilEsOTBn
         LfOUX+bEfqWyRwwqEgVMC2jlNXRVsvbFTWZevIIyQvuvUwdeXp36Ui8jakuoz4XZE7zT
         jWCMArylY6jHK5MqYl94MdNb2jS3a/P/MhiBh7fU+8vTToX5+eOQVVg6Hi9Dn//JFuWo
         IjmaYoAxAiYOCsUxTbNvmJ+pkOoqxVRxLDwMhWOcDK0rRLwBdOC1qQbEOXmt91ag73a5
         d9EsovhsA3DP1UpLlB2ykX8oPK40+x3GXM8ofsxnB2ZmEqCKffBmc56B+vejw0fIIygX
         pMvA==
X-Gm-Message-State: APjAAAXHlhFxFeaKCEOO0yvi6pzD2Skv1hVowgl3Gji0ds7B5YigBmGX
        qKuOExG350uYohgp5zd2ZbDByIxY
X-Google-Smtp-Source: APXvYqzOFRZqA8EOJZWI93/akWTx45etbPraNxCABgu2JkvQ2zD3E+Uicc3/5VHwDKM7ZY+Iwm7WTg==
X-Received: by 2002:a05:600c:24a:: with SMTP id 10mr11358651wmj.7.1564256827873;
        Sat, 27 Jul 2019 12:47:07 -0700 (PDT)
Received: from blackbox.darklights.net (p200300F133C65C00B418D0F4A25A19EC.dip0.t-ipconnect.de. [2003:f1:33c6:5c00:b418:d0f4:a25a:19ec])
        by smtp.googlemail.com with ESMTPSA id c4sm44651726wrt.86.2019.07.27.12.47.06
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Sat, 27 Jul 2019 12:47:07 -0700 (PDT)
From:   Martin Blumenstingl <martin.blumenstingl@googlemail.com>
To:     linux-amlogic@lists.infradead.org, khilman@baylibre.com
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux.amoon@gmail.com, ottuzzi@gmail.com,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Subject: [PATCH 0/2] ARM: dts: meson8b: persistent MAC address for Odroid-C1
Date:   Sat, 27 Jul 2019 21:46:45 +0200
Message-Id: <20190727194647.15355-1-martin.blumenstingl@googlemail.com>
X-Mailer: git-send-email 2.22.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series makes Odroid-C1 use the MAC address which is programmed into
the eFuse.

build-time dependencies:
patches are based on top of "ARM: dts: meson8b: add VDDEE / mali-supply"
from [0]

runtime dependencies (without these a random MAC address is assigned,
just like before these patches):
- "nvmem: meson-mx-efuse: allow reading data smaller than word_size"
  from [1]
- "net: stmmac: manage errors returned by of_get_mac_address()" from [2]


[0] https://patchwork.kernel.org/cover/11062361/
[1] https://patchwork.kernel.org/patch/11062659/
[2] https://patchwork.kernel.org/patch/11062657/


Martin Blumenstingl (2):
  ARM: dts: meson8b: add the nvmem cell with the board's MAC address
  ARM: dts: meson8b: odroidc1: use the MAC address stored in the eFuse

 arch/arm/boot/dts/meson8b-odroidc1.dts | 3 +++
 arch/arm/boot/dts/meson8b.dtsi         | 4 ++++
 2 files changed, 7 insertions(+)

-- 
2.22.0

