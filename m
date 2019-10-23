Return-Path: <SRS0=OaAC=YQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 311B1CA9EB9
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Oct 2019 20:44:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D7E9621928
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Oct 2019 20:44:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ieee.org header.i=@ieee.org header.b="BvFdcz61"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391444AbfJWUo3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 23 Oct 2019 16:44:29 -0400
Received: from mail-io1-f68.google.com ([209.85.166.68]:44439 "EHLO
        mail-io1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732293AbfJWUo3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Oct 2019 16:44:29 -0400
Received: by mail-io1-f68.google.com with SMTP id w12so26654276iol.11
        for <linux-kernel@vger.kernel.org>; Wed, 23 Oct 2019 13:44:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ieee.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=cuTZG+JVrxZMWjV6289aVJw8qF+E1kb/i+ratFQL+Rs=;
        b=BvFdcz61vxqqEQyHEt98anzuxrrj+S3Cj0hVShOxxPpAO3ygC1ztPt6A9cuVzH1Gkf
         ZLzWoSMWcmWr7wZTi/dmdbWJ+S+FeQo8xNd7ctyh4IFsIJ6AVO4VTiZDVc0zBsDldoHK
         45w5ngh2QkoUv7qE2JPZU8G1vrVZatwWlWcUE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=cuTZG+JVrxZMWjV6289aVJw8qF+E1kb/i+ratFQL+Rs=;
        b=hinuZ2mBag0S1g5NwlzkgqFphyDaXROa3zAzDYR27laXIoEWIL51CllnlrQn4yLBKf
         vR3u67n/R+CKORdtd6WC9m0E40+hgwlGCcoJK4XLORgDMrWuigxafiIjbv8jow6ZFkvm
         GiJaHAIFw39fsWmve/LTyT4TbUtOVmhgY1Bevq3Shm6zIn/I//GN5HliY4dTwhuD4WJ9
         2TqjQXrgXBrjAy8MEmO1aP1kpWvOAuLB9GCqt4OPkAsoDGRG8lse/kn0FbX67b/eUV96
         E0Qe2kxYaPOSvCqxY+JMXCbRkX4z6pvliA2hkGpI0hXhFQe2SLsLFMfTyb0r3uq3ACMv
         LUew==
X-Gm-Message-State: APjAAAWc5BKDOfav/lf7VsfbmgMfiDb43MwKmpGuTrktbeqlwGaQw73E
        iQur6jL6ZLAIUR7UpWUouI+nDUlv+118lnb1uVvGOQ==
X-Google-Smtp-Source: APXvYqzGzI5CYUOIPN7FIf8wienHdsShpCFQCiWlvvbY+vdIfEdYMGzsm33qZxl5cWlbDxUWb2LTNSA5nZDOPFIEGT4=
X-Received: by 2002:a6b:c809:: with SMTP id y9mr5758754iof.232.1571863467890;
 Wed, 23 Oct 2019 13:44:27 -0700 (PDT)
MIME-Version: 1.0
References: <20191011234038.198995-1-mail@maciej.szmigiero.name>
 <CALZtONCx4L5K7+h3TuS1Ms_q_Mt_5JcZ+XTgACqdDyVsaCS76g@mail.gmail.com> <d7e1c0ca-80e9-233a-c4ea-d7fccaf56722@maciej.szmigiero.name>
In-Reply-To: <d7e1c0ca-80e9-233a-c4ea-d7fccaf56722@maciej.szmigiero.name>
From:   Dan Streetman <ddstreet@ieee.org>
Date:   Wed, 23 Oct 2019 16:43:51 -0400
Message-ID: <CALZtONDME=Rf3TgYZT0bCXvG5mFzJCM18JAS5VnVB8gpgY850g@mail.gmail.com>
Subject: Re: [PATCH] zswap: allow setting default status, compressor and
 allocator in Kconfig
To:     "Maciej S. Szmigiero" <mail@maciej.szmigiero.name>
Cc:     Seth Jennings <sjenning@redhat.com>,
        Vitaly Wool <vitalywool@gmail.com>,
        Linux-MM <linux-mm@kvack.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 18, 2019 at 6:16 PM Maciej S. Szmigiero
<mail@maciej.szmigiero.name> wrote:
>
> On 18.10.2019 13:19, Dan Streetman wrote:
> > On Fri, Oct 11, 2019 at 7:40 PM Maciej S. Szmigiero
> > <mail@maciej.szmigiero.name> wrote:
> >>
> >> The compressed cache for swap pages (zswap) currently needs from 1 to 3
> >> extra kernel command line parameters in order to make it work: it has to be
> >> enabled by adding a "zswap.enabled=1" command line parameter and if one
> >> wants a different compressor or pool allocator than the default lzo / zbud
> >> combination then these choices also need to be specified on the kernel
> >> command line in additional parameters.
> >>
> >> Using a different compressor and allocator for zswap is actually pretty
> >> common as guides often recommend using the lz4 / z3fold pair instead of
> >> the default one.
> >> In such case it is also necessary to remember to enable the appropriate
> >> compression algorithm and pool allocator in the kernel config manually.
> >>
> >> Let's avoid the need for adding these kernel command line parameters and
> >> automatically pull in the dependencies for the selected compressor
> >> algorithm and pool allocator by adding an appropriate default switches to
> >> Kconfig.
> >
> > Who is the target for using these kernel build-time defaults?  I don't
> > think any distribution would be defaulting zswap to enabled, and if
> > the config defaults are intended for personal kernel builds, it is
> > really so much harder to just configure it on the boot cmdline?
>
> Appropriate kernel config defaults are normally provided for kernel
> parameters that are reasonably expected to be configured for normal
> operation (and sometimes for debugging parameters, too), so one does not
> need to boot kernel with a lot of command line parameters to get the
> desired behavior.
>
> A quick, limited grep of Documentation/admin-guide/kernel-parameters.txt
> gives me the following config options that control the default values of
> command line parameters:
> CONFIG_HPET_MMAP_DEFAULT
> CONFIG_BOOTPARAM_HUNG_TASK_PANIC
> CONFIG_INIT_ON_ALLOC_DEFAULT_ON
> CONFIG_INIT_ON_FREE_DEFAULT_ON
> CONFIG_IOMMU_DEFAULT_PASSTHROUGH
> CONFIG_DEBUG_KMEMLEAK_DEFAULT_OFF
> CONFIG_LSM
> CONFIG_MEMORY_HOTPLUG_DEFAULT_ONLINE
> CONFIG_AMD_MEM_ENCRYPT_ACTIVE_BY_DEFAULT
> CONFIG_RANDOM_TRUST_CPU
> CONFIG_SLUB_MEMCG_SYSFS_ON
> CONFIG_BOOTPARAM_SOFTLOCKUP_PANIC
> CONFIG_SYSFS_DEPRECATED_V2
> CONFIG_COMPAT_VDSO
> CONFIG_WQ_POWER_EFFICIENT_DEFAULT
> CONFIG_XEN_SCRUB_PAGES_DEFAULT
>
> There are countless other ones that set the default values for module
> parameters, for example in the "sound" directory alone there are four:
> CONFIG_SND_PS3_DEFAULT_START_DELAY
> CONFIG_SND_HDA_POWER_SAVE_DEFAULT
> CONFIG_SND_AC97_POWER_SAVE_DEFAULT
> CONFIG_SND_SEQ_HRTIMER_DEFAULT
>
> Providing such selectable default also means that the dependencies for
> the selected compressor algorithm and pool allocator are pulled in
> automatically - the old way pulled in the LZO algorithm (and only the
> LZO algorithm) into the kernel unconditionally, even if the user was
> ultimately going to use another algorithm.
>
> >>
> >> The default values for these options match what the code was using
> >> previously as its defaults.
> >>
> >> Signed-off-by: Maciej S. Szmigiero <mail@maciej.szmigiero.name>
> >> ---
> >>  mm/Kconfig | 103 ++++++++++++++++++++++++++++++++++++++++++++++++++++-
> >>  mm/zswap.c |  26 ++++++++------
> >>  2 files changed, 117 insertions(+), 12 deletions(-)
> >>
> >> diff --git a/mm/Kconfig b/mm/Kconfig
> >> index a5dae9a7eb51..4309bcaaa29d 100644
> >> --- a/mm/Kconfig
> >> +++ b/mm/Kconfig
> >> @@ -525,7 +525,6 @@ config MEM_SOFT_DIRTY
> >>  config ZSWAP
> >>         bool "Compressed cache for swap pages (EXPERIMENTAL)"
> >>         depends on FRONTSWAP && CRYPTO=y
> >> -       select CRYPTO_LZO
> >>         select ZPOOL
> >>         help
> >>           A lightweight compressed cache for swap pages.  It takes
> >> @@ -541,6 +540,108 @@ config ZSWAP
> >>           they have not be fully explored on the large set of potential
> >>           configurations and workloads that exist.
> >>
> >> +choice
> >
> > Using choice becomes a bit of a maintenence issue...if we add this,
> > wouldn't it be better to use string input so new compression algs can
> > be added without having to update this Kconfig?
>
> If this is changed to a string prompt we'll lose automatic pulling in of
> an appropriate CONFIG_CRYPTO_* dependency.
>
> Other similar options are presented as a choice, too, see for example
> CONFIG_KERNEL_{GZIP,BZIP2,LZMA,XZ,LZO,LZ4,UNCOMPRESSED} and
> CONFIG_INITRAMFS_COMPRESSION_{NONE,GZIP,BZIP2,LZMA,XZ,LZO,LZ4} (that
> maps to an extension string table called CONFIG_INITRAMFS_COMPRESSION).
>
> BTW: New compression algorithm being added to the kernel is a rare
> event, I also envision that not every new algorithm will need to be
> presented as a choice for zswap default.
>
> >> +       prompt "Compressed cache for swap pages default compressor"
> >> +       depends on ZSWAP
> >> +       default ZSWAP_DEFAULT_COMP_LZO
> >> +       help
> >> +         Selects the default compression algorithm for the compressed cache
> >> +         for swap pages.
> >> +         If in doubt, select 'LZO'.
> >> +
> >> +         The selection made here can be overridden by using the kernel
> >> +         command line 'zswap.compressor=' option.
> >> +
> >> +config ZSWAP_DEFAULT_COMP_DEFLATE
> >> +       bool "Deflate"
> >> +       select CRYPTO_DEFLATE
> >> +       help
> >> +         Use the Deflate algorithm as the default compression algorithm.
> >> +
> >> +config ZSWAP_DEFAULT_COMP_LZO
> >> +       bool "LZO"
> >> +       select CRYPTO_LZO
> >> +       help
> >> +         Use the LZO algorithm as the default compression algorithm.
> >> +
> >> +config ZSWAP_DEFAULT_COMP_842
> >> +       bool "842"
> >> +       select CRYPTO_842
> >> +       help
> >> +         Use the 842 algorithm as the default compression algorithm.
> >> +
> >> +config ZSWAP_DEFAULT_COMP_LZ4
> >> +       bool "LZ4"
> >> +       select CRYPTO_LZ4
> >> +       help
> >> +         Use the LZ4 algorithm as the default compression algorithm.
> >> +
> >> +config ZSWAP_DEFAULT_COMP_LZ4HC
> >> +       bool "LZ4HC"
> >> +       select CRYPTO_LZ4HC
> >> +       help
> >> +         Use the LZ4HC algorithm as the default compression algorithm.
> >> +
> >> +config ZSWAP_DEFAULT_COMP_ZSTD
> >> +       bool "zstd"
> >> +       select CRYPTO_ZSTD
> >> +       help
> >> +         Use the zstd algorithm as the default compression algorithm.
> >> +endchoice
> >> +
> >> +config ZSWAP_DEFAULT_COMP_NAME
> >> +       string
> >> +       default "deflate" if ZSWAP_DEFAULT_COMP_DEFLATE
> >> +       default "lzo" if ZSWAP_DEFAULT_COMP_LZO
> >> +       default "842" if ZSWAP_DEFAULT_COMP_842
> >> +       default "lz4" if ZSWAP_DEFAULT_COMP_LZ4
> >> +       default "lz4hc" if ZSWAP_DEFAULT_COMP_LZ4HC
> >> +       default "zstd" if ZSWAP_DEFAULT_COMP_ZSTD
> >> +       default ""
> >> +
> >> +choice
> >> +       prompt "Compressed cache for swap pages default allocator"
> >> +       depends on ZSWAP
> >> +       default ZSWAP_DEFAULT_ZPOOL_ZBUD
> >> +       help
> >> +         Selects the default allocator for the compressed cache for
> >> +         swap pages.
> >> +         The default is 'zbud' for compatibility, however please do
> >> +         read the description of each of the allocators below before
> >> +         making a right choice.
> >> +
> >> +         The selection made here can be overridden by using the kernel
> >> +         command line 'zswap.zpool=' option.
> >> +
> >> +config ZSWAP_DEFAULT_ZPOOL_ZBUD
> >> +       bool "zbud"
> >> +       select ZBUD
> >> +       help
> >> +         Use the zbud allocator as the default allocator.
> >> +
> >> +config ZSWAP_DEFAULT_ZPOOL_Z3FOLD
> >> +       bool "z3fold"
> >> +       select Z3FOLD
> >> +       help
> >> +         Use the z3fold allocator as the default allocator.
> >> +endchoice
> >> +
> >> +config ZSWAP_DEFAULT_ZPOOL_NAME
> >> +       string
> >> +       default "zbud" if ZSWAP_DEFAULT_ZPOOL_ZBUD
> >> +       default "z3fold" if ZSWAP_DEFAULT_ZPOOL_Z3FOLD
> >> +       default ""
> >> +
> >> +config ZSWAP_DEFAULT_ON
> >> +       bool "Enable the compressed cache for swap pages by default"
> >> +       depends on ZSWAP
> >> +       help
> >> +         If selected, the compressed cache for swap pages will be enabled
> >> +         at boot, otherwise it will be disabled.
> >> +
> >> +         The selection made here can be overridden by using the kernel
> >> +         command line 'zswap.enabled=' option.
> >> +
> >>  config ZPOOL
> >>         tristate "Common API for compressed memory storage"
> >>         help
> >> diff --git a/mm/zswap.c b/mm/zswap.c
> >> index 46a322316e52..59231f6fb2ca 100644
> >> --- a/mm/zswap.c
> >> +++ b/mm/zswap.c
> >> @@ -71,8 +71,12 @@ static u64 zswap_duplicate_entry;
> >>
> >>  #define ZSWAP_PARAM_UNSET ""
> >>
> >> -/* Enable/disable zswap (disabled by default) */
> >> +/* Enable/disable zswap */
> >> +#ifdef CONFIG_ZSWAP_DEFAULT_ON
> >> +static bool zswap_enabled = true;
> >> +#else
> >>  static bool zswap_enabled;
> >> +#endif
> >>  static int zswap_enabled_param_set(const char *,
> >>                                    const struct kernel_param *);
> >>  static struct kernel_param_ops zswap_enabled_param_ops = {
> >> @@ -82,8 +86,7 @@ static struct kernel_param_ops zswap_enabled_param_ops = {
> >>  module_param_cb(enabled, &zswap_enabled_param_ops, &zswap_enabled, 0644);
> >>
> >>  /* Crypto compressor to use */
> >> -#define ZSWAP_COMPRESSOR_DEFAULT "lzo"
> >> -static char *zswap_compressor = ZSWAP_COMPRESSOR_DEFAULT;
> >> +static char *zswap_compressor = CONFIG_ZSWAP_DEFAULT_COMP_NAME;
> >>  static int zswap_compressor_param_set(const char *,
> >>                                       const struct kernel_param *);
> >>  static struct kernel_param_ops zswap_compressor_param_ops = {
> >> @@ -95,8 +98,7 @@ module_param_cb(compressor, &zswap_compressor_param_ops,
> >>                 &zswap_compressor, 0644);
> >>
> >>  /* Compressed storage zpool to use */
> >> -#define ZSWAP_ZPOOL_DEFAULT "zbud"
> >> -static char *zswap_zpool_type = ZSWAP_ZPOOL_DEFAULT;
> >> +static char *zswap_zpool_type = CONFIG_ZSWAP_DEFAULT_ZPOOL_NAME;
> >>  static int zswap_zpool_param_set(const char *, const struct kernel_param *);
> >>  static struct kernel_param_ops zswap_zpool_param_ops = {
> >>         .set =          zswap_zpool_param_set,
> >> @@ -569,11 +571,12 @@ static __init struct zswap_pool *__zswap_pool_create_fallback(void)
> >>         bool has_comp, has_zpool;
> >>
> >>         has_comp = crypto_has_comp(zswap_compressor, 0, 0);
> >> -       if (!has_comp && strcmp(zswap_compressor, ZSWAP_COMPRESSOR_DEFAULT)) {
> >> +       if (!has_comp && strcmp(zswap_compressor,
> >> +                               CONFIG_ZSWAP_DEFAULT_COMP_NAME)) {
> >
> > bit of bikeshedding, wouldn't CONFIG_ZSWAP_COMPRESSOR_DEFAULT be
> > clearer than CONFIG_ZSWAP_DEFAULT_COMP_NAME?
>
> I'm fine either way (used "COMP" instead of "COMPRESSOR" to shorten these
> identifiers a bit), also CONFIG_ZSWAP_DEFAULT_ZPOOL_NAME then probably
> would need renaming to CONFIG_ZSWAP_ZPOOL_DEFAULT for consistency.

The "NAME" part doesn't add any clarity, while shortening COMPRESSOR
to COMP removes clarity.

Other than that I'm ok with all this.  Thanks!

>
> Thanks,
> Maciej
