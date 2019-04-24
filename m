Return-Path: <SRS0=L2S5=S2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.9 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	URIBL_SBL,URIBL_SBL_A,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 36918C10F11
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 22:45:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 01F91214C6
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 22:45:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="m4NBdyPT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726814AbfDXWpD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Apr 2019 18:45:03 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:46202 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725977AbfDXWpD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Apr 2019 18:45:03 -0400
Received: by mail-pg1-f195.google.com with SMTP id n2so987165pgg.13
        for <linux-kernel@vger.kernel.org>; Wed, 24 Apr 2019 15:45:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=p8gSKo8gjXedOTQOk11adRFUxxP1jM7Eu5UgUQeFB50=;
        b=m4NBdyPTd3DkaO8tjhdGRpfNxFpq7MYYZQjHGXEBIcViluNAMjZJojAaAbsOPT9OC0
         dnVB6g58q3g0oLhSboFuwMDuH4LI6xV/0sSdDNLqhces55KHPnd07I76WZi3Eu8kvXsN
         Xmp/+yAeUOyfysnJKl+k6EorgfR2jAdhE8XwMIpm14B8moycWBN68UQIBFgiTG+Cw255
         HPr30kZyy2fLkNU1+UmiQIcwazMa4/riOY65p3yf/L9WONUIz/TnH8dExKsdTSzEY0iB
         ML2HsFULLRs4BT6gZyQmsBBz0naZtFQNnRCKouLZm8xiVdBikG/+VnNAC9phIWlzNuJJ
         juuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=p8gSKo8gjXedOTQOk11adRFUxxP1jM7Eu5UgUQeFB50=;
        b=HrRKLlc4v+AEQUTLyIi+Ft5MYdfTcJ3X5hCmGq8S/pyN340EiDELiFNPwGrAKDLpIX
         eWjYKRrKpyDPBImQKKlE9beuvwwnrFbHpdT7rUrgfbTpeT1hjr4vDu4KeY+LSkvvF5FZ
         V7t5bP3Yuw3bWEH0gMUhbfbfdGzTAQTIggn5RZaQTdRUgN8KCJnGKWFb1lrWzbDxfKW+
         MeJIcakTptWmIHW/s1/ENeRnmDvP9lMsnMRlz0JmtHD//UhzGPx6xOUnKUm7emal/pkh
         NyPCqDdgWUrAuC87ckGcVc0tKhgPMdaXKKpCgj+we7Xdao8aEfN8tv/9UD2FTCnDlKoh
         2uUw==
X-Gm-Message-State: APjAAAU0/V7XVnya4CXs0Ckg7e8uTUWeFrTaVYRecOuGlm8h94RaYYAN
        XWC5P7naT9Q63YaAvtxxoadxCfAuOr3cIJDIuSU+6g==
X-Google-Smtp-Source: APXvYqxU3/3oADlrCdMRPPscVY2ZUxxmnkxiQ6fu+45xm/SQ2hPkDSWx1J4W6np1Il6wvYVeGD2bkJ8lUDUmfvPKYNY=
X-Received: by 2002:a62:19ca:: with SMTP id 193mr8202593pfz.227.1556145901679;
 Wed, 24 Apr 2019 15:45:01 -0700 (PDT)
MIME-Version: 1.0
References: <20190424185742.7797-1-natechancellor@gmail.com>
In-Reply-To: <20190424185742.7797-1-natechancellor@gmail.com>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Wed, 24 Apr 2019 15:44:50 -0700
Message-ID: <CAKwvOdkRc8o+g=crw2xCesWR53bnYTtx2BXuxEbR_Hec5UNuGQ@mail.gmail.com>
Subject: Re: [PATCH] staging: kpc2000: Use memset to initialize resources
To:     Nathan Chancellor <natechancellor@gmail.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        devel@driverdev.osuosl.org, LKML <linux-kernel@vger.kernel.org>,
        clang-built-linux@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 24, 2019 at 11:58 AM Nathan Chancellor
