Return-Path: <SRS0=vY9Y=RJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 38667C43381
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Mar 2019 22:41:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EF93F206DD
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Mar 2019 22:41:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BF+ao9kZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726134AbfCFWl0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 Mar 2019 17:41:26 -0500
Received: from mail-ed1-f66.google.com ([209.85.208.66]:41867 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725793AbfCFWl0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Mar 2019 17:41:26 -0500
Received: by mail-ed1-f66.google.com with SMTP id x7so11798806eds.8;
        Wed, 06 Mar 2019 14:41:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=QNy3H1vExVS7y9CR7yIN+hNajEJUqjOXXk8GHcBL0/c=;
        b=BF+ao9kZURjK23WgWao54RcihXoWnT2juIsU15P9vrVP/CP3/W8NWl8jbg3cZI+6YK
         jh3rpCIAEbktjf9FtntmhZR7aOC0NEl8HyEGauv8tiEVr3Ca3GE12mb0cvPDnRx7NgZA
         Hk/b6S1xyaSdcNbslrWJGWSGtWC6spwOTh0l4XuEXGlj9DdN5IRk02L3sOKBn7vtWo1c
         BOw5rRJ0TNdUS3qDgX7Ii3WNIWJPLc6zIasxP9CZDWKszmY7/wCMZASwobqYs1Xg+tdB
         xasLoij/wE14nchkvMKg3/XDpAEFKXRlcE8+NhxrZQFTd6gKqun58SIxorjmBaGyBGq1
         beKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=QNy3H1vExVS7y9CR7yIN+hNajEJUqjOXXk8GHcBL0/c=;
        b=kObmaHlTQNy1sHSuc5YT10j+x4SgnEzWu26JXTtV+r0aOTZSUVPa5N4erIVZ3Sbh4+
         xA8nAlV2DOqEQPNziEGFTBgGWx/QmnlRyJLt9Hh2GawwwkL2nbr6A7QEifG+UeuHSQcV
         hwC8p45owoxnbN/dfevR1ZHAHrguCvp9Ml62xL6E2fGCok/yIykRWwxNoRlwxE+23fUc
         rrVMZbMkDYLckI1vjjz5WxWNajYfHuGB55zL8S9SZBOTAAzmky8DHOEbJqdMK40mR/83
         a7Ylv2b4nmtyZaY8DN8VAs2sriwokEF7FUfrbgohdF8VWXZqNKfhTAx2M1XDz4Awn8tw
         ++Qg==
X-Gm-Message-State: APjAAAWhi/o/+e1oAot2VBa45GdjcYMPIpjU+gUSLYw1pAvWVQVZSr0q
        XRn5eiRZKt5oOkOfPtjlvMQ=
X-Google-Smtp-Source: APXvYqww04FKSGLrAU8/8wbNxeC1WN1xICzEQiR+QbM5ZWkhHIciXDRRW9YWw9nWi4OdlhEoegJBuw==
X-Received: by 2002:a50:890f:: with SMTP id e15mr25594564ede.174.1551912084211;
        Wed, 06 Mar 2019 14:41:24 -0800 (PST)
Received: from debian.home (ip51ccf9cd.speed.planet.nl. [81.204.249.205])
        by smtp.gmail.com with ESMTPSA id 36sm801356edz.58.2019.03.06.14.41.23
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 06 Mar 2019 14:41:23 -0800 (PST)
From:   Johan Jonker <jbx6244@gmail.com>
To:     heiko@sntech.de
Cc:     hjc@rock-chips.com, airlied@linux.ie, daniel@ffwll.ch,
        robh+dt@kernel.org, mark.rutland@arm.com,
        dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH v4 0/4] Enable rk3066 VOP and HDMI for MK808
Date:   Wed,  6 Mar 2019 23:41:09 +0100
Message-Id: <20190306224113.24853-1-jbx6244@gmail.com>
X-Mailer: git-send-email 2.11.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

For testing only.

Version: V4

Title: Enable rk3066 VOP and HDMI for MK808.

This patch serie only works in combination with a MK808 TV stick and
a rk3066 processor. Other boxes and tablets with a rk3066
need extra software for power management and lcd's.

What does it do:

With these kernel patches a MK808 can show 2 penguins and a console
on a DVI-D monitor in combination with a framebuffer.

Not tested:

HDMI TV
HDCP
DRM
Xorg
Display managers
Android
etc.

Problems:

DRM functions keep changing every rc.
With v5.0-rc8 the monitor doesn't blank on poweroff, it freezes.
Fixed screen size for DVI-D.
HDMI sound not included.
etc.

///////////////////////////////////////////
Changes V3 > V4:

rockchip,rk3066-hdmi.txt
  change document name

rk3066_hdmi.c
  add more info in commit message
  replace deprecated drmP.h include
  small text style changes
  explain vic variable
  remove enc_in_format
  change lock name
  change regmap name
  change cmp name
  replace hdmi->dev by dev
  use sentinel
  use HDMI_VIDEO_VSYNC_OFFSET_SHIFT define
  remove unused module macros
  change driver name for dmesg

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

 .../display/rockchip/rockchip,rk3066-hdmi.txt      |  72 ++
 arch/arm/boot/dts/rk3066a-mk808.dts                |  29 +
 arch/arm/boot/dts/rk3066a.dtsi                     |  52 ++
 drivers/gpu/drm/rockchip/Kconfig                   |   8 +
 drivers/gpu/drm/rockchip/Makefile                  |   1 +
 drivers/gpu/drm/rockchip/rk3066_hdmi.c             | 901 +++++++++++++++++++++
 drivers/gpu/drm/rockchip/rk3066_hdmi.h             | 226 ++++++
 drivers/gpu/drm/rockchip/rockchip_drm_drv.c        |   2 +
 drivers/gpu/drm/rockchip/rockchip_drm_drv.h        |   1 +
 9 files changed, 1292 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/display/rockchip/rockchip,rk3066-hdmi.txt
 create mode 100644 drivers/gpu/drm/rockchip/rk3066_hdmi.c
 create mode 100644 drivers/gpu/drm/rockchip/rk3066_hdmi.h

-- 
2.11.0

