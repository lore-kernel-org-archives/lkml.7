Return-Path: <SRS0=G/Om=ZT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F084EC432C0
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Nov 2019 20:39:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C7773215A4
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Nov 2019 20:39:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1574887182;
	bh=BwvFe3SlUTd7e8RE877AWwxlNkY5c/Fr4nhCFdcl3r0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=tXiO51HyLH79JDbUfXza9dtVKucrhA5g1hMGdZu+BqQhZHBaHmetYGVdW4h4tC1rk
	 4h0Q6jX2Xq4qCsBJS9EsZQbf9EzhxeaSkBakGEvdFjGfGNTooxkcoRhCu27LCVayah
	 YAOHNDjPj9lF4X5IIdyoLnPkQgFKIomut+MEGXdo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727820AbfK0Ujl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Nov 2019 15:39:41 -0500
Received: from mail.kernel.org ([198.145.29.99]:43792 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728945AbfK0Ujg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Nov 2019 15:39:36 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1F392215A5;
        Wed, 27 Nov 2019 20:39:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1574887175;
        bh=BwvFe3SlUTd7e8RE877AWwxlNkY5c/Fr4nhCFdcl3r0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=wy+GSQTGAJ5Ix22F3CV6/u9KikWbWc1CxK6g91zquRBBxtLaXaZfWGjsyZ9h7qteD
         N//2yGKJtm7Cxi3r3SpRW7WjGf7w6DI7La7iiXUd4+oQf84wCKVFxSz8KsgPDsOpQj
         s0qXdQQ52H4xZx6LnI4ArsBMPwOIbDpywqhkkaeM=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Kiernan Hager <kah.listaddress@gmail.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.9 010/151] platform/x86: asus-nb-wmi: Support ALS on the Zenbook UX430UQ
Date:   Wed, 27 Nov 2019 21:29:53 +0100
Message-Id: <20191127203007.776845911@linuxfoundation.org>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20191127203000.773542911@linuxfoundation.org>
References: <20191127203000.773542911@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Kiernan Hager <kah.listaddress@gmail.com>

[ Upstream commit db2582afa7444a0ce6bb1ebf1431715969a10b06 ]

This patch adds support for ALS on the Zenbook UX430UQ to the asus_nb_wmi
driver. It also renames "quirk_asus_ux330uak" to "quirk_asus_forceals"
because it is now used for more than one model of computer, and should
thus have a more general name.

Signed-off-by: Kiernan Hager <kah.listaddress@gmail.com>
[andy: massaged commit message, fixed indentation and commas in the code]
Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/platform/x86/asus-nb-wmi.c | 13 +++++++++++--
 1 file changed, 11 insertions(+), 2 deletions(-)

diff --git a/drivers/platform/x86/asus-nb-wmi.c b/drivers/platform/x86/asus-nb-wmi.c
index 69ffbd7b76f74..4c35419608f7c 100644
--- a/drivers/platform/x86/asus-nb-wmi.c
+++ b/drivers/platform/x86/asus-nb-wmi.c
@@ -120,7 +120,7 @@ static struct quirk_entry quirk_asus_x550lb = {
 	.xusb2pr = 0x01D9,
 };
 
-static struct quirk_entry quirk_asus_ux330uak = {
+static struct quirk_entry quirk_asus_forceals = {
 	.wmi_force_als_set = true,
 };
 
@@ -431,7 +431,7 @@ static const struct dmi_system_id asus_quirks[] = {
 			DMI_MATCH(DMI_SYS_VENDOR, "ASUSTeK COMPUTER INC."),
 			DMI_MATCH(DMI_PRODUCT_NAME, "UX330UAK"),
 		},
-		.driver_data = &quirk_asus_ux330uak,
+		.driver_data = &quirk_asus_forceals,
 	},
 	{
 		.callback = dmi_matched,
@@ -442,6 +442,15 @@ static const struct dmi_system_id asus_quirks[] = {
 		},
 		.driver_data = &quirk_asus_x550lb,
 	},
+	{
+		.callback = dmi_matched,
+		.ident = "ASUSTeK COMPUTER INC. UX430UQ",
+		.matches = {
+			DMI_MATCH(DMI_SYS_VENDOR, "ASUSTeK COMPUTER INC."),
+			DMI_MATCH(DMI_PRODUCT_NAME, "UX430UQ"),
+		},
+		.driver_data = &quirk_asus_forceals,
+	},
 	{},
 };
 
-- 
2.20.1



