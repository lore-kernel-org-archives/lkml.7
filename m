Return-Path: <SRS0=/WLL=WS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7AAAC3A5A1
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Aug 2019 17:39:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 827DC20856
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Aug 2019 17:39:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="MQnTqO/P"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392762AbfHVRj5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 22 Aug 2019 13:39:57 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:40129 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388253AbfHVRjz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Aug 2019 13:39:55 -0400
Received: by mail-pf1-f193.google.com with SMTP id w16so4423600pfn.7
        for <linux-kernel@vger.kernel.org>; Thu, 22 Aug 2019 10:39:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=message-id:mime-version:content-transfer-encoding:in-reply-to
         :references:cc:subject:to:from:user-agent:date;
        bh=/SKCVH1cP34M+EOCz1gwJK67tID4N48JyS6a43d2kiA=;
        b=MQnTqO/P5HLNo2wRx+4ovpS8Tl5NhKqP4yAwsm75fZBx/0HuNqZY6WQPFieLjqgL8Y
         y+7TnZh/GvrBXFZcy/IiflyoVVy1xtikmPc0Pxx8dgdn6LdnEUYZatahrFKCrA33+kgW
         K/BJVdJ8pwOuIsUYEHDW2kDhp2Dhiiku5TfCA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:mime-version
         :content-transfer-encoding:in-reply-to:references:cc:subject:to:from
         :user-agent:date;
        bh=/SKCVH1cP34M+EOCz1gwJK67tID4N48JyS6a43d2kiA=;
        b=TSgzS+NNvgePl/sHPIU/vQ+xo+qw3f4DHXLpq8ghp+gcPFsaPc2olGfo7aejIaroA+
         OtfQCMUVhaLlK1Ab1vOE6u5h5QVnotNnWkCwi590cwQ+xxdIknhNFefblZRCnhnT04ch
         VbMnnCr/PEFEditQOublWxjucRsV6EckFi+NLF2vmUOsKXtlPYEAoglaPQlQsz10nWyi
         pBO+GXdnAAFERt07DyQ+jN9SUMFsDCD579Z8pRaP/PuQqAuuf8QRhtp0sbtA6pvtdMJh
         ycIx9ddrdGypyXtzSL9X7ibwek++WmhyX+r23PcPsBcp8YVH2PrBvbC3YJ7HscuRJnII
         z9pw==
X-Gm-Message-State: APjAAAWrlsr5jJmbYlBlnzuXT95x+5TyMNHcDkh7KjxXWaHsH+iH/6mt
        thouPVFGrNYyYGbklEovul7tQA==
X-Google-Smtp-Source: APXvYqyjCv+RfuDuHbk6B4dF6CbusPM8neaAWPdHZqiIQnf8Kr9Fc7sVfGImRfS+T0/lf0D9ZKqxww==
X-Received: by 2002:a63:1918:: with SMTP id z24mr358999pgl.94.1566495594017;
        Thu, 22 Aug 2019 10:39:54 -0700 (PDT)
Received: from chromium.org ([2620:15c:202:1:fa53:7765:582b:82b9])
        by smtp.gmail.com with ESMTPSA id c2sm153607pjs.13.2019.08.22.10.39.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Aug 2019 10:39:52 -0700 (PDT)
Message-ID: <5d5ed368.1c69fb81.419fc.0803@mx.google.com>
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20190822071522.143986-3-hsinyi@chromium.org>
References: <20190822071522.143986-1-hsinyi@chromium.org> <20190822071522.143986-3-hsinyi@chromium.org>
Cc:     Russell King <linux@armlinux.org.uk>,
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
        Kees Cook <keescook@chromium.org>,
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
To:     "Theodore Y . Ts'o" <tytso@mit.edu>,
        Hsin-Yi Wang <hsinyi@chromium.org>,
        linux-arm-kernel@lists.infradead.org
