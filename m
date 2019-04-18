Return-Path: <SRS0=NWWL=SU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0BB63C282DA
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Apr 2019 00:14:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C6F742184B
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Apr 2019 00:14:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="LVGQpggD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387614AbfDRAO5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Apr 2019 20:14:57 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:43406 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729331AbfDRAO5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Apr 2019 20:14:57 -0400
Received: by mail-pf1-f196.google.com with SMTP id c8so224240pfd.10
        for <linux-kernel@vger.kernel.org>; Wed, 17 Apr 2019 17:14:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=c9oThqOPQYRE9+j5YBe3T7HRFD4v17lP81JvPeWNUJo=;
        b=LVGQpggDxObbMay+0kK1xkAClUgU3QUKZ2zeyJjh8Xnrx4z9dJPNi9TUp+f8RTd0Ck
         d9NpEkly65of7S0zxErJ85rX495+moDdrKFtuN1ondPtJB3MHKsle748/lx4Hfmml3CZ
         hTOUOxgkvb0vw0HpArE9TW/ArB1KEhj1U94VI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=c9oThqOPQYRE9+j5YBe3T7HRFD4v17lP81JvPeWNUJo=;
        b=j6mOxLzM10EgQE0L9SRBudmZeVgpzWZr8CzUjnW6SNjXgUsFtSBhRs0SLe6dDBFjwX
         2NIYkJShoeHK9RM7Jf7g84+4ZePLWE62/ZdkEFVyafATMczwWqWLZoXV7GdhzmaPankJ
         oI0uU8VZewQr8H2E4Xahl1iwPDTM3nm2bn+jhZtsIMVZNL/sbRjzA4p+FahlNqZixMOA
         oioz7gyHY79gAKxOffM4McsQ9OoZiOJMyFpj+FIgkfSQvS0eisA7X0GL2Lb/em8Zfv/W
         WbPD5PT5En8IAvc7gPbF6IqSeaKlFpvc4kiBF6mp8P0aHk821groh3gS1aIFr+Fe+CAt
         kS/Q==
X-Gm-Message-State: APjAAAVMmIR3hwRXbhXBlD/3Apjd5R6GyKnot2Q6wKzIORLAWBPOOJEA
        JDIxfLuBsNeRW56WY2EgNlYzhw==
X-Google-Smtp-Source: APXvYqxBrq6dTjS91CHRbsI1bTnxxtQbGFSU4OZmJFaPtT8QQp4Fl3rumYe7P87zkpZ1XvLPGPB3XQ==
X-Received: by 2002:a62:7603:: with SMTP id r3mr93273266pfc.32.1555546496404;
        Wed, 17 Apr 2019 17:14:56 -0700 (PDT)
Received: from tictac2.mtv.corp.google.com ([2620:15c:202:1:24fa:e766:52c9:e3b2])
        by smtp.gmail.com with ESMTPSA id q5sm447668pff.97.2019.04.17.17.14.54
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 17 Apr 2019 17:14:55 -0700 (PDT)
From:   Douglas Anderson <dianders@chromium.org>
To:     Minas Harutyunyan <hminas@synopsys.com>,
        Felipe Balbi <felipe.balbi@linux.intel.com>, heiko@sntech.de
Cc:     Alan Stern <stern@rowland.harvard.edu>,
        Artur Petrosyan <Arthur.Petrosyan@synopsys.com>,
        amstan@chromium.org, linux-rockchip@lists.infradead.org,
        William Wu <william.wu@rock-chips.com>,
        linux-usb@vger.kernel.org, Stefan Wahren <stefan.wahren@i2se.com>,
        Randy Li <ayaka@soulik.info>, zyw@rock-chips.com,
        mka@chromium.org, ryandcase@chromium.org,
        Amelie Delaunay <amelie.delaunay@st.com>, jwerner@chromium.org,
        dinguyen@opensource.altera.com,
        Elaine Zhang <zhangqing@rock-chips.com>,
        Douglas Anderson <dianders@chromium.org>,
        linux-arm-kernel@lists.infradead.org,
        Kai-Heng Feng <kai.heng.feng@canonical.com>,
        Mathias Nyman <mathias.nyman@linux.intel.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Nicolas Boichat <drinkcat@chromium.org>,
        Jon Flatley <jflat@chromium.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
Subject: [PATCH v2 0/5] USB: dwc2: Allow wakeup from suspend; enable for rk3288-veyron
Date:   Wed, 17 Apr 2019 17:13:51 -0700
Message-Id: <20190418001356.124334-1-dianders@chromium.org>
X-Mailer: git-send-email 2.21.0.593.g511ec345e18-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This re-hashes two older series I posted a long time ago, re-basing
them to mainline.  ...well, technically, atop another dwc2 series I
recently posted:

* usb: dwc2: Another attempt handling rk3288's remote wake quirk
  https://lkml.kernel.org/r/20190416215351.242246-1-dianders@chromium.org
  https://lore.kernel.org/patchwork/cover/1062972/

In general I've tried to add links to each patch pointing to relevant
older discussion.  Here are overall links to the cover letters though.
Note that for the previous "allow wakeup" series the discussion was
scattered a bit between the original post and the repost.

* usb: dwc2: bus suspend/resume that's not hibernate
  https://lkml.kernel.org/r/1446237173-15263-1-git-send-email-dianders@chromium.org
  https://lore.kernel.org/patchwork/patch/613761/

* dwc2 patches to allow wakeup on Rockchip rk3288
  https://lkml.kernel.org/r/1435017144-2971-1-git-send-email-dianders@chromium.org
  https://lore.kernel.org/patchwork/cover/572944/

* dwc2 patches to allow wakeup on Rockchip rk3288 (REPOST)
  https://lkml.kernel.org/r/1436207224-21849-1-git-send-email-dianders@chromium.org
  https://lore.kernel.org/patchwork/cover/576120/

I'm hoping there's a better chance of these things landing this time
around, but I guess we'll see.  ;-)

In case it's helpful I've put what I tested (which is based on Heiko's
for-next branch and includes patches to enable deep suspend plus two
other s2r fixes) at:

https://chromium.googlesource.com/chromiumos/third_party/kernel/+log/refs/sandbox/dianders/190417-testing-dwc2-wakeup

Changes in v2:
- Rebased to mainline atop rk3288 remote wake quirk series.
- rk3288-veyron dts patch new for v2.

Douglas Anderson (5):
  usb: dwc2: bus suspend/resume for hosts with
    DWC2_POWER_DOWN_PARAM_NONE
  USB: Export usb_wakeup_enabled_descendants()
  Documentation: dt-bindings: Add snps,need-phy-for-wake for dwc2 USB
  USB: dwc2: Don't turn off the usbphy in suspend if wakeup is enabled
  ARM: dts: rockchip: Allow wakeup from rk3288-veyron's dwc2 USB ports

 .../devicetree/bindings/usb/dwc2.txt          |  3 +
 arch/arm/boot/dts/rk3288-veyron.dtsi          |  2 +
 drivers/usb/core/hub.c                        |  7 +-
 drivers/usb/dwc2/core.h                       |  5 ++
 drivers/usb/dwc2/hcd.c                        | 84 ++++++++++++-------
 drivers/usb/dwc2/platform.c                   | 43 +++++++++-
 include/linux/usb/hcd.h                       |  5 ++
 7 files changed, 113 insertions(+), 36 deletions(-)

-- 
2.21.0.593.g511ec345e18-goog

