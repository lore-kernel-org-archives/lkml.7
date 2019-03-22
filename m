Return-Path: <SRS0=oArh=RZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A3A49C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 15:35:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5C60720850
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 15:35:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kudzu-us.20150623.gappssmtp.com header.i=@kudzu-us.20150623.gappssmtp.com header.b="TDmukoFh"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727564AbfCVPfK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Mar 2019 11:35:10 -0400
Received: from mail-io1-f67.google.com ([209.85.166.67]:33529 "EHLO
        mail-io1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727544AbfCVPfI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Mar 2019 11:35:08 -0400
Received: by mail-io1-f67.google.com with SMTP id b6so2069831iog.0
        for <linux-kernel@vger.kernel.org>; Fri, 22 Mar 2019 08:35:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kudzu-us.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=dBlRwOtT+B6SwA8/0ZaIie4/T5RCnzzJQUJD3sIwcfE=;
        b=TDmukoFhAME8d7N/+HKcKr4Qk3wDRPiLmGzVc0kgBxKjDSMONYTM0rNKhWsWUzfsg8
         FMoIOXg+kENmSsrxq1QxkRsuVdxbQ50d054MWx0Vi5zIhKqor6tp83xZsTALmV/Ujh9P
         46ZoMi/7RReIwaOVVPpDGNHbXSPq1ohmIoM1QrEWifZpxNmdYaK7IsHwOqbOq8rd5f78
         bdiiaZtJ4U7z9T7naciH/6uNpBvdnr9upj4AzVyOAyF9j6o78fCvWv7QS2yqAqVPQoXe
         AyhZR4s0/6ujY6ew3imEMCMeduEApd4EETWV9Twbp5Z8xCThXaIaCKYoFAnpfhb2DfMB
         BChg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=dBlRwOtT+B6SwA8/0ZaIie4/T5RCnzzJQUJD3sIwcfE=;
        b=e9CNetYmBu2CARX6jFaK1YoeQwJI2ktuz9M6Cy09Z9Pdn7/5b78RqrnD2bqUelPLWX
         52IYMuUZ33+tF1OvVV8CV9Pv1mFgEEpIUdOIsUWXaKWly+GyaytqF1040fJ7YLndHsB8
         ZcUYadx8stG18I9ykzSbxUOMujisMN6+S84nGFKU6rg7BmiZ9Oa900crd8IGX7RunI19
         we2gu9Ey+D/Px/4jnBm4UO9IG5G9vcCX7lmyQ6YOrZkPSIr0n2ALnFkDjtMAz5O8EXKB
         7Tuvv3QmPSrk05uYQxay4NhK/SSRRLS/dggK5Oug5j87nFPUowdKPnIx6LqTn8UeZVup
         r+Ww==
X-Gm-Message-State: APjAAAVsEztZsOBh24z9d/ztE/n59+19s3MMfKBYeP6FlmZGDijLiv7Z
        6D+sIu/ysbiamdMq31sS72CROFsiNfdZRSc1+kUXLA==
X-Google-Smtp-Source: APXvYqw2EI0rgOKrlVJIfQ1gyciawoYaoREpRrDm7kkE3Bg5qUSqsCz5i9wohRwYS807Em74D2F+NdkC6nmmgE8KOWI=
X-Received: by 2002:a6b:b505:: with SMTP id e5mr6558483iof.277.1553268907528;
 Fri, 22 Mar 2019 08:35:07 -0700 (PDT)
MIME-Version: 1.0
References: <20190321075818.24f9703a@canb.auug.org.au> <8a8ce003-c151-d04b-3ac9-8823a6c8ff7b@deltatee.com>
 <CAPoiz9x9aWMzV3K-UhBz52AXdVpDbCQnLTeM7=nt5tAFL2RPBQ@mail.gmail.com> <20190322072829.77e6c245@canb.auug.org.au>
In-Reply-To: <20190322072829.77e6c245@canb.auug.org.au>
From:   Jon Mason <jdmason@kudzu.us>
Date:   Fri, 22 Mar 2019 11:34:56 -0400
Message-ID: <CAPoiz9zyT8GYo+DrGgCNP8PhHn-oTyRyd6+V4cydGgkGyF3Bww@mail.gmail.com>
Subject: Re: linux-next: Fixes tag needs some work in the ntb tree
To:     Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     Logan Gunthorpe <logang@deltatee.com>,
        NTB Mailing List <linux-ntb@googlegroups.com>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 21, 2019 at 4:28 PM Stephen Rothwell <sfr@canb.auug.org.au> wrote:
>
> Hi Jon,
>
> On Thu, 21 Mar 2019 15:53:47 -0400 Jon Mason <jdmason@kudzu.us> wrote:
> >
> > Is there an existing set of tools/scripts I should run to prevent
> > things like this from happening?
>
> I have attached the script I run over all new commits submitted for
> linux-next.

Fantastic!  I'll add a variation of this to my git tree and hopefully
prevent any future issues.

Thanks,
Jon

>
> --
> Cheers,
> Stephen Rothwell
