Return-Path: <SRS0=jko7=2A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7F7E6C2D0BF
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Dec 2019 12:33:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 55FB020652
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Dec 2019 12:33:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="R/xy9524"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727866AbfLJMdU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Dec 2019 07:33:20 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:27920 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727492AbfLJMbX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Dec 2019 07:31:23 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1575981082;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=6FM6XYBQ1hKH0GC/JZnzY8+SSWAtUZ4+Dcf/j3t4Ako=;
        b=R/xy95245BGKDVyg3DHO9/SfVGpN5cnMjpLuvdO3Ro4VqnZ4gKteZI+Fbb25snA0oOTjFE
        0u6UaPQPexR4a34N5zGNdNF6u2mgwNMvtdWryuwFq6lM17LpUhOG5Cyx2uTvEqubWktuIG
        VDFVdPPKKtUOnVaMIpP4ynT3Ty6a4Xc=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-194-PcFr5xbYOlSSLBTEwHib9w-1; Tue, 10 Dec 2019 07:31:18 -0500
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 7EED7100551C;
        Tue, 10 Dec 2019 12:31:17 +0000 (UTC)
Received: from coeurl.usersys.redhat.com (ovpn-123-90.rdu2.redhat.com [10.10.123.90])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 5CA996F964;
        Tue, 10 Dec 2019 12:31:17 +0000 (UTC)
Received: by coeurl.usersys.redhat.com (Postfix, from userid 1000)
        id E0C2020C2D; Tue, 10 Dec 2019 07:31:15 -0500 (EST)
From:   Scott Mayhew <smayhew@redhat.com>
To:     anna.schumaker@netapp.com, trond.myklebust@hammerspace.com
Cc:     dhowells@redhat.com, viro@zeniv.linux.org.uk,
        linux-nfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-security-module@vger.kernel.org
Subject: [PATCH v6 17/27] NFS: Constify mount argument match tables
Date:   Tue, 10 Dec 2019 07:31:05 -0500
Message-Id: <20191210123115.1655-18-smayhew@redhat.com>
In-Reply-To: <20191210123115.1655-1-smayhew@redhat.com>
References: <20191210123115.1655-1-smayhew@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-MC-Unique: PcFr5xbYOlSSLBTEwHib9w-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: David Howells <dhowells@redhat.com>

The mount argument match tables should never be altered so constify them.

Signed-off-by: David Howells <dhowells@redhat.com>
Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
 fs/nfs/fs_context.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/fs/nfs/fs_context.c b/fs/nfs/fs_context.c
index c8f99a3c7264..8fbfd526d6b8 100644
--- a/fs/nfs/fs_context.c
+++ b/fs/nfs/fs_context.c
@@ -199,7 +199,7 @@ enum {
 =09Opt_lookupcache_err
 };
=20
-static match_table_t nfs_lookupcache_tokens =3D {
+static const match_table_t nfs_lookupcache_tokens =3D {
 =09{ Opt_lookupcache_all, "all" },
 =09{ Opt_lookupcache_positive, "pos" },
 =09{ Opt_lookupcache_positive, "positive" },
@@ -215,7 +215,7 @@ enum {
 =09Opt_local_lock_err
 };
=20
-static match_table_t nfs_local_lock_tokens =3D {
+static const match_table_t nfs_local_lock_tokens =3D {
 =09{ Opt_local_lock_all, "all" },
 =09{ Opt_local_lock_flock, "flock" },
 =09{ Opt_local_lock_posix, "posix" },
@@ -231,7 +231,7 @@ enum {
 =09Opt_vers_err
 };
=20
-static match_table_t nfs_vers_tokens =3D {
+static const match_table_t nfs_vers_tokens =3D {
 =09{ Opt_vers_2, "2" },
 =09{ Opt_vers_3, "3" },
 =09{ Opt_vers_4, "4" },
--=20
2.17.2

