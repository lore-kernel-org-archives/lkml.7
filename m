Return-Path: <SRS0=vISB=2T=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5436EC2D0CE
	for <linux-kernel@archiver.kernel.org>; Sun, 29 Dec 2019 17:28:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 22220208E4
	for <linux-kernel@archiver.kernel.org>; Sun, 29 Dec 2019 17:28:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1577640496;
	bh=1siPgO9l5+fYANeF4ouE/nlWh54xIo2FtSpm8a1SBdY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=z3l4lmo6vzuokPCMkVm2R5XJ3G2HEPxt/UzqhMOoTzc3ubjXHBMCTRIK11se/HGG5
	 UQEROFolPD9GRKFylyxzhFUuFoPArYwgeGR4Hqc4kaFMso0NHIP5zyBsLAnhX/PAOo
	 afGz4fAOHsZBUpNMpTw+dgtg1UJGt+6+PuwybXj0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728562AbfL2R2P (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 29 Dec 2019 12:28:15 -0500
Received: from mail.kernel.org ([198.145.29.99]:51324 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728224AbfL2R2L (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 29 Dec 2019 12:28:11 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5518620409;
        Sun, 29 Dec 2019 17:28:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1577640490;
        bh=1siPgO9l5+fYANeF4ouE/nlWh54xIo2FtSpm8a1SBdY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=EgQB8bhS52OsBSuN7hL95ybGSEMeIVhD7KvXgDdz/9yt1sUbpN2NCHqRfnp7qIvon
         l0GwZJj3Gr1142/NjtCh8utz4kV5wV3mQZqytmjeKtwSIwWXJwCpJmQEPGm7SQFmWN
         WgQrMoTP3wpKVmkC45+PESx4LwSU5v+Ehp0cqHEM=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Filipe Manana <fdmanana@suse.com>,
        Johannes Thumshirn <jthumshirn@suse.de>,
        Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>
Subject: [PATCH 4.19 018/219] btrfs: abort transaction after failed inode updates in create_subvol
Date:   Sun, 29 Dec 2019 18:17:00 +0100
Message-Id: <20191229162511.841334455@linuxfoundation.org>
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

commit c7e54b5102bf3614cadb9ca32d7be73bad6cecf0 upstream.

We can just abort the transaction here, and in fact do that for every
other failure in this function except these two cases.

CC: stable@vger.kernel.org # 4.4+
Reviewed-by: Filipe Manana <fdmanana@suse.com>
Reviewed-by: Johannes Thumshirn <jthumshirn@suse.de>
Signed-off-by: Josef Bacik <josef@toxicpanda.com>
Reviewed-by: David Sterba <dsterba@suse.com>
Signed-off-by: David Sterba <dsterba@suse.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 fs/btrfs/ioctl.c |   10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

--- a/fs/btrfs/ioctl.c
+++ b/fs/btrfs/ioctl.c
@@ -709,11 +709,17 @@ static noinline int create_subvol(struct
 
 	btrfs_i_size_write(BTRFS_I(dir), dir->i_size + namelen * 2);
 	ret = btrfs_update_inode(trans, root, dir);
-	BUG_ON(ret);
+	if (ret) {
+		btrfs_abort_transaction(trans, ret);
+		goto fail;
+	}
 
 	ret = btrfs_add_root_ref(trans, objectid, root->root_key.objectid,
 				 btrfs_ino(BTRFS_I(dir)), index, name, namelen);
-	BUG_ON(ret);
+	if (ret) {
+		btrfs_abort_transaction(trans, ret);
+		goto fail;
+	}
 
 	ret = btrfs_uuid_tree_add(trans, root_item->uuid,
 				  BTRFS_UUID_KEY_SUBVOL, objectid);


