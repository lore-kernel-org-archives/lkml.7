Return-Path: <SRS0=OvUS=X5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNPARSEABLE_RELAY,USER_AGENT_SANE_2 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DA19BC47404
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Oct 2019 08:02:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B13EC2084D
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Oct 2019 08:02:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730869AbfJDICV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 4 Oct 2019 04:02:21 -0400
Received: from mailgw01.mediatek.com ([210.61.82.183]:32919 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1729252AbfJDICU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Oct 2019 04:02:20 -0400
X-UUID: 36bb4cb07a604004879dbefb87b1ff68-20191004
X-UUID: 36bb4cb07a604004879dbefb87b1ff68-20191004
Received: from mtkexhb02.mediatek.inc [(172.21.101.103)] by mailgw01.mediatek.com
        (envelope-from <walter-zh.wu@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.10 Build 0809 with TLS)
        with ESMTP id 585257250; Fri, 04 Oct 2019 16:02:12 +0800
Received: from mtkcas07.mediatek.inc (172.21.101.84) by
 mtkmbs07n1.mediatek.inc (172.21.101.16) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Fri, 4 Oct 2019 16:02:10 +0800
Received: from [172.21.84.99] (172.21.84.99) by mtkcas07.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
 Transport; Fri, 4 Oct 2019 16:02:10 +0800
Message-ID: <1570176131.19702.105.camel@mtksdccf07>
Subject: Re: [PATCH] kasan: fix the missing underflow in memmove and memcpy
 with CONFIG_KASAN_GENERIC=y
From:   Walter Wu <walter-zh.wu@mediatek.com>
To:     Dmitry Vyukov <dvyukov@google.com>
CC:     Andrey Ryabinin <aryabinin@virtuozzo.com>,
        Alexander Potapenko <glider@google.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        LKML <linux-kernel@vger.kernel.org>,
        kasan-dev <kasan-dev@googlegroups.com>,
        Linux-MM <linux-mm@kvack.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>,
        wsd_upstream <wsd_upstream@mediatek.com>
Date:   Fri, 4 Oct 2019 16:02:11 +0800
In-Reply-To: <1570164140.19702.97.camel@mtksdccf07>
References: <20190927034338.15813-1-walter-zh.wu@mediatek.com>
         <CACT4Y+Zxz+R=qQxSMoipXoLjRqyApD3O0eYpK0nyrfGHE4NNPw@mail.gmail.com>
         <1569594142.9045.24.camel@mtksdccf07>
         <CACT4Y+YuAxhKtL7ho7jpVAPkjG-JcGyczMXmw8qae2iaZjTh_w@mail.gmail.com>
         <1569818173.17361.19.camel@mtksdccf07>
         <1570018513.19702.36.camel@mtksdccf07>
         <CACT4Y+bbZhvz9ZpHtgL8rCCsV=ybU5jA6zFnJBL7gY2cNXDLyQ@mail.gmail.com>
         <1570069078.19702.57.camel@mtksdccf07>
         <CACT4Y+ZwNv2-QBrvuR2JvemovmKPQ9Ggrr=ZkdTg6xy_Ki6UAg@mail.gmail.com>
         <1570095525.19702.59.camel@mtksdccf07>
         <1570110681.19702.64.camel@mtksdccf07>
         <CACT4Y+aKrC8mtcDTVhM-So-TTLjOyFCD7r6jryWFH6i2he1WJA@mail.gmail.com>
         <1570164140.19702.97.camel@mtksdccf07>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.2.3-0ubuntu6 
Content-Transfer-Encoding: 7bit
MIME-Version: 1.0
X-MTK:  N
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2019-10-04 at 12:42 +0800, Walter Wu wrote:
> On Thu, 2019-10-03 at 16:53 +0200, Dmitry Vyukov wrote:
> > On Thu, Oct 3, 2019 at 3:51 PM Walter Wu <walter-zh.wu@mediatek.com> wrote:>
> > >
> > >  static void print_error_description(struct kasan_access_info *info)
> > >  {
> > > -       pr_err("BUG: KASAN: %s in %pS\n",
> > > -               get_bug_type(info), (void *)info->ip);
> > > -       pr_err("%s of size %zu at addr %px by task %s/%d\n",
> > > -               info->is_write ? "Write" : "Read", info->access_size,
> > > -               info->access_addr, current->comm, task_pid_nr(current));
> > > +       if ((long)info->access_size < 0) {
> > > +               pr_err("BUG: KASAN: invalid size %zu in %pS\n",
> > > +                       info->access_size, (void *)info->ip);
> > 
> > I would not introduce a new bug type.
> > These are parsed and used by some systems, e.g. syzbot. If size is
> > user-controllable, then a new bug type for this will mean 2 bug
> > reports.
> > It also won't harm to print Read/Write, definitely the address, so no
> > reason to special case this out of a dozen of report formats.
> > This can qualify as out-of-bounds (definitely will cross some
> > bounds!), so I would change get_bug_type() to return
> > "slab-out-of-bounds" (as the most common OOB) in such case (with a
> > comment).
> > 
> Print Read/Write and address information, it is ok.
> But if we can directly point to the root cause of this problem, why we
> not do it?  see 1) and 2) to get a point, if we print OOB, then user
> needs one minute to think what is root case of this problem, but if we
> print invalid size, then user can directly get root case. this is my
> original thinking.
> 1)Invalid size is true then OOB is true.
> 2)OOB is true then invalid size may be true or false.
> 
> But I see you say some systems have used bug report so that avoid this
> trouble, i will print the wrong type is "out-of-bound" in a unified way
> when size<0.
> 

