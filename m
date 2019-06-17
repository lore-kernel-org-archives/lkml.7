Return-Path: <SRS0=xALZ=UQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 20CA0C31E5B
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Jun 2019 21:21:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D912F208CB
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Jun 2019 21:21:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1560806505;
	bh=RWS4ypcpewR1dccRFjGV9Y/7aVml2BDNYi2XHtLitoo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=uCpwwvZQ5hHNuk79p3t2Z/LhzgW0NlKCLu4gHmY1UtK6mtCZ9wT7f4apZmd4WR+Ii
	 MDZVc4z9rErWB7yg42KuQ7KxEIkqVpMOZMhIiJAHYHUH+4xTBJEscJX1otaYvHZQBI
	 k9Ey+iU5XNzGog/Gs0bmXV5dCmXU9hqwOziwv8WI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729411AbfFQVVn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Jun 2019 17:21:43 -0400
Received: from mail.kernel.org ([198.145.29.99]:46200 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728943AbfFQVVl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jun 2019 17:21:41 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8BD7B21655;
        Mon, 17 Jun 2019 21:21:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1560806500;
        bh=RWS4ypcpewR1dccRFjGV9Y/7aVml2BDNYi2XHtLitoo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=MVpQyb3LXMT62IF/UqhscIqRvqGV9NIq8yJVIFUcilNABnTyg6RrquwuHaeYJRt7Q
         NSSYw95KcDzVSLCaQIqbdk0Zw/JddZs8RpxMdCGL0Sejb6kcTb14jqGTfBsjGBkmT/
         7GbKhfGuiTHEqKZ/hxzEE0rRgbpAH4S0C/1mNU2o=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Steffen Dirkwinkel <s.dirkwinkel@beckhoff.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.1 072/115] platform/x86: pmc_atom: Add several Beckhoff Automation boards to critclk_systems DMI table
Date:   Mon, 17 Jun 2019 23:09:32 +0200
Message-Id: <20190617210803.729611238@linuxfoundation.org>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20190617210759.929316339@linuxfoundation.org>
References: <20190617210759.929316339@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[ Upstream commit d6423bd03031c020121da26c41a26bd5cc6d0da3 ]

There are several Beckhoff Automation industrial PC boards which use
pmc_plt_clk* clocks for ethernet controllers. This adds affected boards
to critclk_systems DMI table so the clocks are marked as CLK_CRITICAL and
not turned off.

Fixes: 648e921888ad ("clk: x86: Stop marking clocks as CLK_IS_CRITICAL")
Signed-off-by: Steffen Dirkwinkel <s.dirkwinkel@beckhoff.com>
Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/platform/x86/pmc_atom.c | 24 ++++++++++++++++++++++++
 1 file changed, 24 insertions(+)

diff --git a/drivers/platform/x86/pmc_atom.c b/drivers/platform/x86/pmc_atom.c
index a311f48ce7c9..b1d804376237 100644
--- a/drivers/platform/x86/pmc_atom.c
+++ b/drivers/platform/x86/pmc_atom.c
@@ -413,6 +413,30 @@ static const struct dmi_system_id critclk_systems[] = {
 			DMI_MATCH(DMI_PRODUCT_NAME, "3I380D"),
 		},
 	},
+	{
+		/* pmc_plt_clk* - are used for ethernet controllers */
+		.ident = "Beckhoff CB3163",
+		.matches = {
+			DMI_MATCH(DMI_SYS_VENDOR, "Beckhoff Automation"),
+			DMI_MATCH(DMI_BOARD_NAME, "CB3163"),
+		},
+	},
+	{
+		/* pmc_plt_clk* - are used for ethernet controllers */
+		.ident = "Beckhoff CB6263",
+		.matches = {
+			DMI_MATCH(DMI_SYS_VENDOR, "Beckhoff Automation"),
+			DMI_MATCH(DMI_BOARD_NAME, "CB6263"),
+		},
+	},
+	{
+		/* pmc_plt_clk* - are used for ethernet controllers */
+		.ident = "Beckhoff CB6363",
+		.matches = {
+			DMI_MATCH(DMI_SYS_VENDOR, "Beckhoff Automation"),
+			DMI_MATCH(DMI_BOARD_NAME, "CB6363"),
+		},
+	},
 	{ /*sentinel*/ }
 };
 
-- 
2.20.1



