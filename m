Return-Path: <SRS0=Q+aa=S3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32C13C43218
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Apr 2019 19:52:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 35AC5206BF
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Apr 2019 19:52:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1556221921;
	bh=RC6d0+03iJLxk3c7OD6pLAsANAg+U2tnYNxIEy3W6RQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=VbLfyXZh+8FUMBpcHRx59jtsls5nC3KmT/ch3/cCyreNHnqlHneeu+oJowJhSNnWV
	 5IAZUj/YyHpk9B5PWH2zUHgwJQ8L8VVOslWtZfJHiqwu30FAXCDCeqzd3zxl+xQxzV
	 /8+2llDAKlnbnBfXyzvpLktBYtGxC0P7pdG6uxqA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730150AbfDYTwA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Apr 2019 15:52:00 -0400
Received: from mail-ot1-f65.google.com ([209.85.210.65]:44854 "EHLO
        mail-ot1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726196AbfDYTv7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Apr 2019 15:51:59 -0400
Received: by mail-ot1-f65.google.com with SMTP id d24so585611otl.11;
        Thu, 25 Apr 2019 12:51:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=cKM4pLCQMWaOgJXBRBtihdODzmH4ydKptoPHFUneFTk=;
        b=TTQb2uBLeg7Hvo6nKqY0jIdNYMTMcpzneitRHk2zETqth3hDmM/LsvvVF8aMq2rEh3
         8P8IIS4/sFvzlzYxWz8mFu/HyOqXkecjmmvqxzTENdryxWq7wv4NrWJSkBSLx3URN/T1
         WPeoRG/UxPB2N1a21ZiYmUAMxUERwH+/VdszBlL1MDv3QIx7Zek5uPpQXxk0bn26ANug
         mdLNCUawISUhyymZ/ACo+K/Z3V29QQp1X1b4qVZA5ZNkXHMQk04GZGlcR3NJruf0wOz8
         dl5k6HxHoUyfEdwfFQ8nCWUrLlvM4yMuF31GRU8xUxhT+PWfrrIjCGwPHtxz+X7ukqVy
         JbHA==
X-Gm-Message-State: APjAAAWqXmdMHEV2T7d/GHX9krZz2cOc2UTcswkXwGP4rUBr2ilLqAqj
        6j6NFD9dnD+zM78yQNATLbHUAZ8=
X-Google-Smtp-Source: APXvYqwtw01HRGdPB/X7xIE1zEzbgMd7zwx+GhhbrI4/JwIMsaevE9nc2txru273g8BFLVqBj2ALVg==
X-Received: by 2002:a05:6830:1559:: with SMTP id l25mr24682251otp.355.1556221917937;
        Thu, 25 Apr 2019 12:51:57 -0700 (PDT)
Received: from localhost (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id 38sm4134315otg.10.2019.04.25.12.51.56
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 25 Apr 2019 12:51:56 -0700 (PDT)
Date:   Thu, 25 Apr 2019 14:51:56 -0500
From:   Rob Herring <robh@kernel.org>
To:     Lukasz Luba <l.luba@partner.samsung.com>
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org, linux-samsung-soc@vger.kernel.org,
        b.zolnierkie@samsung.com, krzk@kernel.org, kgene@kernel.org,
        cw00.choi@samsung.com, kyungmin.park@samsung.com,
        m.szyprowski@samsung.com, s.nawrocki@samsung.com,
        myungjoo.ham@samsung.com, keescook@chromium.org, tony@atomide.com,
        jroedel@suse.de, treding@nvidia.com, digetx@gmail.com,
        willy.mh.wolff.ml@gmail.com
Subject: Re: [PATCH v6 04/10] Documentation: dt: device tree bindings for
 LPDDR3 memories
Message-ID: <20190425195156.GA31128@bogus>
References: <1555683568-20882-1-git-send-email-l.luba@partner.samsung.com>
 <CGME20190419141945eucas1p1c95d65f261f82da5c856c0f2fcf1ce87@eucas1p1.samsung.com>
 <1555683568-20882-5-git-send-email-l.luba@partner.samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1555683568-20882-5-git-send-email-l.luba@partner.samsung.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 19, 2019 at 04:19:22PM +0200, Lukasz Luba wrote:
> The device tree bindings for LPDDR3 SDRAM memories.
> 
> For specifying the AC timing parameters of the memory device
> the 'lpddr3' binding uses binding 'lpddr2-timings'.
> 
> Signed-off-by: Lukasz Luba <l.luba@partner.samsung.com>
> ---
>  .../devicetree/bindings/lpddr3/lpddr3-timings.txt  | 57 +++++++++++++
>  .../devicetree/bindings/lpddr3/lpddr3.txt          | 93 ++++++++++++++++++++++

Please rename the lpddr2 directory to 'ddr' and add these to it.

Maybe whatever properties are common should be put in a common doc.

>  2 files changed, 150 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/lpddr3/lpddr3-timings.txt
>  create mode 100644 Documentation/devicetree/bindings/lpddr3/lpddr3.txt
> 
> diff --git a/Documentation/devicetree/bindings/lpddr3/lpddr3-timings.txt b/Documentation/devicetree/bindings/lpddr3/lpddr3-timings.txt
> new file mode 100644
> index 0000000..ebf3e00
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/lpddr3/lpddr3-timings.txt
> @@ -0,0 +1,57 @@
> +* AC timing parameters of LPDDR3 memories for a given speed-bin.
> +* The structures are based on LPDDR2 and extended where needed.
> +
> +Required properties:
> +- compatible : Should be "jedec,lpddr3-timings"
> +- min-freq : minimum DDR clock frequency for the speed-bin. Type is <u32>
> +- max-freq : maximum DDR clock frequency for the speed-bin. Type is <u32>
> +
> +Optional properties:
> +
> +The following properties represent AC timing parameters from the memory
> +data-sheet of the device for a given speed-bin. All these properties are
> +of type <u32> and the default unit is ps (pico seconds).
> +- tRFC
> +- tRRD
> +- tRPab
> +- tRPpb
> +- tRCD
> +- tRC
> +- tRAS
> +- tWTR
> +- tWR
> +- tRTP
> +- tW2W-C2C
> +- tR2R-C2C
> +- tFAW
> +- tXSR
> +- tXP
> +- tCKE
> +- tCKESR
> +- tMRD
> +
> +Example:
> +
> +timings_samsung_K3QF2F20DB_800mhz: lpddr3-timings@0 {

Since the lpddr2 version was written, we've gotten stricter about 
allowing unit-address without reg property. Perhaps 'reg' should be the 
max-freq instead.

> +	compatible	= "jedec,lpddr3-timings";
> +	min-freq	= <100000000>;
> +	max-freq	= <800000000>;
> +	tRFC		= <65000>;
> +	tRRD		= <6000>;
> +	tRPab		= <12000>;
> +	tRPpb		= <12000>;
> +	tRCD		= <10000>;
> +	tRC		= <33750>;
> +	tRAS		= <23000>;
> +	tWTR		= <3750>;
> +	tWR		= <7500>;
> +	tRTP		= <3750>;
> +	tW2W-C2C	= <0>;
> +	tR2R-C2C	= <0>;
> +	tFAW		= <25000>;
> +	tXSR		= <70000>;
> +	tXP		= <3750>;
> +	tCKE		= <3750>;
> +	tCKESR		= <3750>;
> +	tMRD		= <7000>;
> +};
> diff --git a/Documentation/devicetree/bindings/lpddr3/lpddr3.txt b/Documentation/devicetree/bindings/lpddr3/lpddr3.txt
> new file mode 100644
> index 0000000..fc7875c
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/lpddr3/lpddr3.txt
> @@ -0,0 +1,93 @@
> +* LPDDR3 SDRAM memories compliant to JEDEC JESD209-2

That's an LPDDR2 spec.

> +
> +Required properties:
> +- compatible : Should be  - "jedec,lpddr3"
> +- density  : <u32> representing density in Mb (Mega bits)
> +- io-width : <u32> representing bus width. Possible values are 8, 16, 32, 64
> +
> +Optional properties:
> +
> +The following optional properties represent the minimum value of some AC
> +timing parameters of the DDR device in terms of number of clock cycles.
> +These values shall be obtained from the device data-sheet.
> +- tRFC-min-tck
> +- tRRD-min-tck
> +- tRPab-min-tck
> +- tRPpb-min-tck
> +- tRCD-min-tck
> +- tRC-min-tck
> +- tRAS-min-tck
> +- tWTR-min-tck
> +- tWR-min-tck
> +- tRTP-min-tck
> +- tW2W-C2C-min-tck
> +- tR2R-C2C-min-tck
> +- tWL-min-tck
> +- tDQSCK-min-tck
> +- tRL-min-tck
> +- tFAW-min-tck
> +- tXSR-min-tck
> +- tXP-min-tck
> +- tCKE-min-tck
> +- tCKESR-min-tck
> +- tMRD-min-tck
> +
> +Child nodes:
> +- The lpddr3 node may have one or more child nodes of type "lpddr3-timings".
> +  "lpddr3-timings" provides AC timing parameters of the device for
> +  a given speed-bin. Please see Documentation/devicetree/
> +  bindings/lpddr3/lpddr3-timings.txt for more information on "lpddr3-timings"
> +
> +Example:
> +
> +samsung_K3QF2F20DB: lpddr3 {
> +	compatible	= "Samsung,K3QF2F20DB","jedec,lpddr3";
> +	density		= <16384>;
> +	io-width	= <32>;
> +
> +	tRFC-min-tck		= <17>;
> +	tRRD-min-tck		= <2>;
> +	tRPab-min-tck		= <2>;
> +	tRPpb-min-tck		= <2>;
> +	tRCD-min-tck		= <3>;
> +	tRC-min-tck		= <6>;
> +	tRAS-min-tck		= <5>;
> +	tWTR-min-tck		= <2>;
> +	tWR-min-tck		= <7>;
> +	tRTP-min-tck		= <2>;
> +	tW2W-C2C-min-tck	= <0>;
> +	tR2R-C2C-min-tck	= <0>;
> +	tWL-min-tck		= <8>;
> +	tDQSCK-min-tck		= <5>;
> +	tRL-min-tck		= <14>;
> +	tFAW-min-tck		= <5>;
> +	tXSR-min-tck		= <12>;
> +	tXP-min-tck		= <2>;
> +	tCKE-min-tck		= <2>;
> +	tCKESR-min-tck		= <2>;
> +	tMRD-min-tck		= <5>;
> +
> +	timings_samsung_K3QF2F20DB_800mhz: lpddr3-timings@0 {
> +		compatible	= "jedec,lpddr3-timings";
> +		min-freq	= <100000000>;
> +		max-freq	= <800000000>;
> +		tRFC		= <65000>;
> +		tRRD		= <6000>;
> +		tRPab		= <12000>;
> +		tRPpb		= <12000>;
> +		tRCD		= <10000>;
> +		tRC		= <33750>;
> +		tRAS		= <23000>;
> +		tWTR		= <3750>;
> +		tWR		= <7500>;
> +		tRTP		= <3750>;
> +		tW2W-C2C	= <0>;
> +		tR2R-C2C	= <0>;
> +		tFAW		= <25000>;
> +		tXSR		= <70000>;
> +		tXP		= <3750>;
> +		tCKE		= <3750>;
> +		tCKESR		= <3750>;
> +		tMRD		= <7000>;
> +	};
> +}
> -- 
> 2.7.4
> 
