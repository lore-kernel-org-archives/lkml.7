Return-Path: <SRS0=GgR0=RR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 747BDC43381
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Mar 2019 18:56:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3F3512184C
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Mar 2019 18:56:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="QD+gOgBl"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727598AbfCNS4k (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Mar 2019 14:56:40 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:47099 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727078AbfCNS4j (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Mar 2019 14:56:39 -0400
Received: by mail-pf1-f193.google.com with SMTP id s23so4442438pfe.13
        for <linux-kernel@vger.kernel.org>; Thu, 14 Mar 2019 11:56:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=24SeS932k4Lv64ugmBSo8q787ObSwCYuPwVTA5q5L8w=;
        b=QD+gOgBljNxcPAAbT0oYCfxmhC0yeQ+88x9rOhdKjv5xeQDNJUMDai7bKN5RNTZRjZ
         TH2dNpA4zJXNLMrb0dGVmr7RoVrwBhyilBLVQ5e0YSR7bFeeBSqZ5EdGv806BDP9AaIQ
         laymUfmxnxtDOJLIGBFCRQq4LeDQvWroOKaRk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=24SeS932k4Lv64ugmBSo8q787ObSwCYuPwVTA5q5L8w=;
        b=SlU6Ksl/dETsURXTiQK4GYuIBJ3DNA8vINNyGL0PNDmPAKYoHr5cKtzS1lZ3cdY+Hd
         gFFvJcB5GUgfhipCXnLS9PLzD4TJfzAGJH/h09FqqeFeRXsIUGhlWzos8AFOy2/57WeB
         l5gF9bgG9bzQQ/ZJnB9niBGJeXilOkUf1lZe5rFmQjG7HfLrmt7XQem3DKqE4hzXyJHi
         7ew4+SrS+xNdv70XA945knPb3b/+if5d9sOXTGqUSVoBBJJX+6cao7st4ELF8bosWU58
         mfxNAVXQEU2ucCt1SD2JUFJkuuQxgDDwrkP/NafbnInwPdRFzo8ObcKAATsWSRhS9HU6
         Mmog==
X-Gm-Message-State: APjAAAXXYtycS1s0Dhh5XLRM9IZ5+aWJ9YVeWdkT8bz0BUDMoseg7kGP
        qYjIfEdnbukvljHMpQSpw5gfOg==
X-Google-Smtp-Source: APXvYqydvR4Xzm9I0F0lBivmaJQHNQD1lI8kcNxjLVuM7jGe5Qtacv9mcFX879GNVgp6dXSHoMn5nQ==
X-Received: by 2002:a62:70c9:: with SMTP id l192mr50988654pfc.207.1552589798581;
        Thu, 14 Mar 2019 11:56:38 -0700 (PDT)
Received: from localhost ([2620:15c:202:1:75a:3f6e:21d:9374])
        by smtp.gmail.com with ESMTPSA id p6sm19829950pgd.69.2019.03.14.11.56.37
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 14 Mar 2019 11:56:37 -0700 (PDT)
Date:   Thu, 14 Mar 2019 11:56:37 -0700
From:   Matthias Kaehlcke <mka@chromium.org>
To:     c-hbandi@codeaurora.org
Cc:     marcel@holtmann.org, johan.hedberg@gmail.com,
        linux-kernel@vger.kernel.org, linux-bluetooth@vger.kernel.org,
        hemantg@codeaurora.org, linux-arm-msm@vger.kernel.org,
        bgodavar@codeaurora.org, anubhavg@codeaurora.org,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        devicetree@vger.kernel.org, linux-bluetooth-owner@vger.kernel.org
Subject: Re: [PATCH v3 2/2] dt-bindings: net: bluetooth: Add device tree
 bindings for QTI chip wcn3998
Message-ID: <20190314185637.GB112750@google.com>
References: <1552393379-26330-1-git-send-email-c-hbandi@codeaurora.org>
 <1552393379-26330-3-git-send-email-c-hbandi@codeaurora.org>
 <20190312165928.GD200579@google.com>
 <88a923e02073461abb5f3a7674150615@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <88a923e02073461abb5f3a7674150615@codeaurora.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Harish,

On Wed, Mar 13, 2019 at 12:00:06PM +0530, c-hbandi@codeaurora.org wrote:
> Hi Matthias,
> 
> 
> On 2019-03-12 22:29, Matthias Kaehlcke wrote:
> > +DT folks
> > 
> > Please add them in future versions (script/scripts/get_maintainer.pl
> > <patches> should have listed them)
> 
> [Harish] -- Will add them in new version of patches.
> > 
> > On Tue, Mar 12, 2019 at 05:52:59PM +0530, Harish Bandi wrote:
> > > This patch enables regulators for the Qualcomm Bluetooth wcn3998
> > > controller.
> > 
> > No, it doesn't.
> > 
> > The next version should probably say something like "Add compatible
> > string for the Qualcomm WCN3998 Bluetooth controller.
> > 
> [Harish] -- From new patch onwards will add all patch
> version changes and add proper description.
> 
> > Is there any particular reason why QCA drivers folks use 'wcn' instead
> > of 'WCN'? The QCA documentations calls it WCN399x, so I'd suggest to
> > consistently use the uppercase name in comments and documentation (and
> > log messages?).
> > 
> [Harish] -- I think in DT we need to have small case like wcn,

agreed

> i think that is the reason it started using in code, comments and dt
> documentation.

AFAIK there are no hard rules for everything, my suggestion would be:

- use WCN399x
  - for general comments/documentation
  - commit messages
  - in DT context wcn3998-n seems ok
- use wcn399x
  - for function and variable names
  - for compatible strings

For logging: whatever, just be consistent.

> > > Signed-off-by: Harish Bandi <c-hbandi@codeaurora.org>
> > > ---
> > > changes in v3:
> > > - updated to latest code base.
> > 
> > This comment is useless, please describe what changed wrt the previous
> > version.
> [Harish] --  added details in v2, and v3 uploaded just to rebase on tip of
> bluetooth-next
> for better understanding of code in review. From new patch onwards will add
> all patch
> version changes and add proper description.
> > 
> > > ---
> > >  .../devicetree/bindings/net/qualcomm-bluetooth.txt        | 15
> > > +++++++++++++++
> > >  1 file changed, 15 insertions(+)
> > > 
> > > diff --git
> > > a/Documentation/devicetree/bindings/net/qualcomm-bluetooth.txt
> > > b/Documentation/devicetree/bindings/net/qualcomm-bluetooth.txt
> > > index 824c0e2..1221535 100644
> > > --- a/Documentation/devicetree/bindings/net/qualcomm-bluetooth.txt
> > > +++ b/Documentation/devicetree/bindings/net/qualcomm-bluetooth.txt
> > > @@ -53,3 +53,18 @@ serial@898000 {
> > >  		max-speed = <3200000>;
> > >  	};
> > >  };
> > > +
> > > +&blsp1_uart3 {
> > > +	pinctrl-names = "default";
> > > +	pinctrl-0 = <&blsp1_uart3_default>;
> > > +	status = "okay";
> > > +
> > > +	bluetooth: wcn3998-bt {
> > > +		compatible = "qcom,wcn3998-bt";
> > > +		vddio-supply = <&vreg_l6_1p8>;
> > > +		vddxo-supply = <&vreg_l5_1p8>;
> > > +		vddrf-supply = <&vreg_s5_1p35>;
> > > +		vddch0-supply = <&vdd_ch0_3p3>;
> > > +		max-speed = <3200000>;
> > > +	};
> > > +};
> > > \ No newline at end of file
> > 
> > I think the example isn't really needed since it's essentially the
> > same as the one for 'qcom,wcn3990-bt'.
> > 
> > But the important part is missing: add the new compatible string under
> > ´Required properties´. You also want to update the documentation that
> > mentiones 'qcom,wcn3990-bt' to 'qcom,wcn399x-bt' (assuming for now
> > that other possible WCN399x chips would be similar).
> > 
> [Harish] -- Will check the DT properties, documentation and update
> accordingly in new patch.
> 
> > You mentioned in an earlier version of the series that there are
> > multiple WCN3998 variants with different requirements for
> > voltage/current. This seems to suggests that multiple compatible
> > strings are needed to distinguish between them.
> > 
> [Harish] -- for now we want to add WCN3998 support only, What i mean to say
> in my earlier
> explanation that. WCN3990 is base variant and on top of that we have
> variants like WCN3990,
> WCN3998 and WCN3998-0,WCN3998-1 like that..
> So I think wcn399x would make sense for this series.

If the variants have relevant differences between them (like different
regulator requirements) I think you want unique names, rather than
'wcn399x' (I was referring to comments/documentation with this
string).

If there are variants wouldn't your first 'wcn3998' already be a
'wcn3998-n'? If 'wcn3998' without suffix is used I think it needs to
be valid for all 'wcn3998-n' variants (it might be less
power-efficient though than using the variant specific compatible
string), otherwise things get confusing (a 'wcn3998-2' isn't a
'wcn3998'?)

Thanks

Matthias
