Return-Path: <SRS0=h0iA=UR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0D0F4C31E5B
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Jun 2019 23:52:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D88E520873
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Jun 2019 23:52:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Hw8Wh065"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728884AbfFRXwg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Jun 2019 19:52:36 -0400
Received: from mail-qt1-f196.google.com ([209.85.160.196]:41689 "EHLO
        mail-qt1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725913AbfFRXwf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Jun 2019 19:52:35 -0400
Received: by mail-qt1-f196.google.com with SMTP id d17so12767447qtj.8
        for <linux-kernel@vger.kernel.org>; Tue, 18 Jun 2019 16:52:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=oxhoe6qvi5++Tcm34QYjpxvVrTyaf87PFGxTM5J5klQ=;
        b=Hw8Wh065g4/hqpkCuE2UUCCyaWWEgEqIivqSK4AXMEYZFcGFB/YyRBBxDQmwRa3/FK
         vzrp6nSLX89AZwg4NixpQRsHfSw4kAy/vNYqFDmj/46CvZOuY+rQNxJMLVTk76II5KMb
         7StzCUc0Gk3xcASZ7v+85xbg/AmlBLI9C+bi9ajiUUpI3fVcCrRZ6DwQvtYgeYUDlBPr
         MSxYwTNzR3toM7Ww6JZCAh3CEWSG/y24xkrmjRk/f2aEuYaDg2F2XgGUTFD6ZEvOjCM6
         ktrKNYaPkCfWbRCkJsQsHQE77KvMiB4JUel22BfKo02tDP2vLQW+VRL+Bw4EkzSCQLcQ
         WFbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=oxhoe6qvi5++Tcm34QYjpxvVrTyaf87PFGxTM5J5klQ=;
        b=HZMs7eiBWojm6tNjA30uerxeZC50eQMxJYonN2701Mehz6lpGD/IOXM+VdAE2tdDtJ
         ZXcuZvxaoYK2YbYCy3XpPfX1Z2GUBubis75dYdiG8ZOsHVGwCU9/s7etTgpNnT0VOzg8
         eWJ3sYIlzCRPVdvBWAv2OiQrvHPb5W3PbQwu9nwzd72MyBx1Mj11dhxHnYYCEqjp3z0S
         LS2clDjZl5boIr9I1ws1R0WVZSJSLpwjtpzCRXplnWDYUUW9Sgoe7VA7GCVI3leDpV+3
         O0o3y0KRt7od8tmhQ5pequvjIHEUSWVIcTcML8RE9O2unu5na8z60JwfAURuNUvMmfoS
         mHcA==
X-Gm-Message-State: APjAAAX4Z4rb18MjRpflJ2teW04cqUiLJqko7XMSs4/WFc1dygfr0yMY
        jhdV/ktuLETEIHkmu8PUFMNgySAZSMIel1YgPmd0mA==
X-Google-Smtp-Source: APXvYqwiv08J29plxlhYMIDWyxqgmuEcJ7gUaUt/etansUxZvljYL8gyykDyphwMNft4kHd5X4nMneBUhJsZemjwTmc=
X-Received: by 2002:a0c:96c4:: with SMTP id b4mr29430317qvd.2.1560901954609;
 Tue, 18 Jun 2019 16:52:34 -0700 (PDT)
MIME-Version: 1.0
References: <CANA+-vCThdRivg7nrMK5QoFu8SGUzEVSvSyp0H2CPyy9==Tqog@mail.gmail.com>
 <CANA+-vARQ9Ao=W1oEArrAQ0sqh757orq=-=kytdVPhstm-3E9w@mail.gmail.com>
 <20190618182502.GC203031@google.com> <4587569.x9DSL43cXO@kreacher> <CANA+-vCMK6u1n9gXf2+v5dFn_tGfr1PT8d7W4d2BCzw+B-HvYw@mail.gmail.com>
In-Reply-To: <CANA+-vCMK6u1n9gXf2+v5dFn_tGfr1PT8d7W4d2BCzw+B-HvYw@mail.gmail.com>
From:   Joel Fernandes <joelaf@google.com>
Date:   Tue, 18 Jun 2019 19:52:23 -0400
Message-ID: <CAJWu+oo7kwmEyMXQN0yfswV2=J-Fa9QybhAUx-SOGG_ipsBErQ@mail.gmail.com>
Subject: Re: Alternatives to /sys/kernel/debug/wakeup_sources
To:     Tri Vo <trong@android.com>
Cc:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
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

On Tue, Jun 18, 2019 at 7:15 PM Tri Vo <trong@android.com> wrote:
[snip]
> > > > >
> > > > > Android userspace reading wakeup_sources is not ideal because:
> > > > > - Debugfs API is not stable, i.e. Android tools built on top of it are
> > > > > not guaranteed to be backward/forward compatible.
> > > > > - This file requires debugfs to be mounted, which itself is
> > > > > undesirable for security reasons.
> > > > >
> > > > > To address these problems, we want to contribute a way to expose these
> > > > > statistics that doesn't depend on debugfs.
> > > > >
> > > > > Some initial thoughts/questions: Should we expose the stats in sysfs?
> > > > > Or maybe implement eBPF-based solution? What do you think?
> > >
> > > We are going through Android's out-of-tree kernel dependencies along with
> > > userspace APIs that are not necessarily considered "stable and forever
> > > supported" upstream. The debugfs dependencies showed up on our radar as a
> > > result and so we are wondering if we should worry about changes in debugfs
> > > interface and hence the question(s) below.
> > >
> > > So, can we rely on /d/wakeup_sources to be considered a userspace API and
> > > hence maintained stable as we do for other /proc and /sys entries?
> > >
> > > If yes, then we will go ahead and add tests for this in LTP or
> > > somewhere else suitable.
> >
> > No, debugfs is not ABI.
> >
> > > If no, then we would love to hear suggestions for any changes that need to be
> > > made or we simply just move the debugfs entry into somewhere like
> > > /sys/power/ ?
> >
> > No, moving that entire file from debugfs into sysfs is not an option either.
> >
> > The statistics for the wakeup sources associated with devices are already there
> > under /sys/devices/.../power/ , but I guess you want all wakeup sources?
> >
> > That would require adding a kobject to struct wakeup_source and exposing
> > all of the statistics as separate attributes under it.  In which case it would be
> > good to replace the existing wakeup statistics under /sys/devices/.../power/
> > with symbolic links to the attributes under the wakeup_source kobject.
>
> Thanks for your input, Rafael! Your suggestion makes sense. I'll work
> on a patch for this.

Does that entail making each wake up source, a new sysfs node under a
particular device, and then adding stats under that new node?

thanks,

- Joel
