Return-Path: <SRS0=wfQU=S6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D13B5C43219
	for <linux-kernel@archiver.kernel.org>; Sun, 28 Apr 2019 22:46:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 97F5120656
	for <linux-kernel@archiver.kernel.org>; Sun, 28 Apr 2019 22:46:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1556491592;
	bh=e7BFQHKHDCRY4ywasnYlNUEPpVRN6QFaTwlQQ5k/QWo=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=i9nsPLOoUft3RTOA2oeBBm5T6qH1XTIrFBjVsx6Bl3roRQvM6gci9C3uqLscvD8Xh
	 H2yQCh0T6KzALTa+p3NtRjl51nvy0PusPVkSmrJof4K70qdmJqt9nNid2TE692QAtE
	 +PEovhCYl4uiuXfNJQPVh3ycIK9lnPkJKE6WtMm0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726580AbfD1Wq3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 28 Apr 2019 18:46:29 -0400
Received: from mail-lj1-f194.google.com ([209.85.208.194]:44598 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726393AbfD1Wq2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 28 Apr 2019 18:46:28 -0400
Received: by mail-lj1-f194.google.com with SMTP id c6so1114625lji.11
        for <linux-kernel@vger.kernel.org>; Sun, 28 Apr 2019 15:46:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=RlPUF5DPppO5kJlvz7okPOHN8kYgd85Whqp1ZnjpbGg=;
        b=X54SyTSrXpMJr7fhaCEVGQXPaJpi2jGYrp6wQZsyxKPZq9GjmPOnCspoDeVCe8HdZJ
         wGiCCjkToJczyhU8SvVZ6jUusmdHPYkQlEALtK2jq5+wZPHp90BZ82jW9ckmFZQEaoRn
         OQwEhoJSv3A+lxxWTfl28HefOOGdAR/AFfUGA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=RlPUF5DPppO5kJlvz7okPOHN8kYgd85Whqp1ZnjpbGg=;
        b=Ujg/9tOM05+VrXzHpT5kk5/ZDfi+qrVpMswC7kVKGKbzpMiDKxafB/C7lNydVNkq9m
         MfnZOOhuvmTLtbpbBEZK4kBvWJAanpTM1KWB05568CpbxTjWlJgeBRxJsvDSd2nEtnNd
         bw8U4xUGfPAsz8ql01EeI06KfmwY3EfhYHOWqwbEqluJcacxYD5MVN0ZWGsXYTwGs7qN
         PqDFcdzlOj2luUg0Xh7s6pL3I8v3epEqACSN84/KUPmEXA3UFMN9hmMKwCFrAZfm/GXI
         BC/bMiSGQr094oS+Gfbn8dIP2FCxpPFavGyhevFbi94p2rLV4dPVnNJNaAEybGHkjzpL
         zseg==
X-Gm-Message-State: APjAAAXZWrJTNTpHlMXWHQcl8WqGwYJJe04xzCjmQh+EZfH87jdvHbx/
        b5BQqxqVlETDxm1EizdfCEGvLmPje+w=
X-Google-Smtp-Source: APXvYqxvz+QpcenBlLnl3pk17w80Q8ktJ9ulpepBay9rKulI2CaEpFvYSPgN1HSusXD4TcL2Raw85Q==
X-Received: by 2002:a2e:884a:: with SMTP id z10mr21092288ljj.21.1556491586435;
        Sun, 28 Apr 2019 15:46:26 -0700 (PDT)
Received: from mail-lj1-f181.google.com (mail-lj1-f181.google.com. [209.85.208.181])
        by smtp.gmail.com with ESMTPSA id w19sm7067398lfe.23.2019.04.28.15.46.23
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 28 Apr 2019 15:46:24 -0700 (PDT)
Received: by mail-lj1-f181.google.com with SMTP id z26so7656801ljj.2
        for <linux-kernel@vger.kernel.org>; Sun, 28 Apr 2019 15:46:23 -0700 (PDT)
X-Received: by 2002:a2e:5bdd:: with SMTP id m90mr3956870lje.2.1556491583114;
 Sun, 28 Apr 2019 15:46:23 -0700 (PDT)
MIME-Version: 1.0
References: <20190428212557.13482-1-longman@redhat.com>
In-Reply-To: <20190428212557.13482-1-longman@redhat.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Sun, 28 Apr 2019 15:46:07 -0700
X-Gmail-Original-Message-ID: <CAHk-=whU83HbayBmOS-jbK7bQJUp87mvAYxhL=vz5wC_ARQCWA@mail.gmail.com>
Message-ID: <CAHk-=whU83HbayBmOS-jbK7bQJUp87mvAYxhL=vz5wC_ARQCWA@mail.gmail.com>
Subject: Re: [PATCH-tip v7 00/20] locking/rwsem: Rwsem rearchitecture part 2
To:     Waiman Long <longman@redhat.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Will Deacon <will.deacon@arm.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Linux List Kernel Mailing <linux-kernel@vger.kernel.org>,
        "the arch/x86 maintainers" <x86@kernel.org>,
        Davidlohr Bueso <dave@stgolabs.net>,
        Tim Chen <tim.c.chen@linux.intel.com>,
        huang ying <huang.ying.caritas@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This doesn't seem to be the full diff - looking at that patch 1 you
seem to have taken my suggested list_cut_before() change too.

I'm not against it (it does seem to be simpler and better), I just
hope you double-checked it, since I kind of hand-waved it.

                    Linus

On Sun, Apr 28, 2019 at 2:26 PM Waiman Long <longman@redhat.com> wrote:
>
>  v6=>v7 diff
>  -----------
> diff --git a/kernel/locking/rwsem.c b/kernel/locking/rwsem.c
> index 97a2334d9cd3..60783267b50d 100644
> --- a/kernel/locking/rwsem.c
> +++ b/kernel/locking/rwsem.c
> @@ -693,7 +693,7 @@ static void __rwsem_mark_wake(struct rw_semaphore *sem,
>                 atomic_long_add(adjustment, &sem->count);
>
>         /* 2nd pass */
> -       list_for_each_entry(waiter, &wlist, list) {
> +       list_for_each_entry_safe(waiter, tmp, &wlist, list) {
>                 struct task_struct *tsk;
>
>                 tsk = waiter->task;
>
