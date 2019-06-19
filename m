Return-Path: <SRS0=wAGj=US=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3796DC31E49
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Jun 2019 10:33:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F2EE221479
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Jun 2019 10:33:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="p0Sz0EF5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731564AbfFSKd0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Jun 2019 06:33:26 -0400
Received: from mail-qt1-f196.google.com ([209.85.160.196]:41114 "EHLO
        mail-qt1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727129AbfFSKdZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Jun 2019 06:33:25 -0400
Received: by mail-qt1-f196.google.com with SMTP id d17so14229101qtj.8
        for <linux-kernel@vger.kernel.org>; Wed, 19 Jun 2019 03:33:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=A5r+fNs6piiH+aGROj+Wzs8FJ/AgXElJ3JaEl+QTwIo=;
        b=p0Sz0EF57FLawqG1VabOdKC+Bzkx1UdG2TqBFuTGofHL6o9iG0MRLdNfctgnNozh2f
         6F8Mh9THCLq2XpLwTG7HOAWojfnYHMZN+2/aDw5bnfkdIYYrFBfaz9aLdcjqWmSfu8ZE
         VlQbGTn3du33tcn4jSQVpNBG+tHNQ5Bhoi156ScFhodZXXbrqwCrcAH3v1e3JUdcn9XX
         U7CGA6FdOtRrPimU4yrSNENfugRzIwMbgpGbn/TNF/NZLkviGFU2QXWBNV5e/Sa9CIJ4
         QuxvwO4lDynAaiy9HaOwaLl3ut7ueE36ejJI53EkALbw+xzhHFg20VPeoriGxgaYIp2Y
         Xctw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=A5r+fNs6piiH+aGROj+Wzs8FJ/AgXElJ3JaEl+QTwIo=;
        b=LA4e5HGMumnOxEVjh0TOONSgjylWNkFfVZu7exqyxs80/IXfIxgzCaXwg6wGAkzK48
         WQlbAprpZvXaw61xY2uP6r7or/R6U59uzZD0sYRPzjYbvKSKI29acH9F/00Qqdlxq4Du
         9RZlDnB7zBVFk5T+Zg8oxu9VShF9UJeHasuQGwTngwM4pJg2Z+yyxSlnPBqJwEz8bqw/
         Z7PodjZie+nsGT7jAXZbAME4xXAUm8Ix8oguFMmX9j8joGgxOMgS4oWNNnnNA3tI746u
         UES9d3kB0XuP1NVPZrnR8caa1HV4zPqdu/kz10WpMsrakjgekPbsE3JkNvjg8HQQ3mzX
         r4FA==
X-Gm-Message-State: APjAAAX5LA1jYpu9cGspZMmkMBaZhXgVIGo0A+lnmUSlqDN5NRaF+6Uu
        XmVEqjY407eP+JBaRhKCUGlk2nDxDz6nkvW5x+ts8A==
X-Google-Smtp-Source: APXvYqzsT65B1Q6a584qTVdugWKlIu1yIZmyVh6lrG95htoJMyCqQWISMHXkLYv5iX+GmxabuYhjkdpTL/3YmtcKZeU=
X-Received: by 2002:a0c:b999:: with SMTP id v25mr20736885qvf.36.1560940404444;
 Wed, 19 Jun 2019 03:33:24 -0700 (PDT)
MIME-Version: 1.0
References: <CANA+-vCThdRivg7nrMK5QoFu8SGUzEVSvSyp0H2CPyy9==Tqog@mail.gmail.com>
 <CANA+-vARQ9Ao=W1oEArrAQ0sqh757orq=-=kytdVPhstm-3E9w@mail.gmail.com>
 <20190618182502.GC203031@google.com> <4587569.x9DSL43cXO@kreacher>
 <CANA+-vCMK6u1n9gXf2+v5dFn_tGfr1PT8d7W4d2BCzw+B-HvYw@mail.gmail.com>
 <CAJWu+oo7kwmEyMXQN0yfswV2=J-Fa9QybhAUx-SOGG_ipsBErQ@mail.gmail.com> <CAJZ5v0gvzCx-7qS9qkxB=sGKjQJKMR7yCc21f=_vqrbZxMSWNg@mail.gmail.com>
In-Reply-To: <CAJZ5v0gvzCx-7qS9qkxB=sGKjQJKMR7yCc21f=_vqrbZxMSWNg@mail.gmail.com>
From:   Joel Fernandes <joelaf@google.com>
Date:   Wed, 19 Jun 2019 06:33:12 -0400
Message-ID: <CAJWu+orvX7fVGPL1J4mg1s8R0q36O4kdxDuscL5Y+M8wkFJ0Tw@mail.gmail.com>
Subject: Re: Alternatives to /sys/kernel/debug/wakeup_sources
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     Tri Vo <trong@android.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Sandeep Patil <sspatil@android.com>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Hridya Valsaraju <hridya@google.com>,
        Linux PM <linux-pm@vger.kernel.org>,
        "Cc: Android Kernel" <kernel-team@android.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 19, 2019 at 4:35 AM Rafael J. Wysocki <rafael@kernel.org> wrote:
>
> On Wed, Jun 19, 2019 at 1:52 AM Joel Fernandes <joelaf@google.com> wrote:
> >
> > On Tue, Jun 18, 2019 at 7:15 PM Tri Vo <trong@android.com> wrote:
> > [snip]
> > > > > > >
> > > > > > > Android userspace reading wakeup_sources is not ideal because:
> > > > > > > - Debugfs API is not stable, i.e. Android tools built on top of it are
> > > > > > > not guaranteed to be backward/forward compatible.
> > > > > > > - This file requires debugfs to be mounted, which itself is
> > > > > > > undesirable for security reasons.
> > > > > > >
> > > > > > > To address these problems, we want to contribute a way to expose these
> > > > > > > statistics that doesn't depend on debugfs.
> > > > > > >
> > > > > > > Some initial thoughts/questions: Should we expose the stats in sysfs?
> > > > > > > Or maybe implement eBPF-based solution? What do you think?
> > > > >
> > > > > We are going through Android's out-of-tree kernel dependencies along with
> > > > > userspace APIs that are not necessarily considered "stable and forever
> > > > > supported" upstream. The debugfs dependencies showed up on our radar as a
> > > > > result and so we are wondering if we should worry about changes in debugfs
> > > > > interface and hence the question(s) below.
> > > > >
> > > > > So, can we rely on /d/wakeup_sources to be considered a userspace API and
> > > > > hence maintained stable as we do for other /proc and /sys entries?
> > > > >
> > > > > If yes, then we will go ahead and add tests for this in LTP or
> > > > > somewhere else suitable.
> > > >
> > > > No, debugfs is not ABI.
> > > >
> > > > > If no, then we would love to hear suggestions for any changes that need to be
> > > > > made or we simply just move the debugfs entry into somewhere like
> > > > > /sys/power/ ?
> > > >
> > > > No, moving that entire file from debugfs into sysfs is not an option either.
> > > >
> > > > The statistics for the wakeup sources associated with devices are already there
> > > > under /sys/devices/.../power/ , but I guess you want all wakeup sources?
> > > >
> > > > That would require adding a kobject to struct wakeup_source and exposing
> > > > all of the statistics as separate attributes under it.  In which case it would be
> > > > good to replace the existing wakeup statistics under /sys/devices/.../power/
> > > > with symbolic links to the attributes under the wakeup_source kobject.
> > >
> > > Thanks for your input, Rafael! Your suggestion makes sense. I'll work
> > > on a patch for this.
> >
> > Does that entail making each wake up source, a new sysfs node under a
> > particular device, and then adding stats under that new node?
>
> Not under a device, because there are wakeup source objects without
> associated devices.
>
> It is conceivable to have a "wakeup_sources" directory under
> /sys/power/ and sysfs nodes for all wakeup sources in there.
>
> Then, instead of exposing wakeup statistics directly under
> /sys/devices/.../power/, there can be symbolic links from there to the
> new wakeup source nodes under "wakeup_sources" (so as to avoid
> exposing the same data in two different places in sysfs, which may be
> confusing).

Makes sense to me, thanks!

 - Joel
