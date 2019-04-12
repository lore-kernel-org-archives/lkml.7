Return-Path: <SRS0=nVcb=SO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 36F18C10F13
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Apr 2019 02:46:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EE57220869
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Apr 2019 02:46:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UfSc9nzn"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726814AbfDLCqG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Apr 2019 22:46:06 -0400
Received: from mail-qt1-f196.google.com ([209.85.160.196]:44105 "EHLO
        mail-qt1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726678AbfDLCqF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Apr 2019 22:46:05 -0400
Received: by mail-qt1-f196.google.com with SMTP id w5so9568448qtb.11;
        Thu, 11 Apr 2019 19:46:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=4ouqN4hB8wNOcj2j7hCZ0vfUSkJoDTUdIas5URzavms=;
        b=UfSc9nznKQpx9/N+LNXB5bT0p7s3bNSsCYoH2lPZ1r8yy/FfW1gu7f+mV1P+pDP1L5
         txkNxS/ez4QxfsDMBvqDX2YYc4Kq+Qm+T0sW+H5KEUpP2KnPW8a59gVitu4B8DJaVUHN
         Id1ptPaM7O8zc7zHAGrgnpxFcoEZyM0qZ7j8tiFUq2FC1tD/ApjYPOFFE0jtJB0bjbyB
         YOEj6dSfKOM30/xd48sjMrowWGM9sIfmF7xmg3ZzeFPb4J6FYiQGjduribVA4tuF5c1K
         2gBduMZVGQtnrZ0DzSb+7XEAxtb35bFovbJqRJbzqBmCnZqLr8/0JqbamH4Ymu7wJyiW
         m+UA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=4ouqN4hB8wNOcj2j7hCZ0vfUSkJoDTUdIas5URzavms=;
        b=nwVDzOYp9QIuO+jRevILNR7CNjkIFErgAyhVQraSCaKwIAeZr/CyUc088WfvfBcIOh
         GwcRxpZaF2OyO9kCOsUpMPhVqpl9BguWHlA0VmBs0Mu/gCzS3QENK0RoH63uZHtCoTJc
         68U75OppCI4EUgN1zEtyo7SsQe60fo7Fv+ZzbvxlhC85fJEErJfHHku5QBfkLfjAerFI
         Thj1VP+WiXG0kpcEzFpTMDEDXSc5/Kgqy9Ek2pmSCFtntZE3yWZv333SfH6pqHgVy1ku
         aBeV944SfdSve+wVaNNU3i2AfUrus54gdp9TF9m+AS+XBLcwazQZWa/JQ3Y+lzL2MAKE
         xRvg==
X-Gm-Message-State: APjAAAUtpqIBaJAgRaQaxzVt7IUBlncYf7BBUbJiL0v1oOlHgb9BGqEx
        5PFzqVc1z+QKruIZMvSD228=
X-Google-Smtp-Source: APXvYqzQZaZ1CXBS/6jARv78I2G2rfOqWUIIJZ5LKkMRZob8UEcHtYx5sbqs0OTiVceIFUJruMarHw==
X-Received: by 2002:ac8:2843:: with SMTP id 3mr46620526qtr.327.1555037164388;
        Thu, 11 Apr 2019 19:46:04 -0700 (PDT)
Received: from localhost.localdomain ([177.62.178.213])
        by smtp.gmail.com with ESMTPSA id s66sm18484919qkd.90.2019.04.11.19.46.02
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 11 Apr 2019 19:46:03 -0700 (PDT)
From:   Tiago Macedo <tiagohenrique.macedo@gmail.com>
X-Google-Original-From: Tiago Macedo <tiagohenrique.macedo@gmai.com>
To:     gregkh@linuxfoundation.org
Cc:     linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        devel@driverdev.osuosl.org, lkcamp@lists.libreplanetbr.org,
        Tiago Macedo <tiagohenrique.macedo@gmai.com>
Subject: [PATCH] Fixed coding style: do not initialise statics to NULL
Date:   Thu, 11 Apr 2019 23:45:20 -0300
Message-Id: <20190412024520.26835-1-tiagohenrique.macedo@gmai.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The standard guarantees that a pointer with static storage duration
and no other initializer will be initialized to be a null pointer.

Signed-off-by: Tiago Macedo <tiagohenrique.macedo@gmai.com>
---
 drivers/staging/media/zoran/videocodec.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/staging/media/zoran/videocodec.c b/drivers/staging/media/zoran/videocodec.c
index c1ee5cb7e66b..cc6e0f1cd7b4 100644
--- a/drivers/staging/media/zoran/videocodec.c
+++ b/drivers/staging/media/zoran/videocodec.c
@@ -51,7 +51,7 @@ struct codec_list {
 	struct codec_list *next;
 };
 
-static struct codec_list *codeclist_top = NULL;
+static struct codec_list *codeclist_top;
 
 /* ================================================= */
 /* function prototypes of the master/slave interface */
-- 
2.17.1

