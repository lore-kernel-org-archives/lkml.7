Return-Path: <SRS0=Ecng=WJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-19.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC725C433FF
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Aug 2019 20:37:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9D48420665
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Aug 2019 20:37:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="AyImookG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726441AbfHMUhZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 13 Aug 2019 16:37:25 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:35154 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725944AbfHMUhZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Aug 2019 16:37:25 -0400
Received: by mail-pf1-f193.google.com with SMTP id d85so1762031pfd.2
        for <linux-kernel@vger.kernel.org>; Tue, 13 Aug 2019 13:37:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=O4bA+lMwAF10bVhJ27CrBxrtXthZNVrprWrQXBG1DjA=;
        b=AyImookGIyRLr0aL4Rc+DP59fzn5/VINuYoCZPIMOJgE8+cmDF8oZORB3Y0jdKFLYI
         J1ea5L2mlHJa2B/4kRBtfn0WrYfjBCjgm8JsobtRrs3W/qNOwUVkLEAcnudGm6BzRwkt
         Y8llATcOyOIvyPT0/S18Uo/Tp+Vkdr7DrjVehgeYX2kdBMkY68x/o/Ne82TDF7XLzsVE
         jD9ZN1XAr91d/SdADSF6Rr7sBGWjQaGCHtrIn3sPx9TlIf8xjtW3bFFDE8tb+fg2TPwp
         DjOWPL+dNESs/mH8BE1uMMTll7MVA8AhFZjUr58IUFmjDt3cSoM0LP6BvsFauuVVVJSy
         uxbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=O4bA+lMwAF10bVhJ27CrBxrtXthZNVrprWrQXBG1DjA=;
        b=oaswUVHBBPnRFTFz6LnT8cJkrFysrZtaahPktRJpVM0TexsQGVWr98AqFfwrIEOVK+
         6yVCG1siJvTK+z6TVyCKDqEXkJ1I9ukqB68OJV4gC1VOetu7NRSCbD0hYwL9TmxU25ZU
         9G2d9IySlvUwa9ibRCF/OXGR6gU0oiQ34VYSlgr6sARRirPBxHWIFqhJOOs/WPX9f7JF
         5KO9oi3s/mKRClQuhhX4tjyPkf8DB5/mXNsemx1Tyxk3YqJi4ztodrsvRN+Cc55+zZA3
         gogzwYKIEFMJN/icOC1rgfXy9MP5TY/k8tVMWlGr4k50wI5tsABbqwuLNTXULN+/13xj
         OHWA==
X-Gm-Message-State: APjAAAUEa4yHuku0kr1uQucmqgYrtN4BWRC70NpTVwMWLaZfOG1YvZE9
        GDuUINtC9M6BE7J0Copkjll4NipcCNH5GtAHiclVJw==
X-Google-Smtp-Source: APXvYqxBngouGxFq+Aa0fDJhgw/KggllMg5GoLFok4i6jE8qEaXlx75btnsrRm8SCeUVPyTLvxGGjGwPD1cI0kZztUM=
X-Received: by 2002:a63:61cd:: with SMTP id v196mr36483266pgb.263.1565728644215;
 Tue, 13 Aug 2019 13:37:24 -0700 (PDT)
MIME-Version: 1.0
References: <20190813061014.45015-1-natechancellor@gmail.com> <20190813180929.22497-1-natechancellor@gmail.com>
In-Reply-To: <20190813180929.22497-1-natechancellor@gmail.com>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Tue, 13 Aug 2019 13:37:13 -0700
Message-ID: <CAKwvOdnOtR6s2KQVEZ2MRS1HE3W7L3B3ymsLmToJdzN_L2Nz-A@mail.gmail.com>
Subject: Re: [PATCH v2] soundwire: Make slave.o depend on ACPI and rename to acpi_slave.o
To:     Nathan Chancellor <natechancellor@gmail.com>
Cc:     Vinod Koul <vkoul@kernel.org>,
        Sanyog Kale <sanyog.r.kale@intel.com>,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        alsa-devel@alsa-project.org, LKML <linux-kernel@vger.kernel.org>,
        clang-built-linux <clang-built-linux@googlegroups.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 13, 2019 at 11:12 AM Nathan Chancellor
