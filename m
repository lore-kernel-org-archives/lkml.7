Return-Path: <SRS0=95/N=R6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 244C8C43381
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Mar 2019 05:19:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E89042064A
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Mar 2019 05:19:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1553663985;
	bh=+UhRJJjc2iYKQYaeMwXF9jnhdcosuX9C7yCW1yU/S88=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=eke9zJv9+evwfDAwet02jF8ZVVavpJEwaGmMucy9Dcfu4Ocs13B1Rqdmyp1/ucSEs
	 ANDH/E82mAQzfxpnJPHCCQoHJRApTTmMyD5gS+sfkYyo0i2PddDenThwMiNNpEQ/ug
	 cjidaPHmRv+CL0ORBTZHRXrIuLz/NVKNCuahwuU0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733269AbfC0FTm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Mar 2019 01:19:42 -0400
Received: from out3-smtp.messagingengine.com ([66.111.4.27]:58345 "EHLO
        out3-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1733150AbfC0FTk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Mar 2019 01:19:40 -0400
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailout.nyi.internal (Postfix) with ESMTP id 1997A220B3;
        Wed, 27 Mar 2019 01:19:39 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute3.internal (MEProxy); Wed, 27 Mar 2019 01:19:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:date:from
        :in-reply-to:message-id:mime-version:references:subject:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm2; bh=FjHoXW+oSNbeABpNGFpEjjjz7ysOT0oYkb5mJvFJQgs=; b=S/j6Tl/N
        NbTJEwyaJtOYu9Iohj/ldzgSgGpjkpmPyVCiSjUBn53UoILk4yUGXxLiwzGOj4/g
        cY+iYKnhNAWGVCCzlouQfdh7oTLdHqUTSw0PjzhssAlRFO+gNLePrX8/OC2ddTxA
        sDt/mHOb8EZt1/zthu94d+Kgztn8HBn+nh1e3of4WCrCcHlDtF96kt2AfGOcxfEG
        Viwzy/8d+onwEljeUGoCu3eaSvO/iXfoYQSojUVgSqUILQgChU+cm11sL7ML7QA7
        GXMr6EigRcPinGUEStE6dXv7oeF34lsvPbZg4dbWvF9Tc7nTR9RFU13hsXurDV8W
        r285dFZzljv3OQ==
X-ME-Sender: <xms:6gebXGxUCDXma3qIMoi6D0Wdoqct1nzsTmu3Lkv8_67ioUR0x_fdbA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedutddrkedugdektdcutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpefhvffufffkofgjfhgggfestdekredtredttdenucfhrhhomhepfdfvohgsihhn
    ucevrdcujfgrrhguihhnghdfuceothhosghinheskhgvrhhnvghlrdhorhhgqeenucfkph
    epuddvgedrudeiledrudefledrudelvdenucfrrghrrghmpehmrghilhhfrhhomhepthho
    sghinheskhgvrhhnvghlrdhorhhgnecuvehluhhsthgvrhfuihiivgepudei
X-ME-Proxy: <xmx:6gebXJhHbFMw9CN1654xWMLcMiRUXf5BOVL5MYyOATa0qei7MAk3Ig>
    <xmx:6gebXDNTDc6VzjuDeYd583KVeJ4kJhJkmjGH0ATEd-5tuZtWlJuR0Q>
    <xmx:6gebXMfG2sCCePeEljPYtYpH8ilsVG62f26eiCUmuATGcevBphxyHQ>
    <xmx:6webXATKJ-QWB74qXg0sAIJnOlFhbyj_Jo3RNROgfaI-janJWl4Qcg>
Received: from eros.localdomain (124-169-139-192.dyn.iinet.net.au [124.169.139.192])
        by mail.messagingengine.com (Postfix) with ESMTPA id 7E174E415C;
        Wed, 27 Mar 2019 01:19:35 -0400 (EDT)
From:   "Tobin C. Harding" <tobin@kernel.org>
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     "Tobin C. Harding" <tobin@kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Mauro Carvalho Chehab <mchehab@s-opensource.com>,
        Neil Brown <neilb@suse.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        linux-doc@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v3 18/24] docs: filesystems: vfs: Use uniform spacing around headings
Date:   Wed, 27 Mar 2019 16:17:11 +1100
Message-Id: <20190327051717.23225-19-tobin@kernel.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190327051717.23225-1-tobin@kernel.org>
References: <20190327051717.23225-1-tobin@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently spacing before and after headings is non-uniform.  Use two
blank lines before a heading and one after the heading.

Use uniform spacing around headings.

Tested-by: Randy Dunlap <rdunlap@infradead.org>
Signed-off-by: Tobin C. Harding <tobin@kernel.org>
---
 Documentation/filesystems/vfs.txt | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/Documentation/filesystems/vfs.txt b/Documentation/filesystems/vfs.txt
index 5c4d74547dd7..b452b3fc5edc 100644
--- a/Documentation/filesystems/vfs.txt
+++ b/Documentation/filesystems/vfs.txt
@@ -321,6 +321,7 @@ Whoever sets up the inode is responsible for filling in the "i_op"
 field.  This is a pointer to a "struct inode_operations" which describes
 the methods that can be performed on individual inodes.
 
+
 struct xattr_handlers
 ---------------------
 
@@ -507,6 +508,7 @@ otherwise noted.
   tmpfile: called in the end of O_TMPFILE open().  Optional, equivalent to
 	atomically creating, opening and unlinking a file in given directory.
 
+
 The Address Space Object
 ========================
 
@@ -580,8 +582,10 @@ and the constraints under which it is being done.  It is also used to
 return information back to the caller about the result of a writepage or
 writepages request.
 
+
 Handling errors during writeback
 --------------------------------
+
 Most applications that do buffered I/O will periodically call a file
 synchronization call (fsync, fdatasync, msync or sync_file_range) to
 ensure that data written has made it to the backing store.  When there
@@ -612,6 +616,7 @@ file->fsync operation, they should call file_check_and_advance_wb_err to
 ensure that the struct file's error cursor has advanced to the correct
 point in the stream of errors emitted by the backing device(s).
 
+
 struct address_space_operations
 -------------------------------
 
@@ -1200,9 +1205,11 @@ manipulate dentries:
 	and the dentry is returned.  The caller must use dput()
 	to free the dentry when it finishes using it.
 
+
 Mount Options
 =============
 
+
 Parsing options
 ---------------
 
@@ -1217,6 +1224,7 @@ The <linux/parser.h> header defines an API that helps parse these
 options.  There are plenty of examples on how to use it in existing
 filesystems.
 
+
 Showing options
 ---------------
 
@@ -1238,6 +1246,7 @@ The underlying reason for the above rules is to make sure, that a mount
 can be accurately replicated (e.g. umounting and mounting again) based
 on the information found in /proc/mounts.
 
+
 Resources
 =========
 
-- 
2.21.0

