Return-Path: <SRS0=2mSC=W2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5C54DC3A59B
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Aug 2019 15:41:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2CE3223427
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Aug 2019 15:41:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1567179688;
	bh=snAtiQDeS8r659a4ZgziXoPgzimAgLQxafB1YXrD7d4=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=SJrJJep1QVrR6MmDG5PnLxphk/bee+tK1HmvML/5Lk23pXBa+Swbdfju4EOoetdqc
	 1Hj4elEIUdLEExXT1iPkNZLMRwkZP7tzl2A7DMvYmhsjlcjT6nt2eNKHHKpNY97OnF
	 sdCTzVopaVgqyqxDi3WLx371iX00cBXjeFoM3fMI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728445AbfH3Pl1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 30 Aug 2019 11:41:27 -0400
Received: from mail-lj1-f196.google.com ([209.85.208.196]:41968 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728410AbfH3PlY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Aug 2019 11:41:24 -0400
Received: by mail-lj1-f196.google.com with SMTP id m24so6902156ljg.8
        for <linux-kernel@vger.kernel.org>; Fri, 30 Aug 2019 08:41:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=6l/MmER3LwxVChdeaRYIf4zH/5/oimVEhwZA0gfAJeA=;
        b=hTMNumX8xZr51jZ2e8ioodaU7fZy7Zox0fVt25oHPu+ey/m2I7q6COdJTUw30VC209
         kek6cE7p7Qc23NCmn25ahHuKo8wmqd/NbB/BBSNT1Jghi4IFJZOM6sr/9MWX6bHULgBL
         qQFYDc/r1Z1RMajEzSGvyz2pVtBdstCLYcf3M=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=6l/MmER3LwxVChdeaRYIf4zH/5/oimVEhwZA0gfAJeA=;
        b=U0giGfAcruum4bvRqaqxDcoqLBdWEifPb3GXwmZqdhrfqfQWOrZDFyISxJBpu4eQ3n
         xbMFaO5kBk+VgxUIEJrzIpOx93m2x/j12qaic2s1f9Y5YGdkzSETxaWubxX/uWf4InGF
         G4/zWT83tg4gFDOAwAYzmXsGoCWIth1SE6aK8Yf5tRXxdAXzpwnYoiTJuayz30PfZ6hD
         LzUcI6GroGOdEW82dVvrsF1mqppMbDHs8QmMNvQy0yJhFmOLdd6pDvhwEz8FRCcWkQtj
         lcFDwXPNqPHbZZtlx8pyGvbHA5K0aT7Yu7/0NAuQunFRSBjToB6QnB7YsnLMPqxurjz2
         n4CA==
X-Gm-Message-State: APjAAAW4Bx2gNTB4xHnRJZnzADJSZJQxjbrWa0fbwQnZw0xEq4QKf0ZD
        16PoYYjtAcE57ncWkWe7x2E88gYHheo=
X-Google-Smtp-Source: APXvYqxZrQVf5i33if9LPT98syLUwpRedS3t3CK51XnC+kKzyZ/1+PyMTeXgR0UtCS1AdBizFyprUw==
X-Received: by 2002:a2e:7018:: with SMTP id l24mr8740705ljc.165.1567179681873;
        Fri, 30 Aug 2019 08:41:21 -0700 (PDT)
Received: from mail-lj1-f181.google.com (mail-lj1-f181.google.com. [209.85.208.181])
        by smtp.gmail.com with ESMTPSA id b7sm912806ljk.80.2019.08.30.08.41.19
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 30 Aug 2019 08:41:20 -0700 (PDT)
Received: by mail-lj1-f181.google.com with SMTP id l14so6916937lje.2
        for <linux-kernel@vger.kernel.org>; Fri, 30 Aug 2019 08:41:19 -0700 (PDT)
X-Received: by 2002:a2e:9702:: with SMTP id r2mr8837586lji.84.1567179679653;
 Fri, 30 Aug 2019 08:41:19 -0700 (PDT)
MIME-Version: 1.0
References: <20190830140805.GD13294@shell.armlinux.org.uk> <CAHk-=whuggNup=-MOS=7gBkuRqUigk7ABot_Pxi5koF=dM3S5Q@mail.gmail.com>
In-Reply-To: <CAHk-=whuggNup=-MOS=7gBkuRqUigk7ABot_Pxi5koF=dM3S5Q@mail.gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Fri, 30 Aug 2019 08:41:03 -0700
X-Gmail-Original-Message-ID: <CAHk-=wiSFvb7djwa7D=-rVtnq3C5msh3u=CF7CVoU6hTJ=VdLw@mail.gmail.com>
Message-ID: <CAHk-=wiSFvb7djwa7D=-rVtnq3C5msh3u=CF7CVoU6hTJ=VdLw@mail.gmail.com>
Subject: Re: [BUG] Use of probe_kernel_address() in task_rcu_dereference()
 without checking return value
To:     Russell King - ARM Linux admin <linux@armlinux.org.uk>
Cc:     Oleg Nesterov <oleg@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Chris Metcalf <cmetcalf@ezchip.com>,
        Christoph Lameter <cl@linux.com>,
        Kirill Tkhai <tkhai@yandex.ru>, Mike Galbraith <efault@gmx.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@kernel.org>,
        Linux List Kernel Mailing <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 30, 2019 at 8:30 AM Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> Do you actually see that behavior?
>
> Because the foillowing lines:
>
>         smp_rmb();
>         if (unlikely(task != READ_ONCE(*ptask)))
>                 goto retry;

Side note: that code had better not be performance-critical, because
"probe_kernel_address()" is actually really really slow.

We really should do a real set of "read kernel with fault handling" functions.

We have *one* right now: load_unaligned_zeropad(), but that one
assumes that at least the first byte is valid and that the fault can
only be because of unaligned page crossers.

The problem with "probe_kernel_address()" is that it really just
re-uses the user access functions, and then plays games to make them
work for kernel addresses. Games we shouldn't play, and it's all very
expensive when it really shouldn't need to be. Including changing
limits, but also doing all the system instructions to allow user
accesses (PAN on ARM, clac/stac on x86).

Doing a set of "access kernel with error handling" should be trivial,
it's just that every architecture needs to do it. So we'd probably
need to do something where architectures can say "I have it", and fall
back on the silly legacy implementation otherwise..

             Linus
