Return-Path: <SRS0=qJmF=WX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2380EC3A5A3
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Aug 2019 12:20:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E61B9206BF
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Aug 2019 12:20:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KVtpiXX+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729743AbfH0MUM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 27 Aug 2019 08:20:12 -0400
Received: from mail-io1-f66.google.com ([209.85.166.66]:40830 "EHLO
        mail-io1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726170AbfH0MUL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Aug 2019 08:20:11 -0400
Received: by mail-io1-f66.google.com with SMTP id t6so45779738ios.7
        for <linux-kernel@vger.kernel.org>; Tue, 27 Aug 2019 05:20:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=JZZ/56kClmUu9u3Lz2o/WyytqKT9LHvtxY62+NNR8z4=;
        b=KVtpiXX+jnNmjybRAgMq/v2UaZwJ8TQxwMhdPAdIblUW3hTj5KDbNBE+1U8XZrrqsD
         bvaBfzdSJd4O6jptxaZwR3veMwyukJ6IK/y9Oapht5+UPyYAcCfUpf/scv+s7NsBo8E9
         HHshJMGjEUwMyfZKGrBij9V+05AyT+6LD2+CYd/ELmgrnLDbigilxr759mZYDFLJUijN
         lTafxftfeIz+n2j45oT3V/WlfqrQ9YtsdZfe0aXUV38hqqetZw1YVglXySEVouRtR/nA
         xPuhta6YMWXVVN1R4GxNy0k1DADS4JvbLj9Bvq6vCV8Q0xR8QdQT/RC3+QOYg+nUbKs3
         6v/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=JZZ/56kClmUu9u3Lz2o/WyytqKT9LHvtxY62+NNR8z4=;
        b=gGKiTc0+hHBWjgCLF/OJY2VU1KfnKgCkrxOWrqv8tIcyvx+me4NsZd/EUpO2cUD4u2
         zNzJ1uYcN/U0+ITPMZ4zzCQe/3J6OyS9aVG5Lcyk2qZD33n0wEt4Jq50xUysdpPCRaq2
         ygiETtWy7LV3E87lbL4PuopaURfs2efiFEbmTz7Mn2KnqJ0hv554jDtBc/iij4hDetwn
         roGKB1D7Tz4LVYD6iOINsYM07rAg472/SYfr94kK7r7O83sFCzJ+zrow6NdPtIO44in3
         4rmHYQAoQ1wQniwT0p6KnwaT5w/IAWazXkJBebO//ZPyMCXT4BPDvW5REW69DkMX0iO+
         M0bA==
X-Gm-Message-State: APjAAAXIBK3iLpvQcqF7mPpL/EU1vdlkSi2AnDxuKYnWOqHacNIinfia
        fMT9i6g424PYGiCpaGlOrO5bmescVGU9AsVlFII=
X-Google-Smtp-Source: APXvYqxB8MslH6etRvDRLUd46ELBnidSNuloQ4pjR9WaeVYRpmCUEnHfXfiRR7Jcma77KFAblCBMNU0SZa/iXfGek7A=
X-Received: by 2002:a6b:c38f:: with SMTP id t137mr8388942iof.137.1566908410262;
 Tue, 27 Aug 2019 05:20:10 -0700 (PDT)
MIME-Version: 1.0
References: <CAE1jjeePxYPvw1mw2B3v803xHVR_BNnz0hQUY_JDMN8ny29M6w@mail.gmail.com>
 <b9cd7603-2441-d351-156a-57d6c13b2c79@linux.alibaba.com> <20190826105521.GF7538@dhcp22.suse.cz>
 <20190827104313.GW7538@dhcp22.suse.cz> <CALOAHbBMWyPBw+Ciup4+YupbLrxcTW76w+Mfc-mGEm9kcWb8YQ@mail.gmail.com>
 <20190827115014.GZ7538@dhcp22.suse.cz> <CALOAHbAtuQFB=GC41ZgSLXxheaEY4yz=fO9Zr5=rvTnyOYjF3A@mail.gmail.com>
 <20190827120335.GA7538@dhcp22.suse.cz>
In-Reply-To: <20190827120335.GA7538@dhcp22.suse.cz>
From:   Yafang Shao <laoar.shao@gmail.com>
Date:   Tue, 27 Aug 2019 20:19:34 +0800
Message-ID: <CALOAHbDbNxg1xxZAT0rf3=46DrM1PV2YEDEP6F9HMU9JvgvESA@mail.gmail.com>
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

On Tue, Aug 27, 2019 at 8:03 PM Michal Hocko <mhocko@kernel.org> wrote:
>
> On Tue 27-08-19 19:56:16, Yafang Shao wrote:
> > On Tue, Aug 27, 2019 at 7:50 PM Michal Hocko <mhocko@kernel.org> wrote:
> > >
> > > On Tue 27-08-19 19:43:49, Yafang Shao wrote:
> > > > On Tue, Aug 27, 2019 at 6:43 PM Michal Hocko <mhocko@kernel.org> wrote:
> > > > >
> > > > > If there are no objection to the patch I will post it as a standalong
> > > > > one.
> > > >
> > > > I have no objection to your patch. It could fix the issue.
> > > >
> > > > I still think that it is not proper to use a new scan_control here as
> > > > it breaks the global reclaim context.
> > > >
> > > > This context switch from global reclaim to memcg reclaim is very
> > > > subtle change to the subsequent processing, that may cause some
> > > > unexpected behavior.
> > >
> > > Why would it break it? Could you be more specific please?
> > >
> >
> > Hmm, I have explained it when replying to  Hillf's patch.
> > The most suspcious one is settting target_mem_cgroup here, because we
> > only use it to judge whether it is in global reclaim.
> > While the memcg softlimit reclaim is really in global reclaims.
>
> But we are reclaim the target_mem_cgroup hierarchy. This is the whole
> point of the soft reclaim. Push down that hierarchy below the configured
> limit. And that is why we absolutely have to switch the reclaim context.
>

One obvious issue is the reclaim couters may not correct.
See shrink_inactive_list().
The pages relcaimed in memcg softlimit will not be counted to
PGSCAN_{DIRECT, KSWAPD} and
PGSTEAL_{DIRECT, KSWAPD}.
That may cause some misleading. For example, if these counters are not
changed, we will think that direct relcaim doesn't occur, while it
really occurs.

May issues are also in  some other code around the usage of
global_reclaim(). I'm not sure of it.

> > Another example the reclaim_idx, if is not same with reclaim_idx in
> > page allocation context, the reclaimed pages may not be used by the
> > allocator, especially in the direct reclaim.
>
> Again, we do not care about that as well. All we care about is to
> reclaim _some_ memory to get below the soft limit. This is the semantic
> that is not really great but this is how the Soft reclaim has
> traditionally worked and why we keep claiming that people shouldn't
> really use it. It does lead to over reclaim and that is a design rather
> than a bug.
>
> > And some other things in scan_control.
>
> Like?
> --
> Michal Hocko
> SUSE Labs
>
