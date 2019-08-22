Return-Path: <SRS0=/WLL=WS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6EB4DC3A5A1
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Aug 2019 15:59:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 33A7B2089E
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Aug 2019 15:59:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389669AbfHVP7W (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 22 Aug 2019 11:59:22 -0400
Received: from relay.sw.ru ([185.231.240.75]:58148 "EHLO relay.sw.ru"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389588AbfHVP7V (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Aug 2019 11:59:21 -0400
Received: from [172.16.25.5]
        by relay.sw.ru with esmtp (Exim 4.92)
        (envelope-from <aryabinin@virtuozzo.com>)
        id 1i0pUE-0000T6-2I; Thu, 22 Aug 2019 18:58:54 +0300
Subject: Re: [PATCH 1/2] riscv: Add memmove string operation.
To:     Nick Hu <nickhu@andestech.com>, alankao@andestech.com,
        paul.walmsley@sifive.com, palmer@sifive.com, aou@eecs.berkeley.edu,
        green.hu@gmail.com, deanbo422@gmail.com, tglx@linutronix.de,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        glider@google.com, dvyukov@google.com, Anup.Patel@wdc.com,
        gregkh@linuxfoundation.org, alexios.zavras@intel.com,
        atish.patra@wdc.com, zong@andestech.com, kasan-dev@googlegroups.com
References: <cover.1565161957.git.nickhu@andestech.com>
 <a6c24ce01dc40da10d58fdd30bc3e1316035c832.1565161957.git.nickhu@andestech.com>
From:   Andrey Ryabinin <aryabinin@virtuozzo.com>
Message-ID: <09d5108e-f0ba-13d3-be9e-119f49f6bd85@virtuozzo.com>
Date:   Thu, 22 Aug 2019 18:59:02 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <a6c24ce01dc40da10d58fdd30bc3e1316035c832.1565161957.git.nickhu@andestech.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/7/19 10:19 AM, Nick Hu wrote:
> There are some features which need this string operation for compilation,
> like KASAN. So the purpose of this porting is for the features like KASAN
> which cannot be compiled without it.
> 

Compilation error can be fixed by diff bellow (I didn't test it).
If you don't need memmove very early (before kasan_early_init()) than arch-specific not-instrumented memmove()
isn't necessary to have.

---
 mm/kasan/common.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/mm/kasan/common.c b/mm/kasan/common.c
index 6814d6d6a023..897f9520bab3 100644
--- a/mm/kasan/common.c
+++ b/mm/kasan/common.c
@@ -107,6 +107,7 @@ void *memset(void *addr, int c, size_t len)
 	return __memset(addr, c, len);
 }
 
+#ifdef __HAVE_ARCH_MEMMOVE
 #undef memmove
 void *memmove(void *dest, const void *src, size_t len)
 {
@@ -115,6 +116,7 @@ void *memmove(void *dest, const void *src, size_t len)
 
 	return __memmove(dest, src, len);
 }
+#endif
 
 #undef memcpy
 void *memcpy(void *dest, const void *src, size_t len)
-- 
2.21.0



