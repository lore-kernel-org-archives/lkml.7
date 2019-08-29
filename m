Return-Path: <SRS0=brkd=WZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B608C3A5A6
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Aug 2019 16:22:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 46CD420673
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Aug 2019 16:22:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="MJf9BBcy"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727921AbfH2QWe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 29 Aug 2019 12:22:34 -0400
Received: from mail-pl1-f194.google.com ([209.85.214.194]:39685 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726784AbfH2QWb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Aug 2019 12:22:31 -0400
Received: by mail-pl1-f194.google.com with SMTP id az1so830734plb.6
        for <linux-kernel@vger.kernel.org>; Thu, 29 Aug 2019 09:22:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=DdYdr6DVDvibDIbEnZ+Q/sFh6e07cbxVBi1D1KZkmHE=;
        b=MJf9BBcyqCSmz7DipJUqJz/xmbD2RMq8TlbsXLYyknI2/0T4sCih77zexM22p6fsD3
         VOPAg2s0nfw8HvC8gmJEGh9S9voz26Mj3HsS7XxBCflzRa13tqP18CtWMY6VEaoBkog3
         mNx/zUBmuYAX2/7CbnUK9IipcaT+gshqRGuX8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=DdYdr6DVDvibDIbEnZ+Q/sFh6e07cbxVBi1D1KZkmHE=;
        b=GZ3cZXgRgfhk5a8Ts+UJiz2RxeyDHrVgLEC6/TQvPjUeo2HE3rGqwBdKzN93jQ4xod
         tnZbV+WAufQFMFxy9qfJLa0yrtsdOUrVWrI5F2SC6IXBr0wE+taK0GGDYsedGSkHtqNO
         O6tZYHrODQjN1TiinLCEQiIUTloDLS6dT8HxBFHPXsm0Pw19pOIeW5fHp6rIjUxoKbCW
         0uI4V9IT9kZwPCxcoI/zMQ7TDZbqxQ7wfi89SjFUUccd7wX9fOAoIZKu5QGrZ29qACsR
         h7HhR7khk9gSS7JWr/DuL5FaSf4vQYy7m/lzoWi2FJAG2Maw6cHw6y948FK07W4uSXvj
         8vcw==
X-Gm-Message-State: APjAAAV4L4PzTV2mxiy+bv+wKhBXM7NsW0A71z8xOyrPmlV6zi1dTkzf
        jz6CsmA6bttbMu3Y4LUupebllw==
X-Google-Smtp-Source: APXvYqyYQQq2IoRQtC1ZL2R4vak6Z1iGu18iUN+0L1VB1/kKRn+IH73nQqod3Fcbj/NJatoGlKaF2g==
X-Received: by 2002:a17:902:a607:: with SMTP id u7mr10863720plq.43.1567095750695;
        Thu, 29 Aug 2019 09:22:30 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id t189sm4180836pfd.58.2019.08.29.09.22.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Aug 2019 09:22:29 -0700 (PDT)
Date:   Thu, 29 Aug 2019 09:22:28 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Hsin-Yi Wang <hsinyi@chromium.org>
Cc:     Stephen Boyd <swboyd@chromium.org>,
        "Theodore Y . Ts'o" <tytso@mit.edu>,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>,
        Russell King <linux@armlinux.org.uk>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H . Peter Anvin" <hpa@zytor.com>,
        "Paul E . McKenney" <paulmck@linux.vnet.ibm.com>,
        Kate Stewart <kstewart@linuxfoundation.org>,
        "David S . Miller" <davem@davemloft.net>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Arnd Bergmann <arnd@arndb.de>, Marc Zyngier <maz@kernel.org>,
        Julien Thierry <julien.thierry.kdev@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Wei Li <liwei391@huawei.com>,
        Anders Roxell <anders.roxell@linaro.org>,
        Rob Herring <robh@kernel.org>,
        Aaro Koskinen <aaro.koskinen@nokia.com>,
        Daniel Thompson <daniel.thompson@linaro.org>,
        Tim Chen <tim.c.chen@linux.intel.com>,
        Rik van Riel <riel@surriel.com>,
        Waiman Long <longman@redhat.com>,
        Marcelo Tosatti <mtosatti@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Armijn Hemel <armijn@tjaldur.nl>,
        Grzegorz Halat <ghalat@redhat.com>,
        Len Brown <len.brown@intel.com>,
        Shaokun Zhang <zhangshaokun@hisilicon.com>,
        Mike Rapoport <rppt@linux.vnet.ibm.com>,
        Guenter Roeck <groeck@chromium.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Alexey Dobriyan <adobriyan@gmail.com>,
        Yury Norov <ynorov@marvell.com>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Jiri Kosina <jkosina@suse.cz>,
        Mukesh Ojha <mojha@codeaurora.org>,
        lkml <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v9 2/3] fdt: add support for rng-seed
