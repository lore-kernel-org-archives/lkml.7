Return-Path: <SRS0=EIds=SH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 72247C10F00
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Apr 2019 15:49:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3C4242146F
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Apr 2019 15:49:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="JWSC/NNc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731263AbfDEPtm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 5 Apr 2019 11:49:42 -0400
Received: from mail-vs1-f65.google.com ([209.85.217.65]:37057 "EHLO
        mail-vs1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726730AbfDEPtl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Apr 2019 11:49:41 -0400
Received: by mail-vs1-f65.google.com with SMTP id w13so3772548vsc.4
        for <linux-kernel@vger.kernel.org>; Fri, 05 Apr 2019 08:49:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=L5oetkIZG68VNWmHkfR/Dw9MyRhI4MDOLdp/EBMOb1A=;
        b=JWSC/NNcS/vfo9XVl1gVelgegdkriQ43+GdYvOZHbvazgHnSBJvWA5TsSYVaseq3eB
         2ilxO0aNWGTqi0v4lAcyp5G2YHcIDbLqPBkcJLKa4Cv5jHyrj+mbtFeJBAb2Wgm2LvUP
         Gs3tOpQY3Jm8tSFE7isnovNyDUAskZ6YHgkdU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=L5oetkIZG68VNWmHkfR/Dw9MyRhI4MDOLdp/EBMOb1A=;
        b=ETWOERaijdJIobxaScjJXyqIcXUDPSVfbYFoLekvtjCUNrkaVT4FSk1MD0TyGjoBAj
         eUsC5ZBa3cE0ptaOkzbRot4MJ7z9tcQfqaR4byM+kjJsjIpgLCgschWLvd6OelUzd7ZP
         ji1sS3VAfwKUvSvdC/iLG0uwWc9s1ZNESdAfJ03+2qpHtVsYmGOCNhuMVoTZgasbTkKM
         HB3sa7Tgq1+lxTwidnl22X8NI936XTfLKAeTc9FVKWs5o238ntW/SleahYXrEGPtM5+M
         GXvNsA7xSn8QVP79MNi+UIrXfqlQpXS6IphRhsyOb/qkE+ICONjZ4ubtmTuugajP8LMC
         BFEA==
X-Gm-Message-State: APjAAAULIj+Q5K/GhVbCVut2vLV0wwYTcpiDgEN39JsRS6/BON6ddgnw
        QNt/XV/gJLPoIIndAiSTo4O2YXh+/tU=
X-Google-Smtp-Source: APXvYqw5EOSaVtlMUTaqkd4LgNCo5ItIakfr0ybTQXPAyJF67mNobcBmf6+TqmNolfjfglswXHzYpQ==
X-Received: by 2002:a67:d38f:: with SMTP id b15mr8465036vsj.154.1554479379641;
        Fri, 05 Apr 2019 08:49:39 -0700 (PDT)
Received: from mail-vs1-f47.google.com (mail-vs1-f47.google.com. [209.85.217.47])
        by smtp.gmail.com with ESMTPSA id o197sm25217362vkf.27.2019.04.05.08.49.38
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 05 Apr 2019 08:49:38 -0700 (PDT)
Received: by mail-vs1-f47.google.com with SMTP id f22so3763256vso.7
        for <linux-kernel@vger.kernel.org>; Fri, 05 Apr 2019 08:49:38 -0700 (PDT)
X-Received: by 2002:a67:f04e:: with SMTP id q14mr8626492vsm.133.1554479377616;
 Fri, 05 Apr 2019 08:49:37 -0700 (PDT)
MIME-Version: 1.0
References: <20190405065217.125140-1-houtao1@huawei.com>
In-Reply-To: <20190405065217.125140-1-houtao1@huawei.com>
From:   Kees Cook <keescook@chromium.org>
Date:   Fri, 5 Apr 2019 08:49:26 -0700
X-Gmail-Original-Message-ID: <CAGXu5j+939n0Sr2jZ69ga6Mf6ADo+5Y6E3q4QEFwwojR+JgA=g@mail.gmail.com>
Message-ID: <CAGXu5j+939n0Sr2jZ69ga6Mf6ADo+5Y6E3q4QEFwwojR+JgA=g@mail.gmail.com>
Subject: Re: [PATCH] sysctl: redefine zero as a unsigned long
To:     Hou Tao <houtao1@huawei.com>
Cc:     "Luis R. Rodriguez" <mcgrof@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 4, 2019 at 11:48 PM Hou Tao <houtao1@huawei.com> wrote:
>
> We have got KASAN splat when tried to set /proc/sys/fs/file-max:
>
>   BUG: KASAN: global-out-of-bounds in __do_proc_doulongvec_minmax+0x3e4/0x8f0
>   Read of size 8 at addr ffff20000f9b2980 by task file-max.sh/36819
>
>   Call trace:
>    dump_backtrace+0x0/0x3f8
>    show_stack+0x3c/0x60
>    dump_stack+0x150/0x1a8
>    print_address_description+0x2b8/0x5a0
>    kasan_report+0x278/0x648
>    __asan_load8+0x124/0x170
>    __do_proc_doulongvec_minmax+0x3e4/0x8f0
>    proc_doulongvec_minmax+0x80/0xa0
>    proc_sys_call_handler+0x188/0x2a0
>    proc_sys_write+0x5c/0x80
>    __vfs_write+0x118/0x578
>    vfs_write+0x184/0x418
>    ksys_write+0xfc/0x1e8
>    __arm64_sys_write+0x88/0xa8
>    el0_svc_common+0x1a4/0x500
>    el0_svc_handler+0xb8/0x180
>    el0_svc+0x8/0xc
>
>   The buggy address belongs to the variable:
>    zero+0x0/0x40
>
> The cause is that proc_doulongvec_minmax() is trying to cast an int
> pointer (namely &zero) to a unsigned long pointer, and dereferencing it.
>
> Although the warning seems does no harm, because zero will be placed
> in a .bss section, but it's better to kill the KASAN warning by
> redefining zero as a unsigned long, so it's OK whenever it is accessed
> as an int or a a unsigned long.
>
> An alternative fix seems to be set the minimal value of file-max to be 1,
> so one_ul can be used instead, but I'm not sure whether or not a file-max
> with a value of zero has special purpose (e.g., prohibit the file-related
> activities of all no-privileged users).
>
> Signed-off-by: Hou Tao <houtao1@huawei.com>

Acked-by: Kees Cook <keescook@chromium.org>

-Kees

> ---
>  kernel/sysctl.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/kernel/sysctl.c b/kernel/sysctl.c
> index e5da394d1ca3..03846e015013 100644
> --- a/kernel/sysctl.c
> +++ b/kernel/sysctl.c
> @@ -124,7 +124,7 @@ static int sixty = 60;
>
>  static int __maybe_unused neg_one = -1;
>
> -static int zero;
> +static unsigned long zero;
>  static int __maybe_unused one = 1;
>  static int __maybe_unused two = 2;
>  static int __maybe_unused four = 4;
> --
> 2.16.2.dirty
>


-- 
Kees Cook
