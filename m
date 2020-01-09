Return-Path: <SRS0=a4+J=26=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0D042C32771
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Jan 2020 07:50:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CF3582067D
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Jan 2020 07:50:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1578556238;
	bh=8tLTGFgqi2zp8o8rppN3hWEs4301u5uyUfWJU5kJhK0=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=FGnUNh9WSRHw1SVuX5wiBlldDaxB5ePCRDW/UMNPqsW4b9fHqAu5+AkfMxh9zsZmB
	 FyIZHTulDNHIkoZVH1CZoXuAcXSYlbBw2K3TbmNhIDS1snV2gFaHE3FDgXwfNlgeLx
	 VAo7HC0qf2C4u6gG0ru7XPe4H+sD1JmthUAYPDi0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728300AbgAIHuh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 Jan 2020 02:50:37 -0500
Received: from mail-wr1-f65.google.com ([209.85.221.65]:41056 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728184AbgAIHuh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Jan 2020 02:50:37 -0500
Received: by mail-wr1-f65.google.com with SMTP id c9so6233620wrw.8;
        Wed, 08 Jan 2020 23:50:36 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=y/CgzWzQ37tz6tltWi+W06Hb1Am2E42UaSOhmv5oQbc=;
        b=rYRBnzoYA0Jz3uVmSmrR/8nf8n/2SjvICl6vmZn5K7qxwt3y/8QtPOP1Q+6/0PbJOE
         jrLZP1pLTQ8WCdNF2jnVVqkDCh3UrfhQB6zepFvkGgcCJNXKHLHBm/YdvngRtrwyw8gx
         OOctq/bu4O8JN6uaDLfSbt7d6OMsQGzAQ0acWTc6TMZR74N7pbhFQfqI5F/cc9qUkfrK
         5eqOq/82r07d6LYf5tT193ipRJH7n5Q7PXRmtYQhJPUWMYNbJzxapf/VOjLf8SUKjtm5
         CG8yUwvkKnixQJ9RuL2oNxeQYbl70jneDgVjbygwh/BEgVp1plZvSAQ7wqtD7IpWOMx1
         PeYA==
X-Gm-Message-State: APjAAAVODKZm8ooJmM2s2Y9VSiMnmi+vjyf8CpRy4EW5nHPUMD/jD5KA
        THFrX/K01h0F57kZnWDAjayO/CO7tzjzxFP+3M8=
X-Google-Smtp-Source: APXvYqxr2+R2knz2nRfCsd8oe+g8GuCoKuxDgCHRlje6jES4YFF4F6MRi+JCczDav5HaTPEcpwW1ZeTDyqZhAUb9MQY=
X-Received: by 2002:adf:eb48:: with SMTP id u8mr9003242wrn.283.1578556235658;
 Wed, 08 Jan 2020 23:50:35 -0800 (PST)
MIME-Version: 1.0
References: <20200107133501.327117-1-namhyung@kernel.org> <20200107133501.327117-7-namhyung@kernel.org>
 <20200108221833.GD12995@krava>
In-Reply-To: <20200108221833.GD12995@krava>
From:   Namhyung Kim <namhyung@kernel.org>
Date:   Thu, 9 Jan 2020 16:50:24 +0900
Message-ID: <CAM9d7ciqCi3Kh9n+Wsgpa6xmhfu0JcVLcT2+bmWVyo13bcDn1Q@mail.gmail.com>
Subject: Re: [PATCH 6/9] perf record: Support synthesizing cgroup events
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

On Thu, Jan 9, 2020 at 7:18 AM Jiri Olsa <jolsa@redhat.com> wrote:
>
> On Tue, Jan 07, 2020 at 10:34:58PM +0900, Namhyung Kim wrote:
>
> SNIP
>
> > +     if (perf_tool__process_synth_event(tool, event, machine, process) < 0) {
> > +             pr_debug("process synth event failed\n");
> > +             return -1;
> > +     }
> > +
> > +     return 0;
> > +}
> > +
> > +static int perf_event__walk_cgroup_tree(struct perf_tool *tool,
> > +                                     union perf_event *event,
> > +                                     char *path, size_t mount_len,
> > +                                     perf_event__handler_t process,
> > +                                     struct machine *machine)
> > +{
> > +     size_t pos = strlen(path);
> > +     DIR *d;
> > +     struct dirent *dent;
> > +     int ret = 0;
> > +
> > +     if (perf_event__synthesize_cgroup(tool, event, path, mount_len,
> > +                                       process, machine) < 0)
> > +             return -1;
> > +
> > +     d = opendir(path);
> > +     if (d == NULL) {
> > +             pr_debug("failed to open directory: %s\n", path);
> > +             return -1;
> > +     }
> > +
> > +     while ((dent = readdir(d)) != NULL) {
> > +             if (dent->d_type != DT_DIR)
> > +                     continue;
> > +             if (!strcmp(dent->d_name, ".") ||
> > +                 !strcmp(dent->d_name, ".."))
> > +                     continue;
> > +
> > +             if (path[pos - 1] != '/')
> > +                     strcat(path, "/");
> > +             strcat(path, dent->d_name);
>
> shouldn't you also check for the max size of path in here?

I guess a path should be shorter than PATH_MAX.
But yes, I can add a check if you want.

Thanks
Namhyung
