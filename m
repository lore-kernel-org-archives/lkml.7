Return-Path: <SRS0=5wok=UM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15A14C31E45
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Jun 2019 18:26:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E39D720679
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Jun 2019 18:26:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="DRZH+bbs"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728550AbfFMS0z (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Jun 2019 14:26:55 -0400
Received: from mail-pl1-f195.google.com ([209.85.214.195]:46846 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727301AbfFMS0x (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Jun 2019 14:26:53 -0400
Received: by mail-pl1-f195.google.com with SMTP id e5so8497461pls.13
        for <linux-kernel@vger.kernel.org>; Thu, 13 Jun 2019 11:26:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=DCSwLCAumFrPz4M+TgatLYzC2CNUxBHne1EyoUjckX4=;
        b=DRZH+bbs/PxFORs+fs8o/Z/vFJ9lOPYBCTz8KJ0ez2NGE93BleqM4m3xLsXk8uPKdn
         4fO2/l2PdlE2rWbY72e2SY0dHuZbwb0y8kL1OEwG4O9SJ0308kLRYYG22sLpePVXClqS
         DBxulwp11rR9In4MAt+LJuDAoqvgkgnpT6LtpC5EqwQbSK9m9fX9e1LLZ8lfDhr59KKD
         aTf3/txuFs3YgaSAzvBgVItKHmJPuVgrtGEj9+oMMLYqDldSeeAKIRHIqXC5CJ3yZMqE
         qdWlENTC25TGjbItWsM6aCPv6c2QCAu5KTCSIVHThiPyvsvLdo5M95fHyCxxn4YQUPUV
         v+lQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=DCSwLCAumFrPz4M+TgatLYzC2CNUxBHne1EyoUjckX4=;
        b=LWW+CtdMEy4HNiT5+dqyzSk4t9F0dl5FFx7ZT4xKQOHMlOG+ZA7oCzFAmvrCCCZnXQ
         ZltzLYpQ0nGHNKnPBA4lQT0pv2vONVaVIfMa8PBL+yNXJkopsfUZBMLgUiQljkuRzv10
         5AseDf7Qs4wZ0CcWtlDfqHw12pByUJwrrJ/ELaPpgapT4y/4+/ygS5E23ej+AQpnvFSq
         kjeDE7fkZWdbyJbALvRMTSl4C1uIfcTkk/Uzj7yIAs0fF89QjrtLZb7Zage6P+Lo+mvh
         2ViKgszAtzY3vqVq9N20S8eXZHXMNbJsrgAYFGcgdu2tNRdnaj2QtMcrFaOPHAoINrPj
         cv4A==
X-Gm-Message-State: APjAAAW+Y73MWYpfh03TN/SWCLFFqTW+xkVJbQ5PTKJiIifpsNlv6gm+
        IpedIEIJ2hD5dFtzG9eJJZCfcVV17JXkEpke4oa+kA==
X-Google-Smtp-Source: APXvYqyuIOy41PtVn3XCILRP3Kw2qLTEAWNAnwrQCLdwZu2+UKzrSEwu3zpW6r8J7vsVr7599DvMhNLa8VTiAsiRJ3g=
X-Received: by 2002:a17:902:9f93:: with SMTP id g19mr73666606plq.223.1560450412105;
 Thu, 13 Jun 2019 11:26:52 -0700 (PDT)
MIME-Version: 1.0
References: <CAKwvOdnjTxzXgPHQcC7K8N5YkTvh66sy86oorPJZc07b7UBhGw@mail.gmail.com>
 <20190613182326.237391-1-nhuck@google.com>
In-Reply-To: <20190613182326.237391-1-nhuck@google.com>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Thu, 13 Jun 2019 11:26:41 -0700
Message-ID: <CAKwvOd=252Ak-VQ20XtsGaRXEfraxtNTNjhjYfdrsWv_7OHsoQ@mail.gmail.com>
Subject: Re: [PATCH v2] Input: atmel_mxt_ts - fix -Wunused-const-variable
To:     Nathan Huckleberry <nhuck@google.com>
Cc:     nick@shmanahar.org, dmitry.torokhov@gmail.com,
        linux-input@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
        clang-built-linux <clang-built-linux@googlegroups.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 13, 2019 at 11:24 AM 'Nathan Huckleberry' via Clang Built
Linux <clang-built-linux@googlegroups.com> wrote:
> Changes from v1 -> v2
> * Moved definition of mxt_video_fops into existing ifdef

Thanks for the v2.
Reviewed-by: Nick Desaulniers <ndesaulniers@google.com>

> --- a/drivers/input/touchscreen/atmel_mxt_ts.c
> +++ b/drivers/input/touchscreen/atmel_mxt_ts.c
> @@ -256,16 +256,6 @@ enum v4l_dbg_inputs {
>         MXT_V4L_INPUT_MAX,
>  };
>
> -static const struct v4l2_file_operations mxt_video_fops = {
> -       .owner = THIS_MODULE,
> -       .open = v4l2_fh_open,
> -       .release = vb2_fop_release,
> -       .unlocked_ioctl = video_ioctl2,
> -       .read = vb2_fop_read,
> -       .mmap = vb2_fop_mmap,
> -       .poll = vb2_fop_poll,
> -};
> -
>  enum mxt_suspend_mode {
>         MXT_SUSPEND_DEEP_SLEEP  = 0,
>         MXT_SUSPEND_T9_CTRL     = 1,
> @@ -2218,6 +2208,16 @@ static int mxt_init_t7_power_cfg(struct mxt_data *data)
>  }
>
>  #ifdef CONFIG_TOUCHSCREEN_ATMEL_MXT_T37
> +static const struct v4l2_file_operations mxt_video_fops = {
> +       .owner = THIS_MODULE,
> +       .open = v4l2_fh_open,
> +       .release = vb2_fop_release,
> +       .unlocked_ioctl = video_ioctl2,
> +       .read = vb2_fop_read,
> +       .mmap = vb2_fop_mmap,
> +       .poll = vb2_fop_poll,
> +};
> +

-- 
Thanks,
~Nick Desaulniers
