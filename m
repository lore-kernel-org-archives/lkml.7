Return-Path: <SRS0=s1fu=UU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2C6F3C43613
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Jun 2019 13:47:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0601C215EA
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Jun 2019 13:47:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="l9d43X/R"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726192AbfFUNrL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Jun 2019 09:47:11 -0400
Received: from mail-vs1-f65.google.com ([209.85.217.65]:38289 "EHLO
        mail-vs1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726010AbfFUNrJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Jun 2019 09:47:09 -0400
Received: by mail-vs1-f65.google.com with SMTP id k9so3863853vso.5;
        Fri, 21 Jun 2019 06:47:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=AxgTleW+Rc+so/a6uCWVbqNZdSgwRgTWPFlaLkprW1g=;
        b=l9d43X/RzidUfTeFaUJVIgSg7rFhPujB8t6MPaJkL+BXbiEMR8YjN7VdShjpz6bkvw
         QUSOIfF+PUjcjx4bw+2nkVwanDIqb0OycwGWrAip5v9UQV3gFRNtAYIvjDs/Ub2qV5SD
         X/oHMpMr7cF4fauaLi7WntWrzFLtvN/VpRL4LNO7nuRbPgjPirrwB7pBxdeMN1G8P27O
         k0nfM/V6ILUo5GEBbm7OTcR3IHUKN6zk2NI0OZ6sTHIQqMHqmAIlgY/ZhiUdbfbDEu4I
         FRtuF900pC+GrYLZ/jW6fXtW+onZWQQsERIV5e9829hqeYismMHoceM/BgR4P9bza5w/
         D9Vw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=AxgTleW+Rc+so/a6uCWVbqNZdSgwRgTWPFlaLkprW1g=;
        b=l3VZVcdav0k378bkweyZ/mjW5l8BRNVqC2jMB5yonfkoXqyqry/8whDlCJDcEbMI/s
         t+IipYAaEGhCCk+bCEXv4EY0fG5oLI3gr6zT+VZZ6XqA8iLJd+goinnEA2UVkdZTaGwj
         gVp7zzYd+UsmYEvf7wFhN1uQnGUiuRNT/NnExq7f4op7hxxfeyESyIzNlmWLiDdrbR2u
         zFcfMoqJj8Y1497Ic0ci16hlVpc6HkVIC0LZ3I1zV660LIY6Lg9kQn3/03ZAlWKGTWfF
         OjM52QzabBY/a7RbixW2pDXJeC9xy1ELxCxCyBuj3Z1H9q9dnX//TGlbzQIHiSBcAJLp
         gyng==
X-Gm-Message-State: APjAAAUcajHvfDP3s0obGpEtej0qeKSYx78qvPdXTHGVEUywUHXw4yhU
        IyvrdgP9V7Y3YGtIU//NJQY6mHuy+YcNRcIIKcA=
X-Google-Smtp-Source: APXvYqxZKAR0aVKbWTZb3KOX1ndR0McqkNuRlDo55A7wZdbzbHAPJempFQ7bqocfjDVzd2Hs92Tnq4oamZ0f1sblmJc=
X-Received: by 2002:a67:3310:: with SMTP id z16mr57117243vsz.75.1561124827723;
 Fri, 21 Jun 2019 06:47:07 -0700 (PDT)
MIME-Version: 1.0
References: <1561064991-16874-1-git-send-email-alcooperx@gmail.com>
 <1561064991-16874-7-git-send-email-alcooperx@gmail.com> <facac509-1e64-e35b-ee25-5ba265a514c4@cogentembedded.com>
In-Reply-To: <facac509-1e64-e35b-ee25-5ba265a514c4@cogentembedded.com>
From:   Alan Cooper <alcooperx@gmail.com>
Date:   Fri, 21 Jun 2019 09:47:53 -0400
Message-ID: <CAOGqxeWric9HkUGCJ9fKPh73Y6Do=wJnOjhubucqN6Qd006ExQ@mail.gmail.com>
Subject: Re: [PATCH 6/6] usb: bdc: Update compatible match strings
To:     Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Cc:     ": Linux Kernel Mailing List" <linux-kernel@vger.kernel.org>,
        DTML <devicetree@vger.kernel.org>,
        Felipe Balbi <balbi@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        USB list <linux-usb@vger.kernel.org>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Rob Herring <robh+dt@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> > Remove "brcm,bdc-v0.16" because it was never used on any system.
>
>     You're not really removing it, are you?

Whoops, it was supposed to be removed.
Thanks
Al

On Fri, Jun 21, 2019 at 4:28 AM Sergei Shtylyov
<sergei.shtylyov@cogentembedded.com> wrote:
>
> Hello!
>
> On 21.06.2019 0:09, Al Cooper wrote:
>
> > Remove "brcm,bdc-v0.16" because it was never used on any system.
>
>     You're not really removing it, are you?
>
> > Add "brcm,bdc-udc-v3.1" which exists for any STB system with BDC.
> >
> > Signed-off-by: Al Cooper <alcooperx@gmail.com>
> > ---
> >   drivers/usb/gadget/udc/bdc/bdc_core.c | 1 +
> >   1 file changed, 1 insertion(+)
> >
> > diff --git a/drivers/usb/gadget/udc/bdc/bdc_core.c b/drivers/usb/gadget/udc/bdc/bdc_core.c
> > index 15e28790142d..e2b2628925e6 100644
> > --- a/drivers/usb/gadget/udc/bdc/bdc_core.c
> > +++ b/drivers/usb/gadget/udc/bdc/bdc_core.c
> > @@ -644,6 +644,7 @@ static SIMPLE_DEV_PM_OPS(bdc_pm_ops, bdc_suspend,
> >               bdc_resume);
> >
> >   static const struct of_device_id bdc_of_match[] = {
> > +     { .compatible = "brcm,bdc-udc-v3.1" },
> >       { .compatible = "brcm,bdc-v0.16" },
> >       { .compatible = "brcm,bdc" },
> >       { /* sentinel */ }
>
> MBR, Sergei
