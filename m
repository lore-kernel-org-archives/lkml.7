Return-Path: <SRS0=TDKO=W6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3979C3A5A2
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Sep 2019 09:43:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 891CA206BB
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Sep 2019 09:43:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="T/ttRM9O"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728497AbfICJnN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Sep 2019 05:43:13 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:36873 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726631AbfICJnN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Sep 2019 05:43:13 -0400
Received: by mail-wm1-f66.google.com with SMTP id r195so1133203wme.2
        for <linux-kernel@vger.kernel.org>; Tue, 03 Sep 2019 02:43:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=0J18E0tZ/M/Swa0MUYxxRnMzuj0KjoIKolLmA5LLu3s=;
        b=T/ttRM9OHTtfzkq6pm9FFDX4XlOx+nR6jsMAwQPplwFxKY4FU81c6dnzDYIZ6R1a21
         w++T6Z0eqyHOMsTFsD8OF4nn2uSESNoTCMsgz+twP5K3GjKvCIHc6FhBWegxMHNh8BWO
         S8TMW7e7ofYZyWIhFBjiONySFaUBe2/jgzmrBkRP1VoeIAtxf0keoWJDoq72Fs+By48F
         pVrNR3x05ZIhXKaX6a8bP2zKnkzjXIS87zx78+eGrvUpGJSEi3hcuSlyEr4b1fjanFY/
         lwz9LOh8xJgKt3IkJH6yOYhF1xyiO8e/zSGISv2GdfmM3pGc8ZJtL4uULR9pB/jwEdDG
         2iAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=0J18E0tZ/M/Swa0MUYxxRnMzuj0KjoIKolLmA5LLu3s=;
        b=SYvuRaRqZkBUH9TycNU78YWiSs9TQgrYbURXAP1hpaa4stANJ4K0SpUUlCPvkuu9fh
         yKhNwfhH4cxcqvdExr4JOdX7r9AoZpgsqu7s7/pD0oxVKUSDL4GmWGRKy7dwJEKF1wzl
         lMGboJgNS6Fxn9EsHVevyP556Z/6lFXW4h60jlCWTIYRjoYteINnypFnxMuQs54NPNmC
         fYPLYXS518p11+tRrvU9CdLI4v2Kly7qoiNK/gEAXbt6uX00dQ6qoJ6yKazD4kaQFnXk
         +5l+axQr2rlaAKlC03431fGsZzOzoHSzEf+XJaSBj/icUi2WNX+/6jVOXo++ZCu21/Ye
         Ar8w==
X-Gm-Message-State: APjAAAUK6wobg9Wtlcz0H0D3Pu26hqVRlAVmPzNjnyQ2Ly2i/0btoRCZ
        LZbpeKX/qVxYG6PEDA3FVc/aFbFWPts39Wqk9kzG8sa57t1XmA==
X-Google-Smtp-Source: APXvYqxbJlSC6bbjR/fc9S4RRnrIxUzp53YKAKAPuow/KORWKimQsGdW7wlS1bRSUd9j2/LNiTSbDOCOd/vDymgnCMQ=
X-Received: by 2002:a05:600c:21d1:: with SMTP id x17mr2235442wmj.123.1567503790526;
 Tue, 03 Sep 2019 02:43:10 -0700 (PDT)
MIME-Version: 1.0
References: <20190813212251.12316-1-ben.whitten@gmail.com> <20190814100115.GF4640@sirena.co.uk>
 <CAF3==iuZvCnmAg9hqs8ivHw0wHaUQEf8k9U8=KTekMMjdyyEKg@mail.gmail.com> <20190814161938.GI4640@sirena.co.uk>
In-Reply-To: <20190814161938.GI4640@sirena.co.uk>
From:   Ben Whitten <ben.whitten@gmail.com>
Date:   Tue, 3 Sep 2019 10:42:59 +0100
Message-ID: <CAF3==ivJycGpSpSy3Y9cL7kNf27=kZmETpb-v0=L7BNd1ZPJtg@mail.gmail.com>
Subject: Re: [PATCH] regmap: fix writes to non incrementing registers
To:     Mark Brown <broonie@kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        =?UTF-8?Q?Andreas_F=C3=A4rber?= <afaerber@suse.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>, nandor.han@vaisala.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 14 Aug 2019 at 17:19, Mark Brown <broonie@kernel.org> wrote:
>
> On Wed, Aug 14, 2019 at 02:09:11PM +0100, Ben Whitten wrote:
>
> > So it appeared that the last patch in this area for validating a register
> > block [1] broke the regmap_noinc_write use case.
>
> Please include human readable descriptions of things like commits and
> issues being discussed in e-mail in your mails, this makes them much
> easier for humans to read especially when they have no internet access.
> I do frequently catch up on my mail on flights or while otherwise
> travelling so this is even more pressing for me than just being about
> making things a bit easier to read.

Sure thing, the patch adds in a call which checks if range of registers
is writeable within _regmap_raw_write_impl. This check uses the length
of the data given to _regmap_raw_write_impl to determine the range
of registers to check from the given starting register.

> > Because regmap_noinc_write calls _regmap_raw_write and in
> > turn hits the _regmap_raw_write_impl, the val_len is the depth of the
> > one register to write to and not a block of registers which is assumed
> > by the previous check. By inserting a check that the first (and only)
> > register is a noinc one allows me to start writing to my FIFO again.
>
> > I'm all for an alternative solution though if there is a cleaner approach.
>
> Like I said if we're checking for nonincrementing registers it shouldn't
> just be on the first register, it should be for every address in the
> range.  Probably accept it if the nonincrementing register is the first
> and error otherwise, with some documentation explaining what's going on.

I see yes, we don't want to stumble into a noinc register by mistake when
writing a register range.

You mentioned that we likely have breakage elsewhere, I believe that
regmap_noinc_write probably shouldn't ever have been calling
_regmap_raw_write.

Whilst regmap_noinc_read calls _regmap_raw_read, this function doesn't
do any massage and just calls map->bus->read after selecting a page.
regmap_raw_write on the other hand is meant for writing blocks to
register ranges as these added checks show, and does split work based
on page length etc.
This splitting up is something that shouldn't apply to the FIFO as it's a
deep register.

I modified regmap_noinc_write to be much more like the raw_read
internals, just select page then attempt a map->bus->gather_write,
falling back to linearising if that's not supported.
This approach worked at getting writing working into the FIFO.

So I would propose that there are two 'Fixes:' patches here, one
enhancing the checking when writing a register range to ensure you
don't stumble into a noinc register.
And one to fix noinc_writes to send data directly to the bus once the
page is selected with no splitting up as you would a range.

Kind regards,
Ben