From:   Stephen Boyd <swboyd@chromium.org>
User-Agent: alot/0.8.1
Date:   Thu, 22 Aug 2019 10:39:51 -0700
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Hsin-Yi Wang (2019-08-22 00:15:22)
> Introducing a chosen node, rng-seed, which is an entropy that can be
> passed to kernel called very early to increase initial device
> randomness. Bootloader should provide this entropy and the value is
> read from /chosen/rng-seed in DT.
>=20
> Obtain of_fdt_crc32 for CRC check after early_init_dt_scan_nodes(),
> since early_init_dt_scan_chosen() would modify fdt to erase rng-seed.
>=20
> Add a new interface add_bootloader_randomness() for rng-seed use case.
> Depends on whether the seed is trustworthy, rng seed would be passed to
> add_hwgenerator_randomness(). Otherwise it would be passed to
> add_device_randomness(). Decision is controlled by kernel config
> RANDOM_TRUST_BOOTLOADER.
>=20
> Signed-off-by: Hsin-Yi Wang <hsinyi@chromium.org>
> Reviewed-by: Stephen Boyd <swboyd@chromium.org>
> Reviewed-by: Rob Herring <robh@kernel.org>
> ---
> Change from v8:
> * Add a new interface add_bootloader_randomness
> * Add a new kernel config
> ---
>  drivers/char/Kconfig   | 10 ++++++++++
>  drivers/char/random.c  | 15 +++++++++++++++
>  drivers/of/fdt.c       | 14 ++++++++++++--
>  include/linux/random.h |  1 +
>  4 files changed, 38 insertions(+), 2 deletions(-)
>=20
> diff --git a/drivers/char/Kconfig b/drivers/char/Kconfig
> index 96156c729a31..5974a5906fd0 100644
> --- a/drivers/char/Kconfig
> +++ b/drivers/char/Kconfig
> @@ -551,3 +551,13 @@ config RANDOM_TRUST_CPU
>         has not installed a hidden back door to compromise the CPU's
>         random number generation facilities. This can also be configured
>         at boot with "random.trust_cpu=3Don/off".
> +
> +config RANDOM_TRUST_BOOTLOADER
> +       bool "Trust the bootloader to initialize Linux's CRNG"
> +       default n

You can drop the default.

> +       help
> +       Bootloader could provide rng-seed set in /chosen/rng-seed in DT t=
o help
> +       increase initial device randomness. Assume the entropy provided is
> +       trustworthy, it would be regarded as true hardware RNGs and updat=
e the
> +       entropy estimate. Otherwise it would be regarded as device input =
that
> +       could help mix the entropy pool, but won't be added to actual ent=
ropy.

Maybe reword this to something like:

	Some bootloaders can provide entropy to increase the kernel's
	initial device randomness. Say Y here to assume the entropy
	provided by the booloader is trustworthy so it will be added to
	the kernel's entropy pool. Otherwise, say N here so it will be
	regarded as device input that only mixes the entropy pool.

> \ No newline at end of file
> diff --git a/drivers/char/random.c b/drivers/char/random.c
> index 5d5ea4ce1442..29d3ff3de1e1 100644
> --- a/drivers/char/random.c
> +++ b/drivers/char/random.c
> @@ -2445,3 +2445,18 @@ void add_hwgenerator_randomness(const char *buffer=
, size_t count,
>         credit_entropy_bits(poolp, entropy);
>  }
>  EXPORT_SYMBOL_GPL(add_hwgenerator_randomness);
> +
> +/* Handle random seed passed by bootloader.
> + * If the seed is trustworthy, it would be regarded as hardware RNGs. Ot=
herwise
> + * it would be regarded as device data.
> + * The decision is controlled by CONFIG_RANDOM_TRUST_BOOTLOADER.
> + */
> +void add_bootloader_randomness(const void *buf, unsigned int size)
> +{
> +#ifdef CONFIG_RANDOM_TRUST_BOOTLOADER
> +       add_hwgenerator_randomness(buf, size, size * 8);
> +#else
> +       add_device_randomness(buf, size);
> +#endif

Maybe use

	if (IS_ENABLED(CONFIG_RANDOM_TRUST_BOOTLOADER))
		add_hwgenerator_randomness(buf, size, size * 8);
	else
		add_device_randomness(buf, size);
=09
> +}
> +EXPORT_SYMBOL_GPL(add_bootloader_randomness);
> \ No newline at end of file
