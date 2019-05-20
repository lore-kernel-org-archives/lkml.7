Return-Path: <SRS0=lq4r=TU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B30A1C04AAC
	for <linux-kernel@archiver.kernel.org>; Mon, 20 May 2019 12:23:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8A12221019
	for <linux-kernel@archiver.kernel.org>; Mon, 20 May 2019 12:23:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1558355035;
	bh=WupPEC+hMOVZof/t7zKnzKz3HLKKT+Ri07zHZ5ruEwI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=pBNwsPls9hSgpZZ6B8+8zDEz3TKabvtFdQfEUr/VR5J1DN8Efy+FQjn4Jg9x4/QVW
	 qtM1GhluaVIctVylCebfCJcQL4gtPqhH6In44LybZJjhackCv/N9FY4hZRsKdGxzqu
	 VmyTUH0G8MDz5eAlhAJrok60TSXR8xt41LzNNzgg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388713AbfETMXy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 May 2019 08:23:54 -0400
Received: from mail.kernel.org ([198.145.29.99]:38592 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388700AbfETMXx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 May 2019 08:23:53 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 023A321019;
        Mon, 20 May 2019 12:23:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1558355032;
        bh=WupPEC+hMOVZof/t7zKnzKz3HLKKT+Ri07zHZ5ruEwI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=D5hSu/fQFxK5em0xTVJVSc1xPBWKLA3F1zwQDx0HuDKA4nt//Y7XieWpw6NnVmN1X
         RY5Ge7A1dFy8hurGgIPGVNhrBGsDbMwHWuTsyp+vYLwSLZWq9IWgq8UFtL/uFB9dg6
         HVTIi2T0Zj+MAJxk0Gz/OtWHxvlzente1JQ/Za0g=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Kirill Tkhai <ktkhai@virtuozzo.com>,
        Theodore Tso <tytso@mit.edu>, Jan Kara <jack@suse.cz>,
        stable@kernel.org
Subject: [PATCH 4.19 071/105] ext4: actually request zeroing of inode table after grow
Date:   Mon, 20 May 2019 14:14:17 +0200
Message-Id: <20190520115252.087715801@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190520115247.060821231@linuxfoundation.org>
References: <20190520115247.060821231@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Kirill Tkhai <ktkhai@virtuozzo.com>

commit 310a997fd74de778b9a4848a64be9cda9f18764a upstream.

It is never possible, that number of block groups decreases,
since only online grow is supported.

But after a growing occured, we have to zero inode tables
for just created new block groups.

Fixes: 19c5246d2516 ("ext4: add new online resize interface")
Signed-off-by: Kirill Tkhai <ktkhai@virtuozzo.com>
Signed-off-by: Theodore Ts'o <tytso@mit.edu>
Reviewed-by: Jan Kara <jack@suse.cz>
Cc: stable@kernel.org
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 fs/ext4/ioctl.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/fs/ext4/ioctl.c
+++ b/fs/ext4/ioctl.c
@@ -977,7 +977,7 @@ mext_out:
 		if (err == 0)
 			err = err2;
 		mnt_drop_write_file(filp);
-		if (!err && (o_group > EXT4_SB(sb)->s_groups_count) &&
+		if (!err && (o_group < EXT4_SB(sb)->s_groups_count) &&
 		    ext4_has_group_desc_csum(sb) &&
 		    test_opt(sb, INIT_INODE_TABLE))
 			err = ext4_register_li_request(sb, o_group);


