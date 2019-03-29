Return-Path: <SRS0=SA5R=SA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0EA73C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Mar 2019 16:19:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CFC74218A3
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Mar 2019 16:19:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="C4ks38dk"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729689AbfC2QTT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 29 Mar 2019 12:19:19 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:52848 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728839AbfC2QTS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Mar 2019 12:19:18 -0400
Received: by mail-wm1-f65.google.com with SMTP id a184so3109023wma.2
        for <linux-kernel@vger.kernel.org>; Fri, 29 Mar 2019 09:19:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=LYd48GLm76RNcVQs4i+gAMwkQz6rMYUcGPDpnr3oUI4=;
        b=C4ks38dkiOwmMeTZpv1vrTkBNwFJr2oxk/x5+5YVAKFaiseBHMPG3NFWu3B2mtPUi9
         tqI05KO7SKMWv8SeTasRpZKF0pb2amZZeVRHmu5iNz2n/0u9/DXutfyHVUV5Kzfo1cJ+
         r8cpbuYzt3yNYLAdwSth+AyhoSECqq+xqAaueARsRe4u/z73dSIifXhbbK4Yi8PpaIcA
         6h83lw+eQ799iet3UeQc8WyY+skfxlEYdIeXc4wQ3r9coNbmvzkI07zKuKyGbwArWnCx
         l+Kv0ajrZrfO0xCW2zqhXHY0wVAWF1GJLDtzBjUAdEUYdBv5r/OuL8A7m5V5Cy7meWNj
         5xVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=LYd48GLm76RNcVQs4i+gAMwkQz6rMYUcGPDpnr3oUI4=;
        b=E7p28X8QkxxTFVGxq9pr1ZoAPSc/kJgTwZ2tvYYNItXQaQiuyuufTuNwLQRyLPXxKq
         Fmy1L8eVUeCVeQRKoKDokHNlXv0X06BAGFkhBNBCzJKkOpRBFRemaaGAukio+uF0UPfd
         IKII91sadhrxsY6RsLlstfhzrJF6mHHrXNM/422q1qp/hqzPUH+nVSM3c5CTH+EYLtP7
         4z+rjCH6DtsjP03ys5lq4BgkVX+UsrJ2IFaUiFm7PLvSrpeRynEs0ADsB+KQZAXOCNAV
         5Ew7EkQIUrx5WZeIYT4r8IpN4FGcEEKFXa+uf3bRFEwdIWEkGCnJiqAjAQ6czTSMs2rl
         9CtA==
X-Gm-Message-State: APjAAAVWjdRwwSVHvBRG5HRtVXobjm9ZiGMhKe/+liHvK8LmeLBEn9l/
        67daelBUngWL/8fs280eYuGIxpJ3GSY1LbSj+cc=
X-Google-Smtp-Source: APXvYqyU+mhhPaY+EcEqERFll4Mwft+zWEL/u9LfPUOJMXgm7XZp8UMu/mitzLZQmiKN3xJC+/vjNR4PCqiYGyACQ1U=
X-Received: by 2002:a7b:c404:: with SMTP id k4mr4350292wmi.117.1553876357162;
 Fri, 29 Mar 2019 09:19:17 -0700 (PDT)
MIME-Version: 1.0
References: <1553865808-30604-1-git-send-email-yuzenghui@huawei.com>
 <237b00d0-8a8d-ede6-91b1-c3e23e61925c@arm.com> <20190329105332.6b7fc1ae@gandalf.local.home>
 <e08f603a-29d4-07a7-35b9-68fcdf50b338@huawei.com> <20190329114558.586a4f84@gandalf.local.home>
In-Reply-To: <20190329114558.586a4f84@gandalf.local.home>
From:   Zenghui Yu <zenghuiyu96@gmail.com>
Date:   Sat, 30 Mar 2019 00:19:05 +0800
Message-ID: <CAKcZhuUZka1qNyzBqSLbR_Z+_q=DkoidSrGGmYnzamrWai8OjQ@mail.gmail.com>
Subject: Re: [RFC PATCH] irqchip/gic-v3: Make gic_handle_irq() notrace
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Zenghui Yu <yuzenghui@huawei.com>,
        Mark Rutland <mark.rutland@arm.com>, julien.thierry@arm.com,
        Marc Zyngier <marc.zyngier@arm.com>, catalin.marinas@arm.com,
        suzuki.poulose@arm.com, Will Deacon <will.deacon@arm.com>,
        linux@armlinux.org.uk, LKML <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@redhat.com>, james.morse@arm.com,
        wanghaibin.wang@huawei.com, linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 29, 2019 at 11:46 PM Steven Rostedt <rostedt@goodmis.org> wrote:
>
> On Fri, 29 Mar 2019 23:35:59 +0800
> Zenghui Yu <yuzenghui@huawei.com> wrote:
>
> > Hi Steven,
> >
> > On 2019/3/29 22:53, Steven Rostedt wrote:
> > > On Fri, 29 Mar 2019 13:58:40 +0000
> > > Marc Zyngier <marc.zyngier@arm.com> wrote:
> > >
> > >> On the other hand, if you can generate pseudo-NMIs, you could end-up
> > >> tracing gic_handle_irq whilst being inside the tracing code with
> > >> interrupts being notionally disabled (and that could be pretty bad).
> > >
> > > Actually, that should still be safe. The tracing code is expected to
> > > trace NMIs.
> > >
> > > Now the entry of an NMI can be an issue because of the way tracing is
> > > enabled. But this would also cause function tracing to crash, which was
> > > not stated. Does function tracing have the same issue, or is this just
> > > with function_graph tracing?
> >
> > This is just with function_graph tracing. Function tracing works fine.
>
> Then we can rule out the break point issue.
>
> >
> > >
> > > This is because a breakpoint is added to all the places that are going
> > > to be traced so that the "nops" at the beginning of function calls are
> > > going to be converted to calls to the tracer. Now that means a
> > > breakpoint is being added at the beginning of gic_handle_irq(). I don't
> > > know how this pseudo NMI works, but we have notrace set for do_NMI
> > > because breakpoints at the entry (before it can fix things) causes
> > > issues. But this still doesn't make sense because the gic_handle_irq()
> > > call doesn't fix things up either, so other functions that are traced
> > > by gic_handle_irq() should blow up too, which appears (by the patch)
> > > not to be the case.
> >
> > Thanks for your explanation. I will read the code around further, and
> > get back to you if there's any discovery.
>
> Well, if it only affects function_graph tracing, then we don't need to
> investigate the break point issue. If it was the break point issue, it
> would cause function tracing to break too.

OK.

>
> Also, which architecture is this for? ARM or ARM64?

on ARM64.


thanks,

zenghui
