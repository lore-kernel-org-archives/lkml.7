Return-Path: <SRS0=TLrx=2G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB830C43603
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Dec 2019 18:29:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B302820674
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Dec 2019 18:29:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1576520950;
	bh=DLICn1c1uPmyDsnVLmJgRioewe0lH3mEu4E3XX/rk40=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=Hw6z/KIGBH7VN7QEY7HtcvMSBsxlh9OFN6ECebVAjcDJRqe0Ykp0VKz2K+VBDRgGC
	 oK6kREzLs2jOGEJbljOhFcMKAA57XF5kl46kCE4mPeiZ+KeggrFgIdH9rXWMkpbyeu
	 y6D5rHFdXRJ6RUjUhiAwWYfvQndrr4FpGGsYzndE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731499AbfLPS3K (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 16 Dec 2019 13:29:10 -0500
Received: from mail.kernel.org ([198.145.29.99]:33202 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727217AbfLPSON (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Dec 2019 13:14:13 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D885C21739;
        Mon, 16 Dec 2019 18:14:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1576520052;
        bh=DLICn1c1uPmyDsnVLmJgRioewe0lH3mEu4E3XX/rk40=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=tFRWb4NrE/lVnv/e379A7c2AgWLBJDIPlXRbyfrUcJPNENHal2Og4W5o/zQCfHQE1
         skArsgbQA7tBnnzUKbcL76pvEtikEYMX07AeFPS4RiPSWR1QdwRxIkYe+OErYFchsX
         SzPeI+vuJcIKGBwrRJkomzO67tz6VM/BCPAU2Fxk=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Chen Jun <chenjun102@huawei.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Hugh Dickins <hughd@google.com>, Qian Cai <cai@lca.pw>,
        Kefeng Wang <wangkefeng.wang@huawei.com>,
        Linus Torvalds <torvalds@linux-foundation.org>
Subject: [PATCH 5.3 177/180] mm/shmem.c: cast the type of unmap_start to u64
Date:   Mon, 16 Dec 2019 18:50:17 +0100
Message-Id: <20191216174848.312900799@linuxfoundation.org>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20191216174806.018988360@linuxfoundation.org>
References: <20191216174806.018988360@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Chen Jun <chenjun102@huawei.com>

commit aa71ecd8d86500da6081a72da6b0b524007e0627 upstream.

In 64bit system. sb->s_maxbytes of shmem filesystem is MAX_LFS_FILESIZE,
which equal LLONG_MAX.

If offset > LLONG_MAX - PAGE_SIZE, offset + len < LLONG_MAX in
shmem_fallocate, which will pass the checking in vfs_fallocate.

	/* Check for wrap through zero too */
	if (((offset + len) > inode->i_sb->s_maxbytes) || ((offset + len) < 0))
		return -EFBIG;

loff_t unmap_start = round_up(offset, PAGE_SIZE) in shmem_fallocate
causes a overflow.

Syzkaller reports a overflow problem in mm/shmem:

  UBSAN: Undefined behaviour in mm/shmem.c:2014:10
  signed integer overflow: '9223372036854775807 + 1' cannot be represented in type 'long long int'
  CPU: 0 PID:17076 Comm: syz-executor0 Not tainted 4.1.46+ #1
  Hardware name: linux, dummy-virt (DT)
  Call trace:
     dump_backtrace+0x0/0x2c8 arch/arm64/kernel/traps.c:100
     show_stack+0x20/0x30 arch/arm64/kernel/traps.c:238
     __dump_stack lib/dump_stack.c:15 [inline]
     ubsan_epilogue+0x18/0x70 lib/ubsan.c:164
     handle_overflow+0x158/0x1b0 lib/ubsan.c:195
     shmem_fallocate+0x6d0/0x820 mm/shmem.c:2104
     vfs_fallocate+0x238/0x428 fs/open.c:312
     SYSC_fallocate fs/open.c:335 [inline]
     SyS_fallocate+0x54/0xc8 fs/open.c:239

The highest bit of unmap_start will be appended with sign bit 1
(overflow) when calculate shmem_falloc.start:

    shmem_falloc.start = unmap_start >> PAGE_SHIFT.

Fix it by casting the type of unmap_start to u64, when right shifted.

This bug is found in LTS Linux 4.1.  It also seems to exist in mainline.

Link: http://lkml.kernel.org/r/1573867464-5107-1-git-send-email-chenjun102@huawei.com
Signed-off-by: Chen Jun <chenjun102@huawei.com>
Reviewed-by: Andrew Morton <akpm@linux-foundation.org>
Cc: Hugh Dickins <hughd@google.com>
Cc: Qian Cai <cai@lca.pw>
Cc: Kefeng Wang <wangkefeng.wang@huawei.com>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
Signed-off-by: Linus Torvalds <torvalds@linux-foundation.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 mm/shmem.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/mm/shmem.c
+++ b/mm/shmem.c
@@ -2730,7 +2730,7 @@ static long shmem_fallocate(struct file
 		}
 
 		shmem_falloc.waitq = &shmem_falloc_waitq;
-		shmem_falloc.start = unmap_start >> PAGE_SHIFT;
+		shmem_falloc.start = (u64)unmap_start >> PAGE_SHIFT;
 		shmem_falloc.next = (unmap_end + 1) >> PAGE_SHIFT;
 		spin_lock(&inode->i_lock);
 		inode->i_private = &shmem_falloc;


