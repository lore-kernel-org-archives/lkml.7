Return-Path: <SRS0=OfNL=RF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 09F93C43381
	for <linux-kernel@archiver.kernel.org>; Sat,  2 Mar 2019 10:41:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C444A20836
	for <linux-kernel@archiver.kernel.org>; Sat,  2 Mar 2019 10:41:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cUuSR4VZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726270AbfCBKla (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 2 Mar 2019 05:41:30 -0500
Received: from mail-ed1-f65.google.com ([209.85.208.65]:34725 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726019AbfCBKla (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 2 Mar 2019 05:41:30 -0500
Received: by mail-ed1-f65.google.com with SMTP id a16so442459edn.1;
        Sat, 02 Mar 2019 02:41:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=yqapotUBswQEf8ok7L3gakhHsDt2IajmTUF6p7XEmWs=;
        b=cUuSR4VZQho5CoaMeIZGFEfXxNDa6YfjqpUiPL9NJlhEG2BylQOPsIzYboRfboqbp8
         f8NRv/QpmjkMZe5xOUfZolI5qKcjxt9huwUkzBW+xKlX9++locVO7bwMOrXv5nv1N7lw
         L8ovTpNbwVPPI1/ujRmx8eldnLuuBGG/CWHwdIc43fF5NtiS0qIIgrKBFii7KyWhEtwu
         qj7cEkuiIwRGc9E93nmmXou92dcHZyg+Tq627MpgigKwKl+4sCE9v5n3/6FalaQ1fTV2
         9gFIDHbvILcdH9j+/jLPvTcA7FEoWnnELgg+04Ad7BsXyNMOP51rEvoXPAfdgrJ1KHmQ
         dvxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=yqapotUBswQEf8ok7L3gakhHsDt2IajmTUF6p7XEmWs=;
        b=kDLg5tHVemClWphMnQGUCHDxX2gyR/r0beZ1KCfuztz3qhmnPtfQHJ0kwgdPT3wiXs
         saCshdSAdfklIAP3VHFgZVtDhs7nmTJZ0mRYszJnUFCMnCINQsQ2lAwZQdQodCGhUC7P
         HdcYC2L5Vgykjkjz8wvFHBo1SapYQNrawXGnqlDiycbtq1lsW1dJg+O7HWVnlXVPUr+T
         96ouFJfqFoQHPCB+xLYT2B2sjtuDMjDoHV9hHqlKy/9nH8F6Xh/N5Wu8t961lhF0M07q
         U7rOPetmGL3d0N9k79EezUDHLNYTeBR/fi1EU6KCNeoaqI7epEx78c5+oJVCyvUO0bVl
         nREw==
X-Gm-Message-State: APjAAAVj/RGlEH8oYkDtCbMHsnrGwl8Xuu5A+nwfnjDhqmMk/0Hrpwvq
        +GGzp3IwzDC4FevRIF3yKqv+3Hzj
X-Google-Smtp-Source: APXvYqzpH9Uee0E3uLJ/74OoWdxN74YQHI8N5pg48XwgHhEy5c4+HwiNEqz913V0wdkWWlRYcv0osQ==
X-Received: by 2002:a50:8992:: with SMTP id g18mr7662263edg.216.1551523288107;
        Sat, 02 Mar 2019 02:41:28 -0800 (PST)
Received: from debian.home (ip51ccf9cd.speed.planet.nl. [81.204.249.205])
        by smtp.gmail.com with ESMTPSA id 36sm247711edz.58.2019.03.02.02.41.26
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 02 Mar 2019 02:41:27 -0800 (PST)
From:   Johan Jonker <jbx6244@gmail.com>
To:     heiko@sntech.de
Cc:     hjc@rock-chips.com, airlied@linux.ie, daniel@ffwll.ch,
        robh+dt@kernel.org, mark.rutland@arm.com,
        dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH v3 0/4] Enable rk3066 VOP and HDMI for MK808
Date:   Sat,  2 Mar 2019 11:41:12 +0100
Message-Id: <20190302104116.1535-1-jbx6244@gmail.com>
X-Mailer: git-send-email 2.11.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Version: V3

Title: Enable rk3066 VOP and HDMI for MK808.

This patch serie only works in combination with a MK808 TV stick and
a rk3066 processor. Other boxes and tablets with a rk3066
need extra software for power management and lcd's.

What does it do:

With these kernel patches a MK808 can show 2 penguins and a console
on a DVI-D monitor in combination with a framebuffer.

Not tested:

HDMI TV
DRM
Xorg
Display managers
Android
etc.

Problems:

DRM functions keep changing every rc
With v5.0-rc8 the monitor doesn't blank on poweroff, it freezes
Fixed screen size for DVI-D.
HDMI sound not included.
etc.

///////////////////////////////////////////

Changes V2 > V3:

updated to v5.0-rc8
removed patches that are already added to linux-next

rk3066_hdmi.c
  removed gpl text
  small style changes
  removed unused includes
  add include for:
    drm_helper_hpd_irq_event
    drm_helper_probe_single_connector_modes
  update drm_hdmi_avi_infoframe_from_display_mode function call

rk3066_hdmi.h
  removed gpl text

rk3066a.dtsi
  add extra port for hdmi connector node

rk3066a-mk808.dts
  add hdmi connector node
  connect hdmi_out with hdmi_con_in

rk3066-hdmi.txt
  add extra port for hdmi connector node

///////////////////////////////////////////

# How to make rkfs.cpio

find . | cpio -o --format=newc > ../rkfs.cpio

# How to compile/flash

make menuconfig  ARCH=arm CROSS_COMPILE=/usr/bin/arm-linux-gnueabi-
make -j4  ARCH=arm CROSS_COMPILE=/usr/bin/arm-linux-gnueabi-

cp ./arch/arm/boot/zImage ../zImage-dtb
cat ./arch/arm/boot/dts/rk3066a-mk808.dtb >> ../zImage-dtb
../tools/rkcrc -k ../zImage-dtb ../mk808.img
sudo ../tools/rkflashtool w 0x4000 0x8000 < ../mk808.img
sudo ../tools/rkflashtool b

///////////////////////////////////////////

Johan Jonker (2):
  ARM: dts: rockchip: rk3066a-mk808: enable vop0 and hdmi nodes
  dt-bindings: display: rockchip: add document for rk3066 hdmi

Zheng Yang (2):
  drm: rockchip: introduce rk3066 hdmi
  ARM: dts: rockchip: add rk3066 hdmi nodes

 .../bindings/display/rockchip/rk3066-hdmi.txt      |  72 ++
 arch/arm/boot/dts/rk3066a-mk808.dts                |  29 +
 arch/arm/boot/dts/rk3066a.dtsi                     |  52 ++
 drivers/gpu/drm/rockchip/Kconfig                   |   8 +
 drivers/gpu/drm/rockchip/Makefile                  |   1 +
 drivers/gpu/drm/rockchip/rk3066_hdmi.c             | 911 +++++++++++++++++++++
 drivers/gpu/drm/rockchip/rk3066_hdmi.h             | 226 +++++
 drivers/gpu/drm/rockchip/rockchip_drm_drv.c        |   2 +
 drivers/gpu/drm/rockchip/rockchip_drm_drv.h        |   1 +
 9 files changed, 1302 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/display/rockchip/rk3066-hdmi.txt
 create mode 100644 drivers/gpu/drm/rockchip/rk3066_hdmi.c
 create mode 100644 drivers/gpu/drm/rockchip/rk3066_hdmi.h

-- 
2.11.0

