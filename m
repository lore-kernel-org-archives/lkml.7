Return-Path: <SRS0=bMiL=T7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2CFF6C04AB6
	for <linux-kernel@archiver.kernel.org>; Fri, 31 May 2019 09:13:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0B4F42443D
	for <linux-kernel@archiver.kernel.org>; Fri, 31 May 2019 09:13:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727160AbfEaJNS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 31 May 2019 05:13:18 -0400
Received: from mail-lj1-f193.google.com ([209.85.208.193]:37626 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726233AbfEaJNR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 May 2019 05:13:17 -0400
Received: by mail-lj1-f193.google.com with SMTP id h19so8882970ljj.4
        for <linux-kernel@vger.kernel.org>; Fri, 31 May 2019 02:13:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=vS7g8P/NY7dhNfYhpibp7ySBNkV6CxXTbUCyow6hlKE=;
        b=FEctBwY+WhxwCRXglA+TAKQ5gqACEkl2pLYdNnDlagogYOE5abperwrPE9gq8eCt+a
         sBCbkWEIEZVyLzb3F5pEduefM3J6ZNK0wfjQuYFYeRLfEzBGF++tu6SRYFvvqSKm6P/9
         QoJ7ajfFJtcfPJElBcSo8qpjtXEmkjIlzrKaWTzUTKjfV7LSJwG+wTZP27XnD6xQVaVv
         LKp+8OCnNCt9OdC4VoRnASLXV8Mvz71bXST7rE4aRq5hgcXZEnQEvAm8KOij1vcBOFv/
         tM+MIDgvf0E3A5wLnP6nmP1VlNl7z7r+bJjZzQfP7eJqnIFPf/RLGv5tLu8fX4ZqPTAU
         XfpQ==
X-Gm-Message-State: APjAAAVBShK3SMp3VYDUr22AAxO4oLZIARJ3/IqJi8VMa4NeKPePmaDy
        NVvFei56bmtDnOJLwt8ilY/EDGLIJSn+PUb3xaCHU3CtuWU=
X-Google-Smtp-Source: APXvYqzDmSgwAxYiSHZDtl77YC64ZrWXBQnM+m64BL9AIETUQqlw2+6d7QSUlUGrbOV5Q41I4RirlX3zWXAUarEj208=
X-Received: by 2002:a2e:249:: with SMTP id 70mr4703468ljc.178.1559293995678;
 Fri, 31 May 2019 02:13:15 -0700 (PDT)
MIME-Version: 1.0
References: <20190531012649.31797-1-mcroce@redhat.com> <dbc00eaa-c6e9-45b2-7232-5af35fdea113@infradead.org>
In-Reply-To: <dbc00eaa-c6e9-45b2-7232-5af35fdea113@infradead.org>
From:   Matteo Croce <mcroce@redhat.com>
Date:   Fri, 31 May 2019 11:12:39 +0200
Message-ID: <CAGnkfhwJm0N2WvLv9o+DZeL9JjDsDp3-TB-G6iS_6mhTyzYRHQ@mail.gmail.com>
Subject: Re: [PATCH] firmware_loader: fix build without sysctl
To:     Randy Dunlap <rdunlap@infradead.org>
Cc:     Stephen Rothwell <sfr@canb.auug.org.au>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 31, 2019 at 4:15 AM Randy Dunlap <rdunlap@infradead.org> wrote:
>
> On 5/30/19 6:26 PM, Matteo Croce wrote:
> > firmware_config_table has references to the sysctl code which
> > triggers a build failure when CONFIG_PROC_SYSCTL is not set:
> >
> >     ld: drivers/base/firmware_loader/fallback_table.o:(.data+0x30): undefined reference to `sysctl_vals'
> >     ld: drivers/base/firmware_loader/fallback_table.o:(.data+0x38): undefined reference to `sysctl_vals'
> >     ld: drivers/base/firmware_loader/fallback_table.o:(.data+0x70): undefined reference to `sysctl_vals'
> >     ld: drivers/base/firmware_loader/fallback_table.o:(.data+0x78): undefined reference to `sysctl_vals'
> >
> > Put the firmware_config_table struct under #ifdef CONFIG_PROC_SYSCTL.
> >
> > Fixes: 6a33853c5773 ("proc/sysctl: add shared variables for range check")
> > Reported-by: Randy Dunlap <rdunlap@infradead.org>
> > Signed-off-by: Matteo Croce <mcroce@redhat.com>
>
> Works for me.
>
> Acked-by: Randy Dunlap <rdunlap@infradead.org> # build-tested
>
> Thanks.
>
> > ---
> >  drivers/base/firmware_loader/fallback_table.c | 4 ++++
> >  1 file changed, 4 insertions(+)
> >
> > diff --git a/drivers/base/firmware_loader/fallback_table.c b/drivers/base/firmware_loader/fallback_table.c
> > index 58d4a1263480..18d646777fb9 100644
> > --- a/drivers/base/firmware_loader/fallback_table.c
> > +++ b/drivers/base/firmware_loader/fallback_table.c
> > @@ -23,6 +23,8 @@ struct firmware_fallback_config fw_fallback_config = {
> >  };
> >  EXPORT_SYMBOL_GPL(fw_fallback_config);
> >
> > +#ifdef CONFIG_PROC_SYSCTL
> > +
> >  struct ctl_table firmware_config_table[] = {
> >       {
> >               .procname       = "force_sysfs_fallback",
> > @@ -45,3 +47,5 @@ struct ctl_table firmware_config_table[] = {
> >       { }
> >  };
> >  EXPORT_SYMBOL_GPL(firmware_config_table);
> > +
> > +#endif
> >
>
>
> --
> ~Randy

Hi,

please correct the Fixes tag if possible.
It seems that the hash of the offending commit now is d91bff3011cf

Regards,
-- 
Matteo Croce
per aspera ad upstream
