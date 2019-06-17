Return-Path: <SRS0=xALZ=UQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC364C31E5C
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Jun 2019 16:48:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 832AA208CB
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Jun 2019 16:48:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="DYbfUmrC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727940AbfFQQsz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Jun 2019 12:48:55 -0400
Received: from mail-yw1-f68.google.com ([209.85.161.68]:37503 "EHLO
        mail-yw1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726005AbfFQQsz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jun 2019 12:48:55 -0400
Received: by mail-yw1-f68.google.com with SMTP id 186so5352467ywo.4
        for <linux-kernel@vger.kernel.org>; Mon, 17 Jun 2019 09:48:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=+bhc7wfVjCBaM/En8KIXc3jvZNzrMiSbZDMErO7mmcg=;
        b=DYbfUmrCCAumnmXWODR8+LTnOQ7KCdpvfaHsby+TAizkhkgf9X+hDwVKW4YCRvdsbR
         /DOd5z4sNTjXhhHg4CBJHxUJprspmaW8XaWIiWkX+EV8vLcn2YwQSz+9l1BWRwYW+73b
         sRLre+0lZ4TKnygun0iG/ayZWy5ATKzXzNZl5MrbxQC3DEEIjRdnA13dv/ZlgoicmAOp
         g+jvdpAKS2ONslZ6WLqsoHuzSs2omaxjORyd3O7XTFtCOfvPuIEcfVq6Aw0u+QZRs2wk
         T+cp2SBxHX7+kuygOvMGZO3uv0/dBlh/APwxh1cjz+fNoqmHVtoZvU29KFhUYSks2J70
         GFHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=+bhc7wfVjCBaM/En8KIXc3jvZNzrMiSbZDMErO7mmcg=;
        b=jJoYU+Gr49RqF4b1lmy2Afo9EZ9fJQlvGCR8N6wKOrlgn22N5jYxocWdUPwBY7QCap
         dXm5xYbvHW11Hg35ZKF1kVLCWIO6kNcnwwp+yIR/PWFjzhIfqR9JZU89fUHRfpUhWGCV
         ouVbYT1f3MVGO0h8UF70K+E/YPpZ0TGuOECOjX3A4e0uCfn7bX+/DTIkchjFTxPmuQ99
         7OX5jcfzL+XFTKjAWIupekXhvfZFyA1ekipdEPLD6n2uho8wmb0BriiEUWedUAUJChvG
         cF6RekVVoulr2NGgklNxaXy+L3erwXIIxJn8PvQOdkZrEtVFRAVQp1RN9EXLzcMNGAxi
         Latg==
X-Gm-Message-State: APjAAAVt53HuY0KjN8v/ESKECTFDxOnb+rEPvalQ2MYIOCSf2wNTglX/
        x8ugUSKwJJXK1rvJDC9YioIw1FuE3eZdzx/NjHZURB6o68Y3jQ==
X-Google-Smtp-Source: APXvYqxYDlg2DGtdAFSTrNecvf6mKBN+e0hfaf7Tt/m0UWAiagrxescZo68t6wSXRTD7aC9x4EqbsMND7aHUQSudaIQ=
X-Received: by 2002:a81:a55:: with SMTP id 82mr29118544ywk.205.1560790134326;
 Mon, 17 Jun 2019 09:48:54 -0700 (PDT)
MIME-Version: 1.0
References: <20190617155954.155791-1-shakeelb@google.com> <20190617161702.GE1492@dhcp22.suse.cz>
In-Reply-To: <20190617161702.GE1492@dhcp22.suse.cz>
From:   Shakeel Butt <shakeelb@google.com>
Date:   Mon, 17 Jun 2019 09:48:42 -0700
Message-ID: <CALvZod6mO0-nK+aVP+-neFt3B95ztNGQMXLYFZ7oEeasTsXRCA@mail.gmail.com>
Subject: Re: [PATCH] mm, oom: fix oom_unkillable_task for memcg OOMs
To:     Michal Hocko <mhocko@kernel.org>
Cc:     Johannes Weiner <hannes@cmpxchg.org>,
        Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
        Andrew Morton <akpm@linux-foundation.org>,
        Roman Gushchin <guro@fb.com>, Linux MM <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 17, 2019 at 9:17 AM Michal Hocko <mhocko@kernel.org> wrote:
>
> On Mon 17-06-19 08:59:54, Shakeel Butt wrote:
> > Currently oom_unkillable_task() checks mems_allowed even for memcg OOMs
> > which does not make sense as memcg OOMs can not be triggered due to
> > numa constraints. Fixing that.
> >
> > Also if memcg is given, oom_unkillable_task() will check the task's
> > memcg membership as well to detect oom killability. However all the
> > memcg related code paths leading to oom_unkillable_task(), other than
> > dump_tasks(), come through mem_cgroup_scan_tasks() which traverses
> > tasks through memcgs. Once dump_tasks() is converted to use
> > mem_cgroup_scan_tasks(), there is no need to do memcg membership check
> > in oom_unkillable_task().
>
> I think this patch just does too much in one go. Could you split out
> the dump_tasks part and the oom_unkillable_task parts into two patches
> please? It should be slightly easier to review.
>

Yes, will do in v2.

> [...]
> > +static bool oom_unkillable_task(struct task_struct *p, struct oom_control *oc)
> >  {
> >       if (is_global_init(p))
> >               return true;
> >       if (p->flags & PF_KTHREAD)
> >               return true;
> > +     if (!oc)
> > +             return false;
>
> Bah, this is just too ugly. AFAICS this is only because oom_score still
> uses oom_unkillable_task which is kinda dubious, no? While you are
> touching this code, can we remove this part as well? I would be really
> surprised if any code really depends on ineligible tasks reporting 0
> oom_score.

I think it is safer to just localize the is_global_init() and
PF_KTHREAD checks in oom_badness() instead of invoking
oom_unkillable_task(). Also I think cpuset_mems_allowed_intersects()
check from /proc/[pid]/oom_score is unintentional.

Shakeel
