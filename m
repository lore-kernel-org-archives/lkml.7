Return-Path: <SRS0=FHjv=VA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9378FC5B578
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Jul 2019 08:11:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 730DA21882
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Jul 2019 08:11:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727231AbfGCILh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Jul 2019 04:11:37 -0400
Received: from mout.kundenserver.de ([212.227.126.133]:45825 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727046AbfGCILg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Jul 2019 04:11:36 -0400
Received: from threadripper.lan ([149.172.19.189]) by mrelayeu.kundenserver.de
 (mreue011 [212.227.15.129]) with ESMTPA (Nemesis) id
 1MzR0i-1iV4Li0jo0-00vQf3; Wed, 03 Jul 2019 10:11:22 +0200
From:   Arnd Bergmann <arnd@arndb.de>
To:     Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org, clang-built-linux@googlegroups.com
Subject: [PATCH] waitqueue: fix clang -Wuninitialized warnings
Date:   Wed,  3 Jul 2019 10:10:55 +0200
Message-Id: <20190703081119.209976-1-arnd@arndb.de>
X-Mailer: git-send-email 2.20.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:K19QOQm10YrblmzdHMiiEdH0R3Hfi5j9kdim9yq0TZ8m68yPfrf
 zc4ljV6rZgbNb0id7kRgg3RD20cRcEG//g7uqbs/KebGMidFMqq4jpSBc7lulwdbYZK8FZ+
 FGKhfX+OXwLKujaqMZwBzT3c1AaiU36nhDgSmMjfktF7JFW5grp9SL7zyClIEFJSIaHk5In
 NOKG2LRGrVD0S07O22/CA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:Mv1pXsjnFJI=:isvJAEUZheIz0k5bW5GLiZ
 RSjRwvdDkT3jk+TYdx8ttPYbD9rpOdHn9CN1Ekg90GpdroDrASnYRm7aCSudGdYmo/srOL++3
 ZlqC3aLqLO8BXorw1OE5ctCXoJzqkIzOi9omfeH8LEU8E2p2yjYhohhneLsSoTOXRmDh2rgIN
 JbVGvC4fFij2ZgYamHCNskRrVwbPIVH+MWAjJ+o3akXxXOQVvIzX2w168TkYeQy48EV0fvNZp
 Aw/vw7zs6fdMdL1RLk4NrTrq08Kw0tAbt8IS6oSCn4gPte1GaTPyhYUTh0vHtBumj3jBA68PN
 PklWJBz2fps63FcUzLJGUD+OHKdaSyz2MED9ADVke5xuzvr/Uj5gM12PiCjg4RtgbmE2mQVmj
 462A55diQqaSPrQPgyMB/SoFVssmCbtiIWlUiPXv8Nx0Dqx8yLs0XIpw7VqRuRkVoeoZQkaFe
 eBQmzHp+KYRSFtWgOl/waPSyXnWyn/iKCj6Gmsi7EHVwwimOJImbYHx4dtV/6YynkbBco/uUt
 ucUQU4YxCmKw36vikqD9wCT09E1TAI9mPr9TvXj/FvflQobgzIY4+Sex74PpJhu7L8Q+h4sll
 2xbzvdyR7yGz0CiKAY2jdwM/Yt2D2bP7N0zXJSWFeDa1G+jmhNMEItjKwPGU2F+EA6o8afvuw
 l0RF6z4eW186Ccsp4k+QrvdY37BC9ddZTHPKgW44b60IOZt9PDvlAsJKqLFjQkmyo6zXKIHCj
 oXVUJkyaADFe/4PHiW8PX1DN09EPmwv7Zr/vjg==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When CONFIG_LOCKDEP is set, every use of DECLARE_WAIT_QUEUE_HEAD_ONSTACK()
produces an annoying warning from clang, which is particularly annoying
for allmodconfig builds:

fs/namei.c:1646:34: error: variable 'wq' is uninitialized when used within its own initialization [-Werror,-Wuninitialized]
        DECLARE_WAIT_QUEUE_HEAD_ONSTACK(wq);
                                        ^~
include/linux/wait.h:74:63: note: expanded from macro 'DECLARE_WAIT_QUEUE_HEAD_ONSTACK'
        struct wait_queue_head name = __WAIT_QUEUE_HEAD_INIT_ONSTACK(name)
                               ~~~~                                  ^~~~
include/linux/wait.h:72:33: note: expanded from macro '__WAIT_QUEUE_HEAD_INIT_ONSTACK'
        ({ init_waitqueue_head(&name); name; })
                                       ^~~~

After playing with it for a while, I have found a way to rephrase the
macro in a way that should work well with both gcc and clang and not
produce this warning. The open-coded __WAIT_QUEUE_HEAD_INIT_ONSTACK
is a little more verbose than the original version by Peter Zijlstra,
but avoids the gcc-ism that suppresses warnings when assigning a
variable to itself.

Cc: Peter Zijlstra <peterz@infradead.org>
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 include/linux/wait.h | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/include/linux/wait.h b/include/linux/wait.h
index ddb959641709..84e39643b780 100644
--- a/include/linux/wait.h
+++ b/include/linux/wait.h
@@ -68,8 +68,15 @@ extern void __init_waitqueue_head(struct wait_queue_head *wq_head, const char *n
 	} while (0)
 
 #ifdef CONFIG_LOCKDEP
-# define __WAIT_QUEUE_HEAD_INIT_ONSTACK(name) \
-	({ init_waitqueue_head(&name); name; })
+# define __WAIT_QUEUE_HEAD_INIT_ONSTACK(name) {					\
+	.lock		= __SPIN_LOCK_UNLOCKED(name.lock),			\
+	.head		= ({							\
+		static struct lock_class_key __key;				\
+		lockdep_set_class_and_name(&(name).lock, &__key, # name);	\
+		(struct list_head){ &(name).head, &(name).head };		\
+	}),									\
+}
+
 # define DECLARE_WAIT_QUEUE_HEAD_ONSTACK(name) \
 	struct wait_queue_head name = __WAIT_QUEUE_HEAD_INIT_ONSTACK(name)
 #else
-- 
2.20.0

