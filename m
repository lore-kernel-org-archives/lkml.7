Return-Path: <SRS0=YRFP=X2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CB5A2ECE58B
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Oct 2019 13:23:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9E46D20815
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Oct 2019 13:23:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20150623.gappssmtp.com header.i=@bgdev-pl.20150623.gappssmtp.com header.b="pNZ/xbdG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388376AbfJANXt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 1 Oct 2019 09:23:49 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:36212 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388314AbfJANXr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Oct 2019 09:23:47 -0400
Received: by mail-wm1-f68.google.com with SMTP id m18so3249759wmc.1
        for <linux-kernel@vger.kernel.org>; Tue, 01 Oct 2019 06:23:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=SMP20nsut8K+lsuDT/dJwOJCmshErHGRxDa2UzJ4ZSA=;
        b=pNZ/xbdGWvMJsrR7LsXNQNn33ITo6LZWDWxKIj+23UfEU0tPa4OTxtwuulGSIiue/8
         X2z+ubrhvAbCxFXavidWWf2FPs1QLxu6krwSgY6PHudkSlKEaLZgDkBzc6NwYGIx6O2M
         gJGIhlJWhK/ZIkdZACSA7HXTfduo2+8gMtYCvMnjziBC0/HQAatX59iobBg6IKjSfjD3
         rLOizJzInMBqYjfpyAmLaTJjQd/MLnr733PVks/P89Tj53XeC/UQRVcWijRJ2aSPr0Ir
         ozuJWiz6IJXcSR2YFIfW3DBIud2oNsLgV3/FeBX2XdDnnadTVVJj4DyL8XYJNX/LsIH5
         V6NA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=SMP20nsut8K+lsuDT/dJwOJCmshErHGRxDa2UzJ4ZSA=;
        b=TX9XIAUa3SzuzFqjbBktRwabXlJCKs4Ybv2bDQ3Gss3U+xS5WgnXm91ecF9rWvJI5U
         u0o1+/Kv2kavG8VdzJeeSz/nVefWU9YaUHhBbXGeFc8YLTABNRmcq+psIaBTtNaWHur9
         9mY943IFUO9P33H29S2IHfkir5NGCneR+nRfAad11hZNOzJ1gHrdRg4NwfBsb3AlyDlb
         jU4uz3Bml6cCVOpPOgPuRKYsckaKK9Nq9rMepBfQgrMz2+KAuhjDdXPdhG1zEyaSTFtV
         YZMwDx6OYob/WVPmUUdL0wyCvzFfvA4J8yUAdWMTURxSfrnOLyr6Rsajj1HiQo6EZqZY
         1UIA==
X-Gm-Message-State: APjAAAXe8BT2AVjkp+MXQJTGxh+elvhMKsfVQj8jvDYsVB8W7Yp+o6B9
        s4y0aD31pG9ZCdVGIvlpmtP1aA==
X-Google-Smtp-Source: APXvYqwyifTBE4GQLXEIzUj8q0mUZotz7tkb9kVX+0xOqDAooBCfQ0uylmeNHVo+z3S+VXuqNhiuhg==
X-Received: by 2002:a7b:c8d6:: with SMTP id f22mr3519152wml.173.1569936223907;
        Tue, 01 Oct 2019 06:23:43 -0700 (PDT)
Received: from localhost.localdomain (amontpellier-652-1-281-69.w109-210.abo.wanadoo.fr. [109.210.96.69])
        by smtp.gmail.com with ESMTPSA id o22sm41847990wra.96.2019.10.01.06.23.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Oct 2019 06:23:43 -0700 (PDT)
From:   Bartosz Golaszewski <brgl@bgdev.pl>
To:     Jens Axboe <axboe@kernel.dk>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        JC Kuo <jckuo@nvidia.com>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Mathias Nyman <mathias.nyman@intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-ide@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>
Subject: [PATCH 0/3] tegra: use regulator_bulk_set_supply_names()
Date:   Tue,  1 Oct 2019 15:23:30 +0200
Message-Id: <20191001132333.20146-1-brgl@bgdev.pl>
X-Mailer: git-send-email 2.23.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Bartosz Golaszewski <bgolaszewski@baylibre.com>

The regulator_bulk_set_supply_names() helper was merged upstream. Use it
in a couple tegra drivers.

Bartosz Golaszewski (3):
  ahci: tegra: use regulator_bulk_set_supply_names()
  phy: tegra: use regulator_bulk_set_supply_names()
  usb: host: xhci-tegra: use regulator_bulk_set_supply_names()

 drivers/ata/ahci_tegra.c      | 6 +++---
 drivers/phy/tegra/xusb.c      | 6 +++---
 drivers/usb/host/xhci-tegra.c | 5 +++--
 3 files changed, 9 insertions(+), 8 deletions(-)

-- 
2.23.0

