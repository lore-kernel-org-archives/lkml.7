Return-Path: <SRS0=HHJ+=YV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D7081CA9EC2
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Oct 2019 23:03:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A6C9B2054F
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Oct 2019 23:03:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GpL4/t56"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730828AbfJ1XDP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 28 Oct 2019 19:03:15 -0400
Received: from mail-lj1-f193.google.com ([209.85.208.193]:38535 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730303AbfJ1XDP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Oct 2019 19:03:15 -0400
Received: by mail-lj1-f193.google.com with SMTP id q78so13165406lje.5
        for <linux-kernel@vger.kernel.org>; Mon, 28 Oct 2019 16:03:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=dwuHwGwoR4Bx47u1dStEOn2gbiuU5xlnO+a2gXUuQhU=;
        b=GpL4/t56rWO7hWFthuKn2I26kfvX9LtRbOh+/BmNd9G/9e5FePSST8SeqBOKqfiyBh
         Hduzc/NCAwveu+ndfdGxs8ViTU8dS2rTDZRdXiM+yNt0pLyG4HdVgyZXm5hZgojkoAzo
         KL+I0Fk9h6qzqGeRT7aNZ3r7D3zq53wS3N5B6ZaFC0ZPhN4Hg9VGqBGRycu+2OyhJ9pM
         FxzGFDJiRVctbkvaE15YmkxZxx7oUPIAUWZAltWwsr1oMQkRx3/IZ1Lz4g7iHD5CXPRx
         W6gZSBoTHZdUaJeY1lVYj2BWlc3IZw0Rvy30ptfm/7HUFdl3oGnr9KECJhftgwFL3MqZ
         G+ww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=dwuHwGwoR4Bx47u1dStEOn2gbiuU5xlnO+a2gXUuQhU=;
        b=YM0CzgB+QlgQj1gTtwrUWmddI6HOfPJFYk35qZsevpKWcTZVq697ddq8IIUMXZsKOl
         RFD4UVJfR5zP+/3tKv9VZe/B1H0ez53j9z0pth0DRdlJjGtWrEeD4xA9QdCW1jKyzr4b
         iMbVPmkVwKY7mBogO0DXjEGFezyQC4nUwHmJcKSIzvgY1XH5OgMuUd1IqJ7DP7TvTnes
         N+7SrexY40jVHuBztmxx6P1nZT15XTDkXyUpyYYgcjR3ZFmtg1O4zdPEMKHYxmShGgey
         MkyiTGXszFJ8t0rWDKxKvyqH0iqTBKIpFyTlyWfoTNtBCt2krkfzCzT8X6D4D2cIgH0W
         FQGQ==
X-Gm-Message-State: APjAAAX0bsKae2A3qfRgQSUlBGpWM/jyQpzIwuQYhTzwg62QvESlIW83
        nnLpFItvX8hfEq0dmHenGCo=
X-Google-Smtp-Source: APXvYqxQW6bJwWWCmZYRxqdf+HANh2H/VTD8B+GAQslOBO6fF/F4G62Taaqsay18hn5c4NK21mJofw==
X-Received: by 2002:a2e:5b82:: with SMTP id m2mr183184lje.184.1572303791971;
        Mon, 28 Oct 2019 16:03:11 -0700 (PDT)
Received: from localhost.localdomain ([93.152.168.243])
        by smtp.gmail.com with ESMTPSA id v9sm5676566ljk.56.2019.10.28.16.03.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Oct 2019 16:03:11 -0700 (PDT)
From:   Samuil Ivanov <samuil.ivanovbg@gmail.com>
To:     rspringer@google.com, toddpoynor@google.com, benchan@chromium.org,
        gregkh@linuxfoundation.org
Cc:     devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org,
        Samuil Ivanov <samuil.ivanovbg@gmail.com>
Subject: [PATCH 2/2] Staging: gasket: Clean apex_get_status function of comment
Date:   Tue, 29 Oct 2019 00:59:26 +0200
Message-Id: <20191028225926.8951-3-samuil.ivanovbg@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191028225926.8951-1-samuil.ivanovbg@gmail.com>
References: <20191028225926.8951-1-samuil.ivanovbg@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

After implementing the function to check the status of the driver,
there is no longer need for this comment.

Signed-off-by: Samuil Ivanov <samuil.ivanovbg@gmail.com>
---
 drivers/staging/gasket/apex_driver.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/staging/gasket/apex_driver.c b/drivers/staging/gasket/apex_driver.c
index a5dd6f3c367d..67cdb4f5da8e 100644
--- a/drivers/staging/gasket/apex_driver.c
+++ b/drivers/staging/gasket/apex_driver.c
@@ -246,7 +246,6 @@ module_param(bypass_top_level, int, 0644);
 /* Check the device status registers and return device status ALIVE or DEAD. */
 static int apex_get_status(struct gasket_dev *gasket_dev)
 {
-	/* TODO: Check device status. */
 	if (gasket_dev->status == GASKET_STATUS_DEAD)
 		return GASKET_STATUS_DEAD;
 
-- 
2.17.1

