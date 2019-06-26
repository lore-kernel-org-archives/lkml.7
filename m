Return-Path: <SRS0=hRvo=UZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7F091C48BD3
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Jun 2019 10:28:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 571442146E
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Jun 2019 10:28:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="IZlQtchA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726830AbfFZK2Y (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Jun 2019 06:28:24 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:53334 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726131AbfFZK2F (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jun 2019 06:28:05 -0400
Received: by mail-wm1-f67.google.com with SMTP id x15so1519129wmj.3
        for <linux-kernel@vger.kernel.org>; Wed, 26 Jun 2019 03:28:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=YkWgLbuNvvSsHDT8z49IMbijdNbjadafDfpCu7BT3J4=;
        b=IZlQtchA8tyGkV6MypPeDsYD7GgL+RAXRgSwohzYZ7aL3OFSpkLqHTESsBLlDFsdC+
         PL78y4k0DEkuD5Y1Jp7EDdcLshCHlLOMDs+jJWmxe4E5wqfqsV3P0XS5bvG5fGimUBNt
         e5gm4KYH7twrUhQSRa6Xe/IfwZOJWcGlJ4oVE8iWTUdRELvnHQPLoAFYwnY0g2dZghB+
         t/q7yjFbjwydx34vGUCfp5sdO9itDjxYmEU2//f9K2+JFVnjvblxa59G0pH2UErs9QMv
         E/9DIaAe6aANUmXlQ4s6SN5sTdQSMv4KOH6CzlK6zmNTUbpppUvkGPzdIAU7xKUvBXRE
         RcKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=YkWgLbuNvvSsHDT8z49IMbijdNbjadafDfpCu7BT3J4=;
        b=gjFSgA24fycQgKJyQ1oPLFHxtrtkRuhAOvwakgXWuRDaK8I5qMQght0Be4TwS88xxP
         /8alRSXByAErDKeAvGOAV1ODu+87XCHrCYdsYFimuHKWcKapAT2wVtdtVfzw0ECWWzPh
         BQs7wvGwj0mHNElZq62qXZ6wL4p2z336O4d2DWeWi1ozAEJ6QhUypBBifYGoZxVapEKM
         +xvKhu5I7AzN0RhC1b8vVlUaIBWYIXSgTLAEhVbzObT1+HnUO5zb1z83BaBWU123vGEc
         SUynAFTZKglFPNmcq/S0WYZ2ybaj7h5V0LRHV/cCu1xGOj6ztOZTcYTOjbb2BYkHbxui
         1kZw==
X-Gm-Message-State: APjAAAVSWD5dsNJuqyrmCXp55h6jye8p5pPhfdhNdqxbDYRMPV8AahsD
        NAeaNtdDl1t2XVboAxsBR46Mcw==
X-Google-Smtp-Source: APXvYqweJGjACasTVnjTFzlKfUE0OHmQzMzYcn69iB2wzSBvKj6RYfTICKZgBvu12Lg4A4za2EwdCA==
X-Received: by 2002:a1c:d10c:: with SMTP id i12mr2253393wmg.152.1561544882838;
        Wed, 26 Jun 2019 03:28:02 -0700 (PDT)
Received: from srini-hackbox.lan (cpc89974-aztw32-2-0-cust43.18-1.cable.virginm.net. [86.30.250.44])
        by smtp.gmail.com with ESMTPSA id z19sm2212042wmi.7.2019.06.26.03.28.01
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Wed, 26 Jun 2019 03:28:02 -0700 (PDT)
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
To:     gregkh@linuxfoundation.org
Cc:     linux-kernel@vger.kernel.org,
        Bryan O'Donoghue <pure.logic@nexus-software.ie>,
        Leonard Crestez <leonard.crestez@nxp.com>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: [PATCH 2/6] nvmem: imx-ocotp: Ensure WAIT bits are preserved when setting timing
Date:   Wed, 26 Jun 2019 11:27:29 +0100
Message-Id: <20190626102733.11708-3-srinivas.kandagatla@linaro.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190626102733.11708-1-srinivas.kandagatla@linaro.org>
References: <20190626102733.11708-1-srinivas.kandagatla@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Bryan O'Donoghue <pure.logic@nexus-software.ie>

The i.MX6 and i.MX8 both have a bit-field spanning bits 27:22 called the
WAIT field.

The WAIT field according to the documentation for both parts "specifies
time interval between auto read and write access in one time program. It is
given in number of ipg_clk periods."

This patch ensures that the relevant field is read and written back to the
timing register.

Fixes: 0642bac7da42 ("nvmem: imx-ocotp: add write support")

Signed-off-by: Bryan O'Donoghue <pure.logic@nexus-software.ie>
Reviewed-by: Leonard Crestez <leonard.crestez@nxp.com>
Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
---
 drivers/nvmem/imx-ocotp.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/nvmem/imx-ocotp.c b/drivers/nvmem/imx-ocotp.c
index 14c2bff2cd96..f4e117bbf2c3 100644
--- a/drivers/nvmem/imx-ocotp.c
+++ b/drivers/nvmem/imx-ocotp.c
@@ -183,7 +183,8 @@ static void imx_ocotp_set_imx6_timing(struct ocotp_priv *priv)
 	strobe_prog = clk_rate / (1000000000 / 10000) + 2 * (DEF_RELAX + 1) - 1;
 	strobe_read = clk_rate / (1000000000 / 40) + 2 * (DEF_RELAX + 1) - 1;
 
-	timing = strobe_prog & 0x00000FFF;
+	timing = readl(priv->base + IMX_OCOTP_ADDR_TIMING) & 0x0FC00000;
+	timing |= strobe_prog & 0x00000FFF;
 	timing |= (relax       << 12) & 0x0000F000;
 	timing |= (strobe_read << 16) & 0x003F0000;
 
-- 
2.21.0

