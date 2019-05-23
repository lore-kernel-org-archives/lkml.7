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
	by smtp.lore.kernel.org (Postfix) with ESMTP id D33E2C282DD
	for <linux-kernel@archiver.kernel.org>; Thu, 23 May 2019 13:23:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A14EF20862
	for <linux-kernel@archiver.kernel.org>; Thu, 23 May 2019 13:23:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UhXIhYmR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730698AbfEWNXt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 May 2019 09:23:49 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:45051 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726310AbfEWNXt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 May 2019 09:23:49 -0400
Received: by mail-pg1-f196.google.com with SMTP id n2so3131708pgp.11
        for <linux-kernel@vger.kernel.org>; Thu, 23 May 2019 06:23:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=IXUSqhWKpNXueUwu9xgWPW4SvpSlIVLK8VFFvoIyjkg=;
        b=UhXIhYmRzGdKbWHnMSc3BMSk3wEnttvhYKdLEMp20gS9zTefkW2BOKc5AnyTN+6WhN
         /96S+JyibDLOQfU1wEgDdPzWZMSRl9vqUuMFPgBBfOsFLktykrnSx9Nyd8Fi8n1DmbDY
         QIHKbSzRG1rPVOT4GwHR3u7bLZ3x4XWVUf0oh7KFGouuJ1hASRk+F+iAG4Bt5oZlPMua
         H/YwLkJOvjj4fPxYLeryTL3YN35mAppJU9tMErHPWqpwKZiyhE1FC6OkNDeibT5e3Fc3
         kOjB6wCq5FL+GUyZLwNdXoulYKLpqHPJkSSIBpWpFAi3dThhudXCC5mZtChFdHuKd5C+
         A3RA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=IXUSqhWKpNXueUwu9xgWPW4SvpSlIVLK8VFFvoIyjkg=;
        b=dzLJC5aePE7LxpJHUciF3ZzJ+OOqalC5RIKYmZ0mgIVms2vOabQXWcTHgefbFbq+Eg
         CEoI9umWlKnK8CsfwDTak1ly9CHbVOqm6mHWIw1zmT3UElSScBO4eK6viKVjl/ohI3Ru
         5/Yl34jLTVi4k0sIIvs/PFOn8mbi/kU8QQt/Ke99qbUszcHv6iHQBITd98D7Kj3vQQNd
         RbsBOLrz9nrLPur40NnVp09h1oZlhFSXaqOUgJZ9qBam55zxWLHtcWYd8PD2PKP/mBSM
         lRdrnOmB8Wn2QRJIh4jzBdXnJ03+7eQHp/9kUVFF0ERNPTOJaba9hGc/Im7lrMq9WxWf
         2x0A==
X-Gm-Message-State: APjAAAUNhGpW2lPKInQ3SI6U2kbnVoJQucqsh/src4TMUAhWYpGnqQFR
        6iMJijUq31nhZSzDIwLrNgg=
X-Google-Smtp-Source: APXvYqx9C3Z3FscObDjTgasbmhEhfuOgrL73/haGCZs2W8h1x4CwhgY5Fv3LpoV30r4DzQpH730vgA==
X-Received: by 2002:a62:2b94:: with SMTP id r142mr13112527pfr.184.1558617828679;
        Thu, 23 May 2019 06:23:48 -0700 (PDT)
Received: from localhost.localdomain ([122.163.94.48])
        by smtp.gmail.com with ESMTPSA id f36sm35845239pgb.76.2019.05.23.06.23.46
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 23 May 2019 06:23:48 -0700 (PDT)
From:   Nishka Dasgupta <nishkadg.linux@gmail.com>
To:     gregkh@linuxfoundation.org, christian.gromm@microchip.com,
        devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org
Cc:     Nishka Dasgupta <nishkadg.linux@gmail.com>
Subject: [PATCH] staging: most: usb: Remove variable frame_size
Date:   Thu, 23 May 2019 18:53:34 +0530
Message-Id: <20190523132334.29611-1-nishkadg.linux@gmail.com>
X-Mailer: git-send-email 2.19.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove variable frame_size as its multiple usages are all independent of
each other and so can be returned separately.
Issue found with Coccinelle.

Signed-off-by: Nishka Dasgupta <nishkadg.linux@gmail.com>
---
 drivers/staging/most/usb/usb.c | 16 ++++++----------
 1 file changed, 6 insertions(+), 10 deletions(-)

diff --git a/drivers/staging/most/usb/usb.c b/drivers/staging/most/usb/usb.c
index 360cb5b7a10b..751e82cf66c5 100644
--- a/drivers/staging/most/usb/usb.c
+++ b/drivers/staging/most/usb/usb.c
@@ -186,32 +186,28 @@ static inline int start_sync_ep(struct usb_device *usb_dev, u16 ep)
  */
 static unsigned int get_stream_frame_size(struct most_channel_config *cfg)
 {
-	unsigned int frame_size = 0;
 	unsigned int sub_size = cfg->subbuffer_size;
 
 	if (!sub_size) {
 		pr_warn("Misconfig: Subbuffer size zero.\n");
-		return frame_size;
+		return 0;
 	}
 	switch (cfg->data_type) {
 	case MOST_CH_ISOC:
-		frame_size = AV_PACKETS_PER_XACT * sub_size;
-		break;
+		return AV_PACKETS_PER_XACT * sub_size;
 	case MOST_CH_SYNC:
 		if (cfg->packets_per_xact == 0) {
 			pr_warn("Misconfig: Packets per XACT zero\n");
-			frame_size = 0;
+			return 0;
 		} else if (cfg->packets_per_xact == 0xFF) {
-			frame_size = (USB_MTU / sub_size) * sub_size;
+			return (USB_MTU / sub_size) * sub_size;
 		} else {
-			frame_size = cfg->packets_per_xact * sub_size;
+			return cfg->packets_per_xact * sub_size;
 		}
-		break;
 	default:
 		pr_warn("Query frame size of non-streaming channel\n");
-		break;
+		return 0;
 	}
-	return frame_size;
 }
 
 /**
-- 
2.19.1

