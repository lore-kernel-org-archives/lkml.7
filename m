Return-Path: <SRS0=UImc=ZL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.3 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 199CFC432C0
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Nov 2019 00:35:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D293F22316
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Nov 2019 00:35:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="cpQP7haZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727171AbfKSAfH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Nov 2019 19:35:07 -0500
Received: from mail-pl1-f193.google.com ([209.85.214.193]:32977 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726952AbfKSAfH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Nov 2019 19:35:07 -0500
Received: by mail-pl1-f193.google.com with SMTP id ay6so10738742plb.0
        for <linux-kernel@vger.kernel.org>; Mon, 18 Nov 2019 16:35:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=KDjD6wRu08/3eOf5MmI1OKuUS2ePOxx6myNS0OClZW8=;
        b=cpQP7haZ+qnxm49l1kiO3rneGBNvdafMNXYylZOqZtyhHZ0UQBk1UvGioO2Tm4UKfU
         bVxFYceBpiVXNyY+0FP9js/obi0/U1euVPU2zBXCqdIkU2CwzXvjScc7mS06age6cBeu
         RZDjkIOxguq7TDOaRrrHOb0T4eVi0Q/lq7ssL6GCHIHr0kJ23QzzeKVaeyue3EQU33ix
         LZO1ilWg0c1pw46cl07rclj1NJyng7cjT7w7rVpQXLJIvs9UgabUGWKCiiYEdAUPIax1
         8HWULHCUaEw29Ry6bYakMq5jC2UvpyvmjTLa/PtHrRJVVPgtIaTC98wJGbS8TjyKLLlj
         3WHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=KDjD6wRu08/3eOf5MmI1OKuUS2ePOxx6myNS0OClZW8=;
        b=J82AFrclG3cJgpZGHrLNHAYAckFGTMTlHKfbAgI6Zwqb3YaiiA7Lr8B4ntBTol3Sf7
         R666VPIG6XgtA2gj5pJd1g9Jm3MUF6n6md8r+vgTgapxcOTIaq/EZpEbfkExzI7nNix4
         glZCM8wOP4E9cwIzDu4LPeEzNIfVabY4/NGx6L9hJuAHjHsA0NvLwTFLVACntKVAwLeE
         Y67Jjll1CTabsqnY+UYoDf/klgqv1IjjSWny86BpRLYb05/KwD/IbGN+h7E5IVz3Hyfp
         GMbZicuQd2Zd1/W7x1fWoRU0uWeaF6HspQMdTGKwL+aWD1pQMTHQ8HZkG0o6HfuajlxV
         NnHQ==
X-Gm-Message-State: APjAAAW4Zrva7JQkIOXoO7OgZAdMseQNcuE80jfWagAFFlbP6cYknvsK
        AawyN6WIf7RUmJYIyMvzuSnU3MqMZutKg+c/20GAYg==
X-Google-Smtp-Source: APXvYqzisxXdX2gUjgmZ6VXkODOtflaLP8heK8Rw+lwEa0j3nLTrZNJKQNDvqDFnnE1Owdv6Fid84PeLGqzly0vXJ2A=
X-Received: by 2002:a17:90a:d155:: with SMTP id t21mr2326831pjw.84.1574123705397;
 Mon, 18 Nov 2019 16:35:05 -0800 (PST)
MIME-Version: 1.0
References: <20191106004329.16991-1-brendanhiggins@google.com>
 <201911060916.AC9E14B@keescook> <20191107233337.GA191231@google.com>
In-Reply-To: <20191107233337.GA191231@google.com>
From:   Brendan Higgins <brendanhiggins@google.com>
Date:   Mon, 18 Nov 2019 16:34:53 -0800
Message-ID: <CAFd5g462jFnbPxA2Nvc_3W064kZ8t5oHNE4M_3yt84+NuoiHGQ@mail.gmail.com>
Subject: Re: [PATCH linux-kselftest/test v2] apparmor: add AppArmor KUnit
 tests for policy unpack
To:     Kees Cook <keescook@chromium.org>
Cc:     shuah <shuah@kernel.org>,
        John Johansen <john.johansen@canonical.com>, jmorris@namei.org,
        serge@hallyn.com, Alan Maguire <alan.maguire@oracle.com>,
        Iurii Zaikin <yzaikin@google.com>,
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

On Thu, Nov 7, 2019 at 3:33 PM Brendan Higgins
<brendanhiggins@google.com> wrote:
>
> On Wed, Nov 06, 2019 at 09:18:27AM -0800, Kees Cook wrote:
> > On Tue, Nov 05, 2019 at 04:43:29PM -0800, Brendan Higgins wrote:
> > > From: Mike Salvatore <mike.salvatore@canonical.com>
> > >
> > > Add KUnit tests to test AppArmor unpacking of userspace policies.
> > > AppArmor uses a serialized binary format for loading policies. To find
> > > policy format documentation see
> > > Documentation/admin-guide/LSM/apparmor.rst.
> > >
> > > In order to write the tests against the policy unpacking code, some
> > > static functions needed to be exposed for testing purposes. One of the
> > > goals of this patch is to establish a pattern for which testing these
> > > kinds of functions should be done in the future.
> > >
> > > Signed-off-by: Brendan Higgins <brendanhiggins@google.com>
> > > Signed-off-by: Mike Salvatore <mike.salvatore@canonical.com>
> > > ---
> > >  security/apparmor/Kconfig              |  16 +
> > >  security/apparmor/policy_unpack.c      |   4 +
> > >  security/apparmor/policy_unpack_test.c | 607 +++++++++++++++++++++++++
> > >  3 files changed, 627 insertions(+)
> > >  create mode 100644 security/apparmor/policy_unpack_test.c
> > >
> > > diff --git a/security/apparmor/Kconfig b/security/apparmor/Kconfig
> > > index d8b1a360a6368..78a33ccac2574 100644
> > > --- a/security/apparmor/Kconfig
> > > +++ b/security/apparmor/Kconfig
> > > @@ -66,3 +66,19 @@ config SECURITY_APPARMOR_DEBUG_MESSAGES
> > >       Set the default value of the apparmor.debug kernel parameter.
> > >       When enabled, various debug messages will be logged to
> > >       the kernel message buffer.
> > > +
> > > +config SECURITY_APPARMOR_KUNIT_TEST
> > > +   bool "Build KUnit tests for policy_unpack.c"
> > > +   depends on KUNIT && SECURITY_APPARMOR
> > > +   help
> > > +     This builds the AppArmor KUnit tests.
> > > +
> > > +     KUnit tests run during boot and output the results to the debug log
> > > +     in TAP format (http://testanything.org/). Only useful for kernel devs
> > > +     running KUnit test harness and are not for inclusion into a
> > > +     production build.
> > > +
> > > +     For more information on KUnit and unit tests in general please refer
> > > +     to the KUnit documentation in Documentation/dev-tools/kunit/.
> > > +
> > > +     If unsure, say N.
> > > diff --git a/security/apparmor/policy_unpack.c b/security/apparmor/policy_unpack.c
> > > index 8cfc9493eefc7..37c1dd3178fc0 100644
> > > --- a/security/apparmor/policy_unpack.c
> > > +++ b/security/apparmor/policy_unpack.c
> > > @@ -1120,3 +1120,7 @@ int aa_unpack(struct aa_loaddata *udata, struct list_head *lh,
> > >
> > >     return error;
> > >  }
> > > +
> > > +#ifdef CONFIG_SECURITY_APPARMOR_KUNIT_TEST
> > > +#include "policy_unpack_test.c"
> > > +#endif /* CONFIG_SECURITY_APPARMOR_KUNIT_TEST */
> >
> > To make this even LESS intrusive, the ifdefs could live in ..._test.c.
>
> Less intrusive, yes, but I think I actually like the ifdef here; it
> makes it clear from the source that the test is only a part of the build
> when configured to do so. Nevertheless, I will change it if anyone feels
> strongly about it.
>
> > Also, while I *think* the kernel build system will correctly track this
> > dependency, can you double-check that changes to ..._test.c correctly
> > trigger a recompile of policy_unpack.c?
>
> Yep, just verified, first I ran the tests and everything passed. Then I
> applied the following diff:
>
> diff --git a/security/apparmor/policy_unpack_test.c b/security/apparmor/policy_unpack_test.c
> index 533137f45361c..e1b0670dbdc27 100644
> --- a/security/apparmor/policy_unpack_test.c
> +++ b/security/apparmor/policy_unpack_test.c
> @@ -161,7 +161,7 @@ static void policy_unpack_test_unpack_array_with_name(struct kunit *test)
>
>         array_size = unpack_array(puf->e, name);
>
> -       KUNIT_EXPECT_EQ(test, array_size, (u16)TEST_ARRAY_SIZE);
> +       KUNIT_EXPECT_EQ(test, array_size + 1, (u16)TEST_ARRAY_SIZE);
>         KUNIT_EXPECT_PTR_EQ(test, puf->e->pos,
>                 puf->e->start + TEST_ARRAY_BUF_OFFSET + sizeof(u16) + 1);
>  }
>
> and reran the tests (to trigger an incremental build) and the test
> failed as expected indicating that the dependency is properly tracked.

Hey Kees,

Since it looks like you already took a pretty close look at this,
would you mind giving me a review?

Thanks!
