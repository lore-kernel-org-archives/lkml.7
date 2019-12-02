Return-Path: <SRS0=LniW=ZY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B16F1C432C0
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Dec 2019 21:03:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 77021206E0
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Dec 2019 21:03:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="cHC+ZMFr"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726785AbfLBVD2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 2 Dec 2019 16:03:28 -0500
Received: from mail-wm1-f67.google.com ([209.85.128.67]:35316 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726628AbfLBVD1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Dec 2019 16:03:27 -0500
Received: by mail-wm1-f67.google.com with SMTP id u8so1117774wmu.0
        for <linux-kernel@vger.kernel.org>; Mon, 02 Dec 2019 13:03:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=r01J34vJY8VVJPUGVeE7cpERIHDKrc1315raIYX32Cs=;
        b=cHC+ZMFrHWUMG4ZucZrMEJZIo0L6rS1d68qz0/WReqxCnnpF4S31WVVK3sbkXNDMQ4
         p46Ru0bORALpDhY5Pmaq7I9i26WMtVtG2SMaQAE3zIFRBs1Yemi7GCrx0DAlE9HpLY2c
         oTnN+6viYatU0sDYdydhBSSu3KTx7AjnDr5uNOLlJRy/kv8bXlpQJbjbvb38buC8mTlj
         lxl6Ot8u+Cz/jGcJMIAdjiGnTzt2r92ZvkjJywFP7i/o6VIuGAPXjKgDmmx+Bk8IXFVs
         eSa1+T00XmisX+Tl+fqj0DGOX9VDGhGqrf+dBK4/ryMy0Ih4xD5IMcYi8/8XHWrY3B99
         +XVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=r01J34vJY8VVJPUGVeE7cpERIHDKrc1315raIYX32Cs=;
        b=HNb8MM7Xkwn9GgIm8XP9Zfped+UTopsd6tECe0JeI3M+cg1+mu+gyql+ukpTkUROrO
         uaiNZ+gOR6+zaWomXQ38xYMPIyHtmgUMIFIYYLZbeci0NfHyF1/bS8r5CdPlxTi+/YTg
         L+Gz2lKhZUfFVQNDRC9YR2fN5PSqTgC8cvjlG2+NHhmRium9dFaonp0K746C4L2DX8lo
         xdHdYV4MmRITjhelp1nGFMRJJZijkhFTsEIKemQ6X32hFEt32asf1rsSrZWkV/JGkyRi
         q8eSiOT8LbXnQCHBrC00+i8g8Lpj47zKmB8jPtSw79lrqa2n+V0J1BglyMJYpL0OSjGE
         1ijA==
X-Gm-Message-State: APjAAAXyp5CGmnFwbL7CjE1S9K/DTmC53KjY/yiDI/xrVWJjV2I9F3O2
        7Rr3L/0EWoD+utUMf13i2sAKgqT60d7j5pAA6OXxfg==
X-Google-Smtp-Source: APXvYqypm468Dbw2QnL7MKOTLRHeBqpRaUXJTB6WeCBFxGsOlmli3BV5VV358aoosI54jdsIt44FabKsXMYqmF3LD+Q=
X-Received: by 2002:a1c:30b:: with SMTP id 11mr29100382wmd.171.1575320604874;
 Mon, 02 Dec 2019 13:03:24 -0800 (PST)
MIME-Version: 1.0
References: <1575242724-4937-1-git-send-email-sj38.park@gmail.com>
 <1575242724-4937-3-git-send-email-sj38.park@gmail.com> <CAFd5g47C6OShsYy5ngSGTmkL3fQoj-6jb09iQ+CD6FE0usggCA@mail.gmail.com>
In-Reply-To: <CAFd5g47C6OShsYy5ngSGTmkL3fQoj-6jb09iQ+CD6FE0usggCA@mail.gmail.com>
From:   David Gow <davidgow@google.com>
Date:   Mon, 2 Dec 2019 13:03:09 -0800
Message-ID: <CABVgOS=xYiqVNND3JxgRLPv--0ZNC+h=FB0oZc2sKmVk4HJ95A@mail.gmail.com>
Subject: Re: [PATCH 2/6] docs/kunit/start: Skip wrapper run command
To:     Brendan Higgins <brendanhiggins@google.com>
Cc:     SeongJae Park <sj38.park@gmail.com>, shuah <shuah@kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
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

On Mon, Dec 2, 2019 at 9:25 AM Brendan Higgins
<brendanhiggins@google.com> wrote:
>
> +David Gow - David has lots of good opinions on our documentation.
>
> On Sun, Dec 1, 2019 at 3:25 PM SeongJae Park <sj38.park@gmail.com> wrote:
> >
> > From: SeongJae Park <sjpark@amazon.de>
> >
> > The kunit 'Getting Started' document first shows the wrapper running
> > command.  However, a new user who simply following the command might
> > encounter a failure like below:
> >
> >     $ ./tools/testing/kunit/kunit.py run
> >     Traceback (most recent call last):
> >       File "./tools/testing/kunit/kunit.py", line 140, in <module>
> >         main(sys.argv[1:])
> >       File "./tools/testing/kunit/kunit.py", line 126, in main
> >         linux = kunit_kernel.LinuxSourceTree()
> >       File "/home/sjpark/linux/tools/testing/kunit/kunit_kernel.py", line 85, in __init__
> >         self._kconfig.read_from_file(KUNITCONFIG_PATH)
> >       File "/home/sjpark/linux/tools/testing/kunit/kunit_config.py", line 65, in read_from_file
> >         with open(path, 'r') as f:
> >     FileNotFoundError: [Errno 2] No such file or directory: 'kunitconfig'
> >
> > Though the reason of the failure ('kunitconfig') is explained in its
> > next section, it would be better to reduce any failure that user might
> > encounter.  This commit removes the example command for the reason.
>
> Seems reasonable.
>
I definitely agree that having a non-working command here is doing
more harm than good. Whether we just get rid of it, or change it to
use the --defconfig option is a matter of taste. (Personally, I think
there's some value in having a one-line "run the tests" command at the
top of the Getting Started page, but it definitely needs to be one
that works.)

So, overall, I think this is definitely an improvement, but that we do
need to choose whether to take this approach (deleting this command)
or the --defconfig approach as in:
https://lore.kernel.org/linux-kselftest/20191119003120.154041-1-brendanhiggins@google.com/

> > Signed-off-by: SeongJae Park <sjpark@amazon.de>
> > ---
> >  Documentation/dev-tools/kunit/start.rst | 6 ------
> >  1 file changed, 6 deletions(-)
> >
> > diff --git a/Documentation/dev-tools/kunit/start.rst b/Documentation/dev-tools/kunit/start.rst
> > index 78a0aed..e25978d 100644
> > --- a/Documentation/dev-tools/kunit/start.rst
> > +++ b/Documentation/dev-tools/kunit/start.rst
> > @@ -15,12 +15,6 @@ Included with KUnit is a simple Python wrapper that helps format the output to
> >  easily use and read KUnit output. It handles building and running the kernel, as
> >  well as formatting the output.
> >
> > -The wrapper can be run with:
> > -
> > -.. code-block:: bash
> > -
> > -   ./tools/testing/kunit/kunit.py run
> > -
> >  Creating a kunitconfig
> >  ======================
>
> I think maybe we should demote this section so that this is a
> subsection under KUnit Wrapper. Might also want to add a tie-in
> explaining why we are talking about kunitconfig here? Right now this
> kind of reads as a non sequitur.
I generally think we want to keep the "Getting Started" guide focused
on the goal (running/writing tests), rather than too much detail on
the implementation (the wrapper itself).
How about renaming what's currently the "KUnit Wrapper" section to
"Running tests" or similar, and moving the kunitconfig part under
that?

The "Creating a kunitconfig" part could equally be "configuring which
tests to run" or something, which may speak more to motivating

As for some sort of tie-in, perhaps rewording the opening sentence to
say "The easiest way to run tests is to use the kunit_tool script",
and link to the page kunit_tool page in the patch below?
>
> Note: we have tried to address this potential issue for new users in
> this patch under review:
>
> https://patchwork.kernel.org/patch/11252953/
>
> I don't feel strongly whether we do it your way or my way. What do
> other people think?

As above, my slight preference is for adding the --defconfig option
over removing the section entirely.

> >  The Python script is a thin wrapper around Kbuild as such, it needs to be
> > --
> > 2.7.4
> >
On Mon, Dec 2, 2019 at 9:25 AM Brendan Higgins
<brendanhiggins@google.com> wrote:
>
> +David Gow - David has lots of good opinions on our documentation.
>
> On Sun, Dec 1, 2019 at 3:25 PM SeongJae Park <sj38.park@gmail.com> wrote:
> >
> > From: SeongJae Park <sjpark@amazon.de>
> >
> > The kunit 'Getting Started' document first shows the wrapper running
> > command.  However, a new user who simply following the command might
> > encounter a failure like below:
> >
> >     $ ./tools/testing/kunit/kunit.py run
> >     Traceback (most recent call last):
> >       File "./tools/testing/kunit/kunit.py", line 140, in <module>
> >         main(sys.argv[1:])
> >       File "./tools/testing/kunit/kunit.py", line 126, in main
> >         linux = kunit_kernel.LinuxSourceTree()
> >       File "/home/sjpark/linux/tools/testing/kunit/kunit_kernel.py", line 85, in __init__
> >         self._kconfig.read_from_file(KUNITCONFIG_PATH)
> >       File "/home/sjpark/linux/tools/testing/kunit/kunit_config.py", line 65, in read_from_file
> >         with open(path, 'r') as f:
> >     FileNotFoundError: [Errno 2] No such file or directory: 'kunitconfig'
> >
> > Though the reason of the failure ('kunitconfig') is explained in its
> > next section, it would be better to reduce any failure that user might
> > encounter.  This commit removes the example command for the reason.
>
> Seems reasonable.
>
> > Signed-off-by: SeongJae Park <sjpark@amazon.de>
> > ---
> >  Documentation/dev-tools/kunit/start.rst | 6 ------
> >  1 file changed, 6 deletions(-)
> >
> > diff --git a/Documentation/dev-tools/kunit/start.rst b/Documentation/dev-tools/kunit/start.rst
> > index 78a0aed..e25978d 100644
> > --- a/Documentation/dev-tools/kunit/start.rst
> > +++ b/Documentation/dev-tools/kunit/start.rst
> > @@ -15,12 +15,6 @@ Included with KUnit is a simple Python wrapper that helps format the output to
> >  easily use and read KUnit output. It handles building and running the kernel, as
> >  well as formatting the output.
> >
> > -The wrapper can be run with:
> > -
> > -.. code-block:: bash
> > -
> > -   ./tools/testing/kunit/kunit.py run
> > -
> >  Creating a kunitconfig
> >  ======================
>
> I think maybe we should demote this section so that this is a
> subsection under KUnit Wrapper. Might also want to add a tie-in
> explaining why we are talking about kunitconfig here? Right now this
> kind of reads as a non sequitur.
>
> Note: we have tried to address this potential issue for new users in
> this patch under review:
>
> https://patchwork.kernel.org/patch/11252953/
>
> I don't feel strongly whether we do it your way or my way. What do
> other people think?
>
> >  The Python script is a thin wrapper around Kbuild as such, it needs to be
> > --
> > 2.7.4
> >
