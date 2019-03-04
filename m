Return-Path: <SRS0=91bA=RH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EDFE6C43381
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Mar 2019 23:02:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BD94920835
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Mar 2019 23:02:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="fectyLr4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726643AbfCDXCI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 Mar 2019 18:02:08 -0500
Received: from mail-ot1-f67.google.com ([209.85.210.67]:42999 "EHLO
        mail-ot1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726095AbfCDXCI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Mar 2019 18:02:08 -0500
Received: by mail-ot1-f67.google.com with SMTP id i5so5743723oto.9
        for <linux-kernel@vger.kernel.org>; Mon, 04 Mar 2019 15:02:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=38oyutlsQ5kexa/+WoHvvQ0F1ScYRkzlE3zqMhCY8j0=;
        b=fectyLr4ji+lZzoSd5s2XiSOhpWmzcElGHNhfEqvtJcmjlA9E0GIjPl+tUEEVwXCuF
         8i+uo5RvZBf4Dv1AAs4Inuv8TmGuSBjG5TpP7xF3aiohut6AxNNN+xHgk/4NkNKAZVly
         e2Y5tm0nDc9b7ow3UD1mQNDSV0Z9PizBvijjxqDMmfbl5obEmcA8hO3UIrUhHcMjPY29
         JaNJTgbRg+cdDAqR6lRxVCS1yJ51TW+um02GQZG2c99ZQSoaFy+ifhaY7Gnae0XU1uO7
         O3Da1j+OTHRmBOQ6mej1JbnzuyWTBP0Zb2Di46xMsu0seGxhLnknamE0u7Amp/hwN9aE
         KwqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=38oyutlsQ5kexa/+WoHvvQ0F1ScYRkzlE3zqMhCY8j0=;
        b=cvYDvrvY0c8qfbURUTH8FAt7nXqor4kVhDd7XILxUwf9xpIj9GqnhYknSPHTZWL9TE
         iooKxJzC37glQnxcUpHqSkBVZsPbprnYnM41Ibulx5jzOkrbyuVuG2g50aaymE9QC7at
         0sgtxFAdDYJWT/a89tFnIBGRPLNApMje4By338b2oLu5QVZAyHZaZfIwKgTSda+e4Aji
         3Y/G3lcRAse6wOhr2b2ZJeOz1nisXV8a3LVO7/bDEXRjqH6BEE/6tD5GNYN8nTjdIphl
         dcN0SiyjobGk5VISP55EqUnLam6ooTFOyhLWLZrmpZRQKBCyj+Pb4vq8g6FRECqJ4dFZ
         rfLg==
X-Gm-Message-State: APjAAAUgFryr+vIEaGxsbSeznaF4VhT8T0/GYVMNZucXcjaOPdrX6coh
        MmcONK3EbzrjEJY6GMpqAQ4hLgDx4Tb2xFwEmrS+Ug==
X-Google-Smtp-Source: APXvYqxtvHcYYx3sduLRjGFIdMbee+kv2QSFcXxnuE3/iosMVekdFail/TQlSeG2CxXGonIoEwZrrvxAmGEIV19VOco=
X-Received: by 2002:a9d:7a87:: with SMTP id l7mr13492167otn.98.1551740526569;
 Mon, 04 Mar 2019 15:02:06 -0800 (PST)
MIME-Version: 1.0
References: <20190214213729.21702-1-brendanhiggins@google.com>
In-Reply-To: <20190214213729.21702-1-brendanhiggins@google.com>
From:   Brendan Higgins <brendanhiggins@google.com>
Date:   Mon, 4 Mar 2019 15:01:55 -0800
Message-ID: <CAFd5g45F3YUsAjse+Vt5hj5CLjaXrRWgr5zCZZ6CJKc0hboP6Q@mail.gmail.com>
Subject: Re: [RFC v4 00/17] kunit: introduce KUnit, the Linux kernel unit
 testing framework
To:     Kees Cook <keescook@google.com>,
        Luis Chamberlain <mcgrof@kernel.org>, shuah@kernel.org,
        Rob Herring <robh@kernel.org>,
        Kieran Bingham <kieran.bingham@ideasonboard.com>,
        Frank Rowand <frowand.list@gmail.com>
Cc:     Greg KH <gregkh@linuxfoundation.org>,
        Joel Stanley <joel@jms.id.au>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Joe Perches <joe@perches.com>, brakmo@fb.com,
        Steven Rostedt <rostedt@goodmis.org>,
        "Bird, Timothy" <Tim.Bird@sony.com>,
        Kevin Hilman <khilman@baylibre.com>,
        Julia Lawall <julia.lawall@lip6.fr>,
        linux-kselftest@vger.kernel.org, kunit-dev@googlegroups.com,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Jeff Dike <jdike@addtoit.com>,
        Richard Weinberger <richard@nod.at>,
        linux-um@lists.infradead.org, Daniel Vetter <daniel@ffwll.ch>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        Dan Williams <dan.j.williams@intel.com>,
        linux-nvdimm <linux-nvdimm@lists.01.org>,
        Knut Omang <knut.omang@oracle.com>,
        devicetree <devicetree@vger.kernel.org>,
        Petr Mladek <pmladek@suse.com>,
        Sasha Levin <Alexander.Levin@microsoft.com>,
        Amir Goldstein <amir73il@gmail.com>,
        Dan Carpenter <dan.carpenter@oracle.com>, wfg@linux.intel.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 14, 2019 at 1:38 PM Brendan Higgins
<brendanhiggins@google.com> wrote:
>
> This patch set proposes KUnit, a lightweight unit testing and mocking
> framework for the Linux kernel.
>

<snip>

> ## More information on KUnit
>
> There is a bunch of documentation near the end of this patch set that
> describes how to use KUnit and best practices for writing unit tests.
> For convenience I am hosting the compiled docs here:
> https://google.github.io/kunit-docs/third_party/kernel/docs/
> Additionally for convenience, I have applied these patches to a branch:
> https://kunit.googlesource.com/linux/+/kunit/rfc/5.0-rc5/v4
> The repo may be cloned with:
> git clone https://kunit.googlesource.com/linux
> This patchset is on the kunit/rfc/5.0-rc5/v4 branch.
>
> ## Changes Since Last Version
>
>  - Got KUnit working on (hypothetically) all architectures (tested on
>    x86), as per Rob's (and other's) request
>  - Punting all KUnit features/patches depending on UML for now.
>  - Broke out UML specific support into arch/um/* as per "[RFC v3 01/19]
>    kunit: test: add KUnit test runner core", as requested by Luis.
>  - Added support to kunit_tool to allow it to build kernels in external
>    directories, as suggested by Kieran.
>  - Added a UML defconfig, and a config fragment for KUnit as suggested
>    by Kieran and Luis.
>  - Cleaned up, and reformatted a bunch of stuff.
>
> --
> 2.21.0.rc0.258.g878e2cd30e-goog
>

Someone suggested I should send the next revision out as "PATCH"
instead of "RFC" since there seems to be general consensus about
everything at a high level, with a couple exceptions.

At this time I am planning on sending the next revision out as "[PATCH
v1 00/NN] kunit: introduce KUnit, the Linux kernel unit testing
framework". Initially I wasn't sure if the next revision should be
"[PATCH v1 ...]" or "[PATCH v5 ...]". Please let me know if you have a
strong objection to the former.

In the next revision, I will be dropping the last two of three patches
for the DT unit tests as there doesn't seem to be enough features
currently available to justify the heavy refactoring I did; however, I
will still include the patch that just converts everything over to
KUnit without restructuring the test cases:
https://lkml.org/lkml/2019/2/14/1133

I should have the next revision out in a week or so.
