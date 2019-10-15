Return-Path: <SRS0=fSNO=YI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4ECF7ECE58F
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Oct 2019 22:47:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1EDB92067B
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Oct 2019 22:47:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="WfxjInaH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390086AbfJOWq6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 15 Oct 2019 18:46:58 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:35331 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728835AbfJOWq6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Oct 2019 18:46:58 -0400
Received: by mail-pg1-f196.google.com with SMTP id p30so13033896pgl.2
        for <linux-kernel@vger.kernel.org>; Tue, 15 Oct 2019 15:46:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=Xkl1PEm6PjOKAdBEuYy5l8ljzm4XzkefiTF2G+osw9g=;
        b=WfxjInaH8u7IeDqrg3R8m7CSa3YmVXEHADW0204Wh2b1NKxFkH0maH6HGfUvTHCTJH
         SX0t74KIu8UHc3mc4LQhFSJ5LP2p56s/JawwceVz8t5qhGbBxM8Hyr5evin/CH7kpEYI
         i/dP4QgPlyIFLgPrCsZARwLppOdt1ywuYPJqQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=Xkl1PEm6PjOKAdBEuYy5l8ljzm4XzkefiTF2G+osw9g=;
        b=fkkQ5goWvfvGroMJNzveah/1f/qRKVrWMO5p1R5xnyWAxU2Ao8qmqry1PFOCokOiVI
         Z3y/FrfjLnG7u20kHAUw+iACUmh5wvJxJln/jrzA6vg+gCn6vx2bD/nmqrNIF5IXlF+p
         BnHNTCjlTd0OYAUkwSguHjjWAY+tFw4+I0U0BjUSn6qmPUa/Nd5xQa9KcjgfXRxvL26S
         XQFa3Kb140R5/DeiwMvm2SJiwtdfylUY9JtqOl1iomfakKUKqGcvMzzIZBJsOrYRO1yX
         oekUjvtbGp6MeL8+c08tGifOxrTldphBIrZL7TECWci6e82NVTnlK6YWHLV65FlsOYAi
         ZeZg==
X-Gm-Message-State: APjAAAUfyHLaeWlKT5xI/IrQBGC3l1zYvdT5UAPh4BeGXl07oui50xTg
        BlYAvdVK8gghKj6fNYGPlYYyyg==
X-Google-Smtp-Source: APXvYqwd4d6rKMvAQu8jUWvGRjFaibW9gAyF1bRumkomfCdN6jllEUE7XSWEANlcX3OUnyZHyND6QQ==
X-Received: by 2002:a17:90a:32a6:: with SMTP id l35mr976437pjb.55.1571179617670;
        Tue, 15 Oct 2019 15:46:57 -0700 (PDT)
Received: from lbrmn-mmayer.ric.broadcom.com ([192.19.228.250])
        by smtp.gmail.com with ESMTPSA id e127sm23019837pfe.37.2019.10.15.15.46.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Oct 2019 15:46:57 -0700 (PDT)
From:   Markus Mayer <mmayer@broadcom.com>
To:     Brian Norris <computersforpeace@gmail.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Gregory Fong <gregory.0xf0@gmail.com>
Cc:     Broadcom Kernel List <bcm-kernel-feedback-list@broadcom.com>,
        ARM Kernel List <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Markus Mayer <mmayer@broadcom.com>
Subject: [PATCH 7/8] memory: brcmstb: dpfe: Compute checksum at __send_command() time
Date:   Tue, 15 Oct 2019 15:45:12 -0700
Message-Id: <20191015224513.16969-8-mmayer@broadcom.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191015224513.16969-1-mmayer@broadcom.com>
References: <20191015224513.16969-1-mmayer@broadcom.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Florian Fainelli <f.fainelli@gmail.com>

