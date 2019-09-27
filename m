Return-Path: <SRS0=WTd2=XW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3BA8DC388F3
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Sep 2019 19:41:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 07B3120863
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Sep 2019 19:41:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1569613286;
	bh=r2HLKWu5wLRtm/i9i4jLwyp1AgFxK0jh5ydM8NUcVK4=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=ARHXla4qwb/rPAYz40FKMvdwf3DsXSwQZYlsIIrYUr03ivjDx6VwtSAH2opMFRp0t
	 s9o8j+lOKjsam3I5fjJ5fnC63A/Y21p/qfIX++SLp6/h+cubEZeNe4HFnpYPbQCaWc
	 BMST2H6mw5DLwtS9pQ4hQiLSW5MtuTbaWw4rocTI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728119AbfI0TlZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 27 Sep 2019 15:41:25 -0400
Received: from mail-lj1-f195.google.com ([209.85.208.195]:32910 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727734AbfI0TlY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Sep 2019 15:41:24 -0400
Received: by mail-lj1-f195.google.com with SMTP id a22so3644137ljd.0
        for <linux-kernel@vger.kernel.org>; Fri, 27 Sep 2019 12:41:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=RJBm3wIiTMlbTLXcMDkNDDL26nbs1uDfiv0ETeeEYjs=;
        b=LeHqucnAee/LJ+EIK96m57dcj0RYG4Sq1r/U0YWxFvxLjIgEJn2YixNR4e9JVnma6W
         VKwPzGZ5r77StAkDCv5si2HCYWY/ODZzp9MHmduXjdZ92v9zTmg6WzWymIOQkYfSWRu/
         BprUHgbX5ryJrKBKijJz2olCNHAIiXNvec7VE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=RJBm3wIiTMlbTLXcMDkNDDL26nbs1uDfiv0ETeeEYjs=;
        b=BX9SWE0N1C5ty+zYsOd1gaoi+e9dLIRvCD/jjHboYd0XMqdgK0igdkyNUb7/owYm+o
         n5+YG3S7g90SiP8Vq67VfK/Nu9gKW+AfYnSwrMt6xnmtWPv70G4RY36orD85/i4fYs47
         9xzHHUpekiwwBlKA9YvCU5dUrx5VpqHzNMsaYV1ZUHPb0w6IjKXq4rSxB8jNE8yrRCgD
         f3Q569axackqZdI9+3ClGYsOL6cMgQna1E0Wc2obkcXJrvGLka+39SEs6KIK9A/UzSe9
         SVRs0QW32f7YQcVkjgG3dJPedsip1gQfZ+sV8iyFwJqCA/jUwyPoQFHl9SUBrSJD8BTi
         JeuQ==
X-Gm-Message-State: APjAAAXqCgndMFfWQ8t0l7voyAYSuBXVADuwHz3bQ0ZWHQuQz/Tgqu74
        ehJVYholcNKd9HKE3shoOWhhZouCrVE=
X-Google-Smtp-Source: APXvYqyL9wkm+rJWzNUHnm2GH4OxUdHUsgs/uNB01YUY5EgJ+sfmMwll5EGroKH7b5hIsOgtFVq5Rw==
X-Received: by 2002:a2e:2e17:: with SMTP id u23mr4205120lju.26.1569613281813;
        Fri, 27 Sep 2019 12:41:21 -0700 (PDT)
Received: from mail-lj1-f172.google.com (mail-lj1-f172.google.com. [209.85.208.172])
        by smtp.gmail.com with ESMTPSA id i128sm626929lji.49.2019.09.27.12.41.20
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 27 Sep 2019 12:41:21 -0700 (PDT)
Received: by mail-lj1-f172.google.com with SMTP id y23so3589701lje.9
        for <linux-kernel@vger.kernel.org>; Fri, 27 Sep 2019 12:41:20 -0700 (PDT)
X-Received: by 2002:a2e:2c02:: with SMTP id s2mr4224670ljs.156.1569613280372;
 Fri, 27 Sep 2019 12:41:20 -0700 (PDT)
MIME-Version: 1.0
References: <a9e8e68f34139d5a9abb7f8b7d3fe64ff82c6d96.camel@intel.com>
 <CAHk-=whua2XSTLd3gtqVHfq5HtGnjhRUv7vA6SUfkbVUebqWJQ@mail.gmail.com> <64d13484950cab570e5f2691d7cdeca292882d95.camel@redhat.com>
In-Reply-To: <64d13484950cab570e5f2691d7cdeca292882d95.camel@redhat.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Fri, 27 Sep 2019 12:41:04 -0700
X-Gmail-Original-Message-ID: <CAHk-=whwYbKX1AqnOvcdT7T2GofRQqnb6xEJJ6+==ZZN1eEYQA@mail.gmail.com>
Message-ID: <CAHk-=whwYbKX1AqnOvcdT7T2GofRQqnb6xEJJ6+==ZZN1eEYQA@mail.gmail.com>
Subject: Re: [GIT PULL] Thermal management updates for v5.4-rc1
To:     Doug Ledford <dledford@redhat.com>
Cc:     Zhang Rui <rui.zhang@intel.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux PM list <linux-pm@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 27, 2019 at 12:29 PM Doug Ledford <dledford@redhat.com> wrote:
>
> Because there are literally thousands of developers working on kernel
> bits here and there, and you're swatting this particular fly one
> developer at a time.

Well, at least these days it's also very clearly spelled out in the
Documentation directory.

And the "don't rebase" does get posted on the mailing lists each time,
and I've mentioned it over the years in my release notes too.

Besides, I actually only work with about a hundred top-level
maintainers, not thousands. Yes, we have thousands of developers, but
doing the stats over the 5.0 releases, there have been "only" 131
people sending me pull requests. Sure, more than a couple, but at the
same time it's not like this is a "every developer" kind of thing,
this is literally subsystem maintainers. We've got a fair number of
them, but it's definitely not about thousands.

I feel like I've sent that email out way more than a hundred times
over the last 15+ years.

.. and I don't think having git warn is right, since rebasing is
perfectly fine as you are doing development.

It's really just that maintainers shouldn't do it for bad reasons and
at bad times.

And "there was a conflict" and "yesterday" is really one of the
absolute worst reasons/times around.

                    Linus
