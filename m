Return-Path: <SRS0=5V/v=RU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1426CC43381
	for <linux-kernel@archiver.kernel.org>; Sun, 17 Mar 2019 18:32:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D660120896
	for <linux-kernel@archiver.kernel.org>; Sun, 17 Mar 2019 18:32:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="r8fcLsAR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727585AbfCQScO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 17 Mar 2019 14:32:14 -0400
Received: from mail-io1-f66.google.com ([209.85.166.66]:42072 "EHLO
        mail-io1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727470AbfCQScO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 17 Mar 2019 14:32:14 -0400
Received: by mail-io1-f66.google.com with SMTP id c4so12423488ioh.9
        for <linux-kernel@vger.kernel.org>; Sun, 17 Mar 2019 11:32:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=9V+YnJh9rTN+260by+mrhkQTpD7NBsUYhOyprVNDZoQ=;
        b=r8fcLsARb45/A/NqisExhykKD38ZT8GFoIMjzV/SoAxMmycffiL036LMvLdBe7ZHQp
         c2Wm3iUXixtiWs1p1T7LaV9qJ+SbV/XSoutv6yhDBOKouMFQgh6UtzJwRSUCz6gAeHEQ
         syiW+myVfZUu+bQQrJmLKtWNCGMPfoev75Ka4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=9V+YnJh9rTN+260by+mrhkQTpD7NBsUYhOyprVNDZoQ=;
        b=Q7TVGMnXPyt+/xxnGbxhfb6TZb5ZvCGELD2NlDgYwoJ99u/oZUWT+94bE7w967sjmw
         5Eq1PrRr8NH/Mv+57B1eE6N5hplcXr+BlNlPO4oVo4jDkk8dqsg+6mzmAmnCfPM+0Knf
         tTUdPjjLVJsUn2dCwfef2PEtN3lftNRSq2KrNePK1Kt5E9Y9hlmw+3EawDiunQ6sqG4R
         P/SfZ6tQ0m5/imMqPgGaG+R95Jl12aYd++X+pIASRV8mXPQ9oFBf1L8t/kbrzDlzsnvC
         yEM2ag83A7/Y5HzP9XPqy+9Qdhm/myU1XJr4vcFWSQB6zfE2imc1qaOKjE2ydlsJdssV
         okEA==
X-Gm-Message-State: APjAAAUvN45cleQzwn9JApvtfZxZ59KrCBqFL/CFxmQRMy4ZWdULL1PS
        rciUJw0rerqrB1WXmS5xZ9IUp7JE9VQaY+KB3S6Inw==
X-Google-Smtp-Source: APXvYqzyQ9FTzzV5UGyMtO6jSpyRD9ZmujJvBSzkO5W1eegCKGJgJEzcrY2MIsz5o85rfYmlpT6v7gZH8vKidh9PkZk=
X-Received: by 2002:a6b:d80a:: with SMTP id y10mr8415646iob.114.1552847533391;
 Sun, 17 Mar 2019 11:32:13 -0700 (PDT)
MIME-Version: 1.0
References: <20190219101629.15977-1-jagan@amarulasolutions.com>
 <CAMty3ZDpy5YX3V+6e=UtY=a9Lgiw-NEP1JPQn4_LKL3mYFtrvQ@mail.gmail.com>
 <CAMty3ZB3o1Np7_H7rmCgpUWPk7BRqHRm7gxRpgAq_YyeCUKgaw@mail.gmail.com> <CAMty3ZAmPzXvM+xS3+ULorGuQ-rKfMRNi-HvQdr7hjaFYfMZrg@mail.gmail.com>
In-Reply-To: <CAMty3ZAmPzXvM+xS3+ULorGuQ-rKfMRNi-HvQdr7hjaFYfMZrg@mail.gmail.com>
From:   Jagan Teki <jagan@amarulasolutions.com>
Date:   Mon, 18 Mar 2019 00:02:02 +0530
Message-ID: <CAMty3ZAn-7BSr_Bd3hOqEK2pvyBpuLX2McuFBf6Krsk1BKPP8g@mail.gmail.com>
Subject: Re: [PATCH v6 0/4] input: touchscreen: Add goodix GT5553 CTP support
To:     Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Bastien Nocera <hadess@hadess.net>,
        Rob Herring <robh+dt@kernel.org>
Cc:     Henrik Rydberg <rydberg@bitmath.org>, linux-input@vger.kernel.org,
        linux-kernel <linux-kernel@vger.kernel.org>,
        devicetree <devicetree@vger.kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        linux-amarula@amarulasolutions.com,
        Michael Trimarchi <michael@amarulasolutions.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Dmitry,

On Mon, Mar 11, 2019 at 7:08 PM Jagan Teki <jagan@amarulasolutions.com> wrote:
>
> On Wed, Mar 6, 2019 at 10:47 PM Jagan Teki <jagan@amarulasolutions.com> wrote:
> >
> > Hi Dmitry,
> >
> > On Tue, Feb 26, 2019 at 11:43 AM Jagan Teki <jagan@amarulasolutions.com> wrote:
> > >
> > > Hi Dmitry,
> > >
> > > On Tue, Feb 19, 2019 at 3:46 PM Jagan Teki <jagan@amarulasolutions.com> wrote:
> > > >
> > > > This is v6 patchset for supporting goodix GT5553 CTP. Here is the
> > > > previous version[1]
> > > >
> > > > Changes for v5:
> > > > - document bindings for required regulators, which are need during
> > > >   power-on sequence
> > > > - enable, disable required regulators as described in power-on sequence
> > > >   using normal regulator calls
> > > > - update the proper commi messages
> > > > Changes for v4:
> > > > - document AVDD22, DVDD12, VDDIO as optional properties
> > > > - use regulator bulk calls, for get, enable and disable functionalities
> > > > Changes for v4:
> > > > - devm_add_action_or_reset for disabling regulator
> > > > Changes for v3:
> > > > - add cover-letter
> > > > - s/ADVV28/AVDD28 on commit head
> > > > - fix few typo
> > > > Changes for v2:
> > > > - Rename vcc-supply with AVDD28-supply
> > > > - disable regulator in remove
> > > > - fix to setup regulator in probe code
> > > > - add chipdata
> > > > - drop example node in dt-bindings
> > > >
> > > > [1] https://patchwork.kernel.org/cover/10816901/
> > > >
> > > > Jagan Teki (4):
> > > >   dt-bindings: input: touchscreen: goodix: Document regulator properties
> > > >   Input: goodix - Add regulators suppot
> > > >   dt-bindings: input: touchscreen: goodix: Add GT5663 compatible
> > > >   Input: goodix - Add GT5663 CTP support
> > > >
> > > >  .../bindings/input/touchscreen/goodix.txt     |  3 +
> > > >  drivers/input/touchscreen/goodix.c            | 60 +++++++++++++++++++
> > > >  2 files changed, 63 insertions(+)
> > >
> > > Let me know if you have any further comments on regulator patch, fyi
> > > Rob reviewed it already.
> >
> > Would you comment on this? few dts changes are pending for this to support.
>
> Gentle remainder.

It's been several weeks, any further comments?
