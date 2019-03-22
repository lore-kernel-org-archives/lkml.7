Return-Path: <SRS0=oArh=RZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0100FC43381
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 12:15:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C60462192C
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 12:15:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1553256956;
	bh=pGRmLOiXYVV7dLbkrHm4O8+OyjWJKgUDumdzUXjfa4A=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=So8jrYVIyo7gGIWBwG+SSfP1lZdmjQlfXBwOETIpRKqvd8wyxcxcyeCU0WAzvHFJ+
	 7htUIK8M1eMHKBb1ngiOstyf3Bss5ekXrNDpGNdAepRyqBNp5Y6TtP+9r+BhuNJHyW
	 ftOOOiv432lwQcLZx/WZbdZuY/FytngT/0AWTFhI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390126AbfCVMPz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Mar 2019 08:15:55 -0400
Received: from mail.kernel.org ([198.145.29.99]:54458 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389722AbfCVMPy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Mar 2019 08:15:54 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 43A4A218A1;
        Fri, 22 Mar 2019 12:15:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1553256952;
        bh=pGRmLOiXYVV7dLbkrHm4O8+OyjWJKgUDumdzUXjfa4A=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=CmlzxV+N8+Y3mGTZsrh8B8GpNGgKUqwYx4qSYUY/pr7a3l7sAJvJ2fMmb4nzN29d9
         Za/227Po7M3nt3QEY+fYt5JFfH+WKQFSKAqXfOnmYDYp0Y2WVQRmvdmeLiXOgY47Mf
         qGu0+AFm19+K2TqluUhTkoV+pbbKxG2HrrPRkXJA=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Varad Gautam <vrd@amazon.de>,
        Zheng Wang <wanz@amazon.de>,
        Brandon Schwartz <bsschwar@amazon.de>,
        David Woodhouse <dwmw@amazon.co.uk>,
        Maximilian Heyne <mheyne@amazon.de>,
        Stefan Nuernberger <snu@amazon.de>, Amit Shah <aams@amazon.de>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Al Viro <viro@ZenIV.linux.org.uk>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Matthew Wilcox <willy@infradead.org>,
        Eric Biggers <ebiggers@google.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Nicolas Pernas Maradei <npernas@amazon.de>
Subject: [PATCH 5.0 086/238] fs/devpts: always delete dcache dentry-s in dput()
Date:   Fri, 22 Mar 2019 12:15:05 +0100
Message-Id: <20190322111303.660949224@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190322111258.383569278@linuxfoundation.org>
References: <20190322111258.383569278@linuxfoundation.org>
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

5.0-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Varad Gautam <vrd@amazon.de>

commit 73052b0daee0b750b39af18460dfec683e4f5887 upstream.

d_delete only unhashes an entry if it is reached with
dentry->d_lockref.count != 1. Prior to commit 8ead9dd54716 ("devpts:
more pty driver interface cleanups"), d_delete was called on a dentry
from devpts_pty_kill with two references held, which would trigger the
unhashing, and the subsequent dputs would release it.

Commit 8ead9dd54716 reworked devpts_pty_kill to stop acquiring the second
reference from d_find_alias, and the d_delete call left the dentries
still on the hashed list without actually ever being dropped from dcache
before explicit cleanup. This causes the number of negative dentries for
devpts to pile up, and an `ls /dev/pts` invocation can take seconds to
return.

Provide always_delete_dentry() from simple_dentry_operations
as .d_delete for devpts, to make the dentry be dropped from dcache.

Without this cleanup, the number of dentries in /dev/pts/ can be grown
arbitrarily as:

`python -c 'import pty; pty.spawn(["ls", "/dev/pts"])'`

A systemtap probe on dcache_readdir to count d_subdirs shows this count
to increase with each pty spawn invocation above:

probe kernel.function("dcache_readdir") {
    subdirs = &@cast($file->f_path->dentry, "dentry")->d_subdirs;
    p = subdirs;
    p = @cast(p, "list_head")->next;
    i = 0
    while (p != subdirs) {
      p = @cast(p, "list_head")->next;
      i = i+1;
    }
    printf("number of dentries: %d\n", i);
}

Fixes: 8ead9dd54716 ("devpts: more pty driver interface cleanups")
Signed-off-by: Varad Gautam <vrd@amazon.de>
Reported-by: Zheng Wang <wanz@amazon.de>
Reported-by: Brandon Schwartz <bsschwar@amazon.de>
Root-caused-by: Maximilian Heyne <mheyne@amazon.de>
Root-caused-by: Nicolas Pernas Maradei <npernas@amazon.de>
CC: David Woodhouse <dwmw@amazon.co.uk>
CC: Maximilian Heyne <mheyne@amazon.de>
CC: Stefan Nuernberger <snu@amazon.de>
CC: Amit Shah <aams@amazon.de>
CC: Linus Torvalds <torvalds@linux-foundation.org>
CC: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
CC: Al Viro <viro@ZenIV.linux.org.uk>
CC: Christian Brauner <christian.brauner@ubuntu.com>
CC: Eric W. Biederman <ebiederm@xmission.com>
CC: Matthew Wilcox <willy@infradead.org>
CC: Eric Biggers <ebiggers@google.com>
CC: <stable@vger.kernel.org> # 4.9+
Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 fs/devpts/inode.c |    1 +
 1 file changed, 1 insertion(+)

--- a/fs/devpts/inode.c
+++ b/fs/devpts/inode.c
@@ -455,6 +455,7 @@ devpts_fill_super(struct super_block *s,
 	s->s_blocksize_bits = 10;
 	s->s_magic = DEVPTS_SUPER_MAGIC;
 	s->s_op = &devpts_sops;
+	s->s_d_op = &simple_dentry_operations;
 	s->s_time_gran = 1;
 
 	error = -ENOMEM;


