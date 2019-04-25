Return-Path: <SRS0=Q+aa=S3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D7CC3C4321A
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Apr 2019 15:41:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 178E22088F
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Apr 2019 15:41:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MRGBfi4+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726979AbfDYPl1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Apr 2019 11:41:27 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:34160 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725900AbfDYPl1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Apr 2019 11:41:27 -0400
Received: by mail-wr1-f65.google.com with SMTP id c6so120895wrm.1;
        Thu, 25 Apr 2019 08:41:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=THSF3Xpz2phunaGLH3/uW/mOh0mb8AvQYIwvd+2yrsA=;
        b=MRGBfi4+8T1MCw1VzyP5Iw0RGMC4a0Rtv1tYP5S4LsQicF4jwEnQdZRWbO6yfoIRYS
         4LaCz0QSvEOVViUBymjpiSoXb3u6V9PeFm9xxzCP7rGoO1UfyUT17Em5RuoFQfR/Jt62
         hn0Tn8KRFF2AJz0fG46PiQK61F1gquOhUcRwerudY0QY5uAxPO3ZCCGc5nrkVdV7HfZL
         mXY1V3bROv80Z+Sibas85VcTk+WcQ/iDvI3QX45d/nM5OjDQG7mCJQrvKPExpvujKMIE
         ctebXwu5Vqep96hy6i6AinuwkOWXmR289rpTgBFrtweK2/i3E898zUjnuD6S+4SvSqNt
         LyTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=THSF3Xpz2phunaGLH3/uW/mOh0mb8AvQYIwvd+2yrsA=;
        b=NZ6hDClR+ai9t2GMqkXu3NEeiJFpzgMfNlwBPZ9FiOlIGfP3VKemI031qatHvYwtcl
         50AeCenXgZdcQLaeF8Mz/egHT+SeodbinXeowTFjycOo0sQ19a/57Hh/gCXDFX4pvFSL
         uQoG4vLnxC8PSaH/jRl3fG9MYoFkKaHwyNbq8kINjsn+tUT5ApMaDN/P8vhWz7SoJoBK
         KQwHbQg0OJySdhIHkPuC2pqcSxrAzp4fsws9eqNyehhpLgUrsiPwnwI9dM6yKrVHxot3
         Xm6nAJiGpi3fV290YyTu295eqNgJ9El6/3uK/g3GGKsj1V6ttAo/+FtC0NzmM0GESlGs
         Q7sA==
X-Gm-Message-State: APjAAAUI/t1+Gx/n5Z70FcGJu/3Mcyp0HitgiNbiPsi296dC1rLd3n1I
        0H45aJ/IOTlUCkRZKv847HM=
X-Google-Smtp-Source: APXvYqxReYZ0nJjjeV9RVFnLNiw5OAw+vEW7DKlf/dsYfzbirRhGUTe0C3Xa4lvjvBicbWD0W8/HVw==
X-Received: by 2002:a5d:5542:: with SMTP id g2mr3887796wrw.58.1556206884990;
        Thu, 25 Apr 2019 08:41:24 -0700 (PDT)
Received: from localhost.localdomain (216.red-79-159-55.dynamicip.rima-tde.net. [79.159.55.216])
        by smtp.gmail.com with ESMTPSA id r9sm21793674wmh.38.2019.04.25.08.41.23
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 25 Apr 2019 08:41:24 -0700 (PDT)
From:   Sergio Paracuellos <sergio.paracuellos@gmail.com>
To:     kishon@ti.com
Cc:     linux-kernel@vger.kernel.org,
        driverdev-devel@linuxdriverproject.org, devicetree@vger.kernel.org,
        john@phrozen.org, linux-mips@vger.kernel.org, robh+dt@kernel.org,
        neil@brown.name
Subject: [PATCH v3 0/2] MT7621 PCIe PHY
Date:   Thu, 25 Apr 2019 17:41:20 +0200
Message-Id: <20190425154122.24122-1-sergio.paracuellos@gmail.com>
X-Mailer: git-send-email 2.19.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series adds support for the PCIe PHY found in the Mediatek
MT7621 SoC.

This is the first attempt to get feedback of what is missing in
this driver to be promoted from staging.

There is also a 'mt7621-pci' driver which is the controller part
which is still in staging and is a client of this phy.

Both drivers have been tested together in a gnubee1 board.

Changes in v3:
    - Recollect Rob's Reviewed-by of bindings.
    - Make Kishon Vijay suggested changes in v2:
    (See https://lkml.org/lkml/2019/4/17/53)
        - Kconfig:
            * Add depends on COMPILE_TEST
            * Select REGMAP_MMIO
        - Make use of 'soc_device_attribute' and 'soc_device_match'
        - Use regmap mmio API instead of directly 'readl' and 'writel'.
        - Use 'platform_get_resource' instead of 'of_address_to_resource'.

Changes in v2:
    - Reorder patches to get bindings first in the series.
    - Don't use child nodes in the device tree. Use #phy-cells=1 instead.
    - Update driver code with new 'xlate' function for the new device tree.
    - Minor changes in driver's macros changing some spaces to tabs.

Thanks in advance for your time.

Best regards,
    Sergio Paracuellos

Sergio Paracuellos (2):
  dt-bindings: phy: Add binding for Mediatek MT7621 PCIe PHY
  phy: ralink: Add PHY driver for MT7621 PCIe PHY

 .../bindings/phy/mediatek,mt7621-pci-phy.txt  |  28 ++
 drivers/phy/ralink/Kconfig                    |   8 +
 drivers/phy/ralink/Makefile                   |   1 +
 drivers/phy/ralink/phy-mt7621-pci.c           | 423 ++++++++++++++++++
 4 files changed, 460 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/phy/mediatek,mt7621-pci-phy.txt
 create mode 100644 drivers/phy/ralink/phy-mt7621-pci.c

-- 
2.19.1

