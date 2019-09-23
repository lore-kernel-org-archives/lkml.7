Return-Path: <SRS0=bmbz=XS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1EA0AC4CECF
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Sep 2019 18:36:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E7D4B20882
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Sep 2019 18:36:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="lQ5OZUGu"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728034AbfIWSg1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 23 Sep 2019 14:36:27 -0400
Received: from mail-oi1-f196.google.com ([209.85.167.196]:35233 "EHLO
        mail-oi1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727376AbfIWSg0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Sep 2019 14:36:26 -0400
Received: by mail-oi1-f196.google.com with SMTP id x3so8511488oig.2
        for <linux-kernel@vger.kernel.org>; Mon, 23 Sep 2019 11:36:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=RFx99F2ge1nFclKY3g9himgS1snsdSimRPdZ4SeJvlg=;
        b=lQ5OZUGuy2OIyORW8igAX3ubmZTtnsHSEeETkF8+tf7941UDiBdeRxVH3kDxTdO18d
         mWyCcpU4yPfzsuAGb9EEhhymD5CsWlXM7pc2Zdk1kAA/0zsDo71qxfN+nmlUaMHCao+3
         w4OuX33W1+pF5nm+EOTkyDxenDjPA5L082aeA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=RFx99F2ge1nFclKY3g9himgS1snsdSimRPdZ4SeJvlg=;
        b=DYLV7RS/lhjt0S5u8E5yYrgAJGNe7/qD4lV0DQ4jqeAFeC/Ym9reDX6QxODdTCI8Uh
         wbWhq9vTEJXNnCdc8mmOeI910Ipwv2/w57b8idhVPIPfDHOX1vnLn6iu1R1rLYd2nBZB
         3PwnnZFpWG+RH7j2zOHdMJQjYqae/i/SrHBdtxg28xPlTdYsqGuh8601vjRkECrFE77N
         JeVvcIAUyeCYKyVxHvCbVl6HbVAtH/kA/pq7ijCvoerh9uo2Yxui8Gt426eqbEpWgHJX
         dPpd2AUs36Z3zFIbWTV82I9VVdXmJzrxZqgY3ByLJLNeGannNNVNJQjdpPprGQbdhQ3c
         n+Ng==
X-Gm-Message-State: APjAAAVzlB7vsiawyI0KmWa0UCD9Yzu8GRcy7pDaOG4415OEYrpM0uO1
        cmXvnybQC4LiNzOmhD4qc4RojBo1x1U=
X-Google-Smtp-Source: APXvYqyUuPZXWbV/Ibx78Uf+bpvwfpAu9icgkLOrZugAoFRHtoztOHpu/kOfAiRDiI9s05ekJbbjFg==
X-Received: by 2002:aca:c358:: with SMTP id t85mr1355233oif.98.1569263784963;
        Mon, 23 Sep 2019 11:36:24 -0700 (PDT)
Received: from mail-io1-f47.google.com (mail-io1-f47.google.com. [209.85.166.47])
        by smtp.gmail.com with ESMTPSA id a21sm3358398oia.27.2019.09.23.11.36.24
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 23 Sep 2019 11:36:24 -0700 (PDT)
Received: by mail-io1-f47.google.com with SMTP id c6so22762736ioo.13
        for <linux-kernel@vger.kernel.org>; Mon, 23 Sep 2019 11:36:24 -0700 (PDT)
X-Received: by 2002:a5d:9812:: with SMTP id a18mr831293iol.168.1569263783642;
 Mon, 23 Sep 2019 11:36:23 -0700 (PDT)
MIME-Version: 1.0
References: <20190917154021.14693-1-m.felsch@pengutronix.de>
 <20190917154021.14693-2-m.felsch@pengutronix.de> <CAD=FV=W7M8mwQqnPyU9vsK5VAdqqJdQdyxcoe9FRRGTY8zjnFw@mail.gmail.com>
 <20190923181431.GU2036@sirena.org.uk>
In-Reply-To: <20190923181431.GU2036@sirena.org.uk>
From:   Doug Anderson <dianders@chromium.org>
Date:   Mon, 23 Sep 2019 11:36:11 -0700
X-Gmail-Original-Message-ID: <CAD=FV=WVGj8xzKFFxsjpeuqtVzSvv22cHmWBRJtTbH00eC=E9w@mail.gmail.com>
Message-ID: <CAD=FV=WVGj8xzKFFxsjpeuqtVzSvv22cHmWBRJtTbH00eC=E9w@mail.gmail.com>
Subject: Re: [PATCH 1/3] regulator: core: fix boot-on regulators use_count usage
To:     Mark Brown <broonie@kernel.org>
Cc:     Marco Felsch <m.felsch@pengutronix.de>, zhang.chunyan@linaro.org,
        Liam Girdwood <lgirdwood@gmail.com>,
        ckeepax@opensource.cirrus.com, LKML <linux-kernel@vger.kernel.org>,
        Sascha Hauer <kernel@pengutronix.de>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Mon, Sep 23, 2019 at 11:14 AM Mark Brown <broonie@kernel.org> wrote:
>
> On Mon, Sep 23, 2019 at 11:02:26AM -0700, Doug Anderson wrote:
>
> > I will freely admit my ignorance here, but I've always been slightly
> > confused by the "always-on" vs. "boot-on" distinction...
>
> > The bindings say:
>
> >   regulator-always-on:
> >     description: boolean, regulator should never be disabled
>
> >   regulator-boot-on:
> >     description: bootloader/firmware enabled regulator
>
> > For 'boot-on' that's a bit ambiguous about what it means.  The
> > constraints have a bit more details:
>
> Boot on means that it's powered on when the kernel starts, it's
> for regulators that we can't read back the status of.

1. Would it be valid to say that it's always incorrect to set this
property if there is a way to read the status back from the regulator?

2. Would this be a valid description of how the property is expected to behave
a) At early boot this regulator will be turned on if it wasn't already on.
b) If no clients are found for this regulator after everything has
loaded, this regulator will be automatically disabled.

If so then I don't _think_ #2b is happening, but I haven't confirmed.


> > ...but then that begs the question of why we have two attributes?
> > Maybe this has already been discussed before and someone can point me
> > to a previous discussion?  We should probably make it more clear in
> > the bindings and/or the constraints.
>
> boot-on just refers to the status at boot, we can still turn
> those regulators off later on if we want to.

How, exactly?  As of my commit 5451781dadf8 ("regulator: core: Only
count load for enabled consumers") if you do:

  r = regulator_get(...)
  regulator_disable(r)

...then you'll get "Underflow of regulator enable count".  In other
words, if a given regulator client disables more times than it enables
then you will get an error.  Since there is no client that did the
initial "boot" enable then there's no way to do the disable unless it
happens automatically (as per 2b above).

...or do you mean that people could call regulator_force_disable()?
Couldn't they also do that with an always-on regulator?



-Doug
