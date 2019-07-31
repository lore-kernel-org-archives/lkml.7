Return-Path: <SRS0=cgli=V4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3E283C433FF
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Jul 2019 10:20:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0E3052089E
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Jul 2019 10:20:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="OJw/xktc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727913AbfGaKUO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 31 Jul 2019 06:20:14 -0400
Received: from mail-pl1-f196.google.com ([209.85.214.196]:38553 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726671AbfGaKUN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Jul 2019 06:20:13 -0400
Received: by mail-pl1-f196.google.com with SMTP id az7so30266939plb.5
        for <linux-kernel@vger.kernel.org>; Wed, 31 Jul 2019 03:20:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=qG0whHfhXOjtcfLzk188sCOar57eu2kC3PTAbz1gCBo=;
        b=OJw/xktcfO+P4ZQakjW7xr5hrf9cUCU/WoE6ccO8ljF+2fnEBdH+PiLzw/mr+QN3ZM
         xcGe6PTn+eUF8ZHKDSEPxaMT2bvttHqJGAvz8OkjnCxA7ZXm9hXRTjgd93xa5RDfD7pn
         aJSJMLq2r8GboOskpZVxFDFt5UvuWnUYd6nms=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=qG0whHfhXOjtcfLzk188sCOar57eu2kC3PTAbz1gCBo=;
        b=WunWQCRE29XfYNkJYREDbxXE01WoV/R9TqIlyWgK9G+HHsO3Jolg0zXnC1XQE25pCK
         q+zJXRAaGw8lf+uhvEOeiuiGgojPFQ7gfEo4pWI6q/ceNwmN9/o3mVLVS1TG1vB/8iho
         fzcGW1Po3piDU2rUdMdJ1P6Y6r7XUBmtnV3gbqoqV8oPqzBiTCoWWqhzVi35G0x1Tpou
         jtvMF/yyyAVYnd0DeT6pICJ4ZlouInWv7FFH72t4dSiHK9vOcuOGGdxc3Fv86/F9yRWV
         ltBGSnZy6be4b0PipaEvjtuwMa07Svnf9vmn5hHI8qelvq92bpmwWk1vAAGzPDu8d8bo
         yMpw==
X-Gm-Message-State: APjAAAUOblOBLVTs7O8AdmMW9JnsD3XTGcC06KYorEzCILQXrx38V8rV
        aB5yqDRF1NtNwIDcrSclb//hjcqko4s=
X-Google-Smtp-Source: APXvYqxo4nj3CQ1TbR22Q60IlXDAeO1/mETjinmS8a+Y2ov0Lk7OIA4TM0/MdXOXuCjdEFt/+9QbHA==
X-Received: by 2002:a17:902:383:: with SMTP id d3mr35046302pld.176.1564568412688;
        Wed, 31 Jul 2019 03:20:12 -0700 (PDT)
Received: from mannams-OptiPlex-7010.dhcp.broadcom.net ([192.19.234.250])
        by smtp.gmail.com with ESMTPSA id 3sm71161776pfg.186.2019.07.31.03.20.08
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 31 Jul 2019 03:20:11 -0700 (PDT)
From:   Srinath Mannam <srinath.mannam@broadcom.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Mathias Nyman <mathias.nyman@intel.com>,
        Rob Herring <robh+dt@kernel.org>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Mark Rutland <mark.rutland@arm.com>
Cc:     linux-usb@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        bcm-kernel-feedback-list@broadcom.com,
        Srinath Mannam <srinath.mannam@broadcom.com>
Subject: [PATCH v2 0/4] Reset xHCI port PHY on disconnect
Date:   Wed, 31 Jul 2019 15:49:50 +0530
Message-Id: <1564568395-9980-1-git-send-email-srinath.mannam@broadcom.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch set adds a quirk in xHCI driver to reset PHY of xHCI port on
its disconnect event.

This patch set is based on Linux-5.2-rc4.

Changes from v1:
  - Addressed Mathias's comments
    - Modified mapping of HC ports and their corresponding PHYs
  - Addressed Rob's comments
    - Removed usb-phy-port-reset DT property.
    - Added quirk in platform data using HCI compatible string.
  - Add phy ports in phy attr structure to have enabled ports bitmask.
  - Modified #phy-cells of sr-phy to pass phy ports bitmask.

Srinath Mannam (4):
  phy: Add phy ports in attrs
  dt-bindings: phy: Modify Stingray USB PHY #phy-cells
  phy: sr-usb: Set phy ports
  dt-bindings: usb-xhci: Add platform specific compatible for Stingray
    xHCI
  drivers: xhci: Add quirk to reset xHCI port PHY

 .../devicetree/bindings/phy/brcm,stingray-usb-phy.txt | 14 ++++++++------
 Documentation/devicetree/bindings/usb/usb-xhci.txt    |  1 +
 drivers/phy/broadcom/phy-bcm-sr-usb.c                 |  9 ++++++++-
 drivers/usb/core/hcd.c                                |  6 ++++++
 drivers/usb/core/phy.c                                | 19 +++++++++++++++++++
 drivers/usb/core/phy.h                                |  1 +
 drivers/usb/host/xhci-plat.c                          | 10 ++++++++++
 drivers/usb/host/xhci-plat.h                          |  1 +
 drivers/usb/host/xhci-ring.c                          |  9 ++++++---
 drivers/usb/host/xhci.h                               |  1 +
 include/linux/phy/phy.h                               | 10 ++++++++++
 include/linux/usb/hcd.h                               |  1 +
 12 files changed, 72 insertions(+), 10 deletions(-)

-- 
2.7.4

