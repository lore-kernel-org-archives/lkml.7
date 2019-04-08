Return-Path: <SRS0=N68d=SK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 939B7C10F13
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Apr 2019 14:07:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 53C0A20883
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Apr 2019 14:07:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="N7/BWVsk"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726838AbfDHOHe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Apr 2019 10:07:34 -0400
Received: from mail-yb1-f194.google.com ([209.85.219.194]:39930 "EHLO
        mail-yb1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726415AbfDHOHe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Apr 2019 10:07:34 -0400
Received: by mail-yb1-f194.google.com with SMTP id b88so5181176ybi.6
        for <linux-kernel@vger.kernel.org>; Mon, 08 Apr 2019 07:07:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=dJt0M3acIikR+zKblbggMQsaDVTpy28z1BmTsIJt5G4=;
        b=N7/BWVsko7RykJ0c0vd8rzSWAz5g4TGQcSA8ENLBODGypUrr9Uqpkprs1Q1OhlNR9X
         nq8TjpQMKl0y2pSfIhOg4fdeX0cRUOgBeTDVVqs+2gEt4K8wLPGl4HzWHZH7EgIYAQxe
         wStsJGuGWgwIV1h5NfQMnBNVJZyFM178MoHLGDdbEr29nhZTkw3hESL1Q029QRGCHxfS
         o825D95AxrSXeggP3CSwOH0xhMDRJWpbjdhgqUVa6usi7n3H1740fGKVHMI7EELEDVIQ
         bqQZIBgAusg2+jFZHVpJhQFZH+J2NlFh04Mqv7lxueVk1A0TNyBA14tCFB5u63EkN1hD
         RVTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=dJt0M3acIikR+zKblbggMQsaDVTpy28z1BmTsIJt5G4=;
        b=sVdWB0WDLwj8wBODaIXkBzNU5nPnkqmzJ/eddgBqsIPCsiDPdm9DAyY/3Jyivf9J2x
         Wz/KCmd85PZ1OIii/kiiQgJLANgPIaCE1HmgkXDeMr6oaIuqHxx4uY5nnhAC/j3TVW9I
         832wTPaxVaZkj5/bH+o07a+j/Dc7rDwUFtlXt49/EQr2VN+vaU+gdTXRW++UzWYVVvBy
         lTd1vFHAi/VfrNFEOEeU8XBtI7aYDI0we4clEQVYrr48TS71aIhDY5o46yIx6tOBKtzV
         h7izy7xguzXom4e2DP75QTfNZOB5TB495RV4EFjGu4i9LqThQVgT1+gUgYdZdF43cybB
         yktA==
X-Gm-Message-State: APjAAAVAOSG0An5hz4jzhlFMg0ppPIzbISuCDrDOXQfL5zu00vLBf1vu
        DRMnmm07lSzAyOGkViUdxubME6MTHLQsMA==
X-Google-Smtp-Source: APXvYqx+7DIJQj7FZw84Vru4kcfr2f2/lOhuvKJYtr9Nqh+DFm4w+3N5tAbzwKSij1oRH2Tbhg+h3A==
X-Received: by 2002:a25:5d0f:: with SMTP id r15mr25233213ybb.188.1554732452979;
        Mon, 08 Apr 2019 07:07:32 -0700 (PDT)
Received: from leoy-ThinkPad-X240s (li931-65.members.linode.com. [45.56.113.65])
        by smtp.gmail.com with ESMTPSA id x134sm8105673ywg.71.2019.04.08.07.07.26
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 08 Apr 2019 07:07:31 -0700 (PDT)
Date:   Mon, 8 Apr 2019 22:07:21 +0800
From:   Leo Yan <leo.yan@linaro.org>
To:     Suzuki K Poulose <suzuki.poulose@arm.com>
Cc:     mathieu.poirier@linaro.org, robh+dt@kernel.org,
        mark.rutland@arm.com, alexander.shishkin@linux.intel.com,
        shiwanglai@hisilicon.com, linux-arm-kernel@lists.infradead.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 3/4] dt-bindings: arm: coresight: Unify funnel DT
 binding
Message-ID: <20190408140720.GB6541@leoy-ThinkPad-X240s>
References: <20190406112145.15184-1-leo.yan@linaro.org>
 <20190406112145.15184-4-leo.yan@linaro.org>
 <7f63abef-76fc-a767-723d-caacc8da29ae@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7f63abef-76fc-a767-723d-caacc8da29ae@arm.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 08, 2019 at 11:51:16AM +0100, Suzuki K Poulose wrote:
