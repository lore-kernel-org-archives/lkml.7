Return-Path: <SRS0=oHH8=SG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8B3BC10F0C
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Apr 2019 09:31:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7A438205F4
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Apr 2019 09:31:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1554370303;
	bh=LhOHW4mCyl2nmaBN0ZS+FKNTjFjxewPlG8t8dfWyp68=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=KbdYovVYl5/QqCHszGiJhY/WyRJcbw5YKojMY2UHqZrXcCyIBLvxJIYNpnwF5SqMB
	 1OVofNiuH0djFneTocvruIGCkoD+awHkHDsJ4jAvT2rYvhgA7JetxyP7YJDqEct0L4
	 6Eg1khUq92/mRUyzRD13LKYzzeOkqyZ0plOqGjaY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732799AbfDDJJS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Apr 2019 05:09:18 -0400
Received: from mail.kernel.org ([198.145.29.99]:48350 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731894AbfDDJJM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Apr 2019 05:09:12 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1E8622075E;
        Thu,  4 Apr 2019 09:09:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1554368951;
        bh=LhOHW4mCyl2nmaBN0ZS+FKNTjFjxewPlG8t8dfWyp68=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Qda5zGXge91TtmkkW2jgoiCWtbmQhIKaNyFj0vJDvQCx5Xrsjt6XeJKPTwQZByF9k
         Jx/pV/U7DYpj96FhWH31cHmGkhijwdECzgvXE7mM2K/5nG19xk/rYCUN12iJ4MxhJ0
         BVX2aLcJLLKsqknf08pTIQh+RgJWVONiD2z9SvQU=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Louis Taylor <louis@kragniz.eu>,
        Steve French <stfrench@microsoft.com>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.0 042/246] cifs: use correct format characters
Date:   Thu,  4 Apr 2019 10:45:42 +0200
Message-Id: <20190404084620.507441471@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190404084619.236418459@linuxfoundation.org>
References: <20190404084619.236418459@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

5.0-stable review patch.  If anyone has any objections, please let me know.

------------------

[ Upstream commit 259594bea574e515a148171b5cd84ce5cbdc028a ]

When compiling with -Wformat, clang emits the following warnings:

fs/cifs/smb1ops.c:312:20: warning: format specifies type 'unsigned
short' but the argument has type 'unsigned int' [-Wformat]
                         tgt_total_cnt, total_in_tgt);
                                        ^~~~~~~~~~~~

fs/cifs/cifs_dfs_ref.c:289:4: warning: format specifies type 'short'
but the argument has type 'int' [-Wformat]
                 ref->flags, ref->server_type);
                 ^~~~~~~~~~

fs/cifs/cifs_dfs_ref.c:289:16: warning: format specifies type 'short'
but the argument has type 'int' [-Wformat]
                 ref->flags, ref->server_type);
                             ^~~~~~~~~~~~~~~~

fs/cifs/cifs_dfs_ref.c:291:4: warning: format specifies type 'short'
but the argument has type 'int' [-Wformat]
                 ref->ref_flag, ref->path_consumed);
                 ^~~~~~~~~~~~~

fs/cifs/cifs_dfs_ref.c:291:19: warning: format specifies type 'short'
but the argument has type 'int' [-Wformat]
                 ref->ref_flag, ref->path_consumed);
                                ^~~~~~~~~~~~~~~~~~
The types of these arguments are unconditionally defined, so this patch
updates the format character to the correct ones for ints and unsigned
ints.

Link: https://github.com/ClangBuiltLinux/linux/issues/378

Signed-off-by: Louis Taylor <louis@kragniz.eu>
Signed-off-by: Steve French <stfrench@microsoft.com>
Reviewed-by: Nick Desaulniers <ndesaulniers@google.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/cifs/cifs_dfs_ref.c | 4 ++--
 fs/cifs/smb1ops.c      | 2 +-
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/fs/cifs/cifs_dfs_ref.c b/fs/cifs/cifs_dfs_ref.c
index d9b99abe1243..5d83c924cc47 100644
--- a/fs/cifs/cifs_dfs_ref.c
+++ b/fs/cifs/cifs_dfs_ref.c
@@ -285,9 +285,9 @@ static void dump_referral(const struct dfs_info3_param *ref)
 {
 	cifs_dbg(FYI, "DFS: ref path: %s\n", ref->path_name);
 	cifs_dbg(FYI, "DFS: node path: %s\n", ref->node_name);
-	cifs_dbg(FYI, "DFS: fl: %hd, srv_type: %hd\n",
+	cifs_dbg(FYI, "DFS: fl: %d, srv_type: %d\n",
 		 ref->flags, ref->server_type);
-	cifs_dbg(FYI, "DFS: ref_flags: %hd, path_consumed: %hd\n",
+	cifs_dbg(FYI, "DFS: ref_flags: %d, path_consumed: %d\n",
 		 ref->ref_flag, ref->path_consumed);
 }
 
diff --git a/fs/cifs/smb1ops.c b/fs/cifs/smb1ops.c
index 32a6c020478f..20a88776f04d 100644
--- a/fs/cifs/smb1ops.c
+++ b/fs/cifs/smb1ops.c
@@ -308,7 +308,7 @@ coalesce_t2(char *second_buf, struct smb_hdr *target_hdr)
 	remaining = tgt_total_cnt - total_in_tgt;
 
 	if (remaining < 0) {
-		cifs_dbg(FYI, "Server sent too much data. tgt_total_cnt=%hu total_in_tgt=%hu\n",
+		cifs_dbg(FYI, "Server sent too much data. tgt_total_cnt=%hu total_in_tgt=%u\n",
 			 tgt_total_cnt, total_in_tgt);
 		return -EPROTO;
 	}
-- 
2.19.1



