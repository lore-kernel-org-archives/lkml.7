Return-Path: <SRS0=gj9M=VG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E811FC73C53
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Jul 2019 18:37:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C66112080C
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Jul 2019 18:37:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729037AbfGIShL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Jul 2019 14:37:11 -0400
Received: from mout.kundenserver.de ([217.72.192.75]:35105 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727666AbfGIShL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Jul 2019 14:37:11 -0400
Received: from threadripper.lan ([149.172.19.189]) by mrelayeu.kundenserver.de
 (mreue107 [212.227.15.145]) with ESMTPA (Nemesis) id
 1MmU1H-1iBULr1JYX-00iS69; Tue, 09 Jul 2019 20:36:26 +0200
From:   Arnd Bergmann <arnd@arndb.de>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Arnd Bergmann <arnd@arndb.de>, Marco Elver <elver@google.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Andrey Ryabinin <aryabinin@virtuozzo.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Alexander Potapenko <glider@google.com>,
        Andrey Konovalov <andreyknvl@google.com>,
        Christoph Lameter <cl@linux.com>,
        Pekka Enberg <penberg@kernel.org>,
        David Rientjes <rientjes@google.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Kees Cook <keescook@chromium.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Luc Van Oostenryck <luc.vanoostenryck@gmail.com>,
        "ndesaulniers@google.com" <ndesaulniers@google.com>,
        Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>,
        Ingo Molnar <mingo@kernel.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH] mm/kasan: fix kasan_check_read() compiler warning
Date:   Tue,  9 Jul 2019 20:35:40 +0200
Message-Id: <20190709183612.2693974-1-arnd@arndb.de>
X-Mailer: git-send-email 2.20.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:f9tLUWPoDVBA60LLEiX/NkMOqicieII3W/k/YIGKz7X2J9Lxb/h
 5riQyTf13phU14Nz5hQgZ+cFzoe84RnrWqOLP1PaXV1ZX4N5wC+wyB/+hrwnd5Ae7LeSZTA
 qhKdUB2jwKoIzuYwqlMcKX4C0H4tMxU76bpQTDI1UXvHOgcvWRuj1rgceDPbyGmT8DntxUn
 0o8CKBHmZ1d6Qw7SZg74g==
X-UI-Out-Filterresults: notjunk:1;V03:K0:IH6JMBtZ3W8=:d8iGHkyJLAZyJgAL5R+EKT
 wDHfL0miZNRPQrzvx9brg+EoYFDH+5liuU0k4GN8LTfX/WTZKJaiZyUcIm0V+Sgfwm0aIy49o
 yYAmWZdWGzJoPr2dILKw7YGqBILQxrbVqsn9KwipJSRvhzp9ke7mYQ9gyUd+Gqg6SyXa2p8qm
 oGeJUyScwk5YwWrnwQCNoBIcR2FKsn8Ws3Ea0gLruUbcuzySPux2m3g3NXMTokg2vQvky/msP
 f2Hg9KtBBeAt90bphBX0p5ogo7fXNrxTV/2W5EVfVaRfkNEL5nTEMnLVlyNEf1j31PH9Kbbd0
 IhbpmSigld2AQXAzmXl1DVfN9WDRzMwO5zVtqhin9FFImc7Q1mcvY1Ny3ZMIP1v0WALDOK2OY
 g6+0K9tWyYtBNz0sPgle8UL7oBGJksGCrNBHZw1iywlAjRdoSvqTrFTA9bppTgC/5Jhr8wUjt
 1PcHSxOY8rgE3AIRlXe/9+p1DbG/+XdA26x+n3l+xWxmNEbZtFBje9TN/aqE47mWlNP6ScnQd
 rhXQXh/P22dEdovRNYJSkbroGE9Fd7a3blYvQk2DBhc4n/ONGxz1UW/xyVYyVqLG2L2GKW3dS
 HBNLxoYMdca0CIDY/2CdJTHu/P/hoQ0KkAIKilsNjhZkVcpiUa29XeCJ+xVlm6i8hAr3FPXSt
 V2cOqL9+xIg5B6W3ErQwOiOLWeuTwLJUFEYDwzQTYq/gTNpE0Gty/M2WkHH1YZelrCl7XLhvS
 v/9SZ8DBn0EGEfs3U7sLn2fDmMWbLwtHBhaZFQ==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The kasan_check_read() is marked 'inline', which usually includes
the 'always_inline' attribute. In some configuration, gcc decides that
it cannot inline this, causing a build failure:

In file included from include/linux/compiler.h:257,
                 from arch/x86/include/asm/current.h:5,
                 from include/linux/sched.h:12,
                 from include/linux/ratelimit.h:6,
                 from fs/dcache.c:18:
include/linux/compiler.h: In function 'read_word_at_a_time':
include/linux/kasan-checks.h:31:20: error: inlining failed in call to always_inline 'kasan_check_read': function attribute mismatch
 static inline bool kasan_check_read(const volatile void *p, unsigned int size)
                    ^~~~~~~~~~~~~~~~
In file included from arch/x86/include/asm/current.h:5,
                 from include/linux/sched.h:12,
                 from include/linux/ratelimit.h:6,
                 from fs/dcache.c:18:
include/linux/compiler.h:280:2: note: called from here
  kasan_check_read(addr, 1);
  ^~~~~~~~~~~~~~~~~~~~~~~~~

While I have no idea why it does this, but changing the call to the
internal __kasan_check_read() fixes the issue.

Fixes: dc55b51f312c ("mm/kasan: introduce __kasan_check_{read,write}")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 include/linux/compiler.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/compiler.h b/include/linux/compiler.h
index f0fd5636fddb..22909500ba1d 100644
--- a/include/linux/compiler.h
+++ b/include/linux/compiler.h
@@ -277,7 +277,7 @@ static __always_inline void __write_once_size(volatile void *p, void *res, int s
 static __no_kasan_or_inline
 unsigned long read_word_at_a_time(const void *addr)
 {
-	kasan_check_read(addr, 1);
+	__kasan_check_read(addr, 1);
 	return *(unsigned long *)addr;
 }
 
-- 
2.20.0

