Return-Path: <SRS0=a4+J=26=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B5B5C3F68F
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Jan 2020 10:10:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D47622080D
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Jan 2020 10:10:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="e7tdu/FM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729986AbgAIKKx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 Jan 2020 05:10:53 -0500
Received: from mail-pf1-f178.google.com ([209.85.210.178]:41207 "EHLO
        mail-pf1-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729909AbgAIKKw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Jan 2020 05:10:52 -0500
Received: by mail-pf1-f178.google.com with SMTP id w62so3146689pfw.8
        for <linux-kernel@vger.kernel.org>; Thu, 09 Jan 2020 02:10:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=oYLObm1EH6YdnVAuxH4HhWVzCuwo//V40I0Zoh1cRWA=;
        b=e7tdu/FMMGGPPVjoNEmiQCT1rQIRQsa/DcyBNt3Kcufdm6iA+2yEHtlK700c7XSip5
         29foJIQjO1Ux894Sx6t0T47Q++Fb59S2z9PWL0iPs5xFkNi6dt0Nz2HifhwCl5N6cPLo
         pjodAHyNp6UXTwVz31UGyLFgqRpjy0RIlSYPc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=oYLObm1EH6YdnVAuxH4HhWVzCuwo//V40I0Zoh1cRWA=;
        b=GowX3Dri7JFYAxQU3TEda+2lfcUSfoUM7/DFp6RS0885fVRwc/xsnCZ4QV5Xy6v1Zb
         Ffxp82OQkuUMjBWXLI1Wr2bWOHZ05b+BZJBszNu77ntQK7BahNRXs2ZGM4PxfPnd5FZj
         JwcxhELHtK6budtZq9EoDWQR37hfsVOEu+69FDR9FxmqmgEW7DqRLRc7wwwf4t4dqiJn
         HpqYA1qMS6/k4SBpF0mzhSA745UaUhIyfeTeJbR0T4DGa+81LMK2Wmthdmv7NcZA5a49
         6hwUgUb4MDydOhg448J7riX3Xw9M5hIS98Xs4S4mMmpqCTUQpPbTxkgBPXp0F3jdwOMl
         UtbA==
X-Gm-Message-State: APjAAAWCfuRlyeAdr1c6QHATZ2014Oav7XwUJY1MEBsnUwmDDfdeYgRK
        hFUJfCTAFanpS95LShuXslbJfQ==
X-Google-Smtp-Source: APXvYqwebhIZMzghd1qDG5V69TQUhXnikGS2NCAn7B1nL1eqOptwbKauGF29YAc5NlySDTXQg5M0/w==
X-Received: by 2002:a63:358a:: with SMTP id c132mr10552106pga.286.1578564651804;
        Thu, 09 Jan 2020 02:10:51 -0800 (PST)
Received: from hsinyi-z840.tpe.corp.google.com ([2401:fa00:1:10:b852:bd51:9305:4261])
        by smtp.gmail.com with ESMTPSA id s11sm6518713pgp.1.2020.01.09.02.10.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Jan 2020 02:10:51 -0800 (PST)
From:   Hsin-Yi Wang <hsinyi@chromium.org>
To:     linux-arm-kernel@lists.infradead.org
Cc:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Mars Cheng <mars.cheng@mediatek.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mediatek@lists.infradead.org,
        Nicolas Boichat <drinkcat@chromium.org>,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        Daniel Kurtz <djkurtz@chromium.org>
Subject: [PATCH 0/2] Add mt8173 elm and hana board
Date:   Thu,  9 Jan 2020 18:10:40 +0800
Message-Id: <20200109101042.201500-1-hsinyi@chromium.org>
X-Mailer: git-send-email 2.25.0.rc1.283.g88dfdc4193-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series adds devicetree and binding document for Acer Chromebook R13 (elm)
and Lenovo Chromebook (hana), which are using mt8173 as SoC.


Hsin-Yi Wang (2):
  dt-bindings: arm64: dts: mediatek: Add mt8173 elm and hana
  arm64: dts: mediatek: add mt8173 elm and hana board

 .../devicetree/bindings/arm/mediatek.yaml     |   18 +
 arch/arm64/boot/dts/mediatek/Makefile         |    3 +
 .../dts/mediatek/mt8173-elm-hana-rev7.dts     |   27 +
 .../boot/dts/mediatek/mt8173-elm-hana.dts     |   16 +
 .../boot/dts/mediatek/mt8173-elm-hana.dtsi    |   53 +
 arch/arm64/boot/dts/mediatek/mt8173-elm.dts   |   15 +
 arch/arm64/boot/dts/mediatek/mt8173-elm.dtsi  | 1069 +++++++++++++++++
 7 files changed, 1201 insertions(+)
 create mode 100644 arch/arm64/boot/dts/mediatek/mt8173-elm-hana-rev7.dts
 create mode 100644 arch/arm64/boot/dts/mediatek/mt8173-elm-hana.dts
 create mode 100644 arch/arm64/boot/dts/mediatek/mt8173-elm-hana.dtsi
 create mode 100644 arch/arm64/boot/dts/mediatek/mt8173-elm.dts
 create mode 100644 arch/arm64/boot/dts/mediatek/mt8173-elm.dtsi

-- 
2.25.0.rc1.283.g88dfdc4193-goog

