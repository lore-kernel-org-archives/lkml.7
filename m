Return-Path: <SRS0=GAfv=RG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0BDB9C10F00
	for <linux-kernel@archiver.kernel.org>; Sun,  3 Mar 2019 18:21:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D60AB20866
	for <linux-kernel@archiver.kernel.org>; Sun,  3 Mar 2019 18:21:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726619AbfCCSTH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 3 Mar 2019 13:19:07 -0500
Received: from mail-pf1-f193.google.com ([209.85.210.193]:40469 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726416AbfCCSTG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 Mar 2019 13:19:06 -0500
Received: by mail-pf1-f193.google.com with SMTP id h1so1321783pfo.7
        for <linux-kernel@vger.kernel.org>; Sun, 03 Mar 2019 10:19:06 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=Dydz1Zw+oKt95aAjNLUfCgJlTkG9IzSqqBmyQGgVzEY=;
        b=uPAHD29uvjFLaWzalzBYqzv0tVraemOghDr8gNtYA9fF41NGMTc0uH9rR+qAPOgD0u
         ZwHpywWgj5BLp+e/lShUbc9fZ2QeYb7tBdk1LWgLXQRxuuFIxJxFZr2hMzciY8XdDB51
         22MAmx7riyj2TU3ZuiR0+i81MBeZVgXnXP075XIerlCrLMGPLR8tXapzxCbB9yl404eA
         Tp9oTJ3AmNeDAGvKwDDBVFnSAhXBYFCW3UHDWq9LKoxps1ggBLMS2c+xs02OzOzDWOZw
         bOaKpM4KXAy7hQOqb4lnTRGcLNcXZ+vsbxp9mfWI7kTFqg8WvhsIsz/XB+xm3TV0TKqC
         IUlw==
X-Gm-Message-State: APjAAAV4zTNR5dQbHVFHTRiHoxlbKacwtalwdlUzD1kordJSbVZplI4g
        YHyWOl/fL1FX70rWnHx0Bkpqa+mt
X-Google-Smtp-Source: APXvYqz+OVoDWt1AMJhLMLtpNEMXHalx1R2gS78115o0dT3lJdEjQQbGWn7qq6mDWXYEn9cM0FG3SA==
X-Received: by 2002:a17:902:9003:: with SMTP id a3mr16183589plp.2.1551637144288;
        Sun, 03 Mar 2019 10:19:04 -0800 (PST)
Received: from asus.site ([2601:647:4000:5dd1:a41e:80b4:deb3:fb66])
        by smtp.gmail.com with ESMTPSA id h184sm14140427pfc.78.2019.03.03.10.19.02
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 03 Mar 2019 10:19:03 -0800 (PST)
Subject: Re: [PATCH -next] lockdep: skip debugobjects for lock_classes[] init
To:     Qian Cai <cai@lca.pw>, peterz@infradead.org, mingo@redhat.com,
        will.deacon@arm.com
Cc:     longman@redhat.com, tglx@linutronix.de,
        linux-kernel@vger.kernel.org
References: <20190303040224.7666-1-cai@lca.pw>
From:   Bart Van Assche <bvanassche@acm.org>
Message-ID: <c20aa0f0-42ab-a884-d931-7d4ec2bf0cdc@acm.org>
Date:   Sun, 3 Mar 2019 10:19:01 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.1
MIME-Version: 1.0
In-Reply-To: <20190303040224.7666-1-cai@lca.pw>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/2/19 8:02 PM, Qian Cai wrote:
> The linux-next commit a0b0fd53e1e6 ("locking/lockdep: Free lock classes
> that are no longer in use") let init_data_structures_once() call
> init_rcu_head(). As the result, smp_setup_processor_id() calls
> debug_object_init() before debug_objects_early_init() triggering errors
> below on arm64 and ppc64le. Since debug_objects_early_init() depends on
> smp_setup_processor_id(), so it is not straightforward to move the
> former earlier in start_kernel(). Hence, just skip all debugobjects
> creations in init_data_structures_once() as a good trade-off by losing
> track of some RCU list heads debugging.
> 
> BUG: spinlock bad magic on CPU#0, swapper/0
>   lock: obj_hash+0xc3048/0x100000, .magic: 00000000, .owner: <none>/-1,
> .owner_cpu: 0
> CPU: 0 PID: 0 Comm: swapper Not tainted 5.0.0-rc8-next-20190301+ #1
> Call trace:
>   dump_backtrace+0x0/0x450
>   show_stack+0x20/0x2c
>   dump_stack+0xe0/0x16c
>   spin_bug+0x200/0x224
>   do_raw_spin_lock+0x1bc/0x23c
>   _raw_spin_lock_irqsave+0xac/0xd0
>   __debug_object_init+0xf0/0x19dc
>   debug_object_init+0x54/0x6c
>   init_rcu_head+0x24/0x30
>   init_data_structures_once+0xb0/0x41c
>   register_lock_class+0x70c/0x1454
>   __lock_acquire+0xc4/0x235c
>   lock_acquire+0x508/0x668
>   _raw_spin_lock+0x88/0xac
>   vprintk_emit+0x33c/0x53c
>   vprintk_default+0x54/0x7c
>   vprintk_func+0x320/0x40c
>   printk+0x64/0x8c
>   smp_setup_processor_id+0x6c/0x84
>   start_kernel+0x38/0x8f8
> ODEBUG: Out of memory. ODEBUG disabled
> 
> Signed-off-by: Qian Cai <cai@lca.pw>
> ---
>   kernel/locking/lockdep.c | 1 -
>   1 file changed, 1 deletion(-)
> 
> diff --git a/kernel/locking/lockdep.c b/kernel/locking/lockdep.c
> index 21cb81fe6359..1309a6fe88ee 100644
> --- a/kernel/locking/lockdep.c
> +++ b/kernel/locking/lockdep.c
> @@ -988,7 +988,6 @@ static void init_data_structures_once(void)
>   
>   	initialization_happened = true;
>   
> -	init_rcu_head(&delayed_free.rcu_head);
>   	INIT_LIST_HEAD(&delayed_free.pf[0].zapped);
>   	INIT_LIST_HEAD(&delayed_free.pf[1].zapped);

Hi Qian,

Thanks for having reported this issue. Had you considered to follow an 
approach similar to the patch below?

Thanks,

Bart.


[PATCH] locking/lockdep: Only call init_rcu_head() after RCU has been
  initialized

init_data_structures_once() is called for the first time before RCU has
been initialized. Make sure that init_rcu_head() is called before the
RCU head is used and after RCU has been initialized.

Signed-off-by: Bart Van Assche <bvanassche@acm.org>
---
  kernel/locking/lockdep.c | 15 +++++++++++----
  1 file changed, 11 insertions(+), 4 deletions(-)

diff --git a/kernel/locking/lockdep.c b/kernel/locking/lockdep.c
index 21cb81fe6359..c8c83e1e2664 100644
--- a/kernel/locking/lockdep.c
+++ b/kernel/locking/lockdep.c
@@ -980,15 +980,22 @@ static inline void check_data_structures(void) { }
   */
  static void init_data_structures_once(void)
  {
-	static bool initialization_happened;
+	static bool ds_initialized, rcu_head_initialized;
  	int i;

-	if (likely(initialization_happened))
+	if (likely(rcu_head_initialized))
  		return;

-	initialization_happened = true;
+	if (system_state >= SYSTEM_SCHEDULING) {
+		init_rcu_head(&delayed_free.rcu_head);
+		rcu_head_initialized = true;
+	}
+
+	if (ds_initialized)
+		return;
+
+	ds_initialized = true;

-	init_rcu_head(&delayed_free.rcu_head);
  	INIT_LIST_HEAD(&delayed_free.pf[0].zapped);
  	INIT_LIST_HEAD(&delayed_free.pf[1].zapped);

-- 
2.20.1

