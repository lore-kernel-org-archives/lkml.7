Return-Path: <SRS0=Q+aa=S3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-19.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 90DFAC43219
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Apr 2019 17:25:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 193F12084F
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Apr 2019 17:25:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="YFVS8CVG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729317AbfDYRZe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Apr 2019 13:25:34 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:43248 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726026AbfDYRZd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Apr 2019 13:25:33 -0400
Received: by mail-pg1-f194.google.com with SMTP id z9so166924pgu.10
        for <linux-kernel@vger.kernel.org>; Thu, 25 Apr 2019 10:25:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=BGO5PeOx4EywII+WufZaW3LwurSYHhWavRHFNwcCV6k=;
        b=YFVS8CVGWcz/YNeZ1CZ0/9v17Fr46klUjonqlN6JPydHaCEiMge3DmNXeKGlCFc8mx
         lLmaMVSs/uXkJaTKjlHE0MvFKV150BdhsnJK5n1g3pf8TXEcjHEPByCn+Coxdggid37G
         3kkGrt08aNRY+F6LGZtT4eLwa9KKXGFUNfeNiqrpjo3NAfL6bMXLy9G1ASJ39LAQ60ki
         QSsLPefS6q+YStwKe3zXo/Zs5ZAawatIIUMqu+mYnTs9KRlQRqD6zcc0nXLhfbH5DlwP
         Bx1hUsWFuTSpsOmAINyJolt3hq2Sg+xCIiDejtEGQp4aQlRgCXta4uTqZyxYQRV6pcTJ
         lKdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=BGO5PeOx4EywII+WufZaW3LwurSYHhWavRHFNwcCV6k=;
        b=Q7WBXSRGUGFuizN6EGR0/K/jx2d54AViQzE5kR9j1Fj1Ler/+24LWrhhmHlJo7qobO
         Qwr9043ngB2GEGRP6VIKPqukyqXY2116DDDQZkC6Ty/fjJeVtzb0i3JzCke1UDWDBzGO
         yF37zAQraIrnCLPSgqjrHu6pEaD0bN9o5XIXfqC0rghMoyId5ZtT8etS9fVmUwi1BU42
         sEXjLSWznoyEJOEZF3J2A8zxlXNR+XPhArTD52uvkTSw8JdIpNcd1jbKheZnOG2cu/RS
         AJycJ9mKxFFfu1ABcamgdhAJc+efgRGlDqwgab3IyLYqmEJ6ApVN406JI9KuFW07QVJy
         APQQ==
X-Gm-Message-State: APjAAAXDLQIsvI+kW65aWaPZVfuh+2OQBtRfwygA2KdHrUGmcDkCX0so
        GyhUxiGng+y+JKiUMBo8rqcY+4OY7b5+Kil3pKcsXg==
X-Google-Smtp-Source: APXvYqzb0VnDMtr2epgIsdSRI9r+lvt6rNefoSflPKhEC35ePlc3+Q/tsv6n+CYHE75UCPBY4ciSxH0P0BH79vHSYm0=
X-Received: by 2002:a63:4558:: with SMTP id u24mr36749360pgk.225.1556213131350;
 Thu, 25 Apr 2019 10:25:31 -0700 (PDT)
MIME-Version: 1.0
References: <20190425062720.26695-1-natechancellor@gmail.com>
In-Reply-To: <20190425062720.26695-1-natechancellor@gmail.com>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Thu, 25 Apr 2019 10:25:20 -0700
Message-ID: <CAKwvOdk1DHiUkpByC-yReoO7udE-ipW_9D+EvHGSH8BiokcOMQ@mail.gmail.com>
Subject: Re: [PATCH] drm/komeda: Use memset to initialize config_id
To:     Nathan Chancellor <natechancellor@gmail.com>
Cc:     "James (Qian) Wang" <james.qian.wang@arm.com>,
        Liviu Dudau <liviu.dudau@arm.com>,
        Brian Starkey <brian.starkey@arm.com>, malidp@foss.arm.com,
        dri-devel@lists.freedesktop.org,
        LKML <linux-kernel@vger.kernel.org>,
        clang-built-linux@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 24, 2019 at 11:27 PM Nathan Chancellor
<natechancellor@gmail.com> wrote:
>
> Clang warns:
>
> drivers/gpu/drm/arm/display/komeda/komeda_dev.c:76:38: warning: suggest
> braces around initialization of subobject [-Wmissing-braces]
>         union komeda_config_id config_id = {0,};
>                                             ^
>                                             {}
> 1 warning generated.
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
> Fixes: 4cc734cb79a8 ("drm/komeda: Add sysfs attribute: core_id and config_id")
> Link: https://github.com/ClangBuiltLinux/linux/issues/457
> Signed-off-by: Nathan Chancellor <natechancellor@gmail.com>
> ---
>  drivers/gpu/drm/arm/display/komeda/komeda_dev.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/arm/display/komeda/komeda_dev.c b/drivers/gpu/drm/arm/display/komeda/komeda_dev.c
> index 9d6c31cca875..e605a518f59a 100644
> --- a/drivers/gpu/drm/arm/display/komeda/komeda_dev.c
> +++ b/drivers/gpu/drm/arm/display/komeda/komeda_dev.c
> @@ -73,9 +73,10 @@ config_id_show(struct device *dev, struct device_attribute *attr, char *buf)
>  {
>         struct komeda_dev *mdev = dev_to_mdev(dev);
>         struct komeda_pipeline *pipe = mdev->pipelines[0];
> -       union komeda_config_id config_id = {0,};

Haven't seen a trailing comma too often.  Thanks for the patch.
Reviewed-by: Nick Desaulniers <ndesaulniers@google.com>

> +       union komeda_config_id config_id;
>         int i;
>
> +       memset(&config_id, 0, sizeof(config_id));
>         config_id.max_line_sz = pipe->layers[0]->hsize_in.end;
>         config_id.n_pipelines = mdev->n_pipelines;
>         config_id.n_scalers = pipe->n_scalers;
> --
> 2.21.0
>


-- 
Thanks,
~Nick Desaulniers
