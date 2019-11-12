Return-Path: <SRS0=WT+Y=ZE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 06798C43331
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Nov 2019 12:52:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D04D021925
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Nov 2019 12:52:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="JZurKRZa"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727265AbfKLMwF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Nov 2019 07:52:05 -0500
Received: from mail-wr1-f65.google.com ([209.85.221.65]:35966 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727226AbfKLMwF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Nov 2019 07:52:05 -0500
Received: by mail-wr1-f65.google.com with SMTP id r10so18420100wrx.3
        for <linux-kernel@vger.kernel.org>; Tue, 12 Nov 2019 04:52:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=DfqsINWcKRc1MYWJGKjYzKaRLCYqntpX7pPTW5be6v8=;
        b=JZurKRZavYoqZvTK8TYEOfMp8VH/5C7m8TY48CKwOmV3hBKrhPlVg1tBdkkcFCy1w/
         BG69ixJjZDMO+yF9cpoD/91wQHlTRSpADi14ByabcYww6P6rhM8Aj5quMfYt4W8kWQzU
         MB8EE8hCBtuRI5mK4Fz6oC4KB6d0/YxN5ou/oMy1STwaW/h3AxEQBU4GVFgQHAT+nwFZ
         UhCSJH6OONjnIPksILrZAqK2Ws8/TaJWHI7pViKN2mro0ykZm44fN6VCJpsqyUYqA5SX
         FUDlUOxLAs5j3AL2NLIo+3d4vIc0davaaD68wUuR23kB0U8Z+7YsxTMba66PjtUlBI8s
         DQDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=DfqsINWcKRc1MYWJGKjYzKaRLCYqntpX7pPTW5be6v8=;
        b=i8H7FjY3B0CXygEkfMNjRXEbdkRJlaFrqtFrKvpR1RUp050xnzruHzRPJ53hVKEPnO
         IKip661THUHI+v51nHwTTvxgMhO5b4OSEkasUg5xs3G02DctoJPCrq0DkJgYiaV0mAXS
         n8meqcUxI9Wi6rIS6Sw5TIvHBu+J6DtSkSJwXxIhdoCGlfFEFpGze2rBtUdu+T0AWcPD
         XZAuxzObKWTvfU17bhh0/tsEdQvfiVpLSAQchjV9JzlsBt+wV03wGUI34mkuIdqV0qPY
         Zcg9gIkX7P4cOsYH4EHHPm/JR7WlpibzmXYqTcfivtmDR/hkKuPlHYRX9T5HhMSzBpk2
         ZKMQ==
X-Gm-Message-State: APjAAAXZItqgAlBDupXL/jVHxHcOlGieROLi1jtcGn5Ii4ehFMXfDOKL
        dLBoSSkQim65OfVDRXT80G+UCg==
X-Google-Smtp-Source: APXvYqy8EPY5Xwbb23COpmy3eka/7lqjG/CvbJl3rvQUdnzvWRC1PyYLCax49eM+z+H5f84muASU4g==
X-Received: by 2002:adf:c402:: with SMTP id v2mr27337084wrf.323.1573563124065;
        Tue, 12 Nov 2019 04:52:04 -0800 (PST)
Received: from Red ([2a01:cb1d:147:7200:2e56:dcff:fed2:c6d6])
        by smtp.googlemail.com with ESMTPSA id a6sm2771583wmj.1.2019.11.12.04.52.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Nov 2019 04:52:03 -0800 (PST)
Date:   Tue, 12 Nov 2019 13:51:59 +0100
From:   LABBE Corentin <clabbe@baylibre.com>
To:     Maxime Ripard <mripard@kernel.org>
Cc:     mark.rutland@arm.com, robh+dt@kernel.org, wens@csie.org,
        jernej.skrabec@siol.net, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-sunxi@googlegroups.com
Subject: Re: [PATCH v4 1/2] ARM64: dts: sun50i-h6-pine-h64: state that the DT
 supports the modelA
Message-ID: <20191112125159.GC18647@Red>
References: <1573316433-40669-1-git-send-email-clabbe@baylibre.com>
 <1573316433-40669-2-git-send-email-clabbe@baylibre.com>
 <20191112120219.GX4345@gilmour.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191112120219.GX4345@gilmour.lan>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 12, 2019 at 01:02:19PM +0100, Maxime Ripard wrote:
> Hi,
> 
> On Sat, Nov 09, 2019 at 04:20:32PM +0000, Corentin Labbe wrote:
> > The current sun50i-h6-pine-h64 DT does not specify which model (A or B)
> > it supports.
> > When this file was created, only modelA was existing, but now both model
> > exists and with the time, this DT drifted to support the model B since it is
> > the most common one.
> > Furtheremore, some part of the model A does not work with it like ethernet and
> > HDMI connector (as confirmed by Jernej on IRC).
> >
> > So it is time to settle the issue, and the easiest way was to state that
> > this DT is for model B.
> > Easiest since only a small name changes is required.
> > Doing the opposite (stating this file is for model A) will add changes (for
> > ethernet and HDMI) and so, will break too many setup.
> >
> > But as asked by the maintainer this patch state this file is for model A.
> > In the process this patch adds the missing compoments to made it work on
> > model A.
> >
> > Signed-off-by: Corentin Labbe <clabbe@baylibre.com>
> > ---
> >  .../devicetree/bindings/arm/sunxi.yaml        |  4 ++--
> >  .../boot/dts/allwinner/sun50i-h6-pine-h64.dts | 19 +++++++++++++++----
> >  2 files changed, 17 insertions(+), 6 deletions(-)
> >
> > diff --git a/Documentation/devicetree/bindings/arm/sunxi.yaml b/Documentation/devicetree/bindings/arm/sunxi.yaml
> > index 8a1e38a1d7ab..b8ec616c2538 100644
> > --- a/Documentation/devicetree/bindings/arm/sunxi.yaml
> > +++ b/Documentation/devicetree/bindings/arm/sunxi.yaml
> > @@ -599,9 +599,9 @@ properties:
> >            - const: pine64,pine64-plus
> >            - const: allwinner,sun50i-a64
> >
> > -      - description: Pine64 PineH64
> > +      - description: Pine64 PineH64 model A
> >          items:
> > -          - const: pine64,pine-h64
> > +          - const: pine64,pine-h64-modelA
> 
> You can change the description to make it more obvious if you want to,
> but changing the compatible is a no-go.
> 
> >            - const: allwinner,sun50i-h6
> >
> >        - description: Pine64 LTS
> > diff --git a/arch/arm64/boot/dts/allwinner/sun50i-h6-pine-h64.dts b/arch/arm64/boot/dts/allwinner/sun50i-h6-pine-h64.dts
> > index 74899ede00fb..1d9afde4d3d7 100644
> > --- a/arch/arm64/boot/dts/allwinner/sun50i-h6-pine-h64.dts
> > +++ b/arch/arm64/boot/dts/allwinner/sun50i-h6-pine-h64.dts
> > @@ -10,8 +10,8 @@
> >  #include <dt-bindings/gpio/gpio.h>
> >
> >  / {
> > -	model = "Pine H64";
> > -	compatible = "pine64,pine-h64", "allwinner,sun50i-h6";
> > +	model = "Pine H64 model A";
> > +	compatible = "pine64,pine-h64-modelA", "allwinner,sun50i-h6";
> 
> Same thing here, changing the model is fine, the compatible isn't
> 

Hello

I will erase compatible changes in next version.

> >  	aliases {
> >  		ethernet0 = &emac;
> > @@ -22,9 +22,10 @@
> >  		stdout-path = "serial0:115200n8";
> >  	};
> >
> > -	connector {
> > +	hdmi_connector: connector {
> 
> Why do you need to add the label?
> 

For dropping the ddc-en-gpios property in model B.
If you want, I can split this line change in an extra patch.

Regards
