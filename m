Return-Path: <SRS0=/uHP=YM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DC775CA9EA0
	for <linux-kernel@archiver.kernel.org>; Sat, 19 Oct 2019 02:25:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B1C78222C3
	for <linux-kernel@archiver.kernel.org>; Sat, 19 Oct 2019 02:25:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1571451955;
	bh=4XDUJxMNCgCupT7NdyY25ZhBT6OezxSlM+sx+22CD1Q=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=DKjB8sCtDTKSLqqmNNdKM6yHgsOKPoyw0qjsFVK3kIAPWB1G+d/OYbTF0v4uOnlM7
	 TVZLQin1vUZI9in/2+n8wWOCXSRkFkDcWE2nS5satP2tfAbK5st65UKn8lYE26jljl
	 na1sl57dXofCNOz/h1qC9UxFvybUEQobUos0c3Fs=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726924AbfJSCZx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 18 Oct 2019 22:25:53 -0400
Received: from mail-lj1-f194.google.com ([209.85.208.194]:46300 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726859AbfJSCZx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Oct 2019 22:25:53 -0400
Received: by mail-lj1-f194.google.com with SMTP id d1so7969217ljl.13
        for <linux-kernel@vger.kernel.org>; Fri, 18 Oct 2019 19:25:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=gjLg2/6XamYpLjzYfdfmurPFPuRSEvclpGmkEKntTPU=;
        b=Y3VPSbUOalW+13nCDuxT2Ug0pzldDUHE2ml6ey872TES+TNdpfprxNuEtcGt4ELtx9
         fuwCzjl9gCDXeTAE+hj/1zx0vnRGCe9OXrA3T/DWGajCTz5nvgIM33WrlvcenvGaE3Ia
         nOFQIlD8DL5aSGai/hsDeY9Y4GxLiBBQuo0EM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=gjLg2/6XamYpLjzYfdfmurPFPuRSEvclpGmkEKntTPU=;
        b=dEHmKcsaNnR8SpRDzDSB1n7EL7ZQ3C3+OLDnPnGKAl7m4qxqS/Yn5Vnwl68Wz539Fe
         D4AhLNYlQqr/vZ6lFQkGCDCMBSGxJVrNNtEtrAdBMVdMfpVRnSeRBMVCbLNn4qFu1qeN
         EctpDjAV4p0xDYUa7ciQ+FawAhxObPswjEy0/AhP5Jym8o3mFmbkIC15/huLcc7XUqMu
         TuVkdMZa3RBEkhVuVwvEt6X8d2ji6Xkj2bIW41gKjESunmWA+kbdd+rtBdsUox4y3k0V
         8t+DZ7TmWY2xVre1wzdWkqsjWpLGhBaCVjjI74eC8ro6jfPbkNcAb6j29YkIEB9DKuEU
         Z9uw==
X-Gm-Message-State: APjAAAV5LJYd17BjNGMGivNtqWrR5kdSFCwPJIx0JfCWorUE2c8JFgHQ
        fsO7ga9Q4ugzgoh32jVEvvB8rfzPdew=
X-Google-Smtp-Source: APXvYqzYPAILerhKDNBBM/GqzJM85IInvc5vPJuwUGqycRrAvPjM8nousE1AhnyXsenxmDyT69JGGw==
X-Received: by 2002:a2e:86cd:: with SMTP id n13mr1254417ljj.252.1571451949531;
        Fri, 18 Oct 2019 19:25:49 -0700 (PDT)
Received: from mail-lj1-f181.google.com (mail-lj1-f181.google.com. [209.85.208.181])
        by smtp.gmail.com with ESMTPSA id u26sm3428769lfd.19.2019.10.18.19.25.48
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 18 Oct 2019 19:25:48 -0700 (PDT)
Received: by mail-lj1-f181.google.com with SMTP id n14so7991178ljj.10
        for <linux-kernel@vger.kernel.org>; Fri, 18 Oct 2019 19:25:48 -0700 (PDT)
X-Received: by 2002:a2e:9117:: with SMTP id m23mr7994874ljg.82.1571451947966;
 Fri, 18 Oct 2019 19:25:47 -0700 (PDT)
MIME-Version: 1.0
References: <20191018203704.GC31027@cork> <20191018204220.GD31027@cork>
In-Reply-To: <20191018204220.GD31027@cork>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Fri, 18 Oct 2019 22:25:32 -0400
X-Gmail-Original-Message-ID: <CAHk-=wi80VJ+4cUny2kwm0RxrmVdh24VPz5ZHjY4qCWR5iQBDQ@mail.gmail.com>
Message-ID: <CAHk-=wi80VJ+4cUny2kwm0RxrmVdh24VPz5ZHjY4qCWR5iQBDQ@mail.gmail.com>
Subject: Re: [PATCH] random: make try_to_generate_entropy() more robust
To:     =?UTF-8?Q?J=C3=B6rn_Engel?= <joern@purestorage.com>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 18, 2019 at 4:42 PM J=C3=B6rn Engel <joern@purestorage.com> wro=
te:
>
> We can generate entropy on almost any CPU, even if it doesn't provide a
> high-resolution timer for random_get_entropy().  As long as the CPU is
> not idle, it changed the register file every few cycles.  As long as the
> ALU isn't fully synchronized with the timer, the drift between the
> register file and the timer is enough to generate entropy from.

>  static void entropy_timer(struct timer_list *t)
>  {
> +     struct pt_regs *regs =3D get_irq_regs();
> +
> +     /*
> +      * Even if we don't have a high-resolution timer in our system,
> +      * the register file itself is a high-resolution timer.  It
> +      * isn't monotonic or particularly useful to read the current
> +      * time.  But it changes with every retired instruction, which
> +      * is enough to generate entropy from.
> +      */
> +     mix_pool_bytes(&input_pool, regs, sizeof(*regs));

Ok, so I still like this conceptually, but I'm not entirely sure that
get_irq_regs() works reliably in a timer. It's done from softirq
TIMER_SOFTIRQ context, so not necessarily _in_ an interrupt.

Now, admittedly this code doesn't really need "reliably". The odd
occasional hickup would arguably just add more noise. And I think the
code works fine. get_irq_regs() will return a pointer to the last
interrupt or exception frame on the current CPU, and I guess it's all
fine. But let's bring in Thomas, who was not only active in the
randomness discussion, but might also have stronger opinions on this
get_irq_regs() usage.

Thomas, opinions? Using the register state (while we're doing the
whole entropy load with scheduling etc) looks like a good source of
high-entropy data outside of just the TSC, so it does seem like a very
valid model. But I want to run it past more people first, and Thomas
is the obvious victim^Wchoice.

              Linus
