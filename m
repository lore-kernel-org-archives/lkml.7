Return-Path: <SRS0=TLrx=2G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6B376C43603
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Dec 2019 13:21:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3EC08206D8
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Dec 2019 13:21:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FSKVsWM1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727882AbfLPNVT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 16 Dec 2019 08:21:19 -0500
Received: from mail-lj1-f194.google.com ([209.85.208.194]:40498 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727653AbfLPNVS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Dec 2019 08:21:18 -0500
Received: by mail-lj1-f194.google.com with SMTP id s22so6764362ljs.7;
        Mon, 16 Dec 2019 05:21:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=lQsx8zyUIj5ObfEsFUexXNSRbHHE+0/ar0m0MFvhew8=;
        b=FSKVsWM16+PZVcbPhQt4ueF6AvXIFYCF2rK1iib2leLOhYfLAlCBok2E2VtzZeOtGk
         /oLy93zRfA4lyN2CMOk/ySN7zgYBkyO0tz6h1djzZZ+xV1NMKe9mIEuBChiGJtnHeeym
         vJvr2+RqP8Ul+YslzB/p6fLfABbFoDWUuoVQ9m58fJ4IZOFVPWtKrYBdVghNKteVaZho
         6cyvPBzjwCE0x++n2O5iQW6qtLdh8D7OjE9SUrwEhxej9bZD+ukxlrPzLh5YN7Rim7Kh
         j1HNIYKN3QlR1mz4AiqDr2TandMNyMvMjqHXtCP1iMwckpiRvBxXKJETj9ffuaG8hwfS
         4phg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=lQsx8zyUIj5ObfEsFUexXNSRbHHE+0/ar0m0MFvhew8=;
        b=Y1bRDzpoGm4onV8D+w1rXw8hVTJRcqFzaQbL+cIcdTLzw9k1aOmE4SGid30b520DUr
         cqHI5PXUtPwRsdx22PAGuNhzrtWxnvfm/oE+gEjLOmwIU2JImBUgB/EC9ZBHJ3F733In
         BOVNe5TlcGmH25+LP9HncLw9cvvD6wJH5a+rA4Rohw2XNcF0GQYSbLTh2pevHM3IRGAf
         cV3Th3Wj2c6wk2PoNUELPPmOXaL319OkMwSJtFPT0hzrlh/n/1WhOXOl+imieLS/bJte
         rw0abbAvOsLmZPWJOp81jBysMLXZLnnAeyWd/B3H2Q7lVAwSv25AIEAgg5cqmKopqgYy
         sSLw==
X-Gm-Message-State: APjAAAW1IMDjIe9czvczf/bIBahhopkKp1DVsTusOmhb++fYB9axqU0N
        oY9oRHVtexO/A0ayGBeDWfa4Iqoxa5p6MS4f6os=
X-Google-Smtp-Source: APXvYqwyasL4AV9P77TBAwFOUCaOWSbMYr6wZzieWtwjK2yo6sJwnMOm8nr7r2NEKviSPQ6GeMTlFbGJtP4kQXgnngM=
X-Received: by 2002:a2e:8152:: with SMTP id t18mr19475012ljg.255.1576502476464;
 Mon, 16 Dec 2019 05:21:16 -0800 (PST)
MIME-Version: 1.0
References: <20191216103522.32215-1-gonsolo@gmail.com> <20191216103522.32215-2-gonsolo@gmail.com>
 <CAMuHMdVotJuotVKa3rxgR3ujCedoWM19-HhwhbTC9g6gV_EVNw@mail.gmail.com>
In-Reply-To: <CAMuHMdVotJuotVKa3rxgR3ujCedoWM19-HhwhbTC9g6gV_EVNw@mail.gmail.com>
From:   Gonsolo <gonsolo@gmail.com>
Date:   Mon, 16 Dec 2019 14:21:05 +0100
Message-ID: <CANL0fFS81NgFBcMBdWo6OKefz04h_FeXadcau9Rkcna7Ap5PDw@mail.gmail.com>
Subject: Re: [PATCH 1/1] Fix undefined reference to 'node_reclaim_distance'.
To:     Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     Yoshinori Sato <ysato@users.sourceforge.jp>,
        Rich Felker <dalias@libc.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Mike Rapoport <rppt@linux.ibm.com>,
        Nicholas Piggin <npiggin@gmail.com>,
        Linux-sh list <linux-sh@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> Unfortunately that may be an x86-centric assumption: on other platforms,
> there do exist systems with multiple memory banks with different access
> performance figures.

Does that mean that the line

obj-$(CONFIG_SMP) += cpupri.o cpudeadline.o topology.o stop_task.o pelt.o

in kernel/sched/topology/Makefile:23 is wrong?

Because in topology.c:1284 the variable node_reclaim_distance ist defined
which is used in mm/page_alloc.c:3529 without depending on SMP.

-- 
g
