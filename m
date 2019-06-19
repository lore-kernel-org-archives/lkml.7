Return-Path: <SRS0=wAGj=US=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D10C8C31E49
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Jun 2019 12:30:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B17C4208CB
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Jun 2019 12:30:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731843AbfFSMae (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Jun 2019 08:30:34 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:40643 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731796AbfFSMac (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Jun 2019 08:30:32 -0400
Received: by mail-wr1-f65.google.com with SMTP id p11so3190625wre.7
        for <linux-kernel@vger.kernel.org>; Wed, 19 Jun 2019 05:30:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Vz+znNR3F5kjJHoZn9Crk81ccCGx1/tiF7Xfm+PRQVc=;
        b=YUCyJcwJLjyLBoTlhJmXoewkQUwDifCfIzkLZGhGNSWa2FV8cIJgpFSmWo5m9DEbix
         q8u74/XwmE9OxyH86Bc1/qU9EcE6CVwEcqtqoVFkOuKU4X7sOcELktQXvaFXQXpfEloD
         mBuWlu/nYtQEmG2N0dEW3kiTFz2tDPRMNGz1DBjtBND/YJjm+mrerf7K/ZfOMcOVabhJ
         GtO+dTCUtT0VBvv3Oe2iQ1xLcy7bhx2SPolAHTCdFTxtje8Rz8MsnYe2GU6GpJXCZDor
         2BWL1UkeGRVXzNTEzt2I4KiM334GNt9NFjRaAwjGXYU3NaidgPQFvulFxdznSUz/BsEr
         8svw==
X-Gm-Message-State: APjAAAUd+9fxPRQYT3VIcewcG7Rw9bKNmQUCaxR2H+tBGXMeLJmyzFHL
        nTLNQLuD5DBMFs1ee4IOGnY9oQ==
X-Google-Smtp-Source: APXvYqwz5ogA7h2G+mp6k4mHrwtXmsKu8SbTaB/WQVZOvIU+slS295oTNMYD8Kyv4OO88vNv8l44ig==
X-Received: by 2002:a5d:6549:: with SMTP id z9mr22487471wrv.63.1560947430518;
        Wed, 19 Jun 2019 05:30:30 -0700 (PDT)
Received: from miu.piliscsaba.redhat.com (catv-212-96-48-140.catv.broadband.hu. [212.96.48.140])
        by smtp.gmail.com with ESMTPSA id 11sm1837513wmd.23.2019.06.19.05.30.29
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Wed, 19 Jun 2019 05:30:29 -0700 (PDT)
From:   Miklos Szeredi <mszeredi@redhat.com>
To:     David Howells <dhowells@redhat.com>
Cc:     Al Viro <viro@zeniv.linux.org.uk>, Ian Kent <raven@themaw.net>,
        linux-api@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 04/13] vfs: don't parse "posixacl" option
Date:   Wed, 19 Jun 2019 14:30:10 +0200
Message-Id: <20190619123019.30032-4-mszeredi@redhat.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190619123019.30032-1-mszeredi@redhat.com>
References: <20190619123019.30032-1-mszeredi@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Unlike the others, this is _not_ a standard option accepted by mount(8).

In fact SB_POSIXACL is an internal flag, and accepting MS_POSIXACL on the
mount(2) interface is possibly a bug.

The only filesystem that apparently wants to handle the "posixacl" option
is 9p, but it has special handling of that option besides setting
SB_POSIXACL.

Signed-off-by: Miklos Szeredi <mszeredi@redhat.com>
---
 fs/fs_context.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/fs/fs_context.c b/fs/fs_context.c
index cbf89117a507..49636e541293 100644
--- a/fs/fs_context.c
+++ b/fs/fs_context.c
@@ -42,7 +42,6 @@ static const struct constant_table common_set_sb_flag[] = {
 	{ "dirsync",	SB_DIRSYNC },
 	{ "lazytime",	SB_LAZYTIME },
 	{ "mand",	SB_MANDLOCK },
-	{ "posixacl",	SB_POSIXACL },
 	{ "ro",		SB_RDONLY },
 	{ "sync",	SB_SYNCHRONOUS },
 };
-- 
2.21.0

