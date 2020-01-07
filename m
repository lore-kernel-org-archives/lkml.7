Return-Path: <SRS0=facv=24=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5A41FC282DD
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jan 2020 21:13:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2A24A2077B
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jan 2020 21:13:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="KQVwsStO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729875AbgAGVNa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Jan 2020 16:13:30 -0500
Received: from mail-vs1-f66.google.com ([209.85.217.66]:43221 "EHLO
        mail-vs1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727345AbgAGVNY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Jan 2020 16:13:24 -0500
Received: by mail-vs1-f66.google.com with SMTP id s16so453276vsc.10
        for <linux-kernel@vger.kernel.org>; Tue, 07 Jan 2020 13:13:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=4bvDGD+uZFRI6wle2DQe8dNEf7/FawRKtQyhzkKp5kw=;
        b=KQVwsStOsvUFWmEIg1vbufOPH4q4526fnFkHZKuJZrLDUdrYo7b8+m/wOLoLIxlMpQ
         rifgkmP2r1S8nCyPcgVxzg3CxK/rOoqCa6uKsUsyMbk45IZqSPcRxtTjgKyhdO67JVw2
         yZDfkKv5zrHZXehKokQv0Ky2Ry9W0r0NEmWM9Rra4jWzzDJNsvUjjwE0gyPp6en9iHX8
         AB8I2xUL4Ovt8bQoDDJl5+fIYsLQn8fQBttM81wro9kWD1Jcr34on3ie4oTjb184Ifow
         uXvWDd06kKCirdcfRYDKXGHhcP4gu4+aKneQwt/Fz8UleolmSVLsX5BA0JhjUGa/FhGm
         ox2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=4bvDGD+uZFRI6wle2DQe8dNEf7/FawRKtQyhzkKp5kw=;
        b=uUvVSp1vhjbc+wrSKqFqVlWvwDG3BhZNC0pBjttqfkpSGM9vNvkzGdvVzRrdcmIPYM
         DdPxLgGBYZmcIeIApsiAS92CS/9vn2YmlKe3jgx+Lc9iC6Ylv3oh0LkHNAhUWuFT9Lbn
         S6NWWKB62qQ17ocMwWDz+qgQWST76hUeeWq1JIXccDeEC+ohPe3eTFe5ySP8GsxBs+3c
         sIQqOYXR9ynxduEuEWBlImVDN5vzBfsHI6oASMTDZIAdeMRDCw8XZBEiF7Ri7t40Z9Bl
         Rs1QpUh/McoagBemxEI9nBZLIJwk5VWYfNBmm74zmcUV4cxmQmvXaNu55xC2AOS8dRIv
         ki7w==
X-Gm-Message-State: APjAAAXCoUgc4L/UQpJi/IZHzyF6iEkr0UMThaszMKMOtb2OwBAFDqPE
        2b9pB3wZ0i5b3JMiRt/5Hhu0tWbI7gnvjqGQlF96Rg==
X-Google-Smtp-Source: APXvYqz4dUEEj5q+SNZ0t9tcB9nHne8gPerfQ8ARFF6iQ6Im7uIQEkt0Hpm/+TaVwjf3O0rCQAlQVrwOn4RCK0e1NUM=
X-Received: by 2002:a67:fc46:: with SMTP id p6mr784857vsq.235.1578431603178;
 Tue, 07 Jan 2020 13:13:23 -0800 (PST)
MIME-Version: 1.0
References: <20191216213901.106941-1-bgardon@google.com> <20191216213901.106941-3-bgardon@google.com>
 <20200107160035.GG219677@xz-x1>
In-Reply-To: <20200107160035.GG219677@xz-x1>
From:   Ben Gardon <bgardon@google.com>
Date:   Tue, 7 Jan 2020 13:13:12 -0800
Message-ID: <CANgfPd-GLFtqrWsyg6hvrMFYxWCzxAQEGZ9Ahk4ZATYWs0_VaQ@mail.gmail.com>
Subject: Re: [PATCH v3 2/8] KVM: selftests: Add demand paging content to the
 demand paging test
To:     Peter Xu <peterx@redhat.com>
Cc:     linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
        linux-kselftest@vger.kernel.org,
        Paolo Bonzini <pbonzini@redhat.com>,
        Cannon Matthews <cannonmatthews@google.com>,
        Andrew Jones <drjones@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Done. I'll have it in the next version of the patch set I send out.

On Tue, Jan 7, 2020 at 8:00 AM Peter Xu <peterx@redhat.com> wrote:
>
> On Mon, Dec 16, 2019 at 01:38:55PM -0800, Ben Gardon wrote:
>
> [...]
>
> > +static void *uffd_handler_thread_fn(void *arg)
> > +{
> > +     struct uffd_handler_args *uffd_args = (struct uffd_handler_args *)arg;
> > +     int uffd = uffd_args->uffd;
> > +     int64_t pages = 0;
> > +
> > +     while (!quit_uffd_thread) {
> > +             struct uffd_msg msg;
> > +             struct pollfd pollfd[1];
> > +             int r;
> > +             uint64_t addr;
> > +
> > +             pollfd[0].fd = uffd;
> > +             pollfd[0].events = POLLIN;
> > +
> > +             /*
> > +              * TODO this introduces a 0.5sec delay at the end of the test.
> > +              * Reduce the timeout or eliminate it following the example in
> > +              * tools/testing/selftests/vm/userfaultfd.c
> > +              */
> > +             r = poll(pollfd, 1, 500);
>
> Would you mind implement it instead of adding a todo?  IIUC it's as
> simple as a few more lines than the comment itself.  Thanks,
>
> --
> Peter Xu
>
