Return-Path: <SRS0=dUEL=RQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1B06C43381
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Mar 2019 19:24:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8116F2075C
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Mar 2019 19:24:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1552505049;
	bh=edO8ZivETo/D7oQY/026yF+ytHjuzPt1RKGB+G0H6pU=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=nKlT0a/UMTPrNQGJmn7asIGeDYvXePDzR9jzKDAGnzkZfFQRKyVU58QWf9x+kEpss
	 wY166LFTPh7soDSYJqu14OY7HLkvochF94i4jc9wlw8Xj6bcj8W4duZmiP+C31Z2VV
	 5n2G9dGwLgEJQeW23dhCVhsTrYTBDe3Qso5+lyqk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728887AbfCMTYI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Mar 2019 15:24:08 -0400
Received: from mail.kernel.org ([198.145.29.99]:53336 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728709AbfCMTYG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Mar 2019 15:24:06 -0400
Received: from mail-qt1-f178.google.com (mail-qt1-f178.google.com [209.85.160.178])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 82BF52177E;
        Wed, 13 Mar 2019 19:24:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1552505045;
        bh=edO8ZivETo/D7oQY/026yF+ytHjuzPt1RKGB+G0H6pU=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=uSOCtybTK+xGJ98O9vpFDnBWCdkn5jraPTWKAYb8eXsgwE4iLgN75gayewHcYH4B/
         kUq+PRw5lhbFSeb8zFo+1511xNnayUFDowLUcDH5KKZwB30Pbcb/0w/VzUMyF8U4to
         go0mWkbB/zROn7x9c0eodngvMehVBlX99/WZ5Vn8=
Received: by mail-qt1-f178.google.com with SMTP id k2so3329525qtm.1;
        Wed, 13 Mar 2019 12:24:05 -0700 (PDT)
X-Gm-Message-State: APjAAAUrJ9h2RSkBdUTzZR2oEBEZbChcAZTf0YmEg3zgg6lazMFuvOLc
        TAd1FUOnfZtJAKkfKmT5AwlPHrPZC/D3Ayh9pw==
X-Google-Smtp-Source: APXvYqwKJk8paiAkY26pa7ZXNoypsPDvTHhGQBHWA2yIT3uF//y6n19w1URWlWBvJFpkxo3SAnjcvuhQRtLKmbqjN58=
X-Received: by 2002:a0c:ec11:: with SMTP id y17mr8220881qvo.77.1552505044754;
 Wed, 13 Mar 2019 12:24:04 -0700 (PDT)
MIME-Version: 1.0
References: <1551288445-22335-1-git-send-email-thor.thayer@linux.intel.com>
 <1551288445-22335-2-git-send-email-thor.thayer@linux.intel.com>
 <20190312160057.GA31306@bogus> <8b18501b-e120-97f2-f6b5-4771dc0f613f@linux.intel.com>
In-Reply-To: <8b18501b-e120-97f2-f6b5-4771dc0f613f@linux.intel.com>
From:   Rob Herring <robh@kernel.org>
Date:   Wed, 13 Mar 2019 14:23:53 -0500
X-Gmail-Original-Message-ID: <CAL_JsqKnwYXSsP5B_uAaRoCEEV7Cb7f8XFPSC2z_hfSj7Rgqyg@mail.gmail.com>
Message-ID: <CAL_JsqKnwYXSsP5B_uAaRoCEEV7Cb7f8XFPSC2z_hfSj7Rgqyg@mail.gmail.com>
Subject: Re: [PATCHv2 1/5] Documentation: dt: edac: Fix Stratix10 IRQ bindings
To:     thor.thayer@linux.intel.com
Cc:     Borislav Petkov <bp@alien8.de>, Dinh Nguyen <dinguyen@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        devicetree@vger.kernel.org, linux-edac@vger.kernel.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 12, 2019 at 2:13 PM Thor Thayer <thor.thayer@linux.intel.com> wrote:
>
> Hi Rob,
>
> On 3/12/19 11:00 AM, Rob Herring wrote:
> > On Wed, Feb 27, 2019 at 11:27:21AM -0600, thor.thayer@linux.intel.com wrote:
> >> From: Thor Thayer <thor.thayer@linux.intel.com>
> >>
> >> Fix Stratix10 ECC bindings to specify only the single
> >> bit error. On Stratix10 double bit errors are handled
> >> as SErrors instead of interrupts.
> >> Indicate the differences between the ARM64 and ARM32
> >> EDAC architecture in the bindings.
> >>
> >> Signed-off-by: Thor Thayer <thor.thayer@linux.intel.com>
> >> ---
> >> v2 No change
> >> ---
> >>   .../devicetree/bindings/edac/socfpga-eccmgr.txt    | 23 +++++++++++++++-------
> >>   1 file changed, 16 insertions(+), 7 deletions(-)
> >>
> >> diff --git a/Documentation/devicetree/bindings/edac/socfpga-eccmgr.txt b/Documentation/devicetree/bindings/edac/socfpga-eccmgr.txt
> >> index 5626560a6cfd..a0ac50e15912 100644
> >> --- a/Documentation/devicetree/bindings/edac/socfpga-eccmgr.txt
> >> +++ b/Documentation/devicetree/bindings/edac/socfpga-eccmgr.txt
> >> @@ -236,33 +236,42 @@ Stratix10 SoCFPGA ECC Manager
> >>   The Stratix10 SoC ECC Manager handles the IRQs for each peripheral
> >>   in a shared register similar to the Arria10. However, ECC requires
> >>   access to registers that can only be read from Secure Monitor with
> >> -SMC calls. Therefore the device tree is slightly different.
> >> +SMC calls. Therefore the device tree is slightly different. Note that
> >> +only 1 interrupt is sent because the double bit errors are treated as
> >> +SErrors instead of IRQ.
> >>
> >>   Required Properties:
> >>   - compatible : Should be "altr,socfpga-s10-ecc-manager"
> >> -- interrupts : Should be single bit error interrupt, then double bit error
> >> -    interrupt.
> >> +- altr,sysgr-syscon : phandle to Stratix10 System Manager Block
> >> +                  containing the ECC manager registers.
> >
> > Seems this was already in use, but why not just make this node a child
> > of the System Manager Block and remove this phandle?
> >
> Yes, this was already in use but I'm trying to fix that oversight with
> this patch.
>
> The System Manager is a collection of registers used by different
> peripherals including EMAC and ECC.

The EMAC has its own registers too, right? But the ECC does not it seems.

> I view ECC Manager as a separate entity as is the Ethernet MAC which is
> why I have it separate. Using the phandle also follows the convention
> established with the Arria10 ECC Manager.

I guess this ship has sailed, so:

Acked-by: Rob Herring <robh@kernel.org>
