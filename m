Return-Path: <SRS0=a4+J=26=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A3C0EC282DD
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Jan 2020 15:13:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 76469206ED
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Jan 2020 15:13:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="FumRKMU0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730911AbgAIPM7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 Jan 2020 10:12:59 -0500
Received: from mail-oi1-f194.google.com ([209.85.167.194]:45926 "EHLO
        mail-oi1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730812AbgAIPM7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Jan 2020 10:12:59 -0500
Received: by mail-oi1-f194.google.com with SMTP id n16so6078018oie.12
        for <linux-kernel@vger.kernel.org>; Thu, 09 Jan 2020 07:12:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=vbqpZrIDLpDQLH9KUn0l1vMdgrmF9gTvIFjb1L/duXc=;
        b=FumRKMU0RlSPUHrew9kPUV4LHUhfpAsw8FDUVYsyRhgXL8EFZJGgko3coO8RLYG9nZ
         NDmaf3z+oLebNfRrWyafrPH3vZn7lAj0cdTMW4anTa3/DAXSwktL+zxA8ITABoOlQ858
         QfNAeWgiyuoahLzgWFK7EK72hxK44bBOW8fhlk6rJWnzh3SUZN0q+9pP+m8zrPXGYq/U
         iBzzSSxVIDQgthrPQgZ/+dm8r/77aPcGsupZwYcyLfNkOb17KxRhsEg6upleFpRafcGD
         8aEEaHwUKfxl3D0qiE7d6Kc+51Jv87amj2UFGfa7cm0o4gM5uH8Bv/XSOBi331aEvy/s
         fmfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=vbqpZrIDLpDQLH9KUn0l1vMdgrmF9gTvIFjb1L/duXc=;
        b=G8Nn3h3/MWAcD7TZ/jyP4DA2g9ZmPhpzVNepMIXfbTOHieuGFYGj5BcFIG7bA4UekJ
         BVEZNjjwuTZJn4JhEL2b+5CNbcoJcLu7+9Xw61Iv2bzh168pvA8NHuqYWQ23bszcSRnZ
         HWfv5Idz1vnxy9SBCUmIFvEb9pZRNY8z40AkcD/59itvkbOxuQw5jnHUQ76ax5VKvgeR
         PrLLQ9vDe5uVzfsikicB7VokqZE9gOL0tUrsxXkRBYme3XuGrURSLF7cbzMcLWddTd7K
         UMIRbzVwT5/eIAahHXhDXcXS6D481QMlvEbf8oLwa2nPK7Ou3q2KGvqklG4Z1BMWfUd4
         3lnw==
X-Gm-Message-State: APjAAAUEhWPDnjLau7GVm95pMX/D9XZxgX0BW1T8Wc4ziJBh6veV5lU+
        vvnIl4+Adv7dltebHyEjwY+cdq+D/JsOr3Ky6td7fA==
X-Google-Smtp-Source: APXvYqxiY3rySMQtSFIOjSYkHFjQCfCCLQdprTUhbnhtyefAvZaXnm8HWD7dj3MA3hZnzHZ4C/OYID58g5hGQLMoio4=
X-Received: by 2002:aca:4a08:: with SMTP id x8mr3559134oia.39.1578582778388;
 Thu, 09 Jan 2020 07:12:58 -0800 (PST)
MIME-Version: 1.0
References: <CAG48ez0eULP6pH26H9ac-YYa88_RSGt6v_hDhsrZ92iZoRdsoQ@mail.gmail.com>
 <20200109151059.GB8602@kernel.org>
In-Reply-To: <20200109151059.GB8602@kernel.org>
From:   Jann Horn <jannh@google.com>
Date:   Thu, 9 Jan 2020 16:12:30 +0100
Message-ID: <CAG48ez18J4m5_BppHLRidSYnLTt8K809Hqiv4bDiFz52u_=8hA@mail.gmail.com>
Subject: Re: "perf ftrace" segfault because ->cpus!=NULL but ->all_cpus==NULL
To:     Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>
Cc:     Andi Kleen <ak@linux.intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        kernel list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 9, 2020 at 4:11 PM Arnaldo Carvalho de Melo
<arnaldo.melo@gmail.com> wrote:
> Em Thu, Jan 09, 2020 at 12:37:14PM +0100, Jann Horn escreveu:
> > I was clumsily trying to use "perf ftrace" from git master (I might
> > very well be using it wrong), and it's falling over with a NULL deref.
> > I don't really understand the perf code, but it looks to me like it
> > might be related to Andi Kleen's refactoring that introduced
> > evlist->all_cpus?
>
> > I think the problem is that evlist_close() assumes that ->cpus!=NULL
> > implies ->all_cpus!=NULL, but perf_evlist__propagate_maps() doesn't
> > set ->all_cpus if the evlist is empty.
>
> > Here's the crash I encountered:
>
> I've reproduced it and Jiri provided a patch, I'll test it, meanwhile
> you could alternatively drop an 'f' and try 'perf trace' + 'perf probe'
> instead, perhaps that could be enough, some examples:
>
> [root@quaco ~]# perf probe kmem_cache_alloc
> Added new event:
>   probe:kmem_cache_alloc (on kmem_cache_alloc)
>
> You can now use it in all perf tools, such as:
>
>         perf record -e probe:kmem_cache_alloc -aR sleep 1

Ah, thanks for the help. :)
