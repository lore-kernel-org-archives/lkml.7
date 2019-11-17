Return-Path: <SRS0=PwuH=ZJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6A7F0C432C0
	for <linux-kernel@archiver.kernel.org>; Sun, 17 Nov 2019 23:47:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3F2CE20727
	for <linux-kernel@archiver.kernel.org>; Sun, 17 Nov 2019 23:47:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726336AbfKQXrn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 17 Nov 2019 18:47:43 -0500
Received: from smtp.gentoo.org ([140.211.166.183]:54110 "EHLO smtp.gentoo.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726268AbfKQXrm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 17 Nov 2019 18:47:42 -0500
Received: from grubbs.orbis-terrarum.net (localhost [127.0.0.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by smtp.gentoo.org (Postfix) with ESMTPS id AE51234CF2F
        for <linux-kernel@vger.kernel.org>; Sun, 17 Nov 2019 23:47:41 +0000 (UTC)
Received: (qmail 22676 invoked by uid 129); 17 Nov 2019 23:47:34 -0000
X-HELO: bohr-int.orbis-terrarum.net
Authentication-Results: orbis-terrarum.net; auth=pass (plain) smtp.auth=robbat2-bohr@orbis-terrarum.net; iprev=fail; iprev=fail
Received: from node-1w7jr9qta5qnztyeulvvtjk1k.ipv6.telus.net (HELO bohr-int.orbis-terrarum.net) (2001:569:7c26:ae00:4988:d144:fb03:3538)
 by orbis-terrarum.net (qpsmtpd/0.95) with ESMTPSA (ECDHE-RSA-AES256-GCM-SHA384 encrypted); Sun, 17 Nov 2019 23:47:33 +0000
Received: (nullmailer pid 27161 invoked by uid 10000);
        Sun, 17 Nov 2019 23:47:35 -0000
From:   "Robin H. Johnson" <robbat2@gentoo.org>
To:     mcgrof@kernel.org
Cc:     linux-kernel@vger.kernel.org, sir@cmpwn.com,
        ~sircmpwn/public-inbox@lists.sr.ht, gregkh@linuxfoundation.org,
        rafael@kernel.org, "Robin H. Johnson" <robbat2@gentoo.org>
Subject: [PATCH v3] firmware: log name & outcome of loaded firmware
Date:   Sun, 17 Nov 2019 15:47:34 -0800
Message-Id: <20191117234734.27101-1-robbat2@gentoo.org>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <robbat2-20191113T195158-869302266Z@orbis-terrarum.net>
References: <robbat2-20191113T195158-869302266Z@orbis-terrarum.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Virus-Checked: Checked by ClamAV on orbis-terrarum.net
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

It's non-trivial to figure out names of firmware that was actually
loaded, add a debug statement at the end of _request_firmware that logs
the name & result of each firmware.

This is esp. valuable early in boot, before logging of UEVENT is
available.

v3:
- Log at dev_dbg level per maintainer.
- HOWTO: Enable at boot via kernel boot param
  dyndbg="func _request_firmware +p"
- Credit to Drew DeVault for parallel creation and help promoting the
  idea.

Alternate-Creation: Drew DeVault <sir@cmpwn.com>
Signed-off-by: Robin H. Johnson <robbat2@gentoo.org>
---
 drivers/base/firmware_loader/main.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/base/firmware_loader/main.c b/drivers/base/firmware_loader/main.c
index bf44c79beae9..84a879608ca4 100644
--- a/drivers/base/firmware_loader/main.c
+++ b/drivers/base/firmware_loader/main.c
@@ -791,6 +791,13 @@ _request_firmware(const struct firmware **firmware_p, const char *name,
 		fw = NULL;
 	}
 
+	/* Provide a consistent way to capture the result of trying to load any
+	 * firmware. As a potential future improvement, this might include
+	 * persistent state that firmware is loaded (or failed to load for some
+	 * reason). See Message-ID: <20191113205010.GY11244@42.do-not-panic.com>
+	 * for background */
+	dev_dbg(device, "%s %s ret=%d\n", __func__, name, ret);
+
 	*firmware_p = fw;
 	return ret;
 }
-- 
2.24.0