<natechancellor@gmail.com> wrote:
>
> Clang warns:
>
> drivers/staging/kpc2000/kpc2000/cell_probe.c:96:38: warning: suggest
> braces around initialization of subobject [-Wmissing-braces]
>     struct resource  resources[2] = {0};
>                                      ^
>                                      {}
> drivers/staging/kpc2000/kpc2000/cell_probe.c:314:38: warning: suggest
> braces around initialization of subobject [-Wmissing-braces]
>     struct resource  resources[2] = {0};
>                                      ^
>                                      {}
> 2 warnings generated.
>
> One way to fix these warnings is to add additional braces like Clang
> suggests; however, there has been a bit of push back from some
> maintainers, who just prefer memset as it is unambiguous, doesn't
> depend on a particular compiler version, and properly initializes all
> subobjects [1][2]. Do that here so there are no more warnings.
>
> [1]: https://lore.kernel.org/lkml/022e41c0-8465-dc7a-a45c-64187ecd9684@amd.com/
> [2]: https://lore.kernel.org/lkml/20181128.215241.702406654469517539.davem@davemloft.net/
>
> Link: https://github.com/ClangBuiltLinux/linux/issues/455
> Signed-off-by: Nathan Chancellor <natechancellor@gmail.com>
> ---
>  drivers/staging/kpc2000/kpc2000/cell_probe.c | 12 ++++++++----
>  1 file changed, 8 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/staging/kpc2000/kpc2000/cell_probe.c b/drivers/staging/kpc2000/kpc2000/cell_probe.c
> index ad2cc0a3bfa1..13f544f3c0b9 100644
> --- a/drivers/staging/kpc2000/kpc2000/cell_probe.c
> +++ b/drivers/staging/kpc2000/kpc2000/cell_probe.c
> @@ -93,8 +93,8 @@ void parse_core_table_entry(struct core_table_entry *cte, const u64 read_val, co
>  int  probe_core_basic(unsigned int core_num, struct kp2000_device *pcard, char *name, const struct core_table_entry cte)
>  {
>      struct mfd_cell  cell = {0};
> -    struct resource  resources[2] = {0};
> -
> +    struct resource  resources[2];
> +
>      struct kpc_core_device_platdata  core_pdata = {
>          .card_id           = pcard->card_id,
>          .build_version     = pcard->build_version,
> @@ -112,6 +112,8 @@ int  probe_core_basic(unsigned int core_num, struct kp2000_device *pcard, char *
>      cell.id = core_num;
>      cell.num_resources = 2;
>
> +    memset(&resources, 0, sizeof(resources));
> +
>      resources[0].start = cte.offset;
>      resources[0].end   = cte.offset + (cte.length - 1);
>      resources[0].flags = IORESOURCE_MEM;
> @@ -311,8 +313,8 @@ int  probe_core_uio(unsigned int core_num, struct kp2000_device *pcard, char *na
>  static int  create_dma_engine_core(struct kp2000_device *pcard, size_t engine_regs_offset, int engine_num, int irq_num)
>  {
>      struct mfd_cell  cell = {0};
> -    struct resource  resources[2] = {0};
> -
> +    struct resource  resources[2];
> +
>      dev_dbg(&pcard->pdev->dev, "create_dma_core(pcard = [%p], engine_regs_offset = %zx, engine_num = %d)\n", pcard, engine_regs_offset, engine_num);
>
>      cell.platform_data = NULL;
> @@ -321,6 +323,8 @@ static int  create_dma_engine_core(struct kp2000_device *pcard, size_t engine_re
>      cell.name = KP_DRIVER_NAME_DMA_CONTROLLER;
>      cell.num_resources = 2;
>
> +    memset(&resources, 0, sizeof(resources));
> +

Bonus points for clearing up the leading whitespace.  Thanks for the
patch.  I'm beginning to think aggregate initializers are the devil.
Reviewed-by: Nick Desaulniers <ndesaulniers@google.com>

>      resources[0].start = engine_regs_offset;
>      resources[0].end   = engine_regs_offset + (KPC_DMA_ENGINE_SIZE - 1);
>      resources[0].flags = IORESOURCE_MEM;
> --
> 2.21.0
>


-- 
Thanks,
~Nick Desaulniers
