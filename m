Return-Path: <SRS0=Pa1K=VP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9C882C76186
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Jul 2019 03:18:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 682C92173E
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Jul 2019 03:18:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1563419928;
	bh=jptCgE6YTWSDNGmTq9kec/vLT5xnPBTD+yccwxKhFcA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=RutpeNgxIWa4xgAyk1cjY4y5V7/rzv2bmsl4rVWq2E2wZopTsRMhfNAhikrVIBSsR
	 R8YtsE5cz8rmfG9yV+wpRCt1xHKPL+grAjp+8do9BO9HIDHaMY+uxZ+lmqo+ZjIpsh
	 UiGTNngPlTEY1BRkG4s5Q2j4ZQSGAPuXGOk/RTUs=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391482AbfGRDMo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Jul 2019 23:12:44 -0400
Received: from mail.kernel.org ([198.145.29.99]:47242 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2391459AbfGRDMi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Jul 2019 23:12:38 -0400
Received: from localhost (115.42.148.210.bf.2iij.net [210.148.42.115])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 584552077C;
        Thu, 18 Jul 2019 03:12:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1563419557;
        bh=jptCgE6YTWSDNGmTq9kec/vLT5xnPBTD+yccwxKhFcA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=dLTAsZVVlHal6rA/A3jgjAWES+OUAvW7hwrT+PbJ55JcvmU7OCj/Nj4t9sBmOkKYE
         AicZYF3H6+S6ID/5GJWJq88LRoXvXhKZpX7NNd9Dm/nt/s2xUPPcWdpexdLqGo1d6E
         P7lvjRWppZY+WlazMF4569JwBHKNFsiG2VY+zvjw=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Hongjie Fang <hongjiefang@asrmicro.com>,
        Eric Biggers <ebiggers@google.com>
Subject: [PATCH 4.9 27/54] fscrypt: dont set policy for a dead directory
Date:   Thu, 18 Jul 2019 12:01:57 +0900
Message-Id: <20190718030051.512374141@linuxfoundation.org>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20190718030048.392549994@linuxfoundation.org>
References: <20190718030048.392549994@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Hongjie Fang <hongjiefang@asrmicro.com>

commit 5858bdad4d0d0fc18bf29f34c3ac836e0b59441f upstream.

The directory may have been removed when entering
fscrypt_ioctl_set_policy().  If so, the empty_dir() check will return
error for ext4 file system.

ext4_rmdir() sets i_size = 0, then ext4_empty_dir() reports an error
because 'inode->i_size < EXT4_DIR_REC_LEN(1) + EXT4_DIR_REC_LEN(2)'.  If
the fs is mounted with errors=panic, it will trigger a panic issue.

Add the check IS_DEADDIR() to fix this problem.

Fixes: 9bd8212f981e ("ext4 crypto: add encryption policy and password salt support")
Cc: <stable@vger.kernel.org> # v4.1+
Signed-off-by: Hongjie Fang <hongjiefang@asrmicro.com>
Signed-off-by: Eric Biggers <ebiggers@google.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 fs/crypto/policy.c |    2 ++
 1 file changed, 2 insertions(+)

--- a/fs/crypto/policy.c
+++ b/fs/crypto/policy.c
@@ -114,6 +114,8 @@ int fscrypt_process_policy(struct file *
 	if (!inode_has_encryption_context(inode)) {
 		if (!S_ISDIR(inode->i_mode))
 			ret = -ENOTDIR;
+		else if (IS_DEADDIR(inode))
+			ret = -ENOENT;
 		else if (!inode->i_sb->s_cop->empty_dir)
 			ret = -EOPNOTSUPP;
 		else if (!inode->i_sb->s_cop->empty_dir(inode))


