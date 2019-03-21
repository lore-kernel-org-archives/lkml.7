Return-Path: <SRS0=/BZh=RY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 53BB2C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Mar 2019 10:51:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 17E7A218A5
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Mar 2019 10:51:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="A6RI09ay"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727922AbfCUKvz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Mar 2019 06:51:55 -0400
Received: from mail-yw1-f65.google.com ([209.85.161.65]:37587 "EHLO
        mail-yw1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727867AbfCUKvz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Mar 2019 06:51:55 -0400
Received: by mail-yw1-f65.google.com with SMTP id w66so4414529ywd.4
        for <linux-kernel@vger.kernel.org>; Thu, 21 Mar 2019 03:51:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=RfzfzxUXKGrc6yMTco9MzK9M4vYWklrTL94YRCug4Ms=;
        b=A6RI09ayIG4EbSJh2oEdo32z7EzMbrqR9+Kqk0gWTLbYBLR/PrNgndQRf++WXIVsFd
         o1Yi5jIPTaCEbkNdgBAnfcFylaAu/MVPM2THWiaWX5c6XURxMTEwkQEg+x3NU7FG//dU
         w9bemDTCR1xulq+2KWkU+/swpiV7xvszM93Nt5+L0IniSAKr5wM8d25Jt95IduoY7Zfl
         bftlwGJ/TAAVfTmpFfPeBd8E52SiDbvbeRl0jterIOJrvaWAygvhuyjoDHpgoN7OKcMh
         XFj9R76rM2NvkykFz/fZvwXKSayHAJagpbba5Ysxnf9se0ASnfB9vXl2mEeQkLk/ACna
         E3wg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=RfzfzxUXKGrc6yMTco9MzK9M4vYWklrTL94YRCug4Ms=;
        b=F7bFmHRFrb8VUE2tQEUmUpNp55hf2w1NJIBslQCpam5A485ODfuK775BRnHNpocoD4
         jQZnJegXzplmwCNpVmDqQjz6U6oLpI7FKpGZrxNj5MEn17ZCTWDOTiOaNaFpaJl1WHcr
         jn5raizlCtkVJUDOa4d5lbg/7du/NVTPjPca6y2jsb9r+3wo4KBLvM4s7rsYK2WCFV2O
         ZxTq+eYst7YODUtuLMqB67OH5GFT6FcGerUkc0jS9ZgKUQtwR2dmlTEFlvGuCXvoHnMR
         k0VsitCpYmasE3q9STBk8VBXIp4hQMEwUNWc7+EhCVV6v1SQCeAHMkAdUC09uO8TfybR
         cfhw==
X-Gm-Message-State: APjAAAWQglBZtKfRW8RbLrcgADKw5U7rEjYmB2YM/TpITVOb7FmRzaR1
        qwmFjBNAQltdYCuPdLReTCTEF+pOl8pHQmGVVtY=
X-Google-Smtp-Source: APXvYqwChxmfvicljUL7XBwBn2/4EWUhvBUR17pmu7Ba77h1ZfbIIh9+JlzhxXl3WPAT8sd20Xc7d4+Xqtdc12H/w7E=
X-Received: by 2002:a25:2184:: with SMTP id h126mr2322808ybh.6.1553165514496;
 Thu, 21 Mar 2019 03:51:54 -0700 (PDT)
MIME-Version: 1.0
References: <20190319020519.15209-1-tsu.yubo@gmail.com> <CAKq8=3K26Vbg4Vk4+C4F6vjB5mv8SiSxe7mBxLrtph3MHGdi+A@mail.gmail.com>
 <20190321095649.GA2836@kroah.com>
In-Reply-To: <20190321095649.GA2836@kroah.com>
From:   Bo YU <tsu.yubo@gmail.com>
Date:   Thu, 21 Mar 2019 18:51:43 +0800
Message-ID: <CAKq8=3+kGhmv9mKFg=E_g+5z7aQURUmHDpA-fH7rSL1-r+JeKQ@mail.gmail.com>
Subject: Re: [PATCH] misc/fastrpc: add checked value for dma_set_mask
To:     Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        open list <linux-kernel@vger.kernel.org>,
        =?UTF-8?B?5LqO5rOi?= <yuzibode@126.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 21, 2019 at 5:56 PM Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> On Thu, Mar 21, 2019 at 05:31:51PM +0800, Bo YU wrote:
> > On Tue, Mar 19, 2019 at 10:05 AM Bo YU <tsu.yubo@gmail.com> wrote:
> > >
> > > There be should check return value from dma_set_mask to throw some infos
> > > if fail to set dma mask.
> > >
> > > Detected by CoverityScan, CID# 1443983:  Error handling issues (CHECKED_RETURN)
> > >
> > > Fixes:f6f9279f2bf0 (misc: fastrpc: Add Qualcomm fastrpc basic driver model)
> > > Signed-off-by: Bo YU <tsu.yubo@gmail.com>
> > > ---
> > >  drivers/misc/fastrpc.c | 7 ++++++-
> > >  1 file changed, 6 insertions(+), 1 deletion(-)
> > >
> > > diff --git a/drivers/misc/fastrpc.c b/drivers/misc/fastrpc.c
> > > index 39f832d27288..36d0d5c9cfba 100644
> > > --- a/drivers/misc/fastrpc.c
> > > +++ b/drivers/misc/fastrpc.c
> > > @@ -1184,6 +1184,7 @@ static int fastrpc_cb_probe(struct platform_device *pdev)
> > >         struct fastrpc_session_ctx *sess;
> > >         struct device *dev = &pdev->dev;
> > >         int i, sessions = 0;
> > > +       int rc;
> > >
> > >         cctx = dev_get_drvdata(dev->parent);
> > >         if (!cctx)
> > > @@ -1213,7 +1214,11 @@ static int fastrpc_cb_probe(struct platform_device *pdev)
> > >         }
> > >         cctx->sesscount++;
> > >         spin_unlock(&cctx->lock);
> > > -       dma_set_mask(dev, DMA_BIT_MASK(32));
> > > +       rc = dma_set_mask(dev, DMA_BIT_MASK(32));
> > > +       if (rc) {
> > > +               dev_err(dev, "32-bit DMA enable failed\n");
> > > +               return rc;
> > > +       }
> > >
> > Ping?
> > Do me need resend it?
>
> 2 days?  Please give us time to catch up on patches, right after the
> merge window closed.  This isn't a big deal, we have much higher
> priority patches to review.  It will be gotten to eventually :)
Ok, thank you. I am not sure the trival patch is ok so disturb you :)
>
> thanks,
>
> greg k-h
