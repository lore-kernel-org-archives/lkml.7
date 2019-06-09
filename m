Return-Path: <SRS0=y5Xy=UI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,T_DKIMWL_WL_HIGH,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E32F9C28EBD
	for <linux-kernel@archiver.kernel.org>; Sun,  9 Jun 2019 17:14:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AF27020652
	for <linux-kernel@archiver.kernel.org>; Sun,  9 Jun 2019 17:14:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1560100496;
	bh=FXS8WI2RweHxP3Xjj2QUuPxNXwAlOtldatPW632lTIs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=KY03TKuV+bZ0oL4xgW7DpVCT29kRh4Ue4FWi903oGJ5TisljoNJIftzgTgOl8DRem
	 1wmhZ5YvKd0NeESQEtGmJRauIPAanVNYtufnb42Xm4BZmbmc29YrO3IFYm9MWl/Ki1
	 BBa0c7DgK2FsxzIFVFiJmdJPAi/MpnUM0F66G1XA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733070AbfFIRO4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 9 Jun 2019 13:14:56 -0400
Received: from mail.kernel.org ([198.145.29.99]:58434 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732894AbfFIQ4D (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 9 Jun 2019 12:56:03 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id CC211204EC;
        Sun,  9 Jun 2019 16:56:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1560099363;
        bh=FXS8WI2RweHxP3Xjj2QUuPxNXwAlOtldatPW632lTIs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=cF/z5XgM5ifS+jIYjCmOCnm5oszxHVWJcb5Uwh0jxyT7Rxj1rsD0oSAEdq455e71j
         H1QfvJsIcfrIDp3Ghr3OoXcL+p0V2wq1fIkc39zjnLXtbD1KXoJcA5lVzzRTP99eWy
         PzcbobORMyn2NaQ+f7Te+pbXE9wym6I7qLWfyzns=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Kirill Tkhai <ktkhai@virtuozzo.com>,
        Theodore Tso <tytso@mit.edu>, Jan Kara <jack@suse.cz>,
        stable@kernel.org
Subject: [PATCH 4.4 016/241] ext4: actually request zeroing of inode table after grow
Date:   Sun,  9 Jun 2019 18:39:18 +0200
Message-Id: <20190609164148.254365954@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190609164147.729157653@linuxfoundation.org>
References: <20190609164147.729157653@linuxfoundation.org>
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
@@ -577,7 +577,7 @@ group_add_out:
 		if (err == 0)
 			err = err2;
 		mnt_drop_write_file(filp);
-		if (!err && (o_group > EXT4_SB(sb)->s_groups_count) &&
+		if (!err && (o_group < EXT4_SB(sb)->s_groups_count) &&
 		    ext4_has_group_desc_csum(sb) &&
 		    test_opt(sb, INIT_INODE_TABLE))
 			err = ext4_register_li_request(sb, o_group);


