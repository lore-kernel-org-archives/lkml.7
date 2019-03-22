Return-Path: <SRS0=oArh=RZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 41042C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 14:35:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1B54A218A5
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 14:35:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729183AbfCVOfa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Mar 2019 10:35:30 -0400
Received: from mout.kundenserver.de ([212.227.126.187]:46733 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728332AbfCVOf3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Mar 2019 10:35:29 -0400
Received: from wuerfel.lan ([149.172.19.189]) by mrelayeu.kundenserver.de
 (mreue011 [212.227.15.129]) with ESMTPA (Nemesis) id
 1Mdva2-1gXSTg2JgU-00b3lz; Fri, 22 Mar 2019 15:35:10 +0100
From:   Arnd Bergmann <arnd@arndb.de>
To:     Coly Li <colyli@suse.de>,
        Kent Overstreet <kent.overstreet@gmail.com>
Cc:     clang-built-linux@googlegroups.com,
        Nick Desaulniers <ndesaulniers@google.com>,
        Nathan Chancellor <natechancellor@gmail.com>,
        Arnd Bergmann <arnd@arndb.de>, Jens Axboe <axboe@kernel.dk>,
        Shenghui Wang <shhuiw@foxmail.com>,
        Hannes Reinecke <hare@suse.com>, linux-bcache@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] bcache: avoid clang -Wunintialized warning
Date:   Fri, 22 Mar 2019 15:35:00 +0100
Message-Id: <20190322143507.1256436-1-arnd@arndb.de>
X-Mailer: git-send-email 2.20.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:QGc/GctXeJV59y1OYuIdUj9uiL6P2qx1feNmYMt8dpTQTNu+k3a
 A4oJk+zaSs2dKRb4dyyUedkK8pChtVPfa1xr10aOIlVE6rSzxRQJ+ilqwJyQ/o2wZuemRs1
 v+E+RH/lew3kXBt1cOp4r908FUSNoMVbVf3u8Zbjp97duzuT3bXfVPbKf8RGJUgrIidnSME
 qqZMyKS82+UzgaS7Drqdg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:FCS8Mkl7YUc=:km6Y6cIIqK/kGxSFuwuqxk
 mua3NXz9W0OQvAwCvR5gw1hMa+lTOPAPxA3RScHH4Xp4pyajEj7QdZRZuy42V70ZSHYjkfck6
 opEh+TtAfX+/oALb2fRY5Mg2CTDYp/DzzpXaI25V+nKo0QdEJrydJ+QfGyP+8B0DZV0FhxF8s
 Unp2O1HqAhFDcfOTs7Bjps3PIfGwtEFe69MYXv/A7f8/05eBcKGD7TNjwxtoKQgPHrPyWwGys
 8LS6BXDiHzhv/2h9n8N4JKTnkKpOtDiAak71Qi9+DkPZW+TKgFExHKODtHbzclU/tPzS7UjxY
 BqK7Pq9fxRy//wOzAnhXC7tJkAHgPb2mICU8IeSyaXAYQGOHdzaPDh8WV7QlF9j2LpN0nT1l4
 LZGsEPF9wbdxquzlRguRDnVb046Y9QC2+ZjENBOenbBi1UPahz1Ocn0fUQVI6jkCLhhL+AK6Y
 wcJkd+ZZZFqtBbED63DLf5kh8vIWd+4+wTsQLrs1pWBAPTosq0vxV18/tztm6d6D2Vp+eVyAE
 PjbVGNN9AoZkoKrzyhHAmi2wttlJPmm32LRFnBF7bsZ3mXAuypT/d2ygJ/3jE976KdtnOjL5n
 5/4yhIT77MuLXpQWCqy2nU62U3MGI1JdZU2zM7lxHIoUJU3REz0RDBg23dbL5iqmb4opJAPye
 TzsELFkvXSr1ggXkpYLp9WZY5lEpdJR4yP9yfyOYtj205ny7O2F6Sd3HxgrrWLZvOoOVcsmWW
 8qE0512zgWD9zBgx9kqe20vMIuI+pGXXT+E4qw==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

clang has identified a code path in which it thinks a
variable may be unused:

drivers/md/bcache/alloc.c:333:4: error: variable 'bucket' is used uninitialized whenever 'if' condition is false
      [-Werror,-Wsometimes-uninitialized]
                        fifo_pop(&ca->free_inc, bucket);
                        ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
drivers/md/bcache/util.h:219:27: note: expanded from macro 'fifo_pop'
 #define fifo_pop(fifo, i)       fifo_pop_front(fifo, (i))
                                ^~~~~~~~~~~~~~~~~~~~~~~~~
drivers/md/bcache/util.h:189:6: note: expanded from macro 'fifo_pop_front'
        if (_r) {                                                       \
            ^~
drivers/md/bcache/alloc.c:343:46: note: uninitialized use occurs here
                        allocator_wait(ca, bch_allocator_push(ca, bucket));
                                                                  ^~~~~~
drivers/md/bcache/alloc.c:287:7: note: expanded from macro 'allocator_wait'
                if (cond)                                               \
                    ^~~~
drivers/md/bcache/alloc.c:333:4: note: remove the 'if' if its condition is always true
                        fifo_pop(&ca->free_inc, bucket);
                        ^
drivers/md/bcache/util.h:219:27: note: expanded from macro 'fifo_pop'
 #define fifo_pop(fifo, i)       fifo_pop_front(fifo, (i))
                                ^
drivers/md/bcache/util.h:189:2: note: expanded from macro 'fifo_pop_front'
        if (_r) {                                                       \
        ^
drivers/md/bcache/alloc.c:331:15: note: initialize the variable 'bucket' to silence this warning
                        long bucket;
                                   ^

This cannot happen in practice because we only enter the loop
if there is at least one element in the list.

Slightly rearranging the code makes this clearer to both the
reader and the compiler, which avoids the warning.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/md/bcache/alloc.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/md/bcache/alloc.c b/drivers/md/bcache/alloc.c
index 5002838ea476..f8986effcb50 100644
--- a/drivers/md/bcache/alloc.c
+++ b/drivers/md/bcache/alloc.c
@@ -327,10 +327,11 @@ static int bch_allocator_thread(void *arg)
 		 * possibly issue discards to them, then we add the bucket to
 		 * the free list:
 		 */
-		while (!fifo_empty(&ca->free_inc)) {
+		while (1) {
 			long bucket;
 
-			fifo_pop(&ca->free_inc, bucket);
+			if (!fifo_pop(&ca->free_inc, bucket))
+				break;
 
 			if (ca->discard) {
 				mutex_unlock(&ca->set->bucket_lock);
-- 
2.20.0