<natechancellor@gmail.com> wrote:
>
> clang warns when CONFIG_ACPI is unset:
>
> ../drivers/soundwire/slave.c:16:12: warning: unused function
> 'sdw_slave_add' [-Wunused-function]
> static int sdw_slave_add(struct sdw_bus *bus,
>            ^
> 1 warning generated.
>
> Before commit 8676b3ca4673 ("soundwire: fix regmap dependencies and
> align with other serial links"), this code would only be compiled when
> ACPI was set because it was only selected by SOUNDWIRE_INTEL, which
> depends on ACPI.
>
> Now, this code can be compiled without CONFIG_ACPI, which causes the
> above warning. The IS_ENABLED(CONFIG_ACPI) guard could be moved to avoid
> compiling the function; however, slave.c only contains three functions,
> two of which are static. Since slave.c is completetely dependent on
> ACPI, rename it to acpi_slave.c and only compile it when CONFIG_ACPI
> is set so sdw_acpi_find_slaves will actually be used. bus.h contains
> a stub for sdw_acpi_find_slaves so there will be no issues with an
> undefined function.
>
> This has been build tested with CONFIG_ACPI set and unset in combination
> with CONFIG_SOUNDWIRE unset, built in, and a module.
>
> Fixes: 8676b3ca4673 ("soundwire: fix regmap dependencies and align with other serial links")
> Link: https://github.com/ClangBuiltLinux/linux/issues/637
> Signed-off-by: Nathan Chancellor <natechancellor@gmail.com>

Looks good, thanks Nathan.
Reviewed-by: Nick Desaulniers <ndesaulniers@google.com>

> ---
>
> v1 -> v2:
>
> * Rename slave.o to acpi_slave.o
> * Reword commit message to reflect this
>
>  drivers/soundwire/Makefile                  | 6 +++++-
>  drivers/soundwire/{slave.c => acpi_slave.c} | 3 ---
>  2 files changed, 5 insertions(+), 4 deletions(-)
>  rename drivers/soundwire/{slave.c => acpi_slave.c} (98%)
>
> diff --git a/drivers/soundwire/Makefile b/drivers/soundwire/Makefile
> index 45b7e5001653..718d8dd0ac79 100644
> --- a/drivers/soundwire/Makefile
> +++ b/drivers/soundwire/Makefile
> @@ -4,9 +4,13 @@
>  #
>
>  #Bus Objs
> -soundwire-bus-objs := bus_type.o bus.o slave.o mipi_disco.o stream.o
> +soundwire-bus-objs := bus_type.o bus.o mipi_disco.o stream.o
>  obj-$(CONFIG_SOUNDWIRE) += soundwire-bus.o
>
> +ifdef CONFIG_ACPI
> +soundwire-bus-objs += acpi_slave.o
> +endif
> +
>  #Cadence Objs
>  soundwire-cadence-objs := cadence_master.o
>  obj-$(CONFIG_SOUNDWIRE_CADENCE) += soundwire-cadence.o
> diff --git a/drivers/soundwire/slave.c b/drivers/soundwire/acpi_slave.c
> similarity index 98%
> rename from drivers/soundwire/slave.c
> rename to drivers/soundwire/acpi_slave.c
> index f39a5815e25d..0dc188e6873b 100644
> --- a/drivers/soundwire/slave.c
> +++ b/drivers/soundwire/acpi_slave.c
> @@ -60,7 +60,6 @@ static int sdw_slave_add(struct sdw_bus *bus,
>         return ret;
>  }
>
> -#if IS_ENABLED(CONFIG_ACPI)
>  /*
>   * sdw_acpi_find_slaves() - Find Slave devices in Master ACPI node
>   * @bus: SDW bus instance
> @@ -110,5 +109,3 @@ int sdw_acpi_find_slaves(struct sdw_bus *bus)
>
>         return 0;
>  }
> -
> -#endif
> --
> 2.23.0.rc2
>
> --
> You received this message because you are subscribed to the Google Groups "Clang Built Linux" group.
> To unsubscribe from this group and stop receiving emails from it, send an email to clang-built-linux+unsubscribe@googlegroups.com.
> To view this discussion on the web visit https://groups.google.com/d/msgid/clang-built-linux/20190813180929.22497-1-natechancellor%40gmail.com.



-- 
Thanks,
~Nick Desaulniers
