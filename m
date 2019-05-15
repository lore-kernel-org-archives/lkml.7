Return-Path: <SRS0=FrXW=TP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E78FFC04E53
	for <linux-kernel@archiver.kernel.org>; Wed, 15 May 2019 16:18:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ADD2D20881
	for <linux-kernel@archiver.kernel.org>; Wed, 15 May 2019 16:18:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="nqADupGE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727050AbfEOQSL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 May 2019 12:18:11 -0400
Received: from mail-qk1-f195.google.com ([209.85.222.195]:45117 "EHLO
        mail-qk1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725953AbfEOQSL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 May 2019 12:18:11 -0400
Received: by mail-qk1-f195.google.com with SMTP id j1so308708qkk.12
        for <linux-kernel@vger.kernel.org>; Wed, 15 May 2019 09:18:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=wKJWA2gYy8hkL7h9RJYBNbZLfdoFycnmyjs/dg+DBhI=;
        b=nqADupGETekpQGxSasrfeywHHy3SYg0lZm05IeXauZpYwkicj0KwonpEd1x2ET9RhQ
         50LV0Qm23En3mVyamgg4DrsgqAIARvRC650+m7BvHXoYYg6AS5TI7cw/VUAKJN/17wgw
         HzrQ4/m4lX2iLB2MmUZPu1aHzEQS7j9t8fkSM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=wKJWA2gYy8hkL7h9RJYBNbZLfdoFycnmyjs/dg+DBhI=;
        b=SF1rezyhOnRbUozhcV0S8R2TORupI5x5mk0+WhTvARkR+9+atYIdviZohbBTQHKWk0
         f4CR1+w6dJrYc5hUiFAAd2a3usWzH3e7a315h9oZ9mxALrSw9AjDSVh73SLs8r2PRN0l
         51a4UASJSNS2XaTRVXWjMbIt3gPvaMLJ5wtKYcS2398h7YMaK7eg0EbJYFdQDsmYpypG
         Jg6UNSIGfuH/dUIpzWU8Iu8I7evGwDt8l8Km9DVUK0JyaGGIvYAryXKm9WVr85zlFX0O
         3cRQaQM0HoVQW+TY+aifo3KAgV+zZWgfPiEXz2V6TJrVT9SNtv4E1glqP9Z+Lx2zzywl
         kDig==
X-Gm-Message-State: APjAAAVf8108I/SfN+drC90tzxnJwV1Um0Y4UDqgU8d/SY/vyB4XzXEw
        sEOi/yZ52sXoJ/8kT8fm9BnnRaXe/R5SJ+T/x+37IQ==
X-Google-Smtp-Source: APXvYqzxBO3O/axKZZPrkz1SErSLRjHPViiYzVfRAlQlCkiJUzYIqsT0KwYglti9YjSfrpCPHE4czG8MNoAoAPztlNI=
X-Received: by 2002:a37:a5c6:: with SMTP id o189mr34016558qke.318.1557937090254;
 Wed, 15 May 2019 09:18:10 -0700 (PDT)
MIME-Version: 1.0
References: <20190513220610.177489-1-ravisadineni@chromium.org> <CAKdAkRQ_J6QWxtWpoRQnNWKcJpXox6xVDZWcWYOXkBhPSn99Rw@mail.gmail.com>
In-Reply-To: <CAKdAkRQ_J6QWxtWpoRQnNWKcJpXox6xVDZWcWYOXkBhPSn99Rw@mail.gmail.com>
From:   Ravi Chandra Sadineni <ravisadineni@chromium.org>
Date:   Wed, 15 May 2019 09:17:59 -0700
Message-ID: <CAEZbON4Z5GKYvMZJ8ojko_f1xzv2rf4uR6cDz2LMxu+XvzTzog@mail.gmail.com>
Subject: Re: [PATCH V1] elan_i2c: Increment wakeup count if wake source.
To:     Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc:     =?UTF-8?B?5buW5bSH5qau?= <kt.liao@emc.com.tw>,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>,
        Abhishek Bhardwaj <abhishekbh@google.com>,
        Todd Broch <tbroch@google.com>,
        lkml <linux-kernel@vger.kernel.org>,
        "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Dmitry,

On Mon, May 13, 2019 at 4:29 PM Dmitry Torokhov
<dmitry.torokhov@gmail.com> wrote:
>
> Hi Ravi,
>
> On Mon, May 13, 2019 at 3:06 PM Ravi Chandra Sadineni
> <ravisadineni@chromium.org> wrote:
> >
> > Notify the PM core that this dev is the wake source. This helps
> > userspace daemon tracking the wake source to identify the origin of the
> > wake.
>
> I wonder if we could do that form the i2c core instead of individual drivers?
I am sorry, I don't see a way how this could be done.
>
> >
> > Signed-off-by: Ravi Chandra Sadineni <ravisadineni@chromium.org>
> > ---
> >  drivers/input/mouse/elan_i2c_core.c | 2 ++
> >  1 file changed, 2 insertions(+)
> >
> > diff --git a/drivers/input/mouse/elan_i2c_core.c b/drivers/input/mouse/elan_i2c_core.c
> > index f9525d6f0bfe..2c0561e20b7f 100644
> > --- a/drivers/input/mouse/elan_i2c_core.c
> > +++ b/drivers/input/mouse/elan_i2c_core.c
> > @@ -981,6 +981,8 @@ static irqreturn_t elan_isr(int irq, void *dev_id)
> >         if (error)
> >                 goto out;
> >
> > +       pm_wakeup_event(dev, 0);
> > +
> >         switch (report[ETP_REPORT_ID_OFFSET]) {
> >         case ETP_REPORT_ID:
> >                 elan_report_absolute(data, report);
> > --
> > 2.20.1
> >
>
> Thanks.
>
> --
> Dmitry

Thanks,
Ravi
