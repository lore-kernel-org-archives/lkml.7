Return-Path: <SRS0=RWM+=ZG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31651C43141
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Nov 2019 00:06:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 428B4206D8
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Nov 2019 00:06:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1573689998;
	bh=4Upn+v/Ef+ac/mWELV1j3G2nQNGiE1YmdWUT6I+a/YY=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=ZFDH8YvAVEg78Yhn3adrVQLs87NVQ+GbaEuja0uHcISqGwoZ3tb/aWL8evstWag2s
	 EcFiW0DiSEWTwUVyAUf4vGIfm5IkyfLSKcI1fZpQYuEuylYGwLnyce7jpSQKorFomq
	 r47whxBVyrE1xAUKCbc40jW7/QWpwxbpct++Id6M=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727016AbfKNAGg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Nov 2019 19:06:36 -0500
Received: from mail.kernel.org ([198.145.29.99]:45860 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726969AbfKNAGf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Nov 2019 19:06:35 -0500
Received: from mail-qk1-f172.google.com (mail-qk1-f172.google.com [209.85.222.172])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 09D45206D8;
        Thu, 14 Nov 2019 00:06:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1573689995;
        bh=4Upn+v/Ef+ac/mWELV1j3G2nQNGiE1YmdWUT6I+a/YY=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=QPHQmVNHSaAUtsLSMbhog2Zz0T99otIqW6eG6qP9F1/Tk+TZlQmw47aixxHspcvnx
         AgCKMKyF7KRRJpSZaLNcpBkg8Pz7UCQveCpxEP6nboMIQYXVZVfptYExce9B5g/V5D
         YVtkuA9Iyc2ZNpL3uVPDqEwBXWI+yoNjg/4wE7rs=
Received: by mail-qk1-f172.google.com with SMTP id m4so3457083qke.9;
        Wed, 13 Nov 2019 16:06:34 -0800 (PST)
X-Gm-Message-State: APjAAAXCvGar8LtoNsxCa9kwvJS+cN8+zR7j/MNkrMHhZ+1rMUdPhvt8
        3uovndyMsdsBVr7yJJAccC23BWnsCYhOP53tTw==
X-Google-Smtp-Source: APXvYqz5e4wLJrkAmKi09szt8TeDeO5fe8u6LM+XooNZR3qMRtLRZfSA4Jj/LlV3cQU4ZdvZYSE+xNKZ9QKMYjvYptM=
X-Received: by 2002:a37:4904:: with SMTP id w4mr4748065qka.119.1573689993895;
 Wed, 13 Nov 2019 16:06:33 -0800 (PST)
MIME-Version: 1.0
References: <20191111090230.3402-1-chunyan.zhang@unisoc.com>
 <20191111090230.3402-5-chunyan.zhang@unisoc.com> <20191112005600.GA9055@bogus>
 <CAAfSe-uohXXHyQ7txhPmLCpyQODDHAuxjuUVbGcwYySN6G9tNQ@mail.gmail.com>
In-Reply-To: <CAAfSe-uohXXHyQ7txhPmLCpyQODDHAuxjuUVbGcwYySN6G9tNQ@mail.gmail.com>
From:   Rob Herring <robh@kernel.org>
Date:   Wed, 13 Nov 2019 18:06:22 -0600
X-Gmail-Original-Message-ID: <CAL_JsqLUkaL=dq0Nrdcax3KG7TXW3LErHTSONa9mH2gXu4du9w@mail.gmail.com>
Message-ID: <CAL_JsqLUkaL=dq0Nrdcax3KG7TXW3LErHTSONa9mH2gXu4du9w@mail.gmail.com>
Subject: Re: [PATCH v2 4/5] dt-bindings: serial: Add a new compatible string
 for SC9863A
To:     Chunyan Zhang <zhang.lyra@gmail.com>
Cc:     Chunyan Zhang <chunyan.zhang@unisoc.com>,
        Mark Rutland <mark.rutland@arm.com>,
        DTML <devicetree@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Orson Zhai <orsonzhai@gmail.com>,
        Baolin Wang <baolin.wang7@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 11, 2019 at 7:38 PM Chunyan Zhang <zhang.lyra@gmail.com> wrote:
>
> On Tue, 12 Nov 2019 at 08:56, Rob Herring <robh@kernel.org> wrote:
> >
> > On Mon, 11 Nov 2019 17:02:29 +0800, Chunyan Zhang wrote:
> > >
> > > SC9863A use the same serial device which SC9836 uses.
> > >
> > > Signed-off-by: Chunyan Zhang <chunyan.zhang@unisoc.com>
> > > ---
> > >  Documentation/devicetree/bindings/serial/sprd-uart.yaml | 1 +
> > >  1 file changed, 1 insertion(+)
> > >
> >
> > Please add Acked-by/Reviewed-by tags when posting new versions. However,
>
> Yes, I know.
>
> > there's no need to repost patches *only* to add the tags. The upstream
> > maintainer will do that for acks received on the version they apply.
> >
> > If a tag was not added on purpose, please state why and what changed.
>
> The reason was that I switched to yaml rather than txt in last version
> which recieved your Acked-by.
> Not sure for this kind of case I can still add your Acked-by.

This was a semi-automated reply. I do review it first, but if the
changelog is not in the patch I may miss the reason.

Anyways,

Acked-by: Rob Herring <robh@kernel.org>
