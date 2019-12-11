Return-Path: <SRS0=Yvat=2B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7D06C2D0C4
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Dec 2019 02:17:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 85D3820836
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Dec 2019 02:17:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1576030662;
	bh=nsAKjl153J0JJUCjGK9PiMgZyuqUToi/dFZG+kBnD8Q=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=PYqJfG9+B/oE+jt4IKALLxpG6Hk0M5C8lzplto9QIiWHy8eDGxsmmVZCVbhius0kx
	 RL+TCkQJnd1OC/mG/duSucWG1cTIfPlLCTsdVUZAZZ1h7YQeF6YGHFuDRhked1DYXr
	 kVmkRvBZ58UN5rr4dJaZhY7eLZo6Sm1k1PMTWeVM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727678AbfLKCRl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Dec 2019 21:17:41 -0500
Received: from mail.kernel.org ([198.145.29.99]:49476 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726500AbfLKCRl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Dec 2019 21:17:41 -0500
Received: from dragon (98.142.130.235.16clouds.com [98.142.130.235])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8B743206EC;
        Wed, 11 Dec 2019 02:17:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1576030660;
        bh=nsAKjl153J0JJUCjGK9PiMgZyuqUToi/dFZG+kBnD8Q=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=FB4e1hbKhPhj0z40cj0Hmp0JwXqAAWSkrUd6Gu3DIpVTKk9P0tLagZQwdKff4I755
         HdwmwRM+w1AUJZ1p0iOldxPBwPpgWx65e0HyRMuogibSzFwMcudvXh9e0y/QTzyvnS
         p+BpHxjJP5i7DLd9syIB+TI0U5bZebie0jVv3s7k=
Date:   Wed, 11 Dec 2019 10:17:23 +0800
From:   Shawn Guo <shawnguo@kernel.org>
To:     Michael Walle <michael@walle.cc>
Cc:     linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Li Yang <leoyang.li@nxp.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
Subject: Re: [PATCH] arm64: dts: ls1028a: fix reboot node
Message-ID: <20191211021722.GA15858@dragon>
References: <20191123000709.13162-1-michael@walle.cc>
 <20191209034722.GZ3365@dragon>
 <67346b48fa7e236ea31e3ecb1a108f28@walle.cc>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <67346b48fa7e236ea31e3ecb1a108f28@walle.cc>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 09, 2019 at 10:02:02AM +0100, Michael Walle wrote:
> Am 2019-12-09 04:47, schrieb Shawn Guo:
> >On Sat, Nov 23, 2019 at 01:07:09AM +0100, Michael Walle wrote:
> >>The reboot register isn't located inside the DCFG controller,
> >>but in its
> >>own RST controller. Fix it.
> >>
> >>Signed-off-by: Michael Walle <michael@walle.cc>
> >>---
> >> arch/arm64/boot/dts/freescale/fsl-ls1028a.dtsi | 8 +++++++-
> >> 1 file changed, 7 insertions(+), 1 deletion(-)
> >>
> >>diff --git a/arch/arm64/boot/dts/freescale/fsl-ls1028a.dtsi
> >>b/arch/arm64/boot/dts/freescale/fsl-ls1028a.dtsi
> >>index 72b9a75976a1..dc75534a4754 100644
> >>--- a/arch/arm64/boot/dts/freescale/fsl-ls1028a.dtsi
> >>+++ b/arch/arm64/boot/dts/freescale/fsl-ls1028a.dtsi
> >>@@ -102,7 +102,7 @@
> >>
> >> 	reboot {
> >> 		compatible ="syscon-reboot";
> >>-		regmap = <&dcfg>;
> >>+		regmap = <&rst>;
> >> 		offset = <0xb0>;
> >> 		mask = <0x02>;
> >> 	};
> >>@@ -161,6 +161,12 @@
> >> 			big-endian;
> >> 		};
> >>
> >>+		rst: syscon@1e60000 {
> >>+			compatible = "fsl,ls1028a-rst", "syscon";
> >
> >Compatible "fsl,ls1028a-rst" seems undocumented?
> 
> it is the same with fsl,ls1028a-scfg and fsl,ls1028a-dcfg. So maybe
> I should just drop the "fsl,ls1028a-rst". What do you think?

Drop it or document it.  I'm fine with either way.

Shawn
