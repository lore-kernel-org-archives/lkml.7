Return-Path: <SRS0=HtuS=UO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 047F4C31E47
	for <linux-kernel@archiver.kernel.org>; Sat, 15 Jun 2019 10:44:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BDA6C20861
	for <linux-kernel@archiver.kernel.org>; Sat, 15 Jun 2019 10:44:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="MQf6ojqw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726661AbfFOKoF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 15 Jun 2019 06:44:05 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:39442 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725999AbfFOKoE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 15 Jun 2019 06:44:04 -0400
Received: by mail-wm1-f67.google.com with SMTP id z23so4588090wma.4
        for <linux-kernel@vger.kernel.org>; Sat, 15 Jun 2019 03:44:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=S3R0LLQ//2yFv2nqx2NreLb9B1XIfmWQYrxaoZNL4Ck=;
        b=MQf6ojqwu7MV9sf8fWDTviQXFdJqej3YOwrHVJ+F2m/68WDUtAtHzkCB+lHcPCixmr
         tSPH088SJOIAnbJnhxw07fTgiTIR6IhLmQnSdZzn6wksWy2e7G6GV9bDJje8cGjKCNqx
         hckzo6Wi7Xqm1e/a9kQluxyJZvxro9poTdi0DxOUixNPONqjEw9F46KwWbNmfroOpL4M
         ena0Vl2y+0I6wjtMRDT3jTzeubVPcV1U6aRkDe4V0XZgBJ0vWmmUzULR12vdFglChv6j
         FC+7sdl91L888HeoKuNYjFAZwj16J89kS0AfAF+T4jmTDu7Z6BDg4yADViHkRzPsx3BN
         cdKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=S3R0LLQ//2yFv2nqx2NreLb9B1XIfmWQYrxaoZNL4Ck=;
        b=IeRw2WrtlWcaMlXXSDLavWsgxHSa3Dn28YVBT77qNiyMwFTO4HfBi6N7BNAVfGeS+x
         WUcXiExuxbFaaAi2qLI5mO5fZ47vJiSimt0j2h7mdJCa/SJqFDqV/+CeDWAJeLC/Ma0h
         WMvh/9pUBM1tbl8TnZZnn6WUladz+EtYBodu2vx1ijGdNQgHCb7LapoSvq1cCKDD6Qhz
         Px4D6uZpSxJr/S4dBrIQh0MG2BS1Hk+43PRcH3zqNDN4KSwd/fBgtdshGLBy09RbtQ+y
         lxCoke1zF0p4mAyYJHCczLynPjE/wm9kBTyKISakB3iQTyl9aNik39p/AbMNKjgl0pUz
         jF5g==
X-Gm-Message-State: APjAAAV3PC3YgTcICaSlH2rPpjlNoPzPe5MXWOpRpWr1NHF81AIV+BZh
        vGoARfqpXSXmSim9qj3/qAzWrxz+8pE=
X-Google-Smtp-Source: APXvYqz3AGrVhz452+J/j0VdwEw70KSPpUUFJPajmLt/Zzo9mouiFNZ8nzMbqMSyjVK6NYISxyrFng==
X-Received: by 2002:a1c:e709:: with SMTP id e9mr6283589wmh.144.1560595442668;
        Sat, 15 Jun 2019 03:44:02 -0700 (PDT)
Received: from blackbox.darklights.net (p200300F133C20E00A9A405DFDBBC0790.dip0.t-ipconnect.de. [2003:f1:33c2:e00:a9a4:5df:dbbc:790])
        by smtp.googlemail.com with ESMTPSA id l12sm16761120wrb.81.2019.06.15.03.44.01
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Sat, 15 Jun 2019 03:44:01 -0700 (PDT)
From:   Martin Blumenstingl <martin.blumenstingl@googlemail.com>
To:     linux-amlogic@lists.infradead.org, khilman@baylibre.com
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        narmstrong@baylibre.com,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Subject: [PATCH v2 0/2] arm64: dts: g12a/g12b: add the Ethernet PHY GPIO IRQs
Date:   Sat, 15 Jun 2019 12:43:49 +0200
Message-Id: <20190615104351.6844-1-martin.blumenstingl@googlemail.com>
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

This depends on my other series "Ethernet PHY reset GPIO updates for
Amlogic SoCs" from [0]


Changes since v1 at [1]:
- added Neil's Tested/Acked-by (thank you!)
- rebased on top of v3 of my other series
- updated cover-letter since the GPIO interrupt controller support
  is now merged so it's not a dependency anymore


[0] https://patchwork.kernel.org/cover/10997069/
[1] https://patchwork.kernel.org/cover/10985175/


Martin Blumenstingl (2):
  arm64: dts: meson: g12b: odroid-n2: add the Ethernet PHY interrupt
    line
  arm64: dts: meson: g12a: x96-max: add the Ethernet PHY interrupt line

 arch/arm64/boot/dts/amlogic/meson-g12a-x96-max.dts   | 4 ++++
 arch/arm64/boot/dts/amlogic/meson-g12b-odroid-n2.dts | 4 ++++
 2 files changed, 8 insertions(+)

-- 
2.22.0

