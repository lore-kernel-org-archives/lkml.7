Return-Path: <SRS0=xYIU=RV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0D216C4360F
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Mar 2019 23:15:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D06142064C
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Mar 2019 23:15:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1552950933;
	bh=ZojYX+XFjV2N7qXQysduMskFQDMyHJ4OxPsm/itdzvg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=XEVAu2gbrtXFhwm1r3Vv4o+v/w8dJlQMHhy+E4he8ZD496FvAyeASfL1qMept/im3
	 qD9zg7iaamkoImnZIOLlSTYzfxoGDujmoLWe0IruPhVty6ggLXjKcQjQcJHSr67tqy
	 +zXZQYX0ZedIT8tMiv7KCaMYQTPYa8SeDMRqPHok=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727623AbfCRXPc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Mar 2019 19:15:32 -0400
Received: from out2-smtp.messagingengine.com ([66.111.4.26]:55973 "EHLO
        out2-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727235AbfCRXPb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Mar 2019 19:15:31 -0400
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailout.nyi.internal (Postfix) with ESMTP id AFB0420336;
        Mon, 18 Mar 2019 19:15:28 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute3.internal (MEProxy); Mon, 18 Mar 2019 19:15:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:date:from
        :in-reply-to:message-id:mime-version:references:subject:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm2; bh=orANEqMzXIgVGZXxePffekYMyPICqeToBFW7oY8WfmU=; b=kqByyh6C
        8KafHhx3K+glYXqz0qLUSRwhMmDbHY+TkfFKh1TB2O838KhCGxB4/gyNP+jKFizC
        R73GWF3pen68tJtA0GHZ0CZI8Cl/61ip+EHQW6yZY1zJih38pmMSJEJeek+3/gnQ
        ZFvYPMiwBp1Vn6+5R1Z5G2SPdfBbKSI+xPHEpgwtx0z2nVOoSQGmRTvUI1cUQAmM
        YIBbU5fZP+rtlPPp6KwfPAs5Ql/pOzfZ8Cc5B8WaadqTxsBUzof40P80uEBS5DdT
        VKcZI8rJbYMI18LklPi/jgcATAOSkrtg+4a/xWFAks4E/gCjwnQXU+qiExyqjvji
        khPgxBj4e8Yqeg==
X-ME-Sender: <xms:kCaQXHSwZRwiQ98e_t_8k7L-A5ml26PdZ5k6K1mSFDqgRwbCdsO7zw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedutddriedvgddtfecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpefhvffufffkofgjfhgggfestdekredtredttdenucfhrhhomhepfdfvohgsihhn
    ucevrdcujfgrrhguihhnghdfuceothhosghinheskhgvrhhnvghlrdhorhhgqeenucfkph
    epuddvgedrudeiledrudegledrgedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehtohgs
    ihhnsehkvghrnhgvlhdrohhrghenucevlhhushhtvghrufhiiigvpeef
X-ME-Proxy: <xmx:kCaQXKqWMNQ8QDO5ZILt9_iFPtapg8kBKfixEYn3IkWwxpYFgo5eMg>
    <xmx:kCaQXBZ5Qi8ZTATsdUTHZZXfpMOyvXDxDLL-KaIonumvnsiyTA17dQ>
    <xmx:kCaQXEpTqvsytrZsrYYfxipMHfbtPsw9hrHdUEwYSWIkY5ZHz6F4uw>
    <xmx:kCaQXIB29Epx74W2uuXnNE0kd7u84WolUgGuW85ojNR_N5dgJQIPSg>
Received: from eros.localdomain (124-169-149-40.dyn.iinet.net.au [124.169.149.40])
        by mail.messagingengine.com (Postfix) with ESMTPA id DBBBC10288;
        Mon, 18 Mar 2019 19:15:25 -0400 (EDT)
From:   "Tobin C. Harding" <tobin@kernel.org>
To:     Jonathan Corbet <corbet@lwn.net>
Cc:     "Tobin C. Harding" <tobin@kernel.org>,
        Randy Dunlap <rdunlap@infradead.org>,
        linux-doc@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 04/13] docs: filesystems: vfs: Use uniform spacing around headings
Date:   Tue, 19 Mar 2019 10:14:28 +1100
Message-Id: <20190318231437.1666-5-tobin@kernel.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190318231437.1666-1-tobin@kernel.org>
References: <20190318231437.1666-1-tobin@kernel.org>
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
index 14839bc84d38..ed12d28bda62 100644
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
 
@@ -1203,9 +1208,11 @@ manipulate dentries:
 	and the dentry is returned.  The caller must use dput()
 	to free the dentry when it finishes using it.
 
+
 Mount Options
 =============
 
+
 Parsing options
 ---------------
 
@@ -1220,6 +1227,7 @@ The <linux/parser.h> header defines an API that helps parse these
 options.  There are plenty of examples on how to use it in existing
 filesystems.
 
+
 Showing options
 ---------------
 
@@ -1241,6 +1249,7 @@ The underlying reason for the above rules is to make sure, that a mount
 can be accurately replicated (e.g. umounting and mounting again) based
 on the information found in /proc/mounts.
 
+
 Resources
 =========
 
-- 
2.21.0

