Return-Path: <SRS0=Dgga=T6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 176CEC28CC0
	for <linux-kernel@archiver.kernel.org>; Thu, 30 May 2019 03:28:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E2E9524811
	for <linux-kernel@archiver.kernel.org>; Thu, 30 May 2019 03:28:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1559186921;
	bh=hM2m/GbTGIy5XDD6dReCrxzL3V8TUzrk+cjuvLwjHKs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=pKN1hHTlIwu2QlvU2xkhLudNU8i7JKNrU45yRhs+9d0tSQQOLoqeH1uHv1s5sQNao
	 chQPHpBQz3+6FFej3IzbmLZ4Mf1qyVGmdf6WcXPqu6WzGDM1rlevaQkq8mgUdoFfqA
	 CYV7CUoEmavmjGNC02IxsRaCZb+XTlQmixix3w7M=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388205AbfE3D2k (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 May 2019 23:28:40 -0400
Received: from mail.kernel.org ([198.145.29.99]:57638 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730463AbfE3DUC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 May 2019 23:20:02 -0400
Received: from localhost (ip67-88-213-2.z213-88-67.customer.algx.net [67.88.213.2])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1615E248AF;
        Thu, 30 May 2019 03:20:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1559186401;
        bh=hM2m/GbTGIy5XDD6dReCrxzL3V8TUzrk+cjuvLwjHKs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=n/4BAR6DDWNghgNtyTO8BcwZ2VdYANqRQ6Rn8+mlJ5G2RhBlyvRNHALXkKE+Zr67X
         Nr0ie1x2u+QpX3fvY0tzrEAAzK0zqqFRpTHqmeUqDwwQxA/j3xLWhfopLXJ0SAMnRv
         kbvFdOUmkj5JTNpF7zDNuj2tgg7oK0Ipo7OcZbNM=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.14 184/193] media: saa7146: avoid high stack usage with clang
Date:   Wed, 29 May 2019 20:07:18 -0700
Message-Id: <20190530030512.918654514@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190530030446.953835040@linuxfoundation.org>
References: <20190530030446.953835040@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[ Upstream commit 03aa4f191a36f33fce015387f84efa0eee94408e ]

Two saa7146/hexium files contain a construct that causes a warning
when built with clang:

drivers/media/pci/saa7146/hexium_orion.c:210:12: error: stack frame size of 2272 bytes in function 'hexium_probe'
      [-Werror,-Wframe-larger-than=]
static int hexium_probe(struct saa7146_dev *dev)
           ^
drivers/media/pci/saa7146/hexium_gemini.c:257:12: error: stack frame size of 2304 bytes in function 'hexium_attach'
      [-Werror,-Wframe-larger-than=]
static int hexium_attach(struct saa7146_dev *dev, struct saa7146_pci_extension_data *info)
           ^

This one happens regardless of KASAN, and the problem is that a
constructor to initialize a dynamically allocated structure leads
to a copy of that structure on the stack, whereas gcc initializes
it in place.

Link: https://bugs.llvm.org/show_bug.cgi?id=40776

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Reviewed-by: Nick Desaulniers <ndesaulniers@google.com>
Signed-off-by: Hans Verkuil <hverkuil-cisco@xs4all.nl>
[hverkuil-cisco@xs4all.nl: fix checkpatch warnings]
Signed-off-by: Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/media/pci/saa7146/hexium_gemini.c | 5 ++---
 drivers/media/pci/saa7146/hexium_orion.c  | 5 ++---
 2 files changed, 4 insertions(+), 6 deletions(-)

diff --git a/drivers/media/pci/saa7146/hexium_gemini.c b/drivers/media/pci/saa7146/hexium_gemini.c
index f708cab01fef1..934332f1fd8e6 100644
--- a/drivers/media/pci/saa7146/hexium_gemini.c
+++ b/drivers/media/pci/saa7146/hexium_gemini.c
@@ -270,9 +270,8 @@ static int hexium_attach(struct saa7146_dev *dev, struct saa7146_pci_extension_d
 	/* enable i2c-port pins */
 	saa7146_write(dev, MC1, (MASK_08 | MASK_24 | MASK_10 | MASK_26));
 
-	hexium->i2c_adapter = (struct i2c_adapter) {
-		.name = "hexium gemini",
-	};
+	strscpy(hexium->i2c_adapter.name, "hexium gemini",
+		sizeof(hexium->i2c_adapter.name));
 	saa7146_i2c_adapter_prepare(dev, &hexium->i2c_adapter, SAA7146_I2C_BUS_BIT_RATE_480);
 	if (i2c_add_adapter(&hexium->i2c_adapter) < 0) {
 		DEB_S("cannot register i2c-device. skipping.\n");
diff --git a/drivers/media/pci/saa7146/hexium_orion.c b/drivers/media/pci/saa7146/hexium_orion.c
index 01f01580c7cac..cb71653a66694 100644
--- a/drivers/media/pci/saa7146/hexium_orion.c
+++ b/drivers/media/pci/saa7146/hexium_orion.c
@@ -232,9 +232,8 @@ static int hexium_probe(struct saa7146_dev *dev)
 	saa7146_write(dev, DD1_STREAM_B, 0x00000000);
 	saa7146_write(dev, MC2, (MASK_09 | MASK_25 | MASK_10 | MASK_26));
 
-	hexium->i2c_adapter = (struct i2c_adapter) {
-		.name = "hexium orion",
-	};
+	strscpy(hexium->i2c_adapter.name, "hexium orion",
+		sizeof(hexium->i2c_adapter.name));
 	saa7146_i2c_adapter_prepare(dev, &hexium->i2c_adapter, SAA7146_I2C_BUS_BIT_RATE_480);
 	if (i2c_add_adapter(&hexium->i2c_adapter) < 0) {
 		DEB_S("cannot register i2c-device. skipping.\n");
-- 
2.20.1



