Return-Path: <SRS0=Dgga=T6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 759EAC28CC0
	for <linux-kernel@archiver.kernel.org>; Thu, 30 May 2019 17:26:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4B1E525E68
	for <linux-kernel@archiver.kernel.org>; Thu, 30 May 2019 17:26:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726989AbfE3R0N (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 May 2019 13:26:13 -0400
Received: from mx1.redhat.com ([209.132.183.28]:43504 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726550AbfE3R0M (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 May 2019 13:26:12 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id D973030C543E;
        Thu, 30 May 2019 17:26:11 +0000 (UTC)
Received: from warthog.procyon.org.uk (ovpn-120-173.rdu2.redhat.com [10.10.120.173])
        by smtp.corp.redhat.com (Postfix) with ESMTP id AFB5C60C43;
        Thu, 30 May 2019 17:26:10 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
 Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
 Kingdom.
 Registered in England and Wales under Company Registration No. 3798903
Subject: [PATCH 08/10] keys: Grant Link permission to possessers of
 request_key auth keys [ver #2]
From:   David Howells <dhowells@redhat.com>
To:     keyrings@vger.kernel.org
Cc:     James Morris <jamorris@linux.microsoft.com>, dhowells@redhat.com,
        linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org, ebiggers@kernel.org
Date:   Thu, 30 May 2019 18:26:09 +0100
Message-ID: <155923716995.949.7037346392947998625.stgit@warthog.procyon.org.uk>
In-Reply-To: <155923711088.949.14909672457214372214.stgit@warthog.procyon.org.uk>
References: <155923711088.949.14909672457214372214.stgit@warthog.procyon.org.uk>
User-Agent: StGit/unknown-version
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.46]); Thu, 30 May 2019 17:26:11 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Grant Link permission to the possessers of request_key authentication keys,
thereby allowing a daemon that is servicing upcalls to arrange things such
that only the necessary auth key is passed to the actual service program
and not all the daemon's pending auth keys.

Signed-off-by: David Howells <dhowells@redhat.com>
Reviewed-by: James Morris <jamorris@linux.microsoft.com>
---

 security/keys/request_key_auth.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/security/keys/request_key_auth.c b/security/keys/request_key_auth.c
index 572c7a60473a..ec5226557023 100644
--- a/security/keys/request_key_auth.c
+++ b/security/keys/request_key_auth.c
@@ -204,7 +204,7 @@ struct key *request_key_auth_new(struct key *target, const char *op,
 
 	authkey = key_alloc(&key_type_request_key_auth, desc,
 			    cred->fsuid, cred->fsgid, cred,
-			    KEY_POS_VIEW | KEY_POS_READ | KEY_POS_SEARCH |
+			    KEY_POS_VIEW | KEY_POS_READ | KEY_POS_SEARCH | KEY_POS_LINK |
 			    KEY_USR_VIEW, KEY_ALLOC_NOT_IN_QUOTA, NULL);
 	if (IS_ERR(authkey)) {
 		ret = PTR_ERR(authkey);

