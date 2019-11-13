Return-Path: <SRS0=LLNM=ZF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.3 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_IN_DEF_DKIM_WL autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6A21CC43141
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Nov 2019 18:12:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 641BB206E1
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Nov 2019 18:12:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Fs57GyBC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728236AbfKMSMo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Nov 2019 13:12:44 -0500
Received: from mail-wm1-f66.google.com ([209.85.128.66]:54678 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727112AbfKMSMn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Nov 2019 13:12:43 -0500
Received: by mail-wm1-f66.google.com with SMTP id z26so3008859wmi.4
        for <linux-kernel@vger.kernel.org>; Wed, 13 Nov 2019 10:12:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ki25gnbpyN00Iv5cdTY8OhdgRYpiq6GuA0iUi2qS8JY=;
        b=Fs57GyBC4KqL9mwZ7pz4er+6yTwZnzeC3f6ecarogyGItcOt761IC74Ow/Fy4yemVK
         RUqp9/aQEupFLjbQgv1Is7jI9ME2ZM1Urs3WpBzkHiD8m8wVSpaj4qR2HT8NktQ9aIDh
         83PGyCiMELKFkPAAJ4oKSoHJYw+BxXeDVZHwA+/1F1FsDEdMj437l2T1zBZvMvvheHvL
         fdLJ8urtUQhsyRrrfXAVw/DhaY2VeUzbmsUBTotErPCNPW/7n17mK4ajJuqRCwV0CKYj
         W+Zp1BcViOgwN1fFLrhobVuOpXFZhmczbXyYlTzP7butXBzzN7km9hK2nXnGXCXaobqM
         5tig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ki25gnbpyN00Iv5cdTY8OhdgRYpiq6GuA0iUi2qS8JY=;
        b=eBxYaVGXFp0Ftm3d4pYWp0bOT/U9HuXD2cfbxWkJQbps0H/cRb8DlEnAP8xA/3tzPI
         0Dy9anAImnv88WHWmsOdxTFeFqN7d+sKxKCwwPpLKbBn1tZ+cq2vr8hPmI+Dx2ZTQ6bF
         p7hnXzyQSf7uYS0hcf2z+UDuvblypj/hl/KXeyYZZOiQzFFMOboC5w/EMuaOQO9vu937
         iVrNb/R1Ab+NM4NddSWCa3kdlaVQLDRphisit0/ywdQyiYv3EI7AHTsU2vDe30vth8ld
         goUFODpEl+Y5yk/q9DffW6V1JPAKpPKVxFbHVCapui7WtpQfbNbfl7EfCHHDfw8GLAJ4
         9WJg==
X-Gm-Message-State: APjAAAVhgEEH+V3UYBEkpyuB0QogffOolLlfDGsAcMdtNMFq7EFNRGPQ
        1R3L+CKuDA89EMnwlBTH1lsw3OiYCjREmFPxVkjggQ==
X-Google-Smtp-Source: APXvYqyS2MWVz9Gjs48JrwIYbsO/Nl6/uoy1ID+PXy7Cl0PgKvCG4CClUBfmff8XpKrw/24ncJDArH9Sw7hQb50yikE=
X-Received: by 2002:a05:600c:295:: with SMTP id 21mr3864373wmk.43.1573668760287;
 Wed, 13 Nov 2019 10:12:40 -0800 (PST)
MIME-Version: 1.0
References: <20191113012746.52804-1-brendanhiggins@google.com>
In-Reply-To: <20191113012746.52804-1-brendanhiggins@google.com>
From:   David Gow <davidgow@google.com>
Date:   Wed, 13 Nov 2019 10:12:28 -0800
Message-ID: <CABVgOS=3AXS1=rpGyNiNYu8hU+t=gQG9JongHXir=76ENnrnnA@mail.gmail.com>
Subject: Re: [PATCH linux-kselftest/test v1] Documentation: kunit: add
 documentation for kunit_tool
To:     Brendan Higgins <brendanhiggins@google.com>
Cc:     Shuah Khan <shuah@kernel.org>, kunit-dev@googlegroups.com,
        linux-kernel@vger.kernel.org,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>, linux-doc@vger.kernel.org,
        corbet@lwn.net, tytso@mit.edu
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 12, 2019 at 5:28 PM Brendan Higgins
<brendanhiggins@google.com> wrote:
>
> Add documentation for the Python script used to build, run, and collect
> results from the kernel known as kunit_tool. kunit_tool
> (tools/testing/kunit/kunit.py) was already added in previous commits.
>
> Signed-off-by: Brendan Higgins <brendanhiggins@google.com>
> ---
>  Documentation/dev-tools/kunit/index.rst      |  1 +
>  Documentation/dev-tools/kunit/kunit-tool.rst | 57 ++++++++++++++++++++
>  Documentation/dev-tools/kunit/start.rst      |  3 ++
>  3 files changed, 61 insertions(+)
>  create mode 100644 Documentation/dev-tools/kunit/kunit-tool.rst
>
> diff --git a/Documentation/dev-tools/kunit/index.rst b/Documentation/dev-tools/kunit/index.rst
> index 26ffb46bdf99d..c60d760a0eed1 100644
> --- a/Documentation/dev-tools/kunit/index.rst
> +++ b/Documentation/dev-tools/kunit/index.rst
> @@ -9,6 +9,7 @@ KUnit - Unit Testing for the Linux Kernel
>
>         start
>         usage
> +       kunit-tool
>         api/index
>         faq
>
> diff --git a/Documentation/dev-tools/kunit/kunit-tool.rst b/Documentation/dev-tools/kunit/kunit-tool.rst
> new file mode 100644
> index 0000000000000..aa1a93649a45a
> --- /dev/null
> +++ b/Documentation/dev-tools/kunit/kunit-tool.rst
> @@ -0,0 +1,57 @@
> +.. SPDX-License-Identifier: GPL-2.0
> +
> +=================
> +kunit_tool How-To
> +=================
> +
> +What is kunit_tool?
> +===================
> +
> +kunit_tool is a set of scripts that aid in building the Linux kernel as UML
> +(`User Mode Linux <http://user-mode-linux.sourceforge.net/old/>`_), running
> +KUnit tests, parsing the test results and displaying them in a user friendly
> +manner.

Calling this a "set of scripts" is a bit confusing, as the only script
described is tools/testing/kunit/kunit.py, which isn't mentioned in
this section.

Also, it may be worth linking to the new version of the UML website
(even if the old one has more content).

> +
> +What is a kunitconfig?
> +======================
> +
> +It's just a defconfig that kunit_tool looks for in the base directory.
> +kunit_tool uses it to generate a .config as you might expect. In addition, it
> +verifies that the generated .config contains the CONFIG options in the
> +kunitconfig; the reason it does this is so that it is easy to be sure that a
> +CONFIG that enables a test actually ends up in the .config.
> +
> +How do I use kunit_tool?
> +=================================
> +
> +If a kunitconfig is present at the root directory, all you have to do is:
> +
> +.. code-block:: bash
> +
> +       ./tools/testing/kunit/kunit.py run
> +
> +However, you most likely want to use it with the following options:
> +
> +.. code-block:: bash
> +
> +       ./tools/testing/kunit/kunit.py run --timeout=30 --jobs=8
> +
> +- ``--timeout`` sets a maximum amount of time to allow tests to run.
> +- ``--jobs`` sets the number of threads to use to build the kernel.
> +

Not directly an issue with the documentation, but this does raise the
question of why we don't have better defaults. Alternatively, maybe
this doc could suggest --jobs=`nproc` or similar?

> +If you just want to use the defconfig that ships with the kernel, you can
> +append the ``--defconfig`` flag as well:
> +
> +.. code-block:: bash
> +
> +       ./tools/testing/kunit/kunit.py run --timeout=30 --jobs=8 --defconfig
> +
> +.. note::
> +       This command is particularly helpful for getting started because it
> +       just works. No kunitconfig needs to be present.
> +

Should we use this in the getting started section below, then?
Particularly since we're already going over kunitconfigs there
separately.

> +For a list of all the flags supported by kunit_tool, you can run:
> +
> +.. code-block:: bash
> +

Do you think it's worth documenting the remaining two (--build_dir and
--raw_output) here too?

> +       ./tools/testing/kunit/kunit.py run --help
> diff --git a/Documentation/dev-tools/kunit/start.rst b/Documentation/dev-tools/kunit/start.rst
> index aeeddfafeea20..1535c4394cfa2 100644
> --- a/Documentation/dev-tools/kunit/start.rst
> +++ b/Documentation/dev-tools/kunit/start.rst
> @@ -21,6 +21,9 @@ The wrapper can be run with:
>
>     ./tools/testing/kunit/kunit.py run
>
> +For more information on this wrapper (also called kunit_tool) checkout the
> +:doc:`kunit-tool` page.
> +
>  Creating a kunitconfig
>  ======================
>  The Python script is a thin wrapper around Kbuild as such, it needs to be
> --
> 2.24.0.432.g9d3f5f5b63-goog
>
