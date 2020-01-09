Return-Path: <SRS0=a4+J=26=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A45AAC33C9E
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Jan 2020 00:55:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 756F52067D
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Jan 2020 00:55:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1578531358;
	bh=w9USJk+7Qk5Du2zdTArHSElniMN2WqgEdkR2rhkBSY8=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=iAhCOCeHEPA3wW0T6kY2VcVvxkds9tfx+PMMKVScgBB3BGwcIIqAq2DSNgSynNokq
	 p873XtDHi83XbILMwOMnEMsssqRO/V7hFmjRBBZtcZV0CgtaDyuprxkbi7AopnT2Cr
	 8v4QVwfEUsLAauzhx/AKGOJJMhOjVMq0EClINLIk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727654AbgAIAz5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 Jan 2020 19:55:57 -0500
Received: from mail-wm1-f65.google.com ([209.85.128.65]:37561 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726654AbgAIAz5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Jan 2020 19:55:57 -0500
Received: by mail-wm1-f65.google.com with SMTP id f129so949476wmf.2;
        Wed, 08 Jan 2020 16:55:55 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=vwmPUpdkmkbY45E77W6s4PYrOpulotGxAFwkwIHXaXE=;
        b=sQlT5/koy4u2v2bd8kmJ3FLjQfE7BPAJIp/Ww8hJG6Z7QfYk8Gf+bVWIxK8LblWXjA
         jLBCWGiOiNKfC+n4ihUNzq8Y9Nz+m1Ka1Ra3E6LQKbr4cgPG2oqBk4RM14mKMZ+ge+UT
         FOqjlBUFRmbvDhu5+bAdXevBbmkjz4y3pBGCtHXkR3r4a018RvAejcJGUa5/C3TKI18x
         iBEUfEkyC3UNB/v4YDXUcOJwAJ246Bb/0edtZKLO0BL0MyHQkl4YfnBW11q8kNP9r0jV
         3tBpBfymmZlhAMA/aYqGzg/rrI+SrpI7ZUMlPN3z/Dq7lhkpoR3nmAUOZcHtSekve8lg
         Pcvg==
X-Gm-Message-State: APjAAAUEVGv6mVMqbrfgHG8KEr48mMR0j1s3hMGNnSp+xc8Dq0hjKQwN
        VTSry4M49mecKQBC+X62pzEo7UIPTeaZFUpD7aQ=
X-Google-Smtp-Source: APXvYqxVzTs3QW/mlRe9LXP6BOGJ4u2UbulF62s04l7mN2PMMvA1ytPlfXe0r5tvxv6MHPG46pGPVJwG5ro16QApBww=
X-Received: by 2002:a7b:c389:: with SMTP id s9mr1403894wmj.7.1578531355113;
 Wed, 08 Jan 2020 16:55:55 -0800 (PST)
MIME-Version: 1.0
References: <20200107133501.327117-1-namhyung@kernel.org> <20200107133501.327117-5-namhyung@kernel.org>
 <20200108220103.GB12995@krava>
In-Reply-To: <20200108220103.GB12995@krava>
From:   Namhyung Kim <namhyung@kernel.org>
Date:   Thu, 9 Jan 2020 09:55:44 +0900
Message-ID: <CAM9d7cjwGB766NU75SCQnrHamMkCxz5nkgM_H8L-tysxVXaHJg@mail.gmail.com>
Subject: Re: [PATCH 4/9] perf tools: Maintain cgroup hierarchy
To:     Jiri Olsa <jolsa@redhat.com>
Cc:     Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Stephane Eranian <eranian@google.com>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-perf-users <linux-perf-users@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 9, 2020 at 7:01 AM Jiri Olsa <jolsa@redhat.com> wrote:
>
> On Tue, Jan 07, 2020 at 10:34:56PM +0900, Namhyung Kim wrote:
>
> SNIP
>
> > +     while (*p != NULL) {
> > +             parent = *p;
> > +             cgrp = rb_entry(parent, struct cgroup, node);
> > +
> > +             if (cgrp->id == id)
> > +                     return cgrp;
> > +
> > +             if (cgrp->id < id)
> > +                     p = &(*p)->rb_left;
> > +             else
> > +                     p = &(*p)->rb_right;
> > +     }
> > +
> > +     cgrp = malloc(sizeof(*cgrp));
> > +     if (cgrp == NULL)
> > +             return NULL;
> > +
> > +     cgrp->name = strdup(path);
> > +     if (cgrp->name == NULL) {
> > +             free(cgrp);
> > +             return NULL;
> > +     }
> > +
> > +     cgrp->fd = -1;
> > +     cgrp->id = id;
> > +     refcount_set(&cgrp->refcnt, 1);
> > +
> > +     rb_link_node(&cgrp->node, parent, p);
> > +     rb_insert_color(&cgrp->node, &cgroup_tree);
> > +
> > +     return cgrp;
> > +}
> > +
> > +struct cgroup *cgroup__find_by_path(const char *path)
> > +{
> > +     struct rb_node *node;
> > +
> > +     node = rb_first(&cgroup_tree);
> > +     while (node) {
> > +             struct cgroup *cgrp = rb_entry(node, struct cgroup, node);
> > +
> > +             if (!strcmp(cgrp->name, path))
> > +                     return cgrp;
>
> you have it sorted on ids, but only search by path,
> why don't we sort it on path right away?

No, actually it only used cgroup__findnew() not __find_by_path().
I don't remember why I added this - will remove..

Thanks
Namhyung
