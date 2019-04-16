Return-Path: <SRS0=BZT9=SS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 729A2C282DA
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Apr 2019 15:34:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 353D920872
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Apr 2019 15:34:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lca.pw header.i=@lca.pw header.b="l99SQJzt"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729847AbfDPPex (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Apr 2019 11:34:53 -0400
Received: from mail-qk1-f195.google.com ([209.85.222.195]:36055 "EHLO
        mail-qk1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726713AbfDPPew (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Apr 2019 11:34:52 -0400
Received: by mail-qk1-f195.google.com with SMTP id k130so12419078qke.3
        for <linux-kernel@vger.kernel.org>; Tue, 16 Apr 2019 08:34:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lca.pw; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=t/nJ62zGfBhASAqt8Wb9pZGiyJgukG4A6dg+njiVp48=;
        b=l99SQJztWsx18t5a8lNhbvbfGFaHPwjTF8bM8BlWOTlgVZmSy5bw+SPoOtaYnLjO8+
         9t5NTTE/Cr5+wtrCrxpLjNVIg9YEwxQVuQ5WceIdc5Q1w7Dbaiv/sOgUsr7UX/SgktcI
         UNqa1BA0Uw2IcZzp+aKmvW2YEfU0GrakEnIybE9hqRd4Psid6RAqHgBv6hsJYwPwVY0h
         mBF3VNpZbh+emJbhjkTZsu+jy06tvDgV22vmBYXhCpkqRtGknRq2GjLqOmdLIDWAb0z5
         w1uaL1wSUEEx1jhBVS05NgRofOGZ7KRlsJfgkvRVJtn4UIo2pxwEys6pXVmCUS42X0jU
         Ifkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=t/nJ62zGfBhASAqt8Wb9pZGiyJgukG4A6dg+njiVp48=;
        b=cNelj1cfVYMv/zliie5tzw2QxX9daFGB8mFFm121iI/1mWco/yU/tV2Rxz8R0nMxnF
         X/9sCf1yjvj+hKc5PRrj6Cn9/HhBX/NtUmRx5I4JjoDhxSYEjD8n50/l6otz4SQoEV0m
         CeMNoY4mPWsxn4X9HFfYyVf30a13XSdT30c4mrBuWyK5hXYKIvqRpxpxHrCd2A+E/uj+
         9Z6nBh7ABfUd70RbNoM25QjVdvg+fQ3mOMhgbCmEQJCRk516R/+wCM173mXBP12WUr4y
         7sxFYM/soT/yIChENlG/GlCVqNR+gZVTHVSlVt59v8jPhuTnSisR+J49AL9NZE89B9zB
         2Uuw==
X-Gm-Message-State: APjAAAU3rcE/HbLo9cJB0A6GVmDTNIlYpx2rs+9bGxVcH0c7UxiDc1x8
        SLJijV6U+hx4YXiXgvygOAdyagzI3hg=
X-Google-Smtp-Source: APXvYqx7/swZjLqc3SlEHh9S5oV8lv2RLc+PSZLxuIHStt2JIvmtiVkJ03zLHyIKfToBYDWvgIGxuA==
X-Received: by 2002:a37:a64b:: with SMTP id p72mr63826720qke.144.1555428891272;
        Tue, 16 Apr 2019 08:34:51 -0700 (PDT)
Received: from ovpn-120-81.rdu2.redhat.com (pool-71-184-117-43.bstnma.fios.verizon.net. [71.184.117.43])
        by smtp.gmail.com with ESMTPSA id a20sm29689919qth.88.2019.04.16.08.34.50
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 16 Apr 2019 08:34:50 -0700 (PDT)
Subject: Re: [PATCH] slab: remove store_stackinfo()
To:     Vlastimil Babka <vbabka@suse.cz>, akpm@linux-foundation.org
Cc:     luto@kernel.org, jpoimboe@redhat.com,
        sean.j.christopherson@intel.com, penberg@kernel.org,
        rientjes@google.com, tglx@linutronix.de, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
References: <20190416142258.18694-1-cai@lca.pw>
 <902fed9c-9655-a241-677d-5fa11b6c95a1@suse.cz>
From:   Qian Cai <cai@lca.pw>
Message-ID: <332fc776-65fa-eee6-e15d-2d872bd9d220@lca.pw>
Date:   Tue, 16 Apr 2019 11:34:49 -0400
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.14; rv:60.0)
 Gecko/20100101 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <902fed9c-9655-a241-677d-5fa11b6c95a1@suse.cz>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 4/16/19 11:25 AM, Vlastimil Babka wrote:
> On 4/16/19 4:22 PM, Qian Cai wrote:
>> store_stackinfo() does not seem used in actual SLAB debugging.
>> Potentially, it could be added to check_poison_obj() to provide more
>> information, but this seems like an overkill due to the declining
>> popularity of the SLAB, so just remove it instead.
>>
>> Signed-off-by: Qian Cai <cai@lca.pw>
> 
> I've acked Thomas' version already which was narrower, but no objection
> to remove more stuff on top of that. Linus (and I later in another
> thread) already pointed out /proc/slab_allocators. It only takes a look
> at add_caller() there to not regret removing that one.

Well, with the 2 patches I sent a while back, /proc/slab_allocators is back to
life on all arches (arm64, powerpc, and x86) which provides a little information
that may still useful for debugging until SLAB is gone entirely.

# cat /proc/slab_allocators
xfs_ili: 92 kmem_zone_alloc+0x6c/0x100 [xfs]
xfs_ifork: 2539 kmem_zone_alloc+0x6c/0x100 [xfs]
xfs_log_ticket: 3 kmem_zone_alloc+0x6c/0x100 [xfs]
sd_ext_cdb: 2 mempool_alloc_slab+0x1c/0x30
ip_fib_trie: 7 fib_insert_alias+0x11a/0x2b0
ip_fib_alias: 9 fib_table_insert+0x16d/0x510
eventpoll_pwq: 5 ep_ptable_queue_proc+0x3f/0xc0
inotify_inode_mark: 8 __x64_sys_inotify_add_watch+0x225/0x340
khugepaged_mm_slot: 6 __khugepaged_enter+0x36/0x190
file_lock_ctx: 23 locks_get_lock_context+0xf2/0x180
fsnotify_mark_connector: 79 fsnotify_add_mark_locked+0x117/0x460
task_delay_info: 509 __delayacct_tsk_init+0x1e/0x50
sigqueue: 2 __sigqueue_alloc+0xa8/0x130
kernfs_iattrs_cache: 122 __kernfs_iattrs+0x5c/0xf0
kernfs_node_cache: 28234 __kernfs_new_node.constprop.6+0x65/0x200
buffer_head: 1 alloc_buffer_head+0x21/0x70
nsproxy: 4 create_new_namespaces+0x36/0x1c0
vm_area_struct: 17 vm_area_alloc+0x1e/0x60
anon_vma_chain: 16 __anon_vma_prepare+0x3d/0x160
anon_vma: 18 __anon_vma_prepare+0xd2/0x160
Acpi-Operand: 2931 acpi_ut_allocate_object_desc_dbg+0x3e/0x69
Acpi-Namespace: 1618 acpi_ns_create_node+0x37/0x46
numa_policy: 47 __mpol_dup+0x3c/0x170
kmemleak_scan_area: 994 kmemleak_scan_area+0xa0/0x1e0
kmemleak_object: 513426 create_object+0x48/0x2c0
trace_event_file: 1650 trace_create_new_event+0x22/0x90
ftrace_event_field: 3198 __trace_define_field+0x36/0xc0
vmap_area: 890 alloc_vmap_area+0xaf/0x880
vmap_area: 663 alloc_vmap_area+0x2a3/0x880
vmap_area: 6 pcpu_get_vm_areas+0x277/0xbe0
vmap_area: 1 pcpu_get_vm_areas+0x689/0xbe0
vmap_area: 1 vmalloc_init+0x23d/0x26e
debug_objects_cache: 15917 __debug_object_init+0x444/0x4e0
debug_objects_cache: 999 debug_objects_mem_init+0x7b/0x5a2
page->ptl: 1526 ptlock_alloc+0x1e/0x40