Updated my patch, please help to review it. 
thanks.

commit 13e10a7e4264eb25c5a14193068027afc9c261f6
Author: Walter-zh Wu <walter-zh.wu@mediatek.com>
Date:   Fri Oct 4 15:27:17 2019 +0800

    kasan: detect negative size in memory operation function
    
    It is an undefined behavior to pass a negative value to
memset()/memcpy()/memmove()
    , so need to be detected by KASAN.
    
    If size is negative value, then it will be larger than ULONG_MAX/2,
    so that we will qualify as out-of-bounds issue.
    
    KASAN report:
    
     BUG: KASAN: out-of-bounds in kmalloc_memmove_invalid_size+0x70/0xa0
     Read of size 18446744073709551608 at addr ffffff8069660904 by task
cat/72
    
     CPU: 2 PID: 72 Comm: cat Not tainted
5.4.0-rc1-next-20191004ajb-00001-gdb8af2f372b2-dirty #1
     Hardware name: linux,dummy-virt (DT)
     Call trace:
      dump_backtrace+0x0/0x288
      show_stack+0x14/0x20
      dump_stack+0x10c/0x164
      print_address_description.isra.9+0x68/0x378
      __kasan_report+0x164/0x1a0
      kasan_report+0xc/0x18
      check_memory_region+0x174/0x1d0
      memmove+0x34/0x88
      kmalloc_memmove_invalid_size+0x70/0xa0
    
    [1] https://bugzilla.kernel.org/show_bug.cgi?id=199341
    
    Signed-off-by: Walter Wu <walter-zh.wu@mediatek.com>
    Reported -by: Dmitry Vyukov <dvyukov@google.com>
    Suggested-by: Dmitry Vyukov <dvyukov@google.com>

diff --git a/lib/test_kasan.c b/lib/test_kasan.c
index 49cc4d570a40..06942cf585cc 100644
--- a/lib/test_kasan.c
+++ b/lib/test_kasan.c
@@ -283,6 +283,23 @@ static noinline void __init
kmalloc_oob_in_memset(void)
 	kfree(ptr);
 }
 
