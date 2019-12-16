Return-Path: <SRS0=TLrx=2G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 79CA4C43603
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Dec 2019 13:31:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 573E4206D8
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Dec 2019 13:31:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727916AbfLPNb1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 16 Dec 2019 08:31:27 -0500
Received: from mail-oi1-f194.google.com ([209.85.167.194]:41517 "EHLO
        mail-oi1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727601AbfLPNb0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Dec 2019 08:31:26 -0500
Received: by mail-oi1-f194.google.com with SMTP id i1so3293311oie.8;
        Mon, 16 Dec 2019 05:31:26 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=adjDVaDOpI8al3CJQ77m74YYE8EkJXzR3/QYajElcEI=;
        b=StC/OOVyFh/DCx1ibsKGFWicd83T1QyAS6dvKFXQY7CHTwLgm3KDUnXit8naQXFdwx
         y0KJcWqhHxtYuJkWPW4Babu4/kbKqvsVXsvc5T/hO1/17LynlDxHj4f+wW0M9po/wukt
         fReAYQ6Fx/mttEZl+FvenAZnEUPxpXnMArWsUfdKmCvcGHvv7ej6Ujbf+LnB/H27fl2p
         tIkuwZdqISHniJ2E02Jk7bE/Lfx6fzMO+isXsuaL0iVV7fYZzzwD0jUDeN8VeiOiTR1u
         SwKVt3A0KewXAl1zEHGnqFgaOAV9Xs0Pvz/WIjzY7NckqSK0dOxymZjR288oV1Wx7w2b
         +f2Q==
X-Gm-Message-State: APjAAAXhfeiNJM3YAEOLOsYik1OIrLZaGdIXMoXzElvYAnqMROdPl169
        cjcuByeLzPSTPU9vpjbvT6YErPjIf/lu1kF9CXs=
X-Google-Smtp-Source: APXvYqzpYtDQFaajS+ak1BudGvve2+sX5+qPNXt7bilITUMT9J0kfhP2OCfVlZn2kuME7LrilgZcj2EXBvnBUJh8rqA=
X-Received: by 2002:aca:36c5:: with SMTP id d188mr9745707oia.54.1576503086134;
 Mon, 16 Dec 2019 05:31:26 -0800 (PST)
MIME-Version: 1.0
References: <20191216103522.32215-1-gonsolo@gmail.com> <20191216103522.32215-2-gonsolo@gmail.com>
 <CAMuHMdVotJuotVKa3rxgR3ujCedoWM19-HhwhbTC9g6gV_EVNw@mail.gmail.com> <CANL0fFS81NgFBcMBdWo6OKefz04h_FeXadcau9Rkcna7Ap5PDw@mail.gmail.com>
In-Reply-To: <CANL0fFS81NgFBcMBdWo6OKefz04h_FeXadcau9Rkcna7Ap5PDw@mail.gmail.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Mon, 16 Dec 2019 14:31:15 +0100
Message-ID: <CAMuHMdVtm6BGx6d+F8-Bw+fD-M-DugspLkBvCtTKGgWiPvJnSA@mail.gmail.com>
Subject: Re: [PATCH 1/1] Fix undefined reference to 'node_reclaim_distance'.
To:     Gonsolo <gonsolo@gmail.com>
Cc:     Yoshinori Sato <ysato@users.sourceforge.jp>,
        Rich Felker <dalias@libc.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Mike Rapoport <rppt@linux.ibm.com>,
        Nicholas Piggin <npiggin@gmail.com>,
        Linux-sh list <linux-sh@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Matt Fleming <matt@codeblueprint.co.uk>,
        Randy Dunlap <rdunlap@infradead.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Gon,

On Mon, Dec 16, 2019 at 2:21 PM Gonsolo <gonsolo@gmail.com> wrote:
> > Unfortunately that may be an x86-centric assumption: on other platforms,
> > there do exist systems with multiple memory banks with different access
> > performance figures.
>
> Does that mean that the line
>
> obj-$(CONFIG_SMP) += cpupri.o cpudeadline.o topology.o stop_task.o pelt.o
>
> in kernel/sched/topology/Makefile:23 is wrong?
>
> Because in topology.c:1284 the variable node_reclaim_distance ist defined
> which is used in mm/page_alloc.c:3529 without depending on SMP.

The offending commit seems to be a55c7454a8c887b2 ("sched/topology:
Improve load balancing on AMD EPYC systems").

Probably the node_reclaim_distance variable should be moved from
an SMP-specific file to a NUMA-specific file.

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
