Return-Path: <SRS0=WT+Y=ZE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D1961C43331
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Nov 2019 18:50:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A46AA21783
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Nov 2019 18:50:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="somUeRuE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727093AbfKLSui (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Nov 2019 13:50:38 -0500
Received: from mail-io1-f67.google.com ([209.85.166.67]:41274 "EHLO
        mail-io1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725997AbfKLSui (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Nov 2019 13:50:38 -0500
Received: by mail-io1-f67.google.com with SMTP id r144so19892541iod.8
        for <linux-kernel@vger.kernel.org>; Tue, 12 Nov 2019 10:50:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=FKknxADsj8dAaCVRA/6UvI9FWyRNiphwf96YoePWw/c=;
        b=somUeRuEeUFVZZN5aEaXUral3mjnED+uZDYiwCN0BEpTBb5QW4odLtCgcbppWMflo5
         sJhUnYId0QyA/r+NrYi3DU8AEEaM4r84OGyTxJCmOuWuEGZ1kb8buAAtr/nDv/PQC+ij
         mUO4s2E+TmQeVsKxMmYSRmPNh85E9Y1x7TbSViD+fV8nk8ajQMLqkjyg6MGaiEdkTB2g
         e6l34SOnkreeGcZDiM9LnGNgYduKiZ13xjPS5pi0FuxaIupmG/ZLImYHspyIJX31Nokc
         AtwJ8e4qRb8zTETyYAK2VxnbKHBXWw1T9jYvAv67HxwQgxoIo16IvdkxrIvfoofpUKZk
         cSog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=FKknxADsj8dAaCVRA/6UvI9FWyRNiphwf96YoePWw/c=;
        b=kIPUG6wYNUPP7TLlv/hBZpX6gk7+b/bW8liv7MYj1jwHa5FLUFpfiKam/7W9GpTLLD
         E7atPDNVFVV74CT1AGTLWOmPWGL5bIQKDwX3Yl+Fues1umSyCJn9W/8kJ73GXgn0abXM
         oLuYqbBWGdAzh3fSE5YXqSK4pd78KMrd7ku7YvgG1AYT1Sk7MOKi46R5RqxeEnx+kTyk
         v2m+i2zdCCcLv13wTGzTHwHl/lYjmGNgRKXCcCOcjtkwcclv/egjIuAF6KFSU0Sk6NtR
         o1f1mBtSRUshSN4PwIUB9hlO8BvrnbgPkY1l5ObnR0qwMEP0a/5PZ82MK7pGHljLm663
         yvLw==
X-Gm-Message-State: APjAAAU7MR4V8J0DGF4yl5AJbg3x4thDjdGi1HFGmc/lec0gFYvhYRYh
        XHVbQqoDg8Ke8B34GArXzHrtNOS4dKXQoF9tE3oogTuD
X-Google-Smtp-Source: APXvYqzXIf8CzGG4ldQeR4jazTgDKaDOdXZ3kHD4cq94yW+2SJmtwJwP99KXFSHPfhUMXDH7gNKo1Zcsv6DjirlarlM=
X-Received: by 2002:a6b:908a:: with SMTP id s132mr32071112iod.118.1573584636856;
 Tue, 12 Nov 2019 10:50:36 -0800 (PST)
MIME-Version: 1.0
References: <1573478741-30959-1-git-send-email-pbonzini@redhat.com> <1573478741-30959-3-git-send-email-pbonzini@redhat.com>
In-Reply-To: <1573478741-30959-3-git-send-email-pbonzini@redhat.com>
From:   Jim Mattson <jmattson@google.com>
Date:   Tue, 12 Nov 2019 10:50:25 -0800
Message-ID: <CALMp9eRXgMe2hSfDCCPCvYrLenQX_k-J=QTV8a9AtCuZVDByDg@mail.gmail.com>
Subject: Re: [PATCH 2/2] KVM: fix placement of refcount initialization
To:     Paolo Bonzini <pbonzini@redhat.com>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        kvm list <kvm@vger.kernel.org>,
        Wanpeng Li <wanpengli@tencent.com>,
        Junaid Shahid <junaids@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 11, 2019 at 5:25 AM Paolo Bonzini <pbonzini@redhat.com> wrote:
>
> Reported by syzkaller:
>
>    =============================
>    WARNING: suspicious RCU usage
>    -----------------------------
>    ./include/linux/kvm_host.h:536 suspicious rcu_dereference_check() usage!
>
>    other info that might help us debug this:
>
>    rcu_scheduler_active = 2, debug_locks = 1
>    no locks held by repro_11/12688.
>
>    stack backtrace:
>    Call Trace:
>     dump_stack+0x7d/0xc5
>     lockdep_rcu_suspicious+0x123/0x170
>     kvm_dev_ioctl+0x9a9/0x1260 [kvm]
>     do_vfs_ioctl+0x1a1/0xfb0
>     ksys_ioctl+0x6d/0x80
>     __x64_sys_ioctl+0x73/0xb0
>     do_syscall_64+0x108/0xaa0
>     entry_SYSCALL_64_after_hwframe+0x49/0xbe
>
> Commit a97b0e773e4 (kvm: call kvm_arch_destroy_vm if vm creation fails)
> sets users_count to 1 before kvm_arch_init_vm(), however, if kvm_arch_init_vm()
> fails, we need to decrease this count.  By moving it earlier, we can push
> the decrease to out_err_no_arch_destroy_vm without introducing yet another
> error label.
>
> syzkaller source: https://syzkaller.appspot.com/x/repro.c?x=15209b84e00000
>
> Reported-by: syzbot+75475908cd0910f141ee@syzkaller.appspotmail.com
> Fixes: a97b0e773e49 ("kvm: call kvm_arch_destroy_vm if vm creation fails")
> Cc: Jim Mattson <jmattson@google.com>
> Analyzed-by: Wanpeng Li <wanpengli@tencent.com>
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
Reviewed-by: Jim Mattson <jmattson@google.com>
