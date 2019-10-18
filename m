Return-Path: <SRS0=6OEZ=YL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_2 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ED966CA9EB3
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Oct 2019 01:01:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CEB3A2064A
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Oct 2019 01:01:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2441888AbfJRBBB convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 17 Oct 2019 21:01:01 -0400
Received: from mga18.intel.com ([134.134.136.126]:22373 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2439184AbfJRBBB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Oct 2019 21:01:01 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga106.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 17 Oct 2019 18:00:55 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.67,309,1566889200"; 
   d="scan'208";a="221579874"
Received: from unknown (HELO ubuntu) ([10.226.248.102])
  by fmsmga004.fm.intel.com with SMTP; 17 Oct 2019 18:00:02 -0700
Received: by ubuntu (sSMTP sendmail emulation); Fri, 18 Oct 2019 09:00:01 +0800
Message-ID: <1571360401.2504.3.camel@intel.com>
Subject: Re: [PATCHv2] arm64: dts: agilex: add QSPI support for Intel Agilex
From:   Ley Foon Tan <ley.foon.tan@intel.com>
To:     "Ooi, Joyce" <joyce.ooi@intel.com>,
        Dinh Nguyen <dinguyen@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Ong Hean Loong <hean.loong.ong@intel.com>,
        See Chin Liang <chin.liang.see@intel.com>
Date:   Fri, 18 Oct 2019 09:00:01 +0800
In-Reply-To: <1571218846-12306-1-git-send-email-joyce.ooi@intel.com>
References: <1571218846-12306-1-git-send-email-joyce.ooi@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Mailer: Evolution 3.18.5.2-0ubuntu3.1 
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2019-10-16 at 02:40 -0700, Ooi, Joyce wrote:
> This patch adds QSPI flash interface in device tree for Intel Agilex
> 
> Signed-off-by: Ooi, Joyce <joyce.ooi@intel.com>
> ---
> v2: update the qspi_rootfs partition size
> ---
>  arch/arm64/boot/dts/intel/socfpga_agilex_socdk.dts | 35
> ++++++++++++++++++++++
>  1 file changed, 35 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/intel/socfpga_agilex_socdk.dts
> b/arch/arm64/boot/dts/intel/socfpga_agilex_socdk.dts
> index 7814a9e..8de8118 100644
> --- a/arch/arm64/boot/dts/intel/socfpga_agilex_socdk.dts
> +++ b/arch/arm64/boot/dts/intel/socfpga_agilex_socdk.dts
> @@ -73,3 +73,38 @@
>  &watchdog0 {
>  	status = "okay";
>  };
> +
> +&qspi {
> +	flash@0 {
> +		#address-cells = <1>;
> +		#size-cells = <1>;
> +		compatible = "mt25qu02g";
> +		reg = <0>;
> +		spi-max-frequency = <50000000>;
QSPI can support up to 100MHz.
> +
> +		m25p,fast-read;
> +		cdns,page-size = <256>;
> +		cdns,block-size = <16>;
> +		cdns,read-delay = <1>;
> +		cdns,tshsl-ns = <50>;
> +		cdns,tsd2d-ns = <50>;
> +		cdns,tchsh-ns = <4>;
> +		cdns,tslch-ns = <4>;
> +
> +		partitions {
> +			compatible = "fixed-partitions";
> +			#address-cells = <1>;
> +			#size-cells = <1>;
> +
> +			qspi_boot: partition@0 {
> +				label = "Boot and fpga data";
> +				reg = <0x0 0x034B0000>;
> +			};
> +
> +			qspi_rootfs: partition@34B0000 {
> +				label = "Root Filesystem - JFFS2";
> +				reg = <0x034B0000 0x0CB50000>;
> +			};
> +		};
> +	};
> +};
