Return-Path: <SRS0=EIds=SH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2C1F7C4360F
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Apr 2019 15:21:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 069C12175B
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Apr 2019 15:21:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731453AbfDEPVQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 5 Apr 2019 11:21:16 -0400
Received: from mail-it1-f195.google.com ([209.85.166.195]:38873 "EHLO
        mail-it1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726291AbfDEPVQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Apr 2019 11:21:16 -0400
Received: by mail-it1-f195.google.com with SMTP id f22so10125793ita.3
        for <linux-kernel@vger.kernel.org>; Fri, 05 Apr 2019 08:21:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=uh0ShQqIbBMkLRYP0daxYFjdegJIus2IHRa2hCK0ZgY=;
        b=oL5oIVZkquwRNJDae1r8YPeVxWMIrOPhdjqjxIDP6p75jaKNdFfYxDJQSX7CFtdfet
         sASJ1AcKN5tyaGSDnfYZDNKeH9l6FZ3vr3GerHJC7TNeCaINPpqlFvzQrhq3N7kKJW4i
         Ii3pjAPp5Cnwe9RaQH7qinVzwKgQXv6FyOMJAC3pm5R0sqPA3wJmGm6w7G3UTR4myoLs
         /0TWDSNVzYxS0pVVESBbxI7EiPN51pMBFf61CLSsaX3hFmH5Hn+k6r05eLr8bGTUGG+d
         1xzaQbEY9vvKc1JuUmI6XgtJq3u77wHA9mcXLe6WuxRlYg7WVbv5kB+f9xQDy0M433R9
         nAvw==
X-Gm-Message-State: APjAAAWwqtjOv/o5EkMtqozYf2c0iB99vdI9vfJB3/JxwoHJnjtN+M19
        DagkaenVHcx3PTSOVnmDUoSg0e5CPgNYVzXBWYeodw==
X-Google-Smtp-Source: APXvYqzUMicJkVoctqrHq8H0L7Pl8bcYyYlWzQd4WmWJ/kpbfIOot7Gj6RArCsenAjEV1mJ/Z/OHrdv+wsuFw8tKWZk=
X-Received: by 2002:a02:6951:: with SMTP id e78mr4087132jac.132.1554477675541;
 Fri, 05 Apr 2019 08:21:15 -0700 (PDT)
MIME-Version: 1.0
References: <20190404172545.20928-1-kasong@redhat.com> <20190405071704.GC4038@hirez.programming.kicks-ass.net>
In-Reply-To: <20190405071704.GC4038@hirez.programming.kicks-ass.net>
From:   Kairui Song <kasong@redhat.com>
Date:   Fri, 5 Apr 2019 23:21:03 +0800
Message-ID: <CACPcB9eV37uuXyKw6KrJhpZM6j4OtjrW1JUixpaS=KpvG41NYQ@mail.gmail.com>
Subject: Re: [RFC PATCH] perf/x86: make perf callchain work without CONFIG_FRAME_POINTER
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>, Dave Young <dyoung@redhat.com>,
        Josh Poimboeuf <jpoimboe@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 5, 2019 at 3:17 PM Peter Zijlstra <peterz@infradead.org> wrote:
>
> And you forgot to Cc Josh..
>

Hi, thanks for the reply and Cc more people, I just copies the list
from ./scripts/get_maintainer.pl, will pay more attention next time.

> >
> > Just found with ORC unwinder the perf callchain is unusable, and this
> > seems fixes it well, any suggestion is welcome, thanks!
>
> That whole .direct stuff is horrible crap.
>

Sorry if I did anything dumb, but I didn't find a better way to make
it work so sent this RFC... Would you mind tell me what I'm doing
wrong, or give any suggestion about how should I improve it?

--
Best Regards,
Kairui Song
