Return-Path: <SRS0=7lyw=2D=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C0CCEC341AF
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Dec 2019 20:51:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E7F8324689
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Dec 2019 20:51:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726708AbfLMUvT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 13 Dec 2019 15:51:19 -0500
Received: from mout.kundenserver.de ([212.227.17.13]:52363 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725747AbfLMUvT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Dec 2019 15:51:19 -0500
Received: from threadripper.lan ([149.172.19.189]) by mrelayeu.kundenserver.de
 (mreue109 [212.227.15.145]) with ESMTPA (Nemesis) id
 1MbAYo-1i8iwY0uVc-00bePy; Fri, 13 Dec 2019 21:51:02 +0100
From:   Arnd Bergmann <arnd@arndb.de>
To:     y2038@lists.linaro.org, linux-kernel@vger.kernel.org,
        OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Carmeli Tamir <carmeli.tamir@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Thomas Gleixner <tglx@linutronix.de>,
        Deepa Dinamani <deepa.kernel@gmail.com>
Subject: [PATCH v2 02/24] fat: use prandom_u32() for i_generation
Date:   Fri, 13 Dec 2019 21:49:11 +0100
Message-Id: <20191213204936.3643476-3-arnd@arndb.de>
X-Mailer: git-send-email 2.20.0
In-Reply-To: <20191213204936.3643476-1-arnd@arndb.de>
References: <20191213204936.3643476-1-arnd@arndb.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:xom8Rv0Mro1nWgzFI7iwDzUBn2boE9thbAKykOAb1L7RRT/epwZ
 VtM23PMG6pgOlizw3iul83/tWNKoG5HNRt2I+9OXTnAPKKtbuCDdVXh2UDdHxO2S/xIbgzW
 4+mc4R/82Uw/PvlQTQMe+S+3ilRTJvxa6AUa/tfMQHTuafSdfF/5NUHHtM1MGAUJw8gsQIs
 UxGzoDSg1FQTzfyIq7PSw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:W5FzphDL8cs=:g7EVKCCCGWuKFtKBRF9gl8
 9ubOMCgpBznyRwkBiOr7kw4trZ5LWiLLP9bjkAkR2VaRCdGETpAfxLZfkex3O0CdFNJqjCEtV
 7/zVz49UECoZLXBZvVjv5W+fLnyFepmJiw+iX3TTnY2anXbDyEyi4qBOIauLeMtrS/LOtjIrB
 vjBjzgmCqSl5CliXferQgt83CkH8JlEIxHKb9lpp7JM3tKpYsbGjfD1gT239kNx5QVETRORPt
 +MCvYOTgSaAhzVhDOBUEfZdMgJ0yX1Ub6IKdz+SEh5vpKDLkbe94yWNIhgyeV7/tiZzzimPEt
 l7JpAZGx0bonISGsSi/j+cZX/HxM9PvzXnd9aBywC+Axz/Is45PP+jRQB8eiPLS186foq688+
 pc1Z9yU7EDdfUOKBLDc+rzNuJqibKATkixOCW5/2NEhjxiq+RLwEHuA82neI5PN2YPj++T++P
 KJ9EcWJ1deS52sKQB+rni8OWDhQFbxnK75aicnSWhRVMbC0i+1uSnBA5AW7KPVv6qrC5Qpu0o
 rr0JynSM/wOH+Ka5BgbF5fKzCKgEkk8/h32wVFvVN4NVGG/3p14B0Va34OtAvTZc91hnqxshG
 6fZFZI1nc7qtGAwT8Ky60OSq5IXiJMkRJWjYgH80WjZRi9s8RWI4t00jbblBDF8TsdMJppCIb
 8f0aS+NQHjiSTSmPZY0Prio7a3FiAOFz5xJk1aqUcPIwyhuevd+QmNjPlsUXEI6YxM+KgoUB1
 axsNHR6KqKYpLnwS3Er0g1SM+D2d5AuyYn2cJzrnauWBysHSs6F74qYdUHa3KlVX9K0WyPNHh
 mN+q5uTRENovsB9aa6ET4aibHQ6iFTEN6vVfVgwkmxAZ0cVYBM9SXjZM9cTwAR3YifnyK8NMO
 tBIWDES2L1KyB7GHSA+w==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Similar to commit 46c9a946d766 ("shmem: use monotonic time for i_generation")
we should not use the deprecated get_seconds() interface for i_generation.

prandom_u32() is the replacement used in other file systems.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 fs/fat/inode.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/fs/fat/inode.c b/fs/fat/inode.c
index 5f04c5c810fb..594b05ae16c9 100644
--- a/fs/fat/inode.c
+++ b/fs/fat/inode.c
@@ -21,6 +21,7 @@
 #include <linux/blkdev.h>
 #include <linux/backing-dev.h>
 #include <asm/unaligned.h>
+#include <linux/random.h>
 #include <linux/iversion.h>
 #include "fat.h"
 
@@ -521,7 +522,7 @@ int fat_fill_inode(struct inode *inode, struct msdos_dir_entry *de)
 	inode->i_uid = sbi->options.fs_uid;
 	inode->i_gid = sbi->options.fs_gid;
 	inode_inc_iversion(inode);
-	inode->i_generation = get_seconds();
+	inode->i_generation = prandom_u32();
 
 	if ((de->attr & ATTR_DIR) && !IS_FREE(de->name)) {
 		inode->i_generation &= ~1;
-- 
2.20.0

