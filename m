Return-Path: <SRS0=sxVn=TW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 592A7C282CE
	for <linux-kernel@archiver.kernel.org>; Wed, 22 May 2019 18:10:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 30B2720863
	for <linux-kernel@archiver.kernel.org>; Wed, 22 May 2019 18:10:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="frr1iTSy"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729161AbfEVSKh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 May 2019 14:10:37 -0400
Received: from mail-it1-f196.google.com ([209.85.166.196]:54669 "EHLO
        mail-it1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727975AbfEVSKg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 May 2019 14:10:36 -0400
Received: by mail-it1-f196.google.com with SMTP id h20so5126752itk.4
        for <linux-kernel@vger.kernel.org>; Wed, 22 May 2019 11:10:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=3TUaQnKxGVlpWSPefIyk2E07CFvwMDXGPaWjCwdOzPc=;
        b=frr1iTSygWFPnr5/ey27pxt1cfBtzPKcb5lZDA/fu8dE9SjUZ0g+PVcc06KiQ9/wJp
         HNO6AWj6TYApsqV+IK+BQsqd54H5A/bdFsoEMMgsXbs0nAv2poHnHbB45XVWALyR5Br5
         ymgG+BfyWDKpG/NnKJ6OQjG2wMuS9A+Ofk4AE2P05OaUy1D2AgH5cr+HLItgD0A6epA2
         zqkE3JWfzJvbob/DvPkPYG/u4MinzMxlP/cUqevtnoaIDimZ7e3vtLPo8dyZ/vmO0itS
         jOLex57FcbLpUAhIXMukWVDiCsoPvAIAbP7eXp3BA6oUgC3ESC5KHfIMt2+21yv+A8mQ
         Fafw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=3TUaQnKxGVlpWSPefIyk2E07CFvwMDXGPaWjCwdOzPc=;
        b=O7++32y1DsOHuImmxD+xQT/CXQ6FMQyWz6Eg9fLk5syYBf+E8hOJQwfVfHulbfLOG6
         VbistFikCDUTD2ZVVpruhlfkBnKnyzxCliUh3kMkd18a6cyOMjqXvjR/I1yx9Ih3CeOM
         qMLtGxLiZGQ8xut4ZRmkUFCTBxk2Sxy36IDBCXx5BHKEHS4VcqPZytA8UbQEOhk2c7cm
         S5L1lB+iFU5NY6Yp3k7VbPcIbciYshM/LlvxNAyOmVETBkLn3QNofwI/AIRau3gKiq6D
         qv8APDf97DwTVua1NeC3SGHQ9pXSV8088VhIhd2NELcirkx0yh7lmBsCjkbVXgpFD5nL
         h4dw==
X-Gm-Message-State: APjAAAWLq5rULYH5CdFpJl6g/R5bA1dC0qUQdj3vtU/MaRWg0Ui5qSBi
        3xnc0xbyQwSQkOSR4w5zSmwzZ9AYPh6fw2P38dtPlsTK
X-Google-Smtp-Source: APXvYqz9eLUgCjZxLo/vpG3af0L6etYrvYVd0GrTMp4ahq2xE4ZtnQGK9joeaxrO0qQ5Lx7oxC4w9UNyJNOsWgfJk0w=
X-Received: by 2002:a02:ad09:: with SMTP id s9mr20093787jan.17.1558548636248;
 Wed, 22 May 2019 11:10:36 -0700 (PDT)
MIME-Version: 1.0
References: <20190522071227.31488-1-andrew.smirnov@gmail.com>
 <20190522071227.31488-3-andrew.smirnov@gmail.com> <1558517601.2624.32.camel@pengutronix.de>
 <CAHQ1cqHQWqpJdZjeBiOhEC5JjfcHdY+uA+kbCxzj6kRk9SLUXQ@mail.gmail.com>
In-Reply-To: <CAHQ1cqHQWqpJdZjeBiOhEC5JjfcHdY+uA+kbCxzj6kRk9SLUXQ@mail.gmail.com>
From:   Chris Healy <cphealy@gmail.com>
Date:   Wed, 22 May 2019 11:10:25 -0700
Message-ID: <CAFXsbZooc5=_8SQT6rUQ2cRnor_o0fpW8-C3hFtszuXK+PHGZQ@mail.gmail.com>
Subject: Re: [PATCH 3/3] ARM: dts: imx6: rdu2: Limit USBH1 to Full Speed
To:     Andrey Smirnov <andrew.smirnov@gmail.com>
Cc:     Lucas Stach <l.stach@pengutronix.de>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Fabio Estevam <festevam@gmail.com>,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> > Am Mittwoch, den 22.05.2019, 00:12 -0700 schrieb Andrey Smirnov:
> > > Cabling used to connect devices to USBH1 on RDU2 does not meet USB
> > > spec cable quality and cable length requirements to operate at High
> > > Speed, so limit the port to Full Speed only.
> >
> > Really? I thought this issue is specific to the RDU1, but you've been
> > looking at this USB stuff for a lot longer than me.
> >
>
> I am merely a messenger here. I didn't personally verify this to be
> the case, so your knowledge is probably as good as mine. Chris
> reported this based on feedback from their EE team, so he should know
> all of the details better.

The issue is less about the internals of the device and more about the
cabling that the device is connected to.  In the target application of
this device, the USB cables are almost always longer than the spec
limit of the USB standard for high speed.  Given our use cases, we
don't have need for high speed so limiting the max speed to full speed
is the way we work around cables that are too long for stable high
speed operation.

We have validated that running with full speed does mitigate the
problems experienced when attempting to run with high speed on the
target application installations.

Reviewed-by: Chris Healy <cphealy@gmail.com>
