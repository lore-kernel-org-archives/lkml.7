Return-Path: <SRS0=B1dt=RW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 95ABDC43381
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Mar 2019 16:23:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 59E0F2077B
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Mar 2019 16:23:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727803AbfCSQXl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Mar 2019 12:23:41 -0400
Received: from mx1.redhat.com ([209.132.183.28]:52898 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727488AbfCSQXk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Mar 2019 12:23:40 -0400
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 827FE821E2;
        Tue, 19 Mar 2019 16:23:40 +0000 (UTC)
Received: from warthog.procyon.org.uk (ovpn-120-47.rdu2.redhat.com [10.10.120.47])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 68D57100194A;
        Tue, 19 Mar 2019 16:23:39 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
 Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
 Kingdom.
 Registered in England and Wales under Company Registration No. 3798903
Subject: [RFC PATCH 2/4] vfs: Make fs_parse() handle fs_param_is_fd-type
 params better
From:   David Howells <dhowells@redhat.com>
To:     miklos@szeredi.hu, viro@zeniv.linux.org.uk
Cc:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        dhowells@redhat.com, anprice@redhat.com
Date:   Tue, 19 Mar 2019 16:23:38 +0000
Message-ID: <155301261872.7556.14287203880762974502.stgit@warthog.procyon.org.uk>
In-Reply-To: <155301260319.7556.1326405089184672936.stgit@warthog.procyon.org.uk>
References: <155301260319.7556.1326405089184672936.stgit@warthog.procyon.org.uk>
User-Agent: StGit/unknown-version
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.28]); Tue, 19 Mar 2019 16:23:40 +0000 (UTC)
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

