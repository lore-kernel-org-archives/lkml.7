Return-Path: <SRS0=ag/Q=Z7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93B9FC04E30
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Dec 2019 21:43:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 66DFA20721
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Dec 2019 21:43:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ksSraNnz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726787AbfLIVn4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Dec 2019 16:43:56 -0500
Received: from mail-wm1-f68.google.com ([209.85.128.68]:52820 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726532AbfLIVn4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Dec 2019 16:43:56 -0500
Received: by mail-wm1-f68.google.com with SMTP id p9so964640wmc.2;
        Mon, 09 Dec 2019 13:43:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=agn5/+Ff+txwdkMYcl4dOnRhb7wogId0OeGIrqnhFKE=;
        b=ksSraNnzdutiIZQGZh6yoC60sA5Owl+9UUm3n7Je1G/TIUzmTAGbdjjIAnYcJJ9WqF
         0NtW72rA+SXNcVdV5d7h6ZHeL6i26UXPEubD8677Meikhrbwvpf6rW74VfZ1tVkUYZf/
         79dzFN7wssNwWvBfMzDlxRrT6oOxSTEkFaBnxrKEQOn8ptsBecwDzcgyzqgfDQ0a+ShO
         zn3GP8+nV9rM91qdX54EETRABNKjWibuzV9PsUGtK9wbTkimU6EPJsD9bJ0liCUfbRzo
         eCkKZbuai5mf/zP9zs+75DPqRYrHuqdvfbmyYJfBHVTOexX3L583LJ+yJuVucBehF0Ix
         tyXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=agn5/+Ff+txwdkMYcl4dOnRhb7wogId0OeGIrqnhFKE=;
        b=T26xHS0SsijfpAmrtgPgN0TdRhHAAyR5YYIQyc25saU1EQrAdmf4jAENgaKKmADm98
         /9lcAM4m0NuyqHIlN27TO2nKUJmu2RVw7eeLjf6S7Y+Bl7Tx/fM0GcmU2GxYhKh9L13R
         iiDZY9fNqvhJPTwfdAv6wXw2fbn1WfzbqitMRG+0iWPNg6RtmMaLlusQxnYYhE2tOcz1
         YXVZjjtzx26+udxV94YqWtHV2G+000yGTPzSDqNu6jKlve21/UxwG8tsjQLI/8JnM8JO
         ehbd8KPpl65pkau+t58mRSI+Qr+Ize1d3rq8BAC3p43PxwaRFqV7FPWYahLk9euWuMSH
         k7bw==
X-Gm-Message-State: APjAAAUQssI8miufNZjhA+yqFltHP7l+BhBa4KnuxcgqEx5QNb/lCx3J
        h8Q6brDwad95Ld6Cw9LrkkUKUeFE
X-Google-Smtp-Source: APXvYqzkdIQck7ENb0Q67BnAzVNL8+7JT8AQ3bwYZktEpCbKqGfVPbjzxR7d1xGdUBdH0PMUcDmSsg==
X-Received: by 2002:a05:600c:285:: with SMTP id 5mr1259857wmk.158.1575927833260;
        Mon, 09 Dec 2019 13:43:53 -0800 (PST)
Received: from stbsrv-and-01.and.broadcom.net ([192.19.231.250])
        by smtp.gmail.com with ESMTPSA id z6sm757714wmz.12.2019.12.09.13.43.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Dec 2019 13:43:52 -0800 (PST)
From:   Al Cooper <alcooperx@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     Al Cooper <alcooperx@gmail.com>,
        bcm-kernel-feedback-list@broadcom.com, devicetree@vger.kernel.org,
        Florian Fainelli <f.fainelli@gmail.com>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        linux-arm-kernel@lists.infradead.org,
        Mark Rutland <mark.rutland@arm.com>,
        Rob Herring <robh+dt@kernel.org>,
        Srinath Mannam <srinath.mannam@broadcom.com>
Subject: [PATCH v2 resend 00/13] phy: usb: Updates to Broadcom STB USB PHY driver
Date:   Mon,  9 Dec 2019 16:42:36 -0500
Message-Id: <20191209214249.41137-1-alcooperx@gmail.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patchset contains various updates to the Broadcom STB USB Driver.
The updates include:
- Add support for 7216 and 7211 Broadcom SoCs which use the new
  Synopsis USB Controller.
- Add support for USB Wake
- Add various bug fixes.

v2 - Changes based on review feedback
- Add vendor prefix to DT property "syscon-piarbctl"
- Use standard "wakeup" instead of "wake" for DT "interrupt-names"


Al Cooper (13):
  phy: usb: EHCI DMA may lose a burst of DMA data for 7255xA0 family
  phy: usb: Get all drivers that use USB clks using correct
    enable/disable
  phy: usb: Put USB phys into IDDQ on suspend to save power in S2 mode
  phy: usb: Add "wake on" functionality
  phy: usb: Restructure in preparation for adding 7216 USB support
  dt-bindings: Add Broadcom STB USB PHY binding document
  phy: usb: Add support for new Synopsis USB controller on the 7216
  phy: usb: Add support for new Synopsis USB controller on the 7211b0
  phy: usb: fix driver to defer on clk_get defer
  phy: usb: PHY's MDIO registers not accessible without device installed
  phy: usb: bdc: Fix occasional failure with BDC on 7211
  phy: usb: USB driver is crashing during S3 resume on 7216
  phy: usb: Add support for wake and USB low power mode for 7211 S2/S5

 .../bindings/phy/brcm,brcmstb-usb-phy.txt     |  69 ++-
 drivers/phy/broadcom/Makefile                 |   2 +-
 .../phy/broadcom/phy-brcm-usb-init-synopsis.c | 414 ++++++++++++++++++
 drivers/phy/broadcom/phy-brcm-usb-init.c      | 226 +++++-----
 drivers/phy/broadcom/phy-brcm-usb-init.h      | 148 ++++++-
 drivers/phy/broadcom/phy-brcm-usb.c           | 269 ++++++++++--
 6 files changed, 943 insertions(+), 185 deletions(-)
 create mode 100644 drivers/phy/broadcom/phy-brcm-usb-init-synopsis.c

-- 
2.17.1

