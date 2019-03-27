Return-Path: <SRS0=95/N=R6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A80C8C43381
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Mar 2019 23:46:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 71A8B20651
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Mar 2019 23:46:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387610AbfC0XqB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Mar 2019 19:46:01 -0400
Received: from mx1.redhat.com ([209.132.183.28]:53912 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730692AbfC0Xp7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Mar 2019 19:45:59 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id E4DA8309267B;
        Wed, 27 Mar 2019 23:45:58 +0000 (UTC)
Received: from warthog.procyon.org.uk (ovpn-121-98.rdu2.redhat.com [10.10.121.98])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 20D775D9C4;
        Wed, 27 Mar 2019 23:45:57 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
 Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
 Kingdom.
 Registered in England and Wales under Company Registration No. 3798903
Subject: [RFC PATCH 43/68] vfs: Make fs_parse() handle fs_param_is_fd-type
 params better
From:   David Howells <dhowells@redhat.com>
To:     viro@zeniv.linux.org.uk
Cc:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        dhowells@redhat.com
Date:   Wed, 27 Mar 2019 23:45:57 +0000
Message-ID: <155373035738.7602.9290664953121039047.stgit@warthog.procyon.org.uk>
In-Reply-To: <155372999953.7602.13784796495137723805.stgit@warthog.procyon.org.uk>
References: <155372999953.7602.13784796495137723805.stgit@warthog.procyon.org.uk>
User-Agent: StGit/unknown-version
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.43]); Wed, 27 Mar 2019 23:45:58 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Make fs_parse() handle fs_param_is_fd-type parameters that are passed a
string by converting it to an integer (in addition to handling direct fd
specification).

Also range check the integer.

Signed-off-by: David Howells <dhowells@redhat.com>
---

 fs/fs_parser.c |   15 +++++++++++++--
 1 file changed, 13 insertions(+), 2 deletions(-)

diff --git a/fs/fs_parser.c b/fs/fs_parser.c
index be86703ec371..bd59e1725c50 100644
--- a/fs/fs_parser.c
+++ b/fs/fs_parser.c
@@ -208,9 +208,20 @@ int fs_parse(struct fs_context *fc,
 		goto okay;
 
 	case fs_param_is_fd: {
-		if (param->type != fs_value_is_file)
+		switch (param->type) {
+		case fs_value_is_string:
+			ret = kstrtouint(param->string, 0, &result->uint_32);
+			break;
+		case fs_value_is_file:
+			result->uint_32 = param->dirfd;
+			ret = 0;
+		default:
 			goto bad_value;
-		goto okay;
+		}
+
+		if (result->uint_32 > INT_MAX)
+			goto bad_value;
+		goto maybe_okay;
 	}
 
 	case fs_param_is_blockdev:

