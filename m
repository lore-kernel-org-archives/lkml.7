Return-Path: <SRS0=X8En=XO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B00B5C49ED7
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Sep 2019 22:11:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7B2DF218AF
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Sep 2019 22:11:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1568931095;
	bh=CmiYWrCziYWwm/L7yhLnm4McX5taLlSI0gBZlUARNcE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=dKK+f63BTHlACZy47w03Eo+NEPs7XkcCwJa96zlEkduJc+R3AaBWNKBZuR++GVTp/
	 9K6/4RM2VJ98FjqSCpHKGNdu9IESGZoJQpGzAevCqXZYVmeVzcoTQsA6/XjCEonvec
	 ihiP7gkOPqC/NJ6kO1r5+YpI4eFx2kVrFExu8Abo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2393611AbfISWLe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 19 Sep 2019 18:11:34 -0400
Received: from mail.kernel.org ([198.145.29.99]:50202 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2393595AbfISWLa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Sep 2019 18:11:30 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B5EE8218AF;
        Thu, 19 Sep 2019 22:11:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1568931090;
        bh=CmiYWrCziYWwm/L7yhLnm4McX5taLlSI0gBZlUARNcE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=WPwZ97055epYiOqafzcZglfFRGhoRcey/h8PdkO1blGT1XS8HxYFAZXNw1DMuzKMm
         il4ewKKDYK9vVkr0ipuLocuzPa94qywKvamRKK3iif0hkzF8/a7CQ2bLYT99ILCs8U
         EQPvdnb0rHN5iZnKK1a4i5PYh2S7U+Xjl+tb4Efo=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, David Howells <dhowells@redhat.com>
Subject: [PATCH 5.2 124/124] vfs: Fix refcounting of filenames in fs_parser
Date:   Fri, 20 Sep 2019 00:03:32 +0200
Message-Id: <20190919214823.713060325@linuxfoundation.org>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20190919214819.198419517@linuxfoundation.org>
References: <20190919214819.198419517@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: David Howells <dhowells@redhat.com>

commit 7cdfa44227b0d8842d46a775cebe4311150cb8f2 upstream.

Fix an overput in which filename_lookup() unconditionally drops a ref to
the filename it was given, but this isn't taken account of in the caller,
fs_lookup_param().

Addresses-Coverity-ID: 1443811 ("Use after free")
Signed-off-by: David Howells <dhowells@redhat.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 fs/fs_parser.c |    1 +
 1 file changed, 1 insertion(+)

--- a/fs/fs_parser.c
+++ b/fs/fs_parser.c
@@ -264,6 +264,7 @@ int fs_lookup_param(struct fs_context *f
 		return invalf(fc, "%s: not usable as path", param->key);
 	}
 
+	f->refcnt++; /* filename_lookup() drops our ref. */
 	ret = filename_lookup(param->dirfd, f, flags, _path, NULL);
 	if (ret < 0) {
 		errorf(fc, "%s: Lookup failure for '%s'", param->key, f->name);


