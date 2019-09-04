Return-Path: <SRS0=tMFY=W7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F3839C3A5A8
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Sep 2019 18:25:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CF72C20870
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Sep 2019 18:25:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1567621519;
	bh=InPFssa/eK96xAtktCsLBA/fWs+ABjvEBD/fPM2APhU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=CymnmnoqLgZiXbAhtwSGaQE0Yl8+cmQm1fGUS1CpROpD/HFzfEqpNkaj7EZoiOVfQ
	 Gd1msPPkk6ZE5pTV0tp8YpQd/KrztyzXp0EFUUu4OazgjC4TT1s8ym4F14RCd2yjld
	 Ta58fmnPTUgJo/RlA6h7FKOqVAKDVueJNib14E2g=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388664AbfIDSZT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Sep 2019 14:25:19 -0400
Received: from mail.kernel.org ([198.145.29.99]:39526 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388374AbfIDSAS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Sep 2019 14:00:18 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 62D7D22CEA;
        Wed,  4 Sep 2019 18:00:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1567620017;
        bh=InPFssa/eK96xAtktCsLBA/fWs+ABjvEBD/fPM2APhU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=lf3I3ejNQV7kFujtxY7ACu7bRyIlG4Mc3E5oO5fT4syZP/ZrgsUlfBxvwFLHrLPUi
         X8X/470+Tw5KfNlvvWhAG4aPwfwfXRiGlnfvaxgTVT+rgDxII2HnaXAA/gR9CMWfb2
         YZpB6oSAjJKb9z3oY4Vzg8PAvYD3wpKkLPnohmfg=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, benjamin.moody@gmail.com,
        "Darrick J. Wong" <darrick.wong@oracle.com>,
        Dave Chinner <dchinner@redhat.com>,
        Salvatore Bonaccorso <carnil@debian.org>
Subject: [PATCH 4.9 43/83] xfs: fix missing ILOCK unlock when xfs_setattr_nonsize fails due to EDQUOT
Date:   Wed,  4 Sep 2019 19:53:35 +0200
Message-Id: <20190904175307.599412558@linuxfoundation.org>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20190904175303.488266791@linuxfoundation.org>
References: <20190904175303.488266791@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Darrick J. Wong <darrick.wong@oracle.com>

commit 1fb254aa983bf190cfd685d40c64a480a9bafaee upstream.

Benjamin Moody reported to Debian that XFS partially wedges when a chgrp
fails on account of being out of disk quota.  I ran his reproducer
script:

# adduser dummy
# adduser dummy plugdev

# dd if=/dev/zero bs=1M count=100 of=test.img
# mkfs.xfs test.img
# mount -t xfs -o gquota test.img /mnt
# mkdir -p /mnt/dummy
# chown -c dummy /mnt/dummy
# xfs_quota -xc 'limit -g bsoft=100k bhard=100k plugdev' /mnt

(and then as user dummy)

$ dd if=/dev/urandom bs=1M count=50 of=/mnt/dummy/foo
$ chgrp plugdev /mnt/dummy/foo

and saw:

================================================
WARNING: lock held when returning to user space!
5.3.0-rc5 #rc5 Tainted: G        W
------------------------------------------------
chgrp/47006 is leaving the kernel with locks still held!
1 lock held by chgrp/47006:
 #0: 000000006664ea2d (&xfs_nondir_ilock_class){++++}, at: xfs_ilock+0xd2/0x290 [xfs]

...which is clearly caused by xfs_setattr_nonsize failing to unlock the
ILOCK after the xfs_qm_vop_chown_reserve call fails.  Add the missing
unlock.

Reported-by: benjamin.moody@gmail.com
Fixes: 253f4911f297 ("xfs: better xfs_trans_alloc interface")
Signed-off-by: Darrick J. Wong <darrick.wong@oracle.com>
Reviewed-by: Dave Chinner <dchinner@redhat.com>
Tested-by: Salvatore Bonaccorso <carnil@debian.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 fs/xfs/xfs_iops.c |    1 +
 1 file changed, 1 insertion(+)

--- a/fs/xfs/xfs_iops.c
+++ b/fs/xfs/xfs_iops.c
@@ -774,6 +774,7 @@ xfs_setattr_nonsize(
 
 out_cancel:
 	xfs_trans_cancel(tp);
+	xfs_iunlock(ip, XFS_ILOCK_EXCL);
 out_dqrele:
 	xfs_qm_dqrele(udqp);
 	xfs_qm_dqrele(gdqp);


