Return-Path: <SRS0=ecL9=TG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA181C04A6B
	for <linux-kernel@archiver.kernel.org>; Mon,  6 May 2019 12:39:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9A3BD20830
	for <linux-kernel@archiver.kernel.org>; Mon,  6 May 2019 12:39:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mfdBSUT9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726324AbfEFMjC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 May 2019 08:39:02 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:45992 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725853AbfEFMjB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 May 2019 08:39:01 -0400
Received: by mail-pf1-f194.google.com with SMTP id e24so6696536pfi.12;
        Mon, 06 May 2019 05:39:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Cb21//2yAhFXxGlr6DhehcS/WEyUpwWdeRGMN+DKJII=;
        b=mfdBSUT9ap3nnzFaJafy7hAfSKKoZWK01VZThERQabpdIADSgemqDe+bOe/Owl5Hw+
         Gv3hfCFPs9XBP47Zqb50Y1ODjqG1ikNKXuesH5w9QVtZM+lWEzJUr5Sgx+DAevwFIfXK
         6BXAyFuU+zB6A6AFTzzU7IXWpUoLBpPkCcI5/vis0gYjTeVFiIlcIkfY77I3TZe0HqCJ
         7ueNmdUQI5AJHLSqGvPJ5pNvkP/KyACyyiDPLlBrkoaxfV/oM/mmsuEY4BuG6zOHEeEe
         qLKXdY/qS9wnBYW77UJxbIm+w4RbpFpDq81DjoHn3XAvW/terIZIjeqIzcW9dxh27ZHw
         axsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Cb21//2yAhFXxGlr6DhehcS/WEyUpwWdeRGMN+DKJII=;
        b=aEc+ua0+q/Sb4U2yPS/migJVg98AMuM/Pka7oLXUI8dCNC5UZBGjYt0KReLUIbl7OG
         8F5OVhqaU+chGarJ42Jh+KyZKM0LQum2ofdQSAeFpRQSwPpJ8GYMt3BErWIYTuxexdcb
         esVootTJ2k5eLyTmTHfTLePUm7tCRq8jAJKaMNrGJetm2mJ2/hDJAGC7PABgJ6LCMS+9
         GbMiRxdMeCtyc5FWrWa3j08eJmuECHJ2YxYS+g3pnrpgyBVRylddtDaFgyF8Zl+FfgGK
         V2bAPS/ZTcUphOkzKHfSwi1QPfI5bpwHugzeyLOp1w9HbvRNv35TMMHSp8s/vAn+WJMO
         E3yA==
X-Gm-Message-State: APjAAAX1K999hJgg6lGRMbYeEXA79/WBvCHr99ZJxhCK9yu75H6PfzRq
        7IBJm7Yw8wf3e4oT0Hab2W7v4ZWt1CPpgcbbAOc=
X-Google-Smtp-Source: APXvYqx6lVTJglG1xVznZVyHJ0wTG0KonWUxVA7S3oNjrzwTCm68o0ujkge6Ba4zqijCRSSmtrnBTNB/wQOmI6h9Nks=
X-Received: by 2002:a62:30c2:: with SMTP id w185mr33097351pfw.175.1557146341044;
 Mon, 06 May 2019 05:39:01 -0700 (PDT)
MIME-Version: 1.0
References: <20190429150135.15070-1-hdegoede@redhat.com>
In-Reply-To: <20190429150135.15070-1-hdegoede@redhat.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Mon, 6 May 2019 15:38:50 +0300
Message-ID: <CAHp75VeE=88mCcgVx3Y3PQJPQ819Z7=3s=jRGz1y=t09phk=rA@mail.gmail.com>
Subject: Re: [PATCH] platform/x86: pmc_atom: Add Lex 3I380D industrial PC to
 critclk_systems DMI table
To:     Hans de Goede <hdegoede@redhat.com>,
        Stephen Boyd <sboyd@kernel.org>
Cc:     Darren Hart <dvhart@infradead.org>,
        Andy Shevchenko <andy@infradead.org>,
        Kai Heng Feng <kai.heng.feng@canonical.com>,
        Platform Driver <platform-driver-x86@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Semyon Verchenko <semverchenko@factor-ts.ru>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 29, 2019 at 6:01 PM Hans de Goede <hdegoede@redhat.com> wrote:
>
> The Lex 3I380D industrial PC has 4 ethernet controllers on board
> which need pmc_plt_clk0 - 3 to function, add it to the critclk_systems
> DMI table, so that drivers/clk/x86/clk-pmc-atom.c will mark the clocks
> as CLK_CRITICAL and they will not get turned off.
>

Acked-by: Andy Shevchenko <andy.shevchenko@gmail.com>
supposedly to go via CLK tree.

P.S. If you want it through PDx86, I need immutable branch / tag from CLK.

> Fixes: 648e921888ad ("clk: x86: Stop marking clocks as CLK_IS_CRITICAL")
> Reported-and-tested-by: Semyon Verchenko <semverchenko@factor-ts.ru>
> Signed-off-by: Hans de Goede <hdegoede@redhat.com>
> ---
>  drivers/platform/x86/pmc_atom.c | 9 +++++++++
>  1 file changed, 9 insertions(+)
>
> diff --git a/drivers/platform/x86/pmc_atom.c b/drivers/platform/x86/pmc_atom.c
> index 3a635ea09b8a..2910845b7cdd 100644
> --- a/drivers/platform/x86/pmc_atom.c
> +++ b/drivers/platform/x86/pmc_atom.c
> @@ -407,12 +407,21 @@ static int pmc_dbgfs_register(struct pmc_dev *pmc)
>   */
>  static const struct dmi_system_id critclk_systems[] = {
>         {
> +               /* pmc_plt_clk0 is used for an external HSIC USB HUB */
>                 .ident = "MPL CEC1x",
>                 .matches = {
>                         DMI_MATCH(DMI_SYS_VENDOR, "MPL AG"),
>                         DMI_MATCH(DMI_PRODUCT_NAME, "CEC10 Family"),
>                 },
>         },
> +       {
> +               /* pmc_plt_clk0 - 3 are used for the 4 ethernet controllers */
> +               .ident = "Lex 3I380D",
> +               .matches = {
> +                       DMI_MATCH(DMI_SYS_VENDOR, "Lex BayTrail"),
> +                       DMI_MATCH(DMI_PRODUCT_NAME, "3I380D"),
> +               },
> +       },
>         { /*sentinel*/ }
>  };
>
> --
> 2.21.0
>


-- 
With Best Regards,
Andy Shevchenko
