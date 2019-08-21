Return-Path: <SRS0=xaRW=WR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D8EDDC3A59E
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Aug 2019 15:07:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A9C9520870
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Aug 2019 15:07:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="bKoPdm41"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729774AbfHUPHy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 21 Aug 2019 11:07:54 -0400
Received: from mail-vk1-f196.google.com ([209.85.221.196]:46234 "EHLO
        mail-vk1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728756AbfHUPHy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Aug 2019 11:07:54 -0400
Received: by mail-vk1-f196.google.com with SMTP id b64so618741vke.13
        for <linux-kernel@vger.kernel.org>; Wed, 21 Aug 2019 08:07:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Yoz2RIEoekI97TGDwNDb2cYuY4j2KA9YLKzO29oxa68=;
        b=bKoPdm41C+rt86wgtJEZwgf4WpRLlu7uiVMYEdZBNxIo2ki8MFlGUKMbhVAMe3ieZ1
         SNjpNYLICJ2KbpkDWAm2FWLMqMa+zirJcbb5DwZEqVav4uuxU75qfxkKsNGI+232Fz9s
         W+Nj5uoncJ1iZrtPOlwkzEsBmJgZxnVmGNxO6gNjBFQA1uXHa3TNhZ0/UlEfnrCa8016
         KyX4cHo9xAUIC5oOeui0GM4OhIt21o6BHDroDDUjZYT8CweLAeNBjndyIgwf2smXi16G
         D/EX3MYhAJHrNkw3JEnJ2k7WXEckjsLY9fzCgQJoB7LTSaNvFKwoYvXOEaSEO4pp1IZ5
         YqXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Yoz2RIEoekI97TGDwNDb2cYuY4j2KA9YLKzO29oxa68=;
        b=FD5+62ilXLTqs/MDru4G5lHifvQ//cXwsRxiW7Leo+lPiCPh8J+RP7L66kATOfMmUN
         6ZjBVnWV2jiCRfhO7OKsqmoUFJrBS3ETmAfHX+TCzY8KJ7Q16lBkJCW+4AbgRpBZRKhn
         JwZVIJKaYxml5wkyP5YKkZdHvm5Nkb5YXm7sp7Qz2Gl6aFm1q2xcD59FLUXLHjA0sRme
         vJagxmC63i5Wpy1TXhzPZUPdC7icYe9OM6s3yo9Dx8RYPUacN1GIRC/BqBlRMN/gq/6T
         BVEk6M6e6cJIrKzF6yK6GDHNvxul27ANxGJRT3pMf0Fi0aMT39Fqug4BRWjshuNj3adi
         hcIg==
X-Gm-Message-State: APjAAAXY59C5/K+x/S0o5c/8x1i70xIPGvC5LIJsw9vcQij6ClMty7BM
        kOeT/8ihzc+WqdDM7rlGsRrVjB/1mNAFTrP/GFOHgA==
X-Google-Smtp-Source: APXvYqxIjlgM9kgim++G2hEIL2HAfU2N3YDY1R7j00eUtzDimP4T6y7m2Y4h8FTVzBRX/pvG3mUHIeFRN6musNiwflc=
X-Received: by 2002:ac5:c4f7:: with SMTP id b23mr5297907vkl.17.1566400073181;
 Wed, 21 Aug 2019 08:07:53 -0700 (PDT)
MIME-Version: 1.0
References: <1558252637-10556-1-git-send-email-chaotian.jing@mediatek.com> <1559438591.25015.0.camel@mhfsdcap03>
In-Reply-To: <1559438591.25015.0.camel@mhfsdcap03>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Wed, 21 Aug 2019 17:07:17 +0200
Message-ID: <CAPDyKFofoJKqnchJT-Bty9MMLDviiBWupf+MPmMtv+mRemVXLw@mail.gmail.com>
Subject: Re: fix controller busy issue and add 24bits segment support
To:     Chaotian Jing <chaotian.jing@mediatek.com>
Cc:     srv_heupstream <srv_heupstream@mediatek.com>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-mediatek@lists.infradead.org,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2 Jun 2019 at 03:23, Chaotian Jing <chaotian.jing@mediatek.com> wrote:
>
> Hi Ulf,
>
> Gentle ping for this patch.

For some reason these patches didn't reach the patchtracker, hence I
have just not seen them.

Could you please re-post this so we can get this merged?

Kind regards
Uffe

>
> On Sun, 2019-05-19 at 15:57 +0800, Chaotian Jing wrote:
> > the below 2 patches fix controller busy issue when plug out SD card
> > and add 24bits segment size support.
> >
> > Chaotian Jing (2):
> >   mmc: mediatek: fix controller busy when plug out SD
> >   mmc: mediatek: support 24bits segment size
> >
> >  drivers/mmc/host/mtk-sd.c | 24 ++++++++++++++++++------
> >  1 file changed, 18 insertions(+), 6 deletions(-)
> >
>
>
