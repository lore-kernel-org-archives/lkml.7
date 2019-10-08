Return-Path: <SRS0=XKeO=YB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1A94FC4360C
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Oct 2019 18:15:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EE0DC21721
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Oct 2019 18:15:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="kwoc3wm2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728462AbfJHSPT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 8 Oct 2019 14:15:19 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:38837 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726384AbfJHSPT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Oct 2019 14:15:19 -0400
Received: by mail-pg1-f193.google.com with SMTP id x10so10705494pgi.5
        for <linux-kernel@vger.kernel.org>; Tue, 08 Oct 2019 11:15:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=LZNljN/AkdZhmtnZA8uLQ3poagOBASW7ZSNDsz+/4TI=;
        b=kwoc3wm2rR3CIvUhtdBdlhmWm/YevOQgX/fD++B9Iejzidcl2fLkhoXtCuWqKWjo+S
         etvhAve6tI2G+/U4buEu4yBSn3NIaEdAQ6/qvHF6ACUEeg/y29D4conmgY4TJt7WSRN4
         PInLB3D9DEiqS2yAkJkKAn4CjlIW7sxlBqDBE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=LZNljN/AkdZhmtnZA8uLQ3poagOBASW7ZSNDsz+/4TI=;
        b=oYjkFQdNA1Yndka5hc2ThS1vs1hfhkUGtvYgjnXfTntWaTVveS0O1TwT3PzkNnsY6k
         P7BeQcZQcL5rrZv1b5d7eUylt4jTYpC1euvxciFTqf0ghlvVUJFJHRVRbxAXbvKEtIbD
         aNcc32HstoH8j0EpdSUI10RK9FAH/vqNITgYUj5S41hdyR/fbg/LMU2gEytYVL5H3E6j
         DDYKrL7LXU/B9NK0Rs9NTHxV8UWIhGYkSjhR26YyLcroUipnCg2ZDRHx8H+IracwfaoY
         /hR6XF36kNzbBeICrKGrEQZpyEjHBQ0/7PVS+mzyDPJ9withYWwghrJ9ZAPLQJspkStS
         7cwg==
X-Gm-Message-State: APjAAAUIlfMVB5sf10/hSA6d9KDyujKioOWkCrpgYCzXDhidavEKghmc
        ddCKm1kkKOHsEg80GowK9W2F0g==
X-Google-Smtp-Source: APXvYqzYjnU+6t/eIHObkAKBvtTJwWuCd0pBBXRV6LW14MPtb06wVjGqmQ3hz203J6/CQf9wDdhylQ==
X-Received: by 2002:a17:90a:1150:: with SMTP id d16mr7594707pje.2.1570558516852;
        Tue, 08 Oct 2019 11:15:16 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id p189sm20549336pfp.163.2019.10.08.11.15.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Oct 2019 11:15:15 -0700 (PDT)
Date:   Tue, 8 Oct 2019 11:15:14 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Brendan Higgins <brendanhiggins@google.com>
Cc:     David Gow <davidgow@google.com>, shuah@kernel.org,
        akpm@linux-foundation.org, linux-kselftest@vger.kernel.org,
        kunit-dev@googlegroups.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] lib/list-test: add a test for the 'list' doubly linked
 list
Message-ID: <201910081110.C2C582408F@keescook>
References: <20191007213633.92565-1-davidgow@google.com>
 <20191008174837.GA155928@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191008174837.GA155928@google.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 08, 2019 at 10:48:37AM -0700, Brendan Higgins wrote:
> On Mon, Oct 07, 2019 at 02:36:33PM -0700, David Gow wrote:
> > This change adds a KUnit test for the kernel doubly linked list
> > implementation in include/linux/list.h
> > 
> > Note that, at present, it only tests the list_ types (not the
> > singly-linked hlist_), and does not yet test all of the
> > list_for_each_entry* macros (and some related things like
> > list_prepare_entry).
> > 
> > This change depends on KUnit, so should be merged via the 'test' branch:
> > https://git.kernel.org/pub/scm/linux/kernel/git/shuah/linux-kselftest.git/log/?h=test
> > 
> > Signed-off-by: David Gow <davidgow@google.com>
> > ---
> >  lib/Kconfig.debug |  12 +
> >  lib/Makefile      |   3 +
> >  lib/list-test.c   | 711 ++++++++++++++++++++++++++++++++++++++++++++++
> >  3 files changed, 726 insertions(+)
> >  create mode 100644 lib/list-test.c
> 
> Also, I think it might be good to make a MAINTAINERs entry for this
> test.

Another thought, though maybe this is already covered and I missed the
"best practices" notes on naming conventions.

As the "one-off" tests are already named "foo_test.c" it seems like
KUnit tests should be named distinctly. Should this be lib/kunit-list.c,
lib/list-kunit.c, or something else?

For internal naming of structs and tests, should things be
named "kunit_foo"? Examples here would be kunit_list_struct and
kunit_list_test_...

When testing other stuff, should only exposed interfaces be tested?
Many things have their API exposed via registration of a static structure
of function pointers to static functions. What's the proposed best way
to get at that? Should the KUnit tests is IN the .c file that declares
all the static functions?

-- 
Kees Cook
