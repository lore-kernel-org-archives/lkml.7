Return-Path: <SRS0=bmbz=XS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B65AEC4CEC4
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Sep 2019 19:48:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7D7C720665
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Sep 2019 19:48:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728760AbfIWTsm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 23 Sep 2019 15:48:42 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:52365 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728592AbfIWTsm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Sep 2019 15:48:42 -0400
Received: from mail-pg1-f199.google.com ([209.85.215.199])
        by youngberry.canonical.com with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <connor.kuehl@canonical.com>)
        id 1iCUK8-0000jE-HO
        for linux-kernel@vger.kernel.org; Mon, 23 Sep 2019 19:48:40 +0000
Received: by mail-pg1-f199.google.com with SMTP id r12so9916063pgm.16
        for <linux-kernel@vger.kernel.org>; Mon, 23 Sep 2019 12:48:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=1S3tbuayATJvDzZnpsz9pe1S0VUYhd/3QByEuRe2Xx4=;
        b=boodLpNgXu2AsjVJBS9UE4smdX4oZlo4x/AB3EbNjFdXj//Ud7IseyI1tKNUU/Efu8
         PDRyj225Cz1mRhx9ffnLpdY4gBSQ7KHXWgh+7dPxEgZsMXgnRuQIcpIh2gec/46XTMXf
         k/23Jc0RWfMJOE3+9EeZKKhCXKwbfDpOVuIZtHa0Wb3GqvcGDM+WUn6jfDwr7XtqqssQ
         l5gXbrqfWs2tCWelszESK6/1W/EPTVvhF7Xg8alS9SCAzPrfNiCGk7zZiYg4IJ+ney2q
         qeBhcLPDU6GN0mvGHjHsGK7AuaB2wVxswEEvgBRg0utXyuely4x4whew/fS8mL35ckPc
         SCng==
X-Gm-Message-State: APjAAAV87Zb7IcmoC1hfkGzFtkTP+7tGqdc0icliXAerOIeWE491M5fV
        W06aGVTM4CkwuhobVFU7am29INASsmKYAqIGKUZTPORwoFDbgTBTWRS5OShZXcz7BKHs/buKWGD
        E1r9MriQ+TMyG9mUKq00zcZSLbltjtbvgsG9tfmujvg==
X-Received: by 2002:a62:3586:: with SMTP id c128mr1393910pfa.105.1569268119372;
        Mon, 23 Sep 2019 12:48:39 -0700 (PDT)
X-Google-Smtp-Source: APXvYqxIyO7oQ4DlmMEmBB+e51zn7In6laZj0i5/rIJzv56lsoRzXrY1pqufNNLtuyies+wIQgTOKw==
X-Received: by 2002:a62:3586:: with SMTP id c128mr1393900pfa.105.1569268119227;
        Mon, 23 Sep 2019 12:48:39 -0700 (PDT)
Received: from localhost.localdomain (c-71-63-131-226.hsd1.or.comcast.net. [71.63.131.226])
        by smtp.gmail.com with ESMTPSA id g12sm16477924pfb.97.2019.09.23.12.48.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Sep 2019 12:48:38 -0700 (PDT)
From:   Connor Kuehl <connor.kuehl@canonical.com>
To:     Larry.Finger@lwfinger.net, gregkh@linuxfoundation.org,
        straube.linux@gmail.com, devel@driverdev.osuosl.org
Cc:     linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
Subject: [PATCH] staging: rtl8188eu: remove dead code in do-while conditional step
Date:   Mon, 23 Sep 2019 12:48:06 -0700
Message-Id: <20190923194806.25347-1-connor.kuehl@canonical.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The local variable 'bcmd_down' is always set to true almost immediately
before the do-while's condition is checked. As a result, !bcmd_down
evaluates to false which short circuits the logical AND operator meaning
that the second operand is never reached and is therefore dead code.

Addresses-Coverity: ("Logically dead code")

Signed-off-by: Connor Kuehl <connor.kuehl@canonical.com>
---
 drivers/staging/rtl8188eu/hal/rtl8188e_cmd.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/staging/rtl8188eu/hal/rtl8188e_cmd.c b/drivers/staging/rtl8188eu/hal/rtl8188e_cmd.c
index 47352f210c0b..a4b317937b23 100644
--- a/drivers/staging/rtl8188eu/hal/rtl8188e_cmd.c
+++ b/drivers/staging/rtl8188eu/hal/rtl8188e_cmd.c
@@ -48,7 +48,6 @@ static u8 _is_fw_read_cmd_down(struct adapter *adapt, u8 msgbox_num)
 static s32 FillH2CCmd_88E(struct adapter *adapt, u8 ElementID, u32 CmdLen, u8 *pCmdBuffer)
 {
 	u8 bcmd_down = false;
-	s32 retry_cnts = 100;
 	u8 h2c_box_num;
 	u32 msgbox_addr;
 	u32 msgbox_ex_addr;
@@ -103,7 +102,7 @@ static s32 FillH2CCmd_88E(struct adapter *adapt, u8 ElementID, u32 CmdLen, u8 *p
 		adapt->HalData->LastHMEBoxNum =
 			(h2c_box_num+1) % RTL88E_MAX_H2C_BOX_NUMS;
 
-	} while ((!bcmd_down) && (retry_cnts--));
+	} while (!bcmd_down);
 
 	ret = _SUCCESS;
 
-- 
2.17.1

