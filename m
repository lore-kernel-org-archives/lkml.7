Return-Path: <SRS0=IBEs=VB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6F30EC0650E
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Jul 2019 06:47:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3FE98216E3
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Jul 2019 06:47:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dsSZbNRQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727287AbfGDGrF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Jul 2019 02:47:05 -0400
Received: from mail-ua1-f66.google.com ([209.85.222.66]:43073 "EHLO
        mail-ua1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725879AbfGDGrF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Jul 2019 02:47:05 -0400
Received: by mail-ua1-f66.google.com with SMTP id o2so770123uae.10
        for <linux-kernel@vger.kernel.org>; Wed, 03 Jul 2019 23:47:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=9EIsGKDaQdkWTOCLMwtT5nbvh2nfzllYtIpcBeJLo8I=;
        b=dsSZbNRQikjO5dvARv+F6IsHCaRxaj+anwxfONnL6yiccZpZXDbaYmZaJRq3AfPJOP
         c+dFt4kHtFrT9c7Hpofp4uOLf1qoSS7pqB0nXY/94C61wa/YyyDWtWiky0TH/q6bYCTi
         5MYoP7Eypksiy2LEU5j/xmAmzKk8VD1a7okAwvG+amFKo54yyDDdW4VHAhtmyNGdLVag
         /kQWYS+CKpcZZgXq4MUKykVLuh/a0uie97vQaVn28y9YeW5SbW2O+shYLcj5UIZjAIId
         a05qP11JWACaFHDJkskh80vN2PRK2AIhTaLs8Kk/NXawJM7pcNWA+mv7hP8KfKs6ujBV
         rdeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=9EIsGKDaQdkWTOCLMwtT5nbvh2nfzllYtIpcBeJLo8I=;
        b=emrQUXS8THjAPQbCVdxd3NsV+bcmE65OkIVYMBNHpwspT4P81+YMD5AHE7NFfxByog
         Nn1IhoO+xSACADgfbh+QdFsSp0eK3SwDLa87dmn39QkkVTzhluOsclv+eW+rj2KoTxyE
         /UD6UtBTY6KUYRI8vAzReJWvFrw1jR2w5kJqW5sGGy0ishVfz8GspVmT2oXDrGaGscV6
         svo+qf3ZnQo28mcSF6hWPvriY/J1HWlu6dmAOtQtIepvR4whheFyLHz0+DTb716quDJu
         69pT6byYvwqgR257lx9eKY5z92iGhi5PbwiMvvfVlPbgUf9pw3ecjct5hLZ0daV41aP5
         oiJg==
X-Gm-Message-State: APjAAAURl+N0OcYfCHuoXtZAxMrP4LFpxPh1A7QpNGRTSIgoXqvcJ+np
        bDrlSzHNqDQOSJLmTqPibYf/6kehmdtpxXVojF+6hYCH
X-Google-Smtp-Source: APXvYqyoAX8ANpr6fIMUHUQqfVeCMDkbeHsbDlWuisGJKPGZrBsQTSF3Iq8C6cF3qY2MAstlWz/uMNpba/qNhxcVHlE=
X-Received: by 2002:ab0:2c05:: with SMTP id l5mr19280726uar.43.1562222824324;
 Wed, 03 Jul 2019 23:47:04 -0700 (PDT)
MIME-Version: 1.0
References: <20190704062259.GA1094@ogabbay-VM> <20190704064010.GA11575@kroah.com>
 <20190704064141.GA1289@kroah.com>
In-Reply-To: <20190704064141.GA1289@kroah.com>
From:   Oded Gabbay <oded.gabbay@gmail.com>
Date:   Thu, 4 Jul 2019 09:46:38 +0300
Message-ID: <CAFCwf12mahTh+rsRSe6OV1CtL4FkE7h3KEN_Gt8BKMoAS2Z7yQ@mail.gmail.com>
Subject: Re: [git pull] habanalabs pull request for kernel 5.3
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     "Linux-Kernel@Vger. Kernel. Org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 4, 2019 at 9:41 AM Greg KH <gregkh@linuxfoundation.org> wrote:
>
> On Thu, Jul 04, 2019 at 08:40:10AM +0200, Greg KH wrote:
> > On Thu, Jul 04, 2019 at 09:22:59AM +0300, Oded Gabbay wrote:
> > > Hello Greg,
> > >
> > > This is the pull request for habanalabs driver for kernel 5.3.
> > >
> > > It mostly contains improvements to the existing code base. Nothing too
> > > exciting this time.
> > >
> > > Please see the tag message for details on what this pull request contains.
> > >
> > > Thanks,
> > > Oded
> > >
> > > The following changes since commit 60e8523e2ea18dc0c0cea69d6c1d69a065019062:
> > >
> > >   ocxl: Allow contexts to be attached with a NULL mm (2019-07-03 21:29:47 +0200)
> > >
> > > are available in the Git repository at:
> > >
> > >   git://people.freedesktop.org/~gabbayo/linux tags/misc-habanalabs-next-2019-07-04
> >
> > Pulled and pushed out, thanks.
>
> Oops, no, I got the following errors from my scripts when trying to
> push:
>
> Commit a8330ecebaee2703042b95b5437511c5b2876819
>         committer SOB missing
>         dbenzoor@habana.ai oded.gabbay@gmail.com
>         Signed-off-by: Dalit Ben Zoor <dbenzoor@habana.ai>
> Commit 5a0b645318fd96d2d9c65f9b39ef07562c83a494
>         committer SOB missing
>         dbenzoor@habana.ai oded.gabbay@gmail.com
>         Signed-off-by: Dalit Ben Zoor <dbenzoor@habana.ai>
> Commit 4a0fedfc20422d83edd874040a6a965cd55d27d5
>         committer SOB missing
>         dbenzoor@habana.ai oded.gabbay@gmail.com
>         Signed-off-by: Dalit Ben Zoor <dbenzoor@habana.ai>
>
> You "reviewed" these, but as you committed the patch, you also need to
> sign off on them.
>
> Can you fix up the tree and resend?
>
> thanks,
>
> greg k-h

Sure, np, 10 minutes.
I was never really 100% sure about whether I must put sign-off if I
reviewed it, but now I know :)

Sorry for the trouble.

Thanks,
Oded
