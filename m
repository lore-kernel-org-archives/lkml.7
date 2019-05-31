Return-Path: <SRS0=bMiL=T7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1B30C04AB6
	for <linux-kernel@archiver.kernel.org>; Fri, 31 May 2019 16:21:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B7B4F26BE0
	for <linux-kernel@archiver.kernel.org>; Fri, 31 May 2019 16:21:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="avkpptgN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726994AbfEaQVV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 31 May 2019 12:21:21 -0400
Received: from mail-io1-f65.google.com ([209.85.166.65]:46406 "EHLO
        mail-io1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726689AbfEaQVV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 May 2019 12:21:21 -0400
Received: by mail-io1-f65.google.com with SMTP id u25so8628319iot.13
        for <linux-kernel@vger.kernel.org>; Fri, 31 May 2019 09:21:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=hhzUzcK+D+x0PoR8QoOOO0vIELyXq5qCJQReWwEd68k=;
        b=avkpptgN30TGCHK1XGlzNzBfHRpn6OXiAXMYSQjo1mMKGC0YWM0fQDIi/HI3fldW0B
         vUdNL4NJ/dSpcY6P2E8h3eYXHIO1WTZXyaltmZdtL9pnF9xKadr+RVpDRSWCsAlWcsjQ
         +fPgx9hzSwPVG2/qCaSbCzlw6ZiBtn3frTTW++3CfLkiyrIzm7pHCIjbn/e6AlisMBJs
         +xEWhR8qtnXAe4EPvZIxo4BPTmuXaN46HJEwcH9LiJLS/RtvSAX03FG5jr5caf1/7N9M
         4hB0viKAivOLyEDpWzoDjlcxHd7r5u9TsXcVtUKuAl2t4i6Mtikky5lj6gG95+bc9q7V
         +YIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=hhzUzcK+D+x0PoR8QoOOO0vIELyXq5qCJQReWwEd68k=;
        b=nR6/Z485vJ+xEmw0SNF2nynf2Yi7mPUg8pFDVIiw2eZWMEdpUO4wNzsK8MNp4Gdwez
         g/jxEr00hBd3dWXaZnqmLzQiOBicCc00CT3tV1HmUUnFMzQol+mGONGyZttN92YJUvhs
         nIN5kEbaquBxM5ajSIgdatZQ0xgnmXw4y3z/GZfe6sevt1l8ppZ88/26teMMbBdmBIfL
         Twe1FvI5WvD4y9YMdVUDzG8sf9KSQRWTJRT4UsaFRvZDa71GWYiwC1Jg0iROJN4mdAvy
         b7PCSH/0y68hV3xZmqbxycDJDuH4RYmTBdjndRy+03YHpqyy0Z/FkyPGFYg6gEe0siwO
         xC9A==
X-Gm-Message-State: APjAAAUCcTrp8EYPuqtmTbuPyNfUkM+P7MWsmWD6N64mr4Ed5GWeOfWI
        6NwcWSXBqC9VQ+TT4IptFyuUqnvvKZNNNcfFL9k=
X-Google-Smtp-Source: APXvYqyOTbkf5uG2siRLrdE23h185dSngIKc8wsDjAlb6RyZEh9XEpe4nzXaFLzGOZnH3RtV3azlZDTBHwilrML5lE0=
X-Received: by 2002:a5d:8c81:: with SMTP id g1mr7320119ion.239.1559319680310;
 Fri, 31 May 2019 09:21:20 -0700 (PDT)
MIME-Version: 1.0
References: <20190531143320.8895-1-sudeep.holla@arm.com>
In-Reply-To: <20190531143320.8895-1-sudeep.holla@arm.com>
From:   Jassi Brar <jassisinghbrar@gmail.com>
Date:   Fri, 31 May 2019 11:21:08 -0500
Message-ID: <CABb+yY1u5zdocgV=HhQcHWQa_R7ArtFqndU5_T=NsPHJ=jwseA@mail.gmail.com>
Subject: Re: [PATCH 0/6] mailbox: arm_mhu: add support to use in doorbell mode
To:     Sudeep Holla <sudeep.holla@arm.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-arm-kernel@lists.infradead.org,
        Arnd Bergmann <arnd@arndb.de>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Brown <broonie@kernel.org>,
        Cristian Marussi <cristian.marussi@arm.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Sudeep,

On Fri, May 31, 2019 at 9:33 AM Sudeep Holla <sudeep.holla@arm.com> wrote:
>
> This is my another attempt to extend mailbox framework to support
> doorbell mode mailbox hardware. It also adds doorbell support to ARM
> MHU driver.
>
Nothing has really changed since the last time we discussed many months ago.
MHU remains same, and so are my points.

>
> Brief hardware description about MHU
> ====================================
>
> For each of the interrupt signals, the MHU drives the signal using a 32-bit
> register, with all 32 bits logically ORed together. The MHU provides a set of
> registers to enable software to SET, CLEAR, and check the STATUS of each of
> the bits of this register independently. The use of 32 bits for each interrupt
> line enables software to provide more information about the source of the
> interrupt.
>
"32 bits for each interrupt line"  =>  32 virtual channels or 32bit
data over one physical channel. And that is how the driver is
currently written.

> For example, each bit of the register can be associated with a type
> of event that can contribute to raising the interrupt.
>
Sure there can be a usecase where each bit is associated with an event
(virtual channel). As you said, this is just one example of how MHU
can be used. There are other ways MHU is used already.

Patch-2/6 looks good though. I will pick that up.

Thanks.
