Return-Path: <SRS0=2mSC=W2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 99E1CC3A59B
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Aug 2019 16:43:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6BB492087F
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Aug 2019 16:43:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="nJl4ZiCx"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728353AbfH3Qn1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 30 Aug 2019 12:43:27 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:43258 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728086AbfH3Qn1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Aug 2019 12:43:27 -0400
Received: by mail-pf1-f196.google.com with SMTP id v12so4970469pfn.10
        for <linux-kernel@vger.kernel.org>; Fri, 30 Aug 2019 09:43:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=q5gzUFH+LLr1GeRh8d61wQ5ZxK6DUtBvBFz6N7zeYQ8=;
        b=nJl4ZiCxYAu6twY2dIZpt6JBzmYgk4PbodtyM2DHZYiWFm3VZFwCvg9Zw15krklbGj
         eaWHPK+cFBBCGA0j/4A0Yfzho/8xw6VmQkabo5OzbrYcK6qaR5aXh3iUDQWfcbGoSu4Z
         poGclGdOBZhYYd8+6uSeM3dZ20P5jKdpWSYWZDeWh0gjHX+CjnUJf5w/keLKJbxMc+Db
         kBHpAtM1aMNqaSEcg0LPKmRILXrjtbQDjXBBGQeb07g4YwZYcaIKzfRZ4xBW+3ZkhVds
         zzBzYUC+cW02dZjQEYEUijUVJcsCfQkm2xhgu3ItpChGSLeorMLGu1WORzMS/Er5okqr
         2pyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=q5gzUFH+LLr1GeRh8d61wQ5ZxK6DUtBvBFz6N7zeYQ8=;
        b=iQN2VmCgyf4wCG13oYewGq1ilZWtIHZSUvXYAYhRzINwliWGZmbLSB2+15zkVZP0uO
         bEfJgq8hjbuHOjW1SHOLD6dPPyJLRjiBeytb5acnkPSWSX8MMNL2baVjbgG0+LSSKpqd
         77oIxM+DgEg2dJlK2jg78TSG9/KLCqTJrhIx9mWZ0zAHpNMDYXjoEU9f496eobFqiUGz
         rygY7mb02ZPG8MN4MR3Zvejo5nKIXl8mEf04yxww4gSU9+AwFU1Q6iwZ6vJe1TIXqHX8
         YuqxdHiovY3F+FG9bJ+CEXawCdQnP+T3B8fI2Vc+lHM4MrcrgqkjzQxzeAvHMH7B6WAs
         0J3g==
X-Gm-Message-State: APjAAAUGXPClpOd8B69QKOkdHsLgJzvtVxjHjVCVstUyZw4McElUvzpB
        q8n8nLi5wT9BI6Jca14RjHRv9w==
X-Google-Smtp-Source: APXvYqyWTZbyunakxQlyU8+azoFn/fVvPZoIev3hecPMzx3XNAaoIo+T2UrpOj7TfS4xJn93lMOOzQ==
X-Received: by 2002:a63:188:: with SMTP id 130mr13572573pgb.231.1567183406399;
        Fri, 30 Aug 2019 09:43:26 -0700 (PDT)
Received: from tuxbook-pro (104-188-17-28.lightspeed.sndgca.sbcglobal.net. [104.188.17.28])
        by smtp.gmail.com with ESMTPSA id c9sm8573589pfb.43.2019.08.30.09.43.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Aug 2019 09:43:25 -0700 (PDT)
Date:   Fri, 30 Aug 2019 09:45:20 -0700
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Stephen Boyd <swboyd@chromium.org>
Cc:     Jorge Ramirez <jorge.ramirez-ortiz@linaro.org>, robh@kernel.org,
        andy.gross@linaro.org, shawn.guo@linaro.org,
        gregkh@linuxfoundation.org, mark.rutland@arm.com, kishon@ti.com,
        jackp@codeaurora.org, devicetree@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        khasim.mohammed@linaro.org
Subject: Re: [PATCH v4 3/4] dt-bindings: Add Qualcomm USB SuperSpeed PHY
 bindings
Message-ID: <20190830164520.GK26807@tuxbook-pro>
References: <20190207111734.24171-1-jorge.ramirez-ortiz@linaro.org>
 <20190207111734.24171-4-jorge.ramirez-ortiz@linaro.org>
 <20190223165218.GB572@tuxbook-pro>
 <6dc0957d-5806-7643-4454-966015865d38@linaro.org>
 <5d694878.1c69fb81.5f13b.ec4f@mx.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5d694878.1c69fb81.5f13b.ec4f@mx.google.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri 30 Aug 09:01 PDT 2019, Stephen Boyd wrote:

> Quoting Jorge Ramirez (2019-08-29 00:03:48)
> > On 2/23/19 17:52, Bjorn Andersson wrote:
> > > On Thu 07 Feb 03:17 PST 2019, Jorge Ramirez-Ortiz wrote:
> > >> +
> > >> +Required child nodes:
> > >> +
> > >> +- usb connector node as defined in bindings/connector/usb-connector.txt
> > >> +  containing the property vbus-supply.
> > >> +
> > >> +Example:
> > >> +
> > >> +usb3_phy: usb3-phy@78000 {
> > >> +    compatible = "qcom,snps-usb-ssphy";
> > >> +    reg = <0x78000 0x400>;
> > >> +    #phy-cells = <0>;
> > >> +    clocks = <&rpmcc RPM_SMD_LN_BB_CLK>,
> > >> +             <&gcc GCC_USB_HS_PHY_CFG_AHB_CLK>,
> > >> +             <&gcc GCC_USB3_PHY_PIPE_CLK>;
> > >> +    clock-names = "ref", "phy", "pipe";
> > >> +    resets = <&gcc GCC_USB3_PHY_BCR>,
> > >> +             <&gcc GCC_USB3PHY_PHY_BCR>;
> > >> +    reset-names = "com", "phy";
> > >> +    vdd-supply = <&vreg_l3_1p05>;
> > >> +    vdda1p8-supply = <&vreg_l5_1p8>;
> > >> +    usb3_c_connector: usb3-c-connector {
> 
> Node name should be 'connector', not usb3-c-connector.
> 

It probably has to be usb-c-connector, because we have a
micro-usb-connector on the same board.

> > > 
> > > The USB-C connector is attached both to the HS and SS PHYs, so I think
> > > you should represent this external to this node and use of_graph to
> > > query it.
> > 
> > but AFAICS we wont be able to retrieve the vbux-supply from an external
> > node (that interface does not exist).
> > 
> > rob, do you have a suggestion?
> 
> Shouldn't the vbus supply be in the phy? Or is this a situation where
> the phy itself doesn't have the vbus supply going to it because the PMIC
> gets in the way and handles the vbus for the connector by having the SoC
> communicate with the PMIC about when to turn the vbus on and off, etc?
> 

That's correct, the VBUS comes out of the PMIC and goes directly to the
connector.

The additional complicating factor here is that the connector is wired
to a USB2 phy as well, so we need to wire up detection and vbus control
to both of them - but I think this will be fine, if we can only figure
out a sane way of getting hold of the vbus-supply.

Regards,
Bjorn
