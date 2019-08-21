Return-Path: <SRS0=xaRW=WR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D1582C3A59E
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Aug 2019 06:06:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 900A72339E
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Aug 2019 06:06:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=jms.id.au header.i=@jms.id.au header.b="WvF1ftlo"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727778AbfHUGGL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 21 Aug 2019 02:06:11 -0400
Received: from mail-qk1-f193.google.com ([209.85.222.193]:36823 "EHLO
        mail-qk1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727388AbfHUGGL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Aug 2019 02:06:11 -0400
Received: by mail-qk1-f193.google.com with SMTP id d23so869157qko.3
        for <linux-kernel@vger.kernel.org>; Tue, 20 Aug 2019 23:06:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=jms.id.au; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=u4vudB10NnGSSIVbFDIExmT5iLFJ1FBMO1Iq0ZB2aGA=;
        b=WvF1ftloUdpfjtWcfdm6rO6AOAmWH7IfHxfZ9J1MNR+X4HhR7PYkVvciSnk70rUSMH
         VLutVcOTXVIf5zCbD199NfcVBcjyD+/2Lk5tibNQVP8qTUP/r7T5SVHm1u4loLn1ysDg
         u+DmbgmLvHhpA3m0V/XGYeh6/zRNVYQzNwANY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=u4vudB10NnGSSIVbFDIExmT5iLFJ1FBMO1Iq0ZB2aGA=;
        b=s/LNn89s4P+JLNqds/agJTV5Ef9rBlvL/qeyuGPgsIIXKb2iwnQZC/J0uekELkUUKJ
         QBKX13v+QApSHmxI0FCtt+/IpkOgIGnMRG/u+4VizGo/nVxM+aPTWtq9P0gdiCJXmMBa
         l3Sn3ziUGRayClChnLo1kfzFjcSrhKZwSG6rF3wJ+TEK07c46w9NR64FIm285ehjLsEp
         ilZgV0hQjeGqiAFIhALws34eITfwYex3iyngjXWNYuilW9fKV3MyS6dyIwQl0ZRmM11N
         r/tpLKSql+ELRhPNzd//rUK/NR54v4zKMcZzK9mDRUxegNJa20m5+9TWMqD6rwQgX3CU
         SR8Q==
X-Gm-Message-State: APjAAAUq/5gN53JHIhWZPUfFhWZOxmnSVCusNUAIzJNIa2fHsJCOLiMr
        EUraYFL/Bt8/zREQpB7CD6SpMOlwDe1cMYljZbg=
X-Google-Smtp-Source: APXvYqzbicHccNHud6DWGqtLSuhmh68QJIsc5UokILNEEGLB0NGMfwGbZX49AhlIcGFb/6gQfq5DXTrOIrW5Ba+oClg=
X-Received: by 2002:a05:620a:705:: with SMTP id 5mr30258433qkc.330.1566367569477;
 Tue, 20 Aug 2019 23:06:09 -0700 (PDT)
MIME-Version: 1.0
References: <1565896134-22749-1-git-send-email-eajames@linux.ibm.com> <a1cbb068b3b264c22792fda5f62f4fe9f1f1733b.camel@kernel.crashing.org>
In-Reply-To: <a1cbb068b3b264c22792fda5f62f4fe9f1f1733b.camel@kernel.crashing.org>
From:   Joel Stanley <joel@jms.id.au>
Date:   Wed, 21 Aug 2019 06:05:58 +0000
Message-ID: <CACPK8Xeinjk7Vp4-M-dbPtnYWBnouaKS0yQFn9U9juj0pg7zXw@mail.gmail.com>
Subject: Re: [PATCH] fsi: scom: Don't abort operations for minor errors
To:     Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc:     Eddie James <eajames@linux.ibm.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Greg KH <gregkh@linuxfoundation.org>,
        Jeremy Kerr <jk@ozlabs.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 21 Aug 2019 at 05:26, Benjamin Herrenschmidt
<benh@kernel.crashing.org> wrote:
>
> On Thu, 2019-08-15 at 14:08 -0500, Eddie James wrote:
> > The scom driver currently fails out of operations if certain system
> > errors are flagged in the status register; system checkstop, special
> > attention, or recoverable error. These errors won't impact the ability
> > of the scom engine to perform operations, so the driver should continue
> > under these conditions.
> > Also, don't do a PIB reset for these conditions, since it won't help.
> >
> > Signed-off-by: Eddie James <eajames@linux.ibm.com>
>
> Acked-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>

Thanks Ben.  We also have one from jk which was sent to the openbmc list:

Acked-by: Jeremy Kerr <jk@ozlabs.org>

And we can add:

Fixes: 6b293258cded ("fsi: scom: Major overhaul")

I'll stick this in the FSI tree.

Cheers,

Joel

>
> > ---
> >  drivers/fsi/fsi-scom.c | 8 +-------
> >  1 file changed, 1 insertion(+), 7 deletions(-)
> >
> > diff --git a/drivers/fsi/fsi-scom.c b/drivers/fsi/fsi-scom.c
> > index 343153d..004dc03 100644
> > --- a/drivers/fsi/fsi-scom.c
> > +++ b/drivers/fsi/fsi-scom.c
> > @@ -38,8 +38,7 @@
> >  #define SCOM_STATUS_PIB_RESP_MASK    0x00007000
> >  #define SCOM_STATUS_PIB_RESP_SHIFT   12
> >
> > -#define SCOM_STATUS_ANY_ERR          (SCOM_STATUS_ERR_SUMMARY | \
> > -                                      SCOM_STATUS_PROTECTION | \
> > +#define SCOM_STATUS_ANY_ERR          (SCOM_STATUS_PROTECTION | \
> >                                        SCOM_STATUS_PARITY |     \
> >                                        SCOM_STATUS_PIB_ABORT | \
> >                                        SCOM_STATUS_PIB_RESP_MASK)
> > @@ -251,11 +250,6 @@ static int handle_fsi2pib_status(struct scom_device *scom, uint32_t status)
> >       /* Return -EBUSY on PIB abort to force a retry */
> >       if (status & SCOM_STATUS_PIB_ABORT)
> >               return -EBUSY;
> > -     if (status & SCOM_STATUS_ERR_SUMMARY) {
> > -             fsi_device_write(scom->fsi_dev, SCOM_FSI2PIB_RESET_REG, &dummy,
> > -                              sizeof(uint32_t));
> > -             return -EIO;
> > -     }
> >       return 0;
> >  }
> >
>
