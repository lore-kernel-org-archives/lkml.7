Return-Path: <SRS0=Y9JJ=T2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA96EC07542
	for <linux-kernel@archiver.kernel.org>; Sun, 26 May 2019 01:19:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9FD02214DA
	for <linux-kernel@archiver.kernel.org>; Sun, 26 May 2019 01:19:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="oW0SsEHy"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727738AbfEZBT6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 25 May 2019 21:19:58 -0400
Received: from mail-ua1-f65.google.com ([209.85.222.65]:46422 "EHLO
        mail-ua1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727622AbfEZBTf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 25 May 2019 21:19:35 -0400
Received: by mail-ua1-f65.google.com with SMTP id a95so5139513uaa.13
        for <linux-kernel@vger.kernel.org>; Sat, 25 May 2019 18:19:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=2CttEDFzuoOFmumd7c7+k8vupiNFD+Q2bYe9G0CKDuU=;
        b=oW0SsEHygGL0sKM58xiqfbayaqbZjznt9MDUh4lZYFb58UDHS8dxF46H7vxjPptB9K
         JVaVtSu8DhKQjmqlxgYHI73nYcxGYqtyAae+SHOH/gKb+6Te04kv+9zhsmHsMe8lLn0+
         rCyUTaMeSnib+jQjnyYlmMAI99NR/LXUyX8Lwf0znYMuxK5bceAZ8ibSUaponibj0BKq
         ms7P3Yq21plDwdfpClJryb/ySv57CUiiHaRtVLRnM6RlXhMCbV1AlgrNHVmta3kT1HaE
         D2oUSuIAr01aOFxmYsJ4EiUdZ8M8l4vf8N1zxeyMY9rm/iro4lL8SFwvMvQanCMNQ7vd
         9EfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=2CttEDFzuoOFmumd7c7+k8vupiNFD+Q2bYe9G0CKDuU=;
        b=VNpg8ila2W7nztcP7cDLcquutla2JnMf5ofQ6gGWAdbSgZp/0LGlvZzZK+ofppp0uM
         x5ly5l1YKFLhShY5ji9D/rBbWWTlgvniSp8FOMOoi4B41eFeAxo28JkoKtvvcRBv5BSu
         2X06daRiHMnKQ2F8vX+puRCmpkVGikvkv8aOOuOztVKPdtY2Z+zL1wta+oVYButmDZ48
         3otyy3CwwZ+KfieFBvmV9KXH88NDdtwlK349tff/Y1jxjrKtjDqw9wPdyXYo/YGJ0jW9
         6x9eRE7UuhH6Qb4m9pzJu1HvkaVq3oZRRoO5Pmo/N6jWKsBE4D3jjtwNgjYxUuc+VWy1
         mvWA==
X-Gm-Message-State: APjAAAW6hxoHZmmNNwWbLYVUjzXeNBryfPWOE4Zaqr4Sxb2YYfVYb7mJ
        gHMqCrj0nmLWoogJgFsEJjQ=
X-Google-Smtp-Source: APXvYqxzLV1COOV54LKZZseEpXVOSvSlUvrKCJ/XQK6mA2Uf7ZZeBLjOfvDwUvtXLu53OeL2PFMFKA==
X-Received: by 2002:ab0:688b:: with SMTP id t11mr24261965uar.70.1558833574217;
        Sat, 25 May 2019 18:19:34 -0700 (PDT)
Received: from arch-01.home (c-73-132-202-198.hsd1.md.comcast.net. [73.132.202.198])
        by smtp.gmail.com with ESMTPSA id 9sm4593181vkk.43.2019.05.25.18.19.33
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Sat, 25 May 2019 18:19:33 -0700 (PDT)
From:   Geordan Neukum <gneukum1@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org,
        Geordan Neukum <gneukum1@gmail.com>
Subject: [PATCH 4/8] staging: kpc2000: kpc_i2c: Remove unnecessary consecutive newlines
Date:   Sun, 26 May 2019 01:18:30 +0000
Message-Id: <3e02066001a8e32632bf2fe287be727944254fef.1558832514.git.gneukum1@gmail.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <cover.1558832514.git.gneukum1@gmail.com>
References: <cover.1558832514.git.gneukum1@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The kpc2000_i2c.c file contains instances of unnecessary consecutive
newlines which impact the readability of the file. Remove these
unnecessary newlines.

Signed-off-by: Geordan Neukum <gneukum1@gmail.com>
---
 drivers/staging/kpc2000/kpc2000_i2c.c | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/drivers/staging/kpc2000/kpc2000_i2c.c b/drivers/staging/kpc2000/kpc2000_i2c.c
index 1d100bb7c548..1767f351a116 100644
--- a/drivers/staging/kpc2000/kpc2000_i2c.c
+++ b/drivers/staging/kpc2000/kpc2000_i2c.c
@@ -115,7 +115,6 @@ struct i2c_device {
 #define PCI_DEVICE_ID_INTEL_LYNXPOINT_SMBUS         0x8c22
 #define PCI_DEVICE_ID_INTEL_LYNXPOINT_LP_SMBUS      0x9c22
 
-
 #define FEATURE_SMBUS_PEC       BIT(0)
 #define FEATURE_BLOCK_BUFFER    BIT(1)
 #define FEATURE_BLOCK_PROC      BIT(2)
@@ -521,8 +520,6 @@ static s32 i801_access(struct i2c_adapter *adap, u16 addr, unsigned short flags,
 	return 0;
 }
 
-
-
 static u32 i801_func(struct i2c_adapter *adapter)
 {
 	struct i2c_device *priv = i2c_get_adapdata(adapter);
@@ -571,8 +568,6 @@ static const struct i2c_algorithm smbus_algorithm = {
 	.functionality  = i801_func,
 };
 
-
-
 /********************************
  *** Part 2 - Driver Handlers ***
  ********************************/
-- 
2.21.0

