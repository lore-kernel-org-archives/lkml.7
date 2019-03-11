Return-Path: <SRS0=FxTY=RO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6DC1C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Mar 2019 22:06:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 80E952087C
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Mar 2019 22:06:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1552341994;
	bh=nM3KQnBbqpIc2+gMCyMyh2uahYO2VlWfsXrh8CkNld8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=mZdPWxacAc1CbJnzEePD9tnmti2FHYAnRJ868BysI6t5gI09yEicBwhDq+Xh3uUW2
	 OY0sm1fF2gdjd8SZUooYXcQCqezcMw8MMxIytFOEyMRVrewDMHmvxyfARBMVaFJxrs
	 DPQXKxvCEchRcrTGCci3bYd0ih0b7MCR0EFBcrWc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728275AbfCKWGd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Mar 2019 18:06:33 -0400
Received: from mail-ot1-f68.google.com ([209.85.210.68]:45425 "EHLO
        mail-ot1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727527AbfCKWGc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Mar 2019 18:06:32 -0400
Received: by mail-ot1-f68.google.com with SMTP id i12so621391otp.12;
        Mon, 11 Mar 2019 15:06:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=KZfuW/QqHqpiwbbZDSR+JEf1pjvJkZeqOnESC9a6lwg=;
        b=YTWN6FTsd4w8+IKiRgNy4lfMi/x6+66R9IocIW7xpi1dw2sWR8WrC6jjHaBadYqRkM
         bahW0OIsovRFbpLasAl9bDcmX5vSwUQL7DKjqHe7LaIwE5SBzBC+SuRa1/5/MY7unmIb
         GBKRZHR58mOADwSyyyXpg3NuiGQRxFkShiVQ+0hm0xO2eXZW23flTfisWxkIsTEyha1e
         +vsbfRsrrL+a6h1hrF867EYBSMcGEq2RLsYJnvoDWXu9bTlh2hO/6qGKSSH5F4dXwbo0
         zo/byCWj5wRtU4+TnH+XkgRsRh5nbP3xJn8ICAdwVhC/1WPMuAdVCo8cTvBWH/s4tQqB
         toXQ==
X-Gm-Message-State: APjAAAXkxvJt/TpMtvml+mMtaDgwRDQ/jPfuGRUJO8zZ08jDg7NbV9sK
        InI4GmSVHgrFxYbqZOIibg==
X-Google-Smtp-Source: APXvYqzlKrSBQCY0b1JmlCt33ZSwqW/5ziF1xsV/d+ZWhc+BTdGRAenpbmk8vKnC57O1WLGaABK06g==
X-Received: by 2002:a05:6830:11c9:: with SMTP id v9mr8980767otq.288.1552341991779;
        Mon, 11 Mar 2019 15:06:31 -0700 (PDT)
Received: from localhost (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id k15sm3031631otj.26.2019.03.11.15.06.30
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 11 Mar 2019 15:06:31 -0700 (PDT)
Date:   Mon, 11 Mar 2019 17:06:30 -0500
From:   Rob Herring <robh@kernel.org>
To:     Sean Wang <sean.wang@kernel.org>
Cc:     Hsin-Hsiung Wang <hsin-hsiung.wang@mediatek.com>,
        Lee Jones <lee.jones@linaro.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Eddie Huang <eddie.huang@mediatek.com>,
        linux-rtc@vger.kernel.org, devicetree@vger.kernel.org,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        srv_heupstream <srv_heupstream@mediatek.com>,
        Alessandro Zummo <a.zummo@towertech.it>,
        Marc Zyngier <marc.zyngier@arm.com>,
        Sean Wang <sean.wang@mediatek.com>,
        linux-kernel@vger.kernel.org, Liam Girdwood <lgirdwood@gmail.com>,
        linux-mediatek@lists.infradead.org,
        Mark Rutland <mark.rutland@arm.com>,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v2 3/9] dt-bindings: mfd: Add compatible for the MediaTek
 MT6358 PMIC
Message-ID: <20190311220630.GA4082@bogus>
References: <1552275991-34648-1-git-send-email-hsin-hsiung.wang@mediatek.com>
 <1552275991-34648-4-git-send-email-hsin-hsiung.wang@mediatek.com>
 <CAGp9LzrWawWy+mX5VpLeqdV85f0iEdRv6JtJbjS5pamN5xfKjA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAGp9LzrWawWy+mX5VpLeqdV85f0iEdRv6JtJbjS5pamN5xfKjA@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 11, 2019 at 12:19:32PM -0700, Sean Wang wrote:
> Hi,
> 
> Always put the patches about dt-binding changes at the head of the
> series to let the related maintainer more easily find them.
> 
> On Sun, Mar 10, 2019 at 8:48 PM Hsin-Hsiung Wang
> <hsin-hsiung.wang@mediatek.com> wrote:
> >
> > This adds compatible for the MediaTek MT6358 PMIC.
> >
> > Signed-off-by: Hsin-Hsiung Wang <hsin-hsiung.wang@mediatek.com>
> > ---
> >  Documentation/devicetree/bindings/mfd/mt6397.txt | 11 ++++++++---
> >  1 file changed, 8 insertions(+), 3 deletions(-)
> >
> > diff --git a/Documentation/devicetree/bindings/mfd/mt6397.txt b/Documentation/devicetree/bindings/mfd/mt6397.txt
> > index 0ebd08a..62f1c17 100644
> > --- a/Documentation/devicetree/bindings/mfd/mt6397.txt
> > +++ b/Documentation/devicetree/bindings/mfd/mt6397.txt
> > @@ -17,22 +17,27 @@ Documentation/devicetree/bindings/soc/mediatek/pwrap.txt
> >  This document describes the binding for MFD device and its sub module.
> >
> >  Required properties:
> > -compatible: "mediatek,mt6397" or "mediatek,mt6323"
> > +compatible:
> > +       "mediatek,mt6323" for PMIC MT6323
> > +       "mediatek,mt6358" for PMIC MT6358
> > +       "mediatek,mt6397" for PMIC MT6397
> 
> don't change anything not related MT6358

Reformatting like this is preferred.

Rob
