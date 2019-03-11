Return-Path: <SRS0=FxTY=RO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB5AFC43381
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Mar 2019 14:50:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8B08C2087C
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Mar 2019 14:50:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727808AbfCKOuy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Mar 2019 10:50:54 -0400
Received: from mx1.redhat.com ([209.132.183.28]:52924 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727195AbfCKOux (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Mar 2019 10:50:53 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id CC803308FE9C;
        Mon, 11 Mar 2019 14:50:53 +0000 (UTC)
Received: from warthog.procyon.org.uk (ovpn-121-148.rdu2.redhat.com [10.10.121.148])
        by smtp.corp.redhat.com (Postfix) with ESMTP id E479260C8B;
        Mon, 11 Mar 2019 14:50:52 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
 Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
 Kingdom.
 Registered in England and Wales under Company Registration No. 3798903
Subject: [PATCH 2/3] fscache: Add missing unhash
From:   David Howells <dhowells@redhat.com>
To:     lists@nerdbynature.de
Cc:     linux-kernel@vger.kernel.org, anna.schumaker@netapp.com,
        steved@redhat.com, dhowells@redhat.com
Date:   Mon, 11 Mar 2019 14:50:52 +0000
Message-ID: <155231585225.2992.10345384716639884052.stgit@warthog.procyon.org.uk>
In-Reply-To: <2827.1552315718@warthog.procyon.org.uk>
References: <2827.1552315718@warthog.procyon.org.uk>
User-Agent: StGit/unknown-version
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.49]); Mon, 11 Mar 2019 14:50:53 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In __fscache_acquire_cookie() if fscache_acquire_non_index_cookie() fails,
we clean up and return NULL (indicating no cookie) - however, we don't
unhash the previously hashed object first.

Fix this by moving the failure code out of the main path through the
function to its own goto label and add the missing fscache_unhash_cookie()
call.

Moving the code out to its own label allows the remaining part of the
if-statement to be simplified also.

Fixes: ec0328e46d6e ("fscache: Maintain a catalogue of allocated cookies")
Signed-off-by: David Howells <dhowells@redhat.com>
---

 fs/fscache/cookie.c |   26 ++++++++++++--------------
 1 file changed, 12 insertions(+), 14 deletions(-)

diff --git a/fs/fscache/cookie.c b/fs/fscache/cookie.c
index 75d0ffd36ac0..6931e45b7d59 100644
--- a/fs/fscache/cookie.c
+++ b/fs/fscache/cookie.c
@@ -346,20 +346,10 @@ struct fscache_cookie *__fscache_acquire_cookie(
 		/* if the object is an index then we need do nothing more here
 		 * - we create indices on disk when we need them as an index
 		 * may exist in multiple caches */
-		if (cookie->type != FSCACHE_COOKIE_TYPE_INDEX) {
-			if (fscache_acquire_non_index_cookie(cookie, object_size) == 0) {
-				set_bit(FSCACHE_COOKIE_ENABLED, &cookie->flags);
-			} else {
-				atomic_dec(&parent->n_children);
-				fscache_cookie_put(cookie,
-						   fscache_cookie_put_acquire_nobufs);
-				fscache_stat(&fscache_n_acquires_nobufs);
-				_leave(" = NULL");
-				return NULL;
-			}
-		} else {
-			set_bit(FSCACHE_COOKIE_ENABLED, &cookie->flags);
-		}
+		if (cookie->type != FSCACHE_COOKIE_TYPE_INDEX &&
+		    fscache_acquire_non_index_cookie(cookie, object_size) < 0)
+			goto failed;
+		set_bit(FSCACHE_COOKIE_ENABLED, &cookie->flags);
 	}
 
 	fscache_stat(&fscache_n_acquires_ok);
@@ -367,6 +357,14 @@ struct fscache_cookie *__fscache_acquire_cookie(
 out:
 	fscache_free_cookie(candidate);
 	return cookie;
+
+failed:
+	atomic_dec(&parent->n_children);
+	fscache_unhash_cookie(cookie);
+	fscache_cookie_put(cookie, fscache_cookie_put_acquire_nobufs);
+	fscache_stat(&fscache_n_acquires_nobufs);
+	_leave(" = NULL");
+	return NULL;
 }
 EXPORT_SYMBOL(__fscache_acquire_cookie);
 

