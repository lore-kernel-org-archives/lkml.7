Return-Path: <SRS0=S2At=YJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 963D9FA3728
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Oct 2019 22:01:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 637F5218DE
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Oct 2019 22:01:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1571263264;
	bh=YnmQfpc3QrCOIxozSRo+8pJdrIUK4QFjQ8mrgUYzdME=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=hsZq+m2l2CAIXX7X7TIbvB66gYqyLIRpPZ6aPj4z3U9koY5ohiTskSH0HMh3ryRVl
	 F5EO4SHFg1aGnBxgQhtKF2QhkPLeMlwRZgTqqK7l1mO5tqseXTkFdN5GEOlMlrOHOC
	 DxIZNAe33G7+s1stHaKdN9rrPugLzDyQvAUte8AI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2438939AbfJPWBD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 16 Oct 2019 18:01:03 -0400
Received: from mail.kernel.org ([198.145.29.99]:54968 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2438624AbfJPV7r (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Oct 2019 17:59:47 -0400
Received: from localhost (unknown [192.55.54.58])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 09D6A21D80;
        Wed, 16 Oct 2019 21:59:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1571263186;
        bh=YnmQfpc3QrCOIxozSRo+8pJdrIUK4QFjQ8mrgUYzdME=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=rlEmcumHJlOpW3TnJO/NXm2L9UyvpsHZpCDUdDW3LSSMwXd1F+pvQ7dJLk3sKOlOK
         0HSNGKsIKcILnSQkS1zCti3z7xwtZsfi1UT97U8Yv426raTn8lnGAJYfnHVA4Jjvxw
         oNhdhrw90LeVfr6MKBdTarFTLmmjmEhNbsEKGqfc=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Pavel Shilovsky <pshilov@microsoft.com>,
        Steve French <stfrench@microsoft.com>
Subject: [PATCH 5.3 073/112] CIFS: Force reval dentry if LOOKUP_REVAL flag is set
Date:   Wed, 16 Oct 2019 14:51:05 -0700
Message-Id: <20191016214903.754836231@linuxfoundation.org>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191016214844.038848564@linuxfoundation.org>
References: <20191016214844.038848564@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Pavel Shilovsky <piastryyy@gmail.com>

commit 0b3d0ef9840f7be202393ca9116b857f6f793715 upstream.

Mark inode for force revalidation if LOOKUP_REVAL flag is set.
This tells the client to actually send a QueryInfo request to
the server to obtain the latest metadata in case a directory
or a file were changed remotely. Only do that if the client
doesn't have a lease for the file to avoid unneeded round
trips to the server.

Cc: <stable@vger.kernel.org>
Signed-off-by: Pavel Shilovsky <pshilov@microsoft.com>
Signed-off-by: Steve French <stfrench@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 fs/cifs/dir.c |    8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

--- a/fs/cifs/dir.c
+++ b/fs/cifs/dir.c
@@ -738,10 +738,16 @@ cifs_lookup(struct inode *parent_dir_ino
 static int
 cifs_d_revalidate(struct dentry *direntry, unsigned int flags)
 {
+	struct inode *inode;
+
 	if (flags & LOOKUP_RCU)
 		return -ECHILD;
 
 	if (d_really_is_positive(direntry)) {
+		inode = d_inode(direntry);
+		if ((flags & LOOKUP_REVAL) && !CIFS_CACHE_READ(CIFS_I(inode)))
+			CIFS_I(inode)->time = 0; /* force reval */
+
 		if (cifs_revalidate_dentry(direntry))
 			return 0;
 		else {
@@ -752,7 +758,7 @@ cifs_d_revalidate(struct dentry *direntr
 			 * attributes will have been updated by
 			 * cifs_revalidate_dentry().
 			 */
-			if (IS_AUTOMOUNT(d_inode(direntry)) &&
+			if (IS_AUTOMOUNT(inode) &&
 			   !(direntry->d_flags & DCACHE_NEED_AUTOMOUNT)) {
 				spin_lock(&direntry->d_lock);
 				direntry->d_flags |= DCACHE_NEED_AUTOMOUNT;


