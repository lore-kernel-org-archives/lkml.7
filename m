Return-Path: <SRS0=21RF=YY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 429A2CA9ECE
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Oct 2019 09:33:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 191F220873
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Oct 2019 09:33:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="XhDF1lef"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727182AbfJaJdp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 31 Oct 2019 05:33:45 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:36461 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727009AbfJaJdp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Oct 2019 05:33:45 -0400
Received: by mail-pf1-f193.google.com with SMTP id v19so3980952pfm.3
        for <linux-kernel@vger.kernel.org>; Thu, 31 Oct 2019 02:33:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=UfGWBZAudfaqT290q3OdOipHzfk3TijoCmN+3Jz803Q=;
        b=XhDF1lefotT2UASMthSJUxNnb0mHTBcOYfkwpTSAY+w/HCQvebzTSdG9rU5FoZT5jB
         7yGt6KeTaVrur2O+wQU1bqQTugrJbB69piT163uph4YXe867ADk73jYvYgJdMCASsaqO
         jJoZ9FwT67M6PC6GOB7CEWQH/Vaam0LdsvMGqVy4R2FyYjny8XLnDljIsrzwlWUecIxm
         lAAUkGPSwFcHfQ42lhykC7lDHXvf9WRF8TUolfSlHkao3dOb5o/E4oz1kPLmbIMJMZph
         1nluWoVD9/ou08jb121tFfVKxG0vlpu9296vSX3JQpwJ0QYKoASioMWRqKHvSqwmsNB9
         Skag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=UfGWBZAudfaqT290q3OdOipHzfk3TijoCmN+3Jz803Q=;
        b=G/vEDhTGMWNee6jDdGhe3ZjWXlXV3w6OVmHgm9gYlkm8EMMA9sYN4vJQvibg8YqDkk
         AOZBGSir3m50z6SXiiLLvQIoyGzKkBx74L3+q2KNV3igIGJpoU+FwivT2z6AhiP5gCoG
         90KIzGJdmIajUMAzTus6heOLsn3WJ5jh19+8aUD4yz3krvXDaYpCR7Yl30EZoJLW43uf
         2KFJYHRFqdec9F+82xhESGXAu9bDUeqectGlPc3nDDb3pnEptvLfxLlPdteOQJtb8AOJ
         m1UH6zD+pwk1Zs7EROAjiecRVAxU7kN+yDB7kGrEpUOH4VZ2VEOJrJHW62SPot/Cynz0
         1eFg==
X-Gm-Message-State: APjAAAW07UZVlLOjecxMm2NRHna3U6/jT5BQdDwD8EVQTwUAxpbA1GCm
        dxhkSbK8+HrecVXxTpeP2sMUp31rekdIiQkx+Meugg==
X-Google-Smtp-Source: APXvYqwBk6uPqm3VmykJcnsaeX9RA5YnvlcvEM+HRhk1ugxAFt3mcM3t+eszNFAN+ts86FuqPlbKTwge7YK0Mt6Chag=
X-Received: by 2002:a65:664e:: with SMTP id z14mr5281693pgv.201.1572514424176;
 Thu, 31 Oct 2019 02:33:44 -0700 (PDT)
MIME-Version: 1.0
References: <20191018001816.94460-1-brendanhiggins@google.com>
 <20191018122949.GD11244@42.do-not-panic.com> <alpine.LRH.2.20.1910191348280.11804@dhcp-10-175-221-34.vpn.oracle.com>
 <CAFd5g46aO4jwyo32DSz4L8GdhP6t38+Qb9NB+3fev3u4G6sg4w@mail.gmail.com>
 <20191024101529.GK11244@42.do-not-panic.com> <201910301205.74EC2A226D@keescook>
 <CAAXuY3o31iCJwZ+WGHMaK1MgpC0qv=JkJWnzv8Lhym9TnZQvcQ@mail.gmail.com>
In-Reply-To: <CAAXuY3o31iCJwZ+WGHMaK1MgpC0qv=JkJWnzv8Lhym9TnZQvcQ@mail.gmail.com>
From:   Brendan Higgins <brendanhiggins@google.com>
Date:   Thu, 31 Oct 2019 02:33:32 -0700
Message-ID: <CAFd5g446cyijzgap9r8nm_202zkUsfdZXrn5E1_Mfe-R+eFb_g@mail.gmail.com>
Subject: Re: [PATCH linux-kselftest/test v1] apparmor: add AppArmor KUnit
 tests for policy unpack
To:     Iurii Zaikin <yzaikin@google.com>
Cc:     Kees Cook <keescook@chromium.org>,
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
        <linux-kselftest@vger.kernel.org>,
        Mike Salvatore <mike.salvatore@canonical.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 30, 2019 at 1:12 PM Iurii Zaikin <yzaikin@google.com> wrote:
>
> > Why can't unit tests live with the code they're testing? They're already
> > logically tied together; what's the harm there? This needn't be the case
> > for ALL tests, etc. The test driver could still live externally. The
> > test in the other .c would just have exported functions... ?
> >
> Curiously enough, this approach has been adopted by D 2.0 where unittests are
> members of the class under test:  https://digitalmars.com/d/2.0/unittest.html

Thanks for pointing this out, Iurii, that actually looks pretty cool.
I still personally prefer keeping tests and code separate, but if we
decide to go the route of mixing tests and code, maybe we might want
to use this as a model.

> but such approach is not mainstream.
> I personally like the idea of testing the lowest level bits in isolation even if
> they are not a part of any interface. I think that specifying the
> interface using
> unit tests and ensuring implementation correctness are complementary but
> I haven't had much luck arguing this with our esteemed colleagues.

So I think this is a very subtle point which is very widely
misunderstood. Most people write code and then write their tests,
following this practice along with only testing public interfaces
often causes people to just not test all of their code, which is
wrong.

The idea of only testing public interfaces is supposed to make people
think more carefully about what the composite layers of the program
is. If you are having difficulty getting decent coverage by only
testing your public interfaces, then it likely tells you that you have
one of two problems:

1) You have code that you don't need, and you should remove it.

2) One of the layers in your program is too think, and you should
introduce a new layer with a new public interface that you can test
through.

I think the second point here is problematic with how C is written in
the kernel. We don't really have any concept of public vs. private
inside the kernel outside of static vs. not static, which is much more
restricted.
