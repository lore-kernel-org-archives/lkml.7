Return-Path: <SRS0=FxTY=RO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6F76EC43381
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Mar 2019 13:39:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 404782075C
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Mar 2019 13:39:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="he3PkEJT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727613AbfCKNi7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Mar 2019 09:38:59 -0400
Received: from mail-io1-f65.google.com ([209.85.166.65]:42641 "EHLO
        mail-io1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727477AbfCKNi6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Mar 2019 09:38:58 -0400
Received: by mail-io1-f65.google.com with SMTP id c4so4021187ioh.9
        for <linux-kernel@vger.kernel.org>; Mon, 11 Mar 2019 06:38:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=gpVeDd0p7pwBszFsgRuNnRDshm6TeMcM97WhxdFQcTc=;
        b=he3PkEJT47wf4/V4syBMMUw6hVQHSB+F9w7J3okASScPPEDoTL2wt+/oXMHuVLf0TY
         XalPrmnsuqf+g696oH60ad1E55HkbCeUWF7Vtms5ua47jnd1/L3bgeujy67fB8v67xK6
         WOMO+7C4WbTqZLMirL4a5SpTsTVsRZ/Xb++FE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=gpVeDd0p7pwBszFsgRuNnRDshm6TeMcM97WhxdFQcTc=;
        b=SmCBsc6zWDFjA8mVHdJy5W0pfPQ71uDBVKB/uhBbpPANIyTIgbCUboVeJBbwbLzaZ5
         u3DP+Wr10oJiLrnYkPMQrYTU/RA4ebBCXuRQbEA5MXSdZpiUu9k02WQnleOoGQEZXuzp
         RmUhkcpSqw2PIwW1aX2FsHBmeopwQHMUz3Vncv/lAHlsOf8j1AI9KQ2cqw8/BQONcYZe
         mzEMLgDlnvoCrZOUf2wKm0hP42SXfJrPHkRCGPBZjVuvYDfFXDTwK5KQgiNbBY7aFjHG
         zvJyP4Yl8GV3BLmGYu5D7k8CdqAryaxrw00a6QSYVsTYX3J3IJkYlPi6WMTKVWv9T5dt
         AnPA==
X-Gm-Message-State: APjAAAVX/Axldg36/6aNxvow0NTxWzxJGVbcSL6i+DvE7VVLIDdbYSit
        3uUdzBokWi3un0Jc3OoTIPTM4hDSBR3qzHvOC1q/KQ==
X-Google-Smtp-Source: APXvYqzqUdQVR4t6gONFRmEhfTNdHJSzoQfy1OKbMisiU5BeVu46BbDjru1kygkpDfPcRKKar78wvr9gBdWQczEBBCM=
X-Received: by 2002:a5d:97c8:: with SMTP id k8mr17720486ios.267.1552311537228;
 Mon, 11 Mar 2019 06:38:57 -0700 (PDT)
MIME-Version: 1.0
References: <20190219101629.15977-1-jagan@amarulasolutions.com>
 <CAMty3ZDpy5YX3V+6e=UtY=a9Lgiw-NEP1JPQn4_LKL3mYFtrvQ@mail.gmail.com> <CAMty3ZB3o1Np7_H7rmCgpUWPk7BRqHRm7gxRpgAq_YyeCUKgaw@mail.gmail.com>
In-Reply-To: <CAMty3ZB3o1Np7_H7rmCgpUWPk7BRqHRm7gxRpgAq_YyeCUKgaw@mail.gmail.com>
From:   Jagan Teki <jagan@amarulasolutions.com>
Date:   Mon, 11 Mar 2019 19:08:45 +0530
Message-ID: <CAMty3ZAmPzXvM+xS3+ULorGuQ-rKfMRNi-HvQdr7hjaFYfMZrg@mail.gmail.com>
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

On Wed, Mar 6, 2019 at 10:47 PM Jagan Teki <jagan@amarulasolutions.com> wrote:
>
> Hi Dmitry,
>
> On Tue, Feb 26, 2019 at 11:43 AM Jagan Teki <jagan@amarulasolutions.com> wrote:
> >
> > Hi Dmitry,
> >
> > On Tue, Feb 19, 2019 at 3:46 PM Jagan Teki <jagan@amarulasolutions.com> wrote:
> > >
> > > This is v6 patchset for supporting goodix GT5553 CTP. Here is the
> > > previous version[1]
> > >
> > > Changes for v5:
> > > - document bindings for required regulators, which are need during
> > >   power-on sequence
> > > - enable, disable required regulators as described in power-on sequence
> > >   using normal regulator calls
> > > - update the proper commi messages
> > > Changes for v4:
> > > - document AVDD22, DVDD12, VDDIO as optional properties
> > > - use regulator bulk calls, for get, enable and disable functionalities
> > > Changes for v4:
> > > - devm_add_action_or_reset for disabling regulator
> > > Changes for v3:
> > > - add cover-letter
> > > - s/ADVV28/AVDD28 on commit head
> > > - fix few typo
> > > Changes for v2:
> > > - Rename vcc-supply with AVDD28-supply
> > > - disable regulator in remove
> > > - fix to setup regulator in probe code
> > > - add chipdata
> > > - drop example node in dt-bindings
> > >
> > > [1] https://patchwork.kernel.org/cover/10816901/
> > >
> > > Jagan Teki (4):
> > >   dt-bindings: input: touchscreen: goodix: Document regulator properties
> > >   Input: goodix - Add regulators suppot
> > >   dt-bindings: input: touchscreen: goodix: Add GT5663 compatible
> > >   Input: goodix - Add GT5663 CTP support
> > >
> > >  .../bindings/input/touchscreen/goodix.txt     |  3 +
> > >  drivers/input/touchscreen/goodix.c            | 60 +++++++++++++++++++
> > >  2 files changed, 63 insertions(+)
> >
> > Let me know if you have any further comments on regulator patch, fyi
> > Rob reviewed it already.
>
> Would you comment on this? few dts changes are pending for this to support.

Gentle remainder.
