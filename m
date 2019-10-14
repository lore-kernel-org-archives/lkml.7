Return-Path: <SRS0=TxL2=YH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EABA5ECE58E
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Oct 2019 11:53:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C2E342084B
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Oct 2019 11:53:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="YhJw+dAD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731322AbfJNLxJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 14 Oct 2019 07:53:09 -0400
Received: from mail-lj1-f193.google.com ([209.85.208.193]:34018 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730314AbfJNLxJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Oct 2019 07:53:09 -0400
Received: by mail-lj1-f193.google.com with SMTP id j19so16362208lja.1
        for <linux-kernel@vger.kernel.org>; Mon, 14 Oct 2019 04:53:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=BUUSXCx6hkqJbTEWpOdC3FCy26W6ddQaFzU+/nbRFVg=;
        b=YhJw+dADb1GVJrtNlGRG/Y2ls1HP18kIPeidp6Po7LqQHPgDXNvFowqAC5pRd2b+ra
         eDYteQDZ/kNlq2ma7V1mrjosG0xqe5HzfX8QxkdKb2Sw+e+tskaf4MRnSSB0A9y9ymGR
         TX/H46WAUITyWlFBjvXWC1Dgx1OV1xoCrScv8XA84hYySIjqUKrqazRvbVGaHFi2Aubc
         QbvN/rhu6irogrlFCACX8KaCCD0U6qqukDk60xBeil5vO9VAMP9vzKD6ABoqL+7Te5x5
         r3QmpYDcWnhUrXtQ6LY81UX7UpDq+HJ+2JzPawwphbOr9UZuVGQ8XRUD/UoH9qKlTgtT
         8XNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=BUUSXCx6hkqJbTEWpOdC3FCy26W6ddQaFzU+/nbRFVg=;
        b=n7hW2zwK1A7B7GP1mF6nhFG1j+h+w5jg7s8h9xmCGRx4Q6YRzvzt98o2pTkGlBqU6u
         I1krJXdnOmw/cDsJ4dJ+4IOZeku911hMppbAENrfxCrK/W3N3cgnP2/7J9b73fKpQOIk
         zbDbNkLSfrWTwEfa13B8sxd2kgXEyUAsttjeCo50zItJg3pFQHQNckVZoS2WyF8twW/E
         VMsEsGgBBfAY6jCxMKBzMi1ALN6GjzZ/yK5wWtQbILWo7sZOJxalAiAfEuU3uVbAhpUz
         IhOq/fIBJSp+0sACC0DuNw4FHVhf5mIoEMVntDBv4SoD3PVCRDHz1rPtg9CSgoVVi9he
         FjcA==
X-Gm-Message-State: APjAAAVKsvwfqmnG6ckdPVETCMiAYlnFE4JGOjvUGVJaQSxA7UTBLzOi
        jBWOjNiZtNq6eQ+0f3scrbIfdSvk8KP5jWculxTgdg==
X-Google-Smtp-Source: APXvYqz8u5CvuNfqAA4R48grRt6sZXO4XODyM/njd2C+ebU9VV7lVNOLV1asO7f0AmCDGt9XNJlYDIVpjW788PlsTlE=
X-Received: by 2002:a2e:978e:: with SMTP id y14mr5840922lji.206.1571053985940;
 Mon, 14 Oct 2019 04:53:05 -0700 (PDT)
MIME-Version: 1.0
References: <20191014114710.22142-1-valentin.schneider@arm.com>
In-Reply-To: <20191014114710.22142-1-valentin.schneider@arm.com>
From:   Vincent Guittot <vincent.guittot@linaro.org>
Date:   Mon, 14 Oct 2019 13:52:54 +0200
Message-ID: <CAKfTPtCtT8+qTHSvwBXfV1A6e4V_m=A7JmS_g9QWY4AGAvWtpQ@mail.gmail.com>
Subject: Re: [PATCH] sched/topology: Disable sched_asym_cpucapacity on domain destruction
To:     Valentin Schneider <valentin.schneider@arm.com>
Cc:     linux-kernel <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Dietmar Eggemann <Dietmar.Eggemann@arm.com>,
        Morten Rasmussen <morten.rasmussen@arm.com>,
        Quentin Perret <qperret@qperret.net>,
        "# v4 . 16+" <stable@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 14 Oct 2019 at 13:47, Valentin Schneider
<valentin.schneider@arm.com> wrote:
>
> While the static key is correctly initialized as being disabled, it will
> remain forever enabled once turned on. This means that if we start with an
> asymmetric system and hotplug out enough CPUs to end up with an SMP system,
> the static key will remain set - which is obviously wrong. We should detect
> this and turn off things like misfit migration and EAS wakeups.
>
> Having that key enabled should also mandate
>
>   per_cpu(sd_asym_cpucapacity, cpu) != NULL
>
> for all CPUs, but this is obviously not true with the above.
>
> On top of that, sched domain rebuilds first lead to attaching the NULL
> domain to the affected CPUs, which means there will be a window where the
> static key is set but the sd_asym_cpucapacity shortcut points to NULL even
> if asymmetry hasn't been hotplugged out.
>
> Disable the static key when destroying domains, and let
> build_sched_domains() (re) enable it as needed.
>
> Cc: <stable@vger.kernel.org>
> Fixes: df054e8445a4 ("sched/topology: Add static_key for asymmetric CPU capacity optimizations")
> Signed-off-by: Valentin Schneider <valentin.schneider@arm.com>

Acked-by: Vincent Guittot <vincent .guittot@linaro.org>

> ---
>  kernel/sched/topology.c | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/kernel/sched/topology.c b/kernel/sched/topology.c
> index b5667a273bf6..c49ae57a0611 100644
> --- a/kernel/sched/topology.c
> +++ b/kernel/sched/topology.c
> @@ -2123,7 +2123,8 @@ static void detach_destroy_domains(const struct cpumask *cpu_map)
>  {
>         int i;
>
> +       static_branch_disable_cpuslocked(&sched_asym_cpucapacity);
> +
>         rcu_read_lock();
>         for_each_cpu(i, cpu_map)
>                 cpu_attach_domain(NULL, &def_root_domain, i);
> --
> 2.22.0
>
