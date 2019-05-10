Return-Path: <SRS0=sufd=TK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 320C0C04A6B
	for <linux-kernel@archiver.kernel.org>; Fri, 10 May 2019 07:38:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EB5E32173B
	for <linux-kernel@archiver.kernel.org>; Fri, 10 May 2019 07:37:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="YOQP0dts"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727117AbfEJHh6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 10 May 2019 03:37:58 -0400
Received: from mail-qk1-f195.google.com ([209.85.222.195]:44017 "EHLO
        mail-qk1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726981AbfEJHh6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 May 2019 03:37:58 -0400
Received: by mail-qk1-f195.google.com with SMTP id z6so2244184qkl.10
        for <linux-kernel@vger.kernel.org>; Fri, 10 May 2019 00:37:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=YPIdmEziEMHUxazGM82nUeKFs82CMeVb0svBlAIM9mc=;
        b=YOQP0dtsuHdYUa3VJGsw06uyx6HBDRcu7CqZFjC6R74X5SCqFH/fbolbZ4NikUGBOB
         01VRHlTKWDTKyNcqr0mx3OXaYA78NK/XUYGPfVgakaCkbsccPVHl+QvhvJFgRCvxbuDG
         KJ3D9BUxmIMQh16Ljn7fZFKLA8Vj0mFGbYJho=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=YPIdmEziEMHUxazGM82nUeKFs82CMeVb0svBlAIM9mc=;
        b=UVRD8JknDJVK+gNq8kVg+oaCAC/97ThLTM19biHKnyNa+N83KBl54EowrJFEMujFLK
         OmO38nopW3g59yDdOtPK5HOrGEaAowlCKuDZTnG9Rg/7qmV2FdqTr+HXpaCALRdXcdDh
         i35CWEn/E3twO372DTSljHhwXuc89DEXWG3Hy9T8RCX0yUePKj8zBTMq5Z4jenXp8KXb
         IoDplnGFqxZDVUHGE4V3D6QLafZBfggWFufqEamh0CtrK+RFO1AXrl6rkgIvhja99qbY
         sDVfJhz4fRhZ0VV6NiHI6R8WAyGe/rjW/D61kPedz02PhJx3KQp7YUHRkovi3t/3q5Dn
         HUxw==
X-Gm-Message-State: APjAAAXQVWF/jlW7w+iLU99DH8H6qXljYrbAyEOi7HC5k9pe6zQdedbO
        zmQgjBxBENZWSWPGBi+ZZxJCZRCGBHNVrLyGESDjqA==
X-Google-Smtp-Source: APXvYqw0oTMu+CovlvxeRY9ocZTmZNLydi0JE63J09a1MhVGCcjf777Api8V4IshlZIMqAkICDBwoldY3iKTtUIQcho=
X-Received: by 2002:a05:620a:1585:: with SMTP id d5mr7444463qkk.212.1557473876989;
 Fri, 10 May 2019 00:37:56 -0700 (PDT)
MIME-Version: 1.0
References: <20190507045433.542-1-hsinyi@chromium.org> <CAL_Jsq+rGeFKAPVmPvv_Z+G=BppKUK-tEUphBajZVxFtbRBJvQ@mail.gmail.com>
 <CAJMQK-iVhScf0ybZ85kqP0B5_QPoYZ9PZt35jHRUh8FNHKvu7w@mail.gmail.com>
 <CAL_JsqJZ+mOnrLWt0Cpo_Ybr_ohxwWom1qiyV8_EFocULde7=Q@mail.gmail.com>
 <CAJMQK-jjzYwX3NZAKJ-8ypjcN75o-ZX4iOVD=84JecEd4qV1bA@mail.gmail.com>
 <CAL_JsqLnmedF5cJYH+91U2Q_WX755O8TQs6Ue9mqtEiFKcjGWQ@mail.gmail.com>
 <CAJMQK-hJUG855+TqX=droOjUfb-MKnU0n0FYtr_SW2KByKAW1w@mail.gmail.com> <36fab640-b98e-9781-f96f-0ed988a71077@rasmusvillemoes.dk>
In-Reply-To: <36fab640-b98e-9781-f96f-0ed988a71077@rasmusvillemoes.dk>
From:   Hsin-Yi Wang <hsinyi@chromium.org>
Date:   Fri, 10 May 2019 15:37:31 +0800
Message-ID: <CAJMQK-hpA7rkaznW2REYbO=6rOvEMfJOvo6xxPkNb9o1VNUqTA@mail.gmail.com>
Subject: Re: [PATCH] arm64: add support for rng-seed
To:     Rasmus Villemoes <linux@rasmusvillemoes.dk>
Cc:     Rob Herring <robh+dt@kernel.org>,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Frank Rowand <frowand.list@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Mike Rapoport <rppt@linux.ibm.com>,
        Michal Hocko <mhocko@suse.com>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        James Morse <james.morse@arm.com>,
        Andrew Murray <andrew.murray@arm.com>,
        devicetree@vger.kernel.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Stephen Boyd <swboyd@chromium.org>,
        Architecture Mailman List <boot-architecture@lists.linaro.org>,
        Kees Cook <keescook@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 10, 2019 at 2:14 PM Rasmus Villemoes
<linux@rasmusvillemoes.dk> wrote:

> So, why not just have the bootloader add whatever entropy it has via the
> commandline, which already gets mixed in? That requires no kernel
> changes, and works for all architectures.
>
> If anything, perhaps instead of just adding gobbledygook=abc123, make an
> official command line parameter (there was talk about this at some
> point), and have the kernel overwrite the value with xxx so it's not
> visible in /proc/cmdline.
>
> Rasmus

For some arch, besides commandline, we also need to overwrite bootargs
in fdt, otherwise it's still visible by
/sys/firmware/devicetree/base/chosen/bootargs for example.

Originally planned to land v2 as

diff --git a/drivers/of/fdt.c b/drivers/of/fdt.c
index de893c9616a1..96ea5eba9dd5 100644
--- a/drivers/of/fdt.c
+++ b/drivers/of/fdt.c
@@ -24,6 +24,7 @@
 #include <linux/debugfs.h>
 #include <linux/serial_core.h>
 #include <linux/sysfs.h>
+#include <linux/random.h>

 #include <asm/setup.h>  /* for COMMAND_LINE_SIZE */
 #include <asm/page.h>
@@ -1079,6 +1080,7 @@ int __init early_init_dt_scan_chosen(unsigned
long node, const char *uname,
 {
        int l;
        const char *p;
+       const void *rng_seed;

        pr_debug("search \"chosen\", depth: %d, uname: %s\n", depth, uname);

@@ -1113,6 +1115,15 @@ int __init early_init_dt_scan_chosen(unsigned
long node, const char *uname,

        pr_debug("Command line is: %s\n", (char*)data);

+       rng_seed = of_get_flat_dt_prop(node, "rng-seed", &l);
+       if (!rng_seed || l == 0)
+               return 1;
+
+       /* try to clear seed so it won't be found. */
+        fdt_nop_property(initial_boot_params, node, "rng-seed");
+
+        add_device_randomness(rng_seed, l);
+
        /* break now */
        return 1;
 }

(For arm64 RW/RO issue, it will be done in other patch.)

If we add parameter into commandline, I think we probably also need to
do similar changes here since there are fdt related overwrite.
