Return-Path: <SRS0=tJqY=VY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 16F0BC7618B
	for <linux-kernel@archiver.kernel.org>; Sat, 27 Jul 2019 12:13:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EF6CC2070B
	for <linux-kernel@archiver.kernel.org>; Sat, 27 Jul 2019 12:13:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="LOmDlDmr"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728848AbfG0MNF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 27 Jul 2019 08:13:05 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:53358 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725975AbfG0MNF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 27 Jul 2019 08:13:05 -0400
Received: by mail-wm1-f68.google.com with SMTP id x15so50053412wmj.3
        for <linux-kernel@vger.kernel.org>; Sat, 27 Jul 2019 05:13:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=fLCia4qh4Cz22hDttZ6msu77sYqghs6856wL5uLXMuE=;
        b=LOmDlDmr1mz6xDDDjD9Y6KhsxGGc5GpRbfnI8QeCXhKDk54z0oBtJ1FEgORz0p5lO7
         6cChwq0j9UmxyrLrL9EzoXqkyp2qNqX6f8/GHtDo1jZ2HncQAYSMiesfCBFyTds5T/ZN
         2D5DOxJgkDNbPqtnph+G2sRJet+7bs7jSP9jd9YMvJI7O9Df3bmxUTGhfm4113MHcmJA
         6z7bLPkWVBx3WARW/BKwItf8xmsdf7a14Y+qKbxtN8f1D8149s/T0oyaPADmZ4Rv4xfu
         Fz4sVS/RFdsbadw0wttxkY/65mEE4vgvMOfltXj0Ii3u2e98AjbUyZ1RHh0b57fPiLIc
         CRCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=fLCia4qh4Cz22hDttZ6msu77sYqghs6856wL5uLXMuE=;
        b=TBC/PERpv5IZ9itYNfmGeW9F/yfo0gt7qJxArcm0plYTjHSeA9zumt/8tLEUoRGrUW
         A8K59rjnjB1e30k1IfwqHgRKc9Lvkl/BNw5hzUDqBRNIKScrT+l6M3RRz5Nt+SgurD5u
         Vf//5AXu6XUVFB5az9BnZJ3lniLreI/2fDYYmWI+GX3gm9PboCzCevmf2wREsJaOkf5n
         13H2v5RSXQOzS8MYs2LTgZMPOgpfBTIsXwPkCFGDp4AUBFUymPugFBm8T/9th9LZYQGK
         rY47vtYKBWab9co4svWVNDzUd5mGr4SSvU+Jt8oaW7IT3yNEuBIM/4A6VKSOWjqVBAd7
         oO3A==
X-Gm-Message-State: APjAAAXxxzs9Hrl7iYqukmFph9im0TmP4F2paHvFf7iSz63AXU+zLdmY
        XDZwF461yf+tvIExk3Hi0WU=
X-Google-Smtp-Source: APXvYqwO2obe1eiMHV1lLLa64dyAAI5GwwX9D2mKtH94uAOPDREuajftYBx7vCdviI6FTZ4AfFG5hg==
X-Received: by 2002:a1c:345:: with SMTP id 66mr91417990wmd.8.1564229583045;
        Sat, 27 Jul 2019 05:13:03 -0700 (PDT)
Received: from blackbox.darklights.net (p200300F133C65C00B418D0F4A25A19EC.dip0.t-ipconnect.de. [2003:f1:33c6:5c00:b418:d0f4:a25a:19ec])
        by smtp.googlemail.com with ESMTPSA id o26sm111786569wro.53.2019.07.27.05.13.01
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Sat, 27 Jul 2019 05:13:02 -0700 (PDT)
From:   Martin Blumenstingl <martin.blumenstingl@googlemail.com>
To:     linux-amlogic@lists.infradead.org, khilman@baylibre.com
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Subject: [PATCH v2 0/4] ARM: dts: meson8b: add VDDEE / mali-supply
Date:   Sat, 27 Jul 2019 14:12:53 +0200
Message-Id: <20190727121257.18017-1-martin.blumenstingl@googlemail.com>
X-Mailer: git-send-email 2.22.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

EC-100 and Odroid-C1 use a "copy" of the VCCK regulator as "VDDEE"
regulator. VDDEE supplies the Mali GPU and various other bits within
the SoC.

The VDDEE regulator is not exclusive to the Mali GPU so it must not
change it's voltage. The GPU OPP table has a fixed voltage for all
frequencies of 1.10V. This matches with what u-boot sets on my EC-100
and Odroid-C1.

Changes since v1 at [0]:
- fixed node name for Odroid-C1 (which was vcck instead of vddee in v1)
- updated cover-letter since all dependencies made it into v5.3-rc1
- rebased onto v5.3-rc1


[0] https://patchwork.kernel.org/cover/10961091/


Martin Blumenstingl (4):
  ARM: dts: meson8b: add the PWM_D output pin
  ARM: dts: meson8b: ec100: add the VDDEE regulator
  ARM: dts: meson8b: odroidc1: add the VDDEE regulator
  ARM: dts: meson8b: mxq: add the VDDEE regulator

 arch/arm/boot/dts/meson8b-ec100.dts    | 31 +++++++++++++++++++++++---
 arch/arm/boot/dts/meson8b-mxq.dts      | 26 ++++++++++++++++++---
 arch/arm/boot/dts/meson8b-odroidc1.dts | 27 +++++++++++++++++++---
 arch/arm/boot/dts/meson8b.dtsi         |  8 +++++++
 4 files changed, 83 insertions(+), 9 deletions(-)

-- 
2.22.0

