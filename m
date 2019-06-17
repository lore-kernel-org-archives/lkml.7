Return-Path: <SRS0=xALZ=UQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2B37BC31E57
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Jun 2019 13:04:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E9E8D2089E
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Jun 2019 13:04:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727715AbfFQNEf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Jun 2019 09:04:35 -0400
Received: from mout.kundenserver.de ([217.72.192.74]:41383 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726061AbfFQNEf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jun 2019 09:04:35 -0400
Received: from threadripper.lan ([149.172.19.189]) by mrelayeu.kundenserver.de
 (mreue108 [212.227.15.145]) with ESMTPA (Nemesis) id
 1M3DFj-1hdfaV1WAf-003en6; Mon, 17 Jun 2019 15:04:30 +0200
From:   Arnd Bergmann <arnd@arndb.de>
To:     Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Souptick Joarder <jrdr.linux@gmail.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH] hwtracing: msu: fix unused variable warning
Date:   Mon, 17 Jun 2019 15:04:14 +0200
Message-Id: <20190617130428.1887747-1-arnd@arndb.de>
X-Mailer: git-send-email 2.20.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:lGUZlVxJqOQBQmQ9iUiDEzoVXLYKfl+YXBQQYNkGzkzxMD1DP6W
 jAESrOf2EpzPLzelhWZdeKxOkhF+PxC/FzKcinBJTtLN1AP8TYQSr1CrnfbVUG7+ncVXz0v
 AO2lOdt2Tfq9+1tXY5rkVe4yzSyDl9v/mR6ScwaHUi5rIEpzl+tNEEC1MvqVw+6tfB2qj94
 tuhI3MjhyKF5UlrY+K46A==
X-UI-Out-Filterresults: notjunk:1;V03:K0:3Y6m1GkNDTQ=:1ZPizRrzBZ7XQNGey5hHIP
 BYwydtTGS2++A00RVB+nZjtuXyqW9FMmzTUIOC+8D2iMKzH9fyI5dgwGSePhhhZpHIHyoEY69
 xO1KBrGr70gBXMjmSdokNY/HFkAaZzUHpqXu0iV6nFTy0e9rIiuQZcb+W/Y/yxmx/LbrqPOf7
 rdvg/Sr5yDiMFvbv+sMCg7MKsgKXxRI3kqUSYokZHvF6VYWuI7oHD2B2D+IKVoh7s9YJLEuA+
 YRcng59ZDwgmw0kc3Titwku6dkFMMDCJ8JO7qqFbQ0UNG6UL4kU8pb1beqfUVbE6b8cOJI2Xn
 B1YJ68N2TfF57Ld54WFoOhp2n0Sb277P2qCrfPZ43VFtoeBMpsCcKxXKCXtbGg8S8XWPDBJPb
 qs3EVcCS5srpP5deR1k1cCu0D0ynFbGuOqCr6oqFO1UBu2zhyGY76ZFXrzzg0yYqMQwV/GFW5
 h76QAiFPiWyVT8BqSRh1jijgihjwHSjGblmQ9Xpj6GEYmoD+z8HtuEAuJ7wXIPqMy/r1I1C6x
 ja+F+I6/+pebFiUr6nj17gsiGykfFvnukmnjyg+bU7Ll1TMQuBhanfs1ZakNXyT/bpvooeRFD
 cr+MsGLFbNj3n0Qac2409lVImIhlZ1lhz3Igphgtmpj1vvcNXvJE9ueT9eRm9CkaQXjeYIfQG
 s6XCgjv5y7ff9MfHrXP9tbhgLQfcXQIgBBVbwYLos8UvdsaF9TI0VuUfSfcl5hGaVd66e91uy
 ZAYa6xhhXplhpYLZ2PPi/mXen9LdM7ZA6cZ5EQ==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On non-x86 builds, we now get a harmless warning:

drivers/hwtracing/intel_th/msu.c:783:21: error: unused variable 'i' [-Werror,-Wunused-variable]
        int ret = -ENOMEM, i;
                           ^
drivers/hwtracing/intel_th/msu.c:863:6: error: unused variable 'i' [-Werror,-Wunused-variable]
        int i;
            ^

Add the matching #ifdef.

Fixes: ba39bd830605 ("intel_th: msu: Switch over to scatterlist")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/hwtracing/intel_th/msu.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/hwtracing/intel_th/msu.c b/drivers/hwtracing/intel_th/msu.c
index 81bb54fa3ce8..833a5a8f13ad 100644
--- a/drivers/hwtracing/intel_th/msu.c
+++ b/drivers/hwtracing/intel_th/msu.c
@@ -780,7 +780,10 @@ static int __msc_buffer_win_alloc(struct msc_window *win,
 static int msc_buffer_win_alloc(struct msc *msc, unsigned int nr_blocks)
 {
 	struct msc_window *win;
-	int ret = -ENOMEM, i;
+	int ret = -ENOMEM;
+#ifdef CONFIG_X86
+	int i;
+#endif
 
 	if (!nr_blocks)
 		return 0;
@@ -860,7 +863,9 @@ static void __msc_buffer_win_free(struct msc *msc, struct msc_window *win)
  */
 static void msc_buffer_win_free(struct msc *msc, struct msc_window *win)
 {
+#ifdef CONFIG_X86
 	int i;
+#endif
 
 	msc->nr_pages -= win->nr_blocks;
 
-- 
2.20.0

