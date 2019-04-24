Return-Path: <SRS0=L2S5=S2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8AF9C10F11
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 05:34:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8092E206BA
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 05:34:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729526AbfDXFeS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Apr 2019 01:34:18 -0400
Received: from mail-it1-f195.google.com ([209.85.166.195]:52581 "EHLO
        mail-it1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725919AbfDXFeS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Apr 2019 01:34:18 -0400
Received: by mail-it1-f195.google.com with SMTP id x132so4218393itf.2;
        Tue, 23 Apr 2019 22:34:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=bdru01AkYPwaXTH6ik0KxzmcN+kLTAFWhksk6mGVxcE=;
        b=OhxnTeNJfQKmcaodxAepMHE4xVyLhk5/usluSvS1werk2G8V9x3sVY1qEk8OTuyaOT
         oBt0ZeVb4a4PloMMMeop441S1Y6xOIlkDn0CWRIRC+1Dor8gCRRrmoCis7o6ZJWYHJ7E
         GAVibv3fa/bAY7W4jEXgQrNk+KgdPHjbFtxxgqRSNZhfWsRGg5vwIEG2W/IY/K2h27eG
         L3FfUz2RnEG/oAkMaXaGwJRvV9gFMa7UMr0msnm5x1nifqj2/uXP38TP8apbDCVygiPx
         Xus08WmQOhU8dNAv6bJQDJ4F89qGNy2BmPjn+Y+oRQiGNAbB3ySsuz9Pvj7/fgIN35+g
         j9VQ==
X-Gm-Message-State: APjAAAV2GJhvUSA5ST9wrCrTajmiMAvtTLpp/GAjVpYjUlbiC8Zk2k+e
        rJ65lp73JIbSu1CP6HLuB06qvzjeNMaihzVOGi5CVJ+B
X-Google-Smtp-Source: APXvYqwitqMQ59+E7f8gsZSpph0DWiSzXQUit8ltVnvnlEH30xld1mAN61EQ71gv/QUyIvZhjwHCzZIsisPTugqGIXY=
X-Received: by 2002:a02:c790:: with SMTP id n16mr20159814jao.102.1556084057312;
 Tue, 23 Apr 2019 22:34:17 -0700 (PDT)
MIME-Version: 1.0
References: <20190423081158.29859-1-tomeu.vizoso@collabora.com> <ed7c20b9-b435-5f40-55ab-97d6384749f1@collabora.com>
In-Reply-To: <ed7c20b9-b435-5f40-55ab-97d6384749f1@collabora.com>
From:   Tomeu Vizoso <tomeu.vizoso@collabora.com>
Date:   Wed, 24 Apr 2019 07:34:06 +0200
Message-ID: <CAAObsKBuaKtMDKuuwtYLALxx6tx82ioxbfncnVMrXVgB7dptHA@mail.gmail.com>
Subject: Re: [PATCH] PM / devfreq: Return -ENODEV from try_then_request_governor
To:     Enric Balletbo i Serra <enric.balletbo@collabora.com>
Cc:     open list <linux-kernel@vger.kernel.org>,
        Alyssa Rosenzweig <alyssa@rosenzweig.io>,
        MyungJoo Ham <myungjoo.ham@samsung.com>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>, linux-pm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 23 Apr 2019 at 11:56, Enric Balletbo i Serra
<enric.balletbo@collabora.com> wrote:
>
> Hi Tomeu,
>
> On 23/4/19 10:11, Tomeu Vizoso wrote:
> > Callers don't expect it to return NULL, but an error code.
> >
> > Fixes Oops such as the one below, when one tries to set a governor that
> > isn't available:
> >
> > Unable to handle kernel NULL pointer dereference at virtual address 00000018
> >
> > [<c0dcf718>] (governor_store) from [<c0539558>] (kernfs_fop_write+0x100/0x1e0)
> > [<c0539558>] (kernfs_fop_write) from [<c04b09b4>] (__vfs_write+0x2c/0x17c)
> > [<c04b09b4>] (__vfs_write) from [<c04b33fc>] (vfs_write+0xa4/0x184)
> > [<c04b33fc>] (vfs_write) from [<c04b361c>] (ksys_write+0x4c/0xac)
> > [<c04b361c>] (ksys_write) from [<c0301000>] (ret_fast_syscall+0x0/0x28)
> >
> > Signed-off-by: Tomeu Vizoso <tomeu.vizoso@collabora.com>
> > Fixes: 23c7b54ca1cd ("PM / devfreq: Fix devfreq_add_device() when drivers are built as modules.")
> > Reported-by: Alyssa Rosenzweig <alyssa@rosenzweig.io>
> > Cc: Enric Balletbo i Serra <enric.balletbo@collabora.com>
> > ---
>
> There is already a fix for that. The fix was initially sent in October [2] but
> unfortunately it got lost. I resend and now is queued [1]. Hopefully the Fixes
> tag will help to pick the fix to the proper kernel releases.

Actually, Steve Price sent a third patch for this same issue.

Glad to read that it's being merged.

Thanks,

Tomeu



> Thanks,
>  Enric
>
> [1]
> https://git.kernel.org/pub/scm/linux/kernel/git/mzx/devfreq.git/commit/?h=for-next&id=b53b0128052ffd687797d5f4deeb76327e7b5711
>
> [2] https://lkml.org/lkml/2018/10/16/744
>
> >  drivers/devfreq/devfreq.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/drivers/devfreq/devfreq.c b/drivers/devfreq/devfreq.c
> > index 0ae3de76833b..5539e9be718d 100644
> > --- a/drivers/devfreq/devfreq.c
> > +++ b/drivers/devfreq/devfreq.c
> > @@ -254,7 +254,7 @@ static struct devfreq_governor *try_then_request_governor(const char *name)
> >               /* Restore previous state before return */
> >               mutex_lock(&devfreq_list_lock);
> >               if (err)
> > -                     return NULL;
> > +                     return ERR_PTR(-ENODEV);
> >
> >               governor = find_devfreq_governor(name);
> >       }
> >
