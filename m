Return-Path: <SRS0=LehB=SZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6D0AC10F11
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Apr 2019 02:36:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 827C72075A
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Apr 2019 02:36:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="X5xHH4Tx"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731049AbfDWCgW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 22 Apr 2019 22:36:22 -0400
Received: from mail-pl1-f195.google.com ([209.85.214.195]:40569 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729502AbfDWCgV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Apr 2019 22:36:21 -0400
Received: by mail-pl1-f195.google.com with SMTP id b3so6711015plr.7
        for <linux-kernel@vger.kernel.org>; Mon, 22 Apr 2019 19:36:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=tb9GtvfiuyPoAzgJ59A7PgJjsI8k18M+HPWTTzVRLjI=;
        b=X5xHH4TxYjdGPhn4FWhBAk4VpBfQ1bv2ZlXfWG9tywKFXuUKQFgsa1FCser7j01cd+
         VD4obJNWW4/4FLU30KaGKoeTZPVd65jtVhoVhiUahtVxTw+SHwlXDeCdhYYlFLkroLXO
         isNHTNJARDMCPyLpZfw72uW1nWYhb5j3y3YGhM5T6dz583GZIxMIgBusXo+xOv6G//wu
         WgKLS0wp5/bJJFJNPvRU7qnZQrUm6eTDQ72PTWInh3lIuPW+TVbfnVXh9n2MWeymDeSy
         aNG5QZ2ISoqzxe7wEbDEJwilmk/lMGhef0oy7Qy9sy/9X79PtQOGgw4L5pJw5l3TkVFE
         eQHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=tb9GtvfiuyPoAzgJ59A7PgJjsI8k18M+HPWTTzVRLjI=;
        b=JZcVMlGjJbdD86Lrexofw7vBwfk5v016ziXEvVHo3q4FXBadojgFPdTo6NZXdGjHV+
         w/YzKkHw9zyjRtHl0hyIrZ+dW/PzTg5czbwl3Fxg4FYSIDEVZbnmo/dOjDfbGGlr0Oku
         W7/laGYYQQw+5V9m8P17kzDrF2y9A+mmrD1uME3zqjqjVPfMeTt8LleWS5SW1oxX5rYI
         YZyp4KaCKwXSYJNUUVmxEeW7fmN3C7KfUnHY5y+sc49IDyTXX0+GhiZncylyGgC1W9OF
         GoT9wBHp+4RgGTnc55CeaKTT+Zx0zqxVMgqBs36EE61g03rjwKYlH0QVpTiWOQCovgIh
         6sow==
X-Gm-Message-State: APjAAAUmEfEprv2A9Mv5LhJ9th3T8QNlrEGAbO9qvUTMYscpBaG4RFgq
        Z6fgF9AQ2JvMl0glDTQXQcWrB3v92/k=
X-Google-Smtp-Source: APXvYqxEEdR77/fPg+KRcnWW4KkxJEiMG7ESSDZlscw0UukZNxG0oYasNlQ2EpOXzvgnO4+KWEzhbQ==
X-Received: by 2002:a17:902:e183:: with SMTP id cd3mr23742430plb.233.1555986981333;
        Mon, 22 Apr 2019 19:36:21 -0700 (PDT)
Received: from hfq-skylake.ipads-lab.se.sjtu.edu.cn ([202.120.40.82])
        by smtp.googlemail.com with ESMTPSA id d11sm16030511pgq.6.2019.04.22.19.36.18
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 22 Apr 2019 19:36:20 -0700 (PDT)
From:   Fuqian Huang <huangfq.daxian@gmail.com>
Cc:     Fuqian Huang <huangfq.daxian@gmail.com>,
        Eric Anholt <eric@anholt.net>,
        Stefan Wahren <stefan.wahren@i2se.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-rpi-kernel@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] staging: vchiq_arm: Fix misuse of %x
Date:   Tue, 23 Apr 2019 10:36:04 +0800
Message-Id: <20190423023604.13093-1-huangfq.daxian@gmail.com>
X-Mailer: git-send-email 2.11.0
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Pointers should be printed with %p or %px rather than
cast to unsigned long type and printed with %lx.
Change %lx to %pK to print the pointers.

Signed-off-by: Fuqian Huang <huangfq.daxian@gmail.com>
---
 drivers/staging/vc04_services/interface/vchiq_arm/vchiq_arm.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_arm.c b/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_arm.c
index 064d0db..c2c9fae 100644
--- a/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_arm.c
+++ b/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_arm.c
@@ -1486,16 +1486,16 @@ vchiq_ioctl(struct file *file, unsigned int cmd, unsigned long arg)
 	if ((status == VCHIQ_SUCCESS) && (ret < 0) && (ret != -EINTR) &&
 		(ret != -EWOULDBLOCK))
 		vchiq_log_info(vchiq_arm_log_level,
-			"  ioctl instance %lx, cmd %s -> status %d, %ld",
-			(unsigned long)instance,
+			"  ioctl instance %pK, cmd %s -> status %d, %ld",
+			instance,
 			(_IOC_NR(cmd) <= VCHIQ_IOC_MAX) ?
 				ioctl_names[_IOC_NR(cmd)] :
 				"<invalid>",
 			status, ret);
 	else
 		vchiq_log_trace(vchiq_arm_log_level,
-			"  ioctl instance %lx, cmd %s -> status %d, %ld",
-			(unsigned long)instance,
+			"  ioctl instance %pK, cmd %s -> status %d, %ld",
+			instance,
 			(_IOC_NR(cmd) <= VCHIQ_IOC_MAX) ?
 				ioctl_names[_IOC_NR(cmd)] :
 				"<invalid>",
-- 
2.11.0

