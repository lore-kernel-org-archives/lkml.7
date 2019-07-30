Return-Path: <SRS0=Iew4=V3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.2 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8F1F5C32750
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jul 2019 22:39:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5D27A206A2
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jul 2019 22:39:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729316AbfG3Wjb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Jul 2019 18:39:31 -0400
Received: from mail-qk1-f196.google.com ([209.85.222.196]:35370 "EHLO
        mail-qk1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726640AbfG3Wja (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Jul 2019 18:39:30 -0400
Received: by mail-qk1-f196.google.com with SMTP id r21so47843172qke.2
        for <linux-kernel@vger.kernel.org>; Tue, 30 Jul 2019 15:39:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=cvwi8Xd+Csul2yItUt7RyLTrCNwkd7JVVPpXg+i4cxg=;
        b=hA/vX/6LKVxjQePcZpLVj+ME9FzHsNf1VbuFnCFA5QedhGwxDAQFedhFpCCxUBVE2q
         aEK3LGFQyc/1ROIeT0vKp42RPE/l4vAPBV4picMsCGp+tnyuJFdCAKzFMTbT3x6ShRUA
         /4+ULoNHTmzlRcmyM5h8WhEQ2ATJXKREaDpvgnES3JNII+I++/eQoR8qjHJcmcDfIkd6
         D/6+2tadP/10XRhax1bCwknvhj5L2VbtkCrBAOBIXIgRTeBi+YwV3oSm4l0pH6QtN755
         Q6K8J/8lng4yOZzoIqewGsRQnWCWoODcsOqUX9DlJyhYsnGK2bkhWCyFQvIknIxMeoOJ
         6xow==
X-Gm-Message-State: APjAAAXlTWHHly45WzsrT6pLnE+E2NJrMRCt62CquhV6s0H5hYyG+ykU
        zsFuAo81UwA+0oDRAXx87sAiLg==
X-Google-Smtp-Source: APXvYqz2NUczUEUA886YI9clQ6DkOKaNJ4f4gPhwRJ4DQ78Jeo0/WqtVZRoxwyz7BnID96IaEuMwcw==
X-Received: by 2002:a37:bf07:: with SMTP id p7mr74569510qkf.315.1564526369227;
        Tue, 30 Jul 2019 15:39:29 -0700 (PDT)
Received: from [192.168.1.157] (pool-96-235-39-235.pitbpa.fios.verizon.net. [96.235.39.235])
        by smtp.gmail.com with ESMTPSA id e8sm27710104qkn.95.2019.07.30.15.39.27
        (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
        Tue, 30 Jul 2019 15:39:28 -0700 (PDT)
Subject: Re: [mm] 6471384af2: kernel_BUG_at_mm/slub.c
To:     kernel test robot <rong.a.chen@intel.com>,
        Alexander Potapenko <glider@google.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Kees Cook <keescook@chromium.org>,
        Christoph Lameter <cl@linux.com>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Kostya Serebryany <kcc@google.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Sandeep Patil <sspatil@android.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        Jann Horn <jannh@google.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Marco Elver <elver@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>, lkp@01.org
References: <20190729094316.GN22106@shao2-debian>
From:   Laura Abbott <labbott@redhat.com>
Message-ID: <538637ba-f4e3-0dfa-cb13-3aee51c659bd@redhat.com>
Date:   Tue, 30 Jul 2019 18:39:27 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <20190729094316.GN22106@shao2-debian>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/29/19 5:43 AM, kernel test robot wrote:
> FYI, we noticed the following commit (built with gcc-7):
> 
> commit: 6471384af2a6530696fc0203bafe4de41a23c9ef ("mm: security: introduce init_on_alloc=1 and init_on_free=1 boot options")
> https://kernel.googlesource.com/pub/scm/linux/kernel/git/torvalds/linux.git master
> 
> in testcase: trinity
> with following parameters:
> 
> 	runtime: 300s
> 
> test-description: Trinity is a linux system call fuzz tester.
> test-url: http://codemonkey.org.uk/projects/trinity/
> 
> 
> on test machine: qemu-system-x86_64 -enable-kvm -cpu SandyBridge -smp 2 -m 8G
> 
> caused below changes (please refer to attached dmesg/kmsg for entire log/backtrace):
> 
> 
> +------------------------------------------+------------+------------+
> |                                          | ba5c5e4a5d | 6471384af2 |
> +------------------------------------------+------------+------------+
> | boot_successes                           | 8          | 0          |
> | boot_failures                            | 2          | 15         |
> | invoked_oom-killer:gfp_mask=0x           | 1          |            |
> | Mem-Info                                 | 1          |            |
> | kernel_BUG_at_security/keys/keyring.c    | 1          |            |
> | invalid_opcode:#[##]                     | 1          | 15         |
> | RIP:__key_link_begin                     | 1          |            |
> | Kernel_panic-not_syncing:Fatal_exception | 1          | 15         |
> | kernel_BUG_at_mm/slub.c                  | 0          | 15         |
> | RIP:kfree                                | 0          | 15         |
> +------------------------------------------+------------+------------+
> 
> 
> If you fix the issue, kindly add following tag
> Reported-by: kernel test robot <rong.a.chen@intel.com>
> 
> 
> [    4.478342] kernel BUG at mm/slub.c:306!
> [    4.482437] invalid opcode: 0000 [#1] PREEMPT PTI
> [    4.485750] CPU: 0 PID: 0 Comm: swapper Not tainted 5.2.0-05754-g6471384a #4
> [    4.490635] RIP: 0010:kfree+0x58a/0x5c0
> [    4.493679] Code: 48 83 05 78 37 51 02 01 0f 0b 48 83 05 7e 37 51 02 01 48 83 05 7e 37 51 02 01 48 83 05 7e 37 51 02 01 48 83 05 d6 37 51 02 01 <0f> 0b 48 83 05 d4 37 51 02 01 48 83 05 d4 37 51 02 01 48 83 05 d4
> [    4.506827] RSP: 0000:ffffffff82603d90 EFLAGS: 00010002
> [    4.510475] RAX: ffff8c3976c04320 RBX: ffff8c3976c04300 RCX: 0000000000000000
> [    4.515420] RDX: ffff8c3976c04300 RSI: 0000000000000000 RDI: ffff8c3976c04320
> [    4.520331] RBP: ffffffff82603db8 R08: 0000000000000000 R09: 0000000000000000
> [    4.525288] R10: ffff8c3976c04320 R11: ffffffff8289e1e0 R12: ffffd52cc8db0100
> [    4.530180] R13: ffff8c3976c01a00 R14: ffffffff810f10d4 R15: ffff8c3976c04300
> [    4.535079] FS:  0000000000000000(0000) GS:ffffffff8266b000(0000) knlGS:0000000000000000
> [    4.540628] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [    4.544593] CR2: ffff8c397ffff000 CR3: 0000000125020000 CR4: 00000000000406b0
> [    4.549558] Call Trace:
> [    4.551266]  apply_wqattrs_prepare+0x154/0x280
> [    4.554357]  apply_workqueue_attrs_locked+0x4e/0xe0
> [    4.557728]  apply_workqueue_attrs+0x36/0x60
> [    4.560654]  alloc_workqueue+0x25a/0x6d0
> [    4.563381]  ? kmem_cache_alloc_trace+0x1e3/0x500
> [    4.566628]  ? __mutex_unlock_slowpath+0x44/0x3f0
> [    4.569875]  workqueue_init_early+0x246/0x348
> [    4.573025]  start_kernel+0x3c7/0x7ec
> [    4.575558]  x86_64_start_reservations+0x40/0x49
> [    4.578738]  x86_64_start_kernel+0xda/0xe4
> [    4.581600]  secondary_startup_64+0xb6/0xc0
> [    4.584473] Modules linked in:
> [    4.586620] ---[ end trace f67eb9af4d8d492b ]---

I think this is catching an edge case with the freelist walking code
in slab_free_freelist_hook. If we're not doing a bulk free,
getting the free pointer from the object is going to be bogus so
there's a chance it could trigger the bug in set_freepointer even
if we don't actually care about it since it's going to get
overwritten when we actually free. It's probably more robust
to make sure we're terminating it with NULL. Lightly tested:

diff --git a/mm/slub.c b/mm/slub.c
index e6c030e47364..8834563cdb4b 100644
--- a/mm/slub.c
+++ b/mm/slub.c
@@ -1432,7 +1432,9 @@ static inline bool slab_free_freelist_hook(struct kmem_cache *s,
  	void *old_tail = *tail ? *tail : *head;
  	int rsize;
  
-	if (slab_want_init_on_free(s))
+	if (slab_want_init_on_free(s)) {
+		void *p = NULL;
+
  		do {
  			object = next;
  			next = get_freepointer(s, object);
@@ -1445,8 +1447,10 @@ static inline bool slab_free_freelist_hook(struct kmem_cache *s,
  							   : 0;
  			memset((char *)object + s->inuse, 0,
  			       s->size - s->inuse - rsize);
-			set_freepointer(s, object, next);
+			set_freepointer(s, object, p);
+			p = object;
  		} while (object != old_tail);
+	}
  
  /*
   * Compiler cannot detect this function can be removed if slab_free_hook()

