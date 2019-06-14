Return-Path: <SRS0=TKbG=UN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4C487C31E4B
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Jun 2019 19:34:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 18B7C20866
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Jun 2019 19:34:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1560540854;
	bh=wr/eQtEE3iJnSa7E2kL4Ek/lqk/4ET90JhWlyFdrqq0=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=Y+HGGnT9t7kWYQKEAYniVefodHQkSluHo7EESXC/fv5/OosW05dRNTBPYDgqNs1wy
	 q/Xd4msZ2jc0ICp79N0WnwMxrj09ETKlDdguaqN1HK3QYi7YQQ1ez/f1HfPTAbD/i2
	 2ElCDinPOG4o4t7ShpgRLOi5vMxvA++BDUmlbFjI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726338AbfFNTeB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Jun 2019 15:34:01 -0400
Received: from mail.kernel.org ([198.145.29.99]:57368 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725891AbfFNTeB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Jun 2019 15:34:01 -0400
Received: from mail-qt1-f179.google.com (mail-qt1-f179.google.com [209.85.160.179])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8E23B21841;
        Fri, 14 Jun 2019 19:34:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1560540840;
        bh=wr/eQtEE3iJnSa7E2kL4Ek/lqk/4ET90JhWlyFdrqq0=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=0VCrY966gCCbSU1OJoxYKikS7uV+UyvKh6Z+YKdA6Rt/18nh2oN2rQbw3D8LAqsHQ
         3dnyI/DMTGBZEApZZ+vU+DpxXEh01cja6RZLot4/z/r2sm8Wss1aCnqWEC01av87uo
         P3Nmz7VbabNaWzgyAbzG7n5/VnrkMbMkzX9WZD0Y=
Received: by mail-qt1-f179.google.com with SMTP id a15so3814620qtn.7;
        Fri, 14 Jun 2019 12:34:00 -0700 (PDT)
X-Gm-Message-State: APjAAAVFPEAX/8KpblyXeWsUcgUyuQm9fHzihptmQ3iklSRZKlN32Pce
        dIAGlGV605s0yLa46VBeK7G9YGsqVVvb3Uw9zA==
X-Google-Smtp-Source: APXvYqzx09ZX/6kOckWH3iuQjTw8fyB3cWhkcStX8rrUjI+l5U1sNeJAvM7cBDu9l2+/8g404HycvsxHlfGJ34QW0fU=
X-Received: by 2002:a0c:b786:: with SMTP id l6mr9951642qve.148.1560540839834;
 Fri, 14 Jun 2019 12:33:59 -0700 (PDT)
MIME-Version: 1.0
References: <20190517153223.7650-1-robh@kernel.org> <20190613224435.GA32572@bogus>
 <20190614170450.GA29654@Mani-XPS-13-9360> <5946467c-7674-de2b-a657-627cf3be42df@suse.de>
In-Reply-To: <5946467c-7674-de2b-a657-627cf3be42df@suse.de>
From:   Rob Herring <robh@kernel.org>
Date:   Fri, 14 Jun 2019 13:33:47 -0600
X-Gmail-Original-Message-ID: <CAL_JsqJoQDkqZO_4XdaQymVW0cJDXVmAPh3uieRkBjoUXeWE1w@mail.gmail.com>
Message-ID: <CAL_JsqJoQDkqZO_4XdaQymVW0cJDXVmAPh3uieRkBjoUXeWE1w@mail.gmail.com>
Subject: Re: [PATCH v3] dt-bindings: arm: Convert Actions Semi bindings to jsonschema
To:     =?UTF-8?Q?Andreas_F=C3=A4rber?= <afaerber@suse.de>
Cc:     Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>, devicetree@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 14, 2019 at 11:07 AM Andreas F=C3=A4rber <afaerber@suse.de> wro=
te:
>
> Am 14.06.19 um 19:04 schrieb Manivannan Sadhasivam:
> > On Thu, Jun 13, 2019 at 04:44:35PM -0600, Rob Herring wrote:
> >> On Fri, May 17, 2019 at 10:32:23AM -0500, Rob Herring wrote:
> >>> Convert Actions Semi SoC bindings to DT schema format using json-sche=
ma.
> >>>
> >>> Cc: "Andreas F=C3=A4rber" <afaerber@suse.de>
> >>> Cc: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> >>> Cc: Mark Rutland <mark.rutland@arm.com>
> >>> Cc: linux-arm-kernel@lists.infradead.org
> >>> Cc: devicetree@vger.kernel.org
> >>> Signed-off-by: Rob Herring <robh@kernel.org>
> >>> ---
> >>> v3:
> >>> - update MAINTAINERS
> >>>
> >>>  .../devicetree/bindings/arm/actions.txt       | 56 -----------------=
--
> >>>  .../devicetree/bindings/arm/actions.yaml      | 38 +++++++++++++
> >>>  MAINTAINERS                                   |  2 +-
> >>>  3 files changed, 39 insertions(+), 57 deletions(-)
> >>>  delete mode 100644 Documentation/devicetree/bindings/arm/actions.txt
> >>>  create mode 100644 Documentation/devicetree/bindings/arm/actions.yam=
l
> >>
> >> Ping. Please apply or modify this how you'd prefer. I'm not going to
> >> keep respinning this.
> >>
> >
> > Sorry for that Rob.
>
> Well, it was simply not clear whether we were supposed to or not. :)

I thought 'To' you and a single patch should be clear enough.

> > Andreas, are you going to take this patch? Else I'll pick it up (If you
> > want me to do the PR for next cycle)
>
> I had checked that all previous changes to the .txt file were by myself,
> so I would prefer if we not license it under GPLv2-only but under the
> same dual-license (MIT/GPLv2+) as the DTs. That modification would need
> Rob's approval then.

That's fine and dual license is preferred. Can you adjust that when
applying. Note that the preference for schema is (GPL-2.0 OR
BSD-2-Clause), but MIT/GPLv2+ is fine by me.

Rob
