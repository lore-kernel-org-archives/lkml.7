Return-Path: <SRS0=vY9Y=RJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 358FEC43381
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Mar 2019 17:17:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 01A5520684
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Mar 2019 17:17:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="DmPzlkeG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730437AbfCFRRi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 Mar 2019 12:17:38 -0500
Received: from mail-it1-f193.google.com ([209.85.166.193]:55957 "EHLO
        mail-it1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727116AbfCFRRi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Mar 2019 12:17:38 -0500
Received: by mail-it1-f193.google.com with SMTP id z131so10667133itf.5
        for <linux-kernel@vger.kernel.org>; Wed, 06 Mar 2019 09:17:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=zrUbNV+koa4f1wIx3s2XHtmcJu2CEdgy0FiyKR7xLY4=;
        b=DmPzlkeG3h/XfdII8afocr2+r8erNuWOzIcIqjUVRCY9yhnBUGzKBvzu0iaMwMZg1f
         Vhl8RjEfqrrRqMUcht/aeu/PFITH/CSZZju4fymlQvKvE2X4fHX/zsIAxCpnbPuT/YEQ
         Dpf+ND8AlhX6sDa4RuoCs8VEFrkM++3qjeEK8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=zrUbNV+koa4f1wIx3s2XHtmcJu2CEdgy0FiyKR7xLY4=;
        b=Ame/op7yyFGhurNq/t2Szr/d2gKP5poe4tGoVuLEq9be7j+6A25xyCABfAi+Sj3snK
         wB+QP0iHZZONkZDIWO7TSvilZXfa7GTKDalr2QwC5MMlwJT9DEzPeRJBT/JHkreWPv4f
         mwQr4MjijCFOUJw0W8VeCftLr0XNJcSKkN4En5uHbwVvfjIL9Urj/CfhZxtadNFtqxxF
         evdmyJjqOEAa8C1i6o1YEBY/x8OeH5+SZgI4DT2kcoxmJyyDXqpryoSbKe71hwgcuQf9
         aqLkQMkSm75KyH0PkDPFaE68DmzpCqb40fjLyolS+HhZXmtdPafIJgHc6vfyOjZlJ58f
         IJGA==
X-Gm-Message-State: APjAAAXw8qvlwTQJKMp3JXiNL6FtnxfOH/ws6mTaXwtdCNioend0V9h3
        V0KeEs+SNzmUPklNgWvuWcIuMqsnyt0ZTOx586d6aw==
X-Google-Smtp-Source: APXvYqxCPUiq0As8iiMisJcuwj7j8WM4GLMiN6qMEx/1TK7ymws+MtplC2/D1XjjXl8rtJ7VQPBIN8SfBqLC0Gwr60k=
X-Received: by 2002:a24:e4d:: with SMTP id 74mr2557585ite.32.1551892657186;
 Wed, 06 Mar 2019 09:17:37 -0800 (PST)
MIME-Version: 1.0
References: <20190219101629.15977-1-jagan@amarulasolutions.com> <CAMty3ZDpy5YX3V+6e=UtY=a9Lgiw-NEP1JPQn4_LKL3mYFtrvQ@mail.gmail.com>
In-Reply-To: <CAMty3ZDpy5YX3V+6e=UtY=a9Lgiw-NEP1JPQn4_LKL3mYFtrvQ@mail.gmail.com>
From:   Jagan Teki <jagan@amarulasolutions.com>
Date:   Wed, 6 Mar 2019 22:47:26 +0530
Message-ID: <CAMty3ZB3o1Np7_H7rmCgpUWPk7BRqHRm7gxRpgAq_YyeCUKgaw@mail.gmail.com>
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

On Tue, Feb 26, 2019 at 11:43 AM Jagan Teki <jagan@amarulasolutions.com> wrote:
>
> Hi Dmitry,
>
> On Tue, Feb 19, 2019 at 3:46 PM Jagan Teki <jagan@amarulasolutions.com> wrote:
> >
> > This is v6 patchset for supporting goodix GT5553 CTP. Here is the
> > previous version[1]
> >
> > Changes for v5:
> > - document bindings for required regulators, which are need during
> >   power-on sequence
> > - enable, disable required regulators as described in power-on sequence
> >   using normal regulator calls
> > - update the proper commi messages
> > Changes for v4:
> > - document AVDD22, DVDD12, VDDIO as optional properties
> > - use regulator bulk calls, for get, enable and disable functionalities
> > Changes for v4:
> > - devm_add_action_or_reset for disabling regulator
> > Changes for v3:
> > - add cover-letter
> > - s/ADVV28/AVDD28 on commit head
> > - fix few typo
> > Changes for v2:
> > - Rename vcc-supply with AVDD28-supply
> > - disable regulator in remove
> > - fix to setup regulator in probe code
> > - add chipdata
> > - drop example node in dt-bindings
> >
> > [1] https://patchwork.kernel.org/cover/10816901/
> >
> > Jagan Teki (4):
> >   dt-bindings: input: touchscreen: goodix: Document regulator properties
> >   Input: goodix - Add regulators suppot
> >   dt-bindings: input: touchscreen: goodix: Add GT5663 compatible
> >   Input: goodix - Add GT5663 CTP support
> >
> >  .../bindings/input/touchscreen/goodix.txt     |  3 +
> >  drivers/input/touchscreen/goodix.c            | 60 +++++++++++++++++++
> >  2 files changed, 63 insertions(+)
>
> Let me know if you have any further comments on regulator patch, fyi
> Rob reviewed it already.

Would you comment on this? few dts changes are pending for this to support.

Jagan.
