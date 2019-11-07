Return-Path: <SRS0=GkzU=Y7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DAFDFC43331
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Nov 2019 15:49:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A1AF12166E
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Nov 2019 15:49:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Yb3pn5DY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387551AbfKGPtG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 Nov 2019 10:49:06 -0500
Received: from mail-il1-f196.google.com ([209.85.166.196]:41415 "EHLO
        mail-il1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729656AbfKGPtG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Nov 2019 10:49:06 -0500
Received: by mail-il1-f196.google.com with SMTP id z10so2215753ilo.8
        for <linux-kernel@vger.kernel.org>; Thu, 07 Nov 2019 07:49:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=irMCwGA+SjUoAhw2kPyFwUWFY57JiJA9rRuNTgeQCh8=;
        b=Yb3pn5DYtXWC8iLf4ShERfzttjHNlNhL0NjssWsWP6Rd+wR37V5Pn8+bFz76mGvKaB
         QdErVtlytC2NUdQzhSR6XebSH+y3CRMrhcM10+1msuKW0f/seCZQEroBf/w9CM4NntiJ
         pt6jgeZkBbQLbBctN73fHQrGLyT7T0lljR2uFzpIq7NRFURHZZ7CWpQP2V0n0XMGodQc
         ibyB7NUNSoe8uFoYgCbw9sv+jn5ZSpCICaVFVSku0YuRiY9QPAoeOSgHjD0Vocllrvhy
         USKnw16kpc7IuUO56IFQz1ETeCKW+TYOoxMEJMAKrr7QOP+FcjrxGzBLw/ueaXic4h9Y
         3Beg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=irMCwGA+SjUoAhw2kPyFwUWFY57JiJA9rRuNTgeQCh8=;
        b=HC4IvEKoEV6d6NKyuKwItrvI4Fe+1QfPW6Dc1DcIglYfpI0Oun2RoDfffpSJovFdXL
         /p6oISXN4I/pI2Bxeh2x8L9uZuiHdLdYwRiq8vSkSePDtRnm9REV42DrNITQlcT2g5wq
         qLTjfcocFPrc5cqGQXILKVa3/K5DrTF6vgmPtUw7QXuf7jXaLLTBk9nCvwfKnu+m4kW4
         9/WB2hybRGVHgAApFa+BO1HLdg+oSd7Q4TI+EtXXigBAVxqRDo9kWvkennBJHDqiwyO/
         4abu3RG/clBd/BpJJLsamhEMd2ExHj32TfPtlThApwGdXGzuH+yzoRbd4Taio7W4r/+6
         usqg==
X-Gm-Message-State: APjAAAWgbq5FBISHO/OsnQZkJsRKoDNlUv8SQKm+OSYPYHtYuzTyDDLc
        T+IB5ZmIzLcPZ+Qrv8aA+xe8Kic3mDbMKsGumaRNoA==
X-Google-Smtp-Source: APXvYqyta6RxawQ69LCG84WSBv/fO42eHcRNdKfOg8XJYa0M/nleY0bgPGxtlzJsf4qQw0nl6UDH4hMOxuaLiSurdkc=
X-Received: by 2002:a92:7e0d:: with SMTP id z13mr5601143ilc.168.1573141742933;
 Thu, 07 Nov 2019 07:49:02 -0800 (PST)
MIME-Version: 1.0
References: <20191106174804.74723-1-edumazet@google.com> <157307905904.29376.8711513726869840596.tip-bot2@tip-bot2>
 <CANn89iKXi3rWWruKoBwQ8rncwLvkbzjZJWuJL3K05fjAhcySwg@mail.gmail.com>
 <CANn89iL=xPxejRPC=wHY7q27fLOvFBK-7HtqU_HJo+go3S9UXA@mail.gmail.com> <20191107085255.GK20975@paulmck-ThinkPad-P72>
In-Reply-To: <20191107085255.GK20975@paulmck-ThinkPad-P72>
From:   Eric Dumazet <edumazet@google.com>
Date:   Thu, 7 Nov 2019 07:48:50 -0800
Message-ID: <CANn89i+8Hq5j234zFRY05QxZU1n=Vr6S-kZCcvn3Z80xYaindg@mail.gmail.com>
Subject: Re: [tip: timers/core] hrtimer: Annotate lockless access to timer->state
To:     paulmck@kernel.org
Cc:     LKML <linux-kernel@vger.kernel.org>,
        linux-tip-commits@vger.kernel.org,
        syzbot <syzkaller@googlegroups.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@kernel.org>, Borislav Petkov <bp@alien8.de>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 7, 2019 at 12:53 AM Paul E. McKenney <paulmck@kernel.org> wrote:
>
> On Wed, Nov 06, 2019 at 02:59:36PM -0800, Eric Dumazet wrote:
> > On Wed, Nov 6, 2019 at 2:53 PM Eric Dumazet <edumazet@google.com> wrote:
> > >
> > > On Wed, Nov 6, 2019 at 2:24 PM tip-bot2 for Eric Dumazet
> > > <tip-bot2@linutronix.de> wrote:
> > > >
> > > > The following commit has been merged into the timers/core branch of tip:
> > > >
> > > > Commit-ID:     56144737e67329c9aaed15f942d46a6302e2e3d8
> > > > Gitweb:        https://git.kernel.org/tip/56144737e67329c9aaed15f942d46a6302e2e3d8
> > > > Author:        Eric Dumazet <edumazet@google.com>
> > > > AuthorDate:    Wed, 06 Nov 2019 09:48:04 -08:00
> > > > Committer:     Thomas Gleixner <tglx@linutronix.de>
> > > > CommitterDate: Wed, 06 Nov 2019 23:18:31 +01:00
> > > >
> > > > hrtimer: Annotate lockless access to timer->state
> > > >
> > >
> > > I guess we also need to fix timer_pending(), since timer->entry.pprev
> > > could change while we read it.
> >
> > It is interesting seeing hlist_add_head() has a WRITE_ONCE(h->first, n);,
> > but no WRITE_ONCE() for the pprev change.
> >
> > The WRITE_ONCE() was added in commit 1c97be677f72b3c338312aecd36d8fff20322f32
> > ("list: Use WRITE_ONCE() when adding to lists and hlists")
>
> The theory is that while the ->next pointer is concurrently accessed by
> RCU readers, the ->pprev pointer is accessed only by updaters, who need
> to supply sufficient synchronization.
>
> But what is this theory missing in practice?

Here is some context : I am helping triaging about 400 KCSAN data-race
splats in syzbot moderation queue.

Take a look at the timer related one in [1]

If we want to avoid potential load/store-tearing, minimall patch would be :

diff --git a/include/linux/list.h b/include/linux/list.h
index 85c92555e31f85f019354e54d6efb8e79c2aee17..9139803b851cc37bb759c8d7c12ee7e36c61f009
100644
--- a/include/linux/list.h
+++ b/include/linux/list.h
@@ -761,7 +761,7 @@ static inline void __hlist_del(struct hlist_node *n)

        WRITE_ONCE(*pprev, next);
        if (next)
-               next->pprev = pprev;
+               WRITE_ONCE(next->pprev, pprev);
 }

 static inline void hlist_del(struct hlist_node *n)
