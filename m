Return-Path: <SRS0=21RF=YY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D48FECA9ECB
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Oct 2019 09:18:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A89A520862
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Oct 2019 09:18:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="vLVfuciN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727029AbfJaJSC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 31 Oct 2019 05:18:02 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:36472 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726864AbfJaJSC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Oct 2019 05:18:02 -0400
Received: by mail-pf1-f194.google.com with SMTP id v19so3950738pfm.3
        for <linux-kernel@vger.kernel.org>; Thu, 31 Oct 2019 02:18:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=/4vjjXip3PEZlpbvSCBjNSofs7TybrsEceZdmzVqTWg=;
        b=vLVfuciNf7T8Yu5E2bROWn0NM0KpFjqxr++0zpwbFio/EEJo2T5wJdD3D7Cnjum+5S
         oReoZsaxy9BkEdsv2pV9IsrGYf6fnv3cvIgdQCN+azdIrPfljxaoL8N7PG4SH1weLRJz
         8Pq7bPws7tFsavO1Jg3lTNzhSqpD3x1IsE4n9KcEIEh9PPRkZNyo0J04GyWnA9YDYFDP
         ON7Li7hij9hcochr8D0HBMbwnjWPQdG6D7NJ6RAEFI6WvqiJgQhzIpnsvDcS+UAGdqth
         NnKwbU9dNTl+Ntmn//STGsXFF7/l/PtIpEuvLmkAT2KXdJJ9CPiqDpbYcmz4P/j/9KMH
         oLJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=/4vjjXip3PEZlpbvSCBjNSofs7TybrsEceZdmzVqTWg=;
        b=UnRzao1cUB/WZpOuuvVX8Tj2/EZFBVtITV59d2TMEPYnJAMbgUPUFGvW9l7hwVmxHD
         9AIRizBKztFUUlMXmX387Zn3SjLJrwNVQhiKEcDLWg+8avPVLOXpymk1w+HwYL38Us0M
         OroVjAX44tmU/9VhmRFxgenAka9jo9O2TH8ipX8w9ICzJTPMCsv4K0MMUtzHd9fC0mhm
         H9LXi+RsNMLExnhjfkCl1N9gRkuC00fxwMrNroXOiT9GVIrxkars76vxB6dGy1tnBO8d
         7YZHy4fHurmZRYaETKKynXtIuicByOF8zQGERuVqPVBko/VBmhHCBOEEtRR007faSIFK
         m08w==
X-Gm-Message-State: APjAAAVj98zHVUEUdXkXhDOlE7sQ0VqaEIH2R18Nb73n1wEuK6fCTbVI
        8xyHkHiDsUcSB5myBgS84pKMsASV3vHOE5neHTzaHA==
X-Google-Smtp-Source: APXvYqypwZwY39bRA8SlcqSx2t9abzPasBSJqwBHjFz7WDKZ1NhGDmS5XjfCTop3u9EnVZ+RtajjJ+BbxlfeIRaFHGc=
X-Received: by 2002:a63:234c:: with SMTP id u12mr5113679pgm.384.1572513480667;
 Thu, 31 Oct 2019 02:18:00 -0700 (PDT)
MIME-Version: 1.0
References: <20191018001816.94460-1-brendanhiggins@google.com>
 <20191018122949.GD11244@42.do-not-panic.com> <alpine.LRH.2.20.1910191348280.11804@dhcp-10-175-221-34.vpn.oracle.com>
 <CAFd5g46aO4jwyo32DSz4L8GdhP6t38+Qb9NB+3fev3u4G6sg4w@mail.gmail.com>
 <20191024101529.GK11244@42.do-not-panic.com> <201910301205.74EC2A226D@keescook>
In-Reply-To: <201910301205.74EC2A226D@keescook>
From:   Brendan Higgins <brendanhiggins@google.com>
Date:   Thu, 31 Oct 2019 02:17:49 -0700
Message-ID: <CAFd5g45V-iYaAhHwoaUPoPYUBud-5vxbBkApp-h5O6J8trnPRA@mail.gmail.com>
Subject: Re: [PATCH linux-kselftest/test v1] apparmor: add AppArmor KUnit
 tests for policy unpack
To:     Kees Cook <keescook@chromium.org>
Cc:     Luis Chamberlain <mcgrof@kernel.org>,
        Alan Maguire <alan.maguire@oracle.com>,
        Matthias Maennich <maennich@google.com>,
        shuah <shuah@kernel.org>,
        John Johansen <john.johansen@canonical.com>, jmorris@namei.org,
        serge@hallyn.com, Iurii Zaikin <yzaikin@google.com>,
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

On Wed, Oct 30, 2019 at 12:09 PM Kees Cook <keescook@chromium.org> wrote:
>
> On Thu, Oct 24, 2019 at 10:15:29AM +0000, Luis Chamberlain wrote:
> > On Wed, Oct 23, 2019 at 05:42:18PM -0700, Brendan Higgins wrote:
> > > With that, I think the best solution in this case will be the
> > > "__visible_for_testing" route. It has no overhead when testing is
> > > turned off (in fact it is no different in anyway when testing is
> > > turned off). The downsides I see are:
> > >
> > > 1) You may not be able to test non-module code not compiled for
> > > testing later with the test modules that Alan is working on (But the
> > > only way I think that will work is by preventing the symbol from being
> > > inlined, right?).
> > >
> > > 2) I think "__visible_for_testing" will be prone to abuse. Here, I
> > > think there are reasons why we might want to expose these symbols for
> > > testing, but not otherwise. Nevertheless, I think most symbols that
> > > should be tested should probably be made visible by default. Since you
> > > usually only want to test your public interfaces. I could very well
> > > see this getting used as a kludge that gets used far too frequently.
> >
> > There are two parts to your statement on 2):
> >
> >   a) possible abuse of say __visible_for_testing
>
> I really don't like the idea of littering the kernel with these. It'll

Yeah, I kind of hope that it would make people think more
intentionally about what is a public interface so that they wouldn't
litter the kernel with those. But I agree that in the world where
people *didn't* do that. Lots of these sprinkled around would be
annoying.

> also require chunks in header files wrapped in #ifdefs. This is really

Why would it require header files wrapped in #ifdefs?

We could put all the ifdeffery logic in the __visible_for_testing
macro so that nothing in the original code has to change except for
adding an #include and replacing a couple of `static`s with
`__visible_for_testing`.

> ugly.
>
> >   b) you typically only want to test your public interfaces
>
> True, but being able to test the little helper functions is a nice
> starting point and a good building block.

Yeah, I think I have come to accept that. We can argue about how this
should change and how people need to learn to be more intentional
about which interfaces are public and many other high minded ideas,
but when it comes down to it, we need to provide a starting point that
is easy.

If our nice starting point becomes a problem, we can always improve it later.

> Why can't unit tests live with the code they're testing? They're already
> logically tied together; what's the harm there? This needn't be the case
> for ALL tests, etc. The test driver could still live externally. The
> test in the other .c would just have exported functions... ?

Well, for one, it totally tanks certain cases for building KUnit tests
as modules. I don't care about this point *too* much personally, but I
accept that there are others that want this, and I don't want to make
these people's lives too difficult.

The main reason I care, however, is just that I think it looks bad to
me. The file that these tests were in was already pretty long, and the
tests made it even longer. So that makes the tests harder to find. If
all tests are in a *-test.c file, then it becomes really easy to find
all of your tests. Admittedly, this is a pretty minor point. Honestly,
the main reason it looks bad to me, is because it is different from
what I am used to, which, I know, is not a great reason.
