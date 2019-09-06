Return-Path: <SRS0=GGWy=XB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7DFDFC43331
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Sep 2019 15:32:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 503EC20838
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Sep 2019 15:32:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2394854AbfIFPc5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 6 Sep 2019 11:32:57 -0400
Received: from mout.kundenserver.de ([212.227.126.135]:58731 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725871AbfIFPc5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Sep 2019 11:32:57 -0400
Received: from threadripper.lan ([149.172.19.189]) by mrelayeu.kundenserver.de
 (mreue009 [212.227.15.129]) with ESMTPA (Nemesis) id
 1MHX3R-1htHnP36g5-00DWTJ; Fri, 06 Sep 2019 17:32:50 +0200
From:   Arnd Bergmann <arnd@arndb.de>
To:     David Howells <dhowells@redhat.com>
Cc:     Arnd Bergmann <arnd@arndb.de>, Jann Horn <jannh@google.com>,
        Jens Axboe <axboe@kernel.dk>, linux-kernel@vger.kernel.org
Subject: [PATCH 1/2] watch_queue: make locked_vm accessible
Date:   Fri,  6 Sep 2019 17:32:35 +0200
Message-Id: <20190906153249.1864324-1-arnd@arndb.de>
X-Mailer: git-send-email 2.20.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:sbgYIj3sTLe6oQpfz0v9JJ1XPJHhKbHYyyuMMQMqloTgfI7J+rF
 Ggq9j5ylWWGi582FcXvRN3IlkRObdarvjkKJ7QeB3fpN6usSCoV07tXKS/LeXsYbpHkL7c5
 FbZKF6TFQ3hJ8diapQciK0ZYmZJubNGw4ACvb7hbXVURJYIBqz/d1iplTY2jJ2JdELKLP4w
 h/ASi/JKgrIV2x89Tgdbg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:3hY4TUfEVzk=:stupZYSdkkZxNkZrc4/bey
 8HMh1FzR2V4l5qYWkBYMCbQpwkofK81n8wx1tUIS2l+9OTzIbq0Vv/k6ufDxj28RmK47JQETv
 rJq3fyYpp55OBqyg6F573sZCvC2xqyeWm6nBs8eElmuV3O2KEW4pJhn1c8Twu0IxmNp3+3YJZ
 2gcJr0cbQr3pL77PVSOlEElQkzMEmj0PVKPaRj+sRefo/cKAn7bxJeUeVwCZPKSOuEIntcZq8
 nQKeTgKnTa1qJt9cPN5gUhl9ussoBRJWTqEX7vxUVjwOHD1UVYZW0Jvi7htMyHkin8B/MOIYs
 HC6xHOTiTIueai4vT5WaiVTyfGFwy5KTSQfR9XueP8z/fZvjhesTiCG8HgTS5OtYej2JD7VL/
 osPH50qi5pQ3kEA62ibhd0IBWULDoynEUm3zKAUTcGkT6ttaX5rlNi298m3FiGn6NXjtXbsbP
 4oE3jRXkJ5P/yKCgVN7RZEygsgxbYBj6DKACcWunzS3E14/nySVYw7CjaPUNw8FwpZ9jVyyFa
 N7iNbZQdWI+QN9CykkICxjD3V7p7RwchXasFta83oEQu1T4KK6fYkOKJXrXg+aZDSrcgwb1Mq
 rMvzds3+93dP5IqAY+IYpt+qAgAYnOsRV2IlMr5mUicOQawclzp+oZIXs9SU0TyKXo/UyJ41c
 8OOlW6DjWntvKBduRZn81tOxqLCbrdsSG59UymiKmslSqg0Gyzx9x8GDOl3RhO65orZHEA4Tz
 ocBlmv8vGfsnRZKY9wZDrvjtkV5EnRNWga5x7unk+bCRpPr6Plu7M73TvMfqKbyJHees80AVc
 U+fc6PAerA+gWKYzEC2V95fi/UxS8gDjiZ+VWo/kuBngcrGDiQ=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The locked_vm member of struct user_struct is guarded by an #ifdef,
which breaks building the new watch_queue driver when all the other
subsystems that need it are disabled:

drivers/misc/watch_queue.c:315:38: error: no member named 'locked_vm' in 'struct user_struct'; did you mean 'locked_shm'?

Add watch_queue to the list.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 include/linux/sched/user.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/sched/user.h b/include/linux/sched/user.h
index 917d88edb7b9..6cd21c7bb83e 100644
--- a/include/linux/sched/user.h
+++ b/include/linux/sched/user.h
@@ -33,7 +33,7 @@ struct user_struct {
 	kuid_t uid;
 
 #if defined(CONFIG_PERF_EVENTS) || defined(CONFIG_BPF_SYSCALL) || \
-    defined(CONFIG_NET) || defined(CONFIG_IO_URING)
+    defined(CONFIG_NET) || defined(CONFIG_IO_URING) || defined(CONFIG_WATCH_QUEUE)
 	atomic_long_t locked_vm;
 #endif
 
-- 
2.20.0

