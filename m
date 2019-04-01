Return-Path: <SRS0=/BGd=SD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 712CEC43381
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Apr 2019 17:08:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 40E422192C
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Apr 2019 17:08:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1554138520;
	bh=mBUODOQfe0hLpDZ4iVbEHDzmNwaDLTTkXeixK94KC0U=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=BtXm5t6NneGvDkwrWl+DjssLtCCXNI31eUjId69gYVXu19MfIuMkHBnstHe46BpLG
	 /oxU1YQKRV7MmvNslFcuCJjf0SKOEfrsbEvpDhyu8pA2A14SlJD2M6EJKU9A1lhP59
	 jiuZ20octSbGWIi16unTckcWbZSmYDhyJvaaE150=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729670AbfDARIj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Apr 2019 13:08:39 -0400
Received: from mail.kernel.org ([198.145.29.99]:55302 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728947AbfDARIh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Apr 2019 13:08:37 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5B8A82192C;
        Mon,  1 Apr 2019 17:08:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1554138516;
        bh=mBUODOQfe0hLpDZ4iVbEHDzmNwaDLTTkXeixK94KC0U=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=tbrG3pXTy0mvYbe4UDi4FjjXfdQ8Em3KyKY1yBIWhtm7GOu93O0yPe4Y5EcEf1cZH
         eBKWeM3t/ngP/yujd/TZ+YXCJSVmDF2kM80/O3ck4Hoo1roWwvD3kX5Dhl0M66lR9g
         x6sHSWWFkJuc+IuT2wENmpoEqeq9WRowOULlaQcQ=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Qu Wenruo <wqu@suse.com>,
        Nikolay Borisov <nborisov@suse.com>,
        David Sterba <dsterba@suse.com>
Subject: [PATCH 5.0 042/146] btrfs: Fix bound checking in qgroup_trace_new_subtree_blocks
Date:   Mon,  1 Apr 2019 19:00:54 +0200
Message-Id: <20190401170052.086443431@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190401170048.449559024@linuxfoundation.org>
References: <20190401170048.449559024@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

5.0-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Nikolay Borisov <nborisov@suse.com>

commit 7ff2c2a1a71e83f74574b8001ea88deb3c166ad7 upstream.

If 'cur_level' is 7  then the bound checking at the top of the function
will actually pass. Later on, it's possible to dereference
ds_path->nodes[cur_level+1] which will be an out of bounds.

The correct check will be cur_level >= BTRFS_MAX_LEVEL - 1 .

Fixes-coverty-id: 1440918
Fixes-coverty-id: 1440911
Fixes: ea49f3e73c4b ("btrfs: qgroup: Introduce function to find all new tree blocks of reloc tree")
CC: stable@vger.kernel.org # 4.20+
Reviewed-by: Qu Wenruo <wqu@suse.com>
Signed-off-by: Nikolay Borisov <nborisov@suse.com>
Reviewed-by: David Sterba <dsterba@suse.com>
Signed-off-by: David Sterba <dsterba@suse.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 fs/btrfs/qgroup.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

--- a/fs/btrfs/qgroup.c
+++ b/fs/btrfs/qgroup.c
@@ -1917,8 +1917,8 @@ static int qgroup_trace_new_subtree_bloc
 	int i;
 
 	/* Level sanity check */
-	if (cur_level < 0 || cur_level >= BTRFS_MAX_LEVEL ||
-	    root_level < 0 || root_level >= BTRFS_MAX_LEVEL ||
+	if (cur_level < 0 || cur_level >= BTRFS_MAX_LEVEL - 1 ||
+	    root_level < 0 || root_level >= BTRFS_MAX_LEVEL - 1 ||
 	    root_level < cur_level) {
 		btrfs_err_rl(fs_info,
 			"%s: bad levels, cur_level=%d root_level=%d",


