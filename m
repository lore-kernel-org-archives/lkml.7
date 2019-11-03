Return-Path: <SRS0=Ba5y=Y3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1A43CA9EB0
	for <linux-kernel@archiver.kernel.org>; Sun,  3 Nov 2019 18:06:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B521B214D8
	for <linux-kernel@archiver.kernel.org>; Sun,  3 Nov 2019 18:06:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=cmpwn.com header.i=@cmpwn.com header.b="1kmdWuu6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727641AbfKCSGt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 3 Nov 2019 13:06:49 -0500
Received: from mail.cmpwn.com ([45.56.77.53]:37782 "EHLO mail.cmpwn.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726719AbfKCSGt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 Nov 2019 13:06:49 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=cmpwn.com; s=cmpwn;
        t=1572804408; bh=iyXDslN/si2lsvR1kPESlgOJIjw4oscequFw4eD9FiY=;
        h=From:To:Cc:Subject:Date;
        b=1kmdWuu6SLROhRpTGZJ4NAYSp489lAB4RKjOpPOZ/DAOFETiPi/9QO6WnyuT5Dx9J
         x3YkBkBkbrUDprnx4ClJKxq1hLxW/G2DwnwtIYbnA0GOh+ept4pZ0F4P72zAz0Olek
         7sUfHzeQynzH+3NAhDslFsrUXkVk9RP/Dq3PVPNI=
From:   Drew DeVault <sir@cmpwn.com>
To:     Luis Chamberlain <mcgrof@kernel.org>, linux-kernel@vger.kernel.org
Cc:     Drew DeVault <sir@cmpwn.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        ~sircmpwn/public-inbox@lists.sr.ht
Subject: [PATCH v2] firmware loader: log path to loaded firmwares
Date:   Sun,  3 Nov 2019 13:06:46 -0500
Message-Id: <20191103180646.34880-1-sir@cmpwn.com>
X-Mailer: git-send-email 2.23.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


This is useful for users who are trying to identify the firmwares in use
on their system.

Signed-off-by: Drew DeVault <sir@cmpwn.com>
---
v2 uses dev_dbg instead of printk(KERN_INFO)

 drivers/base/firmware_loader/main.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/base/firmware_loader/main.c b/drivers/base/firmware_loader/main.c
index bf44c79beae9..2537da43a572 100644
--- a/drivers/base/firmware_loader/main.c
+++ b/drivers/base/firmware_loader/main.c
@@ -504,6 +504,7 @@ fw_get_filesystem_firmware(struct device *device, struct fw_priv *fw_priv,
 					 path);
 			continue;
 		}
+		dev_dbg(device, "Loading firmware from %s\n", path);
 		if (decompress) {
 			dev_dbg(device, "f/w decompressing %s\n",
 				fw_priv->fw_name);
-- 
2.23.0

