Return-Path: <SRS0=brkd=WZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D4C12C3A59F
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Aug 2019 10:04:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A40B12339E
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Aug 2019 10:04:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="m/hgidyi"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727107AbfH2KEY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 29 Aug 2019 06:04:24 -0400
Received: from mail-qt1-f194.google.com ([209.85.160.194]:45676 "EHLO
        mail-qt1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726739AbfH2KEY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Aug 2019 06:04:24 -0400
Received: by mail-qt1-f194.google.com with SMTP id k13so2937712qtm.12
        for <linux-kernel@vger.kernel.org>; Thu, 29 Aug 2019 03:04:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=vwod3g/h3wsMjoG1LnCiS/Wpf4N1PRkHzIkFBfQoSSw=;
        b=m/hgidyicegyPyO4Uspo+VjOeANso0tBMTHbGMnzh+IJJIAekQigkeObfhGQ43XJxX
         jkkuiNkzoUrtwU97MBaEka9FMd+Ws2GPbajDlQsP8f15aq9yPCjep3IbrRwYZIfI1ZfH
         TIOhZ9lnZvoaDYfehhTDLme2nOgKHArjb2M4s=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=vwod3g/h3wsMjoG1LnCiS/Wpf4N1PRkHzIkFBfQoSSw=;
        b=mHYjM1tZ9Ly/lfjDRN6g9wsywxGOExL9PLJrh/g3nRDIX0hzC2zCBF2KrugNjhymJX
         b9H+qFbKfwcVpVpS5fL5Ovcr0Qj0bnjXLOq5unwr+zq0mDqdQSjKth62qFifCCDJh2MG
         FKuQuErALCg36aMeM9+U0kJaHk5IYxH4GZ690C53snZF18i7QzCjDZqGddMQA5tuEHXG
         VRpll23wTmP5RXKwdG0CHnO6Wkg03ImB9lOTGmgvzEQgqsPSch9KiOr1HfShDdfjuQ5T
         lBtGiwX8P4KrV3HsrnBqLhVkU0Z3DhBS5QIdtTJn625OV4Yhjw3gcs3ATFISiKA3EGg1
         WTAQ==
X-Gm-Message-State: APjAAAULLYnzuvJs5QrKw7i/wiAQiqj5lgz+/WCqZUSvBzPK59uGFZ2P
        NKBkX5q2L2v635eLCKdHwPbQmNuXUZjAxwXO5KiUcQ==
X-Google-Smtp-Source: APXvYqzFV2QhMMIOvBFm8kDuXBJDTG4ory3BugWe2SSfjqg6bDKB2bXQ/IBBCXioYRpHnhFbpw3YoE1Qsaz3ihPmKoA=
X-Received: by 2002:ad4:4050:: with SMTP id r16mr5793678qvp.200.1567073062956;
 Thu, 29 Aug 2019 03:04:22 -0700 (PDT)
MIME-Version: 1.0
References: <20190822071522.143986-1-hsinyi@chromium.org> <20190822071522.143986-3-hsinyi@chromium.org>
 <5d5ed368.1c69fb81.419fc.0803@mx.google.com> <201908241203.92CC0BE8@keescook>
In-Reply-To: <201908241203.92CC0BE8@keescook>
From:   Hsin-Yi Wang <hsinyi@chromium.org>
Date:   Thu, 29 Aug 2019 18:03:57 +0800
Message-ID: <CAJMQK-iDoPxbFUH3JUeJ7SehCptZOnjKZiUoFd1PqLjDdGHujA@mail.gmail.com>
Subject: Re: [PATCH v9 2/3] fdt: add support for rng-seed
To:     Kees Cook <keescook@chromium.org>
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
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 29, 2019 at 1:36 AM Kees Cook <keescook@chromium.org> wrote:
>
> Can this please be a boot param (with the default controlled by the
> CONFIG)? See how CONFIG_RANDOM_TRUST_CPU is wired up...
>
> -Kees
>

Currently rng-seed read and added in setup_arch() -->
setup_machine_fdt().. -> early_init_dt_scan_chosen(), which is earlier
than parse_early_param() that initializes early_param.

If we want to set it as a boot param, add_bootloader_randomness() can
only be called after parse_early_param(). The seed can't be directly
added to pool after it's read in. We need to store into global
variable and load it later.
If this seems okay then I'll add a patch for this. Thanks

--- a/drivers/of/fdt.c
+++ b/drivers/of/fdt.c
@@ -1096,13 +1096,15 @@ static const char *config_cmdline = CONFIG_CMDLINE;

+const void* rng_seed;
+int rng_seed_len;
+
 int __init early_init_dt_scan_chosen(unsigned long node, const char *uname,
                                                            int depth,
void *data)
 {
        int l = 0;
        const char *p = NULL;
        char *cmdline = data;
-       const void *rng_seed;

  pr_debug("search \"chosen\", depth: %d, uname: %s\n", depth, uname);

@@ -1137,10 +1139,8 @@ int __init early_init_dt_scan_chosen(unsigned
long node, const char *uname,

         pr_debug("Command line is: %s\n", (char*)data);

-        rng_seed = of_get_flat_dt_prop(node, "rng-seed", &l);
-        if (rng_seed && l > 0) {
-                add_bootloader_randomness(rng_seed, l);  //
Originally it's added to entropy pool here
-
+       rng_seed = of_get_flat_dt_prop(node, "rng-seed", &rng_seed_len);
+       if (rng_seed && rng_seed_len > 0) {
                /* try to clear seed so it won't be found. */

diff --git a/include/linux/random.h b/include/linux/random.h
index 831a002a1882..946840bba7c1 100644
--- a/include/linux/random.h
+++ b/include/linux/random.h
@@ -31,6 +31,15 @@ static inline void add_latent_entropy(void)
 static inline void add_latent_entropy(void) {}
 #endif

+extern const void* rng_seed;
+extern int rng_seed_len;
+
+static inline void add_bootloader_entropy(void)
+{
+        if (rng_seed && rng_seed_len > 0)
+                add_bootloader_randomness(rng_seed, rng_seed_len);
+}
+
 extern void add_input_randomness(unsigned int type, unsigned int code,
  unsigned int value) __latent_entropy;
 extern void add_interrupt_randomness(int irq, int irq_flags) __latent_entropy;
diff --git a/init/main.c b/init/main.c
index 71847af32e4e..f74a8c7b34af 100644
--- a/init/main.c
+++ b/init/main.c
@@ -645,6 +645,7 @@ asmlinkage __visible void __init start_kernel(void)
  * - adding command line entropy
  */
  rand_initialize();
+ add_bootloader_entropy();
  add_latent_entropy();
  add_device_randomness(command_line, strlen(command_line));
  boot_init_stack_canary();
