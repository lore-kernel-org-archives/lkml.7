Return-Path: <SRS0=wETr=XU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 130CDC432C2
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Sep 2019 20:23:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D77FA21D7A
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Sep 2019 20:23:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1569443030;
	bh=8W9V0w1xVYJZ6PErgcTNXtPAYmvQekM1S5pq3IdYKbY=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=cKH116+gWrRJ1K2Aq0HvxhmVh+pDPBrpSxrtHArAcp3N6UzoSt10fCdsLwfLrFn4l
	 u+mNnCLLXRCnXMh01BhD2Nh+gNFNXMnqQ/yZDx51GHVxwPvwl2ScMYxVxM4r3jkoOp
	 phhLyrEcwgiuSZVL+CVYIHlJW37yC9LRcC/45c+A=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732764AbfIYUXu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 25 Sep 2019 16:23:50 -0400
Received: from mail-lj1-f193.google.com ([209.85.208.193]:44065 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728474AbfIYUXt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Sep 2019 16:23:49 -0400
Received: by mail-lj1-f193.google.com with SMTP id m13so7035018ljj.11
        for <linux-kernel@vger.kernel.org>; Wed, 25 Sep 2019 13:23:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=m3ItCLkP0Wm4Ak+WGr3LTNj+4g3loXe1oyLTxRsQI8c=;
        b=hW5iXNvwQEuj3rT9IzVABGFeZs+xpuh7yW8suXDxSXXGJmlalPZbpXpj5zZHxO8o2h
         HCKtkg3kL0s9BxkQL1hAY/aXPMPIiZufFScpxUWfUWlQwP0BaCIeD26THZhs6rp5ZF5B
         ZT9ScEXwfZBf7u3fO0vG9M1bHCrFQHfGAS+O0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=m3ItCLkP0Wm4Ak+WGr3LTNj+4g3loXe1oyLTxRsQI8c=;
        b=RgnsxWVlQhNW3/TbNFRgkEaWWb5H50Jnq/gTGYNHDniycUFdcgnPG7w/aht4VEHPWo
         RwkGJR16hzYMhRt56W3j1sJI57mEuDBqH5v7A0sXOkzrwa97Cua95bXuwWSmlPPjI+je
         s2i6QsNlqzPI/uZAxSv5LjcRdpL/FXtT7YmnyJrI58JWyTLCIovSK8KB5gShMSDpbKDP
         PRs7KqrKDZ2gupp/XjOrewfmaYL9Wy9an2lVXyN9rdWsHnIi+dPkRgotsxSt/CZQY733
         mZEPx7ibCURbvbzgBzXht35AIIdLKfcuFNY0u2lNTXmoV26YU5A3vD81mzfXXrxtMBZZ
         UZ0Q==
X-Gm-Message-State: APjAAAXpE1gmCanc+0CPvz8xvTXjibFzgqME+fw1iLC4U4cJj3D4bdoF
        VdHhC++UqqKav8Et8OsDU9eWlOzuYzk=
X-Google-Smtp-Source: APXvYqzD4gKCVKyrXxp0MfK8sGjj6B6lE3HqXxzn/L1oEXlR9/ny+47H18YhS2jlvuXlQ84HmW4I1Q==
X-Received: by 2002:a2e:9b5a:: with SMTP id o26mr116374ljj.158.1569443026117;
        Wed, 25 Sep 2019 13:23:46 -0700 (PDT)
Received: from mail-lj1-f177.google.com (mail-lj1-f177.google.com. [209.85.208.177])
        by smtp.gmail.com with ESMTPSA id w30sm7463lfn.82.2019.09.25.13.23.43
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 25 Sep 2019 13:23:44 -0700 (PDT)
Received: by mail-lj1-f177.google.com with SMTP id a22so7064116ljd.0
        for <linux-kernel@vger.kernel.org>; Wed, 25 Sep 2019 13:23:43 -0700 (PDT)
X-Received: by 2002:a2e:8789:: with SMTP id n9mr126368lji.52.1569443023576;
 Wed, 25 Sep 2019 13:23:43 -0700 (PDT)
MIME-Version: 1.0
References: <20190925165915.8135-1-cyphar@cyphar.com> <20190925165915.8135-2-cyphar@cyphar.com>
 <CAHk-=wjFeNjhtUxQ8npmXORz5RLQU7B_3wD=45eug1+MXnuYvA@mail.gmail.com>
 <20190925172049.skm6ohnnxpofdkzv@yavin> <CAHk-=wjagt257WHiOr2v1Bx_3q7tuzogabw_1EnodKm0vt+-WQ@mail.gmail.com>
 <20190925180412.GK26530@ZenIV.linux.org.uk> <CAHk-=wgcHw-O1sXw2jfJEHSVa2xmJcP9dzUmy71Cqk7_wVLSFQ@mail.gmail.com>
 <20190925194331.GL26530@ZenIV.linux.org.uk>
In-Reply-To: <20190925194331.GL26530@ZenIV.linux.org.uk>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Wed, 25 Sep 2019 13:23:27 -0700
X-Gmail-Original-Message-ID: <CAHk-=whSHi46gH-aE8bQsv7hvKDSHpWKQyLW3qF3caAB59cH+g@mail.gmail.com>
Message-ID: <CAHk-=whSHi46gH-aE8bQsv7hvKDSHpWKQyLW3qF3caAB59cH+g@mail.gmail.com>
Subject: Re: [PATCH v1 1/4] lib: introduce copy_struct_from_user() helper
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     Aleksa Sarai <cyphar@cyphar.com>, Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Christian Brauner <christian@brauner.io>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        GNU C Library <libc-alpha@sourceware.org>,
        Linux API <linux-api@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 25, 2019 at 12:43 PM Al Viro <viro@zeniv.linux.org.uk> wrote:
>
> FWIW, I would probably add a kernel-space analogue of that thing at the
> same time - check that an area is all-zeroes is not all that rare.

Hmm. Maybe.

> Another thing is that for s390 we almost certainly want something better
> than word-by-word.  IIRC, word-sized userland accesses really hurt there.
> It's nowhere near as critical as with strncpy_from_user(), but with the
> same underlying issue.

Well, s390 does have those magic "area" instructions, but part of why
it's expensive on s390 is that they haven't implemented the
"user_access_begin()/end()' stuff. I think s390 could use that to at
least minimize some of the costs.

With the common case presumably being just a couple of words, it migth
not be worth it doing anything more than that even on s390.

Interestingly (or perhaps not) if I read the internal s390
implementation correctly, they kind of _have_ that concept and they
use it internally. It's just that they call it "enable_sacf_uaccess()"
and "disable_sacf_uaccess()" instead.

           Linus
