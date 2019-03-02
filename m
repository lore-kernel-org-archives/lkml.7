Return-Path: <SRS0=OfNL=RF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 68997C43381
	for <linux-kernel@archiver.kernel.org>; Sat,  2 Mar 2019 09:43:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2690220836
	for <linux-kernel@archiver.kernel.org>; Sat,  2 Mar 2019 09:43:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AlWKYEmo"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726370AbfCBJnR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 2 Mar 2019 04:43:17 -0500
Received: from mail-wm1-f65.google.com ([209.85.128.65]:35973 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726119AbfCBJnR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 2 Mar 2019 04:43:17 -0500
Received: by mail-wm1-f65.google.com with SMTP id j125so368836wmj.1
        for <linux-kernel@vger.kernel.org>; Sat, 02 Mar 2019 01:43:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=syjDp5AtcL9XBtFK+ESgSPx24l1Z1Rx9YKkdB/Z6VbU=;
        b=AlWKYEmop8tBHcdeTvQ3sKRtrxd+rOPV/SXvgGPkBJyFFT7w1ZurIJJotOHpxvMC/M
         XiXZFuquQjO91WxmRj06+s8DKI8bjB7Tbi+1DpjRmo0qawd9q00DbYeRbcDux0iv3da3
         knqCp858e1J7ABLTfj5/IZtlLht1T95qEPbOymUqKRA1btY2kEOf8Msn+oh+jo/hayrj
         uy11j2yqzH5UrWxuvC2Sx+xYJ7p3F/gwI5OLfT4OgzMvuFVkuJb7+gHiq1IrTsIljEaH
         DQyV7c9IUp8CVZngbxoEsMeCS25S9cORQGXgf7l1k5EBhCqjjoYCF4u82lEXS9lr3GLJ
         yLWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=syjDp5AtcL9XBtFK+ESgSPx24l1Z1Rx9YKkdB/Z6VbU=;
        b=WxfGqo04e5HDuKVfI6JdhJESfHyPgL2K3ouV2100JQPxaQX66VK2Hgm7Og1vVb/a64
         8LLXGXREImOmJEcMMjLbNkx3EXWZKSS1XHmLTb2yo/i1Fj/XJZoSvy3LT3DGZpnQL/1v
         336ZKXf9x1dutr7xK/QEKzhUCThQaZGMhYzUg3DSRbB4FkCuvVEszuQiTVC/4etdJa/0
         ow5eBxdgQDyN9UXoTCRB5FqqqWJXCzlYum9jA/03BQ0+Z55u0v2+zwG4ujzknoUD7YN0
         wk3dBwv+7t4/9jpayb07POD59ecQjxxNnE/BqrJ9fFULNUxzJNi0O0I8QZ4s+ZYDOAJc
         0fUA==
X-Gm-Message-State: APjAAAU7rRPfK+yZENa4gMUjUOufON2nnQjjVxg2igMR8mGRiv4PHbMN
        7F4RIMGVsos9Xesry1P8IZVPCG4Z
X-Google-Smtp-Source: AHgI3IYGR2JKIJWwkWnwFi+v0ieFDhiWFnzqGYu27+6AWH04bX5BxlRIg3caeCGQL1lG1bTJAEk8zw==
X-Received: by 2002:a1c:96ce:: with SMTP id y197mr5776056wmd.126.1551519795394;
        Sat, 02 Mar 2019 01:43:15 -0800 (PST)
Received: from goyamonster.habana-labs.com ([31.154.181.186])
        by smtp.gmail.com with ESMTPSA id n14sm1186004wrx.24.2019.03.02.01.43.14
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 02 Mar 2019 01:43:14 -0800 (PST)
From:   Oded Gabbay <oded.gabbay@gmail.com>
To:     gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org
Cc:     joe@perches.com
Subject: [PATCH] habanalabs: use %px instead of %p in error print
Date:   Sat,  2 Mar 2019 11:43:12 +0200
Message-Id: <20190302094312.13363-1-oded.gabbay@gmail.com>
X-Mailer: git-send-email 2.18.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When parsing the address of an internal command buffer, the driver prints
an error if the buffer's address is not in the range of the device's DRAM
or SRAM memory address space.

Use %px to print the real address that the user gave the driver and not a
hashed value, so the user will get a clue regarding the origin of his
error.

Note that if the print occurs, the pointer that is printed is a
user's virtual address and not some kind of physical address.

Suggested-by: Joe Perches <joe@perches.com>
Signed-off-by: Oded Gabbay <oded.gabbay@gmail.com>
---
 drivers/misc/habanalabs/goya/goya.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/misc/habanalabs/goya/goya.c b/drivers/misc/habanalabs/goya/goya.c
index c4f3ec1e9d8b..238dd57c541b 100644
--- a/drivers/misc/habanalabs/goya/goya.c
+++ b/drivers/misc/habanalabs/goya/goya.c
@@ -4293,7 +4293,7 @@ static int goya_parse_cb_no_ext_quque(struct hl_device *hdev,
 			return 0;
 
 		dev_err(hdev->dev,
-			"Internal CB address %p + 0x%x is not in SRAM nor in DRAM\n",
+			"Internal CB address %px + 0x%x is not in SRAM nor in DRAM\n",
 			parser->user_cb, parser->user_cb_size);
 
 		return -EFAULT;
-- 
2.18.0

