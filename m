Return-Path: <SRS0=6dNS=X4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D049C32792
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Oct 2019 16:37:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5B7AE2086A
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Oct 2019 16:37:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1570120660;
	bh=sYxrHIOFT4VeixNBoCDQ2kqRtflr4K1eRG+U8Qy9/ao=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=wgnYcO6TpC13CoFyCbkTlC1VnnGKSgduKkfVvba3W4rn14v338W88XoDTsYqWN+S4
	 lKhnW2VRhOFJJUntC4Y/IOjaTD8ZXfCElsPYHUjshmd44pOFFq/pimp920+R3VkDzJ
	 5o5X6ZX4lWfUq20tsdtIKcz+/3o2rmga6ues8nio=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392250AbfJCQhj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 3 Oct 2019 12:37:39 -0400
Received: from mail.kernel.org ([198.145.29.99]:46980 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2404621AbfJCQhg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Oct 2019 12:37:36 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 04EB42070B;
        Thu,  3 Oct 2019 16:37:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1570120656;
        bh=sYxrHIOFT4VeixNBoCDQ2kqRtflr4K1eRG+U8Qy9/ao=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ib5E5+Zs01DvAWr1jeZQJeDTmTgW/QHzIC1t01DKaarcwIBgOtxTCDqhFPA9ohas3
         q/dCOXkhWW7QoC0D8fFIOS0JxYxTLCAN2R3m3gYLMIoq6ILCcnMkKOIP7UsDEaBLv1
         H+vhHyZoJahGd/bsYGX+fGk8f6Ftxkll2rLfkvAU=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Theodore Tso <tytso@mit.edu>
Subject: [PATCH 5.2 303/313] ext4: fix punch hole for inline_data file systems
Date:   Thu,  3 Oct 2019 17:54:41 +0200
Message-Id: <20191003154603.031681329@linuxfoundation.org>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191003154533.590915454@linuxfoundation.org>
References: <20191003154533.590915454@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Theodore Ts'o <tytso@mit.edu>

commit c1e8220bd316d8ae8e524df39534b8a412a45d5e upstream.

If a program attempts to punch a hole on an inline data file, we need
to convert it to a normal file first.

This was detected using ext4/032 using the adv configuration.  Simple
reproducer:

mke2fs -Fq -t ext4 -O inline_data /dev/vdc
mount /vdc
echo "" > /vdc/testfile
xfs_io -c 'truncate 33554432' /vdc/testfile
xfs_io -c 'fpunch 0 1048576' /vdc/testfile
umount /vdc
e2fsck -fy /dev/vdc

Cc: stable@vger.kernel.org
Signed-off-by: Theodore Ts'o <tytso@mit.edu>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 fs/ext4/inode.c |    9 +++++++++
 1 file changed, 9 insertions(+)

--- a/fs/ext4/inode.c
+++ b/fs/ext4/inode.c
@@ -4288,6 +4288,15 @@ int ext4_punch_hole(struct inode *inode,
 
 	trace_ext4_punch_hole(inode, offset, length, 0);
 
+	ext4_clear_inode_state(inode, EXT4_STATE_MAY_INLINE_DATA);
+	if (ext4_has_inline_data(inode)) {
+		down_write(&EXT4_I(inode)->i_mmap_sem);
+		ret = ext4_convert_inline_data(inode);
+		up_write(&EXT4_I(inode)->i_mmap_sem);
+		if (ret)
+			return ret;
+	}
+
 	/*
 	 * Write out all dirty pages to avoid race conditions
 	 * Then release them.


