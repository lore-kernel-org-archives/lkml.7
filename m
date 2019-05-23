Return-Path: <SRS0=P610=TX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6909C282DD
	for <linux-kernel@archiver.kernel.org>; Thu, 23 May 2019 11:52:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6F17020881
	for <linux-kernel@archiver.kernel.org>; Thu, 23 May 2019 11:52:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LEEkOhB0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730614AbfEWLwU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 May 2019 07:52:20 -0400
Received: from mail-pl1-f194.google.com ([209.85.214.194]:40523 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729934AbfEWLwU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 May 2019 07:52:20 -0400
Received: by mail-pl1-f194.google.com with SMTP id g69so2667845plb.7;
        Thu, 23 May 2019 04:52:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=1UvPiQr+yb8D/ufSTOjzWAKWkJl0k4z7eKTQxsP0aKg=;
        b=LEEkOhB0qF3TpvZljvm1fCJlzzYTga31PM7TfoUjncv6pn6Bn/lu0U/IpKI+tzp0SK
         LjkAEnaCUFZAuGeaSMANBLjknqKIz9dWDAY0iZkfntymBkGXBikhD6QaQCPYzoPhG72R
         ++qABYWLrl14FDMNmEQbyCTRHlgREkILmNZXuCeFgrwRWgC1hdorOYD/QDW6TJ2QipD8
         9Ss7Q8mkeZq8/6DtuU7aiDO2s+pYbaB8mZMSuuaifglsiUaDeUbYkkMZudKz5NZinCnR
         uEdu/5b1ngRvwqSPBhiQsARIuHjsGZ61VEt8AiQLKEIL8+jWjsEPaFZxagf0Kj69Vg4a
         Bqkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=1UvPiQr+yb8D/ufSTOjzWAKWkJl0k4z7eKTQxsP0aKg=;
        b=CA/GjaO8hSCiogUHPHK0fKpGxTvmwp0Yh2DUTWfDO8L+ZMq6Ba2ZC0TGNmA4Fx2yJr
         249Dzk02xNRSl7vO0FVAa6Y+i/scY8jmjw6T6cw2UAFaJZFtxLyo2zL+inGBm+MfzQ4Y
         zPlQPJFTsVoS/LrEYArP4q7RBfF/jUkv7KxIh7K4Rb8XcBu5HEm6QIkLviIyLRk4wxvT
         KwxxAbCSbVilFU8akkXYgMsJ1Bx5RERfDftN5YvPT+uXklvGcLq23ToRqtdFu2DBw6WB
         txj+t6oQoCjcegoNJC2vrUGgDEQjmb47qEovs+4STfc43fetgu/myXhrjKd33jqeJsYf
         CHvw==
X-Gm-Message-State: APjAAAUnKLFY9lwA+xmJyUhFQNi0I3tXVUz0BZPmAnfHHNRVLL0Iwd5R
        BvKP0fMKoixUPStR6IS4oyw=
X-Google-Smtp-Source: APXvYqwRSZXft5wN8lNXV2ma/2LEu77SnnsV8qwpl83nBEK74b/7jGnt9NxG7Z50ptOON52k26fkdg==
X-Received: by 2002:a17:902:1029:: with SMTP id b38mr56884097pla.72.1558612339862;
        Thu, 23 May 2019 04:52:19 -0700 (PDT)
Received: from localhost ([43.224.245.181])
        by smtp.gmail.com with ESMTPSA id q7sm412409pjb.0.2019.05.23.04.52.18
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 23 May 2019 04:52:19 -0700 (PDT)
From:   Weitao Hou <houweitaoo@gmail.com>
To:     gregkh@linuxfoundation.org, oneukum@suse.com,
        stern@rowland.harvard.edu, chunfeng.yun@mediatek.com,
        ebiederm@xmission.com, bigeasy@linutronix.de, iamkeyur96@gmail.com,
        keescook@chromium.org, houweitaoo@gmail.com
Cc:     linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] usb: avoid redundant allocation and free of memory
Date:   Thu, 23 May 2019 19:52:08 +0800
Message-Id: <20190523115208.24674-1-houweitaoo@gmail.com>
X-Mailer: git-send-email 2.18.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If usb is not attached, it's unnessary to allocate, copy
and free memory

Signed-off-by: Weitao Hou <houweitaoo@gmail.com>
---
 drivers/usb/core/devio.c | 8 +++-----
 1 file changed, 3 insertions(+), 5 deletions(-)

diff --git a/drivers/usb/core/devio.c b/drivers/usb/core/devio.c
index fa783531ee88..aa17dab6c4ea 100644
--- a/drivers/usb/core/devio.c
+++ b/drivers/usb/core/devio.c
@@ -2130,6 +2130,9 @@ static int proc_ioctl(struct usb_dev_state *ps, struct usbdevfs_ioctl *ctl)
 	if (ps->privileges_dropped)
 		return -EACCES;
 
+	if (!connected(ps))
+		return -ENODEV;
+
 	/* alloc buffer */
 	size = _IOC_SIZE(ctl->ioctl_code);
 	if (size > 0) {
@@ -2146,11 +2149,6 @@ static int proc_ioctl(struct usb_dev_state *ps, struct usbdevfs_ioctl *ctl)
 		}
 	}
 
-	if (!connected(ps)) {
-		kfree(buf);
-		return -ENODEV;
-	}
-
 	if (ps->dev->state != USB_STATE_CONFIGURED)
 		retval = -EHOSTUNREACH;
 	else if (!(intf = usb_ifnum_to_if(ps->dev, ctl->ifno)))
-- 
2.18.0

