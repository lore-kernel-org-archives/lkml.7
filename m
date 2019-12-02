Return-Path: <SRS0=LniW=ZY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40080C432C0
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Dec 2019 16:36:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0E0182071F
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Dec 2019 16:36:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="QRXY4Sme"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727493AbfLBQgf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 2 Dec 2019 11:36:35 -0500
Received: from mail-io1-f66.google.com ([209.85.166.66]:44405 "EHLO
        mail-io1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727435AbfLBQge (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Dec 2019 11:36:34 -0500
Received: by mail-io1-f66.google.com with SMTP id z23so4265546iog.11
        for <linux-kernel@vger.kernel.org>; Mon, 02 Dec 2019 08:36:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ssAMXH8W+f366ZBx3DAnlgAtvRdBNu89nK7uXXb27YM=;
        b=QRXY4SmeygkXP5YBTkiIx5Q9RAi7VAH6ojPbJhVcnsQkPuLu38Cr3qfdxVzjXNzWkZ
         3ecEELEyuhZnjuYeXR4CihiLLQHfJsRVWghIHMEvjMIwfW/Wi+cH0QSoNo7pho18CMqc
         XQh+Q4tjDWFdnxAHqtCPHrnSNt5Vf0hrbLu1E=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ssAMXH8W+f366ZBx3DAnlgAtvRdBNu89nK7uXXb27YM=;
        b=EMJjmiKSvYidY4JnNKtrK253/fXSp9G6SA/KuMbIBISlyWt09R7HPmXz1icdr2AnAF
         Qo7EtE+RbER5K1gILvEDn/uc+6/qXWvuqxaXz7nVEeGAMw6oLP0F9EvD0p83JgX8BBKp
         VjWj/dLVwjj1YM5MXHAErVjEfXrCZh2rSXFhheJqogufottH/8NqrClXhvbO/5Vlt+3b
         KpM4dgA+wdcA0J6FAJR8MMPdduVliZTxK7pj/BpodwBKeJbi1BhnEQFqGvHsVSbhddv4
         MqTvzit2DGr7EeH+HMert8iCkUaj1ATIbTkLB1XN+RBUGExtcP6x6Le5S8ACqpzf9Gny
         QVMQ==
X-Gm-Message-State: APjAAAXFomQh0rXzDn8tioOiU75Q5eIigCm6C5W1T/EeKHAlgOCnvS3J
        MI4QLpeNaKdAlIiy9w6I/SdmIkXIQrQ=
X-Google-Smtp-Source: APXvYqw7PW5piEo129pZkbAZ10EzBNeGOMO9TSh4dUWqEbkl8bG62yk49aMJppClB//LrUD+jmmOdw==
X-Received: by 2002:a02:44c7:: with SMTP id o190mr323352jaa.8.1575304593327;
        Mon, 02 Dec 2019 08:36:33 -0800 (PST)
Received: from mail-il1-f172.google.com (mail-il1-f172.google.com. [209.85.166.172])
        by smtp.gmail.com with ESMTPSA id l205sm9800653ill.50.2019.12.02.08.36.32
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 02 Dec 2019 08:36:32 -0800 (PST)
Received: by mail-il1-f172.google.com with SMTP id b15so220328ila.7
        for <linux-kernel@vger.kernel.org>; Mon, 02 Dec 2019 08:36:32 -0800 (PST)
X-Received: by 2002:a92:911b:: with SMTP id t27mr2779332ild.142.1575304591885;
 Mon, 02 Dec 2019 08:36:31 -0800 (PST)
MIME-Version: 1.0
References: <20191019111216.1.I82eae759ca6dc28a245b043f485ca490e3015321@changeid>
 <20191120191813.GD4799@willie-the-truck>
In-Reply-To: <20191120191813.GD4799@willie-the-truck>
From:   Doug Anderson <dianders@chromium.org>
Date:   Mon, 2 Dec 2019 08:36:19 -0800
X-Gmail-Original-Message-ID: <CAD=FV=Wntf0TCwdtNNvPY-CXX1VL_SZK8Y8yw1r=UfeayHfwgw@mail.gmail.com>
Message-ID: <CAD=FV=Wntf0TCwdtNNvPY-CXX1VL_SZK8Y8yw1r=UfeayHfwgw@mail.gmail.com>
Subject: Re: [PATCH] ARM: hw_breakpoint: Handle inexact watchpoint addresses
To:     Will Deacon <will@kernel.org>
Cc:     Mark Rutland <mark.rutland@arm.com>,
        Pavel Labath <labath@google.com>,
        Pratyush Anand <panand@redhat.com>,
        Matthias Kaehlcke <mka@chromium.org>,
        Kazuhiro Inaba <kinaba@google.com>,
        Russell King <linux@armlinux.org.uk>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Wed, Nov 20, 2019 at 11:18 AM Will Deacon <will@kernel.org> wrote:
>
> On Sat, Oct 19, 2019 at 11:12:26AM -0700, Douglas Anderson wrote:
> > This is commit fdfeff0f9e3d ("arm64: hw_breakpoint: Handle inexact
> > watchpoint addresses") but ported to arm32, which has the same
> > problem.
> >
> > This problem was found by Android CTS tests, notably the
> > "watchpoint_imprecise" test [1].  I tested locally against a copycat
> > (simplified) version of the test though.
> >
> > [1] https://android.googlesource.com/platform/bionic/+/master/tests/sys_ptrace_test.cpp
> >
> > Signed-off-by: Douglas Anderson <dianders@chromium.org>
> > ---
> >
> >  arch/arm/kernel/hw_breakpoint.c | 96 ++++++++++++++++++++++++---------
> >  1 file changed, 70 insertions(+), 26 deletions(-)
>
> Sorry for taking so long to look at this. After wrapping my head around the
> logic again

Yeah.  It was a little weird and (unfortunately) arbitrarily different
in some places compared to the arm64 code.


> I think it looks fine, so please put it into the patch system
> with my Ack:
>
> Acked-by: Will Deacon <will@kernel.org>

Thanks!  Submitted as:

https://www.arm.linux.org.uk/developer/patches/viewpatch.php?id=8944/1


> One interesting difference between the implementation here and the arm64
> code is that I think if you have multiple watchpoints, all of which fire
> with a distance != 0, then arm32 will actually report them all whereas
> you'd only get one on arm64.

Are you sure about that?  The "/* No exact match found. */" code is
outside the for loop so it should only be able to trigger for exactly
one breakpoint, no?

-Doug
