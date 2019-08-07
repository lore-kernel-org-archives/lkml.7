Return-Path: <SRS0=/Haq=WD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7DE27C433FF
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Aug 2019 13:17:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5C53721E6B
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Aug 2019 13:17:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388188AbfHGNRs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 7 Aug 2019 09:17:48 -0400
Received: from mga07.intel.com ([134.134.136.100]:9289 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387970AbfHGNRr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Aug 2019 09:17:47 -0400
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga105.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 07 Aug 2019 06:17:46 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,357,1559545200"; 
   d="scan'208";a="198661298"
Received: from smile.fi.intel.com (HELO smile) ([10.237.68.145])
  by fmsmga004.fm.intel.com with ESMTP; 07 Aug 2019 06:17:44 -0700
Received: from andy by smile with local (Exim 4.92.1)
        (envelope-from <andriy.shevchenko@intel.com>)
        id 1hvLp0-0002Yl-C1; Wed, 07 Aug 2019 16:17:42 +0300
Date:   Wed, 7 Aug 2019 16:17:42 +0300
From:   Andy Shevchenko <andriy.shevchenko@intel.com>
To:     Rahul Tanwar <rahul.tanwar@linux.intel.com>
Cc:     linux-serial@vger.kernel.org, devicetree@vger.kernel.org,
        gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org,
        jslaby@suse.com, robh+dt@kernel.org, mark.rutland@arm.com,
        qi-ming.wu@intel.com, cheol.yong.kim@intel.com,
        rahul.tanwar@intel.com
Subject: Re: [PATCH 4/5] dt-bindings: serial: lantiq: Update for new SoC
Message-ID: <20190807131742.GV30120@smile.fi.intel.com>
References: <cover.1565160764.git.rahul.tanwar@linux.intel.com>
 <47c6565f5537575b16f65ca5ccc5ecfc61818dbc.1565160764.git.rahul.tanwar@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <47c6565f5537575b16f65ca5ccc5ecfc61818dbc.1565160764.git.rahul.tanwar@linux.intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 07, 2019 at 05:21:34PM +0800, Rahul Tanwar wrote:
> There is a new Intel Atom based Lightning Mountain(LGM) network processor SoC which
> reuses Lantiq ASC serial controller IP. This patch adds new compatible string
> and its expected property value in order to support the driver for LGM as well.

I think it makes sense to convert to YAML before adding new properties.

> 
> Signed-off-by: Rahul Tanwar <rahul.tanwar@linux.intel.com>
> ---
>  Documentation/devicetree/bindings/serial/lantiq_asc.txt | 17 +++++++++++++++--
>  1 file changed, 15 insertions(+), 2 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/serial/lantiq_asc.txt b/Documentation/devicetree/bindings/serial/lantiq_asc.txt
> index 40e81a5818f6..18b45dd13a61 100644
> --- a/Documentation/devicetree/bindings/serial/lantiq_asc.txt
> +++ b/Documentation/devicetree/bindings/serial/lantiq_asc.txt
> @@ -1,10 +1,14 @@
>  Lantiq SoC ASC serial controller
>  
>  Required properties:
> -- compatible : Should be "lantiq,asc"
> +- compatible : Should be "lantiq,asc" or "intel,lgm-asc"
>  - reg : Address and length of the register set for the device
> -- interrupts: the 3 (tx rx err) interrupt numbers. The interrupt specifier
> +- interrupts:
> +  For "lantiq,asc" - the 3 (tx rx err) interrupt numbers. The interrupt specifier
>    depends on the interrupt-parent interrupt controller.
> +	or
> +  For "intel,lgm-asc" - the common interrupt number for all of tx rx & err interrupts
> +  followed by level/sense specifier.
>  
>  Optional properties:
>  - clocks: Should contain frequency clock and gate clock
> @@ -29,3 +33,12 @@ asc1: serial@e100c00 {
>  	interrupt-parent = <&icu0>;
>  	interrupts = <112 113 114>;
>  };
> +
> +asc0: serial@e0a00000 {
> +	compatible = "intel,lgm-asc";
> +	reg = <0xe0a00000 0x1000>;
> +	interrupt-parent = <&ioapic1>;
> +	interrupts = <128 1>;
> +	clocks = <&cgu0 LGM_CLK_NOC4>, <&cgu0 LGM_GCLK_ASC0>;
> +	clock-names = "freq", "asc";
> +};
> -- 
> 2.11.0
> 

-- 
With Best Regards,
Andy Shevchenko


