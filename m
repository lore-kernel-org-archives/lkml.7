Return-Path: <SRS0=D3m8=SL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6FED5C10F0E
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Apr 2019 06:21:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 39C0F2083E
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Apr 2019 06:21:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="b30B1H1w"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726447AbfDIGVg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Apr 2019 02:21:36 -0400
Received: from mail-io1-f67.google.com ([209.85.166.67]:38992 "EHLO
        mail-io1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726081AbfDIGVg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Apr 2019 02:21:36 -0400
Received: by mail-io1-f67.google.com with SMTP id e13so13247917ioq.6;
        Mon, 08 Apr 2019 23:21:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=5hvlNivR8VkvART7uyUNxm4Yu7jNqlP3IBinQFJAIRc=;
        b=b30B1H1whGteyy1JzywdfR7b050WfwRtu6icxC4WvMiEp4eG7Nv7AQ2Z3nxiFhDFN9
         FlqSKGZJhiKGqYQ4Rxk4VxD8Famlg1G5SY72sdv7IYmeb8Ohlda57OIk6PmTOgXFPU1m
         ajW7H8QNcrCTxpK40Shur25fak8H6vDML47J4rQ2zVCTh36/QVXGaAw8c3nJ7SvAiKm2
         rcEQOZ1TTlBFJx8/9ebzM6aj3GnctJiVkbpWKtp8oFq5zBOy7KuH6c7wXr1aqbNJqq6Z
         KJXCrZEvy0K2DJHEBZha3YJLcHsf8c80+GgC+K00Gq2O4JIDm810zshJoSo20rpzd/c/
         TFnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=5hvlNivR8VkvART7uyUNxm4Yu7jNqlP3IBinQFJAIRc=;
        b=VhzxonHN8fSFtGl4aPb0/aQzzkLFVjNi8bpjvvdyCHTT3w6eejQY5MOJDrIDfcWP3B
         xgvWYxnZuFrghQ/EHxhhB8L73TWkW+L+DOBDUVTMkAc19C3D0LJXQy9edlQtBcgRphMV
         c+PBtS7qByHB9CujCC96XQye1wqxdu5MeNzky+S16WcxgOd70GaXPYCT/v4WpGxpamfh
         cpwMtxuElu0qC2vhN0ykfwJubvGwY0MO2WehunMjRaYAV7iXEfX59Y2UI675la0usTbo
         EgVOZH5s1pJ4Biqy8Axb0EwmZ7pT3E6VV/6rRiH/Emv3hUR8/16zNfrlLIj+D1idhLDg
         38eg==
X-Gm-Message-State: APjAAAXAoNVNF8Q3FOop3z5bFQOKi1PrHs7qn8q5E+qv104+hKrGkDjH
        bdPlNSGpJ6Z82LE3JSYZeERLTRhvOvQ+dyoYSqI=
X-Google-Smtp-Source: APXvYqzBDwfb+KSmx54S0P5I7hTBLRBKEfGjhOhQWpAM4739ORDlD1B4oHNa4uNDlnJe2bw9aDv8QlQako4KkRo4waA=
X-Received: by 2002:a5e:9912:: with SMTP id t18mr22383532ioj.157.1554790895426;
 Mon, 08 Apr 2019 23:21:35 -0700 (PDT)
MIME-Version: 1.0
References: <20190408160706.GA18786@beast>
In-Reply-To: <20190408160706.GA18786@beast>
From:   David Rheinsberg <david.rheinsberg@gmail.com>
Date:   Tue, 9 Apr 2019 08:21:23 +0200
Message-ID: <CADyDSO4NkEY-SPT-abnyRXT9kGWhF8LbU3XQGNp-5k_15debDg@mail.gmail.com>
Subject: Re: [PATCH] apparmor: Restore Y/N in /sys for apparmor's "enabled"
To:     Kees Cook <keescook@chromium.org>
Cc:     James Morris <jmorris@namei.org>,
        John Johansen <john.johansen@canonical.com>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi

On Mon, Apr 8, 2019 at 6:07 PM Kees Cook <keescook@chromium.org> wrote:
>
> Before commit c5459b829b71 ("LSM: Plumb visibility into optional "enabled"
> state"), /sys/module/apparmor/parameters/enabled would show "Y" or "N"
> since it was using the "bool" handler. After being changed to "int",
> this switched to "1" or "0", breaking the userspace AppArmor detection
> of dbus-broker. This restores the Y/N output while keeping the LSM
> infrastructure happy.
>
> Before:
>         $ cat /sys/module/apparmor/parameters/enabled
>         1
>
> After:
>         $ cat /sys/module/apparmor/parameters/enabled
>         Y
>
> Reported-by: David Rheinsberg <david.rheinsberg@gmail.com>
> Link: https://lkml.kernel.org/r/CADyDSO6k8vYb1eryT4g6+EHrLCvb68GAbHVWuULkYjcZcYNhhw@mail.gmail.com
> Fixes: c5459b829b71 ("LSM: Plumb visibility into optional "enabled" state")
> Signed-off-by: Kees Cook <keescook@chromium.org>
> ---
> This fix, if John is okay with it, is needed in v5.1 to correct the
> userspace regression reported by David.
> ---
>  security/apparmor/lsm.c | 49 ++++++++++++++++++++++++++++++++++++++++-
>  1 file changed, 48 insertions(+), 1 deletion(-)

This looks good to me. Thanks a lot! If this makes v5.1, I will leave
the apparmor-detection in dbus-broker as it is, unless someone asks me
to parse 0/1 as well?

I cannot judge whether the apparmor_initialized check is correct, but
for the parameter parsing:

Reviewed-by: David Rheinsberg <david.rheinsberg@gmail.com>

Thanks
David

> diff --git a/security/apparmor/lsm.c b/security/apparmor/lsm.c
> index 49d664ddff44..87500bde5a92 100644
> --- a/security/apparmor/lsm.c
> +++ b/security/apparmor/lsm.c
> @@ -1336,9 +1336,16 @@ module_param_named(path_max, aa_g_path_max, aauint, S_IRUSR);
>  bool aa_g_paranoid_load = true;
>  module_param_named(paranoid_load, aa_g_paranoid_load, aabool, S_IRUGO);
>
> +static int param_get_aaintbool(char *buffer, const struct kernel_param *kp);
> +static int param_set_aaintbool(const char *val, const struct kernel_param *kp);
> +#define param_check_aaintbool param_check_int
> +static const struct kernel_param_ops param_ops_aaintbool = {
> +       .set = param_set_aaintbool,
> +       .get = param_get_aaintbool
> +};
>  /* Boot time disable flag */
>  static int apparmor_enabled __lsm_ro_after_init = 1;
> -module_param_named(enabled, apparmor_enabled, int, 0444);
> +module_param_named(enabled, apparmor_enabled, aaintbool, 0444);
>
>  static int __init apparmor_enabled_setup(char *str)
>  {
> @@ -1413,6 +1420,46 @@ static int param_get_aauint(char *buffer, const struct kernel_param *kp)
>         return param_get_uint(buffer, kp);
>  }
>
> +/* Can only be set before AppArmor is initialized (i.e. on boot cmdline). */
> +static int param_set_aaintbool(const char *val, const struct kernel_param *kp)
> +{
> +       struct kernel_param kp_local;
> +       bool value;
> +       int error;
> +
> +       if (apparmor_initialized)
> +               return -EPERM;
> +
> +       /* Create local copy, with arg pointing to bool type. */
> +       value = !!*((int *)kp->arg);
> +       memcpy(&kp_local, kp, sizeof(kp_local));
> +       kp_local.arg = &value;
> +
> +       error = param_set_bool(val, &kp_local);
> +       if (!error)
> +               *((int *)kp->arg) = *((bool *)kp_local.arg);
> +       return error;
> +}
> +
> +/*
> + * To avoid changing /sys/module/apparmor/parameters/enabled from Y/N to
> + * 1/0, this converts the "int that is actually bool" back to bool for
> + * display in the /sys filesystem, while keeping it "int" for the LSM
> + * infrastructure.
> + */
> +static int param_get_aaintbool(char *buffer, const struct kernel_param *kp)
> +{
> +       struct kernel_param kp_local;
> +       bool value;
> +
> +       /* Create local copy, with arg pointing to bool type. */
> +       value = !!*((int *)kp->arg);
> +       memcpy(&kp_local, kp, sizeof(kp_local));
> +       kp_local.arg = &value;
> +
> +       return param_get_bool(buffer, &kp_local);
> +}
> +
>  static int param_get_audit(char *buffer, const struct kernel_param *kp)
>  {
>         if (!apparmor_enabled)
> --
> 2.17.1
>
>
> --
> Kees Cook
