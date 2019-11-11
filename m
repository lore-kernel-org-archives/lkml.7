Return-Path: <SRS0=camR=ZD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A061FC17443
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Nov 2019 01:58:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 71B4C206DF
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Nov 2019 01:58:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ODWQhV8M"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726885AbfKKB6u (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 10 Nov 2019 20:58:50 -0500
Received: from mail-vs1-f66.google.com ([209.85.217.66]:39859 "EHLO
        mail-vs1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726743AbfKKB6u (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 Nov 2019 20:58:50 -0500
Received: by mail-vs1-f66.google.com with SMTP id v77so1180972vsv.6;
        Sun, 10 Nov 2019 17:58:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=prm6F9A7udBbbazHidVJSyKNJBPGpqmhX/YTquSVgcw=;
        b=ODWQhV8MgF9c7o2guJEdbXplM5OnBK3aAKfrW4wQcPGsMEl4Z1wvYslIzvIUcEgeeS
         JJpHxAGdzB+eevhMgOAa01uxY9/0JXlx7cRn4sKtalwS/zGLHsKZUOjyhpRCgkA12YZv
         nYluLOPOTobquw72QvmHrEj94j5bE0JE73BWUXfvdYNl5l9LJlvyTiRwc5ZxcW2fDzLm
         9S+yDvimVKg1gHiaOblPU0k64pP3JOs7TXIp/T16hfAMpaSpGCsKD8YOIKnuaAhmWCkR
         9AweewCfBrOrsfcO6qvDiMQI8D8S7bnwOY64Wj7h90XUPeP1qSwpRX0vszGgc/PhxY5K
         NeXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=prm6F9A7udBbbazHidVJSyKNJBPGpqmhX/YTquSVgcw=;
        b=PcSgfif5goasXy7PvJG2Tf8h84/HWm1qbvvbktmayQSGw5vVw0uoUPbHMEcRKP4UrG
         Hs6QMXSLnzAAdtbXPECai939kRfXCHr7qMf7dBEdyWD8kh1Zc38lL7GCJAZakE96qYeT
         oTWvU2Cd+7L+vrniTluIpBt9Gia7Mr+NbWBNKA5AlFXMXUOAYXfYj9YKNK9ZAnkypc3l
         YCR2rVwcY5Q5b9jNWXqWhnpd1hKSP0igrYbaro5CgYGvQqfX2Nc0LU5YF+X+rrYm9qBn
         3TDYqNhe7pq+bPvekTE7RrnnUe7lmrG57bGOJqTEGDs0PeQw/u/tawKEnrly50rypF0K
         vEKQ==
X-Gm-Message-State: APjAAAXT6e1u2DbTmf510a1AonFN/06FkuXzHo/4huG6t61oCX8ZFeJH
        NrrnTHBiis5bj/9JIuPMC5QVE7GCZKVBLgWrdDE=
X-Google-Smtp-Source: APXvYqyQNbwOgzWwHpNa70qjjCceQD8KL2Ro68PHn1EFxoYrLUZtoN9TvfX6fwO+a8rioZNWR4k1ii/lh3Pjou1tRf0=
X-Received: by 2002:a67:f44b:: with SMTP id r11mr2704022vsn.23.1573437528995;
 Sun, 10 Nov 2019 17:58:48 -0800 (PST)
MIME-Version: 1.0
References: <20191014141718.22603-1-narmstrong@baylibre.com>
 <20191014141718.22603-2-narmstrong@baylibre.com> <20191023201141.GA21235@bogus>
 <CA+3zgmsJPsvXgsjDQKKrSG+UNdY3SK+hKCTD2X3hGG+OXejHig@mail.gmail.com>
In-Reply-To: <CA+3zgmsJPsvXgsjDQKKrSG+UNdY3SK+hKCTD2X3hGG+OXejHig@mail.gmail.com>
From:   Jun Li <lijun.kernel@gmail.com>
Date:   Mon, 11 Nov 2019 09:58:37 +0800
Message-ID: <CAKgpwJWU3jB0DWEKE09TOV+YLceBFJ75ZirAXQbuhj8v3FwjXg@mail.gmail.com>
Subject: Re: [PATCH 1/3] doc: dt: bindings: usb: dwc3: Update entries for
 disabling SS instances in park mode
To:     Tim <elatllat@gmail.com>
Cc:     Neil Armstrong <narmstrong@baylibre.com>,
        Felipe Balbi <balbi@kernel.org>, khilman@baylibre.com,
        devicetree@vger.kernel.org, linux-usb@vger.kernel.org,
        linux-amlogic@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Dongjin Kim <tobetter@gmail.com>,
        Jianxin Pan <jianxin.pan@amlogic.com>,
        Rob Herring <robh@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Neil

As I got the information from Synopsys, this bug exists on current IP versi=
ons,
and per my tests with external USB3 hub + 2 Super speed udisks on data
read by dd, I can reproduce this issue with different kernel versions, also=
 I
didn't see obvious performance drop by dd tests after disable park mode for
super speed, so should we just disable it by default so no need a quirk?

Li Jun

Tim <elatllat@gmail.com> =E4=BA=8E2019=E5=B9=B411=E6=9C=8811=E6=97=A5=E5=91=
=A8=E4=B8=80 =E4=B8=8A=E5=8D=888:42=E5=86=99=E9=81=93=EF=BC=9A
>
> Thanks for working on this Neil,
> Is there something that needs doing for this patch to make it into 5.3 or=
 5.4?
> As previously mentioned the patch set fixes the issue on affected hardwar=
e;
>     https://patchwork.kernel.org/patch/11164515/
>
>
>
> On Wed, Oct 23, 2019 at 4:11 PM Rob Herring <robh@kernel.org> wrote:
> >
> > On Mon, Oct 14, 2019 at 04:17:16PM +0200, Neil Armstrong wrote:
> > > This patch updates the documentation with the information related
> > > to the quirks that needs to be added for disabling all SuperSpeed XHC=
i
> > > instances in park mode.
> > >
> > > CC: Dongjin Kim <tobetter@gmail.com>
> > > Cc: Jianxin Pan <jianxin.pan@amlogic.com>
> > > Reported-by: Tim <elatllat@gmail.com>
> > > Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
> > > ---
> > >  Documentation/devicetree/bindings/usb/dwc3.txt | 2 ++
> > >  1 file changed, 2 insertions(+)
> >
> > Sigh, what's one more to the never ending list of quirks...
> >
> > Acked-by: Rob Herring <robh@kernel.org>
