Return-Path: <SRS0=kjqD=WY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 24F78C3A5A1
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Aug 2019 17:37:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E75A922DA7
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Aug 2019 17:37:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="MQgzrgND"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727092AbfH1Rge (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 28 Aug 2019 13:36:34 -0400
Received: from mail-pl1-f194.google.com ([209.85.214.194]:39907 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727024AbfH1Rga (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Aug 2019 13:36:30 -0400
Received: by mail-pl1-f194.google.com with SMTP id z3so289230pln.6
        for <linux-kernel@vger.kernel.org>; Wed, 28 Aug 2019 10:36:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=K9Vcpkp2bypd29OVATeo9h/LJsFxpySHevcb6WIs5vE=;
        b=MQgzrgNDOIFtpBwi2JiR/yV2K4DVgUfbIjFMe/5LzpIFiGRCYfdycLhr2q93aC79GX
         KCmUYDmIGohRCQRdj6lCvrdjQZySdQ8YqlEM6MpTlCVG9tUQrGYtOO785imr0EdqY8Lj
         P1bf/U7PCuRnr268FcPRN94qxbb22Wu5pp6Is=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=K9Vcpkp2bypd29OVATeo9h/LJsFxpySHevcb6WIs5vE=;
        b=o02QjQ/jkHKPdYD9rUM7h33vhKVDMuAOYXeTNebbR5XxMcHKy3dzckv3yTyBey7aMR
         R8fBWKyKH/fuOfu9/v4+esPA4LAlk4YgvrsjMSTj+LX4Ca2V5obQZrkGojmsYxB68jzg
         q11cCa5ltuUlB6QUgmo1ngfI0v6LaWLO0Rmc0kXmhPCtec3M2E+xt3LEcFWVVT4FxBKS
         Lzc84fOe94xnXtN/ctCS18tk3hWbPforZ4cHO8ckR86tL2aiCMel/r8WKyAH7/rnjbRM
         XTmBUjoC3GpoEZJJVYuXopYXpHCtpLiRvm6kyVr4s+ds0MWbYYDcMoe47dJ3ZPIyFokj
         6Lpg==
X-Gm-Message-State: APjAAAUHEdiK3xOCnatMJ9EkqogPgyEzarakQTSGmrB3n17FN5UI/51e
        LOOhwHfeYqV++VMet9s8eEE5AQ==
X-Google-Smtp-Source: APXvYqz9ae0cu+VdE0RNiwT4vlyIjt8eKlcChNjdACQB6lRil6fPEaexFwAdxBX5UoHB3qRxLLY+Bg==
X-Received: by 2002:a17:902:a50b:: with SMTP id s11mr5686098plq.44.1567013789568;
        Wed, 28 Aug 2019 10:36:29 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id w207sm3831691pff.93.2019.08.28.10.36.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Aug 2019 10:36:24 -0700 (PDT)
Date:   Sat, 24 Aug 2019 12:04:01 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Stephen Boyd <swboyd@chromium.org>
Cc:     "Theodore Y . Ts'o" <tytso@mit.edu>,
        Hsin-Yi Wang <hsinyi@chromium.org>,
        linux-arm-kernel@lists.infradead.org,
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
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v9 2/3] fdt: add support for rng-seed
Message-ID: <201908241203.92CC0BE8@keescook>
References: <20190822071522.143986-1-hsinyi@chromium.org>
 <20190822071522.143986-3-hsinyi@chromium.org>
 <5d5ed368.1c69fb81.419fc.0803@mx.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5d5ed368.1c69fb81.419fc.0803@mx.google.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 22, 2019 at 10:39:51AM -0700, Stephen Boyd wrote:
> Quoting Hsin-Yi Wang (2019-08-22 00:15:22)
> > Introducing a chosen node, rng-seed, which is an entropy that can be
> > passed to kernel called very early to increase initial device
> > randomness. Bootloader should provide this entropy and the value is
> > read from /chosen/rng-seed in DT.
> > 
> > Obtain of_fdt_crc32 for CRC check after early_init_dt_scan_nodes(),
> > since early_init_dt_scan_chosen() would modify fdt to erase rng-seed.
> > 
> > Add a new interface add_bootloader_randomness() for rng-seed use case.
> > Depends on whether the seed is trustworthy, rng seed would be passed to
> > add_hwgenerator_randomness(). Otherwise it would be passed to
> > add_device_randomness(). Decision is controlled by kernel config
> > RANDOM_TRUST_BOOTLOADER.
> > 
> > Signed-off-by: Hsin-Yi Wang <hsinyi@chromium.org>
> > Reviewed-by: Stephen Boyd <swboyd@chromium.org>
> > Reviewed-by: Rob Herring <robh@kernel.org>
> > ---
> > Change from v8:
> > * Add a new interface add_bootloader_randomness
> > * Add a new kernel config
> > ---
> >  drivers/char/Kconfig   | 10 ++++++++++
> >  drivers/char/random.c  | 15 +++++++++++++++
> >  drivers/of/fdt.c       | 14 ++++++++++++--
> >  include/linux/random.h |  1 +
> >  4 files changed, 38 insertions(+), 2 deletions(-)
> > 
> > diff --git a/drivers/char/Kconfig b/drivers/char/Kconfig
> > index 96156c729a31..5974a5906fd0 100644
> > --- a/drivers/char/Kconfig
> > +++ b/drivers/char/Kconfig
> > @@ -551,3 +551,13 @@ config RANDOM_TRUST_CPU
> >         has not installed a hidden back door to compromise the CPU's
> >         random number generation facilities. This can also be configured
> >         at boot with "random.trust_cpu=on/off".
> > +
> > +config RANDOM_TRUST_BOOTLOADER
> > +       bool "Trust the bootloader to initialize Linux's CRNG"
> > +       default n
> 
> You can drop the default.
> 
> > +       help
> > +       Bootloader could provide rng-seed set in /chosen/rng-seed in DT to help
> > +       increase initial device randomness. Assume the entropy provided is
> > +       trustworthy, it would be regarded as true hardware RNGs and update the
> > +       entropy estimate. Otherwise it would be regarded as device input that
> > +       could help mix the entropy pool, but won't be added to actual entropy.
> 
> Maybe reword this to something like:
> 
> 	Some bootloaders can provide entropy to increase the kernel's
> 	initial device randomness. Say Y here to assume the entropy
> 	provided by the booloader is trustworthy so it will be added to
> 	the kernel's entropy pool. Otherwise, say N here so it will be
> 	regarded as device input that only mixes the entropy pool.
> 
> > \ No newline at end of file
> > diff --git a/drivers/char/random.c b/drivers/char/random.c
> > index 5d5ea4ce1442..29d3ff3de1e1 100644
> > --- a/drivers/char/random.c
> > +++ b/drivers/char/random.c
> > @@ -2445,3 +2445,18 @@ void add_hwgenerator_randomness(const char *buffer, size_t count,
> >         credit_entropy_bits(poolp, entropy);
> >  }
> >  EXPORT_SYMBOL_GPL(add_hwgenerator_randomness);
> > +
> > +/* Handle random seed passed by bootloader.
> > + * If the seed is trustworthy, it would be regarded as hardware RNGs. Otherwise
> > + * it would be regarded as device data.
> > + * The decision is controlled by CONFIG_RANDOM_TRUST_BOOTLOADER.
> > + */
> > +void add_bootloader_randomness(const void *buf, unsigned int size)
> > +{
> > +#ifdef CONFIG_RANDOM_TRUST_BOOTLOADER

Can this please be a boot param (with the default controlled by the
CONFIG)? See how CONFIG_RANDOM_TRUST_CPU is wired up...

-Kees

> > +       add_hwgenerator_randomness(buf, size, size * 8);
> > +#else
> > +       add_device_randomness(buf, size);
> > +#endif
> 
> Maybe use
> 
> 	if (IS_ENABLED(CONFIG_RANDOM_TRUST_BOOTLOADER))
> 		add_hwgenerator_randomness(buf, size, size * 8);
> 	else
> 		add_device_randomness(buf, size);
> 	
> > +}
> > +EXPORT_SYMBOL_GPL(add_bootloader_randomness);
> > \ No newline at end of file

-- 
Kees Cook
