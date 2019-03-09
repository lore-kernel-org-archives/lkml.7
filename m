Return-Path: <SRS0=x0+x=RM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_NEOMUTT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11798C43381
	for <linux-kernel@archiver.kernel.org>; Sat,  9 Mar 2019 00:19:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C7309206DF
	for <linux-kernel@archiver.kernel.org>; Sat,  9 Mar 2019 00:19:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="q3lZIcw/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726444AbfCIATh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 Mar 2019 19:19:37 -0500
Received: from mail-qt1-f193.google.com ([209.85.160.193]:40892 "EHLO
        mail-qt1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726338AbfCIATh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Mar 2019 19:19:37 -0500
Received: by mail-qt1-f193.google.com with SMTP id f11so6014509qti.7;
        Fri, 08 Mar 2019 16:19:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=Kf0wBREv8j37pShsC4OWMsAwgPuP3YyaWl28u/8MzUk=;
        b=q3lZIcw/FBvBaM00nTsi5+SLWovwyXg5LeTww68cN0VPtc5nmyzuZ5rQ6HCyUGvypY
         4BfJBlhnJCg6cj3m2OU4MHs99RCJCYfRJ2CmUXF4HSDuuGJ5RYGItbfGqVFn0iwlffxP
         wg/QKx6BzlVqt45TUVSFosGKbTYhQvihkeP8kDaNxRTim7RNi6wBCCDB/ASmq0UjfDGR
         lapJA6cdMRKtY9qVuHmCknBHboJ5VXHq2Gc09NW0D8u94kvfcunIkZ2hd8NSx29mo36q
         /kk1IJkaH0VhZOf/DgdFsj9WzSxLvSDfr9Vf6uzJxCKw0q0pZ8a7Ie9QaXY8Mzae5TOo
         98bA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=Kf0wBREv8j37pShsC4OWMsAwgPuP3YyaWl28u/8MzUk=;
        b=QJZ702X0rSTtBTOq43ACsjGqpoSQJL5pwipAP6svHaRVtX9jRvHzZkfI19x/9Y54Qz
         PvRe1rRgxKDKIszWySG4/cVMYz1xooiBMQmoEb3JpksiDHom3kc5bmEIGOwDxDlxNPGu
         7M6wubaZThOtq7w/wR08Swfof2D116qzW0JCCzWGSopRr1BVi1IYXyVxWMdmvnLYSgRq
         5Z+MAZD9yVS2ZkQFc9n4oWtmHGuy3AvMqhXgC0uyWW/zjd7C3aFl5pZ0urva69ARyJoe
         fdmKSzQey2KxiBPDGDVhs0Qbf1jeb95MV2erSiZPld19WL41wa2l8V50YLJz5sy11j1V
         HIJw==
X-Gm-Message-State: APjAAAVbQYNspWrdNsxhZ1/0MBzgh5hiT2F7qCZN7ElLPbEA7hLSiBDt
        WJDGWvtxQpjYbN+Ki33CzOY=
X-Google-Smtp-Source: APXvYqzE5a0TktLN9nYtuH6ij+fCW4CwefcXOhZ8MooQ5eTs1IyblxFeuiPKV5U4qDo4jH3rE+kujw==
X-Received: by 2002:a0c:ae78:: with SMTP id z53mr17110233qvc.235.1552090775390;
        Fri, 08 Mar 2019 16:19:35 -0800 (PST)
Received: from renatolg ([191.180.139.44])
        by smtp.gmail.com with ESMTPSA id f8sm4507926qkl.11.2019.03.08.16.19.31
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 08 Mar 2019 16:19:34 -0800 (PST)
From:   Renato Lui Geh <renatogeh@gmail.com>
X-Google-Original-From: Renato Lui Geh <renatogeh@renatolg>
Date:   Fri, 8 Mar 2019 21:19:29 -0300
To:     "Ardelean, Alexandru" <Alex.Ardelean@analog.com>
Cc:     "renatogeh@gmail.com" <renatogeh@gmail.com>,
        "jic23@kernel.org" <jic23@kernel.org>,
        "kernel-usp@googlegroups.com" <kernel-usp@googlegroups.com>,
        "lars@metafoo.de" <lars@metafoo.de>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "knaack.h@gmx.de" <knaack.h@gmx.de>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "Hennerich, Michael" <Michael.Hennerich@analog.com>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
        "devel@driverdev.osuosl.org" <devel@driverdev.osuosl.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "giuliano.belinassi@usp.br" <giuliano.belinassi@usp.br>,
        "pmeerw@pmeerw.net" <pmeerw@pmeerw.net>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "Popa, Stefan Serban" <StefanSerban.Popa@analog.com>
Subject: Re: [PATCH v4 4/9] staging:iio:ad7780: add chip ID values and mask
Message-ID: <20190309001928.uhwia4ujvqqwawlg@renatolg>
References: <cover.1551358569.git.renatogeh@gmail.com>
 <90c573cd53bb54d49de6ac270bcff66880ccfeb5.1551358569.git.renatogeh@gmail.com>
 <190e26b19b8ed6559b92d3a000d852bbb0099a52.camel@analog.com>
 <20190303140107.ljjo3flatwmd44ya@renatolg>
 <20190303145347.41d49646@archlinux>
 <13ef212f8aeebd0c893be253cb4834a3e4d741b8.camel@analog.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Disposition: inline
In-Reply-To: <13ef212f8aeebd0c893be253cb4834a3e4d741b8.camel@analog.com>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 03/04, Ardelean, Alexandru wrote:
>On Sun, 2019-03-03 at 14:53 +0000, Jonathan Cameron wrote:
>> [External]
>>
>>
>> On Sun, 3 Mar 2019 11:01:09 -0300
>> Renato Lui Geh <renatogeh@gmail.com> wrote:
>>
>> > On 03/01, Ardelean, Alexandru wrote:
>> > > On Thu, 2019-02-28 at 11:24 -0300, Renato Lui Geh wrote:
>> > > >
>> > > >
>> > > > The ad7780 supports both the ad778x and ad717x families. Each chip
>> > > > has
>> > > > a corresponding ID. This patch provides a mask for extracting ID
>> > > > values
>> > > > from the status bits and also macros for the correct values for the
>> > > > ad7170, ad7171, ad7780 and ad7781.
>> > > >
>> > > > Signed-off-by: Renato Lui Geh <renatogeh@gmail.com>
>> > > > ---
>> > > >  drivers/staging/iio/adc/ad7780.c | 8 ++++++--
>> > > >  1 file changed, 6 insertions(+), 2 deletions(-)
>> > > >
>> > > > diff --git a/drivers/staging/iio/adc/ad7780.c
>> > > > b/drivers/staging/iio/adc/ad7780.c
>> > > > index 56c49e28f432..ad7617a3a141 100644
>> > > > --- a/drivers/staging/iio/adc/ad7780.c
>> > > > +++ b/drivers/staging/iio/adc/ad7780.c
>> > > > @@ -26,10 +26,14 @@
>> > > >  #define AD7780_RDY             BIT(7)
>> > > >  #define AD7780_FILTER          BIT(6)
>> > > >  #define AD7780_ERR             BIT(5)
>> > > > -#define AD7780_ID1             BIT(4)
>> > > > -#define AD7780_ID0             BIT(3)
>> > > >  #define AD7780_GAIN            BIT(2)
>> > > >
>> > > > +#define AD7170_ID              0
>> > > > +#define AD7171_ID              1
>> > > > +#define AD7780_ID              1
>> > > > +#define AD7781_ID              0
>> > > > +
>> > > > +#define AD7780_ID_MASK         (BIT(3) | BIT(4))
>> > >
>> > > This also doesn't have any functionality change.
>> > > The AD7170_ID, AD7171_ID, AD7780_ID & AD7781_ID IDs are also unused
>> > > (maybe
>> > > in a later patch they are ?).
>> >
>> > They aren't. I added them following a previous review suggestion.
>> > Should
>> > I remove them?
>>
>> Can we check them?  It's always useful to confirm that the device is
>> the one you think it is.  Then we can either use what is there
>> with a suitable warning, or if that is tricky just fault out as the
>> dt is giving us the wrong part number.
>>
>> J
>
>I guess `dev_warn_ratelimited()` could be used to make sure syslog isn't
>spammed-to-death when doing multiple conversions, and the ID isn't correct.
>Since these IDs are read after you get a sample, I'm a bit fearful of log-
>spam.
>
>I wouldn't throw an error in the ad7780_postprocess_sample() for this, but
>warning [with rate-limit] sounds reasonable.

Looking at dev_warn_ratelimited's definition (and its use in other parts
of the kernel), I see that we'd need the device to be stored somewhere
(perhaps in ad7780_state?) in order for us to pass it as argument to
dev_warn from within postprocess_sample. Should this be stored in
ad7780_state?  Or can I get the spi_device some other way?
>
>>
>> > >
>> > > I would also leave the AD7780_ID1 & AD7780_ID0 definitions in place,
>> > > since
>> > > they're easier matched with the datasheet.
>> > >
>> > > >
>> > > >  #define AD7780_PATTERN_GOOD    1
>> > > >  #define AD7780_PATTERN_MASK    GENMASK(1, 0)
>> > > > --
>> > > > 2.21.0
>> > > >
>>
>>
