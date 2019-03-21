Return-Path: <SRS0=/BZh=RY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1ABFC43381
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Mar 2019 00:14:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AE4DC218CD
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Mar 2019 00:14:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BsscLUai"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727718AbfCUAO5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Mar 2019 20:14:57 -0400
Received: from mail-ed1-f65.google.com ([209.85.208.65]:37944 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727464AbfCUAO5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Mar 2019 20:14:57 -0400
Received: by mail-ed1-f65.google.com with SMTP id q14so3568060edr.5;
        Wed, 20 Mar 2019 17:14:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=Mt43KCQtSq+Z0hTpKWdP/GlYFqR1KKeRasY/ohVUwWQ=;
        b=BsscLUaiouFE8pG1hTBCU5am0SgQhN2ivGtqNZL1Zz44BXq/wQcJV8zlSE3ovT5yvX
         MlQekwvd9BVx75/s5TW3yE4O76irbPkFDPOD6I8a59WTRKvWWU2CiVZh3g+CU4IRDci9
         5OF1pHMxEL0eraxrR3uaWWnJ1zk16f53YeZcFBz/24JuyDWBRvN8Qlx453wk/31kRWrx
         Wtjjr0o328g7rIQ5pH2nnkQW3XobBmutWjh7oyohI9SYR9P+d4E7mfiCeoDVDkpK0MKY
         cGSTlUdU60DN2bIu+bgW3jeCM4hlN6x4NU/hU66RvoMJG87d2BKI0vb3CQwrNbX3uSLr
         rWJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=Mt43KCQtSq+Z0hTpKWdP/GlYFqR1KKeRasY/ohVUwWQ=;
        b=eEcq1OBPR8tQRAce0JzXnGMqYRaXCTcwwN2FQ5cqUUNOlhls3CSbU8h267/givZs2E
         +F6cNQpfXXTufAkV/KLL1rgVN8UU2Xbu1ODzUtZ92mgn2Ql2FOIdbcUyVjbA88eqI+Ba
         J9Hz3Wapdp+ZJGShhpYhFPH4mjbt/47URjGAC4K3dwvnctAfZZC7z4HPvFioRm9p92A9
         F8cCpmufLXi/nTFpw3O03GdbNctI/7VbyyMnFMssLaZdpIzNz5i+kPNxmknNC90CoE0o
         9Ee64DUoLRA2Cu8BH/TvCztp1OVmvzNOYL2l4DcHYQeDyjFH1E9Uk7y0Na4fksEQeRIy
         Cqgg==
X-Gm-Message-State: APjAAAXGu5Ws8pOJWOh1Ir0SDxgdRZE3Vo3mhhQg75qLNiprk1gML+X4
        YYf+1G43Gambwz7wURlzxRo=
X-Google-Smtp-Source: APXvYqyZdJKVigVHV+GYKcMElneANHrzCJADLZQAW3/1i1AmmBoCwYGK59wKBrACRf3TY45j57pqTA==
X-Received: by 2002:a50:926e:: with SMTP id j43mr492698eda.60.1553127294417;
        Wed, 20 Mar 2019 17:14:54 -0700 (PDT)
Received: from debian.home (ip51ccf9cd.speed.planet.nl. [81.204.249.205])
        by smtp.gmail.com with ESMTPSA id j34sm1107660edb.30.2019.03.20.17.14.53
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 20 Mar 2019 17:14:53 -0700 (PDT)
From:   Johan Jonker <jbx6244@gmail.com>
To:     heiko@sntech.de
Cc:     hjc@rock-chips.com, airlied@linux.ie, daniel@ffwll.ch,
        robh+dt@kernel.org, mark.rutland@arm.com,
        dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH v5 0/5] Enable rk3066 VOP and HDMI for MK808
Date:   Thu, 21 Mar 2019 01:14:35 +0100
Message-Id: <20190321001440.31057-1-jbx6244@gmail.com>
X-Mailer: git-send-email 2.11.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

For testing only.

Version: V5

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
With v5.0-rc8 the monitor doesn't blank on poweroff, it freezes
due to a patch revert some time ago.

  drm/rockchip: shutdown drm subsystem on shutdown
    https://patchwork.kernel.org/patch/10556151/
  drm/rockchip: Allow driver to be shutdown on reboot/kexec
    https://patchwork.kernel.org/patch/10556135/
  [for-4.20] Revert "drm/rockchip: Allow driver to be shutdown on reboot/kexec"
    https://patchwork.kernel.org/patch/10714725/

To get the rk3066 hdmi driver accepted DVI-D support is removed.
(Fixed screen size support for DVI-D with extra patch.)

HDMI sound not included.
etc.

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
  (add DVI-D support with extra patch)

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

Johan Jonker (3):
  ARM: dts: rockchip: rk3066a-mk808: enable vop0 and hdmi nodes
  dt-bindings: display: rockchip: add document for rk3066 hdmi
  drm: rockchip: add fixed screen size DVI-D support for rk3066 hdmi

Zheng Yang (2):
  drm: rockchip: introduce rk3066 hdmi
  ARM: dts: rockchip: add rk3066 hdmi nodes

 .../display/rockchip/rockchip,rk3066-hdmi.txt      |  72 ++
 arch/arm/boot/dts/rk3066a-mk808.dts                |  29 +
 arch/arm/boot/dts/rk3066a.dtsi                     |  52 ++
 drivers/gpu/drm/rockchip/Kconfig                   |   8 +
 drivers/gpu/drm/rockchip/Makefile                  |   1 +
 drivers/gpu/drm/rockchip/rk3066_hdmi.c             | 889 +++++++++++++++++++++
 drivers/gpu/drm/rockchip/rk3066_hdmi.h             | 229 ++++++
 drivers/gpu/drm/rockchip/rockchip_drm_drv.c        |   2 +
 drivers/gpu/drm/rockchip/rockchip_drm_drv.h        |   1 +
 9 files changed, 1283 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/display/rockchip/rockchip,rk3066-hdmi.txt
 create mode 100644 drivers/gpu/drm/rockchip/rk3066_hdmi.c
 create mode 100644 drivers/gpu/drm/rockchip/rk3066_hdmi.h

-- 
2.11.0

