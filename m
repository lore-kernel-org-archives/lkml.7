Return-Path: <SRS0=2dYc=UG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51070C2BCA1
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Jun 2019 08:39:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 34CF7208E3
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Jun 2019 08:39:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727296AbfFGIjR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Jun 2019 04:39:17 -0400
Received: from mail-ot1-f68.google.com ([209.85.210.68]:46465 "EHLO
        mail-ot1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726531AbfFGIjR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Jun 2019 04:39:17 -0400
Received: by mail-ot1-f68.google.com with SMTP id z23so1101662ote.13
        for <linux-kernel@vger.kernel.org>; Fri, 07 Jun 2019 01:39:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=IEBaZDPZd7L7KgNJ6ypOJKuSsVmtOiA4l4zYpRROEo0=;
        b=DbdAgu3bYlD/oQ38raLvIjWTZ7zC/dDBv/VSsm2YX532ls+htAGgrnpdrxXDPUlNET
         stzT4uBln9ynZX2SUzP1QMCCoTroHW04EgmNiBfvvP9AW3DNDIKwJLkpfnlJzUu3rWJL
         i9t/cP+PWms9g23XTnIHSQEoGBgyt64RmkPKiPOApghp30EtIR/0gSNnJ/ZrDqjk7O4X
         7nZjCs3NiwbNuxWiF6k/PQH0WHYW2RUQ/nXd3cskZ+R9BRBvuJfWfkTE1XK4jaKjNJD0
         PsoAZ63E9817K/BHM0RXVvdmuoPLESRxDti7Zi7JwCEzdhYUbQ/gYMH0Zh/u2bN8ZJAr
         1HmA==
X-Gm-Message-State: APjAAAVx9CMeI7hwQEtTGgI6S3ZykLFdJaTO84YmbxjIBGbAUgJXJwWo
        lZ3m85PO+MBINXa9nvcHOJdmqE2ji47SxzYC48Mu5tCNdKA=
X-Google-Smtp-Source: APXvYqzcPEzjWAhwz/eXHQbLT97yDgHMsd55igo2ERsepjIiDyFkf+6AtDrurtZyr02zLA7o+hq7J/3fARWsSX/apW0=
X-Received: by 2002:a9d:6a8a:: with SMTP id l10mr8355597otq.197.1559896755579;
 Fri, 07 Jun 2019 01:39:15 -0700 (PDT)
MIME-Version: 1.0
References: <20190606092342.GA21672@zhanggen-UX430UQ>
In-Reply-To: <20190606092342.GA21672@zhanggen-UX430UQ>
From:   Ondrej Mosnacek <omosnace@redhat.com>
Date:   Fri, 7 Jun 2019 10:39:05 +0200
Message-ID: <CAFqZXNuricWOMH3fQiCbPZyz2qwf7Gw1zmx1o+wLeTELSF=CUQ@mail.gmail.com>
Subject: Re: [PATCH v3] selinux: lsm: fix a missing-check bug in
 selinux_add_mnt_opt( )
To:     Gen Zhang <blackgod016574@gmail.com>
Cc:     Paul Moore <paul@paul-moore.com>,
        Stephen Smalley <sds@tycho.nsa.gov>,
        Eric Paris <eparis@parisplace.org>, selinux@vger.kernel.org,
        Linux kernel mailing list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 6, 2019 at 11:23 AM Gen Zhang <blackgod016574@gmail.com> wrote:
> In selinux_add_mnt_opt(), 'val' is allocated by kmemdup_nul(). It returns
> NULL when fails. So 'val' should be checked. And 'mnt_opts' should be
> freed when error.
>
> Signed-off-by: Gen Zhang <blackgod016574@gmail.com>
> Fixes: 757cbe597fe8 ("LSM: new method: ->sb_add_mnt_opt()")
> ---
> diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
> index 3ec702c..4e4c1c6 100644
> --- a/security/selinux/hooks.c
> +++ b/security/selinux/hooks.c
> @@ -1052,15 +1052,23 @@ static int selinux_add_mnt_opt(const char *option, const char *val, int len,
>         if (token == Opt_error)
>                 return -EINVAL;
>
> -       if (token != Opt_seclabel)
> -               val = kmemdup_nul(val, len, GFP_KERNEL);
> +       if (token != Opt_seclabel) {
> +                       val = kmemdup_nul(val, len, GFP_KERNEL);
> +                       if (!val) {
> +                               rc = -ENOMEM;
> +                               goto free_opt;
> +                       }
> +       }
>         rc = selinux_add_opt(token, val, mnt_opts);
>         if (unlikely(rc)) {
>                 kfree(val);
> -               if (*mnt_opts) {
> -                       selinux_free_mnt_opts(*mnt_opts);
> -                       *mnt_opts = NULL;
> -               }
> +               goto free_opt;
> +       }
> +       return rc;

At this point rc is guaranteed to be 0, so you can just 'return 0' for
clarity. Also, I visually prefer an empty line between a return
statement and a goto label, but I'm not sure what is the
general/maintainer's preference.

Also, you should drop the "lsm: " from the subject - it is redundant
and doesn't follow the SELinux convention. See `git log --oneline --
security/selinux/` for what the subjects usually look like - mostly we
just go with "selinux: <description>" (or "LSM: <description>" when
the changes affect the shared LSM interface).

> +free_opt:
> +       if (*mnt_opts) {
> +               selinux_free_mnt_opts(*mnt_opts);
> +               *mnt_opts = NULL;
>         }
>         return rc;
>  }

--
Ondrej Mosnacek <omosnace at redhat dot com>
Software Engineer, Security Technologies
Red Hat, Inc.
