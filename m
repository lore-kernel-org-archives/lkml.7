Return-Path: <SRS0=vISB=2T=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A50A6C2D0D1
	for <linux-kernel@archiver.kernel.org>; Sun, 29 Dec 2019 07:47:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 79E45207FF
	for <linux-kernel@archiver.kernel.org>; Sun, 29 Dec 2019 07:47:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726410AbfL2HrQ convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 29 Dec 2019 02:47:16 -0500
Received: from rtits2.realtek.com ([211.75.126.72]:60512 "EHLO
        rtits2.realtek.com.tw" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725800AbfL2HrQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 29 Dec 2019 02:47:16 -0500
Authenticated-By: 
X-SpamFilter-By: BOX Solutions SpamTrap 5.62 with qID xBT7kw2Y014196, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (RTITCASV01.realtek.com.tw[172.21.6.18])
        by rtits2.realtek.com.tw (8.15.2/2.57/5.78) with ESMTPS id xBT7kw2Y014196
        (version=TLSv1 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
        Sun, 29 Dec 2019 15:46:58 +0800
Received: from RTEXDAG02.realtek.com.tw (172.21.6.101) by
 RTITCASV01.realtek.com.tw (172.21.6.18) with Microsoft SMTP Server (TLS) id
 14.3.468.0; Sun, 29 Dec 2019 15:46:58 +0800
Received: from RTEXMB03.realtek.com.tw (172.21.6.96) by
 RTEXDAG02.realtek.com.tw (172.21.6.101) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1779.2; Sun, 29 Dec 2019 15:46:57 +0800
Received: from RTEXMB03.realtek.com.tw ([fe80::71dc:5fb1:bef0:757d]) by
 RTEXMB03.realtek.com.tw ([fe80::71dc:5fb1:bef0:757d%8]) with mapi id
 15.01.1779.005; Sun, 29 Dec 2019 15:46:57 +0800
From:   James Tai <james.tai@realtek.com>
To:     Marc Zyngier <maz@kernel.org>
CC:     "linux-realtek-soc@lists.infradead.org" 
        <linux-realtek-soc@lists.infradead.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>
Subject: RE: [PATCH v2 2/2] arm64: dts: realtek: Add RTD1319 SoC and Realtek PymParticle EVB
Thread-Topic: [PATCH v2 2/2] arm64: dts: realtek: Add RTD1319 SoC and Realtek
 PymParticle EVB
Thread-Index: AQHVvZBwjtzWNBJixEaMzPydnauk0qfPYAMAgAE1hnA=
Date:   Sun, 29 Dec 2019 07:46:57 +0000
Message-ID: <68b6541e1f4b447cb6845d16fdab28d9@realtek.com>
References: <20191228150553.6210-1-james.tai@realtek.com>
 <20191228150553.6210-3-james.tai@realtek.com>
 <6750faa33ee059ec22cf1981e7483186@kernel.org>
In-Reply-To: <6750faa33ee059ec22cf1981e7483186@kernel.org>
Accept-Language: zh-TW, en-US
Content-Language: zh-TW
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [114.37.128.25]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Marc,

Thanks for review.

> > +	timer {
> > +		compatible = "arm,armv8-timer";
> > +		interrupts = <GIC_PPI 13 IRQ_TYPE_LEVEL_LOW>,
> > +			     <GIC_PPI 14 IRQ_TYPE_LEVEL_LOW>,
> > +			     <GIC_PPI 11 IRQ_TYPE_LEVEL_LOW>,
> > +			     <GIC_PPI 10 IRQ_TYPE_LEVEL_LOW>;
> 
> Nit: At some point, it'd be good to be able to describe the EL2 virtual timer
> interrupt too. Not specially important, but since these ARMv8.2 CPUs have it...

I will add the EL2 virtual timer interrupt to timer node.

> > +		gic: interrupt-controller@ff100000 {
> > +			compatible = "arm,gic-v3";
> > +			reg = <0xff100000 0x10000>,
> > +			      <0xff140000 0xc0000>;
> 
> Are you sure about the size of the GICR region? For 4 CPUs, it should be
> 0x80000. Here, you have a range for 6 CPUs.

The GICR region should be 0x80000 because the RTD1319 SoC have only 4 CPUs.

Thank you.

Regards,
James
