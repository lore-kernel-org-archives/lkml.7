Return-Path: <SRS0=Dr8o=U4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2163C4321A
	for <linux-kernel@archiver.kernel.org>; Sat, 29 Jun 2019 13:19:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BA646208E3
	for <linux-kernel@archiver.kernel.org>; Sat, 29 Jun 2019 13:19:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="q9+fIyAw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726947AbfF2NS7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 29 Jun 2019 09:18:59 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:40300 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726723AbfF2NS6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 29 Jun 2019 09:18:58 -0400
Received: by mail-pf1-f196.google.com with SMTP id p184so4329379pfp.7;
        Sat, 29 Jun 2019 06:18:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=uE4JWFxIDLE7QZ3dkStTMJSounb4q6HcO5SZYQs1Co8=;
        b=q9+fIyAwictr27nY1/xezbD7JUcdXBpscjlxo3l3gnmjHwO9OVhpcl0jzKZgZh1JqC
         QqEzj/eRMIUDqMRVfOZDUn7EtKVF8NwhnxhALgfB106kPs/Z52Hk92KtQiD03ijsyTDn
         YiwokvLxYxlWjQ1Pl25vJ117xyscSn+y6Kkp98km57hiuDksTlCvycQm2kqygJBA8NJR
         jlgJDTJxZEcZQWkxwHJuuNtiShnFoVQt9bfkgtK4iR90nvborGL/8cJty2AzzSiC9yHZ
         21OssENh3LhW6n2l7FMoYdEiCcvT5WivVbp7Z6uBOMtIxriYSegkEEsjr9RLKlCgbbR/
         9hVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=uE4JWFxIDLE7QZ3dkStTMJSounb4q6HcO5SZYQs1Co8=;
        b=LcN8SvQOPnXDZvu4WyFqzlNRcep30DVMBvcc5WBpjpMBGZ4Jt53dru+ydwbSy3IBsG
         bXDvJcU3mBa51dswnl8VljQBzKKqKulFoIAhnZfaex0ZWgUqaK6s6mGSIUUpNdVkNYxW
         psrm9rQkqEZrrM4Kty1KYQ5RrB9luys9mGYshRbMQyzkLJ9/iphwsdMX3wVyfwOED0eS
         6lTdLcxS45DcyHQn81y7D0s3atH1YNue2Hj39j26x5HLQs0kBJXPdWuTvm9myltfrzUu
         cR4yDnCeZ7NB4SqJwg2fP10lArMyqi4U0FDdj7vNmTmV5jnHokQEuZmX2jVLsuUhMCkt
         mMpQ==
X-Gm-Message-State: APjAAAWmhZwV2+3sJxYvcbXrDP/k6Fdhktb2KBOYK91n/RYrNxYOeBa+
        hzrzn8ak1TFYz5l+SV2zB7QVyZABVq0oqNPpJSw=
X-Google-Smtp-Source: APXvYqy0Ei/3YH571qP80ANeoil9DAzasU3yxaoAgq8C9V7FZozwLCDd6INRwEyMNG6uoBQOFSup6xXG/b4NkcGEoAA=
X-Received: by 2002:a65:448b:: with SMTP id l11mr14215898pgq.74.1561814337909;
 Sat, 29 Jun 2019 06:18:57 -0700 (PDT)
MIME-Version: 1.0
References: <20190614080940.13640-1-rajneesh.bhardwaj@linux.intel.com>
In-Reply-To: <20190614080940.13640-1-rajneesh.bhardwaj@linux.intel.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Sat, 29 Jun 2019 16:18:45 +0300
Message-ID: <CAHp75VfMdKqpC3_gF-VzcJQqiWM9E0irORr60KLXyu8HuQg9KA@mail.gmail.com>
Subject: Re: [PATCH] platform/x86: intel_pmc_core: Add ICL-NNPI support to PMC Core
To:     Rajneesh Bhardwaj <rajneesh.bhardwaj@linux.intel.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Vishwanath Somayaji <vishwanath.somayaji@intel.com>,
        Darren Hart <dvhart@infradead.org>,
        Andy Shevchenko <andy@infradead.org>,
        Platform Driver <platform-driver-x86@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 14, 2019 at 11:14 AM Rajneesh Bhardwaj
<rajneesh.bhardwaj@linux.intel.com> wrote:
>
> Ice Lake Neural Network Processor for deep learning inference a.k.a.
> ICL-NNPI can re-use Ice Lake Mobile regmap to enable Intel PMC Core
> driver on it.
>

This will be postponed till next cycle since the CPU model will not
appear before merge window.
So, please, resend than (I guess somewhat in a month).

> Cc: Darren Hart <dvhart@infradead.org>
> Cc: Andy Shevchenko <andy@infradead.org>
> Cc: platform-driver-x86@vger.kernel.org
> Link: https://lkml.org/lkml/2019/6/5/1034
> Signed-off-by: Rajneesh Bhardwaj <rajneesh.bhardwaj@linux.intel.com>
> ---
>  drivers/platform/x86/intel_pmc_core.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/drivers/platform/x86/intel_pmc_core.c b/drivers/platform/x86/intel_pmc_core.c
> index 1d902230ba61..be6cda89dcf5 100644
> --- a/drivers/platform/x86/intel_pmc_core.c
> +++ b/drivers/platform/x86/intel_pmc_core.c
> @@ -815,6 +815,7 @@ static const struct x86_cpu_id intel_pmc_core_ids[] = {
>         INTEL_CPU_FAM6(KABYLAKE_DESKTOP, spt_reg_map),
>         INTEL_CPU_FAM6(CANNONLAKE_MOBILE, cnp_reg_map),
>         INTEL_CPU_FAM6(ICELAKE_MOBILE, icl_reg_map),
> +       INTEL_CPU_FAM6(ICELAKE_NNPI, icl_reg_map),
>         {}
>  };
>
> --
> 2.17.1
>


-- 
With Best Regards,
Andy Shevchenko
