Return-Path: <SRS0=Tfva=ZZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BFDFEC432C0
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Dec 2019 22:38:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8FAAA2080F
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Dec 2019 22:38:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1575412739;
	bh=IC6o68mrLdx4mysFXDFXgdZP+YGES3DYn46twtdjoEg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=zNOPZW4l4UlxprJ5EJPxViwfMhD5Z2qJOw0Cf7N8+NIOOLrKwTjSpxu2lMXATFZd1
	 st7ScRtnNR7+9ly97zGBEgjj80QuNixW9ZyN+oQs4xyRjiXebAS0MvD0hqcKZQ0e9L
	 i/opwJkJpqsa6uDshkp3oVM46hJF4OigGwAkLDpM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728108AbfLCWi6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Dec 2019 17:38:58 -0500
Received: from mail.kernel.org ([198.145.29.99]:48600 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728097AbfLCWiz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Dec 2019 17:38:55 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6A6BB20863;
        Tue,  3 Dec 2019 22:38:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1575412734;
        bh=IC6o68mrLdx4mysFXDFXgdZP+YGES3DYn46twtdjoEg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=X/jGHXz7Tkrc/xgNH9cAEX1HqNIZ4NsgPzzwZ7KELSwIQCudpTkNUQPgfV9XMjL32
         bUNx7Tnjv0JXshuHArqBKYTpWdBJIId8Qt8n5C/sZoUz3XoVG2XtfLpO7Cck38HFE2
         zPlvjD+BkuIsMKTDhQBJ15EIdVR3nRzpoGMHI+A4=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Hou Tao <houtao1@huawei.com>,
        Joel Stanley <joel@jms.id.au>,
        Richard Weinberger <richard@nod.at>
Subject: [PATCH 5.4 42/46] Revert "jffs2: Fix possible null-pointer dereferences in jffs2_add_frag_to_fragtree()"
Date:   Tue,  3 Dec 2019 23:36:02 +0100
Message-Id: <20191203212805.427358245@linuxfoundation.org>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20191203212705.175425505@linuxfoundation.org>
References: <20191203212705.175425505@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Joel Stanley <joel@jms.id.au>

commit 6e78c01fde9023e0701f3af880c1fd9de6e4e8e3 upstream.

This reverts commit f2538f999345405f7d2e1194c0c8efa4e11f7b3a. The patch
stopped JFFS2 from being able to mount an existing filesystem with the
following errors:

 jffs2: error: (77) jffs2_build_inode_fragtree: Add node to tree failed -22
 jffs2: error: (77) jffs2_do_read_inode_internal: Failed to build final fragtree for inode #5377: error -22

Fixes: f2538f999345 ("jffs2: Fix possible null-pointer dereferences...")
Cc: stable@vger.kernel.org
Suggested-by: Hou Tao <houtao1@huawei.com>
Signed-off-by: Joel Stanley <joel@jms.id.au>
Signed-off-by: Richard Weinberger <richard@nod.at>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 fs/jffs2/nodelist.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/fs/jffs2/nodelist.c
+++ b/fs/jffs2/nodelist.c
@@ -226,7 +226,7 @@ static int jffs2_add_frag_to_fragtree(st
 		lastend = this->ofs + this->size;
 	} else {
 		dbg_fragtree2("lookup gave no frag\n");
-		return -EINVAL;
+		lastend = 0;
 	}
 
 	/* See if we ran off the end of the fragtree */


