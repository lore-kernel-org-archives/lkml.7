Return-Path: <SRS0=Dgga=T6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B157BC28CC2
	for <linux-kernel@archiver.kernel.org>; Thu, 30 May 2019 08:28:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 86F1A24168
	for <linux-kernel@archiver.kernel.org>; Thu, 30 May 2019 08:28:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726604AbfE3I2y (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 May 2019 04:28:54 -0400
Received: from mail-oi1-f196.google.com ([209.85.167.196]:42101 "EHLO
        mail-oi1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726079AbfE3I2y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 May 2019 04:28:54 -0400
Received: by mail-oi1-f196.google.com with SMTP id v25so3750963oic.9
        for <linux-kernel@vger.kernel.org>; Thu, 30 May 2019 01:28:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=a4/V6C9EK4vY7/JLXibmWc3UiOpGTZPM0ljUbojs3aI=;
        b=uSf9qd5czeq/E4Z8ATFJgo8BGPC/lhO/Dko6Tlpu1FaSw+IKCbOU0ULNjn2rjhoXnY
         l5ZfhHxoe4SGAKaZmWn4sGUnb0YaIoleNM1bzlkfEbBuoRCxcpyo0QiNV5Z8F6HlPW/o
         qnJf2Z/u9u7lf7Mkj5RgJCVFE4je/5phDWonfjljkkRXkrGL0gsabzW5ZMecjWsbmWQj
         7iw1R4Xm6LGn4e/mIreSJGOkc3gSChLRUztgxh1Lg3wMpAlTERSJHUnj3TGVKJ/FzCsq
         5EkOx1+E11wl5aeCvmFJoXXSXIHhx5OafHCm8TMRfLuoRYk5g/AOu85RI2LeS3t3Q/1A
         6fUw==
X-Gm-Message-State: APjAAAUWdktOQDP00puNrB2Mn6megomJJTduN/ipTvguqHA/bdWbrDXG
        caRMIL5TllBKXSmmTG5Ma1Ued88ggwizuHqkYuoybQ==
X-Google-Smtp-Source: APXvYqz8Iw8/yjTeW0ZPob8U9xgh/OrWA3XSOSxGUsJCtkPzLy3bnytgOFnAYpOTDJoJ1VvfTiEd8WIOqAIMIBngZT4=
X-Received: by 2002:aca:e146:: with SMTP id y67mr1244852oig.127.1559204933231;
 Thu, 30 May 2019 01:28:53 -0700 (PDT)
MIME-Version: 1.0
References: <20190530035310.GA9127@zhanggen-UX430UQ>
In-Reply-To: <20190530035310.GA9127@zhanggen-UX430UQ>
From:   Ondrej Mosnacek <omosnace@redhat.com>
Date:   Thu, 30 May 2019 10:28:46 +0200
Message-ID: <CAFqZXNv-54DJhd8gyUhwDo6RvmjFGSHo=+s-BVsL87S+u0cQxQ@mail.gmail.com>
Subject: Re: [PATCH] hooks: fix a missing-check bug in selinux_sb_eat_lsm_opts()
To:     Gen Zhang <blackgod016574@gmail.com>
Cc:     Paul Moore <paul@paul-moore.com>, tony.luck@intel.com,
        Stephen Smalley <sds@tycho.nsa.gov>,
        Eric Paris <eparis@parisplace.org>, selinux@vger.kernel.org,
        Linux kernel mailing list <linux-kernel@vger.kernel.org>,
        bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 30, 2019 at 5:53 AM Gen Zhang <blackgod016574@gmail.com> wrote:
> In selinux_sb_eat_lsm_opts(), 'arg' is allocated by kmemdup_nul(). It
> returns NULL when fails. So 'arg' should be checked.
>
> Signed-off-by: Gen Zhang <blackgod016574@gmail.com>

Since it looks like you are going to respin this patch, please add:

Fixes: 99dbbb593fe6 ("selinux: rewrite selinux_sb_eat_lsm_opts()")

to the commit message so that there is a record of which commit
introduced the issue (then it can be picked up automatically for
backport into the relevant stable kernels).

Thanks for spotting the issue and sending the patch(es)!

> ---
> diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
> index 3ec702c..5a9e959 100644
> --- a/security/selinux/hooks.c
> +++ b/security/selinux/hooks.c
> @@ -2635,6 +2635,8 @@ static int selinux_sb_eat_lsm_opts(char *options, void **mnt_opts)
>                                                 *q++ = c;
>                                 }
>                                 arg = kmemdup_nul(arg, q - arg, GFP_KERNEL);
> +                               if (!arg)
> +                                       return 0;
>                         }
>                         rc = selinux_add_opt(token, arg, mnt_opts);
>                         if (unlikely(rc)) {

-- 
Ondrej Mosnacek <omosnace at redhat dot com>
Software Engineer, Security Technologies
Red Hat, Inc.
