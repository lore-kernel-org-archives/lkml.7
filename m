Return-Path: <SRS0=PjNn=RI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AEDCDC43381
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Mar 2019 08:55:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 89F8520842
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Mar 2019 08:55:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727363AbfCEIzb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 Mar 2019 03:55:31 -0500
Received: from youngberry.canonical.com ([91.189.89.112]:35473 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725818AbfCEIza (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Mar 2019 03:55:30 -0500
Received: from 61-220-137-37.hinet-ip.hinet.net ([61.220.137.37] helo=localhost)
        by youngberry.canonical.com with esmtpsa (TLS1.0:RSA_AES_256_CBC_SHA1:32)
        (Exim 4.76)
        (envelope-from <kai.heng.feng@canonical.com>)
        id 1h15rE-0002Yw-By; Tue, 05 Mar 2019 08:55:28 +0000
From:   Kai-Heng Feng <kai.heng.feng@canonical.com>
To:     ike.pan@canonical.com
Cc:     dvhart@infradead.org, andy@infradead.org,
        platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org,
        Kai-Heng Feng <kai.heng.feng@canonical.com>
Subject: [PATCH] platform/x86: ideapad-laptop: Add Ideapad 530S-14ARR to no_hw_rfkill list
Date:   Tue,  5 Mar 2019 16:55:21 +0800
Message-Id: <20190305085521.25304-1-kai.heng.feng@canonical.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This platform doesn't have hardware switch for rfkill, so add it to
no_hw_rfkill list to prevent wireless gets hard-blocked.

https://bugs.launchpad.net/bugs/1818204
Signed-off-by: Kai-Heng Feng <kai.heng.feng@canonical.com>
---
 drivers/platform/x86/ideapad-laptop.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/platform/x86/ideapad-laptop.c b/drivers/platform/x86/ideapad-laptop.c
index 1589dffab9fa..037970a1800a 100644
--- a/drivers/platform/x86/ideapad-laptop.c
+++ b/drivers/platform/x86/ideapad-laptop.c
@@ -1090,6 +1090,13 @@ static const struct dmi_system_id no_hw_rfkill_list[] = {
 			DMI_MATCH(DMI_PRODUCT_VERSION, "Lenovo ideapad 310-15ISK"),
 		},
 	},
+	{
+		.ident = "Lenovo ideapad 530S-14ARR",
+		.matches = {
+			DMI_MATCH(DMI_SYS_VENDOR, "LENOVO"),
+			DMI_MATCH(DMI_PRODUCT_VERSION, "Lenovo ideapad 530S-14ARR"),
+		},
+	},
 	{
 		.ident = "Lenovo ideapad Y700-14ISK",
 		.matches = {
-- 
2.17.1

