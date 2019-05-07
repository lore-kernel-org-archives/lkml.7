Return-Path: <SRS0=RyeP=TH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	T_DKIMWL_WL_HIGH,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2451CC004C9
	for <linux-kernel@archiver.kernel.org>; Tue,  7 May 2019 05:52:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EA31A204FD
	for <linux-kernel@archiver.kernel.org>; Tue,  7 May 2019 05:52:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1557208325;
	bh=EiAGYo1E9SxfPaS0i1ndJq2wTAwaTy0SAsYy7NBE9E4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=rfkwEx9+MsxgdJFgcHq1oH6zW5WB+6ohavhVQd+DqKOmorKl1d7mODz4oz0egpWkl
	 IJsI7/aTfYtR0JqDPik56PrMaAgK4TBqtRzEIA+wnFxIqNmH8j59HNPCzBaqr1haCD
	 /1UsPZaNRIqeVvlpBEyjvE9xhwyhg9y37nNRXCyw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729072AbfEGFwD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 May 2019 01:52:03 -0400
Received: from mail.kernel.org ([198.145.29.99]:59164 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728896AbfEGFjd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 May 2019 01:39:33 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 90E41205ED;
        Tue,  7 May 2019 05:39:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1557207572;
        bh=EiAGYo1E9SxfPaS0i1ndJq2wTAwaTy0SAsYy7NBE9E4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Ftso1LR8KSfVK8caVI0gkjC/AHqJB7deyx1H+R2wzYoKEsmA+HsZHRZzCkCeehfvN
         r3o0EKUpJ5ZinsCVR7rMVAZOcYzH6ChxL8SjTtw7E36Cg6+QSKclfG3T/X0r7EYBcZ
         SRr17mKObewfIIw/z7lxaSYiJv9102BLpygTm+Yw=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Daniel Gomez <dagmcr@gmail.com>,
        Javier Martinez Canillas <javier@dowhile0.org>,
        "David S . Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>, linux-wireless@vger.kernel.org
Subject: [PATCH AUTOSEL 4.14 33/95] spi: ST ST95HF NFC: declare missing of table
Date:   Tue,  7 May 2019 01:37:22 -0400
Message-Id: <20190507053826.31622-33-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190507053826.31622-1-sashal@kernel.org>
References: <20190507053826.31622-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Daniel Gomez <dagmcr@gmail.com>

[ Upstream commit d04830531d0c4a99c897a44038e5da3d23331d2f ]

Add missing <of_device_id> table for SPI driver relying on SPI
device match since compatible is in a DT binding or in a DTS.

Before this patch:
modinfo drivers/nfc/st95hf/st95hf.ko | grep alias
alias:          spi:st95hf

After this patch:
modinfo drivers/nfc/st95hf/st95hf.ko | grep alias
alias:          spi:st95hf
alias:          of:N*T*Cst,st95hfC*
alias:          of:N*T*Cst,st95hf

Reported-by: Javier Martinez Canillas <javier@dowhile0.org>
Signed-off-by: Daniel Gomez <dagmcr@gmail.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/nfc/st95hf/core.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/nfc/st95hf/core.c b/drivers/nfc/st95hf/core.c
index 2b26f762fbc3..01acb6e53365 100644
--- a/drivers/nfc/st95hf/core.c
+++ b/drivers/nfc/st95hf/core.c
@@ -1074,6 +1074,12 @@ static const struct spi_device_id st95hf_id[] = {
 };
 MODULE_DEVICE_TABLE(spi, st95hf_id);
 
+static const struct of_device_id st95hf_spi_of_match[] = {
+        { .compatible = "st,st95hf" },
+        { },
+};
+MODULE_DEVICE_TABLE(of, st95hf_spi_of_match);
+
 static int st95hf_probe(struct spi_device *nfc_spi_dev)
 {
 	int ret;
@@ -1260,6 +1266,7 @@ static struct spi_driver st95hf_driver = {
 	.driver = {
 		.name = "st95hf",
 		.owner = THIS_MODULE,
+		.of_match_table = of_match_ptr(st95hf_spi_of_match),
 	},
 	.id_table = st95hf_id,
 	.probe = st95hf_probe,
-- 
2.20.1

