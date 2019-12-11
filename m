Return-Path: <SRS0=Yvat=2B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AEB5FC43603
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Dec 2019 19:28:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8605520836
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Dec 2019 19:28:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="hk5XU7cU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729510AbfLKT2P (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Dec 2019 14:28:15 -0500
Received: from mail-vs1-f74.google.com ([209.85.217.74]:43910 "EHLO
        mail-vs1-f74.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729274AbfLKT2O (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Dec 2019 14:28:14 -0500
Received: by mail-vs1-f74.google.com with SMTP id j8so3316919vsm.10
        for <linux-kernel@vger.kernel.org>; Wed, 11 Dec 2019 11:28:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=RQFDo13VZRdiKwc/pVrHKJHbLovklfvTM/XI87MZyHc=;
        b=hk5XU7cUaCcQ0Nde+eT5cb/6qwUvOjqFutXP7PRicgzyIGfK7KSbsZII98DfGIn2FW
         dtQymELG0GrhacSnYHQp3RHByaT46VfTyG6tnTl4Jsk836X8X+fyiDg1vDM0umT5oppm
         UgVIqhFFhkz4LTwJvtJFgchjlga2R0OupRlXvw3oko/W+1K9fRHoYDgICYr3QjciF1hv
         60PjkiTLGt5xA3chP4Yx0vIchU/ZZ3iaMRNuguxvUHnFe1WEFaZso9+eBFcxLjuV0NVZ
         /07928V8wcKVNcx4O0aZhvCWDioa2HlcD1rankvFdc0518jUklNNTHG92Y9KtstUiOND
         P6JQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=RQFDo13VZRdiKwc/pVrHKJHbLovklfvTM/XI87MZyHc=;
        b=VjaPnJoiZ5hqFWH4JkBnJlwe6A83BXyCcfzTxt9zXpdUdQfxYBDITVc/hPrWsJomZD
         8aReLtTL5dFesaj19A5hkiVsFwlUdyBjdLLS4/E+rr+yz/G3TXG80RNlJTdsO3EgXa2t
         PD+sCPXCpLIbIQkYLiD98JARaHNsq7Im/gbnoNK82HBTc5sZqX+/LmbE4vQ9J9UQtyIz
         74MZml439FP1DNHNqrIxb7miFa+0y2tGaRA4Vbk0pIkemeTaHXu7/j+xCOSBoVTPb2bZ
         oZUc1YSZGx6ypj18JdR0LWO1NOEkEja4k6zSOIIAUoPHS9XThQM/1ZJmKl9vn7TaKO1n
         k36g==
X-Gm-Message-State: APjAAAU6eElLjuQ0T3nniZZJtOiS5ewtuwAcK9X4vNkN7SZG/uW0YUjw
        PTdRj/k9hfwLkiJPmOtBS5PtI8jmNFIy8lYLV9QM5g==
X-Google-Smtp-Source: APXvYqxn1i43i48Jqfr6hVocDDO1DiINGbV0G5JeKpjCv8KvGUu2v9FiOXP9TMA8RDO8XOUYwG4WIpJMJNZpSQ90pHgIUg==
X-Received: by 2002:a1f:6103:: with SMTP id v3mr5185450vkb.60.1576092492825;
 Wed, 11 Dec 2019 11:28:12 -0800 (PST)
Date:   Wed, 11 Dec 2019 11:27:38 -0800
In-Reply-To: <20191211192742.95699-1-brendanhiggins@google.com>
Message-Id: <20191211192742.95699-4-brendanhiggins@google.com>
Mime-Version: 1.0
References: <20191211192742.95699-1-brendanhiggins@google.com>
X-Mailer: git-send-email 2.24.0.525.g8f36a354ae-goog
Subject: [PATCH v1 3/7] net: axienet: add unspecified HAS_IOMEM dependency
From:   Brendan Higgins <brendanhiggins@google.com>
To:     jdike@addtoit.com, richard@nod.at, anton.ivanov@cambridgegreys.com,
        "David S. Miller" <davem@davemloft.net>,
        Michal Simek <michal.simek@xilinx.com>,
        Radhey Shyam Pandey <radhey.shyam.pandey@xilinx.com>
Cc:     linux-um@lists.infradead.org, linux-kernel@vger.kernel.org,
        davidgow@google.com, Brendan Higgins <brendanhiggins@google.com>,
        netdev@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently CONFIG_XILINX_AXI_EMAC=y implicitly depends on
CONFIG_HAS_IOMEM=y; consequently, on architectures without IOMEM we get
the following build error:

ld: drivers/net/ethernet/xilinx/xilinx_axienet_main.o: in function `axienet_probe':
drivers/net/ethernet/xilinx/xilinx_axienet_main.c:1680: undefined reference to `devm_ioremap_resource'
ld: drivers/net/ethernet/xilinx/xilinx_axienet_main.c:1779: undefined reference to `devm_ioremap_resource'
ld: drivers/net/ethernet/xilinx/xilinx_axienet_main.c:1789: undefined reference to `devm_ioremap_resource'

Fix the build error by adding the unspecified dependency.

Reported-by: Brendan Higgins <brendanhiggins@google.com>
Signed-off-by: Brendan Higgins <brendanhiggins@google.com>
---
 drivers/net/ethernet/xilinx/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/net/ethernet/xilinx/Kconfig b/drivers/net/ethernet/xilinx/Kconfig
index 6304ebd8b5c69..b1a285e693756 100644
--- a/drivers/net/ethernet/xilinx/Kconfig
+++ b/drivers/net/ethernet/xilinx/Kconfig
@@ -25,6 +25,7 @@ config XILINX_EMACLITE
 
 config XILINX_AXI_EMAC
 	tristate "Xilinx 10/100/1000 AXI Ethernet support"
+	depends on HAS_IOMEM
 	select PHYLINK
 	---help---
 	  This driver supports the 10/100/1000 Ethernet from Xilinx for the
-- 
2.24.0.525.g8f36a354ae-goog

