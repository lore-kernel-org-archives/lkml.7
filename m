Return-Path: <SRS0=UImc=ZL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A523C432C3
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Nov 2019 18:36:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0732722318
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Nov 2019 18:36:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="vVGW3EfT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727357AbfKSSg3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Nov 2019 13:36:29 -0500
Received: from mail-pj1-f65.google.com ([209.85.216.65]:44160 "EHLO
        mail-pj1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726510AbfKSSg2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Nov 2019 13:36:28 -0500
Received: by mail-pj1-f65.google.com with SMTP id w8so2957000pjh.11
        for <linux-kernel@vger.kernel.org>; Tue, 19 Nov 2019 10:36:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=cqd1PZl4Bd7PEGTyuVkaWzR8dbBXh+gC15PgfLfD0Zw=;
        b=vVGW3EfTq7IwmL6p+BTaKa+qb54m/uF752AGPg8O3AB19vr2fJ/XiITO6xRm37/htM
         wgspP/qnrZ1knIUwpY9LkcSAxvEW7iwhMFr5lE+KUXiSfqUzYWgLg9s2yaZu0etKbwbl
         4vPlCLufd/3gzStPsWsGMNY7I1o6en96LUpHN/Y0QlKwMSABDJk/uQmFIVMjQ0F1eiNk
         1DXuJ4+1FQK3UILFjofyOz+sf4XqFrOkSyZVopEKE/90f1tx+zZBAwopmSMT6fJUCUmt
         iuodJG/jzNR98u9s3lij09Ql46xDCZn8QZ5zpDUnSXzbMtU9uA7PJrsByrH5UVZbeSrQ
         FI0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=cqd1PZl4Bd7PEGTyuVkaWzR8dbBXh+gC15PgfLfD0Zw=;
        b=m9cp4NLdydUEIQsuSmH6E+k9mOQC/a29hd8JBcEhIPGeH7UxQ9WpDESoolHiNHEmv1
         o6CLgvL97FQi25LPxzdj1CfSfUB0dp3pYMN/b4HkMlV6Uim9WY3lClRonserVGmlOtbc
         BqWzAqYLqlOnpaay2Qb/otZfGnAaqAyf9YUmlMTeuev7x++bJyzpNsmvpvIH5/nDmnv5
         iNFAeqHOO6Ibvf7kGB5hh14zfMXzTKU1g7LB/BYOjJwI1j7Prwot9921HgCee+LvGSrU
         g4xWwEJKGyPOtJn+lW/7pqZuwyW8b/zzCiGduNUagos7k1hneRdcj8+ywt+wrp7F/Wiq
         RoxQ==
X-Gm-Message-State: APjAAAWoOzcH3utDgkm1y4ipAx1d495Xc9Bod1jmHBVMISlnCPYznXEy
        4lZKenClsVbEWFDyul4XEMdZ4mRySrThCxel7ZAphQ==
X-Google-Smtp-Source: APXvYqwntEoFXFSkd8roeQK4Vfw0pBJCXkLH0R0JAgVf2MFOls4Cp8WPWrVjsoHG2ZZbgV3p9gNovSTX97zEa+suatw=
X-Received: by 2002:a17:90a:d155:: with SMTP id t21mr8032255pjw.84.1574188587517;
 Tue, 19 Nov 2019 10:36:27 -0800 (PST)
MIME-Version: 1.0
References: <1573812972-10529-1-git-send-email-alan.maguire@oracle.com>
 <1573812972-10529-2-git-send-email-alan.maguire@oracle.com> <20191117013336.F23F820730@mail.kernel.org>
In-Reply-To: <20191117013336.F23F820730@mail.kernel.org>
From:   Brendan Higgins <brendanhiggins@google.com>
Date:   Tue, 19 Nov 2019 10:36:15 -0800
Message-ID: <CAFd5g44115hPDMJNWPnyLZ_3zJMBzA+6MHxCLCA1ddkYipDtkA@mail.gmail.com>
Subject: Re: [PATCH v4 linux-kselftest-test 1/6] kunit: move string-stream.h
 to lib/kunit
To:     Stephen Boyd <sboyd@kernel.org>
Cc:     Alan Maguire <alan.maguire@oracle.com>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>,
        Shuah Khan <skhan@linuxfoundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        KUnit Development <kunit-dev@googlegroups.com>,
        Kees Cook <keescook@chromium.org>,
        Iurii Zaikin <yzaikin@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        catalin.marinas@arm.com, joe.lawrence@redhat.com,
        penguin-kernel@i-love.sakura.ne.jp, schowdary@nvidia.com,
        urezki@gmail.com, andriy.shevchenko@linux.intel.com,
        Jonathan Corbet <corbet@lwn.net>,
        "Theodore Ts'o" <tytso@mit.edu>, adilger.kernel@dilger.ca,
        Luis Chamberlain <mcgrof@kernel.org>, changbin.du@intel.com,
        linux-ext4@vger.kernel.org,
        "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
        Knut Omang <knut.omang@oracle.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Nov 16, 2019 at 5:33 PM Stephen Boyd <sboyd@kernel.org> wrote:
>
> Quoting Alan Maguire (2019-11-15 02:16:07)
> > string-stream interfaces are not intended for external use;
> > move them from include/kunit to lib/kunit accordingly.
> >
> > Signed-off-by: Alan Maguire <alan.maguire@oracle.com>
> > Signed-off-by: Knut Omang <knut.omang@oracle.com>
>
> The sign off chain is incorrect here. Is Knut tag supposed to be
> Co-developed-by?

I am not sure what the relationship between Alan and Knut on this
patch. Nevertheless, Signed-off-by is required either way, but it
seems that Co-developed-by is optional depending on how Alan and Knut
would like to share credit for this patch, at least that is based on
my reading of the submitting patches guide:

https://www.kernel.org/doc/html/latest/process/submitting-patches.html#when-to-use-acked-by-cc-and-co-developed-by

> > diff --git a/include/kunit/assert.h b/include/kunit/assert.h
> > index db6a0fc..ad889b5 100644
> > --- a/include/kunit/assert.h
> > +++ b/include/kunit/assert.h
> > @@ -9,10 +9,11 @@
> >  #ifndef _KUNIT_ASSERT_H
> >  #define _KUNIT_ASSERT_H
> >
> > -#include <kunit/string-stream.h>
> >  #include <linux/err.h>
> > +#include <linux/kernel.h>
>
> Why is this included now?

Nice catch! I think I would have missed that.

> >
> >  struct kunit;
> > +struct string_stream;
> >
> >  /**
> >   * enum kunit_assert_type - Type of expectation/assertion.

Cheers!
