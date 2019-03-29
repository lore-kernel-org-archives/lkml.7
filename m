Return-Path: <SRS0=SA5R=SA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 28B07C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Mar 2019 19:45:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D7763218A5
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Mar 2019 19:45:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1553888745;
	bh=sWA86loddRSuajse0cjrWSSEew/adi/EOQlSakyH00I=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=Rx7Vu0IKlPKQcOPZnwszgsnYciANjpoMnm/O/t/6VKmRcujNgxSP425iwYj3yo36p
	 p5wHlvRbf44DWR7J5F6Pk5uqmBIuKzL97HCrMHSeQc9NelWnOxAojTI2ioFEvx/Ng4
	 p2KjhbwQnAtEtBfC1MDmQdOom+15DuCZ1nbHiC+Q=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730068AbfC2Tpn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 29 Mar 2019 15:45:43 -0400
Received: from mail.kernel.org ([198.145.29.99]:45528 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729953AbfC2Tpn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Mar 2019 15:45:43 -0400
Received: from mail-qt1-f177.google.com (mail-qt1-f177.google.com [209.85.160.177])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id DDAA1218D3;
        Fri, 29 Mar 2019 19:45:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1553888742;
        bh=sWA86loddRSuajse0cjrWSSEew/adi/EOQlSakyH00I=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=GSSv1RjCEngxuipqa4q+6PsUrqM1euyoaINJbSj/+HHmxAjnPhIXv6/fEbLF+xGkV
         ABFfclCP+mlYLrG9NVaNXr/OYROoOhNAQaOAst/ZWTo75gCLOGxqg6rInQaQI84ngr
         j36z7Qi0d3RHzPrYQj2LI67oZGPJgm2f18SZTCzo=
Received: by mail-qt1-f177.google.com with SMTP id d13so4002370qth.5;
        Fri, 29 Mar 2019 12:45:41 -0700 (PDT)
X-Gm-Message-State: APjAAAUKbzov3mJnG0HEAGnUZM5BIfDaW3wCsLQWROkY0PBwH7/2BXOo
        94STYDVoculI42/ohRH9pXxqDEm3zhkcaQsHZw==
X-Google-Smtp-Source: APXvYqwK36q1zVcabD1Sr31n/V95Z3MU7gbWFkzN8WB1x5GN7FFxHYel8fXiV0A3+SXI2fYZMpsx1V1mnhep6L6Nnu4=
X-Received: by 2002:ac8:267c:: with SMTP id v57mr41998238qtv.76.1553888741097;
 Fri, 29 Mar 2019 12:45:41 -0700 (PDT)
MIME-Version: 1.0
References: <20190327212155.80730-1-venture@google.com> <20190328165009.GA25705@bogus>
 <CAO=notxxYF4noXbR1BeVrwqCBHaVCaXy+jPV4OVbex=w=fV+Rg@mail.gmail.com>
 <CAL_JsqJSvzOQbJSgz7z2wZj9-z=bfhzF_C+662Gnf68TgAPFaA@mail.gmail.com>
 <CAO=notx6K7xTW1VG6BGJFBM5k8EQsWXn3WoWSPSrZRsxkwueSA@mail.gmail.com>
 <CAO=notxD=5pa5sT15a+VrA7qVNPBoJoTo=5sLxibBxc+HWcG4g@mail.gmail.com> <CAO=notynUJGUn3tuJZ_jFPdz23_T1FPyzS46mm5msphLnLW_JA@mail.gmail.com>
In-Reply-To: <CAO=notynUJGUn3tuJZ_jFPdz23_T1FPyzS46mm5msphLnLW_JA@mail.gmail.com>
From:   Rob Herring <robh@kernel.org>
Date:   Fri, 29 Mar 2019 14:45:29 -0500
X-Gmail-Original-Message-ID: <CAL_Jsq+0udKJ1ZyfJCvS8GDGXdNiFmGN+mOGNBvf5mqLr31wew@mail.gmail.com>
Message-ID: <CAL_Jsq+0udKJ1ZyfJCvS8GDGXdNiFmGN+mOGNBvf5mqLr31wew@mail.gmail.com>
Subject: Re: [PATCH v8 1/2] dt-bindings: misc: aspeed-p2a-ctrl: add support
To:     Patrick Venture <venture@google.com>
Cc:     Mark Rutland <mark.rutland@arm.com>, Joel Stanley <joel@jms.id.au>,
        Andrew Jeffery <andrew@aj.id.au>,
        Greg KH <gregkh@linuxfoundation.org>,
        devicetree@vger.kernel.org,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>,
        linux-aspeed@lists.ozlabs.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 29, 2019 at 10:11 AM Patrick Venture <venture@google.com> wrote:
>
> On Fri, Mar 29, 2019 at 7:59 AM Patrick Venture <venture@google.com> wrote:
> >
> > On Fri, Mar 29, 2019 at 7:56 AM Patrick Venture <venture@google.com> wrote:
> > >
> > > On Fri, Mar 29, 2019 at 6:38 AM Rob Herring <robh@kernel.org> wrote:
> > > >
> > > > On Thu, Mar 28, 2019 at 12:03 PM Patrick Venture <venture@google.com> wrote:
> > > > >
> > > > > On Thu, Mar 28, 2019 at 9:50 AM Rob Herring <robh@kernel.org> wrote:
> > > > > >
> > > > > > On Wed, 27 Mar 2019 14:21:55 -0700, Patrick Venture wrote:
> > > > > > > Document the ast2400, ast2500 PCI-to-AHB bridge control driver bindings.
> > > > > > >
> > > > > > > Signed-off-by: Patrick Venture <venture@google.com>
> > > > > > > ---
> > > > > > > Changes for v8:
> > > > > > > - None
> > > > > > > Changes for v7:
> > > > > > > - Moved node under the syscon node it requires
> > > > > > > Changes for v6:
> > > > > > > - None
> > > > > > > Changes for v5:
> > > > > > > - None
> > > > > > > Changes for v4:
> > > > > > > - None
> > > > > > > Changes for v3:
> > > > > > > - None
> > > > > > > Changes for v2:
> > > > > > > - Added comment about syscon required parameter.
> > > > > > > ---
> > > > > > >  .../bindings/misc/aspeed-p2a-ctrl.txt         | 48 +++++++++++++++++++
> > > > > > >  1 file changed, 48 insertions(+)
> > > > > > >  create mode 100644 Documentation/devicetree/bindings/misc/aspeed-p2a-ctrl.txt
> > > > > > >
> > > > > >
> > > > > > Please add Acked-by/Reviewed-by tags when posting new versions. However,
> > > > > > there's no need to repost patches *only* to add the tags. The upstream
> > > > > > maintainer will do that for acks received on the version they apply.
> > > > > >
> > > > > > If a tag was not added on purpose, please state why and what changed.
> > > > >
> > > > > Adding tags in this case is adding a change version?  I was doing this
> > > > > to keep the two patches version-synced.  I thought that was required.
> > > > > There was a version change in the other patch in this set.
> > > >
> > > > Adding tags is not considered a change. I gave a Reviewed-by in v7.
> > > > Subsequent versions should carry that tag if there's no change (or
> > > > only minor changes) in this patch. What happens in the other patches
> > > > is not really important. Maintainers are not going to go searching
> > > > thru the versions to find all the ack/review tags. And if I've already
> > > > reviewed this, I don't want to look at it again.
> > >
> > > Thank you, I didn't realize that had happened.
> >
> > I went back through my email and found the line of your email that
> > included it.  I apologize.
> >
> > So, before I send the updated patch with your ack -- do I need to send
> > a v9? or is this just me sending v8 again?
>
> Sorry.  I see you already answered that when you said that adding a
> tag isn't considered a change.  I have therefore re-sent v8 of this
> patch with your tag added.

To repeat my form letter again, you don't need to send a series again
just to add tags. IOW, if you send a v9, then add the tags. If v8 is
what a maintainer applies, the maintain will take care of adding them
(or patchwork does it for us):

> Please add Acked-by/Reviewed-by tags when posting new versions. However,
> there's no need to repost patches *only* to add the tags. The upstream
> maintainer will do that for acks received on the version they apply.
