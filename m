Return-Path: <SRS0=LniW=ZY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85B03C432C0
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Dec 2019 17:25:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 59D4C2073C
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Dec 2019 17:25:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="OkT0pATS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727709AbfLBRZv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 2 Dec 2019 12:25:51 -0500
Received: from mail-pf1-f196.google.com ([209.85.210.196]:43787 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727542AbfLBRZv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Dec 2019 12:25:51 -0500
Received: by mail-pf1-f196.google.com with SMTP id h14so8577224pfe.10
        for <linux-kernel@vger.kernel.org>; Mon, 02 Dec 2019 09:25:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=QJkfeNUtZsUM1SriZ4NkOu1VRRZp6DXE5Ca/oup1eY0=;
        b=OkT0pATSCD09KhjE0j2gmub4yYFjggeSCEDGGvJRy3S41QTVkCSh8xwimUhMdMZb9c
         YujkvAxV8pa4f0EZH0s21gVwuSe6g/btLrsuyVX3i5JOTcGQSdNOAMcyRSDd3t5i404n
         WpIK1uw847md8b8LtcOKJ8/u6Wyq9QJD+3DBsup2ZkoPnGM89ExC9cFaVHe3pohsGdlv
         IctyftfHniR6t8oxq3n8RP++aJQhCUxr0uzN5fqRymt39FrYs3jIs3okKnTzay7FBi6g
         tLhRuQOVVIM+TdDGHZsOTABM2SdXJqQAaPqY6dTjTN/zzrN/r7UheQRVQo73q30Dx5sZ
         MDnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=QJkfeNUtZsUM1SriZ4NkOu1VRRZp6DXE5Ca/oup1eY0=;
        b=sqsctXJmTmyDiQxvyFB2DAs7ypLYe5KupJ2ao5QRaplq4yVmZNkGR1JNF09ZYyN3A6
         YDckSfkTsfjiGUSddLbeKZ3l1ZBlZkT74SbHxEq1Wiv4je10Kz7B4QAPyMM/vVCsPC7T
         LQ4Bea1rsocL5O/cSNb4Y4C8FkzQj8F30n31BNbOUiodlSSsiIrYgYh+AuvZnEXsdZ5D
         tzelOdY/T+vl/t3iHPg5mJjXYQ44WhEE7hI28erhu3ecE7tb4oo1c/cVs5ke6xM6T9FI
         uRzj1OWLBJ4VjkaMKmIBNuIpWwFO3phEF+ecgEJKpDVUtuV2aZkYSK0F6tkadC+oLNkA
         6C2w==
X-Gm-Message-State: APjAAAVeRlCj44AxQhWFjpCSS51an+Seyt+yTT8WgTup7YXssIlPjeRL
        v0WXY+6ge2/OlHf/30/qaBeC325gfYio+ehN8T7Pag==
X-Google-Smtp-Source: APXvYqzRNnkhXeK9+TF40gPXRoir6QgRYhi5XcQ7EoDA4SgNek8Tj0V1GXGOZXZRvla3t8H8gAQqwdNuOUyfY1Tvp18=
X-Received: by 2002:a62:7b46:: with SMTP id w67mr26208051pfc.113.1575307550038;
 Mon, 02 Dec 2019 09:25:50 -0800 (PST)
MIME-Version: 1.0
References: <1575242724-4937-1-git-send-email-sj38.park@gmail.com> <1575242724-4937-3-git-send-email-sj38.park@gmail.com>
In-Reply-To: <1575242724-4937-3-git-send-email-sj38.park@gmail.com>
From:   Brendan Higgins <brendanhiggins@google.com>
Date:   Mon, 2 Dec 2019 09:25:41 -0800
Message-ID: <CAFd5g47C6OShsYy5ngSGTmkL3fQoj-6jb09iQ+CD6FE0usggCA@mail.gmail.com>
Subject: Re: [PATCH 2/6] docs/kunit/start: Skip wrapper run command
To:     SeongJae Park <sj38.park@gmail.com>,
        David Gow <davidgow@google.com>
Cc:     shuah <shuah@kernel.org>, Jonathan Corbet <corbet@lwn.net>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>,
        KUnit Development <kunit-dev@googlegroups.com>,
        "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        SeongJae Park <sjpark@amazon.de>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

+David Gow - David has lots of good opinions on our documentation.

On Sun, Dec 1, 2019 at 3:25 PM SeongJae Park <sj38.park@gmail.com> wrote:
>
> From: SeongJae Park <sjpark@amazon.de>
>
> The kunit 'Getting Started' document first shows the wrapper running
> command.  However, a new user who simply following the command might
> encounter a failure like below:
>
>     $ ./tools/testing/kunit/kunit.py run
>     Traceback (most recent call last):
>       File "./tools/testing/kunit/kunit.py", line 140, in <module>
>         main(sys.argv[1:])
>       File "./tools/testing/kunit/kunit.py", line 126, in main
>         linux = kunit_kernel.LinuxSourceTree()
>       File "/home/sjpark/linux/tools/testing/kunit/kunit_kernel.py", line 85, in __init__
>         self._kconfig.read_from_file(KUNITCONFIG_PATH)
>       File "/home/sjpark/linux/tools/testing/kunit/kunit_config.py", line 65, in read_from_file
>         with open(path, 'r') as f:
>     FileNotFoundError: [Errno 2] No such file or directory: 'kunitconfig'
>
> Though the reason of the failure ('kunitconfig') is explained in its
> next section, it would be better to reduce any failure that user might
> encounter.  This commit removes the example command for the reason.

Seems reasonable.

> Signed-off-by: SeongJae Park <sjpark@amazon.de>
> ---
>  Documentation/dev-tools/kunit/start.rst | 6 ------
>  1 file changed, 6 deletions(-)
>
> diff --git a/Documentation/dev-tools/kunit/start.rst b/Documentation/dev-tools/kunit/start.rst
> index 78a0aed..e25978d 100644
> --- a/Documentation/dev-tools/kunit/start.rst
> +++ b/Documentation/dev-tools/kunit/start.rst
> @@ -15,12 +15,6 @@ Included with KUnit is a simple Python wrapper that helps format the output to
>  easily use and read KUnit output. It handles building and running the kernel, as
>  well as formatting the output.
>
> -The wrapper can be run with:
> -
> -.. code-block:: bash
> -
> -   ./tools/testing/kunit/kunit.py run
> -
>  Creating a kunitconfig
>  ======================

I think maybe we should demote this section so that this is a
subsection under KUnit Wrapper. Might also want to add a tie-in
explaining why we are talking about kunitconfig here? Right now this
kind of reads as a non sequitur.

Note: we have tried to address this potential issue for new users in
this patch under review:

https://patchwork.kernel.org/patch/11252953/

I don't feel strongly whether we do it your way or my way. What do
other people think?

>  The Python script is a thin wrapper around Kbuild as such, it needs to be
> --
> 2.7.4
>
