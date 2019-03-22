Return-Path: <SRS0=oArh=RZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5BB72C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 14:36:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 318D6218A5
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 14:36:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729247AbfCVOge convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Mar 2019 10:36:34 -0400
Received: from mail-qk1-f195.google.com ([209.85.222.195]:39560 "EHLO
        mail-qk1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729211AbfCVOgb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Mar 2019 10:36:31 -0400
Received: by mail-qk1-f195.google.com with SMTP id c189so1327717qke.6;
        Fri, 22 Mar 2019 07:36:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=/HL8Tg1lWXyP/ZQj2pyLGJ+TOXyu3xswQLjsHsrEWes=;
        b=tGsAFO3H/Mk6vozZ1kiqAkSg6Oo/xZToRu2/aYnFC/FCY9SCbM58FLoDEFmIJSJ4kU
         JMvS4rZJMnGu9qS3/EppQcj72IG8hovyt3bABKm3sy4vjfPy2K7Fkg9yWG13AKPO1D8h
         VHHO+TiTtBZrU28/85bmPYU8+5fSmCkmBx4TTp188zHdUWActwCf3QO90DHPUQXiK5S0
         Oqv4rUAX7MJTJJhIbkeFxriF9B2S8PGHIJcQHs9XmYOVbtGUa/VN8YP9Bc9ZAeAupGPY
         Hnx/uJqbCHAJTcEflfajo/ux6+O0ZHGizKZCsPuXujAEbYveuQ1wJr7c4aQGQjT1ssge
         Wfjg==
X-Gm-Message-State: APjAAAUUhTMqRCSyVZ5Yk52tBeEBXS6euMCMl649wetsfZxXZw+MS8IH
        8LdCcwC4/AN6ESXR5BKpPIb3P33SjVZ331Exk5DtidUL
X-Google-Smtp-Source: APXvYqwHRfDCNzIargwZVbVN46sqpjw7/DSi9f13npJQ0DLw5TvwXxOfVREUJGRb0OJs2YNrhbiJL3J38I3FY5+MZCk=
X-Received: by 2002:a05:620a:133b:: with SMTP id p27mr7772328qkj.173.1553265390390;
 Fri, 22 Mar 2019 07:36:30 -0700 (PDT)
MIME-Version: 1.0
References: <20190307221054.13126-1-natechancellor@gmail.com> <94c7f399-7101-2297-43e0-834f50c3510f@suse.de>
In-Reply-To: <94c7f399-7101-2297-43e0-834f50c3510f@suse.de>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Fri, 22 Mar 2019 15:36:12 +0100
Message-ID: <CAK8P3a24tM1SB+gy1P9jdJ4077=DtOmgLvMLuNa9cj9RZGdxBg@mail.gmail.com>
Subject: Re: [PATCH] bcache: Zero initialize bucket in bch_allocator_thread
To:     Coly Li <colyli@suse.de>
Cc:     Nathan Chancellor <natechancellor@gmail.com>,
        Kent Overstreet <kent.overstreet@gmail.com>,
        linux-bcache@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        clang-built-linux@googlegroups.com,
        Nick Desaulniers <ndesaulniers@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 8, 2019 at 3:11 AM Coly Li <colyli@suse.de> wrote:
> On 2019/3/8 6:10 上午, Nathan Chancellor wrote:
> > When building with -Wsometimes-uninitialized, Clang warns:
> >
> > drivers/md/bcache/alloc.c:333:4: warning: variable 'bucket' is used
> > uninitialized whenever 'if' condition is false
> > [-Wsometimes-uninitialized]
> >
> > fifo_pop expands to a conditional depending on '!fifo_empty(...)', which
> > is the same condition as the while loop. It seems Clang can't piece
> > together that this condition will never been false as long as we are in
> > the while loop because they are the same condition. It's easy enough to
> > silence this warning by just explicitly zero initializing bucket.
> >
> > Link: https://github.com/ClangBuiltLinux/linux/issues/396
> > Signed-off-by: Nathan Chancellor <natechancellor@gmail.com>
>
> Hi Nathan,
>
> Nice catch, I will add it to my for-test. Thanks.

I saw the same warning but came up with a nicer (IMHO) fix, see
https://lore.kernel.org/lkml/20190322143507.1256436-1-arnd@arndb.de/T/#u

        Arnd
