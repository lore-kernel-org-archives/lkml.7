Return-Path: <SRS0=fWiu=Y6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3809C5DF60
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Nov 2019 00:37:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5F2B22178F
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Nov 2019 00:37:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="H9CHqqLs"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730593AbfKFAh3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 Nov 2019 19:37:29 -0500
Received: from mail-pf1-f195.google.com ([209.85.210.195]:43758 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727046AbfKFAh3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Nov 2019 19:37:29 -0500
Received: by mail-pf1-f195.google.com with SMTP id 3so17422576pfb.10
        for <linux-kernel@vger.kernel.org>; Tue, 05 Nov 2019 16:37:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=+xOEbfGEe8GuKsDuMH9MLXg4toOcxPN6sItuj2bk3/c=;
        b=H9CHqqLsNjXKwjTR8C18iAyH8mYJcqKTJzTxrYbrX9XeucuHFy1MhMkr1qLwUynZoI
         /J/8lr1Tt6Tc60wRlH3f0rCQ+RCSquDh718fEM32Pnwo3rLKeuHLnu9yJmM44VRCWzAL
         fq9Bt+WdnoeV5CUpdKzZdWbZmt41FnpeY8GYZ5DJ2H/cxEiSxhW2f46kx44APEOsPs2N
         4F351UJo2YxVOgozWPeqoavVc5HMRYeB51yXeKoXhAF9CtkVszv/lcexWJwkh/wJIpcR
         4dIAA7zDub0oVR8BKH2l7GEwSt6EPBaBMMM13ETRjrqv2629QX/kFGMEOst2UaazKjlf
         E0Mg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=+xOEbfGEe8GuKsDuMH9MLXg4toOcxPN6sItuj2bk3/c=;
        b=LioZQT1mkTakWdyVxqPzq/GwBF9yngsybV1nE3Vhc+1hi3DDKDsX7rVprfy5Nd5GIu
         Eo7oelYZHhWZDWUwybt2/5fXO3rhtE58I0yk1A9yZ+YUMgh+9MSL5/9FIl5L+mCBGozi
         iEfegazYfE0UByYqzYYC2LtQ8XSG3oMn00MkBbbk70i20XVMgfPioKuIs76xmt3FGhlX
         vjO8KiDxcF+9P1FOav0o53ftdltI+ye3SFnVef4GoIHQTcFToAE4eg+OpKiGl248KMJE
         SWDuLX//uMw3+A5DSlDlOcz1GoBvpn0pozyrbyse8BftrblPDULLYuH75UOI+suNA5cD
         WxbA==
X-Gm-Message-State: APjAAAVkbaPaqI6lSEREvSCMY22r1WZw+ZBP88Uk73+7ED6fqgGiTTqX
        kSImOOaJeZf7QYB/Sk2aasUcTA1HP3cQ33oLgPKmbQ==
X-Google-Smtp-Source: APXvYqxcqWQVNbu/TYt0V5Wacgq4WEbsEc01rhn+cjVcvFFuB1FXuC8UVbgZanjPIa7uEEjhDRGZx0tXaQhiyBI1m6k=
X-Received: by 2002:a17:90a:252d:: with SMTP id j42mr18353pje.131.1573000647922;
 Tue, 05 Nov 2019 16:37:27 -0800 (PST)
MIME-Version: 1.0
References: <20191018001816.94460-1-brendanhiggins@google.com>
 <CAAXuY3rLEt9nqOBSNaWjLMHNg6pDHdjtg7hFiYx-KCDhyfnkcg@mail.gmail.com>
 <201910301157.58D0CE4D3@keescook> <CAFd5g47gfEJqRUW1PR1rtgrzekwLVqRRw0iJ4EVRW4xzUiW2Yw@mail.gmail.com>
In-Reply-To: <CAFd5g47gfEJqRUW1PR1rtgrzekwLVqRRw0iJ4EVRW4xzUiW2Yw@mail.gmail.com>
From:   Brendan Higgins <brendanhiggins@google.com>
Date:   Tue, 5 Nov 2019 16:37:16 -0800
Message-ID: <CAFd5g47Qn7ESPLvm9t_ifGPhjJ9dXgV9KVObg64bN3UNnoQPdA@mail.gmail.com>
Subject: Re: [PATCH linux-kselftest/test v1] apparmor: add AppArmor KUnit
 tests for policy unpack
To:     Kees Cook <keescook@chromium.org>
Cc:     Iurii Zaikin <yzaikin@google.com>, shuah <shuah@kernel.org>,
        John Johansen <john.johansen@canonical.com>, jmorris@namei.org,
        serge@hallyn.com, Alan Maguire <alan.maguire@oracle.com>,
        David Gow <davidgow@google.com>,
        Luis Chamberlain <mcgrof@kernel.org>,
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

On Tue, Nov 5, 2019 at 4:35 PM Brendan Higgins
<brendanhiggins@google.com> wrote:
>
> On Wed, Oct 30, 2019 at 11:59 AM Kees Cook <keescook@chromium.org> wrote:
> >
> > On Thu, Oct 17, 2019 at 05:33:56PM -0700, Iurii Zaikin wrote:
> > > On Thu, Oct 17, 2019 at 5:19 PM Brendan Higgins
> > > <brendanhiggins@google.com> wrote:
> > >
> > > > +config SECURITY_APPARMOR_TEST
> > > > +       bool "Build KUnit tests for policy_unpack.c"
> > > > +       default n
> >
> > New options already already default n, this can be left off.
> >
> > > > +       depends on KUNIT && SECURITY_APPARMOR
> > > > +       help
> > > >
> > > select SECURITY_APPARMOR ?
> >
> > "select" doesn't enforce dependencies, so just a "depends ..." is
> > correct.
> >
> > > > +       KUNIT_EXPECT_EQ(test, size, TEST_BLOB_DATA_SIZE);
> > > > +       KUNIT_EXPECT_TRUE(test,
> > > > +               memcmp(blob, TEST_BLOB_DATA, TEST_BLOB_DATA_SIZE) == 0);
> > > I think this must be  KUNIT_ASSERT_EQ(test, size, TEST_BLOB_DATA_SIZE);,
> > > otherwise there could be a buffer overflow in memcmp. All tests that
> > > follow such pattern
> >
> > Agreed.
> >
> > > are suspect. Also, not sure about your stylistic preference for
> > > KUNIT_EXPECT_TRUE(test,
> > >                memcmp(blob, TEST_BLOB_DATA, TEST_BLOB_DATA_SIZE) == 0);
> > > vs
> > > KUNIT_EXPECT_EQ(test,
> > >                0,
> > >                memcmp(blob, TEST_BLOB_DATA, TEST_BLOB_DATA_SIZE));
> >
> > I like == 0.
>
> Oh, I almost missed this. I think the *_EQ(...) is better than the
> *_TRUE(...) because the EQ is able to provide more debug information
> if the test fails (otherwise there would really be no point in
> providing all these variants).
>
> Any objections?
>
> Thanks for the catch Iurii!

Wait, nevermind.

Either way is fine because memcmp probably won't show terribly
interesting information in the non-zero case. I'll just leave it the
way Mike wrote it.

Sorry!
