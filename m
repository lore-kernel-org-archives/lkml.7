Return-Path: <SRS0=CEgE=VT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 565F7C76188
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Jul 2019 10:48:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3222A21911
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Jul 2019 10:48:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729742AbfGVKs0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 22 Jul 2019 06:48:26 -0400
Received: from mail-qk1-f193.google.com ([209.85.222.193]:43244 "EHLO
        mail-qk1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727310AbfGVKs0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Jul 2019 06:48:26 -0400
Received: by mail-qk1-f193.google.com with SMTP id m14so2522101qka.10
        for <linux-kernel@vger.kernel.org>; Mon, 22 Jul 2019 03:48:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ptJ26MvlaRt4VkcC7ihkvbPVm3VliBbM0BJH3L/2g2c=;
        b=MY5OF7pAGl2WoETTngy0vBnHyYa2TmKcKvxvE1Zu7El1lCjkrNufWzkf5EiXJ4XxN5
         9JNx91Dr1NFzNBxB/0tBDTiidrKOPIlfLuPqz1MUH54nNNNnUsvSc7xs8nov1X+y+Gy0
         zl8bAisUGIW4su8kWAp0RudOq8lM/V51jtLMjK8f1Xo+0bmog8rIlYDDlXGTJN0Utg8B
         e/CsgiCrR50aEZIzKe04dsnzzv5DvXEs+EX0hSMOZerf3WAvt4zGfY5r1vqhihCEx/DU
         TsCjSVrUjQUclrFIrYGnmDIPK0mVMLfZxE5YmQbxyP5Ml22lvux6WkPUZkMuJDAnXfdl
         8pdg==
X-Gm-Message-State: APjAAAVytHnXdAcsy+slkE57WeBmQNAIjFRIVi/b/THHMMIK09vOEOJS
        1G8L5BXztJwR6ya+3e2w88QnbSfcDS7WERc2XE4=
X-Google-Smtp-Source: APXvYqzxtcAqz4bSxc8nm4TP5i62NaUmgS/Rlxiv4Sl82qujheNOGzRQ6t8AlZYNuaJ6qRprS++3xGM6vk966FnFKfk=
X-Received: by 2002:a37:4ac3:: with SMTP id x186mr44445628qka.138.1563792505294;
 Mon, 22 Jul 2019 03:48:25 -0700 (PDT)
MIME-Version: 1.0
References: <20190710130206.1670830-1-arnd@arndb.de> <33511b0e-6d7b-c156-c415-7a609b049567@arm.com>
 <CAK8P3a1EBaWdbAEzirFDSgHVJMtWjuNt2HGG8z+vpXeNHwETFQ@mail.gmail.com>
 <alpine.DEB.2.21.1907221207000.1782@nanos.tec.linutronix.de> <8f01be52-3235-644d-4afc-df979bfce25e@suse.com>
In-Reply-To: <8f01be52-3235-644d-4afc-df979bfce25e@suse.com>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Mon, 22 Jul 2019 12:48:08 +0200
Message-ID: <CAK8P3a0_rEkWYgH_Tc7jwpYOYMy5wA+X0zchQcsXYi62kUG61A@mail.gmail.com>
Subject: Re: [PATCH] vsyscall: use __iter_div_u64_rem()
To:     Jan Beulich <JBeulich@suse.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        clang-built-linux <clang-built-linux@googlegroups.com>,
        Andy Lutomirski <luto@kernel.org>,
        "x86@kernel.org" <x86@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 22, 2019 at 12:39 PM Jan Beulich <JBeulich@suse.com> wrote:
> On 22.07.2019 12:10, Thomas Gleixner wrote:
> > On Thu, 11 Jul 2019, Arnd Bergmann wrote:
> "q" was used in that commit exclusively for byte sized operands, simply
> because that _is_ the constraint to use in such cases. Using "r" is
> wrong on 32-bit, as it would include inaccessible byte portions of %sp,
> %bp, %si, and %di. This is how it's described in gcc sources / docs:
>
>   "Any register accessible as @code{@var{r}l}.  In 32-bit mode, @code{a},
>    @code{b}, @code{c}, and @code{d}; in 64-bit mode, any integer register."
>
> What I'm struggling with is why clang would evaluate that asm() in the
> first place when a 64-bit field (perf_ctr_virt_mask) is being accessed.

clang does the optimization and warning checking in a different order,
in this case the argument type checks for the inline assembly is done
before it eliminates the dead code.

        Arnd
