Return-Path: <SRS0=CMjL=VD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6094CC5B57D
	for <linux-kernel@archiver.kernel.org>; Sat,  6 Jul 2019 01:29:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2695E21670
	for <linux-kernel@archiver.kernel.org>; Sat,  6 Jul 2019 01:29:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XHBVhXF2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726911AbfGFB3x (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 5 Jul 2019 21:29:53 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:36690 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725878AbfGFB3x (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Jul 2019 21:29:53 -0400
Received: by mail-pg1-f195.google.com with SMTP id l21so959634pgm.3;
        Fri, 05 Jul 2019 18:29:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=x5jjwLY7dcGw5169QC417LalHnYGcUOiwki3nVFs4lw=;
        b=XHBVhXF2h1GwnWjBNmXZjiGTl39trxTsI4dOK3oflYgHM9klJyOOhq1bsOwyGzmxTL
         wnkY6igycborjm1aIv4bmPQGKlz7X0yfSctqODIChRTanMSQqZ/mDmb2n+ZRIZNKDZjO
         AiubDbCZn358CTccuM+DvkegkMCRMiwa/lm79HevI0fTf8QWcQB/cqz4S9n5IanGwFOD
         7FmAxfdWh2eQ9c4EwjKj5FraGvU6b/1aNxw3+iDR+7T/D7s4uOIDGFLcH2xIFxl2wz+U
         MaDEfV1HTNJys9G3KMDs+hrRNuBGf84BMZ19NI1CZ17kJfi7VoB6pt1CL2rxz6jIfGeI
         JogA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=x5jjwLY7dcGw5169QC417LalHnYGcUOiwki3nVFs4lw=;
        b=RFC2lFhp9hotiX620V+XJ1tAWM3p8veugXYElKdkcIDJ4JHHAH6T1qIJx4RluK2R8a
         yRVrpMu6yScclXuBAry5lqPh2266ZUUmUwGS1VacnBh1/RlVRIH8JMbC6GIwogzIvfQl
         vhbZ4c5xaCtXjxV388+nceQUVWGchHQFwjBacovcDbIxbFwfXdraX1DCDr4KZ53u071Q
         jT0UDB2/mNXKV+Wsis6EJdp0R5YDYUJvXFM+sqLLutPIxjoJ0SP8zp3VT7CrJkWssBU2
         KCv6Q4/QZ/vKH5y0AhoAxr/v+Xdp8Iceeiamuf0a7uHR07xszqgj4IchOgcPA859L4FG
         l3yw==
X-Gm-Message-State: APjAAAVJEM3Hvx2OqqIXcthBbtjeB03d4iHMaNtDbwyeVA5eXD58SnPX
        7Zu39hXeC4dhvPli62XI+R4Zls9fr8RBaBQQOdElX0Lg+aINpA==
X-Google-Smtp-Source: APXvYqwj73I7bj75wjiG+TfYW3IxNuib3qU9H3/SUmdUO/Gb/qvcCdfSkA9GO3qXXsfr+7xVrb4xP4I4FW4xxbUvMZg=
X-Received: by 2002:a17:90a:eb08:: with SMTP id j8mr9147386pjz.72.1562376592474;
 Fri, 05 Jul 2019 18:29:52 -0700 (PDT)
MIME-Version: 1.0
References: <20190704153529.9429-3-ryan5544@gmail.com> <Pine.LNX.4.44L0.1907051504310.1606-100000@iolanthe.rowland.org>
In-Reply-To: <Pine.LNX.4.44L0.1907051504310.1606-100000@iolanthe.rowland.org>
From:   Ryan Kennedy <ryan5544@gmail.com>
Date:   Fri, 5 Jul 2019 21:29:41 -0400
Message-ID: <CAJRN7XOzk03s6k+EpLKxE6g-7-EeSZ9JxMF9Jphe24vXHktTKQ@mail.gmail.com>
Subject: Re: [PATCH 2/2] usb: pci-quirks: Minor cleanup for AMD PLL quirk
To:     Alan Stern <stern@rowland.harvard.edu>
Cc:     Greg KH <gregkh@linuxfoundation.org>, mathias.nyman@intel.com,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 5, 2019 at 3:10 PM Alan Stern <stern@rowland.harvard.edu> wrote:
>
> On Thu, 4 Jul 2019, Ryan Kennedy wrote:
>
> > usb_amd_find_chipset_info() is used for chipset detection for
> > several quirks. It is strange that its return value indicates
> > the need for the PLL quirk, which means it is often ignored.
> > This patch adds a function specifically for checking the PLL
> > quirk like the other ones. Additionally, rename probe_result to
> > something more appropriate.
> >
> > Signed-off-by: Ryan Kennedy <ryan5544@gmail.com>
>
> > @@ -322,6 +317,13 @@ bool usb_amd_prefetch_quirk(void)
> >  }
> >  EXPORT_SYMBOL_GPL(usb_amd_prefetch_quirk);
> >
> > +bool usb_amd_quirk_pll_check(void)
> > +{
> > +     usb_amd_find_chipset_info();
> > +     return amd_chipset.need_pll_quirk;
> > +}
> > +EXPORT_SYMBOL_GPL(usb_amd_quirk_pll_check);
>
> I really don't see the point of separating out all but one line into a
> different function.  You might as well just rename
> usb_amd_find_chipset_info to usb_amd_quirk_pll_check (along with the
> other code adjustments) and be done with it.

I did this for consistency with the others:

usb_amd_prefetch_quirk()
usb_amd_hang_symptom_quirk()
usb_hcd_amd_remote_wakeup_quirk()

They all need to ensure the chipset information exists then decide if
the particular quirk should be applied to the chipset.

Ryan

>
> However, in the end I don't care if you still want to do this.  Either
> way:
>
> Acked-by: Alan Stern <stern@rowland.harvard.edu>
>
> Alan Stern
>
