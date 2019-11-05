Return-Path: <SRS0=fWiu=Y6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.3 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F49AC5DF62
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Nov 2019 00:00:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0A3B62178F
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Nov 2019 00:00:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="VlMCTkpT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730533AbfKFAAK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 Nov 2019 19:00:10 -0500
Received: from mail-pf1-f196.google.com ([209.85.210.196]:41074 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729563AbfKFAAJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Nov 2019 19:00:09 -0500
Received: by mail-pf1-f196.google.com with SMTP id p26so17344719pfq.8
        for <linux-kernel@vger.kernel.org>; Tue, 05 Nov 2019 16:00:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=lhPGHL3YRrXYTue69wU9eU8V8Hx/b8hEqaEa6yTMnkc=;
        b=VlMCTkpT+whd9RxOskp1d0UAGHuA0h6fy1q55ME6v1BSRDECHdj3UWLD4/nl2kFi57
         QpRQjXkkG5d9C2XQorCh+PtySWXjM/1Ism68mr8kGSxX6kw1HJkesh4FOnHnGPZ9dsTD
         aamT7cM11W7vGaxrQIWXJJmkRttlHajiwihfjEq3uvKt5ZGOqMDiLRXukqUs6y4y/I+F
         ZcRpXOi/VnaKLTPk1GXl1k3S8OX8QuI+UWU+nJm83HCp9Fd9umODkJeL+YS99b/pyJVz
         +T2egQKbxqr6HH1esUB6oT76CdyQY8WAkKAuJWMpkQA1MU1q9jVYpcx+lmxI6UmsWCNh
         to6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=lhPGHL3YRrXYTue69wU9eU8V8Hx/b8hEqaEa6yTMnkc=;
        b=K2T+hkltNyV1oElY5ceb/l9E94T8QF6q83WaHoPmk7Kn58omQX424z9SNOaClP+j28
         thdnS8193lQsWLo7JXDKA61CbORrdrGuu0GS6VcbNjVJHHBYbvkE3QCXxEL3mGUAC9jl
         4Ozo+I81aA+P4QnGdAIKKGc47ZkEQtYHvBzRp4In/p/PoyzBqZ3Nll55CdSWn014m42j
         7EwEbe8egI4pb0I6ffvO4rQYYXEMm7cwap4Pv7yPgVUtjeMGypUa9YNp3ZU77+l7xNiF
         kZKijpE6/FeqQDhlQhwMEmxk5km06IKA4SHDJQLpU/TDcwqWx32H69YBGq/nfQ3lkKKC
         a4Fg==
X-Gm-Message-State: APjAAAXqDJ72FLSrf5dkYCy9lPy28IvBlxZhY+yDgIGEWtVzSdwwfm+r
        xnFX4k+SEPClMbRUBp6CFHLXYMcH5T69Sr7eBbVcwA==
X-Google-Smtp-Source: APXvYqx2fYUU/NkVF71Am9HasgI3vwxMoHR3QiibGcvRUftbZnyu0R3anDH7NSvGotdiSWDPP3VbGLfdWXuUHeNFMvw=
X-Received: by 2002:a65:664e:: with SMTP id z14mr39064849pgv.201.1572998408009;
 Tue, 05 Nov 2019 16:00:08 -0800 (PST)
MIME-Version: 1.0
References: <20191018001816.94460-1-brendanhiggins@google.com>
 <20191018122949.GD11244@42.do-not-panic.com> <alpine.LRH.2.20.1910191348280.11804@dhcp-10-175-221-34.vpn.oracle.com>
 <CAFd5g46aO4jwyo32DSz4L8GdhP6t38+Qb9NB+3fev3u4G6sg4w@mail.gmail.com>
 <20191024101529.GK11244@42.do-not-panic.com> <201910301205.74EC2A226D@keescook>
 <CAAXuY3o31iCJwZ+WGHMaK1MgpC0qv=JkJWnzv8Lhym9TnZQvcQ@mail.gmail.com>
 <CAFd5g446cyijzgap9r8nm_202zkUsfdZXrn5E1_Mfe-R+eFb_g@mail.gmail.com> <205525ba-dc2f-34a9-b7dc-4421285535d7@canonical.com>
In-Reply-To: <205525ba-dc2f-34a9-b7dc-4421285535d7@canonical.com>
From:   Brendan Higgins <brendanhiggins@google.com>
Date:   Tue, 5 Nov 2019 15:59:56 -0800
Message-ID: <CAFd5g47_H=JeC-esa_1H2jgwvW5kThWYzm6Wj_XonEsk-J6JDw@mail.gmail.com>
Subject: Re: [PATCH linux-kselftest/test v1] apparmor: add AppArmor KUnit
 tests for policy unpack
To:     Mike Salvatore <mike.salvatore@canonical.com>
Cc:     Iurii Zaikin <yzaikin@google.com>,
        Kees Cook <keescook@chromium.org>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Alan Maguire <alan.maguire@oracle.com>,
        Matthias Maennich <maennich@google.com>,
        shuah <shuah@kernel.org>,
        John Johansen <john.johansen@canonical.com>, jmorris@namei.org,
        serge@hallyn.com, David Gow <davidgow@google.com>,
        "Theodore Ts'o" <tytso@mit.edu>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-security-module@vger.kernel.org,
        KUnit Development <kunit-dev@googlegroups.com>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 5, 2019 at 8:43 AM Mike Salvatore
<mike.salvatore@canonical.com> wrote:
>
> >> but such approach is not mainstream.
> >> I personally like the idea of testing the lowest level bits in isolation even if
> >> they are not a part of any interface. I think that specifying the
> >> interface using
> >> unit tests and ensuring implementation correctness are complementary but
> >> I haven't had much luck arguing this with our esteemed colleagues.
>
> In general, testing public interfaces is preferable, however, I think it's
> important to avoid becoming dogmatic. IMHO, it's more important to have tests
> that are clear in what they test than to not write tests (or write confusing
> tests) in order to adhere to a generalized principle.

That's a really good point.

> > So I think this is a very subtle point which is very widely
> > misunderstood. Most people write code and then write their tests,
> > following this practice along with only testing public interfaces
> > often causes people to just not test all of their code, which is
> > wrong.
>
> The very nature of this situation is that the code was written before the tests.
>
> > The idea of only testing public interfaces is supposed to make people
> > think more carefully about what the composite layers of the program
> > is. If you are having difficulty getting decent coverage by only
> > testing your public interfaces, then it likely tells you that you have
> > one of two problems:
> >
> > 1) You have code that you don't need, and you should remove it.
> >
> > 2) One of the layers in your program is too think, and you should
> > introduce a new layer with a new public interface that you can test
> > through.
> >
> > I think the second point here is problematic with how C is written in
> > the kernel. We don't really have any concept of public vs. private
> > inside the kernel outside of static vs. not static, which is much more
> > restricted.
>
> I don't think we can expect developers to refactor large portions of complex
> kernel code in order to improve its testability. I imagine this will happen
> naturally over time, but I think we need to allow for developers to test
> "private" code in the meanwhile.
>
> My opinion is that it's more important to have tests than not. As evidence, I
> submit the following commit:
> https://github.com/torvalds/linux/commit/156e42996bd84eccb6acf319f19ce0cb140d00e3.
>
> While not a major bug, this bug was discovered as a direct result of writing
> these unit tests. So, in summary, I see value in "testing the lowest level bits
> in isolation", even if it doesn't necessarily represent the Gold Standard in
> Unit Testing.

You're right.

I think, in summary, it seems that pretty much everyone agrees that we
need to provide a mechanism for testing low level bits of code in
isolation in such a way that the tests are easy to write, and don't
require the code under test to be massively refactored. Beyond that it
seems that we are mostly in between either including tests in the
source for the code under test or using the __visible_for_testing
mechanism. Between the two, it seems the preference is for including
the test in the source.

So I think I will still send out a patch to add in the
__visible_for_testing mechanism in case someone wants to use it in the
future.

Nevertheless, I will reformat this patch to include the tests in the
files that are under test. One question, do we have a preference
between putting all the tests in the same file as the code under test?
Or do we want to put them in a separate file that gets #included in
the file under test? I have a preference for the latter, but will
defer to what everyone else wants.

Thanks everyone!
