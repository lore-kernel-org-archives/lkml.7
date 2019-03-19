Return-Path: <SRS0=B1dt=RW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC740C43381
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Mar 2019 23:43:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 92442217F4
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Mar 2019 23:43:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="PBWwEdAt"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727418AbfCSXnR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Mar 2019 19:43:17 -0400
Received: from mail-vk1-f193.google.com ([209.85.221.193]:37500 "EHLO
        mail-vk1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726801AbfCSXnR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Mar 2019 19:43:17 -0400
Received: by mail-vk1-f193.google.com with SMTP id p190so131002vke.4
        for <linux-kernel@vger.kernel.org>; Tue, 19 Mar 2019 16:43:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=+8NxUn8rc+NfZNElfur2lvJ3hgMei73HKVYJaiKIlbs=;
        b=PBWwEdAtPcUN8KrM2EIrlATIGLE9SIDHmwgWnaZfw46U7UR9fEw5lz6v4PeDzRya7L
         yTnUxNbV993uffsYASgBaPnZTTE7XTHrrEV8xVkPBuJsNXtGiIIOuP4bnDIxQzJQ6nU0
         GFQ9EwPAPT2QmPey436rAPJSyol5NGmCZ4InsbGXWs1MYjOUHlaVG27W/+BbBoarpwEL
         kWqX+pKxToAZWqYYvmx57ygSK/N9A7YafzFPXLyi73yH7CP3BfYoIgASRXhHMhsVMSSD
         7EslW0BRza49cbqAlyLd5Q8HaSBoOreBnRl3Wlyryy+shk/prfC/vOEY8vK7w80Fo1TZ
         UhxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=+8NxUn8rc+NfZNElfur2lvJ3hgMei73HKVYJaiKIlbs=;
        b=WVClAh21O/EbSGPUqaZUMQegeWtBLbA/IX/pa4yvEqwKs5M0LF5GbpiSHX1y/veWsv
         Ir45zQIJSSe5dLKsfQYyn7PS1HzzJUx6KS4ffllrNeuw8p50HpsrN/hNMxi70xidEoZb
         +y9zjLnZAc9juvYd546cN7/UbX569xJlFkRrMMN/vgZZ76sW1dHSRsLvjzACrV5KOgh1
         /ysWPgTmjhb0UvkcbU7wESgbcTm1wrnmNira7J4sFfxLKFqUR6FOdb0EIdD6G6N1Laxv
         kTvgOA4HK7Q3N5fAJiVMtYIWA9CdgLQkeK/+3HQBPoPgKpxHAzep56DyIw91zxK6QdRc
         uZIA==
X-Gm-Message-State: APjAAAXWiJ23Vg3/b0d6jgg/wwpbYDntM2AxISMuQkjoSnZ487fOBxSJ
        tymI/gyzCIFtERsECAzE2lbEi0brj0OWv+cTwgB9ow==
X-Google-Smtp-Source: APXvYqwUlmineMJ1xgVKn4sHVEqVTD/kfI0M9vZfkHihyTeIGGe//Q76Z7Zo1LDKdTkleHgYbTkOniocr61YFzOVcwk=
X-Received: by 2002:a1f:b3c5:: with SMTP id c188mr3090946vkf.14.1553038995735;
 Tue, 19 Mar 2019 16:43:15 -0700 (PDT)
MIME-Version: 1.0
References: <20190314130113.919278615@infradead.org> <20190314130705.852659665@infradead.org>
In-Reply-To: <20190314130705.852659665@infradead.org>
From:   Stephane Eranian <eranian@google.com>
Date:   Tue, 19 Mar 2019 16:43:04 -0700
Message-ID: <CABPqkBTdPh9yHYyu3nVkTNMi-CG2Z6euAomuNCCSJExC6mg6eA@mail.gmail.com>
Subject: Re: [RFC][PATCH 5/8] perf/x86/intel: Optimize intel_get_excl_constraints()
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
> Avoid the POPCNT by noting we can decrement the weight for each
> cleared bit.
>
> Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Looks good to me.
Reviewed-by: Stephane Eranian <eranian@google.com>

> ---
>  arch/x86/events/intel/core.c |   22 +++++++++++++---------
>  1 file changed, 13 insertions(+), 9 deletions(-)
>
> --- a/arch/x86/events/intel/core.c
> +++ b/arch/x86/events/intel/core.c
> @@ -2838,7 +2838,7 @@ intel_get_excl_constraints(struct cpu_hw
>         struct intel_excl_cntrs *excl_cntrs = cpuc->excl_cntrs;
>         struct intel_excl_states *xlo;
>         int tid = cpuc->excl_thread_id;
> -       int is_excl, i;
> +       int is_excl, i, w;
>
>         /*
>          * validating a group does not require
> @@ -2894,36 +2894,40 @@ intel_get_excl_constraints(struct cpu_hw
>          * SHARED   : sibling counter measuring non-exclusive event
>          * UNUSED   : sibling counter unused
>          */
> +       w = c->weight;
>         for_each_set_bit(i, c->idxmsk, X86_PMC_IDX_MAX) {
>                 /*
>                  * exclusive event in sibling counter
>                  * our corresponding counter cannot be used
>                  * regardless of our event
>                  */
> -               if (xlo->state[i] == INTEL_EXCL_EXCLUSIVE)
> +               if (xlo->state[i] == INTEL_EXCL_EXCLUSIVE) {
>                         __clear_bit(i, c->idxmsk);
> +                       w--;
> +                       continue;
> +               }
>                 /*
>                  * if measuring an exclusive event, sibling
>                  * measuring non-exclusive, then counter cannot
>                  * be used
>                  */
> -               if (is_excl && xlo->state[i] == INTEL_EXCL_SHARED)
> +               if (is_excl && xlo->state[i] == INTEL_EXCL_SHARED) {
>                         __clear_bit(i, c->idxmsk);
> +                       w--;
> +                       continue;
> +               }
>         }
>
>         /*
> -        * recompute actual bit weight for scheduling algorithm
> -        */
> -       c->weight = hweight64(c->idxmsk64);
> -
> -       /*
>          * if we return an empty mask, then switch
>          * back to static empty constraint to avoid
>          * the cost of freeing later on
>          */
> -       if (c->weight == 0)
> +       if (!w)
>                 c = &emptyconstraint;
>
> +       c->weight = w;
> +
>         return c;
>  }
>
>
>
