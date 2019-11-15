Return-Path: <SRS0=19dG=ZH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9844BC43141
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Nov 2019 09:09:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5E3AB20723
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Nov 2019 09:09:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1573808960;
	bh=tJM+z7TIEgAVRuhKDQV0d+TCAkZAzOFMrXOfQlDGuhE=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=eTHogo3SVVIJS/eyQuYiBVRLuuiOvBnsy++QL+BOrGmAI9WZLR/g0GzxtDNtOxa71
	 3t/laRuY6dJHO0UKs60bZGQg5EoLDpXV2vjh+n5ZH3JUaxZqt2DfgkLx1r4N3XOPIv
	 0kVXfhiHAFLSneu9cQbKhyhZzcs/N0QQA0ttqUlA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727159AbfKOJJT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Nov 2019 04:09:19 -0500
Received: from mail-ot1-f66.google.com ([209.85.210.66]:38489 "EHLO
        mail-ot1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725829AbfKOJJT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Nov 2019 04:09:19 -0500
Received: by mail-ot1-f66.google.com with SMTP id z25so7456800oti.5;
        Fri, 15 Nov 2019 01:09:17 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=8Ikmf1XdA8YsJb+fWAi72tmw1VlR6mMkl1vGoTPLBo0=;
        b=Dxq+HgDfyUIspmmd+ditN4ZHht6qp/dc0d142OlUMiFjZft8DCQebsBKyiFn3ATnpc
         Uzo43B5biocXMh7Irkrg4h/ITzrrX8DDXywiMvBw0FGaCW7vcQA3zVeUtTGkuAaYJERe
         hxelN4WHQBwdfg62xfWSpK94Ro+qS2BD7DytpwQRPSpPzJH8WP0FOQCB72AhiWtWGvbx
         cItnJ/4dJYcQ05SiLUktWa6+iU5uGnBLsVDit12ttQCGyYEgYZaQ6yoBSAs8x21Lu5W5
         PIK1rjDRpNNjrzKv2HW3tvho6zuWelEOTRy1Wo5tnY6xf7oSOU+05gSIl/lWbwkzXrSt
         m34A==
X-Gm-Message-State: APjAAAVW6rFbyjqJgM5KioZyRhk4sHBxzPttylpd9qsyPNgI798FzVR1
        TgSkEiFwehs4uWIkVRzdQoXF0OHzFCvaFN4ezgMs2Q==
X-Google-Smtp-Source: APXvYqyVAkPZOpCU+l2A4ZRrRXKZ/GDH3ncVnFFj0KSl5MIN2tX3uB3ukkfrz86zUdaFcot5S1uUsSPbqkD0vWHKKsI=
X-Received: by 2002:a9d:590f:: with SMTP id t15mr9911907oth.118.1573808957370;
 Fri, 15 Nov 2019 01:09:17 -0800 (PST)
MIME-Version: 1.0
References: <20191115050613.1556-1-ruansy.fnst@cn.fujitsu.com>
In-Reply-To: <20191115050613.1556-1-ruansy.fnst@cn.fujitsu.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Fri, 15 Nov 2019 10:09:06 +0100
Message-ID: <CAJZ5v0jmQEKip=7530mTSzeY_bRSyJv_Y7B49AJuLiDaTjJqSQ@mail.gmail.com>
Subject: Re: [RFC PATCH] x86/acpi: Drop duplicate BOOT table initialization
To:     Shiyang Ruan <ruansy.fnst@cn.fujitsu.com>
Cc:     "the arch/x86 maintainers" <x86@kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Len Brown <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Cao jin <caoj.fnst@cn.fujitsu.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 15, 2019 at 6:06 AM Shiyang Ruan <ruansy.fnst@cn.fujitsu.com> wrote:
>
> From: Cao jin <caoj.fnst@cn.fujitsu.com>
>
> ACPI BOOT table is initialized in both acpi_boot_table_init &
> acpi_boot_init of setup_arch, but its usage is quite late at the end of
> start_kernel. It should be safe to drop one of them. Since it is less
> related with table init, drop it from there.
>
> Signed-off-by: Cao jin <caoj.fnst@cn.fujitsu.com>

Please resend with a CC to linux-acpi@vger.kernel.org

> ---
>  arch/x86/kernel/acpi/boot.c | 2 --
>  1 file changed, 2 deletions(-)
>
> It existed since git repo is built, so it might has its reason? The
> patch is not tested since I don't have BOOT table in my firmware.
>
> diff --git a/arch/x86/kernel/acpi/boot.c b/arch/x86/kernel/acpi/boot.c
> index 04205ce127a1..ca1c15bb0b48 100644
> --- a/arch/x86/kernel/acpi/boot.c
> +++ b/arch/x86/kernel/acpi/boot.c
> @@ -1558,8 +1558,6 @@ void __init acpi_boot_table_init(void)
>                 return;
>         }
>
> -       acpi_table_parse(ACPI_SIG_BOOT, acpi_parse_sbf);
> -
>         /*
>          * blacklist may disable ACPI entirely
>          */
> --
> 2.21.0
>
>
>
