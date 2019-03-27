Return-Path: <SRS0=95/N=R6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 267C4C43381
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Mar 2019 05:18:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D86B220811
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Mar 2019 05:18:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1553663910;
	bh=QHYt7tBZR2BS4LXePTavteBti0TTK7uUQS7NU6bD0FM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=MBzK7frXgxE6Mtenk7ZAq/v/0xN1dBH4TIXNic3VMocWOqSIrMSf65zemgtGbpsrc
	 GNFrcp1HxzZzhIc/N5TwJivpp16DtS5+bRou8PhyhuHXIYbFr2lL8/aX/LFA9ZQFZI
	 m0RTqoRUAI9ecBI9BhMTAZe9TA7f0yWpIEvxV1lU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732084AbfC0FS3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Mar 2019 01:18:29 -0400
Received: from out3-smtp.messagingengine.com ([66.111.4.27]:39457 "EHLO
        out3-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725805AbfC0FS2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Mar 2019 01:18:28 -0400
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailout.nyi.internal (Postfix) with ESMTP id 53BD02210C;
        Wed, 27 Mar 2019 01:18:27 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute3.internal (MEProxy); Wed, 27 Mar 2019 01:18:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:date:from
        :in-reply-to:message-id:mime-version:references:subject:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm2; bh=wYESywpe2KzRxzveXUnzSCOjdaDBvnaLB8RmwTNSI08=; b=2iLmLtxJ
        bj6hF7eWPLB3PpmuqFVpk/Q27J8ORjAi92g+uIlrGF3sHBTZBvFfhyhNjmg2jiTH
        hB6E66/VOSWyGpOgKbrP8szY0dzWKifRCvz3WfKOJSrsblTA0ZjRaYBqEZhqyIwi
        uUOXf6WUPqj4xNNv6YOB8LLtMKBr6dXtTIpTyPl/Hh6uFRT+Ndd4KuVkVWLyETEz
        1FA+H6Blzn+PcEbMAiqGOoAaNgldGWBQXWHRThJwJxZUdkkEx+sJ604xALwQdxzS
        pVf2Zl2tnnd4HWcklfIBi7qAN3DVhJtUAUwIYBj1UrczPJUKc3q85DWlvgZGf7mw
        FCZTY2yvbDTaEA==
X-ME-Sender: <xms:owebXM-ySsui8nA41IG_3l0sWCPHnq7NX3jegqfVPou7Ph_kLoe_aw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedutddrkedugdektdcutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpefhvffufffkofgjfhgggfestdekredtredttdenucfhrhhomhepfdfvohgsihhn
    ucevrdcujfgrrhguihhnghdfuceothhosghinheskhgvrhhnvghlrdhorhhgqeenucfkph
    epuddvgedrudeiledrudefledrudelvdenucfrrghrrghmpehmrghilhhfrhhomhepthho
    sghinheskhgvrhhnvghlrdhorhhgnecuvehluhhsthgvrhfuihiivgeptd
X-ME-Proxy: <xmx:owebXC3GOahn_av-4qudj9zuRCSH4qVYaciYd0vaHt2mT5Y1JOHFdw>
    <xmx:owebXMkmGfgda0o1gk5nMWDaoKe052DxE-7erJTMyFQ9tW8jBdKSjg>
    <xmx:owebXA8wftR3AGkkP1XHGIwm2utanld4QO3VtGBOUPI3TICTz6ApKg>
    <xmx:owebXCPiyL2iSncWl7H7aAu4i3bUczGRk6QsPjsSJHex8htpXPRMFg>
Received: from eros.localdomain (124-169-139-192.dyn.iinet.net.au [124.169.139.192])
        by mail.messagingengine.com (Postfix) with ESMTPA id C5711E44D7;
        Wed, 27 Mar 2019 01:18:23 -0400 (EDT)
From:   "Tobin C. Harding" <tobin@kernel.org>
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     "Tobin C. Harding" <tobin@kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Mauro Carvalho Chehab <mchehab@s-opensource.com>,
        Neil Brown <neilb@suse.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        linux-doc@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v3 01/24] vfs: Remove trailing whitespace
Date:   Wed, 27 Mar 2019 16:16:54 +1100
Message-Id: <20190327051717.23225-2-tobin@kernel.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190327051717.23225-1-tobin@kernel.org>
References: <20190327051717.23225-1-tobin@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently there are a few instances of trailing whitespace.  In
preparation for patching fs.h lets remove them.

Remove trailing whitespace.

Signed-off-by: Tobin C. Harding <tobin@kernel.org>
---
 include/linux/fs.h | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/include/linux/fs.h b/include/linux/fs.h
index 3e85cb8e8c20..4f9d2e6b9ac3 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -239,7 +239,7 @@ struct iattr {
  */
 #define FILESYSTEM_MAX_STACK_DEPTH 2
 
-/** 
+/**
  * enum positive_aop_returns - aop return codes with specific semantics
  *
  * @AOP_WRITEPAGE_ACTIVATE: Informs the caller that page writeback has
@@ -249,7 +249,7 @@ struct iattr {
  * 			    be a candidate for writeback again in the near
  * 			    future.  Other callers must be careful to unlock
  * 			    the page if they get this return.  Returned by
- * 			    writepage(); 
+ * 			    writepage();
  *
  * @AOP_TRUNCATED_PAGE: The AOP method that was handed a locked page has
  *  			unlocked it and the page might have been truncated.
@@ -959,8 +959,8 @@ static inline struct file *get_file(struct file *f)
 
 #define	MAX_NON_LFS	((1UL<<31) - 1)
 
-/* Page cache limit. The filesystems should put that into their s_maxbytes 
-   limits, otherwise bad things can happen in VM. */ 
+/* Page cache limit. The filesystems should put that into their s_maxbytes
+   limits, otherwise bad things can happen in VM. */
 #if BITS_PER_LONG==32
 #define MAX_LFS_FILESIZE	((loff_t)ULONG_MAX << PAGE_SHIFT)
 #elif BITS_PER_LONG==64
@@ -2170,7 +2170,7 @@ int sync_inode_metadata(struct inode *inode, int wait);
 struct file_system_type {
 	const char *name;
 	int fs_flags;
-#define FS_REQUIRES_DEV		1 
+#define FS_REQUIRES_DEV		1
 #define FS_BINARY_MOUNTDATA	2
 #define FS_HAS_SUBTYPE		4
 #define FS_USERNS_MOUNT		8	/* Can be mounted by userns root */
@@ -2938,7 +2938,7 @@ extern ssize_t kernel_read(struct file *, void *, size_t, loff_t *);
 extern ssize_t kernel_write(struct file *, const void *, size_t, loff_t *);
 extern ssize_t __kernel_write(struct file *, const void *, size_t, loff_t *);
 extern struct file * open_exec(const char *);
- 
+
 /* fs/dcache.c -- generic fs support functions */
 extern bool is_subdir(struct dentry *, struct dentry *);
 extern bool path_is_under(const struct path *, const struct path *);
-- 
2.21.0

