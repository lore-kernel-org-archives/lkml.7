Return-Path: <SRS0=CMjL=VD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 836CDC48BD3
	for <linux-kernel@archiver.kernel.org>; Sat,  6 Jul 2019 15:07:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5B98A20828
	for <linux-kernel@archiver.kernel.org>; Sat,  6 Jul 2019 15:07:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ezTkUV/E"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726920AbfGFPHz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 6 Jul 2019 11:07:55 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:40177 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726526AbfGFPHz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 6 Jul 2019 11:07:55 -0400
Received: by mail-wr1-f67.google.com with SMTP id r1so6310078wrl.7;
        Sat, 06 Jul 2019 08:07:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=tE4puqQe9l5hi2kIxH8qoaAWvN8GSQBOzxrdLq5HQzk=;
        b=ezTkUV/E0+T8fEImE2ehAsd6CleldbKYG5rblHKEw+EjEyKJJQOMRfedt6/OE1W0u8
         aVIG+iQkSkaRzm2juFbdeVO1uIVczDBZWuVnfIdzvMZc+GY7R8nR4OTW50xyI43LG0yS
         RqLp9KbYd6Lcbx8qCPEMQLQidkB8bZ1VFmHGPBROjIOdFbtmmi5RNx4mx8od9+raiP8Z
         104H0LwrvkraImbIzxXWktr1ZzuDa4mgS+0fBOnkj17v6zb5pUZsb5V5esvPq2B5rzAS
         j8+5qQNgv5IqAA94LyKwOlPDF+eAMNRx5bMdjrvOnjpEwZPYMEXUPZbRHtD7zxt7Vo/T
         Ag3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=tE4puqQe9l5hi2kIxH8qoaAWvN8GSQBOzxrdLq5HQzk=;
        b=N+h6+vpD1cYaXAWazOYE5SRJv5E6gPiF/fwK8tC2MTxQIHNdBP+YjSjRb5sKrzXiD2
         TYTHyQBjAiZ7ZiNcqNsqIaOzzhZNZKDS6BrPzZpaNPAVqTeUFrI4p9vtZu7e2YQFtI4y
         63lXTWYYJISnszvaNWf5We/XFLMp2BTfpIRZFe7UU0ES/E6J2VRCfjAeKlrfPpMDXyn0
         Wa5nUbsNd3tW7XKoS3pwdnPnT09xVYsIlMFvMAZtlv5d0ZdOC9D9FSA0oqo+Ef7nuwVl
         T4iw6q9YqmGiJpMmVL/82Q9RWnhc4otsG0WypJvPuGeWrbYQ6wj+yVNMPIWkZIoQ1X73
         vyAQ==
X-Gm-Message-State: APjAAAUU9bMZoVEC2nvta3xvbVl9l3RmLXQyGX37j+njdFfnfQcx/MK0
        RUUFE6LSBXhLqBFr3L2CfQ0=
X-Google-Smtp-Source: APXvYqzM/jyg39HKHcy3ojFrcslNwerHo0IJXsAdA7NX6hRYnRxx+h0GDJFGKtrnSUNmCSmIbUvxhw==
X-Received: by 2002:adf:f591:: with SMTP id f17mr9687738wro.119.1562425672512;
        Sat, 06 Jul 2019 08:07:52 -0700 (PDT)
Received: from localhost.localdomain (bzq-79-183-250-21.red.bezeqint.net. [79.183.250.21])
        by smtp.gmail.com with ESMTPSA id y10sm8464830wmj.2.2019.07.06.08.07.51
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Sat, 06 Jul 2019 08:07:51 -0700 (PDT)
From:   Carmeli Tamir <carmeli.tamir@gmail.com>
To:     serge@hallyn.com, jmorris@namei.org,
        linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Carmeli Tamir <carmeli.tamir@gmail.com>
Subject: [PATCH] security/commoncap: Use xattr security prefix len
Date:   Sat,  6 Jul 2019 11:07:38 -0400
Message-Id: <20190706150738.4619-1-carmeli.tamir@gmail.com>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Using the existing defined XATTR_SECURITY_PREFIX_LEN instead of
sizeof(XATTR_SECURITY_PREFIX) - 1. Pretty simple cleanup.

Signed-off-by: Carmeli Tamir <carmeli.tamir@gmail.com>
---
 security/commoncap.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/security/commoncap.c b/security/commoncap.c
index c0b9664ee49e..99d1fcae22fd 100644
--- a/security/commoncap.c
+++ b/security/commoncap.c
@@ -915,7 +915,7 @@ int cap_inode_setxattr(struct dentry *dentry, const char *name,
 
 	/* Ignore non-security xattrs */
 	if (strncmp(name, XATTR_SECURITY_PREFIX,
-			sizeof(XATTR_SECURITY_PREFIX) - 1) != 0)
+			XATTR_SECURITY_PREFIX_LEN) != 0)
 		return 0;
 
 	/*
@@ -947,7 +947,7 @@ int cap_inode_removexattr(struct dentry *dentry, const char *name)
 
 	/* Ignore non-security xattrs */
 	if (strncmp(name, XATTR_SECURITY_PREFIX,
-			sizeof(XATTR_SECURITY_PREFIX) - 1) != 0)
+			XATTR_SECURITY_PREFIX_LEN) != 0)
 		return 0;
 
 	if (strcmp(name, XATTR_NAME_CAPS) == 0) {
-- 
2.21.0

