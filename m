Return-Path: <SRS0=uTOJ=ST=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 979F8C10F12
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Apr 2019 09:00:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6F5F720693
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Apr 2019 09:00:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731450AbfDQJAg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Apr 2019 05:00:36 -0400
Received: from mail-ot1-f67.google.com ([209.85.210.67]:39160 "EHLO
        mail-ot1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726237AbfDQJAf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Apr 2019 05:00:35 -0400
Received: by mail-ot1-f67.google.com with SMTP id f10so20041973otb.6
        for <linux-kernel@vger.kernel.org>; Wed, 17 Apr 2019 02:00:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=IVXQ9lQyi2Q5wZjTisjUyZ0XWSaOWQ+YMO9bua4jwlY=;
        b=cd/Zr4PtIrLfMwAjbogs+4M+nMfxEvVqGL0gD4bNoXsG1ruZ+1km1++iMT6LYC/1Xi
         P+ZiSEEU/oRsgTz7Gg9xzNkE/HHxH+8xACKidzU1E3SVfR6OVkZaA/mKAfjYximqVSrz
         f2AG611RuxgpIhzaMOhR2kBK+7wgw/7+W1QOmexXOD3XNrr29GLlyz5+akE/VmWcJ+jf
         FUo5VDSpKZ8z+RJQ1wdgd9jZG8YYTlFdp7kfVytIslK7sE6A/eHyyFu+wXDGEs/FcLSP
         uEq/IzD4SWCODdXxBia1uTYxT9olAq2QB5IWNzAaYaGoNjIva2vuqlYKWF4RxA9Np+El
         IGBw==
X-Gm-Message-State: APjAAAVOA01coy2pFjXcwVCoM/Zp77F9FzQ70eM6mMnMDkeSpLE+pyIV
        HSnyrJmp/B4BuO4s1rPbBGVfcsIl/7ZOUulH/xYS3g==
X-Google-Smtp-Source: APXvYqxsTB5Pp6kOIv07dQS/TFykmrqTuxamMMOUJKhazGjniw4D901zY6sjI/2gTADp7RBilQXKya0NIaq4Jvsh2K0=
X-Received: by 2002:a9d:6941:: with SMTP id p1mr52991357oto.64.1555491634828;
 Wed, 17 Apr 2019 02:00:34 -0700 (PDT)
MIME-Version: 1.0
References: <20190417084833.7401-1-mlichvar@redhat.com>
In-Reply-To: <20190417084833.7401-1-mlichvar@redhat.com>
From:   Ondrej Mosnacek <omosnace@redhat.com>
Date:   Wed, 17 Apr 2019 11:00:23 +0200
Message-ID: <CAFqZXNu_pc1BEGZJb=3Ez58uN+BfoECpSm2yVqv1MMx7iTLfRw@mail.gmail.com>
Subject: Re: [PATCH] ntp: Allow TAI-UTC offset to be set to zero
To:     Miroslav Lichvar <mlichvar@redhat.com>
Cc:     Linux kernel mailing list <linux-kernel@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        John Stultz <john.stultz@linaro.org>,
        Richard Cochran <richardcochran@gmail.com>,
        Prarit Bhargava <prarit@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 17, 2019 at 10:48 AM Miroslav Lichvar <mlichvar@redhat.com> wrote:
> The ADJ_TAI adjtimex mode sets the TAI-UTC offset of the system clock.
> It is typically set by NTP/PTP implementations and it is automatically
> updated by the kernel on leap seconds. The initial value is zero (which
> applications may interpret as unknown), but this value cannot be set by
> adjtimex. This limitation seems to go back to the original "nanokernel"
> implementation by David Mills.
>
> Change the ADJ_TAI check to accept zero as a valid TAI-UTC offset in
> order to allow setting it back to the initial value.
>
> Cc: Thomas Gleixner <tglx@linutronix.de>
> Cc: John Stultz <john.stultz@linaro.org>
> Cc: Richard Cochran <richardcochran@gmail.com>
> Cc: Prarit Bhargava <prarit@redhat.com>
> Suggested-by: Ondrej Mosnacek <omosnace@redhat.com>
> Signed-off-by: Miroslav Lichvar <mlichvar@redhat.com>

Thanks for sending the patch! Maybe you (or the committer) could
consider adding:

Fixes: 153b5d054ac2 ("ntp: support for TAI")

so that it gets to the stable kernels as well.

> ---
>  kernel/time/ntp.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/kernel/time/ntp.c b/kernel/time/ntp.c
> index 92a90014a925..f43d47c8c3b6 100644
> --- a/kernel/time/ntp.c
> +++ b/kernel/time/ntp.c
> @@ -690,7 +690,7 @@ static inline void process_adjtimex_modes(const struct __kernel_timex *txc,
>                 time_constant = max(time_constant, 0l);
>         }
>
> -       if (txc->modes & ADJ_TAI && txc->constant > 0)
> +       if (txc->modes & ADJ_TAI && txc->constant >= 0)
>                 *time_tai = txc->constant;
>
>         if (txc->modes & ADJ_OFFSET)
> --
> 2.17.2

-- 
Ondrej Mosnacek <omosnace at redhat dot com>
Software Engineer, Security Technologies
Red Hat, Inc.
