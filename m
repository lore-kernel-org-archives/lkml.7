Return-Path: <SRS0=95/N=R6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D5BF6C43381
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Mar 2019 23:41:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A0B402075E
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Mar 2019 23:41:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730849AbfC0XlC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Mar 2019 19:41:02 -0400
Received: from mx1.redhat.com ([209.132.183.28]:46342 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725601AbfC0XlB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Mar 2019 19:41:01 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id C567930BC666;
        Wed, 27 Mar 2019 23:41:00 +0000 (UTC)
Received: from warthog.procyon.org.uk (ovpn-121-98.rdu2.redhat.com [10.10.121.98])
        by smtp.corp.redhat.com (Postfix) with ESMTP id DF21322706;
        Wed, 27 Mar 2019 23:40:59 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
 Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
 Kingdom.
 Registered in England and Wales under Company Registration No. 3798903
Subject: [RFC PATCH 03/68] vfs: Fix refcounting of filenames in fs_parser
From:   David Howells <dhowells@redhat.com>
To:     viro@zeniv.linux.org.uk
Cc:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        dhowells@redhat.com
Date:   Wed, 27 Mar 2019 23:40:59 +0000
Message-ID: <155373005910.7602.15928901793963598025.stgit@warthog.procyon.org.uk>
In-Reply-To: <155372999953.7602.13784796495137723805.stgit@warthog.procyon.org.uk>
References: <155372999953.7602.13784796495137723805.stgit@warthog.procyon.org.uk>
User-Agent: StGit/unknown-version
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.46]); Wed, 27 Mar 2019 23:41:00 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix an overput in which filename_lookup() unconditionally drops a ref to
the filename it was given, but this isn't taken account of in the caller,
fs_lookup_param().

Addresses-Coverity-ID: 1443811 ("Use after free")
Signed-off-by: David Howells <dhowells@redhat.com>
---

 fs/fs_parser.c |    1 +
 1 file changed, 1 insertion(+)

diff --git a/fs/fs_parser.c b/fs/fs_parser.c
index 842e8f749db6..be86703ec371 100644
--- a/fs/fs_parser.c
+++ b/fs/fs_parser.c
@@ -268,6 +268,7 @@ int fs_lookup_param(struct fs_context *fc,
 		return invalf(fc, "%s: not usable as path", param->key);
 	}
 
+	f->refcnt++; /* filename_lookup() drops our ref. */
 	ret = filename_lookup(param->dirfd, f, flags, _path, NULL);
 	if (ret < 0) {
 		errorf(fc, "%s: Lookup failure for '%s'", param->key, f->name);

