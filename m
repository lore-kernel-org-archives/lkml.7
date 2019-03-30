Return-Path: <SRS0=yJb2=SB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E375CC43381
	for <linux-kernel@archiver.kernel.org>; Sat, 30 Mar 2019 09:56:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A97F9218AC
	for <linux-kernel@archiver.kernel.org>; Sat, 30 Mar 2019 09:56:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Q88YAj0o"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730643AbfC3J4w (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 30 Mar 2019 05:56:52 -0400
Received: from mail-ed1-f65.google.com ([209.85.208.65]:39364 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730415AbfC3J4v (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 30 Mar 2019 05:56:51 -0400
Received: by mail-ed1-f65.google.com with SMTP id p20so4075984eds.6;
        Sat, 30 Mar 2019 02:56:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=16XSbTMVUwZ3JNwu/W9jFRi0xaDPkYIj5jWeTQ9pjYQ=;
        b=Q88YAj0oBnXTct6TJPrAsr31cuMTGJ5YmxIl/OefZoWQzXTlUaPb+3vtz945yi1JPy
         kuT88noVYmZGmXrwrJUjZa5X3TtG7Kvi3l9uLlB103bIGTxcphNqE7Dk+gKO1GlWx7Pl
         Ztu5cd3RMA61ZqAGm7y07C3JN0AbtOqkDP4HhGE2SkRG3//Wqz5P3TNwy3TUe7KtW95E
         T1NiY8yif50cHVNmf3YWxDLhv0+O9lwXS3gYCBnMtnYp0bsuL2fkvZ7fQ2QuZnvVh4Iv
         JEcP4nkWKvhvGRcxm9cU9RxDSWXAB8eLj6joIaF0oUr5aFHYTKzO65pSUEum7VlSctq0
         D3eg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=16XSbTMVUwZ3JNwu/W9jFRi0xaDPkYIj5jWeTQ9pjYQ=;
        b=NUKkJrpcfwTMmhR1mk/VnMRtfnFTl4O5jalh27QcglKf2AsX2k3QlI91fUUmmWqe9s
         e3Jq5GIS5HMKJYEVAhuqAn72sBmLwQ+BSG7hWy58UaUKAgWCMOUQXCww2PpBMpvZKD/W
         Txd104u4vjK5My7F6RkawxUNWmeMoUrZcXGT8/SmwrEPqaki9HPdLKAM27X0ldRJN7QJ
         E8MtBy4Ev+dGkB4diMZXjW5c2+XKsLi/wGpnEn37DpZgBAyrG6/f4np1XaJmPUfBwbUP
         tXmG+TKQCKAkGBPZgrzBhBgkpsO/dhWXoj79UfHGgJhSnstztEzzuBroi8jQqUrVpMBf
         BJ3A==
X-Gm-Message-State: APjAAAWUwzMC6uJUcO2fBzIdnNWwVLENL37XsZmAoqXeySugPCTBAmpt
        mDblLkVWxdE2dfW939oIp88=
X-Google-Smtp-Source: APXvYqyTlU9xDIi3XQDn4k9ya9klKcxBmqs4vl+T2bFeS53SXTYDfjEFoRI85kdUusd2QyCjkgrCMQ==
X-Received: by 2002:a17:906:c2d0:: with SMTP id ch16mr16127804ejb.197.1553939809276;
        Sat, 30 Mar 2019 02:56:49 -0700 (PDT)
Received: from debian.home (ip51ccf9cd.speed.planet.nl. [81.204.249.205])
        by smtp.gmail.com with ESMTPSA id b34sm1087921edd.24.2019.03.30.02.56.48
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 30 Mar 2019 02:56:48 -0700 (PDT)
From:   Johan Jonker <jbx6244@gmail.com>
To:     heiko@sntech.de
Cc:     hjc@rock-chips.com, airlied@linux.ie, daniel@ffwll.ch,
        robh+dt@kernel.org, mark.rutland@arm.com,
        dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH v6 0/4] Enable rk3066 VOP and HDMI for MK808
Date:   Sat, 30 Mar 2019 10:56:35 +0100
Message-Id: <20190330095639.14626-1-jbx6244@gmail.com>
X-Mailer: git-send-email 2.11.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

For testing only.

Version: V6

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
With v5.1-rc1 the monitor doesn't blank on poweroff, it freezes
due to a patch revert some time ago.

  drm/rockchip: shutdown drm subsystem on shutdown
    https://patchwork.kernel.org/patch/10556151/
  drm/rockchip: Allow driver to be shutdown on reboot/kexec
    https://patchwork.kernel.org/patch/10556135/
  [for-4.20] Revert "drm/rockchip: Allow driver to be shutdown on reboot/kexec"
    https://patchwork.kernel.org/patch/10714725/

DVI-D monitors without CEA modes can add a fixed mode
to the kernel command line as workaround.
For example: video=HDMI-A-1:1280x720@60

HDMI sound not included.
etc.

///////////////////////////////////////////
Changes V6:

rk3066_hdmi.c
  add goto err_cleanup_hdmi to rk3066_hdmi_bind function
  small text style changes

///////////////////////////////////////////
Changes V5:

rockchip,rk3066-hdmi.txt
  add Reviewed-by tag

rk3066_hdmi.c
  change order in unbind function
  add goto err_disable_i2c to rk3066_hdmi_bind function
  change dev_foobar calls to their DRM_* equivalents
  remove rk3066_hdmi_i2c_irq function
  use define constants in rk3066_hdmi_encoder_enable function
  add comment to rk3066_hdmi_config_phy function
  small text style changes
  remove DVI-D support

rk3066_hdmi.h
  add define constants

///////////////////////////////////////////
Changes V4:

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
Changes V3:

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
 drivers/gpu/drm/rockchip/rk3066_hdmi.c             | 869 +++++++++++++++++++++
 drivers/gpu/drm/rockchip/rk3066_hdmi.h             | 229 ++++++
 drivers/gpu/drm/rockchip/rockchip_drm_drv.c        |   2 +
 drivers/gpu/drm/rockchip/rockchip_drm_drv.h        |   1 +
 9 files changed, 1263 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/display/rockchip/rockchip,rk3066-hdmi.txt
 create mode 100644 drivers/gpu/drm/rockchip/rk3066_hdmi.c
 create mode 100644 drivers/gpu/drm/rockchip/rk3066_hdmi.h

-- 
2.11.0

