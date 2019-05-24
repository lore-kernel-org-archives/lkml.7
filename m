Return-Path: <SRS0=Z4g5=TY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,T_DKIMWL_WL_HIGH autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80BF4C282E1
	for <linux-kernel@archiver.kernel.org>; Fri, 24 May 2019 14:48:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 53D3820862
	for <linux-kernel@archiver.kernel.org>; Fri, 24 May 2019 14:48:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="TTyzJoAQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404217AbfEXOsI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 May 2019 10:48:08 -0400
Received: from mail-oi1-f195.google.com ([209.85.167.195]:42878 "EHLO
        mail-oi1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2404198AbfEXOsI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 May 2019 10:48:08 -0400
Received: by mail-oi1-f195.google.com with SMTP id w9so7204663oic.9
        for <linux-kernel@vger.kernel.org>; Fri, 24 May 2019 07:48:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=XyDR7SEzBDh6/L7wWbAnb4fBQMmEaID+h9zq8zkdXwM=;
        b=TTyzJoAQaJr1Z5JL720iOhyCk6sQ8Luuk+gkQ98csDg2KOlIYhARswIci9jfRTK5Mt
         vpM9kr70L/vQUWiyHKMgsAEjAqK0xP1n3/6jFoLt0zy7qnX7OdQQsuyC1l1ymSBXbEPI
         PLA7E9fOCDoG5b+JIjtNJuBhvyEX4979+Bk3w=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=XyDR7SEzBDh6/L7wWbAnb4fBQMmEaID+h9zq8zkdXwM=;
        b=Fz8eo18YFaBLwITKpRtM3Tv0UccT0uvo/9L4XFnPa+0yxtlhLcT03/G1dlUdwzfS8I
         FhO8bk3VA5P1SZHHRYVzS7XS7MQj2qLs5d1tZR1H1079NGaNtxGrVGZrISTpdG3/QNvn
         Lwl6rlBfmZIawPiO2gaaeBIV8xxy6ZLU6fJD7fT5PpA73HXKeEgJAvVzPW5Vh2IUYdxk
         cjmd0Zf3hBvuKtFJxkKf3xrAEo5+d7sgpPiHvcTkauIYQ04l3tmQGDF7p+BmdwP5rcRL
         yHKFnrJY0s86WHS3ZlbYXZYG3uC8X7K3fVMOzhjzUrE22p6O4obsDvRfpcNTSBYrnFRp
         ++uQ==
X-Gm-Message-State: APjAAAXly/GXgabZaWWr2gWDrG4qwpDXZCA+IYKEizscwH8telyQpXCh
        6kDLZV0SIcvcl/MLN9BIsmBYTci+ir8=
X-Google-Smtp-Source: APXvYqzhI1wh/lPGD2AINpdwp9ZBhrb1YQDUgCcqkg3VpxyCz6Y4TfuXI3evKLnxOV+WFGZ6aKzsDA==
X-Received: by 2002:aca:b587:: with SMTP id e129mr116340oif.143.1558709286349;
        Fri, 24 May 2019 07:48:06 -0700 (PDT)
Received: from mail-oi1-f171.google.com (mail-oi1-f171.google.com. [209.85.167.171])
        by smtp.gmail.com with ESMTPSA id 59sm1010777otq.8.2019.05.24.07.48.04
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
        Fri, 24 May 2019 07:48:05 -0700 (PDT)
Received: by mail-oi1-f171.google.com with SMTP id a132so7234511oib.2
        for <linux-kernel@vger.kernel.org>; Fri, 24 May 2019 07:48:04 -0700 (PDT)
X-Received: by 2002:aca:48c2:: with SMTP id v185mr6247311oia.171.1558709283923;
 Fri, 24 May 2019 07:48:03 -0700 (PDT)
MIME-Version: 1.0
References: <20190521192045.261801-1-ncrews@chromium.org> <2b8eccfa-0117-37c3-44cb-b1220b9678f9@collabora.com>
In-Reply-To: <2b8eccfa-0117-37c3-44cb-b1220b9678f9@collabora.com>
From:   Nick Crews <ncrews@chromium.org>
Date:   Fri, 24 May 2019 08:47:51 -0600
X-Gmail-Original-Message-ID: <CAHX4x86QbUybRoMScsJ+vwzic6TfECzBnccEe89M8HojMDgH8Q@mail.gmail.com>
Message-ID: <CAHX4x86QbUybRoMScsJ+vwzic6TfECzBnccEe89M8HojMDgH8Q@mail.gmail.com>
Subject: Re: [PATCH v5] platform/chrome: wilco_ec: Add telemetry char device interface
To:     Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        Dmitry Torokhov <dtor@google.com>
Cc:     Benson Leung <bleung@chromium.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Duncan Laurie <dlaurie@chromium.org>,
        Daniel Kurtz <djkurtz@chromium.org>,
        Simon Glass <sjg@chromium.org>, bartfab@chromium.org,
        Oleh Lamzin <lamzin@google.com>,
        Jason Wong <jchwong@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hey Enric, thanks for the review!

On Fri, May 24, 2019 at 3:51 AM Enric Balletbo i Serra
<enric.balletbo@collabora.com> wrote:
>
> Hi Nick,
>
> I'm mostly fine with it but ...
>
> On 21/5/19 21:20, Nick Crews wrote:
> > The Wilco Embedded Controller is able to send telemetry data
> > which is useful for enterprise applications. A daemon running on
> > the OS sends a command to the EC via a write() to a char device,
> > and can read the response with a read(). The write() request is
> > verified by the driver to ensure that it is performing only one
> > of the whitelisted commands, and that no extraneous data is
> > being transmitted to the EC. The response is passed directly
> > back to the reader with no modification.
> >
> > The character device will appear as /dev/wilco_telemN, where N
> > is some small non-negative integer, starting with 0. Only one
>
> Still remains my question in the previous version.
>
> We will really have more than one /dev/wilco_telemN devices handled by this
> driver? Why not use a Miscellaneous Character Device Driver that will simplify
> the code?

We probably will not have more than one device handled by the driver,
but I did this
at the request of Dmitry. He wanted to just do it right the first time so no one
would have to fix it if in the future a second device was needed. FYI,
I did the same
thing for the events driver at https://lore.kernel.org/patchwork/patch/1078461/.

I just tried to find the email thread and/or the review on the
Chromium Gerrit that
documents this, but I couldn't find it. It must have been a private
message, so sorry I
can't link you to it.

Dmitry, am I interpreting your reasoning correctly?

Thanks,
Nick
