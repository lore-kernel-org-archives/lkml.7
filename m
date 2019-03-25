Return-Path: <SRS0=yZjE=R4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 56D99C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Mar 2019 22:11:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 278EA2075E
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Mar 2019 22:11:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="dLtI/jvR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731339AbfCYWL3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Mar 2019 18:11:29 -0400
Received: from mail-ot1-f65.google.com ([209.85.210.65]:45149 "EHLO
        mail-ot1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731219AbfCYWL1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Mar 2019 18:11:27 -0400
Received: by mail-ot1-f65.google.com with SMTP id e5so9572373otk.12
        for <linux-kernel@vger.kernel.org>; Mon, 25 Mar 2019 15:11:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=7ECL5IMzDjAScJLAj+WRY8Z0yeUw/3km3NK6dOEReCw=;
        b=dLtI/jvRoiN8CHunlFAaGhIoBbVCViGCykj4q34wT6+aI36iM8lYP14CJr++3lXdpu
         EtAYCuLKbUv4X1cv70GjR6CyMacazKaiGad6WIdptu4yFopnxIu4Rty9o41cexuQaLNw
         lKSKpSlGZefIhPKY78C08k7ZR3W57pUPOKKSKd5pUWaaxHD6EOY06KQLBwQo3mxFRt3n
         sisR/mN+GKcGkUsFxfrFI8mhXf/ikAMVP+3y/KQZZNK005uj7X7NSXK1qXIxCCfoX885
         yCT+JN/M0bgS/WGVfFbb6iDVQ5+ECUTVGg1fRuJiajcsWjnWzmk51lEWZip9h+qwx4A/
         0e/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=7ECL5IMzDjAScJLAj+WRY8Z0yeUw/3km3NK6dOEReCw=;
        b=NeL8WXZEJQ1BufM0N0+UpCctZ27gyW9QGU4sq3bd8v7mSPe9kFRkqcSp2mu33VAf+4
         mHZH5nfdoZiXF1cblgtB46+OniCgBc+Ur2irzyvrCfhsCYOq6XmC+gZIx1pnVQPY8rMJ
         jItf+92I3cS0LKhWI1400Qw1Tf+rIeiPF0ssb0BwnnpTCTYbLBS3txXbCKX3X/vmgKly
         DymtjStagdpPPwTU5VdpJ4mfQ+IsTo1GAcYXZI5zY7eOvrCUmECLq8sCF1czX0yQOTMc
         XqdRf0VBrCP3NfM+Tb4m0bn30S/4/X5x3pDB8AxnEjhRZ8hK8UvbeFvmSFQUEvcI1h3K
         FWcw==
X-Gm-Message-State: APjAAAXi1y8nWZ953/mpqhxPa1GvGe61sE4MlDDM2C3svfA1ZU4kLmCL
        Icp2otzGvr8/y3u9M39vdsqmFNuKGle9fHSENOnuow==
X-Google-Smtp-Source: APXvYqw/UJ4/3s+iwKOss6rjqKrfhCwPtG6PRkcu4/AJMpcOxmWHIw4fHQkbTV6A53gXbXjiPq4gPMqQt/VJan7na2A=
X-Received: by 2002:a9d:51ca:: with SMTP id d10mr18866047oth.83.1553551885777;
 Mon, 25 Mar 2019 15:11:25 -0700 (PDT)
MIME-Version: 1.0
References: <20190214213729.21702-1-brendanhiggins@google.com>
 <CAFd5g45F3YUsAjse+Vt5hj5CLjaXrRWgr5zCZZ6CJKc0hboP6Q@mail.gmail.com> <0e6eb370-3e62-e1a5-1b91-bccc5868e8e4@gmail.com>
In-Reply-To: <0e6eb370-3e62-e1a5-1b91-bccc5868e8e4@gmail.com>
From:   Brendan Higgins <brendanhiggins@google.com>
Date:   Mon, 25 Mar 2019 15:11:14 -0700
Message-ID: <CAFd5g46ZW5PqQ1-k0gXRxZ+Zp3ukYWmhGYBz589NoFre7f+kzA@mail.gmail.com>
Subject: Re: [RFC v4 00/17] kunit: introduce KUnit, the Linux kernel unit
 testing framework
To:     Frank Rowand <frowand.list@gmail.com>
Cc:     Kees Cook <keescook@google.com>,
        Luis Chamberlain <mcgrof@kernel.org>, shuah@kernel.org,
        Rob Herring <robh@kernel.org>,
        Kieran Bingham <kieran.bingham@ideasonboard.com>,
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

On Thu, Mar 21, 2019 at 6:23 PM Frank Rowand <frowand.list@gmail.com> wrote:
>
> On 3/4/19 3:01 PM, Brendan Higgins wrote:
> > On Thu, Feb 14, 2019 at 1:38 PM Brendan Higgins
< snip >
> > Someone suggested I should send the next revision out as "PATCH"
> > instead of "RFC" since there seems to be general consensus about
> > everything at a high level, with a couple exceptions.
> >
> > At this time I am planning on sending the next revision out as "[PATCH
> > v1 00/NN] kunit: introduce KUnit, the Linux kernel unit testing
> > framework". Initially I wasn't sure if the next revision should be
> > "[PATCH v1 ...]" or "[PATCH v5 ...]". Please let me know if you have a
> > strong objection to the former.
> >
> > In the next revision, I will be dropping the last two of three patches
> > for the DT unit tests as there doesn't seem to be enough features
> > currently available to justify the heavy refactoring I did; however, I
>
> Thank you.
>
>
> > will still include the patch that just converts everything over to
> > KUnit without restructuring the test cases:
> > https://lkml.org/lkml/2019/2/14/1133
>
> The link doesn't work for me (don't worry about that), so I'm assuming
> this is:
>
>    [RFC v4 15/17] of: unittest: migrate tests to run on KUnit

That's correct.

>
> The conversation on that patch ended after:
>
>    >> After adding patch 15, there are a lot of "unittest internal error" messages.
>    >
>    > Yeah, I meant to ask you about that. I thought it was due to a change
>    > you made, but after further examination, just now, I found it was my
>    > fault. Sorry for not mentioning that anywhere. I will fix it in v5.
>
> It is not worth my time to look at patch 15 when it is that broken.  So I
> have not done any review of it.

Right, I didn't expect you to, we were still discussing things on RFC
v3 at the time. I think I got you comments on v3 in a very short time
frame around sending out v4; hence why your comments were not
addressed.

>
> So no, I think you are still in the RFC stage unless you drop patch 15.

Noted. I might split that out into a separate RFC then.

>
> >
> > I should have the next revision out in a week or so.
> >
>

Cheers!
