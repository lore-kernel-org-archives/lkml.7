Return-Path: <SRS0=bMiL=T7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2833FC04AB6
	for <linux-kernel@archiver.kernel.org>; Fri, 31 May 2019 10:31:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EA1C32677A
	for <linux-kernel@archiver.kernel.org>; Fri, 31 May 2019 10:31:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="eMSJafLd"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727178AbfEaKbo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 31 May 2019 06:31:44 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:39423 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726233AbfEaKbm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 May 2019 06:31:42 -0400
Received: by mail-wr1-f67.google.com with SMTP id x4so6180883wrt.6
        for <linux-kernel@vger.kernel.org>; Fri, 31 May 2019 03:31:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=e/qit3YAYedYXhWtBo0joSMWrGm16hBvFvA8vGZqpOo=;
        b=eMSJafLdoP4DDizDOU6pGV9DXZVNAftF1Q7I3m1K62D7k8jntOMsBU5VACjc5E5Wgt
         QdRQiQFZeSI4baoF9vq9IQQDE7GFJhplb7fJ4yEK/vd0Q2KB1OdWb0NKpR3dXNRW7MW1
         UFS/MtugewMvEnfO85vsYPN8R4RmP7IJGZjDNnFmHQukp/Kpmu7J+z6TVLemF+yloCrc
         sgllOksQPoo6Ciu7VzMeoZZKBWOloRQQZEIENnxk0Ac9NEf4zyqy8s00hjMAKxvYlDKI
         9N9XWNCnsmkB2TjL4LCEdTbiULIRxLXH3YOeVhFmvAJgVW6mnyOijrAqXRJqHBUY6b2k
         Sb1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=e/qit3YAYedYXhWtBo0joSMWrGm16hBvFvA8vGZqpOo=;
        b=Nq11Og/sSmbVfrWDCN58iA8eOr2sijtfTY+YCUEvfPEj2QUDo5vh4FewjTr+WcsCGE
         AwkwN7VjMrCHW/P+Ol2arL/GNgNRwj1pFv16CCwnoIwPaOGcScPrsaLsuQUR2aM1EqEO
         rBf+53cS9i0YtmNMJd1ubPZ279M6n1/ROpuDt7t+Fzw9VIQEN8anNor2Ks9+twPB9OeD
         s19Ou1yt1ZOEWq4OFlOCGOP96z/h7zc+6r63eS9EbyTp217/ieMGbg1ZirW7Pho0d4H2
         UZgdiVHIgzJM+EqeOW5gfBoYb8x4c8RZF+CMueQ9BJhWDAAyaPIWQzpmnyZzTceA0rIJ
         l/Kg==
X-Gm-Message-State: APjAAAVVGISRefodCFHcu1E7HnEIdOntYpPQH6F8/v6MjaSbh9+rSo91
        xRTuSNnUDEHELttcltMaEm/ZmA==
X-Google-Smtp-Source: APXvYqw9nPUN3kB50hdthxbIDam9Yqlk99F3arWLzCIUU4hmIzIow25oyIzpAEq72KHxw1TAUoSByg==
X-Received: by 2002:a5d:6709:: with SMTP id o9mr5960345wru.301.1559298700466;
        Fri, 31 May 2019 03:31:40 -0700 (PDT)
Received: from bender.home (amarseille-652-1-291-131.w109-208.abo.wanadoo.fr. [109.208.94.131])
        by smtp.gmail.com with ESMTPSA id j82sm5068008wmj.40.2019.05.31.03.31.39
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 31 May 2019 03:31:39 -0700 (PDT)
From:   Neil Armstrong <narmstrong@baylibre.com>
To:     kishon@ti.com
Cc:     Neil Armstrong <narmstrong@baylibre.com>,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org
Subject: [PATCH] phy: meson-g12a-usb3-pcie: disable locking for cr_regmap
Date:   Fri, 31 May 2019 12:31:37 +0200
Message-Id: <20190531103137.14901-1-narmstrong@baylibre.com>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix the following BUG by disabling locking for the cr_regmap config.

BUG: sleeping function called from invalid context at drivers/phy/amlogic/phy-meson-g12a-usb3-pcie.c:85
in_atomic(): 1, irqs_disabled(): 128, pid: 60, name: kworker/3:1
[snip]
Workqueue: events deferred_probe_work_func
Call trace:
 dump_backtrace+0x0/0x190
 show_stack+0x14/0x20
 dump_stack+0x90/0xb4
 ___might_sleep+0xec/0x110
 __might_sleep+0x50/0x88
 phy_g12a_usb3_pcie_cr_bus_addr.isra.0+0x80/0x1a8
 phy_g12a_usb3_pcie_cr_bus_read+0x34/0x1d8
 _regmap_read+0x60/0xe0
 _regmap_update_bits+0xc4/0x110
 regmap_update_bits_base+0x60/0x90
 phy_g12a_usb3_pcie_init+0xdc/0x210
 phy_init+0x74/0xd0
 dwc3_meson_g12a_probe+0x2cc/0x4d0
 platform_drv_probe+0x50/0xa0
 really_probe+0x20c/0x3b8
 driver_probe_device+0x68/0x150
 __device_attach_driver+0xa8/0x170
 bus_for_each_drv+0x64/0xc8
 __device_attach+0xd8/0x158
 device_initial_probe+0x10/0x18
 bus_probe_device+0x90/0x98
 deferred_probe_work_func+0x94/0xe8
 process_one_work+0x1e0/0x338
 worker_thread+0x230/0x458
 kthread+0x134/0x138
 ret_from_fork+0x10/0x1c

Fixes: 36077e16c050 ("phy: amlogic: Add Amlogic G12A USB3 + PCIE Combo PHY Driver")
Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
---
 drivers/phy/amlogic/phy-meson-g12a-usb3-pcie.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/phy/amlogic/phy-meson-g12a-usb3-pcie.c b/drivers/phy/amlogic/phy-meson-g12a-usb3-pcie.c
index 6233a7979a93..ac322d643c7a 100644
--- a/drivers/phy/amlogic/phy-meson-g12a-usb3-pcie.c
+++ b/drivers/phy/amlogic/phy-meson-g12a-usb3-pcie.c
@@ -188,7 +188,7 @@ static const struct regmap_config phy_g12a_usb3_pcie_cr_regmap_conf = {
 	.reg_read = phy_g12a_usb3_pcie_cr_bus_read,
 	.reg_write = phy_g12a_usb3_pcie_cr_bus_write,
 	.max_register = 0xffff,
-	.fast_io = true,
+	.disable_locking = true,
 };
 
 static int phy_g12a_usb3_init(struct phy *phy)
-- 
2.21.0

