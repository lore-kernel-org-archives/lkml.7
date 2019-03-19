Return-Path: <SRS0=B1dt=RW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 05E94C43381
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Mar 2019 09:16:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CC2B720989
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Mar 2019 09:16:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="XKIomgdb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727495AbfCSJQR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Mar 2019 05:16:17 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:52081 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727408AbfCSJQQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Mar 2019 05:16:16 -0400
Received: by mail-wm1-f66.google.com with SMTP id n19so15761888wmi.1
        for <linux-kernel@vger.kernel.org>; Tue, 19 Mar 2019 02:16:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=Hc2ldVTUDt5Qd5qKJu2C5KWL5G9ldGlFOFxbSm3TKf8=;
        b=XKIomgdbFJ2iGXrpxIzbbPpuO5BP53FvSWwiHZbJTfCGvpUTMzd1r2zMAMHG17yJ7l
         sfKh8dFAAMOUjcZn4D//luB9+urcY/cYufOPP/dpNcBmXOdH+skOBiAmVeUukE6zM67K
         tnQt+hPYiTujjcYtnMoiigJPX5sXj6UjVrlQ8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=Hc2ldVTUDt5Qd5qKJu2C5KWL5G9ldGlFOFxbSm3TKf8=;
        b=mHdE1UhTBSeiQuoLVieoGRzF/er//srL4kQrgS32Jn/20q1dpoYPfB62MmDlKe4o8B
         ge7Q/74F1KSlm5n/HG9+xyyHEvlTWBXRXUVaw4U6gfyFNuPChIuOqtXebgfyACUnpqpT
         3uXGDSXMvU57+6c5KYN2eqPtDKXuAAOBJqob0gUWX9P0CgherBvv3FjqlekA8RSYR7ek
         sh1EeJoEQVuMvXfQZ1H6q0yn0guHlmweaqXby7IwWM9AyZlFbOFNyKHWTaSqO3jLKtzv
         CCdq9tHFnAaxDXx8+v49Cg2Ri3Mevn0upbofrqSmBBLR4fP0hX2CEN2jR9drgL8sbKve
         qu+Q==
X-Gm-Message-State: APjAAAWpM85nKXDMvbJd37tL0R6Qh8Eh9pDDPVOYfGjLpb3WbTr6ttFx
        GYisGny6Ut7ktAkTtUZAGDZxJA==
X-Google-Smtp-Source: APXvYqwl1SFUTXQb0jsAxswr6k0CHZqADprhzbpiPkp3WJs/bcb3BOOIC12uah7HmdphO73Ph3vygw==
X-Received: by 2002:a1c:a186:: with SMTP id k128mr2567746wme.54.1552986974881;
        Tue, 19 Mar 2019 02:16:14 -0700 (PDT)
Received: from mannams-OptiPlex-7010.dhcp.broadcom.net ([192.19.234.250])
        by smtp.gmail.com with ESMTPSA id w10sm14875743wrn.32.2019.03.19.02.16.09
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 19 Mar 2019 02:16:13 -0700 (PDT)
From:   Srinath Mannam <srinath.mannam@broadcom.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Kishon Vijay Abraham I <kishon@ti.com>
Cc:     Tejun Heo <tj@kernel.org>,
        Jayachandran C <jnair@caviumnetworks.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        bcm-kernel-feedback-list@broadcom.com,
        linux-arm-kernel@lists.infradead.org,
        Srinath Mannam <srinath.mannam@broadcom.com>
Subject: [PATCH v6 0/3] Stingray USB PHY driver support
Date:   Tue, 19 Mar 2019 14:45:41 +0530
Message-Id: <1552986944-3398-1-git-send-email-srinath.mannam@broadcom.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

These patches add Stingray USB PHY driver and its corresponding
DT nodes with documentation.

This patch set is based on Linux-5.0-rc2.

Changes from v5:
  - Removed redundant address and size cells in DT nodes.

Changes from v4:
  - Addressed Rob Herring review comments
     - Removed child nodes and added #phy-cells 1
     - Added xlate function to get phy using phandle argument.

Changes from v3:
  - Addressed Rob Herring review comments
     - Changed compatible strings.
     - updated driver based on new compatible strings.

Changes from v2:
  - Addressed Kishon review comments
  - Updated patchset to Linux-5.0-rc2

Changes from v1:
  - Addressed Kishon review comments
  - phy init call return value handle
  
Srinath Mannam (3):
  dt-bindings: phy: Add Stingray USB PHY binding document
  phy: sr-usb: Add Stingray USB PHY driver
  arm64: dts: Add USB DT nodes for Stingray SoC

 .../bindings/phy/brcm,stingray-usb-phy.txt         |  32 ++
 .../boot/dts/broadcom/stingray/stingray-usb.dtsi   |  72 ++++
 .../arm64/boot/dts/broadcom/stingray/stingray.dtsi |   1 +
 drivers/phy/broadcom/Kconfig                       |  11 +
 drivers/phy/broadcom/Makefile                      |   1 +
 drivers/phy/broadcom/phy-bcm-sr-usb.c              | 393 +++++++++++++++++++++
 6 files changed, 510 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/phy/brcm,stingray-usb-phy.txt
 create mode 100644 arch/arm64/boot/dts/broadcom/stingray/stingray-usb.dtsi
 create mode 100644 drivers/phy/broadcom/phy-bcm-sr-usb.c

-- 
2.7.4

