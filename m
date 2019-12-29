Return-Path: <SRS0=vISB=2T=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE8ACC2D0CE
	for <linux-kernel@archiver.kernel.org>; Sun, 29 Dec 2019 17:28:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A02A420409
	for <linux-kernel@archiver.kernel.org>; Sun, 29 Dec 2019 17:28:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1577640504;
	bh=xbbPQPdnsaFtaUiVDO0KG1kyte/ZkD8kzcZcd4Sv2t8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=GuN+3NzgpRd26cYFEuvvmN7I1Gosog8UAHQN3xqAsjO+2V2LL5UW5w56zlMzbPM9S
	 jCegaKKhyew+vywHwy/W2MRO6V5it2nG9oHDEec7iW6+KTZozYTPfO04UpcCBEF3er
	 T6rrwk5pvvdNKarqeO2+JO7dtLLjtfBJJdKiZxJE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728582AbfL2R2X (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 29 Dec 2019 12:28:23 -0500
Received: from mail.kernel.org ([198.145.29.99]:51652 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728282AbfL2R2V (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 29 Dec 2019 12:28:21 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 149D320409;
        Sun, 29 Dec 2019 17:28:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1577640500;
        bh=xbbPQPdnsaFtaUiVDO0KG1kyte/ZkD8kzcZcd4Sv2t8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=1f80Gpf15zZGXiew+3d6qfRwtZMPnwYACXIIFtoMnKcnMzE0Fv0x3My7d8hlGS0Ht
         x1BG9QNosKMShwCEP7nC6tFBPb2O0zuLFNFejJutHyHDra6cXBdm9pQToRjt67uNHo
         mv+29fmW/0CwSh7/KMR2XrZ9OeRcSIZy4W8LJEog=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Filipe Manana <fdmanana@suse.com>,
        Johannes Thumshirn <jthumshirn@suse.de>,
        Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>
Subject: [PATCH 4.19 021/219] btrfs: handle ENOENT in btrfs_uuid_tree_iterate
Date:   Sun, 29 Dec 2019 18:17:03 +0100
Message-Id: <20191229162512.198858037@linuxfoundation.org>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20191229162508.458551679@linuxfoundation.org>
References: <20191229162508.458551679@linuxfoundation.org>
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