+static noinline void __init kmalloc_memmove_invalid_size(void)
+{
+	char *ptr;
+	size_t size = 64;
+
+	pr_info("invalid size in memmove\n");
+	ptr = kmalloc(size, GFP_KERNEL);
+	if (!ptr) {
+		pr_err("Allocation failed\n");
+		return;
+	}
+
+	memset((char *)ptr, 0, 64);
+	memmove((char *)ptr, (char *)ptr + 4, -2);
+	kfree(ptr);
+}
+
 static noinline void __init kmalloc_uaf(void)
 {
 	char *ptr;
@@ -773,6 +790,7 @@ static int __init kmalloc_tests_init(void)
 	kmalloc_oob_memset_4();
 	kmalloc_oob_memset_8();
 	kmalloc_oob_memset_16();
+	kmalloc_memmove_invalid_size();
 	kmalloc_uaf();
 	kmalloc_uaf_memset();
 	kmalloc_uaf2();
diff --git a/mm/kasan/common.c b/mm/kasan/common.c
index 6814d6d6a023..97dd6eecc3e7 100644
--- a/mm/kasan/common.c
+++ b/mm/kasan/common.c
@@ -102,7 +102,8 @@ EXPORT_SYMBOL(__kasan_check_write);
 #undef memset
 void *memset(void *addr, int c, size_t len)
 {
-	check_memory_region((unsigned long)addr, len, true, _RET_IP_);
+	if (!check_memory_region((unsigned long)addr, len, true, _RET_IP_))
+		return NULL;
 
 	return __memset(addr, c, len);
 }
@@ -110,7 +111,8 @@ void *memset(void *addr, int c, size_t len)
 #undef memmove
 void *memmove(void *dest, const void *src, size_t len)
 {
-	check_memory_region((unsigned long)src, len, false, _RET_IP_);
+	if (!check_memory_region((unsigned long)src, len, false, _RET_IP_))
+		return NULL;
 	check_memory_region((unsigned long)dest, len, true, _RET_IP_);
 
 	return __memmove(dest, src, len);
@@ -119,7 +121,8 @@ void *memmove(void *dest, const void *src, size_t
len)
 #undef memcpy
 void *memcpy(void *dest, const void *src, size_t len)
 {
-	check_memory_region((unsigned long)src, len, false, _RET_IP_);
+	if (!check_memory_region((unsigned long)src, len, false, _RET_IP_))
+		return NULL;
 	check_memory_region((unsigned long)dest, len, true, _RET_IP_);
 
 	return __memcpy(dest, src, len);
diff --git a/mm/kasan/generic.c b/mm/kasan/generic.c
index 616f9dd82d12..02148a317d27 100644
--- a/mm/kasan/generic.c
+++ b/mm/kasan/generic.c
@@ -173,6 +173,11 @@ static __always_inline bool
check_memory_region_inline(unsigned long addr,
 	if (unlikely(size == 0))
 		return true;
 
+	if (unlikely((long)size < 0)) {
+		kasan_report(addr, size, write, ret_ip);
+		return false;
+	}
+
 	if (unlikely((void *)addr <
 		kasan_shadow_to_mem((void *)KASAN_SHADOW_START))) {
 		kasan_report(addr, size, write, ret_ip);
diff --git a/mm/kasan/generic_report.c b/mm/kasan/generic_report.c
index 36c645939bc9..ae9596210394 100644
--- a/mm/kasan/generic_report.c
+++ b/mm/kasan/generic_report.c
@@ -107,6 +107,13 @@ static const char *get_wild_bug_type(struct
kasan_access_info *info)
 
 const char *get_bug_type(struct kasan_access_info *info)
 {
+	/*
+	 * if access_size < 0, then it will be larger than ULONG_MAX/2,
+	 * so that this can qualify as out-of-bounds.
+	 */
+	if ((long)info->access_size < 0)
+		return "out-of-bounds";
+
 	if (addr_has_shadow(info->access_addr))
 		return get_shadow_bug_type(info);
 	return get_wild_bug_type(info);
diff --git a/mm/kasan/tags.c b/mm/kasan/tags.c
index 0e987c9ca052..b829535a3ad7 100644
--- a/mm/kasan/tags.c
+++ b/mm/kasan/tags.c
@@ -86,6 +86,11 @@ bool check_memory_region(unsigned long addr, size_t
size, bool write,
 	if (unlikely(size == 0))
 		return true;
 
+	if (unlikely((long)size < 0)) {
+		kasan_report(addr, size, write, ret_ip);
+		return false;
+	}
+
 	tag = get_tag((const void *)addr);
 
 	/*
diff --git a/mm/kasan/tags_report.c b/mm/kasan/tags_report.c
index 969ae08f59d7..1e1ca81214b5 100644
--- a/mm/kasan/tags_report.c
+++ b/mm/kasan/tags_report.c
@@ -36,6 +36,13 @@
 
 const char *get_bug_type(struct kasan_access_info *info)
 {
+	/*
+	 * if access_size < 0, then it will be larger than ULONG_MAX/2,
+	 * so that this can qualify as out-of-bounds.
+	 */
+	if ((long)info->access_size < 0)
+		return "out-of-bounds";
+
 #ifdef CONFIG_KASAN_SW_TAGS_IDENTIFY
 	struct kasan_alloc_meta *alloc_meta;
 	struct kmem_cache *cache;


