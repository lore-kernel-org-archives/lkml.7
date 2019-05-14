Return-Path: <SRS0=uOpN=TO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DAD26C04AB7
	for <linux-kernel@archiver.kernel.org>; Tue, 14 May 2019 21:16:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A8E0820881
	for <linux-kernel@archiver.kernel.org>; Tue, 14 May 2019 21:16:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="HYtfkmzD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726566AbfENVQJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 May 2019 17:16:09 -0400
Received: from mail-pl1-f193.google.com ([209.85.214.193]:39836 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726336AbfENVQJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 May 2019 17:16:09 -0400
Received: by mail-pl1-f193.google.com with SMTP id g9so210185plm.6
        for <linux-kernel@vger.kernel.org>; Tue, 14 May 2019 14:16:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:content-transfer-encoding:in-reply-to:references:from
         :subject:cc:to:message-id:user-agent:date;
        bh=4/0EYyURtIIeG3BNu5Eb8zY3q3sILIawrVYeoU2X7wE=;
        b=HYtfkmzDiWv/IoeQZ8htdEocmcAJwoVrmzPN3cllVYS3DBvkgnDeI7v5BR6vMZweSX
         W4ZLmiOU3JxWHx72V1K3ych98Py+AXaNu6NC2OpH5ciRpOiFP1iglTiZjcXly1deVL8g
         yraTHwNouWxUFKNzRbbqmYRpUAfx1MMm7AutA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:content-transfer-encoding
         :in-reply-to:references:from:subject:cc:to:message-id:user-agent
         :date;
        bh=4/0EYyURtIIeG3BNu5Eb8zY3q3sILIawrVYeoU2X7wE=;
        b=QDBHRhWg47wNVMKbqimGYDLxrGgMrnzrN6rNuQvFUODl0KWKtUu6YWaI524ccnyyIF
         7jiYaRF+6zzEdcrt7GXOQnywc/iGKs1+tXE2XRihwoN8Q94Cdj5P/3vplDBv54g4i4Tc
         RGURWaRm3zpkt9+dxLg78dPNoHk2U+/WiUVpkQinmsb/VNeDd7ebqnwMmWlZ1rsLqHzI
         7H4RRF3Lj1htMlbQw8bLDgAsLY/ya6U4Uu13TvGiWCSLQiILqnxbdXegqG7hh9lI4FsT
         1i/vKxL2oKhgKYkKW5GVzQ/ujmNJxhIr0uon+Nsg0FlRMHzXR4Np7NeJwfF1+E6x7wuI
         HiUQ==
X-Gm-Message-State: APjAAAVE/9WGY2imVNOH6K851+iiKXG0DZejuPlDTpg6DrrcKBDKulJX
        riEpOgTW4tQTqgiaULB8UDErkw==
X-Google-Smtp-Source: APXvYqxvWZiVSIIq1zv4nXn2LXwxu37jK4T5pigsoozMDp9eWQ6PlpkvyNJVYs8JHXKdslF1wplP2Q==
X-Received: by 2002:a17:902:2ae6:: with SMTP id j93mr16503676plb.130.1557868568753;
        Tue, 14 May 2019 14:16:08 -0700 (PDT)
Received: from localhost ([2620:15c:202:1:fa53:7765:582b:82b9])
        by smtp.gmail.com with ESMTPSA id 187sm37857pfv.174.2019.05.14.14.16.07
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 14 May 2019 14:16:08 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <CAHLCerPZ0Y-rkeMa_7BJWtR4g5af2vwfPY9FgOuvpUTJG3rf7g@mail.gmail.com>
References: <20190114184255.258318-1-mka@chromium.org> <CAHLCerP+F9AP97+qVCMqwu-OMJXRhwZrXd33Wk-vj5eyyw-KyA@mail.gmail.com> <CAHLCerPZ0Y-rkeMa_7BJWtR4g5af2vwfPY9FgOuvpUTJG3rf7g@mail.gmail.com>
From:   Stephen Boyd <swboyd@chromium.org>
Subject: Re: [PATCH] arm64: dts: sdm845: Add CPU topology
Cc:     Andy Gross <andy.gross@linaro.org>,
        David Brown <david.brown@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        "open list:ARM/QUALCOMM SUPPORT" <linux-soc@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>,
        Douglas Anderson <dianders@chromium.org>,
        Rajendra Nayak <rnayak@codeaurora.org>
To:     Amit Kucheria <amit.kucheria@linaro.org>,
        Matthias Kaehlcke <mka@chromium.org>
Message-ID: <155786856719.14659.2902538189660269078@swboyd.mtv.corp.google.com>
User-Agent: alot/0.8
Date:   Tue, 14 May 2019 14:16:07 -0700
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Amit Kucheria (2019-05-13 04:54:12)
> On Mon, May 13, 2019 at 4:31 PM Amit Kucheria <amit.kucheria@linaro.org> =
wrote:
> >
> > On Tue, Jan 15, 2019 at 12:13 AM Matthias Kaehlcke <mka@chromium.org> w=
rote:
> > >
> > > The 8 CPU cores of the SDM845 are organized in two clusters of 4 big
> > > ("gold") and 4 little ("silver") cores. Add a cpu-map node to the DT
> > > that describes this topology.
> >
> > This is partly true. There are two groups of gold and silver cores,
> > but AFAICT they are in a single cluster, not two separate ones. SDM845
> > is one of the early examples of ARM's Dynamiq architecture.
> >
> > > Signed-off-by: Matthias Kaehlcke <mka@chromium.org>
> >
> > I noticed that this patch sneaked through for this merge window but
> > perhaps we can whip up a quick fix for -rc2?
> >
>=20
> And please find attached a patch to fix this up. Andy, since this
> hasn't landed yet (can we still squash this into the original patch?),
> I couldn't add a Fixes tag.
>=20

I had the same concern. Thanks for catching this. I suspect this must
cause some problem for IPA given that it can't discern between the big
and little "power clusters"?

Either way,

Reviewed-by: Stephen Boyd <swboyd@chromium.org>

