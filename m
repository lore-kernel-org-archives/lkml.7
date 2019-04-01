Return-Path: <SRS0=/BGd=SD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BA0A6C43381
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Apr 2019 17:48:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 89B1920830
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Apr 2019 17:48:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1554140896;
	bh=abgMX9ip/tT90shcIb1UEdSVowoMRXXL2rrSKTVN6Gw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=lhcVNDfzcU+IpS15UJzv6ttb6qKnRlyCh4LaXBhRfS5EGGznB+R7UiOtwqzx8cA0t
	 6EOVlcQ2BCBEjhb7RY0phrG9etPWepnrzO77LFIX+IFpwZYB9uddwoHU41pivGnikv
	 ouPTWbCHweLow5bSEARMU5R5520E/Q8k44VeDy18=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387525AbfDARsP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Apr 2019 13:48:15 -0400
Received: from mail.kernel.org ([198.145.29.99]:38946 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732092AbfDARbZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Apr 2019 13:31:25 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A9A6820856;
        Mon,  1 Apr 2019 17:31:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1554139884;
        bh=abgMX9ip/tT90shcIb1UEdSVowoMRXXL2rrSKTVN6Gw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=w93nOsB2CS3S++chirBDo7L2AwZDERoJ56OsRLE0paowo6lSXUrsQJbacvOc/RHv/
         t+1Y9m6q2EF5LMXRS/+3MmiqhHc/HP2oRsvg4vJjx6yr5dG92DMcMiOzDU3ADPQbCX
         Oyj1VZgJt8aKrNEInB7pBeZuJvufLrq9LvC5yezs=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Frank Sorenson <fsorenso@redhat.com>,
        Lukas Czerner <lczerner@redhat.com>,
        Theodore Tso <tytso@mit.edu>
Subject: [PATCH 4.4 008/131] ext4: fix data corruption caused by unaligned direct AIO
Date:   Mon,  1 Apr 2019 19:01:18 +0200
Message-Id: <20190401170052.457821782@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190401170051.645954551@linuxfoundation.org>
References: <20190401170051.645954551@linuxfoundation.org>
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

4.4-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Lukas Czerner <lczerner@redhat.com>

commit 372a03e01853f860560eade508794dd274e9b390 upstream.

Ext4 needs to serialize unaligned direct AIO because the zeroing of
partial blocks of two competing unaligned AIOs can result in data
corruption.

However it decides not to serialize if the potentially unaligned aio is
past i_size with the rationale that no pending writes are possible past
i_size. Unfortunately if the i_size is not block aligned and the second
unaligned write lands past i_size, but still into the same block, it has
the potential of corrupting the previous unaligned write to the same
block.

This is (very simplified) reproducer from Frank

    // 41472 = (10 * 4096) + 512
    // 37376 = 41472 - 4096

    ftruncate(fd, 41472);
    io_prep_pwrite(iocbs[0], fd, buf[0], 4096, 37376);
    io_prep_pwrite(iocbs[1], fd, buf[1], 4096, 41472);

    io_submit(io_ctx, 1, &iocbs[1]);
    io_submit(io_ctx, 1, &iocbs[2]);

    io_getevents(io_ctx, 2, 2, events, NULL);

Without this patch the 512B range from 40960 up to the start of the
second unaligned write (41472) is going to be zeroed overwriting the data
written by the first write. This is a data corruption.

00000000  00 00 00 00 00 00 00 00  00 00 00 00 00 00 00 00
*
00009200  30 30 30 30 30 30 30 30  30 30 30 30 30 30 30 30
*
0000a000  00 00 00 00 00 00 00 00  00 00 00 00 00 00 00 00
*
0000a200  31 31 31 31 31 31 31 31  31 31 31 31 31 31 31 31

With this patch the data corruption is avoided because we will recognize
the unaligned_aio and wait for the unwritten extent conversion.

00000000  00 00 00 00 00 00 00 00  00 00 00 00 00 00 00 00
*
00009200  30 30 30 30 30 30 30 30  30 30 30 30 30 30 30 30
*
0000a200  31 31 31 31 31 31 31 31  31 31 31 31 31 31 31 31
*
0000b200

Reported-by: Frank Sorenson <fsorenso@redhat.com>
Signed-off-by: Lukas Czerner <lczerner@redhat.com>
Signed-off-by: Theodore Ts'o <tytso@mit.edu>
Fixes: e9e3bcecf44c ("ext4: serialize unaligned asynchronous DIO")
Cc: stable@vger.kernel.org
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 fs/ext4/file.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/fs/ext4/file.c
+++ b/fs/ext4/file.c
@@ -79,7 +79,7 @@ ext4_unaligned_aio(struct inode *inode,
 	struct super_block *sb = inode->i_sb;
 	int blockmask = sb->s_blocksize - 1;
 
-	if (pos >= i_size_read(inode))
+	if (pos >= ALIGN(i_size_read(inode), sb->s_blocksize))
 		return 0;
 
 	if ((pos | iov_iter_alignment(from)) & blockmask)


