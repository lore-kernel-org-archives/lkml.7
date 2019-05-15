Return-Path: <SRS0=FrXW=TP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7D54DC04E53
	for <linux-kernel@archiver.kernel.org>; Wed, 15 May 2019 22:04:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2CBD62082E
	for <linux-kernel@archiver.kernel.org>; Wed, 15 May 2019 22:04:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="Vu5QV76C"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726997AbfEOWE0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 May 2019 18:04:26 -0400
Received: from mail-vs1-f66.google.com ([209.85.217.66]:37768 "EHLO
        mail-vs1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725977AbfEOWEZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 May 2019 18:04:25 -0400
Received: by mail-vs1-f66.google.com with SMTP id o5so991084vsq.4
        for <linux-kernel@vger.kernel.org>; Wed, 15 May 2019 15:04:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=8mk6oOR5E3y9T6YLxggsmWYDidkfgUM0oLL1MNN2bNM=;
        b=Vu5QV76CkALBkSczLpooJzWVU3MJcb8s7doIxE9gBZQ5bTRFo2IpyRLlWeT1+l43Oq
         XSu19ddTQWIa9bcaDXfMyLdBtm2GznXJGlhOXjGEd6vdz/bNRkkUfFXZnNudJfnAVSHy
         TW6zCm+ps5k0jagrgxUatHVPtmW4FUpuXGBAU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=8mk6oOR5E3y9T6YLxggsmWYDidkfgUM0oLL1MNN2bNM=;
        b=PQCmqV0p7LeC4DUsRJs7liTUYlNoXhfgJwa6RiKCV+w9UKa8aesPyBW748Zl7K5kHQ
         xxkEG6K2jsoC3wylaq3XbP4+00KeoQUysbIqwN/JH7FhgwYLcVRWMzhqEi0o8+9osvUg
         E4dk5F/TmKWNpRR1GwDE4ck5h8lMZpq/XmIkd9+t7wqrEifKlUyT8fJXomrSvZFq9yHF
         DbCu/GDUt2IPmii+BefXwasMoNgX4kyKa6m2G2mrEhYGFYwwnBnBl2nMSKgw3wRto0zv
         AxPq5EP8kMqTNLd7E3lhuvvjrICB75znX9QW6vHUen5/Gvut18R3D5FatAHjUDVf/oyF
         DH+A==
X-Gm-Message-State: APjAAAWzF/RTn+xv9WH11t0jNLkIzA008Qqkw84VBZArKM9snDgdbf6S
        0829/AwBNN6WP1z5upCEwXjzNqf2Yv8=
X-Google-Smtp-Source: APXvYqwihc8xzM4oxJchYWXtUCBpUYeWQJwTC65kxLiY6dd3cmSYK01t7x0ydLVFR2ZX3zDHBI41vw==
X-Received: by 2002:a67:bb1a:: with SMTP id m26mr15430504vsn.133.1557957863640;
        Wed, 15 May 2019 15:04:23 -0700 (PDT)
Received: from mail-ua1-f52.google.com (mail-ua1-f52.google.com. [209.85.222.52])
        by smtp.gmail.com with ESMTPSA id h203sm1519830vke.30.2019.05.15.15.04.22
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
        Wed, 15 May 2019 15:04:22 -0700 (PDT)
Received: by mail-ua1-f52.google.com with SMTP id e9so489656uar.9
        for <linux-kernel@vger.kernel.org>; Wed, 15 May 2019 15:04:22 -0700 (PDT)
X-Received: by 2002:ab0:984:: with SMTP id x4mr11376913uag.2.1557957861942;
 Wed, 15 May 2019 15:04:21 -0700 (PDT)
MIME-Version: 1.0
References: <20190215074802.8260-1-zbestahu@gmail.com>
In-Reply-To: <20190215074802.8260-1-zbestahu@gmail.com>
From:   Kees Cook <keescook@chromium.org>
Date:   Wed, 15 May 2019 15:04:09 -0700
X-Gmail-Original-Message-ID: <CAGXu5j+anH7OKZgYhsCfiv1FhqsQoV7QO4n5GAMswkkNCVxn+Q@mail.gmail.com>
Message-ID: <CAGXu5j+anH7OKZgYhsCfiv1FhqsQoV7QO4n5GAMswkkNCVxn+Q@mail.gmail.com>
Subject: Re: [PATCH v2] pstore: Add boot loader log messages support
To:     Yue Hu <zbestahu@gmail.com>
Cc:     Kees Cook <keescook@chromium.org>,
        Anton Vorontsov <anton@enomsg.org>,
        Colin Cross <ccross@android.com>,
        Tony Luck <tony.luck@intel.com>,
        LKML <linux-kernel@vger.kernel.org>, Yue Hu <huyue2@yulong.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

Thanks for the reminder to review this code. :) Sorry for the delay!

