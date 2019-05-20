Return-Path: <SRS0=lq4r=TU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 742FFC04AAC
	for <linux-kernel@archiver.kernel.org>; Mon, 20 May 2019 12:23:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4B337214DA
	for <linux-kernel@archiver.kernel.org>; Mon, 20 May 2019 12:23:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1558355032;
	bh=cuCka6+D/zHu/Ia0WcLVoONDemKDc45zUEKXJ1Ae6fM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=ar4JUmvLJZwgz4JUWfRTPL77rlIPdhHgC9ttMEtaJ6kP2wkE6S7pDxvBIOJPdK0pC
	 7mPMb1hOXn+BxmWhyOFqKwJ00z0xmjs5Ht7huZ263r77WzQ1IFknESBJXBSGoSl5kU
	 30O2UUbBlmHFfgNzjLwEa3xNPY9nqIAQyhuUgIIs=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388699AbfETMXv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 May 2019 08:23:51 -0400
Received: from mail.kernel.org ([198.145.29.99]:38410 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388680AbfETMXr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 May 2019 08:23:47 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C627621019;
        Mon, 20 May 2019 12:23:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1558355027;
        bh=cuCka6+D/zHu/Ia0WcLVoONDemKDc45zUEKXJ1Ae6fM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=HzOX4XVUiVWTMKT2f+CSVqnGUgvBa2X+t7dQkKpbhcI0NFbqxiUoy14i5lLCX8tpM
         3Olnjl38M0d8U1He1Dh+1eijLfYkJWIWRZCJ21jfJG9KwrCev+vZ+wrMiJQ+80CmCl
         glBRa44gJ0/s53tKefjmSZet/ASQAQS/OnC7ZdLk=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Pan Bian <bianpan2016@163.com>,
        Theodore Tso <tytso@mit.edu>, Jan Kara <jack@suse.cz>,
        stable@kernel.org
Subject: [PATCH 4.19 069/105] ext4: avoid drop reference to iloc.bh twice
Date:   Mon, 20 May 2019 14:14:15 +0200
Message-Id: <20190520115251.952565717@linuxfoundation.org>
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

From: Pan Bian <bianpan2016@163.com>

commit 8c380ab4b7b59c0c602743810be1b712514eaebc upstream.

The reference to iloc.bh has been dropped in ext4_mark_iloc_dirty.
However, the reference is dropped again if error occurs during
ext4_handle_dirty_metadata, which may result in use-after-free bugs.

Fixes: fb265c9cb49e("ext4: add ext4_sb_bread() to disambiguate ENOMEM cases")
Signed-off-by: Pan Bian <bianpan2016@163.com>
Signed-off-by: Theodore Ts'o <tytso@mit.edu>
Reviewed-by: Jan Kara <jack@suse.cz>
Cc: stable@kernel.org
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 fs/ext4/resize.c |    1 +
 1 file changed, 1 insertion(+)

--- a/fs/ext4/resize.c
+++ b/fs/ext4/resize.c
@@ -874,6 +874,7 @@ static int add_new_gdb(handle_t *handle,
 	err = ext4_handle_dirty_metadata(handle, NULL, gdb_bh);
 	if (unlikely(err)) {
 		ext4_std_error(sb, err);
+		iloc.bh = NULL;
 		goto errout;
 	}
 	brelse(dind);


