Return-Path: <SRS0=19dG=ZH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 16D39C432C3
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Nov 2019 08:51:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E098B20715
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Nov 2019 08:51:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="mH7qqFLl"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727065AbfKOIvh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Nov 2019 03:51:37 -0500
Received: from mail-lj1-f196.google.com ([209.85.208.196]:45760 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726567AbfKOIvg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Nov 2019 03:51:36 -0500
Received: by mail-lj1-f196.google.com with SMTP id n21so9775939ljg.12
        for <linux-kernel@vger.kernel.org>; Fri, 15 Nov 2019 00:51:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=3fEb9yyGquoZVltQfVlIxZrZ5NGlUUtelTiB0hCjeas=;
        b=mH7qqFLlMipUmE2tXi/FzxRWoX724aBrp9H8DRQHC4Bo1LMsw9LhmbNuXCyXCAVRH2
         vg/X04TRGffU4kwx7Uxun8pyjXdrQgptOGVASedHe6pBO0TfXgQJChq7GtEyYbDLqP9I
         jBZ6lreXdvBf+EOn/pu22JrEPbOUkZg4k6MDUazl4muUsD875x2LIdD2qalQ8pEHgVBB
         qtb7xIPrCZQnOSuSk7o4C9+JCTglsZd8PbWM1nEhl+XVEI3ZaK9nkn6mYfGqUSexcGyE
         oM2CdW4c4Bf8W6vvhZkSCK2BIyI9qzSWK7Vk8FGMqStLH9NP6vw6Tfz+szhfM2h8ye8A
         2EjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=3fEb9yyGquoZVltQfVlIxZrZ5NGlUUtelTiB0hCjeas=;
        b=Y+1dHCyvVaHNaCwx6oLx9IgBcAkmi0AmRUYIJ1NyHdoX9jcPVyMby+7wIKSNhr1Xzo
         ILMjjGJAWYe6S1a8dv+5kNN5/5KVQ2fAqSl4GORq4nT9PPIWEoceXKZhj88NqntsCRP/
         3JCiPDNFg1sVpbSPOkIailFzUHtxahw2i75lyquZG7igxH+XzdZxjUKFtFbQoXgfwkKV
         j+vVbF9znCNFUcx5HX332/JKDHyZfIw8gfZrc5n43HI2rOqqMRkF/l13tO6I4q8NKfG8
         myhnU23eNe90sl34TspD4+CDMgKuRVAgxkQEEnrbJO0bJpwlpSvOz/IooR4eak5jNHuS
         nFgg==
X-Gm-Message-State: APjAAAUurxtyFF/3N+cgTN9pABws9ep7ZiZoigiPqi9M19fOohirKqVC
        Tkyns6YKKwbzJ74E9G85OcvzBjsImohJgafwPqDTrQ==
X-Google-Smtp-Source: APXvYqxfB5nxoeE6GEmmRaOEnhNox9eLuu4QCKsSPaKT40+0wf4ElVUQvEocDLs5ZN+aFNatwkhrlxuqUejbpqq/3zw=
X-Received: by 2002:a2e:7202:: with SMTP id n2mr9182412ljc.194.1573807894435;
 Fri, 15 Nov 2019 00:51:34 -0800 (PST)
MIME-Version: 1.0
References: <20191113171201.14032-1-frederic@kernel.org> <VI1PR04MB70232EC7B98497C2CEC633DCEE710@VI1PR04MB7023.eurprd04.prod.outlook.com>
In-Reply-To: <VI1PR04MB70232EC7B98497C2CEC633DCEE710@VI1PR04MB7023.eurprd04.prod.outlook.com>
From:   Naresh Kamboju <naresh.kamboju@linaro.org>
Date:   Fri, 15 Nov 2019 14:21:23 +0530
Message-ID: <CA+G9fYtMPsF6z82_CPeFySX-5zahrqceikunfU3AtkdsyRC6ZA@mail.gmail.com>
Subject: Re: [PATCH] irq_work: Fix IRQ_WORK_BUZY bit clearing
To:     Frederic Weisbecker <frederic@kernel.org>
Cc:     Ingo Molnar <mingo@kernel.org>,
        Leonard Crestez <leonard.crestez@nxp.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        "Paul E . McKenney" <paulmck@linux.vnet.ibm.com>,
        kernel test robot <rong.a.chen@intel.com>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        lkft-triage@lists.linaro.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Frederic,

Thanks for this fix patch.

On Thu, 14 Nov 2019 at 21:26, Leonard Crestez <leonard.crestez@nxp.com> wrote:
>
> On 13.11.2019 19:12, Frederic Weisbecker wrote:
> > While attempting to clear the buzy bit at the end of a work execution,
> > atomic_cmpxchg() expects the value of the flags with the pending bit
> > cleared as the old value. However we are passing by mistake the value of
> > the flags before we actually cleared the pending bit.
>
> Busy is spelled with an S
>
> >
> > As a result, clearing the buzy bit fails and irq_work_sync() may stall:
> >
> >       watchdog: BUG: soft lockup - CPU#0 stuck for 22s! [blktrace:4948]
> >       CPU: 0 PID: 4948 Comm: blktrace Not tainted 5.4.0-rc7-00003-gfeb4a51323bab #1
> >       Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.10.2-1 04/01/2014
> >       RIP: 0010:irq_work_sync+0x4/0x10
> >       Call Trace:
> >         relay_close_buf+0x19/0x50
> >         relay_close+0x64/0x100
> >         blk_trace_free+0x1f/0x50
> >         __blk_trace_remove+0x1e/0x30
> >         blk_trace_ioctl+0x11b/0x140
> >         blkdev_ioctl+0x6c1/0xa40
> >         block_ioctl+0x39/0x40
> >         do_vfs_ioctl+0xa5/0x700
> >         ksys_ioctl+0x70/0x80
> >         __x64_sys_ioctl+0x16/0x20
> >         do_syscall_64+0x5b/0x1d0
> >         entry_SYSCALL_64_after_hwframe+0x44/0xa9
> >
> > So clear the appropriate bit before passing the old flags to cmpxchg().
> >
> > Reported-by: kernel test robot <rong.a.chen@intel.com>
> > Reported-by: Leonard Crestez <leonard.crestez@nxp.com>
> > Fixes: feb4a51323ba ("irq_work: Slightly simplify IRQ_WORK_PENDING clearing")
> > Signed-off-by: Frederic Weisbecker <frederic@kernel.org>
> > Cc: Paul E . McKenney <paulmck@linux.vnet.ibm.com>
> > Cc: Peter Zijlstra <peterz@infradead.org> everywhere.
> > Cc: Thomas Gleixner <tglx@linutronix.de>
> > Cc: Ingo Molnar <mingo@kernel.org>
>
> Tested-by: Leonard Crestez <leonard.crestez@nxp.com>
>
> Without this patch switching cpufreq governors hangs on arm64.

Right.

This patch solved two problems,
1) juno-r2 boot pass now
2) rcu_sched self-detected stall on CPU on x86_64 problem is solved now.

Tested-by: Naresh Kamboju <naresh.kamboju@linaro.org>

Hope this will get merged into linux next.

ref:
https://lkft.validation.linaro.org/scheduler/job/1010542#L260
https://lkft.validation.linaro.org/scheduler/job/1010793#L493

- Naresh
