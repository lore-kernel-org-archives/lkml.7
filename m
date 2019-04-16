Return-Path: <SRS0=BZT9=SS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 99DA4C10F13
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Apr 2019 11:37:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6C27C2077C
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Apr 2019 11:37:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729081AbfDPLhT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Apr 2019 07:37:19 -0400
Received: from mx2.suse.de ([195.135.220.15]:35854 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726408AbfDPLhR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Apr 2019 07:37:17 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 052BCAF8F;
        Tue, 16 Apr 2019 11:37:14 +0000 (UTC)
Date:   Tue, 16 Apr 2019 13:37:13 +0200 (CEST)
From:   Miroslav Benes <mbenes@suse.cz>
To:     Joe Lawrence <joe.lawrence@redhat.com>
cc:     linux-kernel@vger.kernel.org, live-patching@vger.kernel.org,
        linux-kbuild@vger.kernel.org, Jessica Yu <jeyu@kernel.org>,
        Jiri Kosina <jikos@kernel.org>,
        Joao Moreira <jmoreira@suse.de>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Konstantin Khlebnikov <khlebnikov@yandex-team.ru>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Michael Matz <matz@suse.de>, Nicolai Stange <nstange@suse.de>,
        Petr Mladek <pmladek@suse.com>,
        Jason Baron <jbaron@akamai.com>,
        Evgenii Shatokhin <eshatokhin@virtuozzo.com>
Subject: Re: [PATCH v3 0/9] klp-convert livepatch build tooling
In-Reply-To: <20190412212654.GA21627@redhat.com>
Message-ID: <alpine.LSU.2.21.1904161323230.17836@pobox.suse.cz>
References: <20190412212654.GA21627@redhat.com>
User-Agent: Alpine 2.21 (LSU 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


[...]

> Current behavior
> ----------------
> 
> Not good.  The livepatch successfully builds but crashes on load:
> 
>   % insmod lib/livepatch/test_klp_static_keys_mod.ko
>   % insmod lib/livepatch/test_klp_static_keys.ko
> 
>   BUG: unable to handle kernel NULL pointer dereference at 0000000000000010
>   #PF error: [normal kernel read fault]
>   PGD 0 P4D 0
>   Oops: 0000 [#1] SMP PTI
>   CPU: 3 PID: 9367 Comm: insmod Tainted: G            E K   5.1.0-rc4+ #4
>   Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS ?-20180724_192412-buildhw-07.phx2.fedoraproject.org-1.fc29 04/01/2014
>   RIP: 0010:jump_label_apply_nops+0x3b/0x60
>   Code: 02 00 00 48 c1 e5 04 48 01 dd 48 39 eb 74 3a 72 0b eb 36 48 83 c3 10 48 39 dd 76 2d 48 8b 43 08 48 89 c2 83 e0 01 48 83 e2 fc <48> 8b 54 13 10 83 e2 01 38 c2 75 dd 48 89 df 31 f6 48 83 c3 10 e8
>   RSP: 0018:ffffa8874068fcf8 EFLAGS: 00010206
>   RAX: 0000000000000000 RBX: ffffffffc07fd000 RCX: 000000000000000d
>   RDX: 000000003f803000 RSI: ffffffffa5077be0 RDI: ffffffffc07fe540
>   RBP: ffffffffc07fd0a0 R08: ffffa88740f43878 R09: ffffa88740eed000
>   R10: 0000000000055a4b R11: ffffa88740f43878 R12: ffffa88740f430b8
>   R13: 0000000000000000 R14: ffffa88740f42df8 R15: 0000000000042b01
>   FS:  00007f4f1dafb740(0000) GS:ffff9a81fbb80000(0000) knlGS:0000000000000000
>   CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
>   CR2: 0000000000000010 CR3: 00000000b5d8a000 CR4: 00000000000006e0
>   Call Trace:
>    module_finalize+0x184/0x1c0
>    load_module+0x1400/0x1910
>    ? kernel_read_file+0x18d/0x1c0
>    ? __do_sys_finit_module+0xa8/0x110
>    __do_sys_finit_module+0xa8/0x110
>    do_syscall_64+0x55/0x1a0
>    entry_SYSCALL_64_after_hwframe+0x44/0xa9
>   RIP: 0033:0x7f4f1cae82bd
> 
> 
> Future work
> -----------
> 
> At the very least, I think this call-chain ordering is wrong for
> livepatch static key symbols:
> 
>   load_module
> 
>     apply_relocations
> 
>     post_relocation
>       module_finalize
>         jump_label_apply_nops                                         <<
> 
>     ...
> 
>     prepare_coming_module
>       blocking_notifier_call_chain(&module_notify_list, MODULE_STATE_COMING, mod);
>         jump_label_module_notify
>           case MODULE_STATE_COMING
>             jump_label_add_module                                     <<
> 
>     do_init_module
> 
>       do_one_initcall(mod->init)
>         __init patch_init [kpatch-patch]
>           klp_register_patch
>             klp_init_patch
>               klp_for_each_object(patch, obj)
>                 klp_init_object
>                   klp_init_object_loaded
>                     klp_write_object_relocations                      <<
> 
>       blocking_notifier_call_chain(&module_notify_list, MODULE_STATE_LIVE, mod);
>         jump_label_module_notify
>           case MODULE_STATE_LIVE
>             jump_label_invalidate_module_init
> 
> where klp_write_object_relocations() is called way *after*
> jump_label_apply_nops() and jump_label_add_module().

Quick look, but it seems quite similar to the problem we had with 
apply_alternatives(). See arch/x86/kernel/livepatch.c and the commit which 
introduced it.

I think, we should do the same for jump labels. Add 
jump_label_apply_nops() from module_finalize() to 
arch_klp_init_object_loaded() and convert jump_table ELF section so its 
processing is delayed.

Which leads me another TODO... klp-convert does not convert even 
.altinstructions and .parainstructions sections, so it has that problem as 
well. If I remember, it was on Josh's TODO list when he first introduced 
klp-convert. See cover.1477578530.git.jpoimboe@redhat.com.

The selftest for the alternatives would be appreciated too. One day.

And of course we should look at the other supported architectures and 
their module_finalize() functions. I have it on my TODO list somewhere, 
but you know how it works with those :/. I am sure there are more hidden 
surprises there.

 
> Detection
> ---------
> 
> I have been tinkering with some prototype code to defer
> jump_label_apply_nops() and jump_label_add_module(), but it has been
> slow going.  I think the jist of it is that we're going to need to call
> these dynamically when individual klp_objects are patched, not when the
> livepatch module itself loads.  If anyone with static key expertise
> wants to jump in here, let me know.
> 
> In the meantime, I cooked up a potential followup commit to detect
> conversion of static key symbols and klp-convert failure.  It basically
> runs through the output .ko's ELF symbols and verifies that none of the
> converted ones can be found as a .rela__jump_table relocated symbol.  It
> accurately catches the problematic references in test_klp_static_keys.ko
> thus far.
> 
> This was based on a similar issue reported as a bug against
> kpatch-build, in which Josh wrote code to detect this scenario:
> 
>   https://github.com/dynup/kpatch/issues/946
>   https://github.com/jpoimboe/kpatch/commit/2cd2d27607566aee9590c367e615207ce1ce24c6
> 
> I can post ("livepatch/klp-convert: abort on static key conversion")
> here as a follow commit if it looks reasonable and folks wish to review
> it... or we can try and tackle static keys before merging klp-convert.

Good idea. I'd rather fix it, but I think it could be a lot of work, so 
something like this patch seems to be a good idea.

Thanks
Miroslav