On Thu, Feb 14, 2019 at 11:49 PM Yue Hu <zbestahu@gmail.com> wrote:
>
> From: Yue Hu <huyue2@yulong.com>
>
> Sometimes we hope to check boot loader log messages (e.g. Android
> Verified Boot status) when kernel is coming up. Generally it does
> depend on serial device, but it will be removed for the hardware
> shipping to market by most of manufacturers. In that case better
> solder and proper serial cable for different interface (e.g. Type-C
> or microUSB) are needed. That is inconvenient and even wasting much
> time on it.

Can you give some examples of how this would be used on a real device?
More notes below...

>
> Therefore, let's add a logging support: PSTORE_TYPE_XBL.
>
> Signed-off-by: Yue Hu <huyue2@yulong.com>
> ---
> v2: mention info of interacting with boot loader
>
>  fs/pstore/Kconfig      | 10 +++++++
>  fs/pstore/platform.c   | 16 ++++++++++
>  fs/pstore/ram.c        | 81 ++++++++++++++++++++++++++++++++++++++++++++++++--
>  include/linux/pstore.h | 21 +++++++++----
>  4 files changed, 121 insertions(+), 7 deletions(-)
>
> diff --git a/fs/pstore/Kconfig b/fs/pstore/Kconfig
> index 0d19d19..ef4a2dc 100644
> --- a/fs/pstore/Kconfig
> +++ b/fs/pstore/Kconfig
> @@ -137,6 +137,16 @@ config PSTORE_FTRACE
>
>           If unsure, say N.
>
> +config PSTORE_XBL
> +       bool "Log bootloader messages"
> +       depends on PSTORE
> +       help
> +         When the option is enabled, pstore will log boot loader
> +         messages to /sys/fs/pstore/xbl-ramoops-[ID] after reboot.
> +         Boot loader needs to support log buffer reserved.
> +
> +         If unsure, say N.
> +
>  config PSTORE_RAM
>         tristate "Log panic/oops to a RAM buffer"
>         depends on PSTORE
> diff --git a/fs/pstore/platform.c b/fs/pstore/platform.c
> index 2d1066e..2e6c3f8f 100644
> --- a/fs/pstore/platform.c
> +++ b/fs/pstore/platform.c
> @@ -65,6 +65,7 @@
>         "mce",
>         "console",
>         "ftrace",
> +       "xbl",
>         "rtas",
>         "powerpc-ofw",
>         "powerpc-common",
> @@ -530,6 +531,19 @@ static void pstore_register_console(void) {}
>  static void pstore_unregister_console(void) {}
>  #endif
>
> +#ifdef CONFIG_PSTORE_XBL
> +static void pstore_register_xbl(void)
> +{
> +       struct pstore_record record;
> +
> +       pstore_record_init(&record, psinfo);
> +       record.type = PSTORE_TYPE_XBL;
> +       psinfo->write(&record);
> +}

This seems like a very strange way to get the record: this is an
"empty" write that has a side-effect of reading the XBL region and
copying it into the prz area. I would expect this to all happen in
ramoops_pstore_read() instead.

