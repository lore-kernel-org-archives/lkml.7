Return-Path: <SRS0=WVJ0=YK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5D5FECE58D
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Oct 2019 20:48:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6FF7821A49
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Oct 2019 20:48:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="LyDa0ifV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2394970AbfJQUsK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 17 Oct 2019 16:48:10 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:46823 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728420AbfJQUsJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Oct 2019 16:48:09 -0400
Received: by mail-pg1-f196.google.com with SMTP id e15so2006718pgu.13
        for <linux-kernel@vger.kernel.org>; Thu, 17 Oct 2019 13:48:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=message-id:mime-version:content-transfer-encoding:in-reply-to
         :references:from:to:cc:subject:user-agent:date;
        bh=gx3DSxvx8ltZUKzpBMBDSoOp0YvfoQmYP1b2jQLzjTA=;
        b=LyDa0ifVkL7+cRQNqU4ahaZLAGNiBCG/A79JhFoz/TB2ib8zIIK/XQtdy+aseHDQDV
         AI0T254tfPYqcV5PK+RSNavvydgC04gJCgKSlg4fCdL4DsFkCYLHReAjCu+5OOR8yQao
         hwnAEOLSelUCfBqxKCYO2Holpza4y+F5VNbEc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:mime-version
         :content-transfer-encoding:in-reply-to:references:from:to:cc:subject
         :user-agent:date;
        bh=gx3DSxvx8ltZUKzpBMBDSoOp0YvfoQmYP1b2jQLzjTA=;
        b=V0oYAceKYtubn/7frAeCLjb+BFA8OE4vDrDBo8ZIRBgeKMI5vjTfjneV2lPzVlNq6m
         OwuiQm8ymtBhOoDdRnmoeSb0uMICb/fHRJ4Sp6GLynjsnk7DfQz2te1y0cqzNBeChXBk
         Gp4wJ4kpWJFDetVjQiur7SrUaZIdhKGVAfLE+oWpDYyrYqPCuQyg5CL9NsL3Vi7op0YZ
         ccUrSOuRlk1m+8P/WspLFSmvyAVBmXaF/PZMOkNJDHlXHkPxQvsIDem8g3V0OSmlGAQX
         iMV21ZVysXJmURYCHHiT7QJ2zZ01sSfSGhCSkX9UmA1aMd9F6C1pQsLOQxSqatQWkMKV
         tCDA==
X-Gm-Message-State: APjAAAWuJxlv3jHnBzqE65AHhcKVpyzu7VZtcz5LjmPJPL2R47n5urZE
        HT63lpgVI/6+Fdii70O1kDL5gQ==
X-Google-Smtp-Source: APXvYqw8EyhFH+SgRLU1IKKnBMNFY1QxBBrBGQr9eMg1c+35NIB9KypzDsaiJp/I7Cjf5re52fYpFA==
X-Received: by 2002:a63:d757:: with SMTP id w23mr5839776pgi.19.1571345287356;
        Thu, 17 Oct 2019 13:48:07 -0700 (PDT)
Received: from chromium.org ([2620:15c:202:1:fa53:7765:582b:82b9])
        by smtp.gmail.com with ESMTPSA id w134sm3979527pfd.4.2019.10.17.13.48.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Oct 2019 13:48:06 -0700 (PDT)
Message-ID: <5da8d386.1c69fb81.4cb85.a19a@mx.google.com>
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <CAL_JsqLf+dLgva+xYNr56xQx3fsLNWsdJBxaJo8nyJDtRxoiyA@mail.gmail.com>
References: <20191004214334.149976-1-swboyd@chromium.org> <20191004214334.149976-11-swboyd@chromium.org> <6ce47827-55e4-dd15-6a05-f25a2f8a8bb7@gmail.com> <CAL_JsqLf+dLgva+xYNr56xQx3fsLNWsdJBxaJo8nyJDtRxoiyA@mail.gmail.com>
From:   Stephen Boyd <swboyd@chromium.org>
To:     Rob Herring <robh+dt@kernel.org>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Frank Rowand <frowand.list@gmail.com>
Subject: Re: [PATCH 10/10] of/device: Don't NULLify match table in of_match_device() with CONFIG_OF=n
User-Agent: alot/0.8.1
Date:   Thu, 17 Oct 2019 13:48:06 -0700
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Rob Herring (2019-10-17 13:24:23)
> On Thu, Oct 17, 2019 at 12:48 PM Frank Rowand <frowand.list@gmail.com> wr=
ote:
> >
> > On 10/04/2019 16:43, Stephen Boyd wrote:
> > > This effectively reverts 1db73ae39a97 ("of/device: Nullify match table
> > > in of_match_device() for CONFIG_OF=3Dn") because that commit makes it=
 more
> > > surprising to users of this API that the arguments may never be
> > > referenced by any code. This is because the pre-processor will replace
> > > the argument with NULL and then the match table will be left unrefere=
nced
> > > by any code but the compiler optimizer doesn't know to drop it. This =
can
> > > lead to compilers warning that match tables are unused, when we really
> > > want to pass the match table to the API but have the compiler see that
> > > it's all inlined and not used and then drop the match table while
> > > silencing the warning. We're being too smart here and not giving the
> > > compiler the chance to do dead code elimination.
> > >
> > > Cc: Arnd Bergmann <arnd@arndb.de>
> > > Cc: Geert Uytterhoeven <geert@linux-m68k.org>
> > > Cc: Rob Herring <robh+dt@kernel.org>
> > > Cc: Frank Rowand <frowand.list@gmail.com>
> > > Signed-off-by: Stephen Boyd <swboyd@chromium.org>
> > > ---
> > >
> > > Please ack or pick for immediate merge so the last patch can be merge=
d.
>=20
> As this one is the last patch, I guess you don't want it picked up by its=
elf.
>=20
> It seems everyone has acked rather than applying. Do you want me to
> take the series?
>=20

It would be great if you could take the series.

Mark applied the ASoC and spi patches. I guess you can try to see if
those merged into mainline and then base on top, or just apply the same
patches on your tree and let the duplicates drop out in the merge path.