Instead of pre-computing the checksum, do it at the time we send the
command, this reduces the possibility of introducing errors as well as
limits the amount of code necessary while adding new commands and/or new
API versions. The MSG_CHKSUM enumeration value is no longer necessary
and is removed.

Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
Signed-off-by: Markus Mayer <mmayer@broadcom.com>
---
 drivers/memory/brcmstb_dpfe.c | 23 ++++++++++-------------
 1 file changed, 10 insertions(+), 13 deletions(-)

diff --git a/drivers/memory/brcmstb_dpfe.c b/drivers/memory/brcmstb_dpfe.c
index cf320302d2c0..7c6e85ad25a7 100644
--- a/drivers/memory/brcmstb_dpfe.c
+++ b/drivers/memory/brcmstb_dpfe.c
@@ -127,7 +127,6 @@ enum dpfe_msg_fields {
 	MSG_COMMAND,
 	MSG_ARG_COUNT,
 	MSG_ARG0,
-	MSG_CHKSUM,
 	MSG_FIELD_MAX	= 16 /* Max number of arguments */
 };
 
@@ -243,21 +242,18 @@ static const struct dpfe_api dpfe_api_v2 = {
 			[MSG_COMMAND] = 1,
 			[MSG_ARG_COUNT] = 1,
 			[MSG_ARG0] = 1,
-			[MSG_CHKSUM] = 4,
 		},
 		[DPFE_CMD_GET_REFRESH] = {
 			[MSG_HEADER] = DPFE_MSG_TYPE_COMMAND,
 			[MSG_COMMAND] = 2,
 			[MSG_ARG_COUNT] = 1,
 			[MSG_ARG0] = 1,
-			[MSG_CHKSUM] = 5,
 		},
 		[DPFE_CMD_GET_VENDOR] = {
 			[MSG_HEADER] = DPFE_MSG_TYPE_COMMAND,
 			[MSG_COMMAND] = 2,
 			[MSG_ARG_COUNT] = 1,
 			[MSG_ARG0] = 2,
-			[MSG_CHKSUM] = 6,
 		},
 	}
 };
@@ -273,18 +269,11 @@ static const struct dpfe_api dpfe_api_v3 = {
 			[MSG_COMMAND] = 0x0101,
 			[MSG_ARG_COUNT] = 1,
 			[MSG_ARG0] = 1,
-			[MSG_CHKSUM] = 0x104,
 		},
 		[DPFE_CMD_GET_REFRESH] = {
 			[MSG_HEADER] = DPFE_MSG_TYPE_COMMAND,
 			[MSG_COMMAND] = 0x0202,
 			[MSG_ARG_COUNT] = 0,
-			/*
-			 * This is a bit ugly. Without arguments, the checksum
-			 * follows right after the argument count and not at
-			 * offset MSG_CHKSUM.
-			 */
-			[MSG_ARG0] = 0x203,
 		},
 		/* There's no GET_VENDOR command in API v3. */
 	},
@@ -432,9 +421,17 @@ static int __send_command(struct brcmstb_dpfe_priv *priv, unsigned int cmd,
 		return -ETIMEDOUT;
 	}
 
+	/* Compute checksum over the message */
+	chksum_idx = msg[MSG_ARG_COUNT] + MSG_ARG_COUNT + 1;
+	chksum = get_msg_chksum(msg, chksum_idx);
+
 	/* Write command and arguments to message area */
-	for (i = 0; i < MSG_FIELD_MAX; i++)
-		writel_relaxed(msg[i], regs + DCPU_MSG_RAM(i));
+	for (i = 0; i < MSG_FIELD_MAX; i++) {
+		if (i == chksum_idx)
+			writel_relaxed(chksum, regs + DCPU_MSG_RAM(i));
+		else
+			writel_relaxed(msg[i], regs + DCPU_MSG_RAM(i));
+	}
 
 	/* Tell DCPU there is a command waiting */
 	writel_relaxed(1, regs + REG_TO_DCPU_MBOX);
-- 
2.17.1