diff --git a/include/linux/timer.h b/include/linux/timer.h
index 1e6650ed066d5d28251b0bd385fc37ef94c96532..c7c8dd89f2797389ca96473e60c7297fd38d8259
100644
--- a/include/linux/timer.h
+++ b/include/linux/timer.h
@@ -164,7 +164,7 @@ static inline void destroy_timer_on_stack(struct
timer_list *timer) { }
  */
 static inline int timer_pending(const struct timer_list * timer)
 {
-       return timer->entry.pprev != NULL;
+       return READ_ONCE(timer->entry.pprev) != NULL;
 }

 extern void add_timer_on(struct timer_list *timer, int cpu);


But really many other WRITE_ONCE() would be needed in include/linux/list.h


[1]

BUG: KCSAN: data-race in del_timer / detach_if_pending

write to 0xffff88808697d870 of 8 bytes by task 10 on cpu 0:
 __hlist_del include/linux/list.h:764 [inline]
 detach_timer kernel/time/timer.c:815 [inline]
 detach_if_pending+0xcd/0x2d0 kernel/time/timer.c:832
 try_to_del_timer_sync+0x60/0xb0 kernel/time/timer.c:1226
 del_timer_sync+0x6b/0xa0 kernel/time/timer.c:1365
 schedule_timeout+0x2d2/0x6e0 kernel/time/timer.c:1896
 rcu_gp_fqs_loop+0x37c/0x580 kernel/rcu/tree.c:1639
 rcu_gp_kthread+0x143/0x230 kernel/rcu/tree.c:1799
 kthread+0x1d4/0x200 drivers/block/aoe/aoecmd.c:1253
 ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:352

read to 0xffff88808697d870 of 8 bytes by task 12060 on cpu 1:
 del_timer+0x3b/0xb0 kernel/time/timer.c:1198
 sk_stop_timer+0x25/0x60 net/core/sock.c:2845
 inet_csk_clear_xmit_timers+0x69/0xa0 net/ipv4/inet_connection_sock.c:523
 tcp_clear_xmit_timers include/net/tcp.h:606 [inline]
 tcp_v4_destroy_sock+0xa3/0x3f0 net/ipv4/tcp_ipv4.c:2096
 inet_csk_destroy_sock+0xf4/0x250 net/ipv4/inet_connection_sock.c:836
 tcp_close+0x6f3/0x970 net/ipv4/tcp.c:2497
 inet_release+0x86/0x100 net/ipv4/af_inet.c:427
 __sock_release+0x85/0x160 net/socket.c:590
 sock_close+0x24/0x30 net/socket.c:1268
 __fput+0x1e1/0x520 fs/file_table.c:280
 ____fput+0x1f/0x30 fs/file_table.c:313
 task_work_run+0xf6/0x130 kernel/task_work.c:113
 tracehook_notify_resume include/linux/tracehook.h:188 [inline]
 exit_to_usermode_loop+0x2b4/0x2c0 arch/x86/entry/common.c:163

Reported by Kernel Concurrency Sanitizer on:
CPU: 1 PID: 12060 Comm: syz-executor.5 Not tainted 5.4.0-rc3+ #0
Hardware name: Google Google Compute Engine/Google Compute Engine,
BIOS Google 01/01/2011
==================================================================
