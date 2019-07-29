Return-Path: <SRS0=K9bG=V2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2C795C433FF
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jul 2019 19:34:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F1DA6217D7
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jul 2019 19:34:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1564428870;
	bh=FRTWK1UW7JCfMIwKadFY/C0ZNh5/pNuZbIf5M2pQ2sY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=mvhy4Yp+m9GK37kc2J5QaT4qFILQaDYg7hSoBwDb5fwxIuRl0o1NMPChjihZOPluG
	 3V1N8j9+A2sKYrWS/DmW9wSnPDmkN+lWza/FRVdb+HnudISzWJtcw8aVcUmcgFKZl0
	 k8a1F8sFrK+wqSdeST1hj6wF7dvqOU6+rwmEnfeQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388440AbfG2Te2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Jul 2019 15:34:28 -0400
Received: from mail.kernel.org ([198.145.29.99]:48812 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388336AbfG2TeY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Jul 2019 15:34:24 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3F7D32070B;
        Mon, 29 Jul 2019 19:34:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1564428863;
        bh=FRTWK1UW7JCfMIwKadFY/C0ZNh5/pNuZbIf5M2pQ2sY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=NA+l6CFWFvjYkooNF84rAOZKh8YaiOyMvCf9LrZGAG5vG0DupOQ0CM6ELdIwVdvhU
         H48B5+516EbkcWwrkwruaVBdJcJwcP9bCMwSBrC/2dNu29bO1GFx8sqDZrdtBzCWBv
         0HHEevKqEXac2X0Z0HDvrXWfPsqyPHXzcmVY76y4=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Ross Zwisler <zwisler@google.com>,
        Theodore Tso <tytso@mit.edu>, Jan Kara <jack@suse.cz>
Subject: [PATCH 4.14 210/293] mm: add filemap_fdatawait_range_keep_errors()
Date:   Mon, 29 Jul 2019 21:21:41 +0200
Message-Id: <20190729190840.547311068@linuxfoundation.org>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20190729190820.321094988@linuxfoundation.org>
References: <20190729190820.321094988@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ross Zwisler <zwisler@chromium.org>

commit aa0bfcd939c30617385ffa28682c062d78050eba upstream.

In the spirit of filemap_fdatawait_range() and
filemap_fdatawait_keep_errors(), introduce
filemap_fdatawait_range_keep_errors() which both takes a range upon
which to wait and does not clear errors from the address space.

Signed-off-by: Ross Zwisler <zwisler@google.com>
Signed-off-by: Theodore Ts'o <tytso@mit.edu>
Reviewed-by: Jan Kara <jack@suse.cz>
Cc: stable@vger.kernel.org
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 include/linux/fs.h |    2 ++
 mm/filemap.c       |   22 ++++++++++++++++++++++
 2 files changed, 24 insertions(+)

--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -2580,6 +2580,8 @@ extern int filemap_flush(struct address_
 extern int filemap_fdatawait_keep_errors(struct address_space *mapping);
 extern int filemap_fdatawait_range(struct address_space *, loff_t lstart,
 				   loff_t lend);
+extern int filemap_fdatawait_range_keep_errors(struct address_space *mapping,
+		loff_t start_byte, loff_t end_byte);
 
 static inline int filemap_fdatawait(struct address_space *mapping)
 {
--- a/mm/filemap.c
+++ b/mm/filemap.c
@@ -464,6 +464,28 @@ int filemap_fdatawait_range(struct addre
 EXPORT_SYMBOL(filemap_fdatawait_range);
 
 /**
+ * filemap_fdatawait_range_keep_errors - wait for writeback to complete
+ * @mapping:		address space structure to wait for
+ * @start_byte:		offset in bytes where the range starts
+ * @end_byte:		offset in bytes where the range ends (inclusive)
+ *
+ * Walk the list of under-writeback pages of the given address space in the
+ * given range and wait for all of them.  Unlike filemap_fdatawait_range(),
+ * this function does not clear error status of the address space.
+ *
+ * Use this function if callers don't handle errors themselves.  Expected
+ * call sites are system-wide / filesystem-wide data flushers: e.g. sync(2),
+ * fsfreeze(8)
+ */
+int filemap_fdatawait_range_keep_errors(struct address_space *mapping,
+		loff_t start_byte, loff_t end_byte)
+{
+	__filemap_fdatawait_range(mapping, start_byte, end_byte);
+	return filemap_check_and_keep_errors(mapping);
+}
+EXPORT_SYMBOL(filemap_fdatawait_range_keep_errors);
+
+/**
  * file_fdatawait_range - wait for writeback to complete
  * @file:		file pointing to address space structure to wait for
  * @start_byte:		offset in bytes where the range starts


