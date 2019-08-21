Return-Path: <SRS0=xaRW=WR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3BABAC3A59E
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Aug 2019 00:18:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 02C4B22DD3
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Aug 2019 00:18:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MH13mfy/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726617AbfHUASx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 20 Aug 2019 20:18:53 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:45900 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726372AbfHUASv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Aug 2019 20:18:51 -0400
Received: by mail-pg1-f196.google.com with SMTP id o13so226231pgp.12
        for <linux-kernel@vger.kernel.org>; Tue, 20 Aug 2019 17:18:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=c3LQHcY3+YvhpAJ3SOOoCNwpGf42ZIdm9oft5Rg6R8E=;
        b=MH13mfy/rC2MWrFrghbk3ERrfOJ7Acc2V5PTmjiUJ2UNkoWSzaaCcQ+L1XS6wjV1NZ
         fnz/Qw3+jI0mJo5ZTwDo2D43ey6zMwlKjjFfvwWh95XuqfRYmFrLLfMos7MItV2S8S4r
         znUOap6+GdVm2fAzNACWW30Jy8d/tsw+kmVMyv6/B25kbodcxkaJo2wRykahpVFG8GUV
         dgOV2Ww4hpl5Ll8M+MI+YDNaYItpk3EPoFrpBOsm7F/Rsj+1E8WEStN6Mu2h0GQ82wrl
         9VzRMbOjLagbaCiurxsYGBiJDRP4OQ9MOCrslguAFBz+LQ5B8KmQZW2F1xZJapyuE3iy
         MMSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=c3LQHcY3+YvhpAJ3SOOoCNwpGf42ZIdm9oft5Rg6R8E=;
        b=OGEJJjQOPp/ktsGcp6fZGUKB95ZfOzuLA1GITXq18JG/iowOgzQO3YqfWoiGdEso7I
         GYMWJc8IKZl7Izu+46kbhWo8hj2r2s4ae++bAsidjV8QSiAfFxbSZJfstSgjNNdt77KT
         LYjD+KNpAbrGwGBpJw83qhbfuMTXnVNqJCurFmqqfH2XQgxkYVdP4IBoiD0VlDk5C7MU
         o34d0g4Qt0OWeEt8+WvXR6fZZn4uiemIf8qiuVmY9K24T2Ki71E2felDwnTBuEXAscXr
         zaajH4qjenr/v3qk+kDDaqQ/RRlMpAKDPB3nHc/v7mFoRZWqlRellzgrOBAUZmK6xwpA
         MDxA==
X-Gm-Message-State: APjAAAXWJbYguorQcOAKwXbQWw7QhPBrnPBzSZfhQ2eYXPQmgiFSJlIW
        kmvoYWRMlh8NsBbr5sCGbLI=
X-Google-Smtp-Source: APXvYqwwan2OY/ZV7PXfeMhMGdEvRd4vEiJuNjIlg98ZfD/In7j14ai4ajqEPw9W14GV2GUgiaRNmg==
X-Received: by 2002:a17:90a:9202:: with SMTP id m2mr2663705pjo.16.1566346730545;
        Tue, 20 Aug 2019 17:18:50 -0700 (PDT)
Received: from localhost.localdomain (wsip-184-188-36-2.sd.sd.cox.net. [184.188.36.2])
        by smtp.googlemail.com with ESMTPSA id g2sm18806323pfm.32.2019.08.20.17.18.49
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 20 Aug 2019 17:18:50 -0700 (PDT)
From:   Caitlyn <caitlynannefinn@gmail.com>
To:     Gao Xiang <gaoxiang25@huawei.com>, Chao Yu <yuchao0@huawei.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Caitlyn <caitlynannefinn@gmail.com>,
        "Tobin C . Harding" <me@tobin.cc>, linux-erofs@lists.ozlabs.org,
        devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org
Subject: [PATCH 1/2] staging/erofs/xattr.h: Fixed misaligned function arguments.
Date:   Tue, 20 Aug 2019 20:18:19 -0400
Message-Id: <1566346700-28536-2-git-send-email-caitlynannefinn@gmail.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1566346700-28536-1-git-send-email-caitlynannefinn@gmail.com>
References: <1566346700-28536-1-git-send-email-caitlynannefinn@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Indented some function arguments to fix checkpath warnings.

Signed-off-by: Caitlyn <caitlynannefinn@gmail.com>
---
 drivers/staging/erofs/xattr.h | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/staging/erofs/xattr.h b/drivers/staging/erofs/xattr.h
index 35ba5ac..d86f5cd 100644
--- a/drivers/staging/erofs/xattr.h
+++ b/drivers/staging/erofs/xattr.h
@@ -74,14 +74,14 @@ int erofs_getxattr(struct inode *, int, const char *, void *, size_t);
 ssize_t erofs_listxattr(struct dentry *, char *, size_t);
 #else
 static int __maybe_unused erofs_getxattr(struct inode *inode, int index,
-	const char *name,
-	void *buffer, size_t buffer_size)
+					 const char *name, void *buffer,
+					 size_t buffer_size)
 {
 	return -ENOTSUPP;
 }
 
 static ssize_t __maybe_unused erofs_listxattr(struct dentry *dentry,
-	char *buffer, size_t buffer_size)
+					      char *buffer, size_t buffer_size)
 {
 	return -ENOTSUPP;
 }
-- 
2.7.4

