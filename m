Return-Path: <SRS0=Ymnc=YU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 98C9ECA9EAF
	for <linux-kernel@archiver.kernel.org>; Sun, 27 Oct 2019 16:18:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6F27D214AF
	for <linux-kernel@archiver.kernel.org>; Sun, 27 Oct 2019 16:18:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="J1puDYWl"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727684AbfJ0QSS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 27 Oct 2019 12:18:18 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:56130 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727258AbfJ0QSQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 27 Oct 2019 12:18:16 -0400
Received: by mail-wm1-f66.google.com with SMTP id g24so6950161wmh.5;
        Sun, 27 Oct 2019 09:18:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=fzxJHdWe3FCszZKpIfTnAoSqGWjqpiAHUUSq7m5VVx4=;
        b=J1puDYWlQm8AmK/pphEqz3Tmiwv+jP4W/murkGnYs+HHoegmq7/3IEgAn2E5ZO93Sx
         BQuNtFthdu93/m09qB/qiUX+2Nk71lhUnadCGqIuTzBjKUppvjxBxIQtnzAWPdaGC+jL
         swavw60rQxN5LvewsVpVK+aRqeGIVOdOpwCieY3foNi2HbxPbzzbIcbozdYTiPx3zwwI
         guqi2UEL5D31jdF4In8QohisZQaYjgXrUbW81Vb0hHf8JK1eNbVo/zeON0TlviWjIo+y
         54IzN9HCFevVnM1CPiuXgvvAkobz7LSCiuPFAqibsLfubC1XegW0Vd+ziy/XfXp8DT8z
         qGNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=fzxJHdWe3FCszZKpIfTnAoSqGWjqpiAHUUSq7m5VVx4=;
        b=JX+3U0l9+aNMmFLqT3zkrwKJ/dhNDFoVHMnI/vB7TsejhtIG/2+J4cwJMdOUhAFSX8
         H6FpyZKs4N964etmti1+9iGhADw/e2Ghr1nYCacddmNJ97mjlZb+OJukGAbIznlucP+W
         RFl+JeW2fp5hmokNwx8tYn3FnzmBDd6kdpMRvtwqw4TrTZgqHMppMY2Fq6cqJjdejzsO
         r1gx/kEtRvMDSI3x43K1IYanO+4SV8W0KMZC0Ea2/1B4slInP5yHONbOiDknbUF4FK0u
         8xVLe/x/qaTV/AyNVIa3r/2fYcGJ1vicZsBXL0Jg+8CToZvKG2Ssn/jywmw7fnTnQXpB
         xuiQ==
X-Gm-Message-State: APjAAAUPsVu5YHel7Qrt5JQRkaMb30eZ4SvuI7uxeVs/N01vmGZwK0P+
        9cq8IoLc2bVXZNhefUPhOGghMczAEG0MvQ==
X-Google-Smtp-Source: APXvYqxArGQ2A5p0zyY9Lwm4fMAnRlV3pFBQpHzOz3hdCU27iLZp3shZOqLi87k185MCm7c/ed5U3w==
X-Received: by 2002:a7b:c011:: with SMTP id c17mr12464869wmb.95.1572193092324;
        Sun, 27 Oct 2019 09:18:12 -0700 (PDT)
Received: from localhost.localdomain (p200300F133D01300428D5CFFFEB99DB8.dip0.t-ipconnect.de. [2003:f1:33d0:1300:428d:5cff:feb9:9db8])
        by smtp.googlemail.com with ESMTPSA id j14sm9585014wrj.35.2019.10.27.09.18.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 27 Oct 2019 09:18:10 -0700 (PDT)
From:   Martin Blumenstingl <martin.blumenstingl@googlemail.com>
To:     narmstrong@baylibre.com, jbrunet@baylibre.com,
        linux-amlogic@lists.infradead.org, khilman@baylibre.com
Cc:     robh+dt@kernel.org, mark.rutland@arm.com,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-clk@vger.kernel.org,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Subject: [PATCH v2 0/5] provide the XTAL clock via OF on Meson8/8b/8m2
Date:   Sun, 27 Oct 2019 17:18:00 +0100
Message-Id: <20191027161805.1176321-1-martin.blumenstingl@googlemail.com>
X-Mailer: git-send-email 2.23.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

So far the HHI clock controller has been providing the XTAL clock on
Amlogic Meson8/Meson8b/Meson8m2 SoCs.
This is not correct because the XTAL is actually a crystal on the
boards and the SoC has a dedicated input for it.

This updates the dt-bindings of the HHI clock controller and defines
a fixed-clock in meson.dtsi (along with switching everything over to
use this clock).
The clock driver needs three updates to use this:
- patch #2 uses clk_hw_set_parent in the CPU clock notifier. This drops
  the explicit reference to CLKID_XTAL while at the same time making
  the code much easier (thanks to Neil for providing this new method
  as part of the G12A CPU clock bringup!)
- patch #3 ensures that the clock driver doesn't rely on it's internal
  XTAL clock while not losing support for older .dtbs that don't have
  the XTAL clock input yet
- with patch #4 the clock controller's own XTAL clock is not registered
  anymore when a clock input is provided via OF

This series is a functional no-op. It's main goal is to better represent
how the actual hardware looks like.


Changes since v1 at [0]:
- add Rob's Reviewed-by to the dt-bindings patch
- check that "xtal" clock is actually passed via OF instead of checking
  that there's any parent at all (which in the worst case may not be the
  xtal clock) as suggested by Jerome
  

[0] https://patchwork.kernel.org/cover/11155515/


Martin Blumenstingl (5):
  dt-bindings: clock: meson8b: add the clock inputs
  clk: meson: meson8b: use clk_hw_set_parent in the CPU clock notifier
  clk: meson: meson8b: change references to the XTAL clock to use the
    name
  clk: meson: meson8b: don't register the XTAL clock when provided via
    OF
  ARM: dts: meson: provide the XTAL clock using a fixed-clock

 .../bindings/clock/amlogic,meson8b-clkc.txt   |   5 +
 arch/arm/boot/dts/meson.dtsi                  |   7 ++
 arch/arm/boot/dts/meson6.dtsi                 |   7 --
 arch/arm/boot/dts/meson8.dtsi                 |  15 +--
 arch/arm/boot/dts/meson8b-ec100.dts           |   2 +-
 arch/arm/boot/dts/meson8b-mxq.dts             |   2 +-
 arch/arm/boot/dts/meson8b-odroidc1.dts        |   2 +-
 arch/arm/boot/dts/meson8b.dtsi                |  15 +--
 drivers/clk/meson/meson8b.c                   | 106 +++++++++---------
 9 files changed, 87 insertions(+), 74 deletions(-)

-- 
2.23.0

