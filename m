Return-Path: <SRS0=J4ZE=RP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 505F9C43381
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Mar 2019 16:07:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 148622054F
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Mar 2019 16:07:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="QWjsKFD5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726760AbfCLQHS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Mar 2019 12:07:18 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:35319 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726141AbfCLQHS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Mar 2019 12:07:18 -0400
Received: by mail-pg1-f194.google.com with SMTP id e17so2186420pgd.2
        for <linux-kernel@vger.kernel.org>; Tue, 12 Mar 2019 09:07:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=zlt/jmx4V61Shf5QPLhKkir7eUUMQGfCYNQBZevcH50=;
        b=QWjsKFD5c8dv4Hy1XD/hTlaHxeP4olGvWbkbslc8aV9FKLWO167cvFvRBlp4ierGk4
         fyZ7GSzzCsjne8u53u5QAbt2U1wBS40auKHVCLHAhB/57K8HWFvbmR3ycyly+vLfzgYH
         ephyXevfVcmBm9HORYlwV9MslUCVKD6f5spKo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=zlt/jmx4V61Shf5QPLhKkir7eUUMQGfCYNQBZevcH50=;
        b=r0KGvs6EdO4rmkc0/UB5C/xq/HRI0K09Nyh0eEv/YhcRtTBDS8FmJK6nSP7pwq8kK2
         d+CThc6b64/rq9vpuyGbYh+8d5c7fL/LbcR5wrCRKSlVLCLMwyewwnR8VJzrrHxjIpMd
         ObYigPUJYjl1KUhBT+LnUayqeQ1mJeXrbwD7VAphRDsSo4VjhjlEqsZHMEASZo2MeVmt
         qxECNUhs9JZlsZe0ltoHcDkAiK92G+6NfhaNIMJwB04rHQVMnKW8UGsC7vIulZZ91Nv2
         pImf7lqm0eqBgTAx+U9tv3PurPOakRr4khB9ePXgIjBoyj+O0bVL00dD08dCkbEZK4Ld
         9sAw==
X-Gm-Message-State: APjAAAVlFXMKUv+24heaR9IsfNBoZ10hXIALG1ZQbtSrPTGjzD2ukCQ4
        50iC/+/EH/3WLiCnyhAawnKFRQ==
X-Google-Smtp-Source: APXvYqwQndMpv8xXp+HqEMPhPg8sxgZWNq3achTTg4cvdUJyDARM6XaWtDmm0K+9oDC7f94UO95f9w==
X-Received: by 2002:a62:b415:: with SMTP id h21mr39065830pfn.26.1552406837244;
        Tue, 12 Mar 2019 09:07:17 -0700 (PDT)
Received: from mannams-OptiPlex-7010.dhcp.broadcom.net ([192.19.234.250])
        by smtp.gmail.com with ESMTPSA id z12sm12875854pgv.0.2019.03.12.09.07.14
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 12 Mar 2019 09:07:16 -0700 (PDT)
From:   Srinath Mannam <srinath.mannam@broadcom.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Kishon Vijay Abraham I <kishon@ti.com>
Cc:     Tejun Heo <tj@kernel.org>,
        Jayachandran C <jnair@caviumnetworks.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        bcm-kernel-feedback-list@broadcom.com,
        Srinath Mannam <srinath.mannam@broadcom.com>
Subject: [PATCH v5 0/3] Stingray USB PHY driver support
Date:   Tue, 12 Mar 2019 21:36:18 +0530
Message-Id: <1552406781-5180-1-git-send-email-srinath.mannam@broadcom.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

These patches add Stingray USB PHY driver and its corresponding
DT nodes with documentation.

This patch set is based on Linux-5.0-rc2.

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

 .../bindings/phy/brcm,stingray-usb-phy.txt         |  40 +++
 .../boot/dts/broadcom/stingray/stingray-usb.dtsi   |  78 ++++
 .../arm64/boot/dts/broadcom/stingray/stingray.dtsi |   1 +
 drivers/phy/broadcom/Kconfig                       |  11 +
 drivers/phy/broadcom/Makefile                      |   1 +
 drivers/phy/broadcom/phy-bcm-sr-usb.c              | 393 +++++++++++++++++++++
 6 files changed, 524 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/phy/brcm,stingray-usb-phy.txt
 create mode 100644 arch/arm64/boot/dts/broadcom/stingray/stingray-usb.dtsi
 create mode 100644 drivers/phy/broadcom/phy-bcm-sr-usb.c

-- 
2.7.4

