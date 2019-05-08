Return-Path: <SRS0=J8hU=TI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4C064C04A6B
	for <linux-kernel@archiver.kernel.org>; Wed,  8 May 2019 15:25:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1F7D220989
	for <linux-kernel@archiver.kernel.org>; Wed,  8 May 2019 15:25:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=brauner.io header.i=@brauner.io header.b="NgO1Mq5A"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728239AbfEHPZa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 May 2019 11:25:30 -0400
Received: from mail-ed1-f68.google.com ([209.85.208.68]:39638 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726830AbfEHPZ2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 May 2019 11:25:28 -0400
Received: by mail-ed1-f68.google.com with SMTP id e24so22445935edq.6
        for <linux-kernel@vger.kernel.org>; Wed, 08 May 2019 08:25:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brauner.io; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=tDcf7GIagYCWBHmHNqLEzcfvnj4u6JLSwHcVNqGzP2g=;
        b=NgO1Mq5Aw4c5KYGT1vvsJ0bpYv/oA8QAi2Odl80dddVs4dhdRMs65+phDKlJ5CNWhP
         LPb+RO84dd3fsU7V6DT46aZmXeETwR54Qt+98xlMYs3sRsZMrGVi7cd/rRVBEl+ogWVI
         H3xOPtuv1E5aiu50h4yqiidxkjajl2sm/rHi8265xqcM2RCLcl1T6e5XGzLdY4vmnm0w
         dkhLTWe1prXg68KIdxTrltjtf03YA2cKJvkXfSv7u6OuhPXP5PJilip7arY7G+wLWx/y
         uwKED0OOJRStKJTPNkLqhcT9BEHZoLVKzTotbi6UQwXKo7QzpsPPBrs5T4DUlmRmKxt8
         mqNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=tDcf7GIagYCWBHmHNqLEzcfvnj4u6JLSwHcVNqGzP2g=;
        b=BMalsTxOGcC9vav5O4CDGWxa1qc0oBHh0szfJYGYsOufZaLpHm3btXwNYUxrWJDtdO
         4aYTOPX7OKLgESK0wyD8wRz63A+YEnrnqn7/cu0n/dLeKQdTf1Fq38LALnmIJfOMvG2b
         muT85JwVbSyOmFPy2n0E3kHxDk3OAq9Ave9OJ3aJt9uJPYc5NFgq4xZ5wzr8DwIUqi9A
         PLF7JCx/Xnjt9mF67RiFQ81yMdDhIbFEvuheykYYN045Fh8tH1Q1n6hevOx5v/8iZ6pk
         G1QlFlZfZ4jFcFM/WpnY5M0J43EzlS8V/nn0LacMAmmEgzAvYBDXAvW43BOhauMVcZ/8
         X/AA==
X-Gm-Message-State: APjAAAWjMGC6A+ItXk32SX6vywfxmpZV8dhBTHM8P2OwX89Wh7voItaO
        9xH5djkC5W7/+i6Jhv2O/8LwWw==
X-Google-Smtp-Source: APXvYqwKPkI7tu2GUuyIovy++9CAH7985KLaTuMuUPsXMVXrSPJtFkUBQguQDSqNmRYJDgjkNPPwkQ==
X-Received: by 2002:a17:906:eb97:: with SMTP id mh23mr28086886ejb.69.1557329126318;
        Wed, 08 May 2019 08:25:26 -0700 (PDT)
Received: from localhost.localdomain ([212.91.227.56])
        by smtp.gmail.com with ESMTPSA id r55sm5260252edd.94.2019.05.08.08.25.25
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 08 May 2019 08:25:25 -0700 (PDT)
From:   Christian Brauner <christian@brauner.io>
To:     viro@zeniv.linux.org.uk, dhowells@redhat.com,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Christian Brauner <christian@brauner.io>
Subject: [PATCH v1 2/2] fsopen: use square brackets around "fscontext"
Date:   Wed,  8 May 2019 17:25:09 +0200
Message-Id: <20190508152509.13336-2-christian@brauner.io>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190508152509.13336-1-christian@brauner.io>
References: <20190508152509.13336-1-christian@brauner.io>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Make the name of the anon inode fd "[fscontext]" instead of "fscontext".
This is minor but most core-kernel anon inode fds carry square brackets
around their name (cf. [1]). For the sake of consistency lets do the same
for the mount api:

[eventfd]
[eventpoll]
[fanotify]
[fscontext]
[io_uring]
[pidfd]
[signalfd]
[timerfd]
[userfaultfd]

Signed-off-by: Christian Brauner <christian@brauner.io>
---
 fs/fsopen.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/fsopen.c b/fs/fsopen.c
index a38fa8c616cf..83d0d2001bb2 100644
--- a/fs/fsopen.c
+++ b/fs/fsopen.c
@@ -92,7 +92,7 @@ static int fscontext_create_fd(struct fs_context *fc)
 {
 	int fd;
 
-	fd = anon_inode_getfd("fscontext", &fscontext_fops, fc,
+	fd = anon_inode_getfd("[fscontext]", &fscontext_fops, fc,
 			      O_RDWR | O_CLOEXEC);
 	if (fd < 0)
 		put_fs_context(fc);
-- 
2.21.0

