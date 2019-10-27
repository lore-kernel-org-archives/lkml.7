Return-Path: <SRS0=Ymnc=YU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ABD40CA9EAF
	for <linux-kernel@archiver.kernel.org>; Sun, 27 Oct 2019 21:26:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7D5BE222BD
	for <linux-kernel@archiver.kernel.org>; Sun, 27 Oct 2019 21:26:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1572211604;
	bh=uPIfQWqLKM5q170ciZ8ZKXKT3PTDtM1DUcLlUr0y/SE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=hggSjrWuIm/ZjUt91Xac38DYNQaImrqqQunApPhR9UCa3LSqlr+2mcj7+liKbE620
	 zmdviuTPkCmxuS+qvlmuW3AqHlbb9CRlG1WVGvag7Q572S7aQEsO5CiVXyTDFUBIrS
	 oOXpN95WXmiQqQvdDG4nskenGQWy+n6zIGDYb1i0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732927AbfJ0V00 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 27 Oct 2019 17:26:26 -0400
Received: from mail.kernel.org ([198.145.29.99]:48328 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732042AbfJ0V0X (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 27 Oct 2019 17:26:23 -0400
Received: from localhost (100.50.158.77.rev.sfr.net [77.158.50.100])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 38A3321D7F;
        Sun, 27 Oct 2019 21:26:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1572211582;
        bh=uPIfQWqLKM5q170ciZ8ZKXKT3PTDtM1DUcLlUr0y/SE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=cqttyMcXbjrAgY5pfRhLB0aJFA1k+movpN7+GmDlXNncBxhmhUhnXKr9tC2SHKWby
         Erp0vYe528cvR4s5hO+IxyhnotAB4c7HKXvrf76pAnzS/yoJtVLUWsGOuEwV0Q6dLF
         9h532M/7RhEjYOZAPIdiRqsgYCW3449qk/nLRfOc=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Nikolay Borisov <nborisov@suse.com>,
        Qu Wenruo <wqu@suse.com>, David Sterba <dsterba@suse.com>
Subject: [PATCH 5.3 186/197] btrfs: tracepoints: Fix wrong parameter order for qgroup events
Date:   Sun, 27 Oct 2019 22:01:44 +0100
Message-Id: <20191027203406.527183420@linuxfoundation.org>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191027203351.684916567@linuxfoundation.org>
References: <20191027203351.684916567@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Qu Wenruo <wqu@suse.com>

commit fd2b007eaec898564e269d1f478a2da0380ecf51 upstream.

[BUG]
For btrfs:qgroup_meta_reserve event, the trace event can output garbage:

  qgroup_meta_reserve: 9c7f6acc-b342-4037-bc47-7f6e4d2232d7: refroot=5(FS_TREE) type=DATA diff=2

The diff should always be alinged to sector size (4k), so there is
definitely something wrong.

[CAUSE]
For the wrong @diff, it's caused by wrong parameter order.
The correct parameters are:

  struct btrfs_root, s64 diff, int type.

However the parameters used are:

  struct btrfs_root, int type, s64 diff.

Fixes: 4ee0d8832c2e ("btrfs: qgroup: Update trace events for metadata reservation")
CC: stable@vger.kernel.org # 4.19+
Reviewed-by: Nikolay Borisov <nborisov@suse.com>
Signed-off-by: Qu Wenruo <wqu@suse.com>
Reviewed-by: David Sterba <dsterba@suse.com>
Signed-off-by: David Sterba <dsterba@suse.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 fs/btrfs/qgroup.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

--- a/fs/btrfs/qgroup.c
+++ b/fs/btrfs/qgroup.c
@@ -3617,7 +3617,7 @@ int __btrfs_qgroup_reserve_meta(struct b
 		return 0;
 
 	BUG_ON(num_bytes != round_down(num_bytes, fs_info->nodesize));
-	trace_qgroup_meta_reserve(root, type, (s64)num_bytes);
+	trace_qgroup_meta_reserve(root, (s64)num_bytes, type);
 	ret = qgroup_reserve(root, num_bytes, enforce, type);
 	if (ret < 0)
 		return ret;
@@ -3664,7 +3664,7 @@ void __btrfs_qgroup_free_meta(struct btr
 	 */
 	num_bytes = sub_root_meta_rsv(root, num_bytes, type);
 	BUG_ON(num_bytes != round_down(num_bytes, fs_info->nodesize));
-	trace_qgroup_meta_reserve(root, type, -(s64)num_bytes);
+	trace_qgroup_meta_reserve(root, -(s64)num_bytes, type);
 	btrfs_qgroup_free_refroot(fs_info, root->root_key.objectid,
 				  num_bytes, type);
 }


