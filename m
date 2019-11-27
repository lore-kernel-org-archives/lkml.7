Return-Path: <SRS0=G/Om=ZT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7503C432C0
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Nov 2019 20:37:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8FED32158C
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Nov 2019 20:37:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1574887063;
	bh=8zZBd4JllggUa0QqNjPyfYaunOJs2rrXmcTVYbNuM+s=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=Jq+uXGCiij3cwMERIl7xjXFQhK9RNZPi5ix/zNDTaxGNTxXcWmyMfTbW4xd6wCpFF
	 AkkXwR8wmg7A9yh7M7DeT3Gi++dgjCzDx5Cb0gCQgWOIEECwIoBsEAFmQ/I3EnHwD5
	 5rA0JpCsjy48Q5tz6GLEyChkAcZWKyoiOEvgun40=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727719AbfK0Uhm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Nov 2019 15:37:42 -0500
Received: from mail.kernel.org ([198.145.29.99]:40654 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727685AbfK0Uhf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Nov 2019 15:37:35 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A46CB215A5;
        Wed, 27 Nov 2019 20:37:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1574887054;
        bh=8zZBd4JllggUa0QqNjPyfYaunOJs2rrXmcTVYbNuM+s=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=vzr7xFJYIFjCK5ErBFMPhgS58MC+ltVkvvqsCKmCjmnzgo2+ZJrkejig03K7YLTOs
         agaRe3NJ3CTNHU4UlGpx8RZPvpflNm08dn89MHXSvKX03RyrYu6kDAj1/Z0hqvE/w+
         iqTxWvzGvXmyA1xygHs/GC9KBpN0yAg6upi8F2Nc=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Nathan Chancellor <natechancellor@gmail.com>,
        Michal Simek <michal.simek@xilinx.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.4 095/132] pinctrl: zynq: Use define directive for PIN_CONFIG_IO_STANDARD
Date:   Wed, 27 Nov 2019 21:31:26 +0100
Message-Id: <20191127203021.759504966@linuxfoundation.org>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20191127202857.270233486@linuxfoundation.org>
References: <20191127202857.270233486@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Nathan Chancellor <natechancellor@gmail.com>

[ Upstream commit cd8a145a066a1a3beb0ae615c7cb2ee4217418d7 ]

Clang warns when one enumerated type is implicitly converted to another:

drivers/pinctrl/pinctrl-zynq.c:985:18: warning: implicit conversion from
enumeration type 'enum zynq_pin_config_param' to different enumeration
type 'enum pin_config_param' [-Wenum-conversion]
        {"io-standard", PIN_CONFIG_IOSTANDARD, zynq_iostd_lvcmos18},
        ~               ^~~~~~~~~~~~~~~~~~~~~
drivers/pinctrl/pinctrl-zynq.c:990:16: warning: implicit conversion from
enumeration type 'enum zynq_pin_config_param' to different enumeration
type 'enum pin_config_param' [-Wenum-conversion]
        = { PCONFDUMP(PIN_CONFIG_IOSTANDARD, "IO-standard", NULL, true),
            ~~~~~~~~~~^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
./include/linux/pinctrl/pinconf-generic.h:163:11: note: expanded from
macro 'PCONFDUMP'
        .param = a, .display = b, .format = c, .has_arg = d     \
                 ^
2 warnings generated.

It is expected that pinctrl drivers can extend pin_config_param because
of the gap between PIN_CONFIG_END and PIN_CONFIG_MAX so this conversion
isn't an issue. Most drivers that take advantage of this define the
PIN_CONFIG variables as constants, rather than enumerated values. Do the
same thing here so that Clang no longer warns.

Signed-off-by: Nathan Chancellor <natechancellor@gmail.com>
Acked-by: Michal Simek <michal.simek@xilinx.com>
Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/pinctrl/pinctrl-zynq.c | 9 +++------
 1 file changed, 3 insertions(+), 6 deletions(-)

diff --git a/drivers/pinctrl/pinctrl-zynq.c b/drivers/pinctrl/pinctrl-zynq.c
index d57b5eca7b983..ad12205dd7962 100644
--- a/drivers/pinctrl/pinctrl-zynq.c
+++ b/drivers/pinctrl/pinctrl-zynq.c
@@ -967,15 +967,12 @@ enum zynq_io_standards {
 	zynq_iostd_max
 };
 
-/**
- * enum zynq_pin_config_param - possible pin configuration parameters
- * @PIN_CONFIG_IOSTANDARD: if the pin can select an IO standard, the argument to
+/*
+ * PIN_CONFIG_IOSTANDARD: if the pin can select an IO standard, the argument to
  *	this parameter (on a custom format) tells the driver which alternative
  *	IO standard to use.
  */
-enum zynq_pin_config_param {
-	PIN_CONFIG_IOSTANDARD = PIN_CONFIG_END + 1,
-};
+#define PIN_CONFIG_IOSTANDARD		(PIN_CONFIG_END + 1)
 
 static const struct pinconf_generic_params zynq_dt_params[] = {
 	{"io-standard", PIN_CONFIG_IOSTANDARD, zynq_iostd_lvcmos18},
-- 
2.20.1



