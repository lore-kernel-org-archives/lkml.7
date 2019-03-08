Return-Path: <SRS0=vL1f=RL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D2CCEC43381
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Mar 2019 13:01:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9FCB720449
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Mar 2019 13:01:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1552050116;
	bh=Jt9Ly9jZS0kVYZUyEnwHKUmh1SvFcIaYHUc3Sfy1l94=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=MkpO/SZI7aRoPA17/QJQqdmEKPfycrizmWNfyqWoSiGiCHF0ofp0CU/t1u32lw9dc
	 ozdMgt3grUUGsQ7NnVx7ImPQHFU8GJO5Kqg2XB+AQru62yvB0pmhZVmWYdvxUaAkFQ
	 yLu5w3m1m8QdobcsghNL4NIABuBbv+aTyWHaGg3Q=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728372AbfCHNAu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 Mar 2019 08:00:50 -0500
Received: from mail.kernel.org ([198.145.29.99]:37922 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728358AbfCHNAq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Mar 2019 08:00:46 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 94B4B20449;
        Fri,  8 Mar 2019 13:00:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1552050046;
        bh=Jt9Ly9jZS0kVYZUyEnwHKUmh1SvFcIaYHUc3Sfy1l94=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=fxSuTWccSNwTqAkAbEDJmmx3sWsMg5IwLKSMyUPCDBhj7VFEG5wJ2unuSMC2glxl6
         wdB7mD18lWekYnVq5S1iua+Mk1knd/+Np12LHluljz9bAmI5xu5Z8+ZOBz3oosJn7+
         W/hJAYyS9Tui3cMdjF1qPyYEjghi5A7UJ4Ck1LBs=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, YueHaibing <yuehaibing@huawei.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Thibaut Sautereau <thibaut@sautereau.fr>
Subject: [PATCH 4.19 66/68] exec: Fix mem leak in kernel_read_file
Date:   Fri,  8 Mar 2019 13:50:36 +0100
Message-Id: <20190308124913.858536613@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190308124910.696595153@linuxfoundation.org>
References: <20190308124910.696595153@linuxfoundation.org>
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

4.19-stable review patch.  If anyone has any objections, please let me know.

------------------

From: YueHaibing <yuehaibing@huawei.com>

commit f612acfae86af7ecad754ae6a46019be9da05b8e upstream.

syzkaller report this:
BUG: memory leak
unreferenced object 0xffffc9000488d000 (size 9195520):
  comm "syz-executor.0", pid 2752, jiffies 4294787496 (age 18.757s)
  hex dump (first 32 bytes):
    ff ff ff ff ff ff ff ff a8 00 00 00 01 00 00 00  ................
    02 00 00 00 00 00 00 00 80 a1 7a c1 ff ff ff ff  ..........z.....
  backtrace:
    [<000000000863775c>] __vmalloc_node mm/vmalloc.c:1795 [inline]
    [<000000000863775c>] __vmalloc_node_flags mm/vmalloc.c:1809 [inline]
    [<000000000863775c>] vmalloc+0x8c/0xb0 mm/vmalloc.c:1831
    [<000000003f668111>] kernel_read_file+0x58f/0x7d0 fs/exec.c:924
    [<000000002385813f>] kernel_read_file_from_fd+0x49/0x80 fs/exec.c:993
    [<0000000011953ff1>] __do_sys_finit_module+0x13b/0x2a0 kernel/module.c:3895
    [<000000006f58491f>] do_syscall_64+0x147/0x600 arch/x86/entry/common.c:290
    [<00000000ee78baf4>] entry_SYSCALL_64_after_hwframe+0x49/0xbe
    [<00000000241f889b>] 0xffffffffffffffff

It should goto 'out_free' lable to free allocated buf while kernel_read
fails.

Fixes: 39d637af5aa7 ("vfs: forbid write access when reading a file into memory")
Signed-off-by: YueHaibing <yuehaibing@huawei.com>
Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
Cc: Thibaut Sautereau <thibaut@sautereau.fr>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 fs/exec.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/fs/exec.c
+++ b/fs/exec.c
@@ -929,7 +929,7 @@ int kernel_read_file(struct file *file,
 		bytes = kernel_read(file, *buf + pos, i_size - pos, &pos);
 		if (bytes < 0) {
 			ret = bytes;
-			goto out;
+			goto out_free;
 		}
 
 		if (bytes == 0)


