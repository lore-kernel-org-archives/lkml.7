Return-Path: <SRS0=95/N=R6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A73A2C43381
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Mar 2019 05:18:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6D15120811
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Mar 2019 05:18:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1553663922;
	bh=wabzPJI4uBJSb0sEs7YcfoSgI+eDrvXdU3cdKJPtlaw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=OZzUe+F36DrqT1YvRzg7fOQlBuHBz4pk/x/1bZlIIpzj6VjeSJMt/JBemLAMTV/cs
	 DWJmQGjPB10hWcutrZC4OfPpST85ngpDctJ3XP1COFKjENb6F0qALJ5m34Yt9GLJ7m
	 fkdW/twbn9cClyjfNTe0Zvox1btEEC1a8EAARfvo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732744AbfC0FSl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Mar 2019 01:18:41 -0400
Received: from out3-smtp.messagingengine.com ([66.111.4.27]:42137 "EHLO
        out3-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725805AbfC0FSk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Mar 2019 01:18:40 -0400
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailout.nyi.internal (Postfix) with ESMTP id CE94E22165;
        Wed, 27 Mar 2019 01:18:39 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute3.internal (MEProxy); Wed, 27 Mar 2019 01:18:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:date:from
        :in-reply-to:message-id:mime-version:references:subject:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm2; bh=gqKWtylwm0gNw0hTdJOIxDNpCX0YdD/vmBdRDnc/fAE=; b=EBj+S0Wi
        zdB5dHaBPi59XvobYlwZAcBpwphkRTrDqapUYdzSO8x/A5ynGZVhnEZpzIl4h5hA
        lHESdx4G4bft/V0uvSmwW3gbmRKxq1KQUBRsWmdLWNff+oMz7RiKTFdW/fs39985
        Sfj9NqIE3SdVVhqGwMivh4X7GXGMBGxyNcOW74lCt8JwR2FNhEhVY/w6G3kun04p
        HD+xNojFXHz1xaAaIuBbRzN/wxttgSs4UhR0VPgdPRR4bqBt6TxjjLtinqD2WCk5
        J1uEPv35odGTR58NXh5qtVCtNfMg9PDSI1m2lx1OQiAi70Z8Af14U54VtnQrA6ff
        K29vnxFUkH10Vg==
X-ME-Sender: <xms:rwebXMKn3TTloV-HOIRcGbH6q_6P3RrhJVCX6swV5G1XZ3y9acOFKA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedutddrkedugdektdcutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpefhvffufffkofgjfhgggfestdekredtredttdenucfhrhhomhepfdfvohgsihhn
    ucevrdcujfgrrhguihhnghdfuceothhosghinheskhgvrhhnvghlrdhorhhgqeenucfkph
    epuddvgedrudeiledrudefledrudelvdenucfrrghrrghmpehmrghilhhfrhhomhepthho
    sghinheskhgvrhhnvghlrdhorhhgnecuvehluhhsthgvrhfuihiivgepfe
X-ME-Proxy: <xmx:rwebXHHYIBkv5iM5MbLWJaDCjqmpIBaO9-RgyyGGuSCPECsoDThnAg>
    <xmx:rwebXLskpskoamub4KyF20ezoj5ibm8VGBpi_WH84Bied3n_LJ5IqA>
    <xmx:rwebXOup7yVpBGyCND3AsrC2miTbeyXjcXfBaE8VR1IOu5nLKLraEQ>
    <xmx:rwebXMYraFZRT6T1ZcsIN5MeFjxu6rHPgN3c8K58v-XKl36Vf8xlGQ>
Received: from eros.localdomain (124-169-139-192.dyn.iinet.net.au [124.169.139.192])
        by mail.messagingengine.com (Postfix) with ESMTPA id 40857E415C;
        Wed, 27 Mar 2019 01:18:35 -0400 (EDT)
From:   "Tobin C. Harding" <tobin@kernel.org>
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     "Tobin C. Harding" <tobin@kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Mauro Carvalho Chehab <mchehab@s-opensource.com>,
        Neil Brown <neilb@suse.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        linux-doc@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v3 04/24] fs: Add docstrings to exported functions
Date:   Wed, 27 Mar 2019 16:16:57 +1100
Message-Id: <20190327051717.23225-5-tobin@kernel.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190327051717.23225-1-tobin@kernel.org>
References: <20190327051717.23225-1-tobin@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently exported docstrings for fs/file_table.c are included in
Documentation/filesystems/api-summary.rst.  This is a problem because
there are no docstrings in file_table.c

Add function docstrings for exported functions defined in
fs/file_table.c

Signed-off-by: Tobin C. Harding <tobin@kernel.org>
---
 fs/file_table.c | 21 +++++++++++++++++----
 1 file changed, 17 insertions(+), 4 deletions(-)

diff --git a/fs/file_table.c b/fs/file_table.c
index 5679e7fcb6b0..e3c6966c2d53 100644
--- a/fs/file_table.c
+++ b/fs/file_table.c
@@ -65,8 +65,8 @@ static long get_nr_files(void)
 	return percpu_counter_read_positive(&nr_files);
 }
 
-/*
- * Return the maximum number of open files in the system
+/**
+ * get_max_files() - Get the maximum number of open files in the system.
  */
 unsigned long get_max_files(void)
 {
@@ -178,8 +178,7 @@ struct file *alloc_empty_file_noaccount(int flags, const struct cred *cred)
 }
 
 /**
- * alloc_file - allocate and initialize a 'struct file'
- *
+ * alloc_file() - Allocate and initialize a &struct file.
  * @path: the (dentry, vfsmount) pair for the new file
  * @flags: O_... flags with which the new file will be opened
  * @fop: the 'struct file_operations' for the new file
@@ -210,6 +209,20 @@ static struct file *alloc_file(const struct path *path, int flags,
 	return file;
 }
 
+/**
+ * alloc_file_pseudo() - Allocate a pseudo file.
+ * @inode: The inode to fill in.
+ * @mnt: The vfsmount to use.
+ * @name: Name to used for newly allocated pseudo dentry.
+ * @flags: ``O_...`` flags with which the new file will be opened.
+ * @fops: fops for the new file.
+ *
+ * Allocate a pseudo dentry, fill in @inode information in the dentry
+ * (i.e. instantiate @inode).  Create a &struct path from the dentry and
+ * @mnt.  Allocate a &struct file from the newly created path.
+ *
+ * Return: The newly allocated file or -ENOMEM on error.
+ */
 struct file *alloc_file_pseudo(struct inode *inode, struct vfsmount *mnt,
 				const char *name, int flags,
 				const struct file_operations *fops)
-- 
2.21.0