> +#else
> +static void pstore_register_xbl(void) {}
> +#endif
> +
>  static int pstore_write_user_compat(struct pstore_record *record,
>                                     const char __user *buf)
>  {
> @@ -616,6 +630,8 @@ int pstore_register(struct pstore_info *psi)
>                 pstore_register_ftrace();
>         if (psi->flags & PSTORE_FLAGS_PMSG)
>                 pstore_register_pmsg();
> +       if (psi->flags & PSTORE_FLAGS_XBL)
> +               pstore_register_xbl();
>
>         /* Start watching for new records, if desired. */
>         if (pstore_update_ms >= 0) {
> diff --git a/fs/pstore/ram.c b/fs/pstore/ram.c
> index 1adb5e3..b114b1d 100644
> --- a/fs/pstore/ram.c
> +++ b/fs/pstore/ram.c
> @@ -56,6 +56,27 @@
>  module_param_named(pmsg_size, ramoops_pmsg_size, ulong, 0400);
>  MODULE_PARM_DESC(pmsg_size, "size of user space message log");

How is the base address of the XBL area specified? It looks currently
like it's up to the end user to do all the math correctly to line it
up with where it's expected?

>
> +/*
> + * interact with boot loader
> + * =========================
> + *
> + * xbl memory layout:
> + * +----+
> + * |dst |
> + * |----|     +------------+
> + * |src ----> |   header   |
> + * +----+     |log messages|
> + *            +------------+
> + *
> + * As above, src memory is used to store header and log messages generated
> + * by boot loader, pstore will copy the log messages to dst memory which
> + * has same size as src. The header in src is to record log messages size
> + * written and make xbl cookie.

Why is such a copy needed? The log is already present in memory; why
can't pstore just use what's already there?

> + */
> +static ulong ramoops_xbl_size = MIN_MEM_SIZE;
> +module_param_named(xbl_size, ramoops_xbl_size, ulong, 0400);
> +MODULE_PARM_DESC(xbl_size, "size of boot loader log");
> +
>  static unsigned long long mem_address;
>  module_param_hw(mem_address, ullong, other, 0400);
>  MODULE_PARM_DESC(mem_address,
> @@ -88,6 +109,7 @@ struct ramoops_context {
>         struct persistent_ram_zone *cprz;       /* Console zone */
>         struct persistent_ram_zone **fprzs;     /* Ftrace zones */
>         struct persistent_ram_zone *mprz;       /* PMSG zone */
> +       struct persistent_ram_zone *bprz;       /* XBL zone */
>         phys_addr_t phys_addr;
>         unsigned long size;
>         unsigned int memtype;
> @@ -95,6 +117,7 @@ struct ramoops_context {
>         size_t console_size;
>         size_t ftrace_size;
>         size_t pmsg_size;
> +       size_t xbl_size;
>         int dump_oops;
>         u32 flags;
>         struct persistent_ram_ecc_info ecc_info;
> @@ -106,6 +129,7 @@ struct ramoops_context {
>         unsigned int max_ftrace_cnt;
>         unsigned int ftrace_read_cnt;
>         unsigned int pmsg_read_cnt;
> +       unsigned int xbl_read_cnt;
>         struct pstore_info pstore;
>  };
>
> @@ -119,6 +143,7 @@ static int ramoops_pstore_open(struct pstore_info *psi)
>         cxt->console_read_cnt = 0;
>         cxt->ftrace_read_cnt = 0;
>         cxt->pmsg_read_cnt = 0;
> +       cxt->xbl_read_cnt = 0;
>         return 0;
>  }
>
> @@ -272,6 +297,10 @@ static ssize_t ramoops_pstore_read(struct pstore_record *record)
>         if (!prz_ok(prz) && !cxt->pmsg_read_cnt++)
>                 prz = ramoops_get_next_prz(&cxt->mprz, 0 /* single */, record);
>
> +       if (!prz_ok(prz) && !cxt->xbl_read_cnt++) {
> +               prz = ramoops_get_next_prz(&cxt->bprz, 0 /* single */, record);
> +       }
> +
>         /* ftrace is last since it may want to dynamically allocate memory. */
>         if (!prz_ok(prz)) {
>                 if (!(cxt->flags & RAMOOPS_FLAG_FTRACE_PER_CPU) &&
> @@ -360,6 +389,26 @@ static size_t ramoops_write_kmsg_hdr(struct persistent_ram_zone *prz,
>         return len;
>  }
>
> +static void ramoops_get_xbl_record(struct persistent_ram_zone *prz,
> +                                 struct pstore_record *record,
> +                                 size_t xbl_size)
> +{
> +       struct pstore_xbl_header *hdr = NULL;
> +       size_t half = xbl_size / 2;
> +       size_t max = half - PSTORE_XBL_HDR_SIZE;
> +
> +       hdr = (struct pstore_xbl_header *)((size_t)prz->buffer + half);
> +
> +       if (hdr->cookie == PSTORE_XBL_COOKIE) {
> +               record->buf = (char *)((size_t)hdr + PSTORE_XBL_HDR_SIZE);
> +               record->size = hdr->size_written;
> +               if (unlikely(record->size > max))
> +                       record->size = max;
> +               return;
> +       }
> +       pr_debug("no valid xbl record (cookie = 0x%08x)\n", hdr->cookie);
> +}
> +
>  static int notrace ramoops_pstore_write(struct pstore_record *record)
>  {
>         struct ramoops_context *cxt = record->psi->data;
> @@ -390,6 +439,16 @@ static int notrace ramoops_pstore_write(struct pstore_record *record)
>         } else if (record->type == PSTORE_TYPE_PMSG) {
>                 pr_warn_ratelimited("PMSG shouldn't call %s\n", __func__);
>                 return -EINVAL;
> +       } else if (record->type == PSTORE_TYPE_XBL) {
> +               if (!cxt->bprz)
> +                       return -ENOMEM;
> +
> +               ramoops_get_xbl_record(cxt->bprz, record, cxt->xbl_size);
> +               if (record->size == 0)
> +                       return -EINVAL;
> +
> +               persistent_ram_write(cxt->bprz, record->buf, record->size);
> +               return 0;
>         }

This operates using a very strange side-effect (strange in the sense
that none of the other przs work like this). I don't get the sense
that XBL is actually a persistent ram zone: these are storage areas to
be used for specific front-end purposes (console, oops, ftrace, etc).
The XBL seems much more like a read-only backend, but having a
read-only backend kind of defeats the purpose of pstore. :) This
doesn't seem like it maps to pstore very well (it's not a storage
area). You're looking to just expose a memory region somewhere in a
kernel filesystem.

I'm not entirely opposed to creating a new type of "thing" for pstore,
just so the filesystem infrastructure can be reused (and it's
conceptually similar), but it looks like the expected information
needed to read XBL are: where in memory to find it, and what is the
maximum expected size of the log. Extracting that directly should be a
pretty small addition to pstore.

Alternatively, why not inject the XBL into the kernel printk log
directly instead?

Also, where can I find a public specification about XBL?

-- 
Kees Cook
