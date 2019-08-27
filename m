Return-Path: <SRS0=qJmF=WX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 60B83C41514
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Aug 2019 11:56:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3739220828
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Aug 2019 11:56:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="j2rsb5Zy"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728830AbfH0L4x (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 27 Aug 2019 07:56:53 -0400
Received: from mail-io1-f68.google.com ([209.85.166.68]:38495 "EHLO
        mail-io1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726125AbfH0L4x (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Aug 2019 07:56:53 -0400
Received: by mail-io1-f68.google.com with SMTP id p12so45656769iog.5
        for <linux-kernel@vger.kernel.org>; Tue, 27 Aug 2019 04:56:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=sv7ctbIZmhwfvVvphyckgTgWoG/tmxYo1/lJYp9bSvw=;
        b=j2rsb5Zy+AB9R0Bl7fWdPlgvbKytKWzmVQPCoO43x0Ay/Bd3pOoIR0c9iT14m/OvPe
         xyY0KwO1dImbbwhuMxSgJa2FfeUgyvHYdtiIgmfjhd5AtHxXNJ2y7ZkXq8MWIzqbq2A9
         r9dKOF+mXRl8kxZnDZreIbyv44HsC1GGhn72F1A3sp+/UlfrCczmhqzrgROwC7du8o4f
         He3wwj6di7eALXWIo+1u4OXZYuI9iZupox82Jmcsd1+VPnqHClTxXGzVOeEnHSztbZhA
         i28nQz0IDadiw6JVCDp8L6gVD/ZULdUhEpeFvQDmD4bLtxqYgWWzv5n9lNeAutHVox4q
         Jw6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=sv7ctbIZmhwfvVvphyckgTgWoG/tmxYo1/lJYp9bSvw=;
        b=NKgRAwq8o19KXOQKZnHkHAqbAhosrcbw8He3/pCvnLY1ZOJlXeU60DOX5tbZWx3+p1
         BvIXuZ+UErFbeUheocucTpraNVuqmGH03aneHdq4dLqpxbU8lpFvnrLbJ5N2gEGK+lGk
         bOoUhMpgA0jN4fMAM9RqL40CpH/CEESeq0xERpoTOu6uCDOHYV5nt7wNUOpc4G5lkRFs
         mXYW0v/1i0dRRq0zBJbxxSQvzUn0cRRxeJWkr+COsXLMdYzC20/KFMK3tc2M5/86hDEO
         nggfGYsz9Z2gLhN2W2agvn+k0p9/8dLAT9lMvwdygT8ppYOk/DuIyMKzJuo778+o6tOQ
         IdHA==
X-Gm-Message-State: APjAAAXn0+WhPwRuj7LKKenBW+97YfEyVCd/BO6w00SBRbfx7fJ//RJU
        hp2CUNHBS0EgQJ1RzNAZOzsiQFllrYg7t7SB2Wg=
X-Google-Smtp-Source: APXvYqxX6vjVuvQsFhLZ+TP9EWx2J7QXvByD4P4FHjFLjOiRvzgi1yY2tYNCxA+qddXjAulll80dgnyyZa2cfYSqTzE=
X-Received: by 2002:a5e:df06:: with SMTP id f6mr20004377ioq.93.1566907012782;
 Tue, 27 Aug 2019 04:56:52 -0700 (PDT)
MIME-Version: 1.0
References: <CAE1jjeePxYPvw1mw2B3v803xHVR_BNnz0hQUY_JDMN8ny29M6w@mail.gmail.com>
 <b9cd7603-2441-d351-156a-57d6c13b2c79@linux.alibaba.com> <20190826105521.GF7538@dhcp22.suse.cz>
 <20190827104313.GW7538@dhcp22.suse.cz> <CALOAHbBMWyPBw+Ciup4+YupbLrxcTW76w+Mfc-mGEm9kcWb8YQ@mail.gmail.com>
 <20190827115014.GZ7538@dhcp22.suse.cz>
In-Reply-To: <20190827115014.GZ7538@dhcp22.suse.cz>
From:   Yafang Shao <laoar.shao@gmail.com>
Date:   Tue, 27 Aug 2019 19:56:16 +0800
Message-ID: <CALOAHbAtuQFB=GC41ZgSLXxheaEY4yz=fO9Zr5=rvTnyOYjF3A@mail.gmail.com>
Subject: Re: WARNINGs in set_task_reclaim_state with memory cgroup and full
 memory usage
To:     Michal Hocko <mhocko@kernel.org>
Cc:     Yang Shi <yang.shi@linux.alibaba.com>,
        Adric Blake <promarbler14@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Kirill Tkhai <ktkhai@virtuozzo.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Daniel Jordan <daniel.m.jordan@oracle.com>,
        Mel Gorman <mgorman@techsingularity.net>,
        Linux MM <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 27, 2019 at 7:50 PM Michal Hocko <mhocko@kernel.org> wrote:
>
> On Tue 27-08-19 19:43:49, Yafang Shao wrote:
> > On Tue, Aug 27, 2019 at 6:43 PM Michal Hocko <mhocko@kernel.org> wrote:
> > >
> > > If there are no objection to the patch I will post it as a standalong
> > > one.
> >
> > I have no objection to your patch. It could fix the issue.
> >
> > I still think that it is not proper to use a new scan_control here as
> > it breaks the global reclaim context.
> >
> > This context switch from global reclaim to memcg reclaim is very
> > subtle change to the subsequent processing, that may cause some
> > unexpected behavior.
>
> Why would it break it? Could you be more specific please?
>

Hmm, I have explained it when replying to  Hillf's patch.
The most suspcious one is settting target_mem_cgroup here, because we
only use it to judge whether it is in global reclaim.
While the memcg softlimit reclaim is really in global reclaims.

Another example the reclaim_idx, if is not same with reclaim_idx in
page allocation context, the reclaimed pages may not be used by the
allocator, especially in the direct reclaim.

And some other things in scan_control.

> > Anyway, we can send this patch as a standalong one.
> > Feel free to add:
> >
> > Acked-by: Yafang Shao <laoar.shao@gmail.com>
>
> Thanks!
> --
> Michal Hocko
> SUSE Labs
