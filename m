Return-Path: <SRS0=CtY/=UD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,T_DKIMWL_WL_HIGH autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85AA9C282CE
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Jun 2019 21:27:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 52379207E0
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Jun 2019 21:27:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1559683624;
	bh=oQ1JVM7OTEDQtkaAi9QY0NyPFMx/9MMFSQQMnQkpRPo=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=K7SkKiMlSt14ijA7mNhERHozaJ6DUnHVU26xWbD50UWCK8lln8Ndzdjj8mshUhz5W
	 ZocHFEqCDllQ0booj0l0wrLjfnkrO/p9oy8oMv4zSXC5reE7FBHujeqePN8nbwe16P
	 az3sItfLbAs88hZ7rDP72DwnalpRBxdS2S5SLgIc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726593AbfFDV1D (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Jun 2019 17:27:03 -0400
Received: from mail-lf1-f68.google.com ([209.85.167.68]:45528 "EHLO
        mail-lf1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726179AbfFDV1D (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Jun 2019 17:27:03 -0400
Received: by mail-lf1-f68.google.com with SMTP id u10so10504598lfm.12
        for <linux-kernel@vger.kernel.org>; Tue, 04 Jun 2019 14:27:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=fjr6VsCXE/x8E/UigyoFfXOlatfjUvy0HOG/EWEq9/E=;
        b=AqnHNsD1VskjlimA3YwkF5JNU3DvSRUk55MoR6ni75AS44QkMcJCvxHI3dSdlI6y5J
         mKW0Es7RWq6sAXJ9MeVUOaPQSf8pexTFCehFbQMkkbeBhb+EWYhswZLPdoe2U/wgnvPd
         T/eBCFdkAAdh/w7SO0Y9hNdRXoDDz3+5dAwXw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=fjr6VsCXE/x8E/UigyoFfXOlatfjUvy0HOG/EWEq9/E=;
        b=sFK5NbsDtwWIG/OHI2aDkp14PoT/cZttTfsz7x+youDTtd0NZte3jjaWUwMB3iwcQz
         OKjBXHxdLHKSL5T4XGmrXb2UjgbORgi0Q/6ozt79hULLI0jgA1aKBzIoISjS4cNNOFU3
         3XHgmCZKKcVYSKWQRIng2EAeGiib4x6nJ+AMwMgUAham/3mK8J9Ri4wKAhPir60gNagv
         cFdS8ETWzaEa7ZFQkZwhzPUhq8t3+TTcRkoTZinDHCkSWV32Z2ZwgaJBB+Faon3qPnQ7
         MzEdrMKhf1iJ4bzBRabm9KNqBjGcxNwuH7+eKACs0EICV/jHVUdZgxF2Wky+otIabCV8
         3U6g==
X-Gm-Message-State: APjAAAVtmo+owZjNDdK5J5OK+JON4wDX56LkAERwNnPDjMS2kyIMojq+
        P7LZ1AXtDUVDj0uhVYMmibt4usuAuVA=
X-Google-Smtp-Source: APXvYqxMH/s+lAXumbjHAq26NPiRIsjskKnJKL4a7W7SDshWWh/ihN31HnEb0uaWvnDfzEQ2LQBCuA==
X-Received: by 2002:a19:2948:: with SMTP id p69mr17512979lfp.160.1559683620631;
        Tue, 04 Jun 2019 14:27:00 -0700 (PDT)
Received: from mail-lf1-f53.google.com (mail-lf1-f53.google.com. [209.85.167.53])
        by smtp.gmail.com with ESMTPSA id m25sm2914933lfp.97.2019.06.04.14.26.59
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 04 Jun 2019 14:26:59 -0700 (PDT)
Received: by mail-lf1-f53.google.com with SMTP id j29so3627662lfk.10
        for <linux-kernel@vger.kernel.org>; Tue, 04 Jun 2019 14:26:59 -0700 (PDT)
X-Received: by 2002:a19:ae01:: with SMTP id f1mr17362076lfc.29.1559683618741;
 Tue, 04 Jun 2019 14:26:58 -0700 (PDT)
MIME-Version: 1.0
References: <20190522032144.10995-1-deepa.kernel@gmail.com>
 <20190529161157.GA27659@redhat.com> <20190604134117.GA29963@redhat.com>
In-Reply-To: <20190604134117.GA29963@redhat.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Tue, 4 Jun 2019 14:26:42 -0700
X-Gmail-Original-Message-ID: <CAHk-=wjSOh5zmApq2qsNjmY-GMn4CWe9YwdcKPjT+nVoGiDKOQ@mail.gmail.com>
Message-ID: <CAHk-=wjSOh5zmApq2qsNjmY-GMn4CWe9YwdcKPjT+nVoGiDKOQ@mail.gmail.com>
Subject: Re: [PATCH] signal: remove the wrong signal_pending() check in restore_user_sigmask()
To:     Oleg Nesterov <oleg@redhat.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Deepa Dinamani <deepa.kernel@gmail.com>,
        Linux List Kernel Mailing <linux-kernel@vger.kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Davidlohr Bueso <dbueso@suse.de>, Jens Axboe <axboe@kernel.dk>,
        Davidlohr Bueso <dave@stgolabs.net>, e@80x24.org,
        Jason Baron <jbaron@akamai.com>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        linux-aio@kvack.org, omar.kilani@gmail.com,
        Thomas Gleixner <tglx@linutronix.de>,
        stable <stable@vger.kernel.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        David Laight <David.Laight@aculab.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 4, 2019 at 6:41 AM Oleg Nesterov <oleg@redhat.com> wrote:
>
> This is the minimal fix for stable, I'll send cleanups later.

Ugh. I htink this is correct, but I wish we had a better and more
intuitive interface.

In particular, since restore_user_sigmask() basically wants to check
for "signal_pending()" anyway (to decide if the mask should be
restored by signal handling or by that function), I really get the
feeling that a lot of these patterns like

> -       restore_user_sigmask(ksig.sigmask, &sigsaved);
> -       if (signal_pending(current) && !ret)
> +
> +       interrupted = signal_pending(current);
> +       restore_user_sigmask(ksig.sigmask, &sigsaved, interrupted);
> +       if (interrupted && !ret)
>                 ret = -ERESTARTNOHAND;

are wrong to begin with, and we really should aim for an interface
which says "tell me whether you completed the system call, and I'll
give you an error return if not".

How about we make restore_user_sigmask() take two return codes: the
'ret' we already have, and the return we would get if there is a
signal pending and w're currently returning zero.

IOW, I think the above could become

        ret = restore_user_sigmask(ksig.sigmask, &sigsaved, ret, -ERESTARTHAND);

instead if we just made the right interface decision.

Hmm?

             Linus
