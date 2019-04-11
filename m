Return-Path: <SRS0=BPXs=SN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 616C6C10F13
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Apr 2019 14:13:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2BB5F217F4
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Apr 2019 14:13:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RpHUJdQ2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726739AbfDKONj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Apr 2019 10:13:39 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:33051 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726014AbfDKONj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Apr 2019 10:13:39 -0400
Received: by mail-pf1-f196.google.com with SMTP id h5so3539066pfo.0;
        Thu, 11 Apr 2019 07:13:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Psxq1a4XqqKstTyF5j8GevDssfxU25xh8JuczOrSjAE=;
        b=RpHUJdQ2vd0YcPCaW6JwryLgBMnY5/ojB+mqLaGyJb/NZFdiQ6nWDUjRGAVaUplebs
         c87SaPRdmBlO/0fswUFICCR0ks1Z9rdZwt31vI5K4POLlWWgpq9f7DW95rPrqEHRmXby
         Bc5Zm/tTZhzgOPnAwM6msPuCuyJjyM51n+i3P2GvoZ/vdNoMYnBy3NJVpqL6ibkQ/nNh
         O7jLIYAZeQxlNDeSOw9hh8Odwi/yJNPtoCxA+Y9Xdwcwon58lKDmfym7NljEEg/Szu1l
         fcY+UAYe1WzPvTa/GPq93X7JDxVRwoEv+2hlkuEZ+aYuQPytn+V+PPaj85yLvons+AuZ
         j6iA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Psxq1a4XqqKstTyF5j8GevDssfxU25xh8JuczOrSjAE=;
        b=gNqhfBFzCaeEErmuCEr15e9VTrqf+vULLpnmm1xU75ySW4tmy7F88kKN6f5EAHlj2k
         ZgRPmEHrkE0LJ2sRc3+4BSerE6Bu7ETyN5ijP16xgCZbTToDrtANd9gJM7HfpNG2SzkS
         brMw/Lkieg/uQgrE7O+cadhZ8J+ZgvlfKV8JgcPk/+ayH0M4CJYrUwW5GEhwc69QwujW
         LmwiiXRScBTjCpvIoXN9uwqkNojdN4iSWZUx5lqkn9w0YOHKWGmwc2XJGc5GQHtUubXG
         EqoAqnQglz3Sv5I6Bwireka8XWOmxbo/O0vqlyHty+SevuHjyf+uNU7FLwln1NpVafHe
         mKyQ==
X-Gm-Message-State: APjAAAW1DK2MyPeWGbTH6afYdYNJfvoQjFFsMUlfey1jdOg98S2dbwav
        sndSYHtmxpfzofhep30HUCpISueanZGZJo2FlV0=
X-Google-Smtp-Source: APXvYqxwB2wV6kO78NH4gSox5U60K09V345MFH+6jguP8JuUL0GW9ZC1VLhuZRp7m7JBrEzfLI8tHD510JJTVEhvpOM=
X-Received: by 2002:aa7:8b4c:: with SMTP id i12mr43773357pfd.189.1554992018299;
 Thu, 11 Apr 2019 07:13:38 -0700 (PDT)
MIME-Version: 1.0
References: <b143b40446c1870fb8d422b364ead95d54552be9.1527264077.git.lsun@mellanox.com>
 <1554406595-3128-1-git-send-email-lsun@mellanox.com> <CAHp75VdUwn1NEpSc0_Oc4wEh0TRzCwcE0_tajg3ak8BjfZ_-Mw@mail.gmail.com>
 <DB6PR05MB3223779DDDF815D2F5AFFE6BA1510@DB6PR05MB3223.eurprd05.prod.outlook.com>
 <DB6PR05MB3223F6EA9E91F2564C24F5D5A1530@DB6PR05MB3223.eurprd05.prod.outlook.com>
In-Reply-To: <DB6PR05MB3223F6EA9E91F2564C24F5D5A1530@DB6PR05MB3223.eurprd05.prod.outlook.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Thu, 11 Apr 2019 17:13:27 +0300
Message-ID: <CAHp75Vfqi4Z3OrMsgeTJamJ61b7urAGkU2CKng8+Y-HvOGTvBQ@mail.gmail.com>
Subject: Re: [PATCH v13] platform/mellanox: Add TmFifo driver for Mellanox
 BlueField Soc
To:     Liming Sun <lsun@mellanox.com>
Cc:     David Woods <dwoods@mellanox.com>,
        Andy Shevchenko <andy@infradead.org>,
        Darren Hart <dvhart@infradead.org>,
        Vadim Pasternak <vadimp@mellanox.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Platform Driver <platform-driver-x86@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Apr 7, 2019 at 5:05 AM Liming Sun <lsun@mellanox.com> wrote:

> > > + * mlxbf_tmfifo_msg_hdr - Structure of the TmFifo message header
> > > + * @type: message type
> > > + * @len: payload length
> > > + * @u: 64-bit union data
> > > + */
> > > +union mlxbf_tmfifo_msg_hdr {
> > > +       struct {
> > > +               u8 type;
> > > +               __be16 len;
> > > +               u8 unused[5];
> > > +       } __packed;
> > > +       u64 data;
> >
> > I'm not sure I understand how you can distinguish which field of union to use?
> > Isn't here some type missed?
>
> Updated the comment in v14.
>
> This message header is a union of struct and u64 data.
> The 'struct' has
> type and length field which are used to encode & decode the message.
> The 'data' field is used to read/write the message header from/to the FIFO.

Something fishy here.

You are using a structure of data which you would like to write with
one call? Perhaps you need to construct this on-the-fly.
Moreover, the __be memeber is used in a data which is written as LE.
This needs more explanation.

-- 
With Best Regards,
Andy Shevchenko
