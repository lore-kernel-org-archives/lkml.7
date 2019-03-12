Return-Path: <SRS0=J4ZE=RP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ED881C43381
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Mar 2019 17:18:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B611E218A1
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Mar 2019 17:18:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1552411096;
	bh=bkNxBxU5BVyEhENq+Qc9p1OWgVS0nwzcryRTYdmb/aE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=P7+/9ZiR0LCuGN0A9en/pdBL9bPAfLbM6W+La+RUpjPhut3MqbYjf9KNPYy+j8MMW
	 ancjeKLDWpDKk3SWeI9sifr5IaeMYPOO1Wba3xgLaYNhZarznxyrUK8ZU/Rbc4HPXY
	 6pydL9YVRzRq6TbUhqdfzrH8WSmCZ8sL8lGVrp60=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728175AbfCLRSP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Mar 2019 13:18:15 -0400
Received: from mail.kernel.org ([198.145.29.99]:33310 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729606AbfCLRR3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Mar 2019 13:17:29 -0400
Received: from localhost (unknown [104.133.8.98])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E5C5821874;
        Tue, 12 Mar 2019 17:17:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1552411049;
        bh=bkNxBxU5BVyEhENq+Qc9p1OWgVS0nwzcryRTYdmb/aE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Q6d2x3UppPXKBxxDOLS/958aJO2snIUYsKnsTvPGxBP3no2m0RAja/JuCk+RtozTe
         MIr/ExJb/zxhX4ISR2IrkssshswPXe97ybmwWN9Muh1gjTEt4bvEGmD2GycIxPXth1
         2T9SutwnYL5+kvVUv4xzhQg9bEurV/zNQHw1H1Dc=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, YueHaibing <yuehaibing@huawei.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Thibaut Sautereau <thibaut@sautereau.fr>
Subject: [PATCH 4.9 32/96] exec: Fix mem leak in kernel_read_file
Date:   Tue, 12 Mar 2019 10:09:50 -0700
Message-Id: <20190312171036.935314060@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190312171034.530434962@linuxfoundation.org>
References: <20190312171034.530434962@linuxfoundation.org>
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

4.9-stable review patch.  If anyone has any objections, please let me know.

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
@@ -938,7 +938,7 @@ int kernel_read_file(struct file *file,
 				    i_size - pos);
 		if (bytes < 0) {
 			ret = bytes;
-			goto out;
+			goto out_free;
 		}
 
 		if (bytes == 0)


