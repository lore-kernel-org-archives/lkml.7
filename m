Return-Path: <SRS0=2dYc=UG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,T_DKIMWL_WL_MED,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9624C28CC3
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Jun 2019 08:45:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8E8CC208E3
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Jun 2019 08:45:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="vtFW7dQk"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727324AbfFGIp6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Jun 2019 04:45:58 -0400
Received: from mail-it1-f194.google.com ([209.85.166.194]:55301 "EHLO
        mail-it1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726671AbfFGIp6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Jun 2019 04:45:58 -0400
Received: by mail-it1-f194.google.com with SMTP id i21so1548428ita.5
        for <linux-kernel@vger.kernel.org>; Fri, 07 Jun 2019 01:45:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=qxzzEblUMEA5qQdRiWIndWcO3q1z3D8GVOYc/iBF8T0=;
        b=vtFW7dQkZ6w7ZKz2yBwH0nSO+7wnvEyhA4Zvn7m4ERt5orAakOZxJQbbAFC/6bqIFS
         uCDWauPC0ld6wHGkBUqdwmgETG9jIkEIbMroRaI72GvlDslq/xqon9ikBm7s083yHQra
         IhykEpUQTCYGci0d4VzKHelk7NysiKzea2wIstcbnvrIlfF8XFgzRrqfyZDaMILKkdKQ
         WjV96dvEF4Azc46bdZhwb/N/XJXSaEEOyJZp7YYicqih0NjVW9rshSgXlGsFiWbwuHqw
         a+7iET5Nl0R6tdI2itZ8hWXlsazF/vbxkHbhqqqj4aaojx2cg1dBZsTMaY491yeleVQO
         +ctA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=qxzzEblUMEA5qQdRiWIndWcO3q1z3D8GVOYc/iBF8T0=;
        b=k0J4YtUeklSxnHU6nADGIsi4mwCvR7XvTNx1TZO28yZiO75dB4Oyy0ew/l6b42rIOc
         Kty1d0KSaQSs6+ByTkv0XmGNhCVPSBHc4rthBhb+1P0giRZ9OUjhWwu7+6GL7c0MsKCS
         N6jtrBOYUKjRC6btn+YoHDgBLJJ//XrABX74calLrwi50IuTnmqjPR/ecRt3eZnk6rAT
         jqqXG9VotJOaLjfJXSL15bJHwaXSgRW3rShVGk9gCGWyhAxywhrgc/7x6DKAY8mNbosL
         XDTlhLPS7uk+J8ZUbr6asM/Wq0T/6lJmQIcsDybnvfiBYrsnV6TAjLb4vZ3/TZjOUaHu
         XnUg==
X-Gm-Message-State: APjAAAUR97Q9cqlUXwEMJkZRHBUkmB0DENGes6jptPwsd22uljl+yMxY
        15nOs+V0IJ+ev6iuB0TssRqqYXu8JO7xh5iLfDPaYA==
X-Google-Smtp-Source: APXvYqyyIc3w38KtpRgwzInkX7C52C7qLNIhYaBz1KW51AZa/S8BPxu0J0HyjhtYLoeXbrcad31ZTGsAa4j675kCnjk=
X-Received: by 2002:a02:22c6:: with SMTP id o189mr21527930jao.35.1559897157328;
 Fri, 07 Jun 2019 01:45:57 -0700 (PDT)
MIME-Version: 1.0
References: <000000000000f19676058ab7adc4@google.com>
In-Reply-To: <000000000000f19676058ab7adc4@google.com>
From:   Dmitry Vyukov <dvyukov@google.com>
Date:   Fri, 7 Jun 2019 10:45:45 +0200
Message-ID: <CACT4Y+ZZy5nqduErU8hjKrwThHiybGpwd3QzOviAWftZFZ4d2A@mail.gmail.com>
Subject: Re: linux-next boot error: WARNING: workqueue cpumask: online
 intersect > possible intersect
To:     syzbot <syzbot+4d497898effeb1936245@syzkaller.appspotmail.com>,
        Tejun Heo <tj@kernel.org>,
        Lai Jiangshan <jiangshanlai@gmail.com>, mwb@linux.vnet.ibm.com
Cc:     LKML <linux-kernel@vger.kernel.org>,
        syzkaller-bugs <syzkaller-bugs@googlegroups.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 7, 2019 at 10:33 AM syzbot
<syzbot+4d497898effeb1936245@syzkaller.appspotmail.com> wrote:
>
> Hello,
>
> syzbot found the following crash on:
>
> HEAD commit:    ae3cad8f Add linux-next specific files for 20190603
> git tree:       linux-next
> console output: https://syzkaller.appspot.com/x/log.txt?x=164f802ea00000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=7ccec0766d83706f
> dashboard link: https://syzkaller.appspot.com/bug?extid=4d497898effeb1936245
> compiler:       gcc (GCC) 9.0.0 20181231 (experimental)
>
> Unfortunately, I don't have any reproducer for this crash yet.
>
> IMPORTANT: if you fix the bug, please add the following tag to the commit:
> Reported-by: syzbot+4d497898effeb1936245@syzkaller.appspotmail.com
>
> smpboot: CPU0: Intel(R) Xeon(R) CPU @ 2.30GHz (family: 0x6, model: 0x3f,
> stepping: 0x0)
> Performance Events: unsupported p6 CPU model 63 no PMU driver, software
> events only.
> rcu: Hierarchical SRCU implementation.
> NMI watchdog: Perf NMI watchdog permanently disabled
> smp: Bringing up secondary CPUs ...
> x86: Booting SMP configuration:
> .... node  #0, CPUs:      #1
> MDS CPU bug present and SMT on, data leak possible. See
> https://www.kernel.org/doc/html/latest/admin-guide/hw-vuln/mds.html for
> more details.
> smp: Brought up 2 nodes, 2 CPUs
> smpboot: Max logical packages: 1
> smpboot: Total of 2 processors activated (9200.00 BogoMIPS)
> devtmpfs: initialized
> clocksource: jiffies: mask: 0xffffffff max_cycles: 0xffffffff, max_idle_ns:
> 19112604462750000 ns
> futex hash table entries: 512 (order: 4, 65536 bytes)
> xor: automatically using best checksumming function   avx
> PM: RTC time: 07:02:18, date: 2019-06-03
> NET: Registered protocol family 16
> audit: initializing netlink subsys (disabled)
> cpuidle: using governor menu
> ACPI: bus type PCI registered
> dca service started, version 1.12.1
> PCI: Using configuration type 1 for base access
> WARNING: workqueue cpumask: online intersect > possible intersect

+workqueue maintainers and Michael who added this WARNING

The WARNING was added in 2017, so I guess it's a change somewhere else
that triggered it.
The WARNING message does not seem to give enough info about the caller
(should it be changed to WARN_ONCE to print a stack?). How can be root
cause this and unbreak linux-next?


> ---
> This bug is generated by a bot. It may contain errors.
> See https://goo.gl/tpsmEJ for more information about syzbot.
> syzbot engineers can be reached at syzkaller@googlegroups.com.
>
> syzbot will keep track of this bug report. See:
> https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
>
> --
> You received this message because you are subscribed to the Google Groups "syzkaller-bugs" group.
> To unsubscribe from this group and stop receiving emails from it, send an email to syzkaller-bugs+unsubscribe@googlegroups.com.
> To view this discussion on the web visit https://groups.google.com/d/msgid/syzkaller-bugs/000000000000f19676058ab7adc4%40google.com.
> For more options, visit https://groups.google.com/d/optout.
