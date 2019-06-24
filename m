Return-Path: <SRS0=hO5d=UX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 50B46C48BE4
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Jun 2019 01:48:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1F9CD2063F
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Jun 2019 01:48:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=android.com header.i=@android.com header.b="aYkg+TE3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726536AbfFXBs4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 23 Jun 2019 21:48:56 -0400
Received: from mail-ot1-f66.google.com ([209.85.210.66]:33689 "EHLO
        mail-ot1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726323AbfFXBs4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 23 Jun 2019 21:48:56 -0400
Received: by mail-ot1-f66.google.com with SMTP id i4so12083012otk.0
        for <linux-kernel@vger.kernel.org>; Sun, 23 Jun 2019 18:48:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=android.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=KoQYiQrMBAoPwcouH5zLkPtiukwZNYdGgxBPjr/sF88=;
        b=aYkg+TE39brESepUpYvudC15qXREldRUSMU/512F+I3btn18W+Xyfqt6LgqaLTPCkh
         vCiVE2NlKC1hkzVZQPazcAnCKBWcQ56W8WagWpEk5ys8BlKUE8Tti5E4ZaCMNNgKYpGM
         MsJCrSidc4ZdUr0WbczMxSGC8q3qfuxN9gHvUsNU/IRlKcdg7NcG/cBP9kWp0ZZM4AQd
         4ix6Wuk06EKbD7SsXf7AWQrjeWS/JMdohdjDev0BJ5XI/c1gmGhRnKg2GmyCbWj0FLzb
         02XeKxEDDNRRW0+Xg44AIg6KcDbGzWU1YaXJnupcpQ18Kg5Ez8NhzflUYscbN98fUctm
         UGOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=KoQYiQrMBAoPwcouH5zLkPtiukwZNYdGgxBPjr/sF88=;
        b=DWo1L/7bB1RWyvHmsulLGh2jViQKn2GfUvohog01OZqQYMKlikyZlPY+dWm41V/rAQ
         k2O8zurj8sF49iC3mC4qOfrSgcHhcqyH60v0vWqc3OV9PMaTYp7jzYoZMqf9hoyEDQsb
         zva7nUBDKYOAM3zMcwt6mbyEAyqy/x8aXEBli8wzpy7QRy7ozOITdp7+DGJkjuzsW6ky
         tXAcR+YILFeOeSawiYNUp9J56wtwlVuCOGKFptVfH2KdqZZc1uPJ9hC1vTIzr2L/chWC
         viZ8r9peZ6c4/puLanvNs6ePckMtyqYhjSnkbaT0NBhuCUIA3Yc1SAlkrUmUkLzQNYJC
         N3XA==
X-Gm-Message-State: APjAAAWpndj2IgassgItqHTaJdelYuHO0vpJDd28AG7tl4/WTo71BIre
        sYY5Q9IreqXkaHINClUERgLcoXj4TsuCbX3dB9ZYrA==
X-Google-Smtp-Source: APXvYqyu3RIcWBRJLSScwP9CuXO3dOu2zHqFIr87b56yxDl/RFshM7fhRGX07M5Ok8/ypr/fYnAwbIpE31qvkI24V9g=
X-Received: by 2002:a9d:450a:: with SMTP id w10mr43913762ote.148.1561340935025;
 Sun, 23 Jun 2019 18:48:55 -0700 (PDT)
MIME-Version: 1.0
References: <CANA+-vCThdRivg7nrMK5QoFu8SGUzEVSvSyp0H2CPyy9==Tqog@mail.gmail.com>
 <CANA+-vARQ9Ao=W1oEArrAQ0sqh757orq=-=kytdVPhstm-3E9w@mail.gmail.com>
 <20190618182502.GC203031@google.com> <4587569.x9DSL43cXO@kreacher>
 <CANA+-vCMK6u1n9gXf2+v5dFn_tGfr1PT8d7W4d2BCzw+B-HvYw@mail.gmail.com>
 <CAJWu+oo7kwmEyMXQN0yfswV2=J-Fa9QybhAUx-SOGG_ipsBErQ@mail.gmail.com> <CAJZ5v0gvzCx-7qS9qkxB=sGKjQJKMR7yCc21f=_vqrbZxMSWNg@mail.gmail.com>
In-Reply-To: <CAJZ5v0gvzCx-7qS9qkxB=sGKjQJKMR7yCc21f=_vqrbZxMSWNg@mail.gmail.com>
From:   Tri Vo <trong@android.com>
Date:   Sun, 23 Jun 2019 18:48:43 -0700
Message-ID: <CANA+-vCBW=P=dpJGfcKTt7SoNKzWcpP5pwZHSDMU6MkwBKoC9A@mail.gmail.com>
Subject: Re: Alternatives to /sys/kernel/debug/wakeup_sources
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     Joel Fernandes <joelaf@google.com>,
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

On Wed, Jun 19, 2019 at 1:35 AM Rafael J. Wysocki <rafael@kernel.org> wrote:
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

This may be a dumb question. Is it appropriate to make symbolic links
in sysfs from one attribute to another attribute? For example,
/sys/devices/.../power/wakeup_count ->
/sys/power/wakeup_sources/.../wakeup_count.

I only see kobject to kobject symlinks around. And I don't think we
can make /sys/devices/.../power/ directory a symlink to where our new
wakeup stats will be, since the former contains attributes other than
wakeup ones.

Thanks!
