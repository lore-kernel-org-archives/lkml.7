Return-Path: <SRS0=TLrx=2G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNPARSEABLE_RELAY,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C63A5C43603
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Dec 2019 03:07:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A29F524679
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Dec 2019 03:07:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726682AbfLPDHM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 15 Dec 2019 22:07:12 -0500
Received: from out30-131.freemail.mail.aliyun.com ([115.124.30.131]:46682 "EHLO
        out30-131.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726528AbfLPDHM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 15 Dec 2019 22:07:12 -0500
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R111e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01f04427;MF=shile.zhang@linux.alibaba.com;NM=1;PH=DS;RN=13;SR=0;TI=SMTPD_---0Tl.YiWC_1576465628;
Received: from ali-6c96cfdd1403.local(mailfrom:shile.zhang@linux.alibaba.com fp:SMTPD_---0Tl.YiWC_1576465628)
          by smtp.aliyun-inc.com(127.0.0.1);
          Mon, 16 Dec 2019 11:07:08 +0800
Subject: Re: [RFC PATCH v6 0/7] Speed booting by sorting ORC unwind tables at
 build time
To:     Ingo Molnar <mingo@kernel.org>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Michal Marek <michal.lkml@markovi.net>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Andy Lutomirski <luto@amacapital.net>, x86@kernel.org,
        "H . Peter Anvin" <hpa@zytor.com>, linux-kernel@vger.kernel.org,
        linux-kbuild@vger.kernel.org
References: <20191204004633.88660-1-shile.zhang@linux.alibaba.com>
 <20191213100244.GB113121@gmail.com>
From:   Shile Zhang <shile.zhang@linux.alibaba.com>
Message-ID: <c9c81536-2afc-c8aa-c5f8-c7618ecd4f54@linux.alibaba.com>
Date:   Mon, 16 Dec 2019 11:07:29 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.14; rv:60.0)
 Gecko/20100101 Thunderbird/60.9.1
MIME-Version: 1.0
In-Reply-To: <20191213100244.GB113121@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 2019/12/13 18:02, Ingo Molnar wrote:
>    arch/x86/kernel/unwind_orc.c:210:12: warning: ‘orc_sort_cmp’ defined but not used [-Wunused-function]
>    arch/x86/kernel/unwind_orc.c:190:13: warning: ‘orc_sort_swap’ defined but not used [-Wunused-function]
Hi Ingo,

Sorry for trouble! please help to check the warning-fix patch.
Thanks!

---
 From b3d34213b4fe5a9cf2efcc1c758a5fb6c5f7676b Mon Sep 17 00:00:00 2001
From: Shile Zhang <shile.zhang@linux.alibaba.com>
Date: Mon, 16 Dec 2019 10:56:03 +0800
Subject: [PATCH] x86/unwind/orc: fix build warning
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

To fix follwowing warning due to ORC sort moved to build time:

arch/x86/kernel/unwind_orc.c:210:12: warning: ‘orc_sort_cmp’ defined but 
not used [-Wunused-function]
arch/x86/kernel/unwind_orc.c:190:13: warning: ‘orc_sort_swap’ defined 
but not used [-Wunused-function]

Signed-off-by: Shile Zhang <shile.zhang@linux.alibaba.com>
---
  arch/x86/kernel/unwind_orc.c | 2 +-
  1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/kernel/unwind_orc.c b/arch/x86/kernel/unwind_orc.c
index 280da6fa9922..2391874b724a 100644
--- a/arch/x86/kernel/unwind_orc.c
+++ b/arch/x86/kernel/unwind_orc.c
@@ -187,6 +187,7 @@ static struct orc_entry *orc_find(unsigned long ip)
         return orc_ftrace_find(ip);
  }

+#ifdef CONFIG_MODULES
  static void orc_sort_swap(void *_a, void *_b, int size)
  {
         struct orc_entry *orc_a, *orc_b;
@@ -229,7 +230,6 @@ static int orc_sort_cmp(const void *_a, const void *_b)
         return orc_a->sp_reg == ORC_REG_UNDEFINED && !orc_a->end ? -1 : 1;
  }

-#ifdef CONFIG_MODULES
  void unwind_module_init(struct module *mod, void *_orc_ip, size_t 
orc_ip_size,
                         void *_orc, size_t orc_size)
  {
--
2.24.0.rc2
