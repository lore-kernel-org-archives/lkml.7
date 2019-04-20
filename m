Return-Path: <SRS0=ruH4=SW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 04C92C282DD
	for <linux-kernel@archiver.kernel.org>; Sat, 20 Apr 2019 09:33:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B81B62087F
	for <linux-kernel@archiver.kernel.org>; Sat, 20 Apr 2019 09:33:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="LJsLFwpq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727519AbfDTJdP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 20 Apr 2019 05:33:15 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:51353 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725920AbfDTJdO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 20 Apr 2019 05:33:14 -0400
Received: by mail-wm1-f68.google.com with SMTP id 4so8625523wmf.1
        for <linux-kernel@vger.kernel.org>; Sat, 20 Apr 2019 02:33:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=LlwusV5xkrlPrMvp3F6BsXTUrYiLIFI2XvB6iP5cgFk=;
        b=LJsLFwpquTfoWgpcKDZr4tlhW62nbLMAZTfSrg+97SjPTIAm5ZKKlU1uMHBRBQ0c0k
         CCNT9j2z/C5+2lbW0xLV7LzipRgue8kF8i9faFB1im3XB5Z0maSXvkqOid7rAq19JFWt
         T/t9rf/ANQQFhF44q5mc6x8zKcGpYYEkNmTruJNPXlD9OjshIblHSbYZbUEXfxQUoHDB
         d24jEWSDtWkGGnfvkyZGW6JvWDaaA31UkmhD+3NZTFuXnaS3u266p+Xtj4pqAkYUbdW/
         q5+WKbXc2FkH2pyQ0Q6QpTZn+ycb8oOvIbs6abOfUskTKb86iksaeytI6wjbV6Yrb5uw
         59qQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=LlwusV5xkrlPrMvp3F6BsXTUrYiLIFI2XvB6iP5cgFk=;
        b=bYUdGqX5g1XOAtth0ymOzHudlZRXPr1sNGJYIKL5Ko0rZ01e5Cv6jCsp2cc+snVtHE
         P3t880cuo7/EI+rWbSjRiXkaGu7ExSDcbLGfDoW7QnUSVreLcIwPC8hq4nBu69CXY+OZ
         KRFxCY54lPcJbtoPTruq+2C0mqPMbUuqseOuQzd/Acs2t+wHABxp1RuHqTT4e7j7ZbVy
         KQvNln4U2jJs2jywemYcPzldCqfxaststqZL8S5lJ5CE2dXVr0/EfomgDSAfndjQ8aFq
         9uCeVBP7l2jzh/pxZmyAyVHjIP052oyYwOp72AE59uOdHPVkdMWWWvrFRqkl9NXbjhTK
         Vm4g==
X-Gm-Message-State: APjAAAUP1rLiW4rvHekzQj5t4xoTjAP73FXxhjnE+rU3iAhG4ql+5MOM
        bJcUQ9YpZqnOoQd7SwcXc+c=
X-Google-Smtp-Source: APXvYqyOm16IL7NomyQEgKcwNH2Yz97yqIwRk456Tr7o8sFhFjDbNFHfsWTwT0nv8hrxqjbXNj4/dQ==
X-Received: by 2002:a7b:c086:: with SMTP id r6mr5220402wmh.123.1555752792829;
        Sat, 20 Apr 2019 02:33:12 -0700 (PDT)
Received: from blackbox.darklights.net (p200300F133C8AD0028C4739A57449001.dip0.t-ipconnect.de. [2003:f1:33c8:ad00:28c4:739a:5744:9001])
        by smtp.googlemail.com with ESMTPSA id w11sm12858244wre.15.2019.04.20.02.33.11
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 20 Apr 2019 02:33:11 -0700 (PDT)
From:   Martin Blumenstingl <martin.blumenstingl@googlemail.com>
To:     linux-amlogic@lists.infradead.org, khilman@baylibre.com
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Subject: [PATCH 0/2] ARM: dts: meson: two GPU fixes
Date:   Sat, 20 Apr 2019 11:32:56 +0200
Message-Id: <20190420093258.2012-1-martin.blumenstingl@googlemail.com>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

While switching over to the main mesa git repository I was testing
kmscube again. On my Meson8m2 board I noticed that two interrupts were
correctly set up. This didn't cause any errors so far because on my
setup the lima driver is using the "pp_bcast" interrupt instead of
ppX and ppmmuX.

While fixing the interrupt lines I also noticed that I accidentally
left the switch-delay property in there. That was needed at some
point to run the out-of-tree lima kernel driver. It's not required
anymore and it's not documented so drop it.

Target release: v5.2 (if possible because this is where the lima kernel
driver will land). No need to send it for v5.1-rcX because there lima
driver won't be part of v5.1.


Martin Blumenstingl (2):
  ARM: dts: meson8: fix GPU interrupts and drop an undocumented property
  ARM: dts: meson8b: drop undocumented property from the Mali GPU node

 arch/arm/boot/dts/meson8.dtsi  | 5 ++---
 arch/arm/boot/dts/meson8b.dtsi | 1 -
 2 files changed, 2 insertions(+), 4 deletions(-)

-- 
2.21.0

