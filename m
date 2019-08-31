Return-Path: <SRS0=k4ck=W3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31292C3A5A6
	for <linux-kernel@archiver.kernel.org>; Sat, 31 Aug 2019 22:00:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E6F372187F
	for <linux-kernel@archiver.kernel.org>; Sat, 31 Aug 2019 22:00:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AJ/i3mis"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728523AbfHaV5R (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 31 Aug 2019 17:57:17 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:38652 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725806AbfHaV5Q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 31 Aug 2019 17:57:16 -0400
Received: by mail-wm1-f67.google.com with SMTP id o184so10928742wme.3;
        Sat, 31 Aug 2019 14:57:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=AYOwNEwasq9ZeSJ1tPX4siPkH0OJNt6wmi5XPh6tDK0=;
        b=AJ/i3mis8+vkGBYtlunuOHCXAG4O8vnpGO3SINmsB3D1igJM59m6N1qGCFoR3ZWiYT
         +qMqyF6K2zbG1JvudVAbxWgSUVNz8oqsMuw6J11JvqklrJLU3KyAny8mNZnBAiNqxBZw
         rm2ls2KADFRsIUQbWS4/O2aQj9cg+NCt/qvbP/pBdH+oAgnD2duVkr2fvLs4Dv2hoL/4
         TY8wjE+VccJ5Dz0fNvc+UnxSUfidcC2yWEJP2nycJE85dN7mx40zlyWwuL3CVY6G/WJx
         SHp2Xr2Gg60owC5FMmAKbXzzSWj/SxXzOaiVADFsaOLLtW9mIxI/EaD8K/DCefFO3mJ1
         FyDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :mime-version:content-transfer-encoding;
        bh=AYOwNEwasq9ZeSJ1tPX4siPkH0OJNt6wmi5XPh6tDK0=;
        b=byYESp64RnnmEWuug8cKG0CcGIQFArxEJNlCUXGAdjyTVop2pLjRCgHbmcZwoeq2qS
         qbxlPckeI3zgrCX75EOfh/t2v4VNSS0kJvjC5H/CCEdgY9MZS414C1ERHyvjWajwkPpB
         i37p2aEfLTs8uIqEjXDLqKOMbmK6xRnKk5QzgpOpe8bnnvhrp8rSPwXJWQLnpUqVCx2L
         BoaJwnTclvvpPPZO5e6LrD0K4Z8NG7F+bzn8y8TPTetLimd6jTBNGzEOJ5SLCxbho1hv
         F3DpjBKC5NUZNLxNuX6/4sliNkWWTad6auvYatjlSjALwT7En5Q9AovNZGM/mmJKy+E8
         Akmg==
X-Gm-Message-State: APjAAAU69MgD8f7N2jG3txC8rThx9ZMapnZdjQGa11Cr1Pxt7gSDA9gw
        FJlBplgkbZLZTxP8VB+7O2c=
X-Google-Smtp-Source: APXvYqxF8OnuJlVtDEZ2N/jealSjlLOGtlyQPVrn47WwZgo7igVRtfxdne/npBcKcgefeskRr2H8/A==
X-Received: by 2002:a05:600c:2181:: with SMTP id e1mr10119664wme.117.1567288634393;
        Sat, 31 Aug 2019 14:57:14 -0700 (PDT)
Received: from localhost.localdomain (ip5b4096c3.dynamic.kabel-deutschland.de. [91.64.150.195])
        by smtp.gmail.com with ESMTPSA id l9sm7713580wmi.29.2019.08.31.14.57.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 31 Aug 2019 14:57:13 -0700 (PDT)
From:   Krzysztof Wilczynski <kw@linux.com>
To:     Jeff Layton <jlayton@kernel.org>
Cc:     Sage Weil <sage@redhat.com>, Ilya Dryomov <idryomov@gmail.com>,
        ceph-devel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] ceph: Move static keyword to the front of declarations
Date:   Sat, 31 Aug 2019 23:57:12 +0200
Message-Id: <20190831215712.10148-1-kw@linux.com>
X-Mailer: git-send-email 2.23.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Move the static keyword to the front of declarations of
snap_handle_length, handle_length and connected_handle_length,
and resolve the following compiler warnings that can be seen
when building with warnings enabled (W=1):

fs/ceph/export.c:38:2: warning:
  ‘static’ is not at beginning of declaration [-Wold-style-declaration]

fs/ceph/export.c:88:2: warning:
  ‘static’ is not at beginning of declaration [-Wold-style-declaration]

fs/ceph/export.c:90:2: warning:
  ‘static’ is not at beginning of declaration [-Wold-style-declaration]

Signed-off-by: Krzysztof Wilczynski <kw@linux.com>
---
Related: https://lore.kernel.org/r/20190827233017.GK9987@google.com

 fs/ceph/export.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/fs/ceph/export.c b/fs/ceph/export.c
index 020d39a85ecc..b6bfa94332c3 100644
--- a/fs/ceph/export.c
+++ b/fs/ceph/export.c
@@ -35,7 +35,7 @@ struct ceph_nfs_snapfh {
 static int ceph_encode_snapfh(struct inode *inode, u32 *rawfh, int *max_len,
 			      struct inode *parent_inode)
 {
-	const static int snap_handle_length =
+	static const int snap_handle_length =
 		sizeof(struct ceph_nfs_snapfh) >> 2;
 	struct ceph_nfs_snapfh *sfh = (void *)rawfh;
 	u64 snapid = ceph_snap(inode);
@@ -85,9 +85,9 @@ static int ceph_encode_snapfh(struct inode *inode, u32 *rawfh, int *max_len,
 static int ceph_encode_fh(struct inode *inode, u32 *rawfh, int *max_len,
 			  struct inode *parent_inode)
 {
-	const static int handle_length =
+	static const int handle_length =
 		sizeof(struct ceph_nfs_fh) >> 2;
-	const static int connected_handle_length =
+	static const int connected_handle_length =
 		sizeof(struct ceph_nfs_confh) >> 2;
 	int type;
 
-- 
2.22.1

