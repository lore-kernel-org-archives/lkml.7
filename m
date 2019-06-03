Return-Path: <SRS0=cV2B=UC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4DE28C04AB5
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Jun 2019 14:53:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 23D7127A26
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Jun 2019 14:53:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729142AbfFCOxi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Jun 2019 10:53:38 -0400
Received: from gateway36.websitewelcome.com ([192.185.193.119]:33083 "EHLO
        gateway36.websitewelcome.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729038AbfFCOxi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Jun 2019 10:53:38 -0400
Received: from cm13.websitewelcome.com (cm13.websitewelcome.com [100.42.49.6])
        by gateway36.websitewelcome.com (Postfix) with ESMTP id 7BBD2400CB651
        for <linux-kernel@vger.kernel.org>; Mon,  3 Jun 2019 09:14:22 -0500 (CDT)
Received: from gator4166.hostgator.com ([108.167.133.22])
        by cmsmtp with SMTP
        id XoLBhdMUhYTGMXoLBhbra7; Mon, 03 Jun 2019 09:53:37 -0500
X-Authority-Reason: nr=8
Received: from [189.250.123.250] (port=47532 helo=embeddedor)
        by gator4166.hostgator.com with esmtpa (Exim 4.91)
        (envelope-from <gustavo@embeddedor.com>)
        id 1hXoL9-000fQa-VE; Mon, 03 Jun 2019 09:53:36 -0500
Date:   Mon, 3 Jun 2019 09:53:35 -0500
From:   "Gustavo A. R. Silva" <gustavo@embeddedor.com>
To:     Peter Rosin <peda@axentia.se>
Cc:     linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>,
        Kees Cook <keescook@chromium.org>
Subject: [PATCH] i2c: mux: pinctrl: use flexible-array member and
 struct_size() helper
Message-ID: <20190603145335.GA2743@embeddedor>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.9.4 (2018-02-28)
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - gator4166.hostgator.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - embeddedor.com
X-BWhitelist: no
X-Source-IP: 189.250.123.250
X-Source-L: No
X-Exim-ID: 1hXoL9-000fQa-VE
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: (embeddedor) [189.250.123.250]:47532
X-Source-Auth: gustavo@embeddedor.com
X-Email-Count: 3
X-Source-Cap: Z3V6aWRpbmU7Z3V6aWRpbmU7Z2F0b3I0MTY2Lmhvc3RnYXRvci5jb20=
X-Local-Domain: yes
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Update the code to use a flexible array member instead of a pointer in
structure i2c_mux_pinctrl and use the struct_size() helper.

Also, make use of the struct_size() helper instead of an open-coded
version in order to avoid any potential type mistakes, in particular
in the context in which this code is being used.

So, replace the following form:

sizeof(*mux) + num_names * sizeof(*mux->states)

with:

struct_size(mux, states, num_names)

This code was detected with the help of Coccinelle.

Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>
---
 drivers/i2c/muxes/i2c-mux-pinctrl.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/i2c/muxes/i2c-mux-pinctrl.c b/drivers/i2c/muxes/i2c-mux-pinctrl.c
index cc6818aabab5..ff3e8c9d4dd8 100644
--- a/drivers/i2c/muxes/i2c-mux-pinctrl.c
+++ b/drivers/i2c/muxes/i2c-mux-pinctrl.c
@@ -27,7 +27,7 @@
 
 struct i2c_mux_pinctrl {
 	struct pinctrl *pinctrl;
-	struct pinctrl_state **states;
+	struct pinctrl_state *states[];
 };
 
 static int i2c_mux_pinctrl_select(struct i2c_mux_core *muxc, u32 chan)
@@ -104,14 +104,13 @@ static int i2c_mux_pinctrl_probe(struct platform_device *pdev)
 		return PTR_ERR(parent);
 
 	muxc = i2c_mux_alloc(parent, dev, num_names,
-			     sizeof(*mux) + num_names * sizeof(*mux->states),
+			     struct_size(mux, states, num_names),
 			     0, i2c_mux_pinctrl_select, NULL);
 	if (!muxc) {
 		ret = -ENOMEM;
 		goto err_put_parent;
 	}
 	mux = i2c_mux_priv(muxc);
-	mux->states = (struct pinctrl_state **)(mux + 1);
 
 	platform_set_drvdata(pdev, muxc);
 
-- 
2.21.0

