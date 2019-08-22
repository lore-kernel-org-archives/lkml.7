Return-Path: <SRS0=/WLL=WS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DAB09C3A5A3
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Aug 2019 18:24:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AFAF023400
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Aug 2019 18:24:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JjSJQtGt"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388741AbfHVSY3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 22 Aug 2019 14:24:29 -0400
Received: from mail-ua1-f53.google.com ([209.85.222.53]:37257 "EHLO
        mail-ua1-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727685AbfHVSY3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Aug 2019 14:24:29 -0400
Received: by mail-ua1-f53.google.com with SMTP id f9so2337205uaj.4
        for <linux-kernel@vger.kernel.org>; Thu, 22 Aug 2019 11:24:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=RyMbtTLUWCmoliNTAnndKPMWCp0b4Jb6ryQcQLXyRPk=;
        b=JjSJQtGtEHCCNTj150vGW5+IpYhImY2UzbDtjgs4fQWzbQTHkTDfsTTl6FpavisshJ
         fwcs+njq9+RsyDcoV112B1tJf42BSk8bVmtw3FXoBECYvX++AeTBda1RcvqlSWxy182h
         3x3WyPptDBifo8JNFSVk1D4m9kVAAvElZMUwLx9uyQZZNOoJJvC28/6cg/D3DduaWb6N
         zqGOKC3DbGAvkqbqdbt148Iv31HDBWJe9KIBsqitJe0xtfqQQHn4pZuCU7jmK7liN2I4
         LG/EAV7E0aAVPr2xtqGsPgf1klpmq431jYayAK+17anGdxIN/hKTl76IuPK6Fy0wRjvh
         8vzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=RyMbtTLUWCmoliNTAnndKPMWCp0b4Jb6ryQcQLXyRPk=;
        b=sUb37HRvQ0H98CCRiRCjn7H5e/JuM4y4IJWl0RGbUKsTkHHGxkyNHGK1aGtbiPlg4z
         jiIydD+ey2TKA6FLLvMUQkkuWdfkeNeq+AoXEB7BmMQco3SQ0oAw8oz1cn43WLW5VymU
         EnWRtrXIoW2bRcGrd6pVNj4SSwxvU1P7cBpqEou6rA92p0grkSNrIIPNrYHZpLxXgXpl
         +FCfjfdewtUmU84uGUMc1b5IVerIYQ9yNyTLiC4c9Vih4oHFEJoreYesYG2DtjX2ZVDy
         CWDvnOdEXnk3QDxOSHvuK/R9ZbhufLhbnazt+A1QIwxjr4rK/BOvBSz76nVspectn+SO
         /UHA==
X-Gm-Message-State: APjAAAXTi2z08YXhqSeLakSmur5WxYhqI/E3oT+HonOpMEAuLFbEpL2n
        uFpztZVem3OZtiri2xZUC/h/lL8xQeVLM+CAxpI=
X-Google-Smtp-Source: APXvYqx1J/Ncnfo9JgGyq3fQGw8OEaIMxKLGGLgK2xQXI3wljRgHLN8cm74bJyiNWXXKWFJiioDxBRgNgg6xLX2AjqA=
X-Received: by 2002:ab0:70ac:: with SMTP id q12mr624615ual.134.1566498268191;
 Thu, 22 Aug 2019 11:24:28 -0700 (PDT)
MIME-Version: 1.0
References: <CACDBo57u+sgordDvFpTzJ=U4mT8uVz7ZovJ3qSZQCrhdYQTw0A@mail.gmail.com>
 <20190822125231.GJ12785@dhcp22.suse.cz>
In-Reply-To: <20190822125231.GJ12785@dhcp22.suse.cz>
From:   Pankaj Suryawanshi <pankajssuryawanshi@gmail.com>
Date:   Thu, 22 Aug 2019 23:54:19 +0530
Message-ID: <CACDBo57OkND1LCokPLfyR09+oRTbA6+GAPc90xAEF6AM_LmbyQ@mail.gmail.com>
Subject: Re: PageBlocks and Migrate Types
To:     Michal Hocko <mhocko@kernel.org>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Vlastimil Babka <vbabka@suse.cz>,
        pankaj.suryawanshi@einfochips.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 22, 2019 at 6:22 PM Michal Hocko <mhocko@kernel.org> wrote:
>
> On Wed 21-08-19 22:23:44, Pankaj Suryawanshi wrote:
> > Hello,
> >
> > 1. What are Pageblocks and migrate types(MIGRATE_CMA) in Linux memory ?
>
> Pageblocks are a simple grouping of physically contiguous pages with
> common set of flags. I haven't checked closely recently so I might
> misremember but my recollection is that only the migrate type is stored
> there. Normally we would store that information into page flags but
> there is not enough room there.
>
> MIGRATE_CMA represent pages allocated for the CMA allocator. There are
> other migrate types denoting unmovable/movable allocations or pages that
> are isolated from the page allocator.
>
> Very broadly speaking, the migrate type groups pages with similar
> movability properties to reduce fragmentation that compaction cannot
> do anything about because there are objects of different properti
> around. Please note that pageblock might contain objects of a different
> migrate type in some cases (e.g. low on memory).
>
> Have a look at gfpflags_to_migratetype and how the gfp mask is converted
> to a migratetype for the allocation. Also follow different MIGRATE_$TYPE
> to see how it is used in the code.
>
> > How many movable/unmovable pages are defined by default?
>
> There is nothing like that. It depends on how many objects of a specific
> type are allocated.


It means that it started creating pageblocks after allocation of
different objects, but from which block it allocate initially when
there is nothing like pageblocks ? (when memory subsystem up)

Pageblocks and its type dynamically changes ?
>
>
> HTH
> --
> Michal Hocko
> SUSE Labs
