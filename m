Return-Path: <SRS0=/WLL=WS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D1C6C3A5A1
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Aug 2019 14:55:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E2A1F233A2
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Aug 2019 14:55:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=arista.com header.i=@arista.com header.b="FYT0lQV4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388773AbfHVOzx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 22 Aug 2019 10:55:53 -0400
Received: from mail-io1-f66.google.com ([209.85.166.66]:43059 "EHLO
        mail-io1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732015AbfHVOzw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Aug 2019 10:55:52 -0400
Received: by mail-io1-f66.google.com with SMTP id 18so12370994ioe.10
        for <linux-kernel@vger.kernel.org>; Thu, 22 Aug 2019 07:55:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=arista.com; s=googlenew;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Q0wZh/4eoEqPIOzqTZqYPWLyH+hmBcAleu6hn0qpR1E=;
        b=FYT0lQV4jyIvhIYQEmusX9xZ6+PljzPQLO5A6kRdIxSmSntvCyp+oIozq0QbcobPm0
         U+n09xGdumBz3idw8/NbVLvhZima8AHwuZyYxthJPW7w33MQAB++LXepHo5AJv0mRYjg
         VMzOsk6/yhFIgLaavspEQnZNQzeZfkKGf5RDH2DTgt7p2Ojpt4kxjzwv6GrNdd8YnDmy
         b8sy1sReUILgJvjsNVSWDrN1a/eKfy0O6tT69sflIow4VUzC+hFCCg6d/Y3LnF6VFxgo
         /vDvOVQkvoTYJZMEmtqI/YYwZ8j6S9Ig2VJiNr1kV1FwQlK1eMw5w5yc5NTQEeugzctm
         jfYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Q0wZh/4eoEqPIOzqTZqYPWLyH+hmBcAleu6hn0qpR1E=;
        b=QvXiO517OP/8JJNupcbOXPHayGpa1LVfqIqlSRgqvKGUWglxFl8IOXy+4TCiP6yCoE
         zCENx9OzjeUGAplwDfiGlv2u1hLW7bSDLh4/VTiN3cZ2riSINS8qZ8BTxV/9ZuMtJb+X
         nUJJsWlD2xN4pGDDbp7TsE01UKkbZFqMTDboM297uo2EKMU5AlH9gOeX9n9OcyFadYGA
         PuiM17X8XVfEfUMVMY/Hx1SBlmmDVwzIVs5xwkLVOw1BGs7pXq4S6wuvTGlR4zyDTnAz
         GP7shsneST0+hwpP9jxjnTcGDZBYMkJCDsZXE81w+G/3m3yCw4fqaDC2FCT8Zq5tZ9zg
         v+uQ==
X-Gm-Message-State: APjAAAWxC05dAUOP+NzjXwxBSAntBpWXcj9y4qNAk7RSpXIZEwzIU6lB
        Ru5hLvjcLK/mQBzuAxFq2pWw8GgMd3pvdRyB2gEkTw==
X-Google-Smtp-Source: APXvYqy5AZAJmwouZteRGWOXLWbdOyLehNERePxTeUACR/e5Q5nCRTooG/TRmy2DbZbovwqmENfGImoE8GJYUGNCEsE=
X-Received: by 2002:a5e:8e0d:: with SMTP id a13mr122437ion.28.1566485751848;
 Thu, 22 Aug 2019 07:55:51 -0700 (PDT)
MIME-Version: 1.0
References: <20190821001445.32114-1-echron@arista.com> <alpine.DEB.2.21.1908202024300.141379@chino.kir.corp.google.com>
 <20190821064732.GW3111@dhcp22.suse.cz> <alpine.DEB.2.21.1908210017320.177871@chino.kir.corp.google.com>
 <20190821074721.GY3111@dhcp22.suse.cz> <CAM3twVR5Z1LG4+pqMF94mCw8R0sJ3VJtnggQnu+047c7jxJVug@mail.gmail.com>
 <20190822072134.GD12785@dhcp22.suse.cz>
In-Reply-To: <20190822072134.GD12785@dhcp22.suse.cz>
From:   Edward Chron <echron@arista.com>
Date:   Thu, 22 Aug 2019 07:55:40 -0700
Message-ID: <CAM3twVQuMU+T+GveqyMuyedcOC+NGrb7QNJCsHXRk3eVCfNG0w@mail.gmail.com>
Subject: Re: [PATCH] mm/oom: Add oom_score_adj value to oom Killed process message
To:     Michal Hocko <mhocko@kernel.org>
Cc:     David Rientjes <rientjes@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Roman Gushchin <guro@fb.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
        Shakeel Butt <shakeelb@google.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Ivan Delalande <colona@arista.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 22, 2019 at 12:21 AM Michal Hocko <mhocko@kernel.org> wrote:
>
> On Wed 21-08-19 16:12:08, Edward Chron wrote:
> [...]
> > Additionally (which you know, but mentioning for reference) the OOM
> > output used to look like this:
> >
> > Nov 14 15:23:48 oldserver kernel: [337631.991218] Out of memory: Kill
> > process 19961 (python) score 17 or sacrifice child
> > Nov 14 15:23:48 oldserver kernel: [337631.991237] Killed process 31357
> > (sh) total-vm:5400kB, anon-rss:252kB, file-rss:4kB, shmem-rss:0kB
> >
> > It now looks like this with 5.3.0-rc5 (minus the oom_score_adj):
> >
> > Jul 22 10:42:40 newserver kernel:
> > oom-kill:constraint=CONSTRAINT_NONE,nodemask=(null),cpuset=/,mems_allowed=0,global_oom,task_memcg=/user.slice/user-10383.slice/user@10383.service,task=oomprocs,pid=3035,uid=10383
> > Jul 22 10:42:40 newserver kernel: Out of memory: Killed process 3035
> > (oomprocs) total-vm:1056800kB, anon-rss:8kB, file-rss:4kB,
> > shmem-rss:0kB
> > Jul 22 10:42:40 newserver kernel: oom_reaper: reaped process 3035
> > (oomprocs), now anon-rss:0kB, file-rss:0kB, shmem-rss:0kB
> >
> > The old output did explain that a oom_score of 17 must have either
> > tied for highest or was the highest.
> > This did document why OOM selected the process it did, even if ends up
> > killing the related sh process.
> >
> > With the newer format that added constraint message, it does provide
> > uid which can be helpful and
> > the oom_reaper showing that the memory was reclaimed is certainly reassuring.
> >
> > My understanding now is that printing the oom_score is discouraged.
> > This seems unfortunate.  The oom_score_adj can be adjusted
> > appropriately if oom_score is known.
> > So It would be useful to have both.
>
> As already mentioned in our previous discussion I am really not happy
> about exporting oom_score withtout a larger context - aka other tasks
> scores to have something to compare against. Other than that the value
> is an internal implementation detail and it is meaningless without
> knowing the exact algorithm which can change at any times so no
> userspace should really depend on it. All important metrics should be
> displayed by the oom report message already.

The oom_score is no longer displayed any where in the OOM output with 5.3
so there isn't anything to compare against any way with the current OOM
per process output and for the killed process.

I understand the reasoning for this from your discussion.
Thanks for explaining the rational.

>
> --
> Michal Hocko
> SUSE Labs
