Return-Path: <SRS0=Yvat=2B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7125DC43603
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Dec 2019 17:45:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4373120663
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Dec 2019 17:45:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="dSFm1czu"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730569AbfLKRpU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Dec 2019 12:45:20 -0500
Received: from mail-pf1-f195.google.com ([209.85.210.195]:39175 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729524AbfLKRpS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Dec 2019 12:45:18 -0500
Received: by mail-pf1-f195.google.com with SMTP id 2so2152384pfx.6
        for <linux-kernel@vger.kernel.org>; Wed, 11 Dec 2019 09:45:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=f0OGrv7lx+Zl9WZjIpgsG/9JjtlvMsK6Onor4QOzhiU=;
        b=dSFm1czu+pm7SIs0bP6i1otiKyGyBdfhEZRT7//ic7M+oipYjchAdycG1x8Z9Lu4V+
         CQIuES31Slfjt0oRLUO+N4wfsvQmw7z6HF0Q6B/x/jGGum093H02AtsWXp/SWE1/SZ3m
         SOGhNmVT/p2ON2mW07FTcZt7wgkCkY2I5OW0mJHzLGmQc1yHrKBZRcMylRkRYmdHQdJp
         ML2ECNENZdF+ZFsQaQbzGxQoMHmGMQ8O/hu7wQnu/HPzT5TQ5oK7OM/hBGBTeOyWdNxj
         vrEkCrGLZq1wTc3b8hEXEHk5ry9DTB04uS/3b8511yyi647gaQ2rSBsvLjObpWfyL2vw
         w+0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=f0OGrv7lx+Zl9WZjIpgsG/9JjtlvMsK6Onor4QOzhiU=;
        b=eYoKUA4TdOax6nrh22fcwA1HSRA4tCYCVUC1iNn7c9vMPvft53vYvdrzWuLeDKaa4r
         CFp8yuQUAuuYdTsx/CPLQa/C+i5xEes5RcuDt92XlKTE9A5Ryvvy0nck94ZPmVXocRcY
         MkRPlN8jUawSSXWSIY3Zk+QdcqUSkoxl/5hgg5Lo+pV6qx2a53dMRipwpxqSV2NExo1d
         I7gPl56awFz0TKcg0MNvn1/WLXNBH0wgYzBft+tg8+ZinbIEJghiWJ8EOF+QG6jhM00E
         ksAREUiQg27CFEibmpHET+OyAfpEpvLgGP6uBlULUXRGHq8WvC/ZijLyFnfgT4mXumDv
         Gj9g==
X-Gm-Message-State: APjAAAWl05GrEzNisUGry8gpi/A+NPXGpaYzVWJ4WOL3oJwLnDaKDW7P
        n7VhWqxwMwWepsJ5wDHc7z3Zgv3g6+pV7BdMkcPs6w==
X-Google-Smtp-Source: APXvYqz7XjlAgHjobYmSc6XZ3IV9j5m9Gn/I2mq5n5sH6vxlj2+haEA9q7qO4eY1S7TizEeFPgB0uvoPBvBL9nZ6eVo=
X-Received: by 2002:aa7:961b:: with SMTP id q27mr5064829pfg.23.1576086317561;
 Wed, 11 Dec 2019 09:45:17 -0800 (PST)
MIME-Version: 1.0
References: <20191211163310.4788-1-sj38.park@gmail.com> <3dab421e-6aa5-90e4-791e-53482f5c1fe8@kernel.org>
 <CAEjAshqjjVgtf_JxNvi3WOvkrjOp_-YjK=rY7GE0Mt40Y1EMqQ@mail.gmail.com>
In-Reply-To: <CAEjAshqjjVgtf_JxNvi3WOvkrjOp_-YjK=rY7GE0Mt40Y1EMqQ@mail.gmail.com>
From:   Brendan Higgins <brendanhiggins@google.com>
Date:   Wed, 11 Dec 2019 09:45:07 -0800
Message-ID: <CAFd5g4649_C0tSy3W-KzN05Y8K5zZtGUGVYFA9iAKvaXsPentw@mail.gmail.com>
Subject: Re: [PATCH v5 0/6] Fix nits in the kunit
To:     SeongJae Park <sj38.park@gmail.com>
Cc:     shuah <shuah@kernel.org>, SeongJae Park <sjpark@amazon.com>,
        Jonathan Corbet <corbet@lwn.net>,
        KUnit Development <kunit-dev@googlegroups.com>,
        linux-doc <linux-doc@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>, SeongJae Park <sjpark@amazon.de>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 11, 2019 at 9:40 AM SeongJae Park <sj38.park@gmail.com> wrote:
>
> On Wed, Dec 11, 2019 at 6:22 PM shuah <shuah@kernel.org> wrote:
> >
> > On 12/11/19 9:33 AM, SeongJae Park wrote:
> > > May I ask some comments?
> > >
> > >
> > > Thanks,
> > > SeongJae Park
> > >
> >
> > + Brendan
> >
> > > On Thu, 5 Dec 2019 10:34:34 +0100 SeongJae Park <sjpark@amazon.com> wrote:
> > >
> > >>
> > >> This patchset contains trivial fixes for the kunit documentations and
> > >> the wrapper python scripts.
> > >>
> > >> This patchset is based on 'kselftest/test' branch of linux-kselftest[1]
> > >> and depends on Heidi's patch[2].  A complete tree is available at my repo:
> > >> https://github.com/sjp38/linux/tree/kunit_fix/20191205_v5
> > >>
> > >> Changes from v4
> > >> (https://lore.kernel.org/linux-doc/1575490683-13015-1-git-send-email-sj38.park@gmail.com/):
> > >>   - Rebased on Heidi Fahim's patch[2]
> > >>   - Fix failing kunit_tool_test test
> > >>   - Add 'build_dir' option test in 'kunit_tool_test.py'
> > >>
> >
> > Please include Brendana Higgins on kunit patches.
>
> Not sure how I could forgot adding him.  I will never forget from next time.

No worries. I still got the email from the list :-)

I think I reviewed all the patches in this series; I just need to test
them. I will try to have that done later today or tomorrow.

Cheers!
