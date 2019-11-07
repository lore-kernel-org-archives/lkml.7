Return-Path: <SRS0=GkzU=Y7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ADCFFC43331
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Nov 2019 17:44:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 81A322084D
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Nov 2019 17:44:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730860AbfKGRoB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 Nov 2019 12:44:01 -0500
Received: from smtp.gentoo.org ([140.211.166.183]:35850 "EHLO smtp.gentoo.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729830AbfKGRoB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Nov 2019 12:44:01 -0500
Received: from grubbs.orbis-terrarum.net (localhost [127.0.0.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by smtp.gentoo.org (Postfix) with ESMTPS id 6676D34CA30
        for <linux-kernel@vger.kernel.org>; Thu,  7 Nov 2019 17:44:00 +0000 (UTC)
Received: (qmail 14153 invoked by uid 129); 7 Nov 2019 17:43:52 -0000
X-HELO: bohr-int.orbis-terrarum.net
Authentication-Results: orbis-terrarum.net; auth=pass (plain) smtp.auth=robbat2-bohr@orbis-terrarum.net; iprev=fail; iprev=fail
Received: from node-1w7jr9qta5qnztyeulvvtjk1k.ipv6.telus.net (HELO bohr-int.orbis-terrarum.net) (2001:569:7c26:ae00:4988:d144:fb03:3538)
 by orbis-terrarum.net (qpsmtpd/0.95) with ESMTPSA (ECDHE-RSA-AES256-GCM-SHA384 encrypted); Thu, 07 Nov 2019 17:43:52 +0000
Received: (nullmailer pid 20692 invoked by uid 10000);
        Thu, 07 Nov 2019 17:43:54 -0000
From:   "Robin H. Johnson" <robbat2@gentoo.org>
To:     mcgrof@kernel.org
Cc:     linux-kernel@vger.kernel.org,
        "Robin H. Johnson" <robbat2@gentoo.org>
Subject: [PATCH] firmware: log names of loaded firmware
Date:   Thu,  7 Nov 2019 09:43:53 -0800
Message-Id: <20191107174353.20625-1-robbat2@gentoo.org>
X-Mailer: git-send-email 2.24.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Virus-Checked: Checked by ClamAV on orbis-terrarum.net
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

It's non-trivial to figure out names of firmware that was actually
loaded, add a print statement at the end of _request_firmware that logs
the name & result of each firmware.

This is esp. valuable early in boot, before logging of UEVENT is
available.

Signed-off-by: Robin H. Johnson <robbat2@gentoo.org>
---
 drivers/base/firmware_loader/main.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/base/firmware_loader/main.c b/drivers/base/firmware_loader/main.c
index bf44c79beae9..f0362af16b66 100644
--- a/drivers/base/firmware_loader/main.c
+++ b/drivers/base/firmware_loader/main.c
@@ -791,6 +791,8 @@ _request_firmware(const struct firmware **firmware_p, const char *name,
 		fw = NULL;
 	}
 
+	dev_info(device, "%s %s ret=%d\n", __func__, name, ret);
+
 	*firmware_p = fw;
 	return ret;
 }
-- 
2.24.0

