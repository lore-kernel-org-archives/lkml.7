Return-Path: <SRS0=lq4r=TU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5B539C04AAC
	for <linux-kernel@archiver.kernel.org>; Mon, 20 May 2019 12:35:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 30D59216C4
	for <linux-kernel@archiver.kernel.org>; Mon, 20 May 2019 12:35:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1558355755;
	bh=gjf+mOszHMrKvbqtvIw9132vFb8gT0KeTwcDppoOEo0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=CaQEFuAk1lG02rnIhtD1Y29uG1C2ZSoGfs7oUy13OOTRg1ckX31gLTdkeVN6623VG
	 bulI8Mq6m9aUn2cyJG1ukbvXwJp9lMEuwPOldfWEIsAsM8mEvB62jJq+IFWpVWAcW+
	 9lxA+mQ8b5ynKGEP0pFPzq48Jt0mU+KKV1gb0ug8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391173AbfETMfy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 May 2019 08:35:54 -0400
Received: from mail.kernel.org ([198.145.29.99]:54662 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2391147AbfETMfw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 May 2019 08:35:52 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3B187204FD;
        Mon, 20 May 2019 12:35:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1558355751;
        bh=gjf+mOszHMrKvbqtvIw9132vFb8gT0KeTwcDppoOEo0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=AYIpfCmfiJbgnGbAjfB/EucQTGs70L0TXV83zLxs5vZROAZ56cBrrgmZc/Vryh0kf
         RTMt8RnF6J1iN9Xr/DUcUm8HR6Qo7VAIq7aOUHmdO1gWO0QHxNSH2d/A8YjsmV7XXH
         30Mqs6IPTtuRcMGPEv9bdgnSewhoqv1HkxMT0HnA=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Jan Kara <jack@suse.cz>,
        Theodore Tso <tytso@mit.edu>, stable@kernel.org
Subject: [PATCH 5.1 085/128] ext4: make sanity check in mballoc more strict
Date:   Mon, 20 May 2019 14:14:32 +0200
Message-Id: <20190520115255.270881756@linuxfoundation.org>
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

From: Jan Kara <jack@suse.cz>

commit 31562b954b60f02acb91b7349dc6432d3f8c3c5f upstream.

The sanity check in mb_find_extent() only checked that returned extent
does not extend past blocksize * 8, however it should not extend past
EXT4_CLUSTERS_PER_GROUP(sb). This can happen when clusters_per_group <
blocksize * 8 and the tail of the bitmap is not properly filled by 1s
which happened e.g. when ancient kernels have grown the filesystem.

Signed-off-by: Jan Kara <jack@suse.cz>
Signed-off-by: Theodore Ts'o <tytso@mit.edu>
Cc: stable@kernel.org
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 fs/ext4/mballoc.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/fs/ext4/mballoc.c
+++ b/fs/ext4/mballoc.c
@@ -1539,7 +1539,7 @@ static int mb_find_extent(struct ext4_bu
 		ex->fe_len += 1 << order;
 	}
 
-	if (ex->fe_start + ex->fe_len > (1 << (e4b->bd_blkbits + 3))) {
+	if (ex->fe_start + ex->fe_len > EXT4_CLUSTERS_PER_GROUP(e4b->bd_sb)) {
 		/* Should never happen! (but apparently sometimes does?!?) */
 		WARN_ON(1);
 		ext4_error(e4b->bd_sb, "corruption or bug in mb_find_extent "


