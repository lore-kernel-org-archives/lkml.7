Return-Path: <SRS0=vI2Y=WC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-19.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A279CC433FF
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Aug 2019 22:04:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 63FEB20651
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Aug 2019 22:04:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Gq51WFCg"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726982AbfHFWEj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 6 Aug 2019 18:04:39 -0400
Received: from mail-oi1-f194.google.com ([209.85.167.194]:45214 "EHLO
        mail-oi1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726133AbfHFWEj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Aug 2019 18:04:39 -0400
Received: by mail-oi1-f194.google.com with SMTP id m206so68949567oib.12
        for <linux-kernel@vger.kernel.org>; Tue, 06 Aug 2019 15:04:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=QfnP4WFLi3j9Pcefb2omV5XrdW/cAbsj/88MkL4fbvI=;
        b=Gq51WFCgr1zdsFkg5BQRpfVFNcqwrXt/ByM2qpZmeimqpO9xdv5amX6U9IY+GySEbs
         MW9UFDu+wuO0qwiLcw5AezTeq7h+VLNv8b5+LbA6ah+w0ZHGGwJQ9WzabRJ356Vtp9rZ
         xijUotEAFl5yO3Q2wbmCiP2UycrvTZVkEbjiG1pJrgkzA3ISkkoZ73f/08M9ZgLIJ+qX
         7YTDOUphK/A4GisdJxfftSNZEA9tT0YrdJ20eY2EViMjxF+/iegHSa0mmgn7SYzSc9Dk
         wSEfADHPl6hQqvVOX5MkU+S0MdyfKy9IfPUAJcNEePMpK6/NR4D6g9wdaTaNiV0Mm7oq
         QDNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=QfnP4WFLi3j9Pcefb2omV5XrdW/cAbsj/88MkL4fbvI=;
        b=ePK7TK2A5maoiCKD5bSt54bDh2PG4J+a2Ea38GNsDmlfCuW6cd+oNh2sThZAabY0O/
         y8D2pAPoIjlcNsf0IiMLXc8y43E1XRlLPcIWcd93tqATN2VMIx8zLoUjbituBKiHWxw4
         f4hrzKPZm/llw/xm74Fd83FVJYEo2H0CzIFzYBc3xcTDJ6p7z5e/ZYIs7pZxPMBiipKF
         ldDKgabZzyPKeOth1h5RTq2X8XbSHKyZ9vn9xPeoULRnH/ahCIKZVnz/2xuD8uDidjZ9
         Qn/l4kE0c7CGgXt6MzIrBFueyTVPcfK/2cSa4umG3f2FQ1nGr5/hQGgIgFn1J76iTWw5
         PWJQ==
X-Gm-Message-State: APjAAAVi2ITfD/DjjDhzfWcWSWbSHaRXtpayFVDWDebhzYqgSHjAAMDD
        gCBtEilt4BsebAwIzDYoZv3Uq1fYmw6vCv1lz8ulcA==
X-Google-Smtp-Source: APXvYqxotQJSiWzEumcCLEIqBNRnOr8vATGsyoLi96yVYHfCMRt5aTAq4Tb9x3MuVSGks46FUgah69A375EX3l1ZKwM=
X-Received: by 2002:aca:1803:: with SMTP id h3mr2930076oih.24.1565129078021;
 Tue, 06 Aug 2019 15:04:38 -0700 (PDT)
MIME-Version: 1.0
References: <20190806192654.138605-1-saravanak@google.com> <20190806192654.138605-2-saravanak@google.com>
 <CAL_Jsq+BwHSj1XUNp_eY362XnNoOqVTNHqAkvnbgece8ZQE3Qw@mail.gmail.com>
In-Reply-To: <CAL_Jsq+BwHSj1XUNp_eY362XnNoOqVTNHqAkvnbgece8ZQE3Qw@mail.gmail.com>
From:   Saravana Kannan <saravanak@google.com>
Date:   Tue, 6 Aug 2019 15:04:01 -0700
Message-ID: <CAGETcx8+EETv6nSu+BEBStKvbmBs+tZZgo1u_Pw8SNu+7Urq1Q@mail.gmail.com>
Subject: Re: [PATCH 2/2] of/platform: Disable generic device linking code for PowerPC
To:     Rob Herring <robh+dt@kernel.org>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Frank Rowand <frowand.list@gmail.com>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Android Kernel Team <kernel-team@android.com>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 6, 2019 at 2:27 PM Rob Herring <robh+dt@kernel.org> wrote:
>
> On Tue, Aug 6, 2019 at 1:27 PM Saravana Kannan <saravanak@google.com> wrote:
> >
> > PowerPC platforms don't use the generic of/platform code to populate the
> > devices from DT.
>
> Yes, they do.

No they don't. My wording could be better, but they don't use
of_platform_default_populate_init()
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/drivers/of/platform.c#n511

>
> > Therefore the generic device linking code is never used
> > in PowerPC.  Compile it out to avoid warning about unused functions.
>
> I'd prefer this get disabled on PPC using 'if (IS_ENABLED(CONFIG_PPC))
> return' rather than #ifdefs.

I'm just moving the existing ifndef some lines above. I don't want to
go change existing #ifndef in this patch. Maybe that should be a
separate patch series that goes and fixes all such code in drivers/of/
or driver/

-Saravana

>
> >
> > If a specific PowerPC platform wants to use this code in the future,
> > bringing this back for PowerPC would be trivial. We'll just need to export
> > of_link_to_suppliers() and then let the machine specific files do the
> > linking as they populate the devices from DT.
> >
> > Signed-off-by: Saravana Kannan <saravanak@google.com>
> > ---
> >  drivers/of/platform.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/drivers/of/platform.c b/drivers/of/platform.c
> > index f68de5c4aeff..a2a4e4b79d43 100644
> > --- a/drivers/of/platform.c
> > +++ b/drivers/of/platform.c
> > @@ -506,6 +506,7 @@ int of_platform_default_populate(struct device_node *root,
> >  }
> >  EXPORT_SYMBOL_GPL(of_platform_default_populate);
> >
> > +#ifndef CONFIG_PPC
> >  static bool of_link_is_valid(struct device_node *con, struct device_node *sup)
> >  {
> >         of_node_get(sup);
> > @@ -683,7 +684,6 @@ static int of_link_to_suppliers(struct device *dev)
> >         return __of_link_to_suppliers(dev, dev->of_node);
> >  }
> >
> > -#ifndef CONFIG_PPC
> >  static const struct of_device_id reserved_mem_matches[] = {
> >         { .compatible = "qcom,rmtfs-mem" },
> >         { .compatible = "qcom,cmd-db" },
> > --
> > 2.22.0.770.g0f2c4a37fd-goog
> >