> On 04/06/2019 12:21 PM, Leo Yan wrote:
> > Following the same fashion with replicator DT binding, this patch is to
> > unify the DT binding for funnel to support static and dynamic modes;
> > finally we get the funnel DT binding as below:
> > 
> > Before patch:
> > 
> >    Static funnel, aka. non-configurable funnel:
> >      Not supported;
> > 
> >    Dynamic funnel, aka. configurable funnel:
> >      "arm,coresight-funnel", "arm,primecell";
> > 
> > After patch:
> > 
> >    Static funnel:
> >      "arm,coresight-static-funnel";
> > 
> >    Dynamic funnel:
> >      "arm,coresight-funnel", "arm,primecell"; (obsolete)
> >      "arm,coresight-dynamic-funnel", "arm,primecell";
> > 
> > At the end of this patch, it gives an example for static funnel DT
> > binding, and updates the dynamic funnel example.
> > 
> > Cc: Mathieu Poirier <mathieu.poirier@linaro.org>
> > Cc: Suzuki K Poulose <suzuki.poulose@arm.com>
> > Cc: Wanglai Shi <shiwanglai@hisilicon.com>
> > Signed-off-by: Leo Yan <leo.yan@linaro.org>
> > ---
> >   .../devicetree/bindings/arm/coresight.txt     | 52 +++++++++++++++++--
> >   1 file changed, 48 insertions(+), 4 deletions(-)
> > 
> > diff --git a/Documentation/devicetree/bindings/arm/coresight.txt b/Documentation/devicetree/bindings/arm/coresight.txt
> > index f8f794869af2..f8ad11a17cd5 100644
> > --- a/Documentation/devicetree/bindings/arm/coresight.txt
> > +++ b/Documentation/devicetree/bindings/arm/coresight.txt
> > @@ -8,7 +8,8 @@ through the intermediate links connecting the source to the currently selected
> >   sink. Each CoreSight component device should use these properties to describe
> >   its hardware characteristcs.
> > -* Required properties for all components *except* non-configurable replicators:
> > +* Required properties for all components *except* non-configurable replicators
> > +  and non-configurable funnels:
> >   	* compatible: These have to be supplemented with "arm,primecell" as
> >   	  drivers are using the AMBA bus interface.  Possible values include:
> > @@ -24,8 +25,11 @@ its hardware characteristcs.
> >   		  discovered at boot time when the device is probed.
> >   			"arm,coresight-tmc", "arm,primecell";
> > -		- Trace Funnel:
> > +		- Trace Programmable Funnel, the compatible string
> > +		  "arm,coresight-funnel" is obsolete, keep it to support
> > +		  the old DT bindings:
> >   			"arm,coresight-funnel", "arm,primecell";
> > +			"arm,coresight-dynamic-funnel", "arm,primecell";
> 
> Same comments as the first patch here.

Will do it.

> > +	funnel {
> > +		/*
> > +		 * non-configurable funnel don't show up on the AMBA
> > +		 * bus.  As such no need to add "arm,primecell".
> > +		 */
> > +		compatible = "arm,coresight-static-funnel";
> > +		clocks = <&crg_ctrl HI3660_PCLK>;
> > +		clock-names = "apb_pclk";
> > +
> > +		out-ports {
> > +			port {
> > +				combo_funnel_out: endpoint {
> > +					remote-endpoint = <&top_funnel_in>;
> > +				};
> > +			};
> > +		};
> > +
> > +		in-ports {
> > +			#address-cells = <1>;
> > +			#size-cells = <0>;
> > +
> > +			port@0 {
> > +				reg = <0>;
> > +				combo_funnel_in0: endpoint {
> > +					remote-endpoint = <&cluster0_etf_out>;
> > +				};
> > +			};
> > +
> > +			port@1 {
> > +				reg = <1>;
> > +				combo_funnel_in1: endpoint {
> > +					remote-endpoint = <&cluster1_etf_out>;
> > +				};
> > +			};
> > +		};
> > +	};
> > +
> >   	funnel@20040000 {
> 
> Should we rename this to say dynamic_funnel@2004000 { ?

I read ePAPR and it suggests "The name of a node should be somewhat
generic, reflecting the function of the device and not its precise
programming model".

So seems to me it's good to keep using generic naming 'funnel'.  If I
misunderstand anything, just let me know.

Will spin patch set for following other suggestions.

Thanks,
Leo Yan

> 
> > -		compatible = "arm,coresight-funnel", "arm,primecell";
> > +		compatible = "arm,coresight-dynamic-funnel", "arm,primecell";
> >   		reg = <0 0x20040000 0 0x1000>;
> 
> 
> Rest looks fine to me.
> 
> Suzuki
