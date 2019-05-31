Return-Path: <SRS0=bMiL=T7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7D13EC28CC4
	for <linux-kernel@archiver.kernel.org>; Fri, 31 May 2019 15:45:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 52EEA26A8C
	for <linux-kernel@archiver.kernel.org>; Fri, 31 May 2019 15:45:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore-com.20150623.gappssmtp.com header.i=@paul-moore-com.20150623.gappssmtp.com header.b="fRr515es"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726713AbfEaPpo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 31 May 2019 11:45:44 -0400
Received: from mail-lf1-f66.google.com ([209.85.167.66]:37584 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726601AbfEaPpn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 May 2019 11:45:43 -0400
Received: by mail-lf1-f66.google.com with SMTP id m15so8283941lfh.4
        for <linux-kernel@vger.kernel.org>; Fri, 31 May 2019 08:45:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=/DZt8luZx8AZd+g3OwucXhV/souOkAqU6IAlufN+JIw=;
        b=fRr515esaIOr8mkEww0IKDtMKmNftE282RImc1BVF4NJkoyzWycXVzqJGvuIhA4tRg
         yGD98Ugj6GLQCyZr2JaDPuomsu1bWjRPzuDOz5QxW4SEF/qpmGwOeTDYHxJmmhOgcpvh
         YTD8txi1NP7Tf93arKTMnQTYJzJOeBgEcuaR9Nk9UIfApiKPLOM9OKvKzoFI65b+en8G
         mqoQU8m/U/4AUlvwyEhuXXJiWSMQGVpS8baWkvBUint97bO4se4HJHQ4vXPI0pA6nHPM
         QiOQRZe0fXT8C240IXihy/Ku1XNTcuFvmFzZNCsaPzcfS7NIiVdploSAO975KD9bFmyl
         O+bA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=/DZt8luZx8AZd+g3OwucXhV/souOkAqU6IAlufN+JIw=;
        b=mvTx2sm2zSdMJBf3837iuKvlxZCLbZqFr2D7/+QiX5VrWA2t83IN2+4oT4RhNnn5NE
         n9oANd1kVSi+ZwqPF0VS+T3M508wc9sndQa4X5wdIXlQnhZXOkVYYxmuzzDtwjlnxmCb
         yJ9GllEYl639YVOt5ifMXYkoNa/qMRGP8QK19jAqSgZ71UgcURwzBO/oCDEAuSXS7oRS
         MzCiJSJA0hoNNMPXhqNM4dxJC7Caup1uyOtaERZuCcA8ajxR78wYX5Hkq8tO90UYdp5T
         kioHZEJPVeeF0eXkQwCv6ZbUHjjfU+uaKK9q9yVwvdxdEja1ygsElyXMcdmjBVuqkKzP
         WSKA==
X-Gm-Message-State: APjAAAWfQ8rdn/v0iwnx+hcaQ/iyBOiLNzN7y2F44Y3a+yiOoZBqbq8B
        8L+uSnOFmdkcZy/+dmmlSo4lsqA08jkdEemMRfmU
X-Google-Smtp-Source: APXvYqzFztIsHezNj4wOvdAK/eHaIBSHz130vzxCSTL8AZkALwTZeT3dQxZbC5UR86jbnMY3vWbN4D58tPPMshgs18U=
X-Received: by 2002:a19:c301:: with SMTP id t1mr6164138lff.137.1559317540060;
 Fri, 31 May 2019 08:45:40 -0700 (PDT)
MIME-Version: 1.0
References: <20190531013350.GA4642@zhanggen-UX430UQ>
In-Reply-To: <20190531013350.GA4642@zhanggen-UX430UQ>
From:   Paul Moore <paul@paul-moore.com>
Date:   Fri, 31 May 2019 11:45:28 -0400
Message-ID: <CAHC9VhTmj8b9jYMaXd=ORhBgTAWUgF=srgqAXkECe7MFkDXOmg@mail.gmail.com>
Subject: Re: [PATCH v2] hooks: fix a missing-check bug in selinux_sb_eat_lsm_opts()
To:     Gen Zhang <blackgod016574@gmail.com>
Cc:     Stephen Smalley <sds@tycho.nsa.gov>,
        Eric Paris <eparis@parisplace.org>, selinux@vger.kernel.org,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        bpf@vger.kernel.org, omosnace@redhat.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 30, 2019 at 9:34 PM Gen Zhang <blackgod016574@gmail.com> wrote:
>
> In selinux_sb_eat_lsm_opts(), 'arg' is allocated by kmemdup_nul(). It
> returns NULL when fails. So 'arg' should be checked.
>
> Signed-off-by: Gen Zhang <blackgod016574@gmail.com>
> Reviewed-by: Ondrej Mosnacek <omosnace@redhat.com>
> Fixes: 99dbbb593fe6 ("selinux: rewrite selinux_sb_eat_lsm_opts()")

One quick note about the subject line, instead of using "hooks:" you
should use "selinux:" since this is specific to SELinux.  If the patch
did apply to the LSM framework as a whole, I would suggest using
"lsm:" instead of "hooks:" as "hooks" is too ambiguous of a prefix.

> diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
> index 3ec702c..5a9e959 100644
> --- a/security/selinux/hooks.c
> +++ b/security/selinux/hooks.c
> @@ -2635,6 +2635,8 @@ static int selinux_sb_eat_lsm_opts(char *options, void **mnt_opts)
>                                                 *q++ = c;
>                                 }
>                                 arg = kmemdup_nul(arg, q - arg, GFP_KERNEL);
> +                               if (!arg)
> +                                       return -ENOMEM;

It seems like we should also check for, and potentially free *mnt_opts
as the selinux_add_opt() error handling does just below this change,
yes?  If that is the case we might want to move that error handling
code to the bottom of the function and jump there on error.

>                         }
>                         rc = selinux_add_opt(token, arg, mnt_opts);
>                         if (unlikely(rc)) {

-- 
paul moore
www.paul-moore.com
