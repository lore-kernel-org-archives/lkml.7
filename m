Return-Path: <SRS0=B1dt=RW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 43038C43381
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Mar 2019 06:29:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 09AED20872
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Mar 2019 06:29:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="aCujGM4u"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726851AbfCSG3i (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Mar 2019 02:29:38 -0400
Received: from mail-ua1-f65.google.com ([209.85.222.65]:42537 "EHLO
        mail-ua1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725988AbfCSG3i (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Mar 2019 02:29:38 -0400
Received: by mail-ua1-f65.google.com with SMTP id s26so6093871uao.9
        for <linux-kernel@vger.kernel.org>; Mon, 18 Mar 2019 23:29:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Udb7CEzMieQ1Ow6EJ3APNAoMu6rNd7q0c4Yhfz+6yaI=;
        b=aCujGM4uvrizQnYgYmS0PDKAFRVvuCV2hegJLG3qSyIIql2V41/ie/ZcXKby2tRZ/X
         eEPuNOE1MvmpLjVgw0VcFct+p2VaN5gt8l6ipVKVy77Ma+so33pFI8W/JT/6spPxs4Zb
         mM0nJK9LYahXSfNrQ8YN3qJUU7++ZPosU6Gs7o77bU4ckYVnty4mrNPMi4oUVCzz9NrH
         aiXaBzxrdsNgkIOiakLVLxWP+VeRK1sbZxC0MUgQ+NLqsdg/Mipd9pUVRW50BKXIx9HS
         PkaH0DgaoCrrmZawVIAI7d4kGfnCoAaAjBnG3PJNSIiIF98PraFFQkJRExLOYe/OqPco
         a25Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Udb7CEzMieQ1Ow6EJ3APNAoMu6rNd7q0c4Yhfz+6yaI=;
        b=e0DzxKCnPsIsLm4AbRQ4kg0BcVFKB0GvsJPbdHp7FcTqrTa2FC9JVFspaNlyBGw45i
         e7bOKebY2IoVxqPJIEbmOicJgVVlnfCx2Yyrkj6ZLR1L00171glMLXUGi9Tm924VsKfA
         U6Zb1oaV2jATKrbiCJc//Mq/Hr8KxqcsCj/e6emk9FJWMpdMR82cbdxFQh2nU6Dwc30e
         G51T/A4aQTAJCB7C0KnX7GeE466lMVD14wf3R2PzxMVsw+diB4DnnvYajEpYSL7EsWrj
         HCv89EoNoe5ffdi+UTLfbRMmUiee6GHrdxrkeh4AhCp8CcjaEjtYOVy1Lt8zRASfwqjr
         U+Hw==
X-Gm-Message-State: APjAAAVk1WDKMH2ggqD1ZFw7Mm3jPaK9nVrbHUmrcY9cyyWx6BWN+esF
        jHTZFqG7zPfC32du7HQeFemGRp9O0GUY0vLq0+DRVg==
X-Google-Smtp-Source: APXvYqxRySojNxfX/WupvGobA922i+K3IMx6byfXtBbZI9OzjrmFzIh+u1+i8ENqrSvvgiTBOkvyUIrbDsM3GQxiLSM=
X-Received: by 2002:ab0:6193:: with SMTP id h19mr352463uan.47.1552976976539;
 Mon, 18 Mar 2019 23:29:36 -0700 (PDT)
MIME-Version: 1.0
References: <20190314130113.919278615@infradead.org> <20190314130705.441549378@infradead.org>
In-Reply-To: <20190314130705.441549378@infradead.org>
From:   Stephane Eranian <eranian@google.com>
Date:   Mon, 18 Mar 2019 23:29:25 -0700
Message-ID: <CABPqkBT9=XRLinbhA0T5iztM6NGd5fO39-kQoB5j3Evfvfh2yA@mail.gmail.com>
Subject: Re: [PATCH 1/8] perf/x86/intel: Fix memory corruption
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Ingo Molnar <mingo@kernel.org>, Jiri Olsa <jolsa@redhat.com>,
        LKML <linux-kernel@vger.kernel.org>, tonyj@suse.com,
        nelson.dsouza@intel.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 14, 2019 at 6:11 AM Peter Zijlstra <peterz@infradead.org> wrote:
>
> Through:
>
>   validate_event()
>     x86_pmu.get_event_constraints(.idx=-1)
>       tfa_get_event_constraints()
>         dyn_constraint()
>
> We use cpuc->constraint_list[-1], which is an obvious out-of-bound
> access.
>
> In this case, simply skip the TFA constraint code, there is no event
> constraint with just PMC3, therefore the code will never result in the
> empty set.
>
> Reported-by: Tony Jones <tonyj@suse.com>
> Reported-by: "DSouza, Nelson" <nelson.dsouza@intel.com>
> Tested-by: Tony Jones <tonyj@suse.com>
> Tested-by: "DSouza, Nelson" <nelson.dsouza@intel.com>
> Cc: stable@kernel.org
> Fixes: 400816f60c54 ("perf/x86/intel: Implement support for TSX Force Abort")
> Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
> ---
>  arch/x86/events/intel/core.c |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> --- a/arch/x86/events/intel/core.c
> +++ b/arch/x86/events/intel/core.c
> @@ -3410,7 +3410,7 @@ tfa_get_event_constraints(struct cpu_hw_
>         /*
>          * Without TFA we must not use PMC3.
>          */
> -       if (!allow_tsx_force_abort && test_bit(3, c->idxmsk)) {
> +       if (!allow_tsx_force_abort && test_bit(3, c->idxmsk) && idx >= 0) {
>                 c = dyn_constraint(cpuc, c, idx);
>                 c->idxmsk64 &= ~(1ULL << 3);
>                 c->weight--;
>
>
I was not cc'd on the patch that added  allow_tsx_force_abort, so I
will give some comments here.
If I understand the goal of the control parameter it is to turn on/off
the TFA workaround and thus determine
whether or not PMC3 is available. I don't know why you would need to
make this a runtime tunable. That
seems a bit dodgy. But given the code you have here right now, we have
to deal with it. A sysadmin could
flip the control at any time, including when PMC3 is already in used
by some events. I do not see the code
that schedules out all the events on all CPUs once PMC3 becomes
unavailable. You cannot just rely on the
next context-switch or timer tick for multiplexing.
