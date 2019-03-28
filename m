Return-Path: <SRS0=Qu8K=R7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14CA7C10F03
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Mar 2019 17:39:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CFE3020823
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Mar 2019 17:39:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1553794768;
	bh=wBsyo3nDuPTBwGgVWSG9805Qn9gDNN4O5soEfYx4iSg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=me9lrhLWbYy+A1Zq/sKBOMmbM76dcAAEfCGzCMbjBJMfVjyOPpnzfMR0qPMb+naMI
	 u7k2+uImUzEMb3by+NDW92YYXtDGlAe7QsXXKQ7PJf/PmL6EHYp9LRXLpqlDV2Fs3H
	 fEg2tDXVxsVeCF/aC9XX1kqiJIm6WW6+LajJ2zd4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727413AbfC1Rj1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Mar 2019 13:39:27 -0400
Received: from mail-oi1-f195.google.com ([209.85.167.195]:38642 "EHLO
        mail-oi1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725816AbfC1Rj1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Mar 2019 13:39:27 -0400
Received: by mail-oi1-f195.google.com with SMTP id w137so16454936oiw.5;
        Thu, 28 Mar 2019 10:39:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=X8T2Mq9pFzdl/B0J7bAykbJ2mPCP8DjHSrnwsePCTHQ=;
        b=MzQwYMSTH1XK5FQOfGjKmL54vggzMqyWZ2xdKAXk0r8/Zyv0+SrQQ9iwjngZQZmDna
         z4NQqkzPHbDLsc9QPIKTCzzt8Qpi+e9gBlMribxKO+2rT8TkXfUmuKZwMswnOwQmInTg
         e2fi/2gZHmV61sPGPpmHN+myPMqWrlxKVOQbSItsziLkRJHInSvwaagRqoukCYarXi+P
         pHymcElk7YITF/2k9x4uZVlnEnhLerjjsdIwjQAnnT7tHPOyShd4ISQ6qzfSaQE708xE
         QpUMfW1DIwaxsTWkniQZyjAj+KsfCf7RJZqp0BDrXY+XrsLkKeJdOMoVy49IgdiAsVTC
         Bapw==
X-Gm-Message-State: APjAAAUrjezHiAdtLwNS4U3JQDEJz6buCKdsdfVQo9qJ0DTyp6Y5sVUL
        Wp1A8kLR/lk+lhmd17UEOw==
X-Google-Smtp-Source: APXvYqz8Es3V63WBpwwjWRlpdI5C+DnnKkvdzjK03MWI7E/au2UaS2fOpWvL9ib03xWPVagYZJbBqQ==
X-Received: by 2002:aca:c505:: with SMTP id v5mr781576oif.111.1553794766065;
        Thu, 28 Mar 2019 10:39:26 -0700 (PDT)
Received: from localhost (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id 42sm6629241otg.10.2019.03.28.10.39.24
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 28 Mar 2019 10:39:25 -0700 (PDT)
Date:   Thu, 28 Mar 2019 12:39:24 -0500
From:   Rob Herring <robh@kernel.org>
To:     Gregory CLEMENT <gregory.clement@bootlin.com>
Cc:     Stephen Boyd <sboyd@codeaurora.org>,
        Mike Turquette <mturquette@baylibre.com>,
        linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, Jason Cooper <jason@lakedaemon.net>,
        Andrew Lunn <andrew@lunn.ch>,
        Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        linux-arm-kernel@lists.infradead.org,
        Antoine Tenart <antoine.tenart@bootlin.com>,
        =?iso-8859-1?Q?Miqu=E8l?= Raynal <miquel.raynal@bootlin.com>,
        Maxime Chevallier <maxime.chevallier@bootlin.com>
Subject: Re: [PATCH v4 1/6] dt-bindings: ap806: add the cluster clock node in
 the syscon file
Message-ID: <20190328173924.GB26680@bogus>
References: <20190325124803.28904-1-gregory.clement@bootlin.com>
 <20190325124803.28904-2-gregory.clement@bootlin.com>
 <20190328171350.GA26680@bogus>
 <87k1gioqrp.fsf@FE-laptop>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87k1gioqrp.fsf@FE-laptop>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 28, 2019 at 06:25:14PM +0100, Gregory CLEMENT wrote:
> Hi Rob,
>  
>  On jeu., mars 28 2019, Rob Herring <robh@kernel.org> wrote:
> 
> > On Mon, Mar 25, 2019 at 01:47:58PM +0100, Gregory CLEMENT wrote:
> >> Document the device tree binding for the cluster clock controllers found
> >> in the Armada 7K/8K SoCs.
> >> 
> >> Signed-off-by: Gregory CLEMENT <gregory.clement@bootlin.com>
> >> ---
> >>  .../arm/marvell/ap806-system-controller.txt   | 25 +++++++++++++++++++
> >>  1 file changed, 25 insertions(+)
> >> 
> >> diff --git a/Documentation/devicetree/bindings/arm/marvell/ap806-system-controller.txt b/Documentation/devicetree/bindings/arm/marvell/ap806-system-controller.txt
> >> index 7b8b8eb0191f..ceeba18b4ac3 100644
> >> --- a/Documentation/devicetree/bindings/arm/marvell/ap806-system-controller.txt
> >> +++ b/Documentation/devicetree/bindings/arm/marvell/ap806-system-controller.txt
> >> @@ -143,3 +143,28 @@ ap_syscon1: system-controller@6f8000 {
> >>  		#thermal-sensor-cells = <1>;
> >>  	};
> >>  };
> >> +
> >> +Cluster clocks:
> >> +---------------
> >> +
> >> +Device Tree Clock bindings for cluster clock of AP806 Marvell. Each
> >> +cluster contain up to 2 CPUs running at the same frequency.
> >> +
> >> +Required properties:
> >> +- compatible: must be  "marvell,ap806-cpu-clock";
> >> +- #clock-cells : should be set to 1.
> >> +- clocks : shall be the input parents clock phandle for the clock.
> >> +
> >> +Optional property:
> >> + - reg: register range associated the cluser clocks
> >
> > reg can be optional to use, but should either be there or not.
> 
> OK so let's remove it!

If you can define what the registers are, then you should have it even 
if Linux happens to not care.

Rob