Message-ID: <201908290921.1F0FCC9E5@keescook>
References: <20190822071522.143986-1-hsinyi@chromium.org>
 <20190822071522.143986-3-hsinyi@chromium.org>
 <5d5ed368.1c69fb81.419fc.0803@mx.google.com>
 <201908241203.92CC0BE8@keescook>
 <CAJMQK-iDoPxbFUH3JUeJ7SehCptZOnjKZiUoFd1PqLjDdGHujA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJMQK-iDoPxbFUH3JUeJ7SehCptZOnjKZiUoFd1PqLjDdGHujA@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 29, 2019 at 06:03:57PM +0800, Hsin-Yi Wang wrote:
> On Thu, Aug 29, 2019 at 1:36 AM Kees Cook <keescook@chromium.org> wrote:
> >
> > Can this please be a boot param (with the default controlled by the
> > CONFIG)? See how CONFIG_RANDOM_TRUST_CPU is wired up...
> >
> > -Kees
> >
> 
> Currently rng-seed read and added in setup_arch() -->
> setup_machine_fdt().. -> early_init_dt_scan_chosen(), which is earlier
> than parse_early_param() that initializes early_param.
> 
> If we want to set it as a boot param, add_bootloader_randomness() can
> only be called after parse_early_param(). The seed can't be directly
> added to pool after it's read in. We need to store into global
> variable and load it later.
> If this seems okay then I'll add a patch for this. Thanks

This seems like a good idea to me.

> 
> --- a/drivers/of/fdt.c
> +++ b/drivers/of/fdt.c
> @@ -1096,13 +1096,15 @@ static const char *config_cmdline = CONFIG_CMDLINE;
> 
> +const void* rng_seed;
> +int rng_seed_len;

These should be __initdata, yes?

> +
>  int __init early_init_dt_scan_chosen(unsigned long node, const char *uname,
>                                                             int depth,
> void *data)
>  {
>         int l = 0;
>         const char *p = NULL;
>         char *cmdline = data;
> -       const void *rng_seed;
> 
>   pr_debug("search \"chosen\", depth: %d, uname: %s\n", depth, uname);
> 
> @@ -1137,10 +1139,8 @@ int __init early_init_dt_scan_chosen(unsigned
> long node, const char *uname,
> 
>          pr_debug("Command line is: %s\n", (char*)data);
> 
> -        rng_seed = of_get_flat_dt_prop(node, "rng-seed", &l);
> -        if (rng_seed && l > 0) {
> -                add_bootloader_randomness(rng_seed, l);  //
> Originally it's added to entropy pool here
> -
> +       rng_seed = of_get_flat_dt_prop(node, "rng-seed", &rng_seed_len);
> +       if (rng_seed && rng_seed_len > 0) {
>                 /* try to clear seed so it won't be found. */
> 
> diff --git a/include/linux/random.h b/include/linux/random.h
> index 831a002a1882..946840bba7c1 100644
> --- a/include/linux/random.h
> +++ b/include/linux/random.h
> @@ -31,6 +31,15 @@ static inline void add_latent_entropy(void)
>  static inline void add_latent_entropy(void) {}
>  #endif
> 
> +extern const void* rng_seed;
> +extern int rng_seed_len;
> +
> +static inline void add_bootloader_entropy(void)
> +{
> +        if (rng_seed && rng_seed_len > 0)
> +                add_bootloader_randomness(rng_seed, rng_seed_len);
> +}

And this should be __init

> +
>  extern void add_input_randomness(unsigned int type, unsigned int code,
>   unsigned int value) __latent_entropy;
>  extern void add_interrupt_randomness(int irq, int irq_flags) __latent_entropy;
> diff --git a/init/main.c b/init/main.c
> index 71847af32e4e..f74a8c7b34af 100644
> --- a/init/main.c
> +++ b/init/main.c
> @@ -645,6 +645,7 @@ asmlinkage __visible void __init start_kernel(void)
>   * - adding command line entropy
>   */
>   rand_initialize();
> + add_bootloader_entropy();
>   add_latent_entropy();
>   add_device_randomness(command_line, strlen(command_line));
>   boot_init_stack_canary();

But yeah, looks reasonable to me.

-- 
Kees Cook
