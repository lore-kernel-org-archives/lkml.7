Return-Path: <SRS0=yZjE=R4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D9099C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Mar 2019 17:56:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9A3F120823
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Mar 2019 17:56:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="hlHXr/at"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729716AbfCYR4V (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Mar 2019 13:56:21 -0400
Received: from mail-lf1-f68.google.com ([209.85.167.68]:34596 "EHLO
        mail-lf1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729036AbfCYR4U (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Mar 2019 13:56:20 -0400
Received: by mail-lf1-f68.google.com with SMTP id y18so6760660lfe.1
        for <linux-kernel@vger.kernel.org>; Mon, 25 Mar 2019 10:56:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=gxz4yoPt1q6OV76nKiFOODegQSe7rL5QL9V2EAX+Woo=;
        b=hlHXr/at2H4nErYZbKBI1q2uTyv9g0aaTySTLBtg2fh3UIeutwX4ysAJkcWWQPQLuU
         sgS3NrXbXlkxcjW1Y/jBm+/7LYo6volmPRiZxREkCSXGshOa00kS5t9u6sT1DEKAjcU3
         S0Bw/Q3ROtGOnNS8vQ38KuW1BF2RINWpuSbkY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=gxz4yoPt1q6OV76nKiFOODegQSe7rL5QL9V2EAX+Woo=;
        b=C4A8KdSRZIfQJrI4CaGd46VmrzCm8FA8JyL/ebyqf49VY7hJwqoROA9Q0KfeS3GQqD
         hHSgogew18EDI8lxth6XhQrcgOb0kwU4+Jf9Bmm68BJNk0Jcn1kGfYuZKuU7ndO8oPth
         uPUyeM65MFIdRnl+wIkOb/DmjMCeBqsZJvdieEWuQ9NPzU3E7FVHKJ+s93MbUUX76Vdt
         fzz+NCOX2hSXqiYkIOI9xUk4OY5I3oIdYdr38XDJN2DqB9Q3sSZcEdx0C1Ueewki4tll
         caGL8XQhtvt7n+LEBolHRMHu6ZtTMtMbEyJezGzDUUfLiYNkFv8yPyFq302Zr+Yl08Y+
         7xdg==
X-Gm-Message-State: APjAAAWmG8I36vqeve3IANhsKTGQEgI3tGnTj5BE6pd4CoOZiWOKJ9sY
        7Yi0kLGL2h/niB96wPZxnli5OESty0Y=
X-Google-Smtp-Source: APXvYqwDcOTqWBdA1CPX5KwagShWn5wc/KZx80GoErTEUgk32bbm1FEd5TGH+S+hP6jcvkBzyZbQFg==
X-Received: by 2002:a19:954b:: with SMTP id x72mr12968314lfd.67.1553536577474;
        Mon, 25 Mar 2019 10:56:17 -0700 (PDT)
Received: from mail-lj1-f181.google.com (mail-lj1-f181.google.com. [209.85.208.181])
        by smtp.gmail.com with ESMTPSA id s10sm131988lfc.20.2019.03.25.10.56.14
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 25 Mar 2019 10:56:14 -0700 (PDT)
Received: by mail-lj1-f181.google.com with SMTP id v22so8663845lje.9
        for <linux-kernel@vger.kernel.org>; Mon, 25 Mar 2019 10:56:14 -0700 (PDT)
X-Received: by 2002:a2e:b058:: with SMTP id d24mr14870339ljl.42.1553536573991;
 Mon, 25 Mar 2019 10:56:13 -0700 (PDT)
MIME-Version: 1.0
References: <20190306214730.6545-1-valleau@chromium.org> <44e151af-b6c4-d0af-3ef1-a5632d079915@kernel.org>
 <CA+ASDXMcnEfZzTjDGsDbZxX2Xknv6dt3H-3kN79WdKFzif2zsA@mail.gmail.com> <caee30e2-ddc4-0076-907e-558dbcfe7c52@kernel.org>
In-Reply-To: <caee30e2-ddc4-0076-907e-558dbcfe7c52@kernel.org>
From:   Brian Norris <briannorris@chromium.org>
Date:   Mon, 25 Mar 2019 10:56:02 -0700
X-Gmail-Original-Message-ID: <CA+ASDXOzTkXk_JtBDa4zkMhy3NyWv7Wn1i6YYtwRdeF8j_c2nA@mail.gmail.com>
Message-ID: <CA+ASDXOzTkXk_JtBDa4zkMhy3NyWv7Wn1i6YYtwRdeF8j_c2nA@mail.gmail.com>
Subject: Re: [PATCH] tools: usb: usbip: adding support for older kernel versions
To:     shuah <shuah@kernel.org>
Cc:     David Valleau <valleau@chromium.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux USB Mailing List <linux-usb@vger.kernel.org>,
        Michael Grzeschik <m.grzeschik@pengutronix.de>,
        Valentina Manea <valentina.manea.m@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Sasha Levin <alexander.levin@microsoft.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Shuah,

On Mon, Mar 25, 2019 at 8:51 AM shuah <shuah@kernel.org> wrote:
> On 3/18/19 12:23 PM, Brian Norris wrote:
> > On Sat, Mar 16, 2019 at 4:40 PM shuah <shuah@kernel.org> wrote:
> >> I would like to understand the reasons for wanting to run new tool on
> >> old kernels.
> >
> > On Chromium OS, we ship more or less the same user space for a variety
> > of systems, but not all of those run the same kernel. That's not
> > exactly a novel concept -- many good tools are written such that they
> > degrade gracefully when running with reduced feature sets (e.g., older
> > kernels). While we are working on reducing the divergence and number
> > of kernels we ship, it's currently a fact of life that we have to
> > support multiple target kernel versions.
>
> Thanks for the context for this change.

One thing to add: we're currently only using usbip as a test utility,
and we're not yet enabling it on older kernels (because of this
precise problem).

> > Is there a fundamental problem with VHCI such that it doesn't have a
> > stable ABI that tools can be written against?
> >
>
> In general the ABI is stable.

No, it really isn't. This commit was a breaking change:

commit 2f2d0088eb93db5c649d2a5e34a3800a8a935fc5
Author: Shuah Khan <shuahkh@osg.samsung.com>
Date: Thu Dec 7 14:16:49 2017 -0700

  usbip: prevent vhci_hcd driver from leaking a socket pointer address

That one is arguably OK, since nobody was actually using that field
(except for parsing it and throwing it away), and it's a security
leak.

But this one is definitely a break:

commit 1c9de5bf428612458427943b724bea51abde520a
Author: Yuyang Du <yuyang.du@intel.com>
Date: Thu Jun 8 13:04:10 2017 +0800

  usbip: vhci-hcd: Add USB3 SuperSpeed support

You can't just arbitrarily add columns to the beginning of a file like
that and claim that you're not breaking ABI. And I shouldn't need to
remind you that Thou Shalt Not Break User Space.

Now, this whole file has tons of problems:
 * it's not documented at all in Documentation/ABI/ (so hey, you can
argue there's no ABI to break!)
 * it violates the "one piece of information per attribute" rule; this
contributes to the previous point, since it's hard to extend anything
without breaking user space

> +#define V3_18_STATUS_HEADER "prt sta spd bus dev socket
> local_busid"
>
> What's your 3.18 kernel version? I think you are missing security
> fixes that prevent socket address leak in the status file.

We're not using the latest 3.18.y stable series, if that's what you're
asking. So no, we don't have that security patch. But we also don't
currently enable USBIP_CORE and similar. We can backport stuff if we
need (backporting that security fix is on my/our plate), but we'd
probably like to understand the maintenance landscape here first.
Clearly usbip is not maintained with ABI compatibility in mind.

> +#define V4_4_STATUS_HEADER "prt sta spd dev      sockfd local_busid"
> +#define V4_14_STATUS_HEADER "hub port sta spd dev      sockfd local_busid"
>
> The difference here is the high speed support. Let's find a better
> way to fix this than hard-coding kernel revisions in the tool.

Yeah, I'm not in love with this particular patch, but it exposes the
systemic problems you have already, so at least it serves to start the
discussion.

> > If stability is possible but you just don't care, then I guess we can
> > fork our own version...
> >
> > Or even worse, we could build N copies of usbip for N kernels. But we
> > don't do that for any other user space component.
> >
>
> It might be easier to build N versions than maintaining the fork :)
>
> In any case, let's find ways to fix the problem with a constructive
> approach.

I think we should settle the biggest questions first: documenting
(and/or re-implementing) the current ABI, so that we have a stable
target. Going forward, if we are to pretend this is a real kernel
feature, it should not be breaking compatibility arbitrarily like it
has already. If I started using usbip on kernel 3.18 (+ the
pointer-leaking security fix), I should not expect to see my user
space break just because I upgraded to the latest kernel.

If we can agree on that part, *then* we can talk about what (if
anything) to do about patching usbip for compatibility with old
(ABI-broken) kernels. Perhaps we will just throw out old kernels. Or
maybe we'll do some minimal user space patching. Or maybe we patch our
old kernels to match the latest ABI. That's not quite as big as a
problem, as long as we agree on what ABI stability means going
forward.

Brian
