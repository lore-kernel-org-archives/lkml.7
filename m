Return-Path: <SRS0=WTd2=XW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 82364C32774
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Sep 2019 10:04:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 51CC4217F4
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Sep 2019 10:04:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="hlT4UFDD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727142AbfI0KEV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 27 Sep 2019 06:04:21 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:37685 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726033AbfI0KET (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Sep 2019 06:04:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1569578657;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=yr1qbbjmCmVWV/qKG3BFNpAVMN2lXkfBYcR3fqycFRA=;
        b=hlT4UFDDaIkEjvRbAQNOSfzIY/hyGLPWEeWZZ+IFZQkA6OCB/OL1SNZ8SwmttTO/IZtRpF
        hVIbs3qEhjHuN27HMHmYUGb3axYqjqLlIjFvsCb8zg/k43iVPXYGaj07FiXAcE6RXICTzE
        hcCa/Om2BHrusFQqkRjwzUcx80fG9LI=
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-37-y4hUlO5pPJqeoRwBmplC2Q-1; Fri, 27 Sep 2019 06:04:16 -0400
Received: by mail-qk1-f200.google.com with SMTP id x186so2079208qke.13
        for <linux-kernel@vger.kernel.org>; Fri, 27 Sep 2019 03:04:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=X0RxdG+xzTY6hppirsAZIE83xPEk0t3BjDbFciB2Sa4=;
        b=f9KmfNSA9R7i9z4jurXwPiAljYSsmeRRlYff8Z1KxzCuXQJVCxbfFCOPToFakzDtNp
         LUTwnB4OLUEHZ8SJNw/2wqffhyaDQGaQitK/sY5o0n09sgUbPcRdin53T7d8Lfw2jEVU
         PswBv/gT4iJ35bRQNIAwmq1i+guTISDG67FQQP5LAAbcm1zmcBscTBLNTLnJqwQE54lb
         pJ4p2pNk7tugjUzgQmKgUdLVat7ujgxTqvAy+sqnIfIyRs+3GNRocnF2pDj2UevB/j2h
         GCqr8dqirB0+KineRTaD9S7VftywF8PaNoL3Sm5T9j1cImaAjXfmUGvKzSU7oVvA3bST
         XybA==
X-Gm-Message-State: APjAAAW9d3KsVGIXPyPw8aDO8rF5fQOvXPZ1suUQX+KEPraW8YtN/U0w
        wK2MJE/GTGF6tYW82Hw0SpqUiV80mO1ocx8gfsDfoC3LQw192naI62UXXDGgM25iTbUI/MgKjTi
        ssct+blw6MmzLOux5o6YaWh6Fyl+RgvFRNLx/DQCu
X-Received: by 2002:a37:a147:: with SMTP id k68mr3643566qke.169.1569578655687;
        Fri, 27 Sep 2019 03:04:15 -0700 (PDT)
X-Google-Smtp-Source: APXvYqygBRP9Pf1w27R4vGLTLB2f3Li9BSkOnzV6Y2bFEcYng23lnngm0cVH6hH+IR1910Txe1zUoKpLhO3vOfuBmjE=
X-Received: by 2002:a37:a147:: with SMTP id k68mr3643545qke.169.1569578655419;
 Fri, 27 Sep 2019 03:04:15 -0700 (PDT)
MIME-Version: 1.0
References: <20190922115054.10880-1-colin.king@canonical.com>
 <nycvar.YFH.7.76.1909231303180.1459@cbobk.fhfr.pm> <20190925114741.GD27389@kadam>
In-Reply-To: <20190925114741.GD27389@kadam>
From:   Benjamin Tissoires <benjamin.tissoires@redhat.com>
Date:   Fri, 27 Sep 2019 12:04:04 +0200
Message-ID: <CAO-hwJKpqGBi+9CRn08sNcn+ggQtnefuMgG98bXtW1UiGqneQA@mail.gmail.com>
Subject: Re: [PATCH] HID: core: clean up indentation issue
To:     Dan Carpenter <dan.carpenter@oracle.com>
Cc:     Jiri Kosina <jikos@kernel.org>,
        Colin King <colin.king@canonical.com>,
        "open list:HID CORE LAYER" <linux-input@vger.kernel.org>,
        kernel-janitors@vger.kernel.org,
        lkml <linux-kernel@vger.kernel.org>
X-MC-Unique: y4hUlO5pPJqeoRwBmplC2Q-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 25, 2019 at 1:48 PM Dan Carpenter <dan.carpenter@oracle.com> wr=
ote:
>
> On Mon, Sep 23, 2019 at 01:04:13PM +0200, Jiri Kosina wrote:
> > On Sun, 22 Sep 2019, Colin King wrote:
> >
> > > From: Colin Ian King <colin.king@canonical.com>
> > >
> > > There is an if statement that is indented by one extra space,
> > > fix this by removing the extraneous space.
> > >
> > > Signed-off-by: Colin Ian King <colin.king@canonical.com>
> > > ---
> > >  drivers/hid/hid-core.c | 4 ++--
> > >  1 file changed, 2 insertions(+), 2 deletions(-)
> > >
> > > diff --git a/drivers/hid/hid-core.c b/drivers/hid/hid-core.c
> > > index 3eaee2c37931..9469c382a182 100644
> > > --- a/drivers/hid/hid-core.c
> > > +++ b/drivers/hid/hid-core.c
> > > @@ -2329,10 +2329,10 @@ int hid_add_device(struct hid_device *hdev)
> > >     /*
> > >      * Check for the mandatory transport channel.
> > >      */
> > > -    if (!hdev->ll_driver->raw_request) {
> > > +   if (!hdev->ll_driver->raw_request) {
> > >             hid_err(hdev, "transport driver missing .raw_request()\n"=
);
> > >             return -EINVAL;
> > > -    }
> > > +   }
> >
> > Let's not pollute git blame and wait for an ocasion when we need to tou=
ch
> > the code for some more valid reason.
>
> Just use `git blame -w`.
>
> This probably came from a Smatch warning.  Smatch warns very seldom
> warns about style issues, but in this case the indenting is legitimately
> bad.

Well, I tend to agree with Jiri here. Yes, you can use a particular
flag in a tool to 'solve' the git blame/history issue, but this is
putting the workload on the user, while tthe code is fine, in this
case. Why do we need to pollute the history of a file for no good
reasons?

Cheers,
Benjamin

