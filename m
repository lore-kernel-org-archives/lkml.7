Return-Path: <SRS0=95/N=R6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5D48C43381
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Mar 2019 18:23:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B1B0B20643
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Mar 2019 18:23:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1553711018;
	bh=LdnaTTwEfKeySI/RW2qOf3CLXnrpU6S599i+vNalKec=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=CrUYt3ol9nVTH/MupokCOUOU3ivkF3N108dV8UXCuig99Dgv4XGKQte/3G2E2/0WE
	 5uNYRsnt6cvYRzA8Zr/xq5Wuv8Ynz4Wu6jpwNCsekmlTadEVSafQmUacXVQQR85q5L
	 yymviHUQSDfW8gB9mwFXMPn+03P1YZtbkOm8rWlw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391521AbfC0SXh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Mar 2019 14:23:37 -0400
Received: from mail.kernel.org ([198.145.29.99]:42028 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1733019AbfC0SX2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Mar 2019 14:23:28 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0276220651;
        Wed, 27 Mar 2019 18:23:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1553711007;
        bh=LdnaTTwEfKeySI/RW2qOf3CLXnrpU6S599i+vNalKec=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=dWkftnxA45hw1BgHuThvXogfCJawt3RB2xZhKjrz6VZNlESERV7CQla43/9WIhzdu
         VQIIa0IK1+28vzV+Q6Vw//zvf821b1vk1/Z75pSKl2d+oxUpfHJD02YSO6iYteTw+x
         c9aEoKzoqYWnjf7JRCzxPntx8ReqQ/oIrkNIaTr0=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Louis Taylor <louis@kragniz.eu>, Wolfram Sang <wsa@the-dreams.de>,
        Sasha Levin <sashal@kernel.org>, linux-i2c@vger.kernel.org
Subject: [PATCH AUTOSEL 4.4 03/63] i2c: sis630: correct format strings
Date:   Wed, 27 Mar 2019 14:22:23 -0400
Message-Id: <20190327182323.18577-3-sashal@kernel.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190327182323.18577-1-sashal@kernel.org>
References: <20190327182323.18577-1-sashal@kernel.org>
MIME-Version: 1.0
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Louis Taylor <louis@kragniz.eu>

[ Upstream commit 60f7691c624b41a05bfc3493d9b0519e7951b7ef ]

When compiling with -Wformat, clang warns:

drivers/i2c/busses/i2c-sis630.c:482:4: warning: format specifies type
      'unsigned short' but the argument has type 'int' [-Wformat]
                        smbus_base + SMB_STS,
                        ^~~~~~~~~~~~~~~~~~~~

drivers/i2c/busses/i2c-sis630.c:483:4: warning: format specifies type
      'unsigned short' but the argument has type 'int' [-Wformat]
                        smbus_base + SMB_STS + SIS630_SMB_IOREGION - 1);
                        ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

drivers/i2c/busses/i2c-sis630.c:531:37: warning: format specifies type
      'unsigned short' but the argument has type 'int' [-Wformat]
                 "SMBus SIS630 adapter at %04hx", smbus_base + SMB_STS);
                                          ~~~~~   ^~~~~~~~~~~~~~~~~~~~

This patch fixes the format strings to use the format type for int.

Link: https://github.com/ClangBuiltLinux/linux/issues/378
Signed-off-by: Louis Taylor <louis@kragniz.eu>
Reviewed-by: Nick Desaulniers <ndesaulniers@google.com>
Reviewed-by: Jean Delvare <jdelvare@suse.de>
Signed-off-by: Wolfram Sang <wsa@the-dreams.de>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/i2c/busses/i2c-sis630.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/i2c/busses/i2c-sis630.c b/drivers/i2c/busses/i2c-sis630.c
index 1e6805b5cef2..a57aa4fe51a4 100644
--- a/drivers/i2c/busses/i2c-sis630.c
+++ b/drivers/i2c/busses/i2c-sis630.c
@@ -478,7 +478,7 @@ static int sis630_setup(struct pci_dev *sis630_dev)
 	if (!request_region(smbus_base + SMB_STS, SIS630_SMB_IOREGION,
 			    sis630_driver.name)) {
 		dev_err(&sis630_dev->dev,
-			"I/O Region 0x%04hx-0x%04hx for SMBus already in use.\n",
+			"I/O Region 0x%04x-0x%04x for SMBus already in use.\n",
 			smbus_base + SMB_STS,
 			smbus_base + SMB_STS + SIS630_SMB_IOREGION - 1);
 		retval = -EBUSY;
@@ -528,7 +528,7 @@ static int sis630_probe(struct pci_dev *dev, const struct pci_device_id *id)
 	sis630_adapter.dev.parent = &dev->dev;
 
 	snprintf(sis630_adapter.name, sizeof(sis630_adapter.name),
-		 "SMBus SIS630 adapter at %04hx", smbus_base + SMB_STS);
+		 "SMBus SIS630 adapter at %04x", smbus_base + SMB_STS);
 
 	return i2c_add_adapter(&sis630_adapter);
 }
-- 
2.19.1

