Return-Path: <SRS0=AMXA=TQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F09DC04AB4
	for <linux-kernel@archiver.kernel.org>; Thu, 16 May 2019 14:43:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3BAA320815
	for <linux-kernel@archiver.kernel.org>; Thu, 16 May 2019 14:43:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727495AbfEPOn2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 May 2019 10:43:28 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:35255 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727401AbfEPOn1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 May 2019 10:43:27 -0400
Received: by mail-wr1-f65.google.com with SMTP id m3so3551903wrv.2
        for <linux-kernel@vger.kernel.org>; Thu, 16 May 2019 07:43:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=Cj+rXNfNlUN3r4Yp7FC3w8W2jv87lre7M4pXy1RJygg=;
        b=S6+iqijnJucwreWKxlpYkRrSVGQK1pNor13wssFA/H0y8dBClJmFrCrVxTeUYizJrD
         OoejWbW5q/7zNxWTwDVghddMUrDAq7vrw6DwEPXUF5vtSVE7dF9iZrAtE+oiVO76c4I8
         UUB+BHAVuPtK/YQWdcYEc/RrJ1byYPUrt3mIE2yNiaK2nSvMSoZMWy6/S/OoPm3QYNMF
         +6ZkJlZE3JDU2zmNSDKoWRW+w/rTDxBU05354TVJmAnR6dax5apuM/E7/aP4tJA7uvjV
         2swpOL3vmwzk0e2EyPA4/uFaIV4Hx5Q54Q9XKKJ3/DETbN1biKHDw/WC3VNGuIAzedIO
         LRQw==
X-Gm-Message-State: APjAAAX13thBNkfsBkJFhZGCVy/zynQGwmb+gXQ5UC0ZwTqnN9ZrK0Tr
        j9beSdA1vPFVO9g6TpORZ/cX0w==
X-Google-Smtp-Source: APXvYqzKDhdhn0sTfAQMEnf2Z3MPEpDPMQ1RAoC5i7RhAcgllW8ck8oD5TGkmgzragiiRcn+PESIqQ==
X-Received: by 2002:a5d:4206:: with SMTP id n6mr17691401wrq.58.1558017806003;
        Thu, 16 May 2019 07:43:26 -0700 (PDT)
Received: from localhost (nat-pool-brq-t.redhat.com. [213.175.37.10])
        by smtp.gmail.com with ESMTPSA id q13sm6113444wrn.27.2019.05.16.07.43.24
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 16 May 2019 07:43:25 -0700 (PDT)
Date:   Thu, 16 May 2019 16:43:24 +0200
From:   Oleksandr Natalenko <oleksandr@redhat.com>
To:     Jann Horn <jannh@google.com>
Cc:     kernel list <linux-kernel@vger.kernel.org>,
        Kirill Tkhai <ktkhai@virtuozzo.com>,
        Hugh Dickins <hughd@google.com>,
        Alexey Dobriyan <adobriyan@gmail.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Michal Hocko <mhocko@suse.com>,
        Matthew Wilcox <willy@infradead.org>,
        Pavel Tatashin <pasha.tatashin@soleen.com>,
        Greg KH <greg@kroah.com>,
        Suren Baghdasaryan <surenb@google.com>,
        Minchan Kim <minchan@kernel.org>,
        Timofey Titovets <nefelim4ag@gmail.com>,
        Aaron Tomlin <atomlin@redhat.com>,
        Grzegorz Halat <ghalat@redhat.com>,
        Linux-MM <linux-mm@kvack.org>,
        Linux API <linux-api@vger.kernel.org>
Subject: Re: [PATCH RFC 4/5] mm/ksm, proc: introduce remote merge
Message-ID: <20190516144323.pzkvs6hapf3czorz@butterfly.localdomain>
References: <20190516094234.9116-1-oleksandr@redhat.com>
 <20190516094234.9116-5-oleksandr@redhat.com>
 <CAG48ez2yXw_PJXO-mS=Qw5rkLpG6zDPd0saMhhGk09-du2bpaA@mail.gmail.com>
 <20190516142013.sf2vitmksvbkb33f@butterfly.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190516142013.sf2vitmksvbkb33f@butterfly.localdomain>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 16, 2019 at 04:20:13PM +0200, Oleksandr Natalenko wrote:
> > [...]
> > > @@ -2960,15 +2962,63 @@ static int proc_stack_depth(struct seq_file *m, struct pid_namespace *ns,
> > >  static ssize_t madvise_write(struct file *file, const char __user *buf,
> > >                 size_t count, loff_t *ppos)
> > >  {
> > > +       /* For now, only KSM hints are implemented */
> > > +#ifdef CONFIG_KSM
> > > +       char buffer[PROC_NUMBUF];
> > > +       int behaviour;
> > >         struct task_struct *task;
> > > +       struct mm_struct *mm;
> > > +       int err = 0;
> > > +       struct vm_area_struct *vma;
> > > +
> > > +       memset(buffer, 0, sizeof(buffer));
> > > +       if (count > sizeof(buffer) - 1)
> > > +               count = sizeof(buffer) - 1;
> > > +       if (copy_from_user(buffer, buf, count))
> > > +               return -EFAULT;
> > > +
> > > +       if (!memcmp("merge", buffer, min(sizeof("merge")-1, count)))
> > 
> > This means that you also match on something like "mergeblah". Just use strcmp().
> 
> I agree. Just to make it more interesting I must say that
> 
>    /sys/kernel/mm/transparent_hugepage/enabled
> 
> uses memcmp in the very same way, and thus echoing "alwaysssss" or
> "madviseeee" works perfectly there, and it was like that from the very
> beginning, it seems. Should we fix it, or it became (zomg) a public API?

Actually, maybe, the reason for using memcmp is to handle "echo"
properly: by default it puts a newline character at the end, so if we use
just strcmp, echo should be called with -n, otherwise strcmp won't match
the string.

Huh?

> [...]

-- 
  Best regards,
    Oleksandr Natalenko (post-factum)
    Senior Software Maintenance Engineer
