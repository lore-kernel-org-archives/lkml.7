Return-Path: <SRS0=4ODY=VF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2EF2FC606CF
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Jul 2019 20:40:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F41E821707
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Jul 2019 20:40:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="VrhrRyUs"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405118AbfGHUkS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Jul 2019 16:40:18 -0400
Received: from mail-io1-f65.google.com ([209.85.166.65]:44906 "EHLO
        mail-io1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729212AbfGHUkS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Jul 2019 16:40:18 -0400
Received: by mail-io1-f65.google.com with SMTP id s7so38311199iob.11
        for <linux-kernel@vger.kernel.org>; Mon, 08 Jul 2019 13:40:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=o0JMAMSSYy4GxSN2yix27wmYhn/WlIZxfCVDhGj0R7o=;
        b=VrhrRyUspaRe/rJ+uDjJUK9XdWrRYfBMXl7rSykuozBRuSENQdCySqCjCsPiVS0W5N
         jZwgHbF3MXLC+Q0HPRE29Ek1KI3CW+6GF3eEhj3ZZbMkwZA4MQD3DkYAzcrmZ+rwKuF1
         DWjv+d5FZS1e7FZthcx+GNLMN7/rCN0sZV90Suux+LQJOH9zHtAg4kFXOWqDF7sQtcrC
         AccHghWrcEcX0eYwZ0FCXZF8yaD1PmA4e9Dh+KvRaNBOxXNBG0jLoublhyNuwtTPotlp
         pVWHjYB4Kq2kVm03vA6Dh+Shc4nhx7zJLDBFNeNUWSFpmZnkVbtH5Q+xGkTo/QWBY+eb
         igDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=o0JMAMSSYy4GxSN2yix27wmYhn/WlIZxfCVDhGj0R7o=;
        b=lKjvrfevCECZQjJ0xBxM1fkooyvwoMF9jJpin+KbbUImbAXrg6pU/i6riUJL5+lskC
         LIJI51YcOJ2UEK5DSeRUDgnTY7Q8QBEvUrCBjHRaEWLQwhr/F+v3tcjpdAlwbyXRgR75
         ISIeuynVhsV6ldGnhEQDTlCCDDKY2PKpgnJHwF7vCPHrJ4dEuqGe5UUYLNeTMTOsI8po
         oIFvQ4627jVxyetO+mBSA8hgpuh9iZvrt9a8UIdf1AHwb9G+RwxQg55rZUF81HpHOvL9
         I+OV9zspDiV6SgwcEZz+R7dNuvnVOpCYrgoGCCojGIOFBSbrVqT4+wczzDOnxUTH6Y0M
         a7Hg==
X-Gm-Message-State: APjAAAUsJztoOZSqn/rN9uJpxminB0qWYBEM64ZRsmWU8alM26+hmcSx
        M/TE/uPVBGEE0UozzowtKpgte5dOR4EAECWJbEIMqmIV5gk=
X-Google-Smtp-Source: APXvYqyUBwATdUOEC9GtJeUhEQhxDPI4A/ccvoj9P9fTmBcw/QOpH0M3ZWQD4kHnufBZjS94zfyblC4S5BfZWr3NM9A=
X-Received: by 2002:a5e:8618:: with SMTP id z24mr21944628ioj.174.1562618417361;
 Mon, 08 Jul 2019 13:40:17 -0700 (PDT)
MIME-Version: 1.0
References: <20190703100349.12893-1-r.czerwinski@pengutronix.de>
In-Reply-To: <20190703100349.12893-1-r.czerwinski@pengutronix.de>
From:   Jens Wiklander <jens.wiklander@linaro.org>
Date:   Mon, 8 Jul 2019 22:40:06 +0200
Message-ID: <CAHUa44FU-B5FVE7_tsmuMsvN3ftrVytpijYPknX7vi-277n7ag@mail.gmail.com>
Subject: Re: [PATCH] tee: optee: add might_sleep for RPC requests
To:     Rouven Czerwinski <r.czerwinski@pengutronix.de>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "tee-dev @ lists . linaro . org" <tee-dev@lists.linaro.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Rouven,

On Wed, Jul 3, 2019 at 12:04 PM Rouven Czerwinski
<r.czerwinski@pengutronix.de> wrote:
>
> If the kernel is compiled with CONFIG_PREEMPT_VOLUNTARY and OP-TEE is
> executing a long running workload, the following errors are raised:
>
> [ 1705.971228] rcu: INFO: rcu_sched detected stalls on CPUs/tasks:
> [ 1705.977195] rcu:     (detected by 0, t=2102 jiffies, g=51977, q=3)
> [ 1705.983152] rcu: All QSes seen, last rcu_sched kthread activity 2102 (140596-138494), jiffies_till_next_fqs=1, root ->qsmask 0x0
> [ 1705.994729] optee-xtest     R  running task        0   169    157 0x00000002
>
> While OP-TEE is returning regulary to the kernel due to timer
> interrrupts, the OPTEE_SMC_FUNC_FOREIGN_INTR case does not contain an
> explicit rescheduling point. Add a might_sleep() to the RPC request case
> to ensure that the kernel can reschedule another task if OP-TEE requests
> RPC handling.
>
> Signed-off-by: Rouven Czerwinski <r.czerwinski@pengutronix.de>
> ---
>  drivers/tee/optee/call.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/drivers/tee/optee/call.c b/drivers/tee/optee/call.c
> index aa942703ae65..13b0269a0abc 100644
> --- a/drivers/tee/optee/call.c
> +++ b/drivers/tee/optee/call.c
> @@ -148,6 +148,7 @@ u32 optee_do_call_with_arg(struct tee_context *ctx, phys_addr_t parg)
>                          */
>                         optee_cq_wait_for_completion(&optee->call_queue, &w);
>                 } else if (OPTEE_SMC_RETURN_IS_RPC(res.a0)) {
> +                       might_sleep();
>                         param.a0 = res.a0;
>                         param.a1 = res.a1;
>                         param.a2 = res.a2;
> --
> 2.20.1
>

Looks good. I'll pick this up and fix the spell errors in the commit message.

Thanks,
Jens
