Return-Path: <SRS0=eZ3S=UF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 19050C28CC5
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Jun 2019 00:51:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D7BD420866
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Jun 2019 00:51:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Jxkav8gs"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726637AbfFFAvZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Jun 2019 20:51:25 -0400
Received: from mail-it1-f195.google.com ([209.85.166.195]:56090 "EHLO
        mail-it1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726532AbfFFAvY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Jun 2019 20:51:24 -0400
Received: by mail-it1-f195.google.com with SMTP id i21so516934ita.5
        for <linux-kernel@vger.kernel.org>; Wed, 05 Jun 2019 17:51:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=x3JgMGXxoFyrSzQKQvIy0d7RmVBrUCmiUkROdMVZIa8=;
        b=Jxkav8gsgBQ06Hb3Wavigr7Dv4OUBFIziYGUBLGQNsY249hkoBhG9msopaIum3RGkC
         GFdgeT5uczfIuMBub/0izw1+Yz8t7Cnv9B8AtQXn3V1tl60GxZcEkkf3i1UqTrYJLLNj
         enR4W1ZSsOFMvaAv0uJSRGUps1GRMSN8BCLXthT0DDEBjrQVQEVHZP8Q1tRtTXJi0cE7
         h8OIo2Y/gnomw6nVExCTiDhZWYYcsHxZr5ByjwKkSD+Uw6e0Td8eAf0vve6CCzpApvUt
         IyZT5EwLTvLYNnNXL5SgS1RnZQ8raSUKBDtadEx4HRLAZpWheGbBukqCCahrFAJMkheI
         ZStQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=x3JgMGXxoFyrSzQKQvIy0d7RmVBrUCmiUkROdMVZIa8=;
        b=p/RBcIOfWKzgZy/jP/5z4Nhr1/+weMxT69aJSLDTexqdRf+t+qbNxV09cbjSGX7ztq
         RJBgt+H/+yx2U65xYVVnQhiD0l++pacsHmQPidUvg9r60gIUPdRtgIFKsRcipv0kE3Kp
         qcpO2Spy21QOpKDpCXZpnOT+rN27yhAkunjSDkpG13Ht6y+Bzit2TqBBz4eMFPtWNXog
         4wF86eyCMjqenWVkiDJ2mR7VnSc3k+fUOydP9VPD7jZtBBQQewYEQLjjGno8v8yhpBBY
         s9eBz29xbxrzAsgAsjc+d7JvsaGDc5tBRih/hCluLAofv5Lg6NCzw951k+Ze6xWkDiwf
         Rj8A==
X-Gm-Message-State: APjAAAX0xDqzY3WnSDNAjTS6ueKI+FO6tyL3hXg9pZXBb3GW888j+igF
        oBwJ4LcP0v4jbpMkowWGn5M84NXZ+fgKB+rRrlI=
X-Google-Smtp-Source: APXvYqzmph6ZRur6mOBzsUcQ4NfOKcvNyvpb/8eRdiBEF85qH85HkoWRXZfOxuO7UJ3GmA6ueUrxorUxCsRI9L5q0bM=
X-Received: by 2002:a24:424f:: with SMTP id i76mr9129411itb.119.1559782283865;
 Wed, 05 Jun 2019 17:51:23 -0700 (PDT)
MIME-Version: 1.0
References: <20190531143320.8895-1-sudeep.holla@arm.com> <CABb+yY1u5zdocgV=HhQcHWQa_R7ArtFqndU5_T=NsPHJ=jwseA@mail.gmail.com>
 <20190531165326.GA18115@e107155-lin> <20190603193946.GC2456@sirena.org.uk>
 <20190604093827.GA31069@e107533-lin.cambridge.arm.com> <20190605194636.GW2456@sirena.org.uk>
In-Reply-To: <20190605194636.GW2456@sirena.org.uk>
From:   Jassi Brar <jassisinghbrar@gmail.com>
Date:   Wed, 5 Jun 2019 19:51:12 -0500
Message-ID: <CABb+yY27Xe7d5=drKUGg82rJXcRU3EfZkG9FygZoOiioY-BMyw@mail.gmail.com>
Subject: Re: [PATCH 0/6] mailbox: arm_mhu: add support to use in doorbell mode
To:     Mark Brown <broonie@kernel.org>
Cc:     Sudeep Holla <sudeep.holla@arm.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-arm-kernel@lists.infradead.org,
        Arnd Bergmann <arnd@arndb.de>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Cristian Marussi <cristian.marussi@arm.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 5, 2019 at 2:46 PM Mark Brown <broonie@kernel.org> wrote:
>
> On Tue, Jun 04, 2019 at 10:44:24AM +0100, Sudeep Holla wrote:
> > On Mon, Jun 03, 2019 at 08:39:46PM +0100, Mark Brown wrote:
>
> >
> > > It feels like the issues with sharing access to the hardware and with the
> > > API for talking to doorbell hardware are getting tied together and
> > > confusing things.  But like I say I might be missing something here.
>
> ...
>
> > So what I am trying to convey here is MHU controller hardware can be
> > used choosing one of the  different transport protocols available and
> > that's platform choice based on the use-case.
>
> > The driver in the kernel should identify the same from the firmware/DT
> > and configure it appropriately.
>
> > It may get inefficient and sometime impossible to address all use-case
> > if we stick to one transport protocol in the driver and try to build
> > an abstraction on top to use in different transport mode.
>
> Right, what I was trying to get at was that it feels like the discussion
> is getting wrapped up in the specifics of the MHU rather than
> representing this sort of controller with multiple modes in the
> framework.
>
Usually when a controller could be used in more than one way, we
implement the more generic usecase. And that's what was done for MHU.
Implementing doorbell scheme would have disallowed mhu platforms that
don't have any shmem between the endpoints. Now such platforms could
use 32bits registers to pass/get data. Meanwhile doorbells could be
emulated in client code.
 Also, next version of MHU has many (100?) such 32bit registers per
interrupt. Clearly those are not meant to be seen as 3200 doorbells,
but as message passing windows. (or maybe that is an almost different
controller because of the differences)

BTW, this is not going to be the end of SCMI troubles (I believe
that's what his client is). SCMI will eventually have to be broken up
in layers (protocol and transport) for many legit platforms to use it.
That is mbox_send_message() will have to be replaced by, say,
platform_mbox_send()  in drivers/firmware/arm_scmi/driver.c  OR  the
platforms have to have shmem and each mailbox controller driver (that
could ever be used under scmi) will have to implement "doorbell
emulation" mode. That is the reason I am not letting the way paved for
such emulations.

Thanks
