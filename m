Return-Path: <SRS0=G/Om=ZT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86E18C43215
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Nov 2019 20:34:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5D9222154A
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Nov 2019 20:34:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1574886854;
	bh=ISw/D12soK1PH4BKs72Gf3BrgKXz0bgrQqro4pbVxT8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=NrkAB0wLrfhCra8Bct1OFJytxMemeBVNNNAZvl/caCVQLL4zsCBe+j4tC/9hrWO3v
	 2a0ZMFPDnrv9JbHohaA0Fbu9o0k2CiE+QBYWYCnTDf5QwJOD02iRc8QwK4j0Tcdama
	 9z4O/Y8V55X3KLNmR1feiRQGactLmVR60b8jFE6E=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727535AbfK0UeN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Nov 2019 15:34:13 -0500
Received: from mail.kernel.org ([198.145.29.99]:34330 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727501AbfK0UeJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Nov 2019 15:34:09 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0920C207DD;
        Wed, 27 Nov 2019 20:34:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1574886848;
        bh=ISw/D12soK1PH4BKs72Gf3BrgKXz0bgrQqro4pbVxT8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=qH5cFl0O1jH2X3Gg0CcnBAaR4ihlK3qzRZwlujYDEPHVHGRie9eoV3+kNh3aWcJbH
         1dkfBTTeY+NtToF9FMsGKuUVNvMgywgg6v0OXsaoiqPR+CW/AKyfHK8ISiJ8wS56Kj
         dsdRLI3J0slEYODL5cDsBI5QVJZK3sgai7sy/sd8=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Kiernan Hager <kah.listaddress@gmail.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.4 017/132] platform/x86: asus-nb-wmi: Support ALS on the Zenbook UX430UQ
Date:   Wed, 27 Nov 2019 21:30:08 +0100
Message-Id: <20191127202913.900919182@linuxfoundation.org>
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
index bf9e48010b98b..274ccf920af50 100644
--- a/drivers/platform/x86/asus-nb-wmi.c
+++ b/drivers/platform/x86/asus-nb-wmi.c
@@ -120,7 +120,7 @@ static struct quirk_entry quirk_asus_x550lb = {
 	.xusb2pr = 0x01D9,
 };
 
-static struct quirk_entry quirk_asus_ux330uak = {
+static struct quirk_entry quirk_asus_forceals = {
 	.wmi_force_als_set = true,
 };
 
@@ -422,7 +422,7 @@ static const struct dmi_system_id asus_quirks[] = {
 			DMI_MATCH(DMI_SYS_VENDOR, "ASUSTeK COMPUTER INC."),
 			DMI_MATCH(DMI_PRODUCT_NAME, "UX330UAK"),
 		},
-		.driver_data = &quirk_asus_ux330uak,
+		.driver_data = &quirk_asus_forceals,
 	},
 	{
 		.callback = dmi_matched,
@@ -433,6 +433,15 @@ static const struct dmi_system_id asus_quirks[] = {
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



