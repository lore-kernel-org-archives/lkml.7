Return-Path: <SRS0=lq4r=TU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF7ABC04AAC
	for <linux-kernel@archiver.kernel.org>; Mon, 20 May 2019 12:36:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A182F20815
	for <linux-kernel@archiver.kernel.org>; Mon, 20 May 2019 12:36:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1558355805;
	bh=wftdP+bcB8N5/08oAw9aWqUvzWDJItRf/5W8fKgiDR8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=ohMStXL8lStuSbJzoWYX27ESVLLaqcfaBfRqCTalbyec+xjtY5MFkO5Z6yijfgYjX
	 aE1a/ouLESYn3fXhwrWx/0RLvGzjXYYOsUvYcvj/IAWZdevs5NsNUHR7PLRLvfbP9c
	 WRC5lvrxwKCV9wSxJRFDKJnKyGpAVaECB7CLiUf0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2403890AbfETMgk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 May 2019 08:36:40 -0400
Received: from mail.kernel.org ([198.145.29.99]:55656 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2403876AbfETMgf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 May 2019 08:36:35 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id DBAD0204FD;
        Mon, 20 May 2019 12:36:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1558355794;
        bh=wftdP+bcB8N5/08oAw9aWqUvzWDJItRf/5W8fKgiDR8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=hIRrBU7YfJaADhlDzfQ12S5/9h/v89MFRKY8NwvCyvhws590A0m0+Vj2pUBtqiTLB
         +CNslXcVcCipLp+wz4TjHkZdksxUqGjsVHriAuZ3YfZoOZgzVUYN3l6FurJ76mmIK7
         WZt03cI2Vn4ePT3EjcjplhZOyx1n+qN1Eyqj46EA=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Theodore Tso <tytso@mit.edu>,
        stable@kernel.org
Subject: [PATCH 5.1 087/128] ext4: ignore e_value_offs for xattrs with value-in-ea-inode
Date:   Mon, 20 May 2019 14:14:34 +0200
Message-Id: <20190520115255.349328649@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190520115249.449077487@linuxfoundation.org>
References: <20190520115249.449077487@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Theodore Ts'o <tytso@mit.edu>

commit e5d01196c0428a206f307e9ee5f6842964098ff0 upstream.

In other places in fs/ext4/xattr.c, if e_value_inum is non-zero, the
code ignores the value in e_value_offs.  The e_value_offs *should* be
zero, but we shouldn't depend upon it, since it might not be true in a
corrupted/fuzzed file system.

Bugzilla: https://bugzilla.kernel.org/show_bug.cgi?id=202897
Bugzilla: https://bugzilla.kernel.org/show_bug.cgi?id=202877
Signed-off-by: Theodore Ts'o <tytso@mit.edu>
Cc: stable@kernel.org
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 fs/ext4/xattr.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/fs/ext4/xattr.c
+++ b/fs/ext4/xattr.c
@@ -1696,7 +1696,7 @@ static int ext4_xattr_set_entry(struct e
 
 	/* No failures allowed past this point. */
 
-	if (!s->not_found && here->e_value_size && here->e_value_offs) {
+	if (!s->not_found && here->e_value_size && !here->e_value_inum) {
 		/* Remove the old value. */
 		void *first_val = s->base + min_offs;
 		size_t offs = le16_to_cpu(here->e_value_offs);


