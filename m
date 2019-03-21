Return-Path: <SRS0=/BZh=RY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 52064C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Mar 2019 16:55:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1401A21874
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Mar 2019 16:55:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ZOQDErPc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728460AbfCUQz0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Mar 2019 12:55:26 -0400
Received: from mail-ot1-f65.google.com ([209.85.210.65]:37702 "EHLO
        mail-ot1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727844AbfCUQzZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Mar 2019 12:55:25 -0400
Received: by mail-ot1-f65.google.com with SMTP id c16so6068349otn.4
        for <linux-kernel@vger.kernel.org>; Thu, 21 Mar 2019 09:55:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=lgLe/zsvfz2aVJmMSIccglHO9Qslr0A9hXgrCfW+8tQ=;
        b=ZOQDErPc2go4z3WmpoVzTY0Emr+9aUeF0GVuGTZ4g2UIFjUbJq4ekec4bSm6+nArU9
         dRjFCDxmF2th/MYEsv51OBdq5G3gReq/PSCB0C507hPzrsZ7Meaw6CeLJTd9dcbDMIEa
         D6QbWMkw4MO0RecE2HI8eQNmwBjVreHHS9p2MW1j4C6zMCgaheqIG6XGtLH0jtaaeT2E
         +jdR53v+tG17RjiRupD3HAkeVaE/EXmXK2UVJ4fDWuEypCs3D5cqdWhlS2uqO5pyPdpg
         OmYPnuFKo9u5zbdLqxsHrE5+Wc7joesFcLugqfiTx2+Bkif48YWfnV5nQwkxHut/cSlj
         xcbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=lgLe/zsvfz2aVJmMSIccglHO9Qslr0A9hXgrCfW+8tQ=;
        b=IuXxS2jlsVBu+EKl1p0NxIqx1l1gOPJIkVN1QTDkVBXs15tSsP2feT7SZkoEzqGSRE
         MFNyRDm9qqBLnq1DKfaWn8+qosw36nYqGQTjav5hWqKd/xnE4Qjuvf6Rvi42kOofHnen
         4KsFiUUSwmbEy8Yd4oh8vzL1nz1K/dBak8eWx8OSQCklIuAoC/WGjCLT9M8gHiPFpIWW
         i+9ND2eAh3JO1DyTapvFONbHMM35xreNrGVP98oCOmb+y92PtdFaw5rWMzE0CBIUO/Ls
         eOEPhB5nb2hlcMWJU3mDXjCl/erysycWiTHAhCcKjUz04xy9o5/8/gDBnBz8HwBVcQxp
         PiQQ==
X-Gm-Message-State: APjAAAVUoXbB1nfABUawCciFlGQBBQFPnhaJbHTmn78DSiAqAxLZOv54
        74G5QNt2IoFBQ3mI8YTaOOoT1/tylERsXUnQLo00vQ==
X-Google-Smtp-Source: APXvYqz9yhHBIi6L+dYxaz/pPMlHvgXAaMZDEeiVCbYbIFzfWufM6nkeGKKEPQTCVKO8oAHZXJHvtPp6DCEHsNAEvCI=
X-Received: by 2002:a9d:73c2:: with SMTP id m2mr3190373otk.338.1553187323847;
 Thu, 21 Mar 2019 09:55:23 -0700 (PDT)
MIME-Version: 1.0
References: <20190214213729.21702-1-brendanhiggins@google.com>
 <6d9b3b21-1179-3a45-7545-30aa15306cb4@deltatee.com> <01b2a950f661e8ebd6acbc45c2f89c8f10063daf.camel@oracle.com>
 <ce355f5c-189c-816c-cde4-fb4e816d44e7@deltatee.com>
In-Reply-To: <ce355f5c-189c-816c-cde4-fb4e816d44e7@deltatee.com>
From:   Brendan Higgins <brendanhiggins@google.com>
Date:   Thu, 21 Mar 2019 09:55:12 -0700
Message-ID: <CAFd5g45LKU+SZAFzn3RNCoxhzum0NAr9t+UJ80SJDMc_FeKgBQ@mail.gmail.com>
Subject: Re: [RFC v4 00/17] kunit: introduce KUnit, the Linux kernel unit
 testing framework
To:     Logan Gunthorpe <logang@deltatee.com>
Cc:     Knut Omang <knut.omang@oracle.com>,
        Kees Cook <keescook@google.com>,
        Luis Chamberlain <mcgrof@kernel.org>, shuah@kernel.org,
        Rob Herring <robh@kernel.org>,
        Kieran Bingham <kieran.bingham@ideasonboard.com>,
        Frank Rowand <frowand.list@gmail.com>,
        Greg KH <gregkh@linuxfoundation.org>,
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

On Thu, Mar 21, 2019 at 8:56 AM Logan Gunthorpe <logang@deltatee.com> wrote:
>
>
>
> On 2019-03-20 11:23 p.m., Knut Omang wrote:
> > Testing drivers, hardware and firmware within production kernels was the use
> > case that inspired KTF (Kernel Test Framework). Currently KTF is available as a
> > standalone git repository. That's been the most efficient form for us so far,
> > as we typically want tests to be developed once but deployed on many different
> > kernel versions simultaneously, as part of continuous integration.
>
> Interesting. It seems like it's really in direct competition with KUnit.

I won't speak for Knut, but I don't think we are in competition. I see
KTF as a novel way to do a kind of white box end-to-end testing for
the Linux kernel, which is a valuable thing, especially in some
circumstances. I could see KTF having a lot of value for someone who
wants to maintain out of tree drivers, in particular.

Nevertheless, I don't really see KTF as a real unit testing framework
for a number of different reasons; you pointed out some below, but I
think the main one being that it requires booting a real kernel on
actual hardware; I imagine it could be made to work on a VM, but that
isn't really the point; it fundamentally depends on having part of the
test, or at least driving the test from userspace on top of the kernel
under test. Knut, myself, and others, had a previous discussion to
this effect here: https://lkml.org/lkml/2018/11/24/170

> I didn't really go into it in too much detail but these are my thoughts:
>
> From a developer perspective I think KTF not being in the kernel tree is
> a huge negative. I want minimal effort to include my tests in a patch
> series and minimal effort for other developers to be able to use them.
> Needing to submit these tests to another project or use another project
> to run them is too much friction.
>
> Also I think the goal of having tests that run on any kernel version is
> a pipe dream. You'd absolutely need a way to encode which kernel
> versions a test is expected to pass on because the tests might not make
> sense until a feature is finished in upstream. And this makes it even
> harder to develop these tests because, when we write them, we might not
> even know which kernel version the feature will be added to. Similarly,
> if a feature is removed or substantially changed, someone will have to
> do a patch to disable the test for subsequent kernel versions and create
> a new test for changed features. So, IMO, tests absolutely have to be
> part of the kernel tree so they can be changed with the respective
> features they test.
>
> Kunit's ability to run without having to build and run the entire kernel
>  is also a huge plus. (Assuming there's a way to get around the build
> dependency issues). Because of this, it can be very quick to run these
> tests which makes development a *lot* easier seeing you don't have to
> reboot a machine every time you want to test a fix.

I will reply to your comments directly on your original email. I don't
want to hijack this thread, in case we want to discuss the topic of
KUnit vs. KTF further.
