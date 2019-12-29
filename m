Return-Path: <SRS0=vISB=2T=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0C1BC2D0C6
	for <linux-kernel@archiver.kernel.org>; Sun, 29 Dec 2019 11:29:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C3043208C4
	for <linux-kernel@archiver.kernel.org>; Sun, 29 Dec 2019 11:29:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1577618966;
	bh=oVfGipAAJ2TJZ0pU2FQWz2oq6t/1REI9Q14DB8MlQag=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=jq3qAwcHIutr1ejq1Pjwda6WGMROql9qsCx3Cpx9S/SOoV2qphRKwjLhXjWSCNeeL
	 gRirI1KnOiODhaWpFv6jiD64UUjBLb5RZAbWZzxSvW7Kfk4jy7HPLGtXOnQLOwh6WN
	 JLEagwu5Vgl04likJUwIzToY/WmCPkzI6bojOUgg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726410AbfL2L3V (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 29 Dec 2019 06:29:21 -0500
Received: from disco-boy.misterjones.org ([51.254.78.96]:34214 "EHLO
        disco-boy.misterjones.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726151AbfL2L3U (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 29 Dec 2019 06:29:20 -0500
Received: from disco-boy.misterjones.org ([51.254.78.96] helo=www.loen.fr)
        by disco-boy.misterjones.org with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.92)
        (envelope-from <maz@kernel.org>)
        id 1ilWl2-00061M-EV; Sun, 29 Dec 2019 11:29:16 +0000
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Sun, 29 Dec 2019 11:29:16 +0000
From:   Marc Zyngier <maz@kernel.org>
To:     James Tai <james.tai@realtek.com>
Cc:     linux-realtek-soc@lists.infradead.org, mark.rutland@arm.com,
        devicetree@vger.kernel.org,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        linux-kernel@vger.kernel.org, robh+dt@kernel.org,
        Robin Murphy <robin.murphy@arm.com>,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v2 2/2] arm64: dts: realtek: Add RTD1319 SoC and Realtek
 PymParticle EVB
In-Reply-To: <68b6541e1f4b447cb6845d16fdab28d9@realtek.com>
References: <20191228150553.6210-1-james.tai@realtek.com>
 <20191228150553.6210-3-james.tai@realtek.com>
 <6750faa33ee059ec22cf1981e7483186@kernel.org>
 <68b6541e1f4b447cb6845d16fdab28d9@realtek.com>
Message-ID: <718082aebcc3ab4d9169a4abbe968ec1@kernel.org>
X-Sender: maz@kernel.org
User-Agent: Roundcube Webmail/1.3.8
X-SA-Exim-Connect-IP: 51.254.78.96
X-SA-Exim-Rcpt-To: james.tai@realtek.com, linux-realtek-soc@lists.infradead.org, mark.rutland@arm.com, devicetree@vger.kernel.org, lorenzo.pieralisi@arm.com, linux-kernel@vger.kernel.org, robh+dt@kernel.org, robin.murphy@arm.com, linux-arm-kernel@lists.infradead.org
X-SA-Exim-Mail-From: maz@kernel.org
X-SA-Exim-Scanned: No (on disco-boy.misterjones.org); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2019-12-29 07:46, James Tai wrote:
> Hi Marc,
> 
> Thanks for review.
> 
>> > +	timer {
>> > +		compatible = "arm,armv8-timer";
>> > +		interrupts = <GIC_PPI 13 IRQ_TYPE_LEVEL_LOW>,
>> > +			     <GIC_PPI 14 IRQ_TYPE_LEVEL_LOW>,
>> > +			     <GIC_PPI 11 IRQ_TYPE_LEVEL_LOW>,
>> > +			     <GIC_PPI 10 IRQ_TYPE_LEVEL_LOW>;
>> 
>> Nit: At some point, it'd be good to be able to describe the EL2 
>> virtual timer
>> interrupt too. Not specially important, but since these ARMv8.2 CPUs 
>> have it...
> 
> I will add the EL2 virtual timer interrupt to timer node.

If you do this, please update the binding first, as this interrupt
is not described there yet.

> 
>> > +		gic: interrupt-controller@ff100000 {
>> > +			compatible = "arm,gic-v3";
>> > +			reg = <0xff100000 0x10000>,
>> > +			      <0xff140000 0xc0000>;
>> 
>> Are you sure about the size of the GICR region? For 4 CPUs, it should 
>> be
>> 0x80000. Here, you have a range for 6 CPUs.
> 
> The GICR region should be 0x80000 because the RTD1319 SoC have only 4 
> CPUs.

OK. Please verify that this is actually the case, and that the last
redistributor (at offset 0x60000) has GICR_TYPER.Last set. I have
recently seen GICs configured for a larger number of CPUs where
some of them were disabled in HW, and the DT was wrongly describing
some of the redistributors only, leading to SW crashes.

Thanks,

         M.
-- 
Jazz is not dead. It just smells funny...
