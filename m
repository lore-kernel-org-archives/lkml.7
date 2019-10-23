Return-Path: <SRS0=OaAC=YQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0881CA9EB9
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Oct 2019 21:26:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A66BB2084C
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Oct 2019 21:26:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="oxa7Yq/p"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392343AbfJWV0C (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 23 Oct 2019 17:26:02 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:45153 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2392252AbfJWV0C (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Oct 2019 17:26:02 -0400
Received: by mail-pf1-f196.google.com with SMTP id x28so241773pfi.12
        for <linux-kernel@vger.kernel.org>; Wed, 23 Oct 2019 14:26:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=rv4Nqh5d+/cF2RpTBWJWh8crG9DJ9LN8rUEiLCVkDCI=;
        b=oxa7Yq/pKC6Rtd8OTFkXDgv+sg58exGMNevQgY3cd/UoqcmGNae53c+vJ/Gv3HMIDe
         1InEbVJhTKBH1sdxN5bLgjnNQnl4tnly+ZsYiPj+aTVPQ/ilgn3tCucka8j02OQpoMOh
         VBXes1Krr5ikefRmE0ryyaFKvRch5oAe274i6gFt3LgvAo6HN7DvKw9VsP85ADeX83oi
         rYGxAHbLzViqTLFA9btg/bC/cwBeo3cATsyFEwMvrFgHAhfdJd/u+tZjLqcl7uDWIJ3W
         ZQbJARrMZozIZVsGBfy40SIYNTP9S7OBcEa7ipxSKyYkngWATCFBqYQg7qcgzNT6/jjH
         d90A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=rv4Nqh5d+/cF2RpTBWJWh8crG9DJ9LN8rUEiLCVkDCI=;
        b=k/EDMt+q6SYLsMz9+OaaKoKht7v1dZvEyJubw5dMyUxMLfuXWbzvRPNiKvw5mB38yl
         z5Gc3PWBwfeBPHLRHui7P2P4pYEF1S43VM2mKdDFFFcLejkUk+/e5QJMs0fEPDZbAupl
         CZOO8qox8G/XtatCDao1W7HqHYzkftlOngMZaH0HJTja6po28Mc8ej5WaH4kx/v3aA3O
         27VRfVSDmA6xtW6QxJNJ5Bsjqt5BJpad5bUrljYzWIIlGTRvoMCVUJA01Wfed5J+2eYS
         3icGb9wfk5XPHiBcV1Uri9FVpCfk49QgnnshmEBnhR+f1CwQW3ZdRV+UuB/2mhx/0F6o
         gNTg==
X-Gm-Message-State: APjAAAVQtE0VojnEJDI7nMblI5ehEFDYKFIFHbKR7FJ1k9WW6vaUuD9x
        jzhEyLheeP/+ODpK3Fd6/cul8GXSWzyrjSCekRHtVA==
X-Google-Smtp-Source: APXvYqxtwcSKP3dxNcBOousSaiPma55QN+uHm54W5IwsX3gK7duaFgAkFXHm+eMI1oaF/mQ8CtDYgxMTVBxaFGpzq8w=
X-Received: by 2002:a62:61c4:: with SMTP id v187mr13349382pfb.23.1571865960644;
 Wed, 23 Oct 2019 14:26:00 -0700 (PDT)
MIME-Version: 1.0
References: <20191018215549.65000-1-davidgow@google.com> <20191019082731.GM21344@kadam>
 <CABVgOSkegmhmeRa=7Qcx3MnX88wLy9qZx97CMhk4NvWb-pgpYQ@mail.gmail.com>
In-Reply-To: <CABVgOSkegmhmeRa=7Qcx3MnX88wLy9qZx97CMhk4NvWb-pgpYQ@mail.gmail.com>
From:   Brendan Higgins <brendanhiggins@google.com>
Date:   Wed, 23 Oct 2019 14:25:49 -0700
Message-ID: <CAFd5g46BuY02M_QBD3PVFnbsvO7fuuS+ZOBmfFBmmGy3xSMXbQ@mail.gmail.com>
Subject: Re: [PATCH linux-kselftest/test v4] lib/list-test: add a test for the
 'list' doubly linked list
To:     David Gow <davidgow@google.com>
Cc:     Dan Carpenter <dan.carpenter@oracle.com>,
        Shuah Khan <shuah@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Kees Cook <keescook@chromium.org>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>,
        KUnit Development <kunit-dev@googlegroups.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 22, 2019 at 3:13 PM David Gow <davidgow@google.com> wrote:
>
> On Sat, Oct 19, 2019 at 1:27 AM Dan Carpenter <dan.carpenter@oracle.com> wrote:
> >
> > On Fri, Oct 18, 2019 at 02:55:49PM -0700, David Gow wrote:
> > > +     list4 = kzalloc(sizeof(*list4), GFP_KERNEL);
> > > +     KUNIT_ASSERT_NOT_ERR_OR_NULL(test, list4);
> >
> > Why not just use GFP_KERNEL | GFP_NOFAIL and remove the check?
>
> I've sent a new version of the patch out (v5) which uses __GFP_NOFAIL instead.
>
> The idea had been to exercise KUnit's assertion functionality, in the
> hope that it'd allow the test to fail (but potentially allow other
> tests to still run) in the case of allocation failure. Given that
> we're only allocating enough to store ~4 pointers in total, though,
> that's probably of little use.
>
> > kzalloc() can't return error pointers.  If this were an IS_ERR_OR_NULL()
> > check then it would generate a static checker warning, but static
> > checkers don't know about KUNIT_ASSERT_NOT_ERR_OR_NULL() yet so you're
> > safe.
>
> Alas, KUnit doesn't have a KUNIT_ASSERT_NOT_NULL() macro, and I'd
> assumed it was not dangerous (even if not ideal) to check for error
> pointers, even if kzalloc() can't return them.

Maybe it would be good for us (not in this case, just generally
speaking) to add a KUNIT_ASSERT_NOT_NULL() and friends?

> Perhaps it'd make sense to add a convenient way of checking the
> NULL-ness of pointers to KUnit (it's possible with the
> KUNIT_ASSERT_PTR_EQ(), but requires a bit of casting to make the type
> checker happy) in the future. Once KUnit is properly upstream, it may
> be worth teaching the static analysis tools about these functions to
> avoid having warnings in these sorts of tests.
>
> For now, though, (and for this test in particular), I agree with the
> suggestion of just using __GFP_NOFAIL.
>
> Thanks a lot for the comments,
> -- David
