Return-Path: <SRS0=6dNS=X4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9119AC32792
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Oct 2019 16:06:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5563B222C7
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Oct 2019 16:06:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1570118781;
	bh=nO2aNFFt/QWhOfK1FnH2b9iLK+//n70ngPK3pltsN9o=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=GiZGn+o+tg/ZArT/LI2B+jb4MXQ8VORndtaQDhf0P+y0j3tfSurLOb7mA8E1x07Hw
	 N5FIPJnmzPzfOOBWIumwDTPmsIMCS9c4U7K57FJohQUxcMp02nteRsq8dJq6R+zoiT
	 nsZlQUcMyJ5a4xDtmbKAlvYnKpxu5dt+hSOsb72s=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732732AbfJCQGU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 3 Oct 2019 12:06:20 -0400
Received: from mail.kernel.org ([198.145.29.99]:53472 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729741AbfJCQGS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Oct 2019 12:06:18 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id F021620865;
        Thu,  3 Oct 2019 16:06:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1570118777;
        bh=nO2aNFFt/QWhOfK1FnH2b9iLK+//n70ngPK3pltsN9o=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Ca4LuEpq6jPj6+Nhz4P4kiL69NKBvT7O33JDiBH5Saw4gRaRpwvFRSSTzagwz/NWm
         EszzaHIwcxzYh0dhW9JeanjFPNsA1p1R1nI8N3V52Udj9LQUw+mDxEk5tJf16hemWw
         SzxuNKdVMgjQXpa101jAwERncL6uuWwRfShFOBpk=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Rakesh Pandit <rakesh@tuxera.com>,
        Theodore Tso <tytso@mit.edu>, stable@kernel.org
Subject: [PATCH 4.9 121/129] ext4: fix warning inside ext4_convert_unwritten_extents_endio
Date:   Thu,  3 Oct 2019 17:54:04 +0200
Message-Id: <20191003154415.470175875@linuxfoundation.org>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191003154318.081116689@linuxfoundation.org>
References: <20191003154318.081116689@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Rakesh Pandit <rakesh@tuxera.com>

commit e3d550c2c4f2f3dba469bc3c4b83d9332b4e99e1 upstream.

Really enable warning when CONFIG_EXT4_DEBUG is set and fix missing
first argument.  This was introduced in commit ff95ec22cd7f ("ext4:
add warning to ext4_convert_unwritten_extents_endio") and splitting
extents inside endio would trigger it.

Fixes: ff95ec22cd7f ("ext4: add warning to ext4_convert_unwritten_extents_endio")
Signed-off-by: Rakesh Pandit <rakesh@tuxera.com>
Signed-off-by: Theodore Ts'o <tytso@mit.edu>
Cc: stable@kernel.org
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 fs/ext4/extents.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

--- a/fs/ext4/extents.c
+++ b/fs/ext4/extents.c
@@ -3755,8 +3755,8 @@ static int ext4_convert_unwritten_extent
 	 * illegal.
 	 */
 	if (ee_block != map->m_lblk || ee_len > map->m_len) {
-#ifdef EXT4_DEBUG
-		ext4_warning("Inode (%ld) finished: extent logical block %llu,"
+#ifdef CONFIG_EXT4_DEBUG
+		ext4_warning(inode->i_sb, "Inode (%ld) finished: extent logical block %llu,"
 			     " len %u; IO logical block %llu, len %u",
 			     inode->i_ino, (unsigned long long)ee_block, ee_len,
 			     (unsigned long long)map->m_lblk, map->m_len);


