Return-Path: <SRS0=Yun1=YR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0ECBCA9EB9
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Oct 2019 00:42:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C76302084B
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Oct 2019 00:42:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="hgo1tTqy"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2408102AbfJXAmb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 23 Oct 2019 20:42:31 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:34343 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2408092AbfJXAmb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Oct 2019 20:42:31 -0400
Received: by mail-pg1-f196.google.com with SMTP id k20so13148686pgi.1
        for <linux-kernel@vger.kernel.org>; Wed, 23 Oct 2019 17:42:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=LUXGEETBvCcBLZu+5N1PADlLxqK4jppDWqJHP95xhoM=;
        b=hgo1tTqyRFfyzQv2OcL/tBjhnyeaQkOXCW1UdFe54sVVt5yCbNBd2/b4dA+vHazekb
         zDu3uTT2j/++aRlvyk5c2Zm8C1nybWUVOHVDllkDsMyNhNSIpdo2aF3WTz33RtrFer3I
         pnh6GFpGx2LdS2hXJo/Wcm06srTtUZodnYmvTqp+2b0CV/xMEu5QtJnpEHsY7SkSCZah
         yPbwwyIiuPEsvqgV8mKW+3pv7EssjoDq1val32jBsYbkQ6gfiYLdCVWMqp9GoOmST5hB
         Mej6locdjzzG0iS/6EXDCZrQ7DPIVwKc6/QDKzVKdz8K57eAhQJesOJY/CvT7YG8GMdG
         kTFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=LUXGEETBvCcBLZu+5N1PADlLxqK4jppDWqJHP95xhoM=;
        b=Oop2FnkqiEGsRnqCD7jwZP9rtKQjEt2ZdmahKxMtcohTIPVm/tgGQEtBMnBq7PO6s2
         LEgWzMIOII4ljp55Jl9LZZFNgfRSrfeUecEAZHqWXVucyBrY2/yLjxvaP9s3qnzRnzbk
         ZDtOuDjlS+WfaiPETe632tzbjPE9sVOmtYtgIZN3CDWfvvVTSxXq4wOWVTs+2jBHZqPk
         mQRH3D7z2akYBbUxF4Td9Bml0InRWTACeEWCqQJkYCZMbHJIbpznlFQECeIANVuFDNnJ
         B1aQEtV4lCZjIhVg+MbyLFbJnuY76cafo40FYB7Sxm8foJYdrGdgWfGmvp2qAsePIlHy
         gcIA==
X-Gm-Message-State: APjAAAWu7BmTNsp/94mAVSRdQB/pbq7p5UX9ziUbOqEpwmnIdVAeY90m
        xX3dPe5RWF9+4KNRSGK+018bWkPE3mdGuydf0y2kKw==
X-Google-Smtp-Source: APXvYqz5EEvMyrSqzS9/KwMWlOiRt8rJspvtoU1gthEpc2kJiPfEtOw5QdDcyKeHJCEZ5I/WGgPeoJndy4X6dFc6i5s=
X-Received: by 2002:a63:3044:: with SMTP id w65mr12961228pgw.384.1571877749882;
 Wed, 23 Oct 2019 17:42:29 -0700 (PDT)
MIME-Version: 1.0
References: <20191018001816.94460-1-brendanhiggins@google.com>
 <20191018122949.GD11244@42.do-not-panic.com> <alpine.LRH.2.20.1910191348280.11804@dhcp-10-175-221-34.vpn.oracle.com>
In-Reply-To: <alpine.LRH.2.20.1910191348280.11804@dhcp-10-175-221-34.vpn.oracle.com>
From:   Brendan Higgins <brendanhiggins@google.com>
Date:   Wed, 23 Oct 2019 17:42:18 -0700
Message-ID: <CAFd5g46aO4jwyo32DSz4L8GdhP6t38+Qb9NB+3fev3u4G6sg4w@mail.gmail.com>
Subject: Re: [PATCH linux-kselftest/test v1] apparmor: add AppArmor KUnit
 tests for policy unpack
To:     Alan Maguire <alan.maguire@oracle.com>
Cc:     Luis Chamberlain <mcgrof@kernel.org>,
        Matthias Maennich <maennich@google.com>,
        shuah <shuah@kernel.org>,
        John Johansen <john.johansen@canonical.com>, jmorris@namei.org,
        serge@hallyn.com, Kees Cook <keescook@chromium.org>,
        Iurii Zaikin <yzaikin@google.com>,
        David Gow <davidgow@google.com>,
        "Theodore Ts'o" <tytso@mit.edu>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-security-module@vger.kernel.org,
        KUnit Development <kunit-dev@googlegroups.com>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>,
        Mike Salvatore <mike.salvatore@canonical.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Oct 19, 2019 at 5:56 AM Alan Maguire <alan.maguire@oracle.com> wrote:
>
> On Fri, 18 Oct 2019, Luis Chamberlain wrote:
>
> > On Thu, Oct 17, 2019 at 05:18:16PM -0700, Brendan Higgins wrote:
> > > From: Mike Salvatore <mike.salvatore@canonical.com>
> > >
> > > In order to write the tests against the policy unpacking code, some
> > > static functions needed to be exposed for testing purposes. One of the
> > > goals of this patch is to establish a pattern for which testing these
> > > kinds of functions should be done in the future.
> >
> > And you'd run into the same situation expressed elsewhere with kunit of
> > an issue of the kunit test as built-in working but if built as a module
> > then it would not work, given the lack of exports. Symbols namespaces
> > should resolve this [0], and we'd be careful where a driver imports this
> > namespace.
> >
> > [0] https://lwn.net/Articles/798254/

Maybe I am not understanding how the symbol namespaces work, but it
seems that it doesn't actually solve our problem, at least not all of
it.

First off this doesn't solve the problem for when a piece of code is
included as a module; it also does not address the problem for symbols
that would not normally be exported. Also, I think we still expect a
symbol that is not static to have an appropriate prefix, right? As in,
it is *not* okay to have a non-static symbol in apparmor called
"inbounds", correct?

> WRT adding tests, I think what we're aiming at is a set of best practices
> to advise test developers using KUnit, while attempting to minimize
> side-effects of any changes we need to make to support testability.
>
> One aspect of this we probably have to consider is inlining of code. For
> cases like this where the functions are small and are called in a small
> number of cases, any testability changes we make may push a
> previously-inlined function to not be inlined, with potential performance
> side-effects for the subsystem.  In such cases, I wonder if the right
> answer would be to suggest actually defining the functions as
> inline in the header file? That way the compiler still gets to decide (as
> opposed to __always_inline), and we don't perturb performance too much.

That's a really good point. Okay, so it seems that making the symbols
public when not testing is probably not okay on its own. If we are
going to do that, we probably need to do something like what you are
suggesting.

With that, I think the best solution in this case will be the
"__visible_for_testing" route. It has no overhead when testing is
turned off (in fact it is no different in anyway when testing is
turned off). The downsides I see are:

1) You may not be able to test non-module code not compiled for
testing later with the test modules that Alan is working on (But the
only way I think that will work is by preventing the symbol from being
inlined, right?).

2) I think "__visible_for_testing" will be prone to abuse. Here, I
think there are reasons why we might want to expose these symbols for
testing, but not otherwise. Nevertheless, I think most symbols that
should be tested should probably be made visible by default. Since you
usually only want to test your public interfaces. I could very well
see this getting used as a kludge that gets used far too frequently.

Nevertheless, based on Alan's point, I suspect it, for this case at
least, will likely be the least painful.

How do people feel about that?
