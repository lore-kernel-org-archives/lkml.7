Return-Path: <SRS0=vISB=2T=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B5110C2D0D1
	for <linux-kernel@archiver.kernel.org>; Sun, 29 Dec 2019 17:42:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8656820718
	for <linux-kernel@archiver.kernel.org>; Sun, 29 Dec 2019 17:42:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1577641377;
	bh=xbbPQPdnsaFtaUiVDO0KG1kyte/ZkD8kzcZcd4Sv2t8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=JVmAhd2bsXJhbCshH9+J6zZ5yra4tu967g06+Na4eFIqusokTPq8DnuFbOKKs2jsW
	 goRf5uMorD3E71EbDwXYsg1o+Xok3gqmuuETgkbE1b5sblbmvcqmzR31pccxmhXbgx
	 UZCAYp3QzZZ8UnW5es7w7/ub8e/nKGSjIgvhtDgs=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730387AbfL2Rm4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 29 Dec 2019 12:42:56 -0500
Received: from mail.kernel.org ([198.145.29.99]:49472 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730367AbfL2Rmu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 29 Dec 2019 12:42:50 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C11AF207FD;
        Sun, 29 Dec 2019 17:42:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1577641370;
        bh=xbbPQPdnsaFtaUiVDO0KG1kyte/ZkD8kzcZcd4Sv2t8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=T96afz5d+3fUzN5p/DGdg6uMuivBmLzXDGbNKOh2rpmKQs5txp0ZdbBvtXBnIyo/w
         /IavpsIw1NSICQSlJ0Z3e4KTp7cxMolFZhblloWfUuSCGqbIJZnUoOnwj+J87wf/fv
         EB6uYw4HiYheDb1uhgB+agQA+Uz8ok5yDkzw6+e4=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Filipe Manana <fdmanana@suse.com>,
        Johannes Thumshirn <jthumshirn@suse.de>,
        Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>
Subject: [PATCH 5.4 037/434] btrfs: handle ENOENT in btrfs_uuid_tree_iterate
Date:   Sun, 29 Dec 2019 18:21:30 +0100
Message-Id: <20191229172704.504531654@linuxfoundation.org>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20191229172702.393141737@linuxfoundation.org>
References: <20191229172702.393141737@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Josef Bacik <josef@toxicpanda.com>

commit 714cd3e8cba6841220dce9063a7388a81de03825 upstream.

If we get an -ENOENT back from btrfs_uuid_iter_rem when iterating the
uuid tree we'll just continue and do btrfs_next_item().  However we've
done a btrfs_release_path() at this point and no longer have a valid
path.  So increment the key and go back and do a normal search.

CC: stable@vger.kernel.org # 4.4+
Reviewed-by: Filipe Manana <fdmanana@suse.com>
Reviewed-by: Johannes Thumshirn <jthumshirn@suse.de>
Signed-off-by: Josef Bacik <josef@toxicpanda.com>
Reviewed-by: David Sterba <dsterba@suse.com>
Signed-off-by: David Sterba <dsterba@suse.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 fs/btrfs/uuid-tree.c |    2 ++
 1 file changed, 2 insertions(+)

--- a/fs/btrfs/uuid-tree.c
+++ b/fs/btrfs/uuid-tree.c
@@ -324,6 +324,8 @@ again_search_slot:
 				}
 				if (ret < 0 && ret != -ENOENT)
 					goto out;
+				key.offset++;
+				goto again_search_slot;
 			}
 			item_size -= sizeof(subid_le);
 			offset += sizeof(subid_le);


