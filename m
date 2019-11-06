Return-Path: <SRS0=fWiu=Y6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.3 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 60805C5DF63
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Nov 2019 12:11:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2AD90214D8
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Nov 2019 12:11:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="fA5EbDNN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730172AbfKFMLJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 Nov 2019 07:11:09 -0500
Received: from mail-pg1-f195.google.com ([209.85.215.195]:37106 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727652AbfKFMLJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Nov 2019 07:11:09 -0500
Received: by mail-pg1-f195.google.com with SMTP id z24so12459225pgu.4
        for <linux-kernel@vger.kernel.org>; Wed, 06 Nov 2019 04:11:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=OEfw9cUz4TGuYkw6SKbOhoFYIK/OUoQLEjTHKdEArNo=;
        b=fA5EbDNNhUthKOfKfplHC/PC0ChmTlyF6fmMfBqXTprs8uRNto83kgWHVaS8OcRM4W
         PtnjGw4M/cfDVmAxqRXwpd9NczmkNfCR37ozIcvmzjr2X7cO2UFEL7KmJr+1+50w8OjU
         deNOf/rey23zka2vXis+c7yrfKPew7KFRjLXr7utYeN+7YLjLv3xfKMui7FXPmInxp/Q
         On2Dmvnc8TxwkGGjUYMsGTbXWJpqBe1KM6zzzWXxpNxOUDyLK+56AnnOV0rLPQxLnKQ9
         JbtS51kREKMexDTmZi4Ud4Dr9+BEtsSps39PGQA4C0wJ75PHunHRLAaUHKEGvanZURbg
         jlWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=OEfw9cUz4TGuYkw6SKbOhoFYIK/OUoQLEjTHKdEArNo=;
        b=VcovOOpiblXNR63J+YLjCI70pztD1HZVAP/ga/w7dywsuhY/Hfe21cg+8ZnmPIIJz/
         rK7BLK4zxgfra7tvhyIcGifnnoVPs/VkHpoHvwmsAw7g9aewtUEM0r/GkjsYBnAJxrZy
         Ch0Zlf/44Iehg0IyX0goB9AUCxmBou+Pg8ZJbwgSYeH0ROXQequIwSAMDQ2PUtkojdgO
         1DwLEV/i3OxBMAeXsn6/6Exsx6kKwVEGA6UxQW2EJQypfGIAQwmRi66sXS6HrT9IggxV
         xQowOPwPXKKKqsvgcAaZ70YbfJpph6hq2jmQHqYt4Im2fctBUfnR2CFWTDjPxbweJyob
         QFRw==
X-Gm-Message-State: APjAAAU+4rDntNZdeXyIkVdKp/4qv8TypQ1vOdI+yZYidJQiQZhyFQfO
        b4cmz2RNyU5mNlyBW8zQsbLT12QfThG2SklX1rTtoTOV
X-Google-Smtp-Source: APXvYqzNvoD7XYantgXwZkOZmcI65fkzmHQsoQLeCP54fkmsPfBgPqY9pqxrRXZplYktB1mgJjiBj6ZvU0+bmxy5IWI=
X-Received: by 2002:aa7:9ad0:: with SMTP id x16mr2953838pfp.51.1573042268452;
 Wed, 06 Nov 2019 04:11:08 -0800 (PST)
MIME-Version: 1.0
References: <00000000000042d60805933945b5@google.com> <20191105233652.21033-1-tranmanphong@gmail.com>
In-Reply-To: <20191105233652.21033-1-tranmanphong@gmail.com>
From:   Andrey Konovalov <andreyknvl@google.com>
Date:   Wed, 6 Nov 2019 13:10:56 +0100
Message-ID: <CAAeHK+zKShqnZ=R8KQvVjsfOkAGrWW5jbsXRUnuEY8k4XN3+Fw@mail.gmail.com>
Subject: Re: [PATCH] usb: appledisplay: fix use-after-free in bl_get_brightness
To:     Phong Tran <tranmanphong@gmail.com>
Cc:     syzbot+495dab1f175edc9c2f13@syzkaller.appspotmail.com, 2pi@mok.nu,
        alex.theissen@me.com,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        LKML <linux-kernel@vger.kernel.org>,
        USB list <linux-usb@vger.kernel.org>,
        syzkaller-bugs <syzkaller-bugs@googlegroups.com>,
        linux-kernel-mentees@lists.linuxfoundation.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 6, 2019 at 12:37 AM Phong Tran <tranmanphong@gmail.com> wrote:
>
> In context of USB disconnect, the delaywork trigger and calling
> appledisplay_bl_get_brightness() and the msgdata was freed.
>
> add the checking return value of usb_control_msg() and only update the
> data while the retval is valid.
>
> Reported-by: syzbot+495dab1f175edc9c2f13@syzkaller.appspotmail.com
> Reported-and-tested-by:
> syzbot+495dab1f175edc9c2f13@syzkaller.appspotmail.com
>
> https://groups.google.com/d/msg/syzkaller-bugs/dRmkh2UYusY/l2a6Mg3FAQAJ

Hi Phong,

FYI, when testing patches with the usb-fuzzer instance, you need to
provide the same kernel commit id as the one where the bug was
triggered. Please see here for details:

>
> Signed-off-by: Phong Tran <tranmanphong@gmail.com>
> ---
>  drivers/usb/misc/appledisplay.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/usb/misc/appledisplay.c b/drivers/usb/misc/appledisplay.c
> index ac92725458b5..3e3dfa5a3954 100644
> --- a/drivers/usb/misc/appledisplay.c
> +++ b/drivers/usb/misc/appledisplay.c
> @@ -164,7 +164,8 @@ static int appledisplay_bl_get_brightness(struct backlight_device *bd)
>                 0,
>                 pdata->msgdata, 2,
>                 ACD_USB_TIMEOUT);
> -       brightness = pdata->msgdata[1];
> +       if (retval >= 0)
> +               brightness = pdata->msgdata[1];
>         mutex_unlock(&pdata->sysfslock);
>
>         if (retval < 0)
> --
> 2.20.1
>
