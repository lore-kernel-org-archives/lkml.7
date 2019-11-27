Return-Path: <SRS0=G/Om=ZT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CEC00C432C0
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Nov 2019 20:33:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A1A3620866
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Nov 2019 20:33:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1574886839;
	bh=w+5QWYDBaAm3wYh2uf2y43zBFPV8/lZUMPSK0ly/lYw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=g7gM0MVX8IKCSYs6C6DVFsHu1PkrtACeLPmHy024G78QhQNZoajZu1G0tBr+QxxOU
	 CGOsvy/LC9fvJzlN+8vm8P9vylK3+gmFc+vS+QSdHsy/pMO5Ak7boyXozdViePnIKG
	 4ZnWCRk0d2pl7Kmyk4X/2qNsw4ob4HYrxz2EvwPw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727312AbfK0Udz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Nov 2019 15:33:55 -0500
Received: from mail.kernel.org ([198.145.29.99]:33898 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727010AbfK0Udy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Nov 2019 15:33:54 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 544FC207DD;
        Wed, 27 Nov 2019 20:33:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1574886833;
        bh=w+5QWYDBaAm3wYh2uf2y43zBFPV8/lZUMPSK0ly/lYw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=M8JIoBAnmOLBwZZHNudizjqeLY/A0uXL0rGUSr3p4h6MMrPHDu2YRxxiQQZH1VJLb
         KZ0/TNfzfcPFob+elQ9CZKqKEgvC9sZtlj6N8C5Ftm51YtOaYgQqyNk8//GgQ88plx
         ChVsawCbGkvWf47MyYqGgTbzKd6KyLg1cQ1iloiI=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        =?UTF-8?q?Jo=C3=A3o=20Paulo=20Rechi=20Vita?= <jprvita@endlessm.com>,
        Ming Shuo Chiu <chiu@endlessm.com>,
        Corentin Chary <corentin.chary@gmail.com>,
        Darren Hart <dvhart@linux.intel.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.4 011/132] asus-wmi: Add quirk_no_rfkill for the Asus Z550MA
Date:   Wed, 27 Nov 2019 21:30:02 +0100
Message-Id: <20191127202908.775370697@linuxfoundation.org>
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

From: João Paulo Rechi Vita <jprvita@gmail.com>

[ Upstream commit 6b7ff2af5286a8c6bec7ff5f4df62e3506c1674e ]

The Asus Z550MA has an airplane-mode indicator LED and the WMI WLAN user
bit set, so asus-wmi uses ASUS_WMI_DEVID_WLAN_LED (0x00010002) to store
the wlan state, which has a side-effect of driving the airplane mode
indicator LED in an inverted fashion. quirk_no_rfkill prevents asus-wmi
from registering RFKill switches at all for this laptop and allows
asus-wireless to drive the LED through the ASHS ACPI device.

Signed-off-by: João Paulo Rechi Vita <jprvita@endlessm.com>
Reported-by: Ming Shuo Chiu <chiu@endlessm.com>
Reviewed-by: Corentin Chary <corentin.chary@gmail.com>
Signed-off-by: Darren Hart <dvhart@linux.intel.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/platform/x86/asus-nb-wmi.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/drivers/platform/x86/asus-nb-wmi.c b/drivers/platform/x86/asus-nb-wmi.c
index 69e33c2772c11..734f95c09508f 100644
--- a/drivers/platform/x86/asus-nb-wmi.c
+++ b/drivers/platform/x86/asus-nb-wmi.c
@@ -351,6 +351,15 @@ static const struct dmi_system_id asus_quirks[] = {
 		},
 		.driver_data = &quirk_no_rfkill,
 	},
+	{
+		.callback = dmi_matched,
+		.ident = "ASUSTeK COMPUTER INC. Z550MA",
+		.matches = {
+			DMI_MATCH(DMI_SYS_VENDOR, "ASUSTeK COMPUTER INC."),
+			DMI_MATCH(DMI_PRODUCT_NAME, "Z550MA"),
+		},
+		.driver_data = &quirk_no_rfkill,
+	},
 	{},
 };
 
-- 
2.20.1



