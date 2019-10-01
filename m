Return-Path: <SRS0=YRFP=X2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8C978ECE587
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Oct 2019 19:57:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5677C20842
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Oct 2019 19:57:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="UnfQmCCa"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727156AbfJAT5p (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 1 Oct 2019 15:57:45 -0400
Received: from mail-io1-f65.google.com ([209.85.166.65]:35897 "EHLO
        mail-io1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725851AbfJAT5p (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Oct 2019 15:57:45 -0400
Received: by mail-io1-f65.google.com with SMTP id b136so51244797iof.3
        for <linux-kernel@vger.kernel.org>; Tue, 01 Oct 2019 12:57:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=o96/wPUY2y8t2voI0Nm5DYaXA5TqXtuex67jswMxEfo=;
        b=UnfQmCCa9punf9e/whGTDqID0hInyaH5EOY9vA7tDwhbUQLhMNrPorQKMIioGkP+yp
         HS2/+bo04gQQgpdbN1Dc2K+aCrYPcGzvk0J8aR+fjy9ZdnbNut6TuC3PO0erBUF+gIY2
         IoOz4UmCofirLGKeCXFZB9X6K0YpCd8iPj1yw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=o96/wPUY2y8t2voI0Nm5DYaXA5TqXtuex67jswMxEfo=;
        b=sXooTPFynnbDvM90TV14bw4/ZSP/sg/et4MhKUuTyc7PJcqQLyUSvFpG2Hjk0pSOc6
         6lqMTAeG6FOqb/ci0oxUERv9hrgVU3r5GGyA3V1xCG2wa/xY3IyAKd9KBkFA+CpYkz9y
         eRxmxFgl3eWt0InKFniadLNXsxtosk+JzUjeUpGNXjjsObh+6KMrRiNSR2Rs4zuhpTgs
         jYYYZn3DdkuaXzo7PsXnytqsS9V8Bvhel1mq5TWqvwGVBM/XRKRYHwNNj/dMjsWLKaWC
         cEpSUJP9ylEhtqFXtrB3Y+RrYx0j4rQNO6I/9uN9uznkq/DiTl2TRY9Is8Xx5tvns2zL
         T95Q==
X-Gm-Message-State: APjAAAUMd74wfY3YkiU1J1/tU3HhNbVzNdFZjTFVGcJa3kN4RXWFVU5o
        fc45S5tI7og62Xs9Hn6CgSiNcegkdOk=
X-Google-Smtp-Source: APXvYqwhCw6cj6406VfNHvlldNKr7RPglJFkBjYZwohmF7HDpqon5TjB0Gm6g4nbKptU37ZD3qSFBA==
X-Received: by 2002:a92:b74f:: with SMTP id c15mr28228873ilm.43.1569959864067;
        Tue, 01 Oct 2019 12:57:44 -0700 (PDT)
Received: from mail-io1-f52.google.com (mail-io1-f52.google.com. [209.85.166.52])
        by smtp.gmail.com with ESMTPSA id t24sm7392857ioi.44.2019.10.01.12.57.43
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 01 Oct 2019 12:57:43 -0700 (PDT)
Received: by mail-io1-f52.google.com with SMTP id q1so51315044ion.1
        for <linux-kernel@vger.kernel.org>; Tue, 01 Oct 2019 12:57:43 -0700 (PDT)
X-Received: by 2002:a92:4a11:: with SMTP id m17mr27844201ilf.142.1569959862851;
 Tue, 01 Oct 2019 12:57:42 -0700 (PDT)
MIME-Version: 1.0
References: <20190917154021.14693-1-m.felsch@pengutronix.de>
 <20190917154021.14693-2-m.felsch@pengutronix.de> <CAD=FV=W7M8mwQqnPyU9vsK5VAdqqJdQdyxcoe9FRRGTY8zjnFw@mail.gmail.com>
 <20190923181431.GU2036@sirena.org.uk> <CAD=FV=WVGj8xzKFFxsjpeuqtVzSvv22cHmWBRJtTbH00eC=E9w@mail.gmail.com>
 <20190923184907.GY2036@sirena.org.uk> <CAD=FV=VkaXDn034EFnJWYvWwyLgvq7ajfgMRm9mbhQeRKmPDRQ@mail.gmail.com>
 <20190924182758.GC2036@sirena.org.uk> <CAD=FV=WZSy6nHjsY2pvjcoR4iy64b35OPGEb3EPSSc5vpeTTuA@mail.gmail.com>
 <20190927084710.mt42454vsrjm3yh3@pengutronix.de>
In-Reply-To: <20190927084710.mt42454vsrjm3yh3@pengutronix.de>
From:   Doug Anderson <dianders@chromium.org>
Date:   Tue, 1 Oct 2019 12:57:31 -0700
X-Gmail-Original-Message-ID: <CAD=FV=XM0i=GsvttJjug6VPOJJGHRqFmsmCp-1XXNvmsYp9sJA@mail.gmail.com>
Message-ID: <CAD=FV=XM0i=GsvttJjug6VPOJJGHRqFmsmCp-1XXNvmsYp9sJA@mail.gmail.com>
Subject: Re: [PATCH 1/3] regulator: core: fix boot-on regulators use_count usage
To:     Marco Felsch <m.felsch@pengutronix.de>
Cc:     Mark Brown <broonie@kernel.org>,
        Chunyan Zhang <zhang.chunyan@linaro.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        ckeepax@opensource.cirrus.com, LKML <linux-kernel@vger.kernel.org>,
        Sascha Hauer <kernel@pengutronix.de>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Fri, Sep 27, 2019 at 1:47 AM Marco Felsch <m.felsch@pengutronix.de> wrote:
> > > > > It should be possible to do a regulator_disable() though I'm not
> > > > > sure anyone actually uses that.  The pattern for a regular
> > > > > consumer should be the normal enable/disable pair to handle
> > > > > shared usage, only an exclusive consumer should be able to use
> > > > > just a straight disable.
>
> In my case it is a regulator-fixed which uses the enable/disable pair.
> But as my descriptions says this will not work currently because boot-on
> marked regulators can't be disabled right now (using the same logic as
> always-on regulators).
>
> > > > Ah, I see, I wasn't aware of the "exclusive" special case!  Marco: is
> > > > this working for you?  I wonder if we need to match
> > > > "regulator->enable_count" to "rdev->use_count" at the end of
> > > > _regulator_get() in the exclusive case...
>
> So my fix isn't correct to fix this in general?

I don't think your fix is correct.  It sounds as if the intention of
"regulator-boot-on" is to have the OS turn the regulator on at bootup
and it keep an implicit reference until someone explicitly tells the
OS to drop the reference.


> > > Yes, I think that case has been missed when adding the enable
> > > counts - I've never actually had a system myself that made any
> > > use of this stuff.  It probably needs an audit of the users to
> > > make sure nobody's relying on the current behaviour though I
> > > can't think how they would.
> >
> > Marco: I'm going to assume you'll tackle this since I don't actually
> > have any use cases that need this.
>
> My use case is a simple regulator-fixed which is turned on by the
> bootloader or to be more precise by the pmic-rom. To map that correctly
> I marked this regulator as boot-on. Unfortunately as I pointed out above
> this is handeld the same way as always-on.

It's a fixed regulator controlled by a GPIO?  Presumably the GPIO can
be read.  That would mean it ideally shouldn't be using
"regulator-boot-on" since this is _not_ a regulator whose software
state can't be read.  Just remove the property.


-Doug
