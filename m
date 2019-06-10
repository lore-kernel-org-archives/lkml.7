Return-Path: <SRS0=f7FU=UJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66D4FC31E40
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Jun 2019 16:45:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 360D4206C3
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Jun 2019 16:45:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="dLs3GkEG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727947AbfFJQpl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Jun 2019 12:45:41 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:37831 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726363AbfFJQpl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jun 2019 12:45:41 -0400
Received: by mail-wr1-f68.google.com with SMTP id v14so9895260wrr.4
        for <linux-kernel@vger.kernel.org>; Mon, 10 Jun 2019 09:45:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=atD0PAi5sOPjSTIUUiE9fFF80lpCvQQKnWdofwI4CI8=;
        b=dLs3GkEG06LBImSCtU4a4V8jXEuk8rKwMUHm/kWB8kFTH1DYKZXAc5sf8OLn11z4Qi
         CT518WxPuKwwWBMO5Cht9KvgWQmqpjALn6YS94P4IM+0OEbL6aNxKpvwMlmoanOEG8e1
         sr6+yB0LwZxDJmkipEhPMBL7em/oi+hHiIqlfqZBhwxaPN3perkctaBNG2sRbs9+gY6Z
         V/Dkx0SVfgqYKC9yXWIiOx3mpC9GguyMzUFfaqe5Wu5g84L4IDygZjWfgp7rW8hFMbp2
         NysgQxSw1r0XKDeLLCvlCECQF6nIHnzEvUxNdnWyI7KsZ6TmEM0zQgJgznSPfNesMR0d
         O39w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=atD0PAi5sOPjSTIUUiE9fFF80lpCvQQKnWdofwI4CI8=;
        b=Ukr8ZTeSvzHZoFEJAeqmlsWUnagjRP+JZMTEyJ0lm6O9wMrRzpJufuSKhBvRQfQhIC
         I490mfkD3LxmrPzdzAQOqboWccIsvyyb8Xs9+czVaYxOQ45BkQMdTfIv3TJYpgaOrj9C
         8hZd+DDm43vmOxLCeJ72PQOtc4Bcfs63y+mmfaGUnLRp3Ifmc9qvY4XADbBrwLc/uLf0
         CgEEnaWyanZYSyJVayhnRCbr29kdvpRjeVAwqsqkh1sKjCflrhMp0euQqjF1lquPDz9e
         6PS7wdfxiiKMWZRExXGRXPXBS6Gro+GR2myR5rlXZPKX4ZXoMatBYBUF5TOwnKIVEexK
         lVRA==
X-Gm-Message-State: APjAAAURbDW9FZnud5iFcrljLgJLzPlral+RJr7wMcnGsnp3mn9wcMk9
        wynSwEP3R8jWTvBQDfcDtLXn9pjU
X-Google-Smtp-Source: APXvYqwAlPuwzIPq1MSOToglEmT/DFNbT0pEDv8nx8cpyBG5z+0hTiPXvPFfRewOCOPc/g9BnsUZOw==
X-Received: by 2002:a5d:5510:: with SMTP id b16mr11138175wrv.267.1560185139530;
        Mon, 10 Jun 2019 09:45:39 -0700 (PDT)
Received: from blackbox.darklights.net (p200300F133DDA40000C4C39937FBD289.dip0.t-ipconnect.de. [2003:f1:33dd:a400:c4:c399:37fb:d289])
        by smtp.googlemail.com with ESMTPSA id g17sm11441158wrm.7.2019.06.10.09.45.38
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Mon, 10 Jun 2019 09:45:39 -0700 (PDT)
From:   Martin Blumenstingl <martin.blumenstingl@googlemail.com>
To:     linux-amlogic@lists.infradead.org, khilman@baylibre.com
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Subject: [PATCH 0/2] arm64: dts: g12a/g12b: add the Ethernet PHY GPIO IRQs
Date:   Mon, 10 Jun 2019 18:45:29 +0200
Message-Id: <20190610164531.8303-1-martin.blumenstingl@googlemail.com>
X-Mailer: git-send-email 2.22.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Avoid polling of the PHY status by passing the Ethernet PHY's GPIO
interrupt line to the PHY node.

I tested this successfully on my X96 Max, but I don't have an Odroid-N2
to test it there. The reset and interrupt GPIO part of the schematics
seems to be identical for both boards (and probably other "reference
design" based boards as well).

This depends on two of my other series:
1. "irqchip/meson-gpio: Add support for Meson-G12A SoC" from [0]
2. "Ethernet PHY reset GPIO updates for Amlogic SoCs" from [1]


[0] https://patchwork.kernel.org/cover/10983339/
[1] https://patchwork.kernel.org/cover/10985155/


Martin Blumenstingl (2):
  arm64: dts: meson: g12b: odroid-n2: add the Ethernet PHY interrupt
    line
  arm64: dts: meson: g12a: x96-max: add the Ethernet PHY interrupt line

 arch/arm64/boot/dts/amlogic/meson-g12a-x96-max.dts   | 4 ++++
 arch/arm64/boot/dts/amlogic/meson-g12b-odroid-n2.dts | 4 ++++
 2 files changed, 8 insertions(+)

-- 
2.22.0

