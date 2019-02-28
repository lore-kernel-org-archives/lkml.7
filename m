Return-Path: <SRS0=g5d9=RD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CFF0CC43381
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Feb 2019 18:07:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9B2DF20863
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Feb 2019 18:07:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UiMPOdm4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388560AbfB1SHw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Feb 2019 13:07:52 -0500
Received: from mail-wr1-f66.google.com ([209.85.221.66]:39264 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727499AbfB1SHv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Feb 2019 13:07:51 -0500
Received: by mail-wr1-f66.google.com with SMTP id l5so23025691wrw.6
        for <linux-kernel@vger.kernel.org>; Thu, 28 Feb 2019 10:07:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=zYAsKudwVvUsx3oedl2oKeJpm9BSOkvJEnrUIz73q/8=;
        b=UiMPOdm46fdP1SPbk0XgV2tIXJ5W0WM9Qq6Am+Y8qJFcRJ0WXo0vycio6oCFbgrGyB
         MGR2FLVeZAwnxUCx1CulNNz0E9H5r+bSR6TK3IJZG3HeRIJCJiY+lbPkdiYMP7sqA+rB
         A+p2OMI4Xftwbdx7d6KQ6i7pYKZawU5ZhJQf5jy128vdpKOAJtt+kGA9goyj5u8zLBtt
         ce4jVu5T2509XeMJOgvjzQz8replbPk4qEdkYA7NOaeMmLpHEB2mruKcjEo+IA6+OXJq
         Rq0m7jphwiZPQpkSfNwiNOeQA+4FBf10xcEKdZuVw4AvDZTw5fkhu89dWJQEdENP9JEk
         tM0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=zYAsKudwVvUsx3oedl2oKeJpm9BSOkvJEnrUIz73q/8=;
        b=BECle3Y6xplJZKOQmbGCj7dnVfeP+pr19qjri7m6u9jiOSiglMrhulvtQaZOIP7ghH
         75xy3JcQ4sykGoxaV/69ZH4LGxwjQyvxNsdrzpvE5/0sFV0SCsr2lsJl5JdoQOET5vYw
         tIOEwSel4tpqPH+ll6uno7IdQKqNqYXe0c4FHlPqjLZZHRuTzdgrov7itLRveYdM8VQV
         F5YaUz8PvMbJ9oCfF4CSMuyvYceeElslkQeipYu3OofMJ+V/YN/FoDQ4WaVbFTMOQxh4
         qhlWE6Roasm3mKgqjDH7Acki4a48RwxaQJpkt+VosEDBu7/4SDIPT14AwKDcO5/Dpb9v
         xOaA==
X-Gm-Message-State: APjAAAVFby7xCfTBwJe/AzxyEppr+F200Qc2LlC7Ca6IUh2xez0NQei4
        zT4dTDqlNkOe20Om3iHYS/w=
X-Google-Smtp-Source: APXvYqyNXsIzkSC3lqaYtBlg+YAnKVmMj5sabwJNQ5lgcFzcbXPDWzDFJENb839htKcIQLLDpQrAIA==
X-Received: by 2002:a5d:4e44:: with SMTP id r4mr462124wrt.228.1551377269985;
        Thu, 28 Feb 2019 10:07:49 -0800 (PST)
Received: from luna.home (2.154.9.52.dyn.user.ono.com. [2.154.9.52])
        by smtp.gmail.com with ESMTPSA id b17sm12778415wrt.39.2019.02.28.10.07.48
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 28 Feb 2019 10:07:49 -0800 (PST)
From:   Oscar Gomez Fuente <oscargomezf@gmail.com>
To:     oscargomezf@gmail.com
Cc:     gregkh@linuxfoundation.org, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] staging: rtl8192e: Fix space and suspect issue
Date:   Thu, 28 Feb 2019 19:07:29 +0100
Message-Id: <1551377249-12142-1-git-send-email-oscargomezf@gmail.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

These changes fixed a checkpatch error for space required before the
open brace '{' as well as a warning for suspect code indent for
conditional statements.

Signed-off-by: Oscar Gomez Fuente <oscargomezf@gmail.com>
---
 drivers/staging/rtl8192e/rtllib_wx.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/staging/rtl8192e/rtllib_wx.c b/drivers/staging/rtl8192e/rtllib_wx.c
index 74d4d2d..4f4904a 100644
--- a/drivers/staging/rtl8192e/rtllib_wx.c
+++ b/drivers/staging/rtl8192e/rtllib_wx.c
@@ -541,8 +541,8 @@ int rtllib_wx_set_encode_ext(struct rtllib_device *ieee,
 		if (idx < 1 || idx > NUM_WEP_KEYS)
 			return -EINVAL;
 		idx--;
-	} else{
-			idx = ieee->crypt_info.tx_keyidx;
+	} else {
+		idx = ieee->crypt_info.tx_keyidx;
 	}
 	if (ext->ext_flags & IW_ENCODE_EXT_GROUP_KEY) {
 		crypt = &ieee->crypt_info.crypt[idx];
-- 
2.7.4

