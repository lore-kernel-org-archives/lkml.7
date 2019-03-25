Return-Path: <SRS0=yZjE=R4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB54BC43381
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Mar 2019 12:59:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7509A20830
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Mar 2019 12:59:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731333AbfCYM7J (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Mar 2019 08:59:09 -0400
Received: from mout.kundenserver.de ([212.227.17.10]:37757 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731076AbfCYM7J (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Mar 2019 08:59:09 -0400
Received: from wuerfel.lan ([149.172.19.189]) by mrelayeu.kundenserver.de
 (mreue106 [212.227.15.145]) with ESMTPA (Nemesis) id
 1N7AAk-1gtvjC2hYa-017WsT; Mon, 25 Mar 2019 13:58:10 +0100
From:   Arnd Bergmann <arnd@arndb.de>
To:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Will Deacon <will.deacon@arm.com>
Cc:     clang-built-linux@googlegroups.com,
        Nick Desaulniers <ndesaulniers@google.com>,
        Nathan Chancellor <natechancellor@gmail.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Bart Van Assche <bvanassche@acm.org>,
        Waiman Long <longman@redhat.com>,
        "Joel Fernandes (Google)" <joel@joelfernandes.org>,
        "Steven Rostedt (VMware)" <rostedt@goodmis.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH] lockdep: avoid bogus clang warning
Date:   Mon, 25 Mar 2019 13:57:57 +0100
Message-Id: <20190325125807.1437049-1-arnd@arndb.de>
X-Mailer: git-send-email 2.20.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:0JalITWuNlbGqFMWf9YPNNXCWWUj21kBnB2vH7FtjIP/ktkihCw
 5HK5xvrpIjZDO4dtalArBgT5e8vsk0eqzK+BGsRPdkYpl3T9ElR3Fm946BO+r/k/DRRsapw
 5Wyiu1+Rz9NnxYd4TfYJPZa5DC3joUl5P+j5u1Tt++fjU7nS3x+hHRQYc/c9a494JY5uTiu
 IZbq8xmlU8kwg0zN7EunA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:vuakBT5w3FA=:hSdnnqgKKJeV+VQOcavrmK
 maXlRfkopN986NZHq/koC9j58NRJ1Nx/chb5Uaz0sQ+gk+6eKY0WbiGg4VQ4+8H4g6qxyrb27
 q7vlGWXhPDVc5I2kT7fHKvDIW1nqto8VTR1nbKnqbCBpIZfRfmB+yPCEvFnuZstjuMp6XSG/k
 DW5Mo6+6/m0d3wWRf2BDKGPIGGZ79+hVmwdtuxhJKBsvoFTg4ka/KJLHWJCWfgAwixWe7IiQU
 m3T4Dq2Omfzp4WehUPffL06XWRi29S2++OgpjeyOy/HwP+t6WUU39Ti2k7MdDmYh4PWNLa1Eb
 nuhN+6mQ6vz09O60+GvM/ABEZvexRebYwNp+xNcS/jQ3t9RWf+9vOYsoIoOuaSXZfDVybzAx2
 DXmc2O4VqRLIA1qe1F5d+EfLkwTbV9J8C6A8gIPDGeajS4jfG+CPZDtGK6QXztl0JMyrWOV4i
 kfbXAex/3RmyJcPTKxXhP31ncaIBLOm+beunBoG+dkFOQeYPxX/Y/IkSV+MKFls/WsrpgvYRr
 koQ34AlqLwEEvKt8c3aJrfiqgOdSKUa3tIJX5n/fd59BXmLsPBZhbZn+R2zUbxlF3cTtGqfsf
 C3CQFuF6xbD182nqDjQxtXOBopNtw+Jn7DLUc9rIw7KVXBU0q+eqdq45qfCjRgeTuCbcjWXpS
 yzME8HQ6/HM7wO+fRoLB3CPDV6x3QaeGAdG1uUIF9qMpZeeqrDT4jMp/fv3V8FQ0rQ9AnjxGC
 cfsU+FsPUY3VKXF78xczqJTPIodkbtjDZIy8Pw==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When lockdep is enabled, and -Wuninitialized warnings are enabled,
clang produces a silly warning for every file we compile:

In file included from  kernel/sched/fair.c:23:
 kernel/sched/sched.h:1094:15: error: variable 'cookie' is uninitialized when used here [-Werror,-Wuninitialized]
        rf->cookie = lockdep_pin_lock(&rq->lock);
                     ^~~~~~~~~~~~~~~~~~~~~~~~~~~
 include/linux/lockdep.h:474:60: note: expanded from macro 'lockdep_pin_lock'
 #define lockdep_pin_lock(l)                     ({ struct pin_cookie cookie; cookie; })
                                                                             ^~~~~~
 kernel/sched/sched.h:1094:15: note: variable 'cookie' is declared here
 include/linux/lockdep.h:474:34: note: expanded from macro 'lockdep_pin_lock'
 #define lockdep_pin_lock(l)                     ({ struct pin_cookie cookie; cookie; })
                                                   ^
As the 'struct pin_cookie' structure is empty in this configuration,
there is no need to initialize it for correctness, but it also
does not hurt to set it to an empty structure, so do that to
avoid the warning.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 include/linux/lockdep.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/lockdep.h b/include/linux/lockdep.h
index 79c3873d58ac..31d7549933eb 100644
--- a/include/linux/lockdep.h
+++ b/include/linux/lockdep.h
@@ -471,7 +471,7 @@ struct pin_cookie { };
 
 #define NIL_COOKIE (struct pin_cookie){ }
 
-#define lockdep_pin_lock(l)			({ struct pin_cookie cookie; cookie; })
+#define lockdep_pin_lock(l)			({ struct pin_cookie cookie = {}; cookie; })
 #define lockdep_repin_lock(l, c)		do { (void)(l); (void)(c); } while (0)
 #define lockdep_unpin_lock(l, c)		do { (void)(l); (void)(c); } while (0)
 
-- 
2.20.0

