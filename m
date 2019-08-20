Return-Path: <SRS0=Exau=WQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EEE0DC3A589
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Aug 2019 15:52:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C15B3205ED
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Aug 2019 15:52:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1566316364;
	bh=zPFkoWhazwcOswQIN11F8cssHIWjMjC+C4+Eu5Mdx+0=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=fvS9iDmQ2rRwejfRKubFDepUyIE7uSXzLlLL6cwg83u9EFsz6kcZLSlN83CHBcHBX
	 eRhgdf+Td8pQw8KPHdcKTFgMVU1PJu3JxPs7StACDHNQZt6j9nZAJ4j/Hh/O9CLErk
	 nFuHdPS+9qsUO1Ty+4ttpiMoG+HFEuqBn9+3oIoY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730453AbfHTPwn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 20 Aug 2019 11:52:43 -0400
Received: from mail.kernel.org ([198.145.29.99]:59410 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727077AbfHTPwn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Aug 2019 11:52:43 -0400
Received: from mail-qt1-f178.google.com (mail-qt1-f178.google.com [209.85.160.178])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1706D22DBF;
        Tue, 20 Aug 2019 15:52:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1566316362;
        bh=zPFkoWhazwcOswQIN11F8cssHIWjMjC+C4+Eu5Mdx+0=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=ORMIJlxQPFacuquMw7UB2DxzpaaTlObm4ySkNhhB/hNiv5/0fvois8SDaC4TfL/uN
         WL+ih+nxz4DVDaqLRHtNoT57fb+la/+wSGO/Pch8t+HRK08tGpL/+bGSggDTFRfAka
         KNrnzjF1pNUwWnI/quOFditGLxfVIBDIkedLKuHs=
Received: by mail-qt1-f178.google.com with SMTP id l9so6570333qtu.6;
        Tue, 20 Aug 2019 08:52:42 -0700 (PDT)
X-Gm-Message-State: APjAAAU4nVs57qLPSTaHKiKk9Sy4AaSi07hQxS8Dg62WavYuDxqDZ3ka
        3NsYn2DLFOjj+wBDxc6zvhWD3X8oVNR+/qFEkg==
X-Google-Smtp-Source: APXvYqwtJUmVtro6jUEBE02WMEyBqqIruc8G65ghUIvXNND3CcohL1oCB2ITHWFckP8WQC8dUJVX22usvAwBDybS4VY=
X-Received: by 2002:ac8:7593:: with SMTP id s19mr26870702qtq.136.1566316361289;
 Tue, 20 Aug 2019 08:52:41 -0700 (PDT)
MIME-Version: 1.0
References: <20190819182619.29065-1-mripard@kernel.org> <20190820081525.celdosrgcvwoq6e7@gofer.mess.org>
 <20190820095028.l74sfvipwjjla6kq@flea>
In-Reply-To: <20190820095028.l74sfvipwjjla6kq@flea>
From:   Rob Herring <robh+dt@kernel.org>
Date:   Tue, 20 Aug 2019 10:52:29 -0500
X-Gmail-Original-Message-ID: <CAL_JsqJaH5wWCHScNZwN4jxqY5Q_UDZLnq+fghecBgYY752Lnw@mail.gmail.com>
Message-ID: <CAL_JsqJaH5wWCHScNZwN4jxqY5Q_UDZLnq+fghecBgYY752Lnw@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] dt-bindings: media: Add YAML schemas for the
 generic RC bindings
To:     Maxime Ripard <mripard@kernel.org>
Cc:     Sean Young <sean@mess.org>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Linux Media Mailing List <linux-media@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Chen-Yu Tsai <wens@csie.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Frank Rowand <frowand.list@gmail.com>,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>, devicetree@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 20, 2019 at 4:50 AM Maxime Ripard <mripard@kernel.org> wrote:
>
> Hi Sean,
>
> On Tue, Aug 20, 2019 at 09:15:26AM +0100, Sean Young wrote:
> > On Mon, Aug 19, 2019 at 08:26:18PM +0200, Maxime Ripard wrote:
> > > From: Maxime Ripard <maxime.ripard@bootlin.com>
> > >
> > > The RC controllers have a bunch of generic properties that are needed in a
> > > device tree. Add a YAML schemas for those.
> > >
> > > Reviewed-by: Rob Herring <robh@kernel.org>
> > > Signed-off-by: Maxime Ripard <maxime.ripard@bootlin.com>
> >
> > For the series (both 1/2 and 2.2):
> >
> > Reviewed-by: Sean Young <sean@mess.org>
> >
> > How's tree should this go through?
>
> Either yours or Rob's, I guess?

Sean's because there are other changes to
Documentation/devicetree/bindings/media/sunxi-ir.txt in -next.

Rob
