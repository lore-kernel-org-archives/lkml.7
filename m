Return-Path: <SRS0=lq4r=TU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CB54CC04AAC
	for <linux-kernel@archiver.kernel.org>; Mon, 20 May 2019 19:44:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A23CB20863
	for <linux-kernel@archiver.kernel.org>; Mon, 20 May 2019 19:44:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="U+BzZHbe"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726076AbfETToF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 May 2019 15:44:05 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:40958 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725554AbfETToF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 May 2019 15:44:05 -0400
Received: by mail-wr1-f66.google.com with SMTP id f10so513570wre.7;
        Mon, 20 May 2019 12:44:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=hVta5xB/O0QdvUGc5eYkdvpzELli1ZpHwr59R5nENcw=;
        b=U+BzZHbeO1KY+dPmw/oGi3XSWlv90ycsDjx9KXI1IOImK13sc2HFLTbDBRkR1LHxH6
         +if9w9trTLebLbFzw3M2MkHFy67mF0vIIMh9//saXEcs78CYk6pfEuM2T+Yo/SbreWdx
         AUUgrkT+kPv4wm0NkTZmHzygH6OHSaOC0iGu1JsRjSWS8IK6o8lKSygaqCQIPSB9wnCd
         SQ5+pRE308Avd7zKs4DRKUUYXogC/Ay3rtZU00hDgCKcErpndPWlTi89LYl5r8fVPjvi
         O6X8lAzlYYv2egbSv9M2ilcFmWDuOVKlX/BQGBGwc91NrmxKpNuizf6i/JBen7cCTP7l
         BPmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=hVta5xB/O0QdvUGc5eYkdvpzELli1ZpHwr59R5nENcw=;
        b=rRDYQbpYhV6FXafwA6vasbSDPaFq3pw0F8UYJyzN/ktXSgiVJmnNNMu0BxLBFTtx7S
         6b6/j0B3H4s/GA09637rsfjXDOud8KftOprsAxCBZUM8Spl9NqDvQ+ws6mgXrrx6BwIi
         zsUtK8otxpBH3LhyDbM1ZU30Q3ohj/zqtPHUXzcb+XPT7ax8FsR2yWvOP25napx6SDCf
         8jnqlhhtXYU4rghRs6MF+Te/vFWqJuzHw3etYkNmrie0cGX1IQ9n8bHSLIWoy59uc/Bk
         qQuY7E/hYO3Jm5RNVGBlkHBPxTym2lYe7SUvee8Svu5VRpJNUAEhGozk7nWrGuAFQH6+
         RnxA==
X-Gm-Message-State: APjAAAU9ajs35dPEmyuJY1ptUvflYTSLGOycwzODIfBC1yI+MP0HUQzf
        XX6OZWwqR56zYnB21NKB2qU=
X-Google-Smtp-Source: APXvYqynMyqoH9GhYe+AN/gAgwqbO94OY9y/bT/SijzrVrRAbf9a6+TW6auDD4ShFC3FSuOOiz30pg==
X-Received: by 2002:a5d:6b03:: with SMTP id v3mr2725642wrw.309.1558381443684;
        Mon, 20 May 2019 12:44:03 -0700 (PDT)
Received: from blackbox.darklights.net (p200300F133EE71009C356FA1F0E19AF9.dip0.t-ipconnect.de. [2003:f1:33ee:7100:9c35:6fa1:f0e1:9af9])
        by smtp.googlemail.com with ESMTPSA id p8sm9135352wro.0.2019.05.20.12.44.02
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 20 May 2019 12:44:02 -0700 (PDT)
From:   Martin Blumenstingl <martin.blumenstingl@googlemail.com>
To:     linux-amlogic@lists.infradead.org, khilman@baylibre.com,
        mjourdan@baylibre.com, robh+dt@kernel.org, mark.rutland@arm.com,
        devicetree@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Subject: [PATCH v2 0/5] 32-bit Meson: add the canvas module
Date:   Mon, 20 May 2019 21:43:48 +0200
Message-Id: <20190520194353.24445-1-martin.blumenstingl@googlemail.com>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This adds the canvas module on Meson8, Meson8b and Meson8m2. The canvas
IP is used by the video decoder hardware as well as the VPU (video
output) hardware.

Neither the VPU nor the video decoder driver support the 32-bit SoCs
yet. However, we can still add the canvas module to have it available
once these drivers gain support for the older SoCs.

I have tested this on my Meson8m2 board by hacking the VPU driver to
not re-initialize the VPU (and to use the configuration set by u-boot).
With that hack I could get some image out of the CVBS connector. No
changes to the canvas driver were required.

Due to lack of hardware I could not test Meson8, but I'm following (as
always) what the Amlogic 3.10 vendor kernel uses.
Meson8b is also not tested because u-boot of my EC-100 doesn't have
video output enabled (so I couldn't use the same hack I used on my
Meson8m2 board).

This series meant to be applied on top of "Meson8b: add support for the
RTC on EC-100 and Odroid-C1" from [0]


changes since v1 at [1]:
- added new bindings for the 32-bit SoCs because they don't support the
  "endianness" configuration (new patch #1, thanks to Maxime Jourdan
  for pointing this out)
- update the driver to reject the "endianness" configuration on the
  32-bit SoCs (new patch #2)
- patches #3 to #5 haven't changed compared to v1


[0] https://patchwork.kernel.org/cover/10899509/
[1] https://patchwork.kernel.org/cover/10899565/


Martin Blumenstingl (5):
  dt-bindings: soc: amlogic: canvas: document support for Meson8/8b/8m2
  soc: amlogic: canvas: add support for Meson8, Meson8b and Meson8m2
  ARM: dts: meson8: add the canvas module
  ARM: dts: meson8m2: update the offset of the canvas module
  ARM: dts: meson8b: add the canvas module

 .../bindings/soc/amlogic/amlogic,canvas.txt   | 10 ++++++---
 arch/arm/boot/dts/meson8.dtsi                 | 22 +++++++++++++++++++
 arch/arm/boot/dts/meson8b.dtsi                | 22 +++++++++++++++++++
 arch/arm/boot/dts/meson8m2.dtsi               | 10 +++++++++
 drivers/soc/amlogic/meson-canvas.c            | 14 +++++++++++-
 5 files changed, 74 insertions(+), 4 deletions(-)

-- 
2.21.0

