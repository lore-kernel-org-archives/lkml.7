Return-Path: <SRS0=xALZ=UQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 56B4AC31E57
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Jun 2019 13:12:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 366152054F
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Jun 2019 13:12:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727892AbfFQNMj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Jun 2019 09:12:39 -0400
Received: from mout.kundenserver.de ([212.227.17.24]:53435 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725973AbfFQNMi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jun 2019 09:12:38 -0400
Received: from threadripper.lan ([149.172.19.189]) by mrelayeu.kundenserver.de
 (mreue106 [212.227.15.145]) with ESMTPA (Nemesis) id
 1MTzKW-1i2oYx43MY-00QycG; Mon, 17 Jun 2019 15:12:14 +0200
From:   Arnd Bergmann <arnd@arndb.de>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Alexander Potapenko <glider@google.com>,
        Kees Cook <keescook@chromium.org>,
        Christoph Lameter <cl@linux.com>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Kostya Serebryany <kcc@google.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Sandeep Patil <sspatil@android.com>,
        Laura Abbott <labbott@redhat.com>,
        Jann Horn <jannh@google.com>, Marco Elver <elver@google.com>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        linux-kernel@vger.kernel.org
Subject: [PATCH] lib: test_meminit: fix -Wmaybe-uninitialized false positive
Date:   Mon, 17 Jun 2019 15:11:57 +0200
Message-Id: <20190617131210.2190280-1-arnd@arndb.de>
X-Mailer: git-send-email 2.20.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:kOJR4T41V/xJjVqo+3xT+Z4mWAd8aTQRzAFqh4zAFz0xLbWz96U
 2dooLYqmY+E0WT/rDs/meig77BanZK7eoQzYy1zN5ZRAWt5HY7zV+cvn+EBlN/lXLuR/PA6
 BVj9LTOouIEzed06XF+0wHwJ1dBmHryeKugsG28von18kBLDu1kF/aJ4vO1ydIL8zutGLO+
 pkp6F7iWbM39bcEuGArFA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:IXykDVGcQ/g=:THSQ10OrLUrXEk6BhOe21s
 s0nGLPNWCfJHDuwD4FInvG63Xu3CGGen54eLAyQNRWko2f64iIVTPx2AWXm1Nh7fRJ+UI0LF3
 HF8KA5+DMPyOAi3UQhZebphdh9T/etXNs21RyY/F8OMRHIbkCTATtqy241bgFcBcv7G0pwqq8
 75M6c6ROVXpC7Hhzv5GzfuwAxOpBzIgQJMxxr39U+HS5JG2IyPiiut/FW4cR2msshVPR+bIso
 vsieTcMpldKIl4VHn/6/fyzpdUJ1PAPL5evBCun18Z1vVvFj8qY4csbn/l6+qbbQaR6yFSgII
 VKVugbsLHIAiywi5sTn4b0F4pngRTHTcBrRW6t0wnkzxllqqQyAfIK0soF7ZfOTSokRs2nowF
 sUX7THC/UKYIsW9ynnyj+hekdIyMNYkbQTbUQCH8tHGevkU2na6SUf6MrwLHhOlpK0KIi5Tq5
 mU0IayF2qX1/BPVz5lM51QMBf6g1ZOOXd45T0tNd2OHf/CG/vYtB8QX2V+6tdZCC+7VXavbC4
 CucNF62zDcwhFXH7UIotOioUmR6720c4U5zr7Q/O1+N4gSfLjLER9rEljqE1874xeoqonwWTI
 pwsIV44lcZ+8A0iTJTl3yB7AbCoP1KTo3YuhuazKOlkjFCq2EEpcM0fm2VwRnASZl+d2a0NZH
 qVHxk2/GiQW/FojsogBlrG+fLFdiutMKmS3ZGi5a1IqN7ePcSWncCsuHqK8Wjya5vxYYafrtA
 h8FZkhSYwqX2xvQZ/cntP2f5WhSdZcV3+Zqw2A==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The conditional logic is too complicated for the compiler to
fully comprehend:

lib/test_meminit.c: In function 'test_meminit_init':
lib/test_meminit.c:236:5: error: 'buf_copy' may be used uninitialized in this function [-Werror=maybe-uninitialized]
     kfree(buf_copy);
     ^~~~~~~~~~~~~~~
lib/test_meminit.c:201:14: note: 'buf_copy' was declared here

Simplify it by splitting out the non-rcu section.

Fixes: af734ee6ec85 ("lib: introduce test_meminit module")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 lib/test_meminit.c | 50 ++++++++++++++++++++++++----------------------
 1 file changed, 26 insertions(+), 24 deletions(-)

diff --git a/lib/test_meminit.c b/lib/test_meminit.c
index ed7efec1387b..7ae2183ff1f4 100644
--- a/lib/test_meminit.c
+++ b/lib/test_meminit.c
@@ -208,35 +208,37 @@ static int __init do_kmem_cache_size(size_t size, bool want_ctor,
 		/* Check that buf is zeroed, if it must be. */
 		fail = check_buf(buf, size, want_ctor, want_rcu, want_zero);
 		fill_with_garbage_skip(buf, size, want_ctor ? CTOR_BYTES : 0);
+
+		if (!want_rcu) {
+			kmem_cache_free(c, buf);
+			continue;
+		}
+
 		/*
 		 * If this is an RCU cache, use a critical section to ensure we
 		 * can touch objects after they're freed.
 		 */
-		if (want_rcu) {
-			rcu_read_lock();
-			/*
-			 * Copy the buffer to check that it's not wiped on
-			 * free().
-			 */
-			buf_copy = kmalloc(size, GFP_KERNEL);
-			if (buf_copy)
-				memcpy(buf_copy, buf, size);
-		}
-		kmem_cache_free(c, buf);
-		if (want_rcu) {
-			/*
-			 * Check that |buf| is intact after kmem_cache_free().
-			 * |want_zero| is false, because we wrote garbage to
-			 * the buffer already.
-			 */
-			fail |= check_buf(buf, size, want_ctor, want_rcu,
-					  false);
-			if (buf_copy) {
-				fail |= (bool)memcmp(buf, buf_copy, size);
-				kfree(buf_copy);
-			}
-			rcu_read_unlock();
+		rcu_read_lock();
+		/*
+		 * Copy the buffer to check that it's not wiped on
+		 * free().
+		 */
+		buf_copy = kmalloc(size, GFP_KERNEL);
+		if (buf_copy)
+			memcpy(buf_copy, buf, size);
+
+		/*
+		 * Check that |buf| is intact after kmem_cache_free().
+		 * |want_zero| is false, because we wrote garbage to
+		 * the buffer already.
+		 */
+		fail |= check_buf(buf, size, want_ctor, want_rcu,
+				  false);
+		if (buf_copy) {
+			fail |= (bool)memcmp(buf, buf_copy, size);
+			kfree(buf_copy);
 		}
+		rcu_read_unlock();
 	}
 	kmem_cache_destroy(c);
 
-- 
2.20.0

