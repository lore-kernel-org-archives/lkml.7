Return-Path: <SRS0=lq4r=TU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 818B6C04E87
	for <linux-kernel@archiver.kernel.org>; Mon, 20 May 2019 12:20:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 48DFB20815
	for <linux-kernel@archiver.kernel.org>; Mon, 20 May 2019 12:20:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1558354814;
	bh=SgXpXZq9XtdhF8LXnJ1SB4sVb3RKPlH5SPcOkCu6N1g=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=sjXOa/ewLX0rdp9V7huZqkbapmrpovWrGf/948n5zZZ12yEdIndYw9056IdQhgLeP
	 hccfZO3pe1JKD6ZxFbNbsvHq3o120wtoOljVpQt2cguRFPllMZGw8o8CAa01cbVm/o
	 0K4DmE9gkq43odzVzBwXL6mculn4NdeUzqq5p5nQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387953AbfETMUN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 May 2019 08:20:13 -0400
Received: from mail.kernel.org ([198.145.29.99]:33512 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730449AbfETMUL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 May 2019 08:20:11 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 18ED620656;
        Mon, 20 May 2019 12:20:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1558354810;
        bh=SgXpXZq9XtdhF8LXnJ1SB4sVb3RKPlH5SPcOkCu6N1g=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=0oLJwQTNw/AApYFDcgF7P9g7jZwjc8EejCAQrWin+tvEBB9OLZQylI7OhFhKE3VQn
         ePCVDIxEknLEfO0gUBPfYfzrSQfT+qjQ63DscO+LTIf8VYNpfCKPXuVG4Ge3PPfuQu
         jHz7ceWTxPFq3GAov8HARGFB+d3V/nSY2g71G208=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Debabrata Banerjee <dbanerje@akamai.com>,
        Theodore Tso <tytso@mit.edu>, Jan Kara <jack@suse.cz>,
        stable@kernel.org
Subject: [PATCH 4.14 50/63] ext4: fix ext4_show_options for file systems w/o journal
Date:   Mon, 20 May 2019 14:14:29 +0200
Message-Id: <20190520115236.563016206@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190520115231.137981521@linuxfoundation.org>
References: <20190520115231.137981521@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Debabrata Banerjee <dbanerje@akamai.com>

commit 50b29d8f033a7c88c5bc011abc2068b1691ab755 upstream.

Instead of removing EXT4_MOUNT_JOURNAL_CHECKSUM from s_def_mount_opt as
I assume was intended, all other options were blown away leading to
_ext4_show_options() output being incorrect.

Fixes: 1e381f60dad9 ("ext4: do not allow journal_opts for fs w/o journal")
Signed-off-by: Debabrata Banerjee <dbanerje@akamai.com>
Signed-off-by: Theodore Ts'o <tytso@mit.edu>
Reviewed-by: Jan Kara <jack@suse.cz>
Cc: stable@kernel.org
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 fs/ext4/super.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/fs/ext4/super.c
+++ b/fs/ext4/super.c
@@ -4209,7 +4209,7 @@ static int ext4_fill_super(struct super_
 				 "data=, fs mounted w/o journal");
 			goto failed_mount_wq;
 		}
-		sbi->s_def_mount_opt &= EXT4_MOUNT_JOURNAL_CHECKSUM;
+		sbi->s_def_mount_opt &= ~EXT4_MOUNT_JOURNAL_CHECKSUM;
 		clear_opt(sb, JOURNAL_CHECKSUM);
 		clear_opt(sb, DATA_FLAGS);
 		sbi->s_journal = NULL;


