Return-Path: <SRS0=qJmF=WX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D62D0C3A5A4
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Aug 2019 16:36:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AEA0C214DA
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Aug 2019 16:36:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Vo95IgAE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729355AbfH0Qgn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 27 Aug 2019 12:36:43 -0400
Received: from mail-yb1-f195.google.com ([209.85.219.195]:40175 "EHLO
        mail-yb1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726522AbfH0Qgn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Aug 2019 12:36:43 -0400
Received: by mail-yb1-f195.google.com with SMTP id t15so2616056ybg.7;
        Tue, 27 Aug 2019 09:36:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=xIYv3BU6JaefmDoaa35ZOIFyAcL76S8KOZAwhz7dmjk=;
        b=Vo95IgAEhgkNSJYTdAHV9CshPC53hILvjZxbesLEwpL5SGwfG4rrSG7lpbFWOyFwdd
         L/oParCC7vynXx6fUef7UPK8l5zVZaq1Yxx6lbk//Oo+R/F5oSJgW3yEEnVnUUYLZL2s
         qDZXxUApfo+cXrDcVn18cxCmyt/pmIY+sBUgFibjYHsBwoo6xDP1P6kS595/e9hPc7ZM
         4Z+ps6QRLleJKxK1O1ittPb03GZlCcQFtKL6avDLDUJeZ3bUXLE0Yk0fnRc9BbCOcRwN
         0g2eAXOHYkQE/HlMPDj75FFr/98pjzdxGQoAAaCXNjQhfgWGUL19E65/deHErPXdYiDI
         dwvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=xIYv3BU6JaefmDoaa35ZOIFyAcL76S8KOZAwhz7dmjk=;
        b=KKhAfhuWgjpzoaklwF4hVS+Bfz+h5GLZvNGC8GObBYQl2lwrf9jcWbp4ViEPyUVavS
         IHYLViEkVGtKyTK51LL0YHlSdYbzyQDIwb170Vd+4QqKdow9fFsq/W3iFJnLxTAQcR6g
         LHe1kmxW+cRi48FGR6CcsrCMmgk3lbQbICai2cVIwhYWSYa0ULJFzu/PS/kzslw1fQvW
         WNhNTgSpBkJwxSOszgTI8fTPOoGmwJyF7lNY+5R8044f7GxfB6/wz+18z2FxZrFmcYj2
         sCS373DH7l6M9uuxJZh0CqJpBV4Vkyh4Eg9LYynYD3aduXY9m2KWQKd8Grjtyd9BdMm6
         PwbQ==
X-Gm-Message-State: APjAAAX7y4Z+5SXWPoq7qPBbbpAXIFZi+nl3QGoe5nVeLhkEvj4CuD1D
        nONdUkGz2mypqbPDnsaSTad3xxbjW5E479UZn8nqHvmK
X-Google-Smtp-Source: APXvYqxhdBMNi2BS/8hO0O0q5dDmuExqnrYWzayBxh25fnfsGQAfF6Vx827s63AH+X1mtGqvqcUQmZKXrGWrPIBVqIU=
X-Received: by 2002:a25:d490:: with SMTP id m138mr17642647ybf.341.1566923802051;
 Tue, 27 Aug 2019 09:36:42 -0700 (PDT)
MIME-Version: 1.0
References: <20190826081752.57258-1-kkamagui@gmail.com> <CACdnJutomLNthYDzEc0wFBcBHK5iqnk0p-hkAkp57zQZ38oGPA@mail.gmail.com>
 <CAHjaAcSFhQsDYL2iRwwhyvxh9mH4DhxZ__DNzhtk=iiZZ5JdbA@mail.gmail.com> <CACdnJutfR2X-5ksXw4PNUdyH2MJs_mExNCcYPp8NLcPW2EDrYQ@mail.gmail.com>
In-Reply-To: <CACdnJutfR2X-5ksXw4PNUdyH2MJs_mExNCcYPp8NLcPW2EDrYQ@mail.gmail.com>
From:   Seunghun Han <kkamagui@gmail.com>
Date:   Wed, 28 Aug 2019 01:36:30 +0900
Message-ID: <CAHjaAcSpU0eW5PLsEpxTkycwi+wNS67xeizb6_BMM_-qUZYAmg@mail.gmail.com>
Subject: Re: [PATCH] x86: tpm: Remove a busy bit of the NVS area for
 supporting AMD's fTPM
To:     Matthew Garrett <mjg59@google.com>
Cc:     Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>,
        Matthew Garrett <mjg59@srcf.ucam.org>,
        Peter Huewe <peterhuewe@gmx.de>,
        "open list:TPM DEVICE DRIVER" <linux-integrity@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> On Tue, Aug 27, 2019 at 1:23 AM Seunghun Han <kkamagui@gmail.com> wrote:
> > If the regions allocated in the NVS region need to be handled by a
> > driver, the callback mechanism is good for it. However, this case
> > doesn't need it because the regions allocated in NVS are just I/O
> > regions.
> >
> > In my opinion, if the driver wants to handle the region in the NVS
> > while suspending or hibernating, it has to use register_pm_notifier()
> > function and handle the event. We already had the mechanism that could
> > ensure that the cases you worried about would be handled, so it seems
> > to me that removing the busy bit from the NVS region is fine.
>
> No. The NVS regions are regions that need to be saved and restored
> over hibernation, but which aren't otherwise handled by a driver -
> that's why the NVS code exists. If drivers are allowed to bind to NVS
> regions without explicit handling, they risk conflicting with that.

I got your point. Is there any problem if some regions which don't
need to be handled in NVS area are saved and restored? If there is a
problem, how about adding code for ignoring the regions in NVS area to
the nvs.c file like Jarkko said? If we add the code, we can save and
restore NVS area without driver's interaction.

Seunghun
