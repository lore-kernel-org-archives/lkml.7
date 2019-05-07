Return-Path: <SRS0=RyeP=TH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF16DC004C9
	for <linux-kernel@archiver.kernel.org>; Tue,  7 May 2019 06:21:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9F77E20989
	for <linux-kernel@archiver.kernel.org>; Tue,  7 May 2019 06:21:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="WrPSrTYe"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726504AbfEGGVc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 May 2019 02:21:32 -0400
Received: from smtprelay-out1.synopsys.com ([198.182.61.142]:51046 "EHLO
        smtprelay-out1.synopsys.com" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725858AbfEGGVb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 May 2019 02:21:31 -0400
Received: from mailhost.synopsys.com (dc2-mailhost2.synopsys.com [10.12.135.162])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        by smtprelay-out1.synopsys.com (Postfix) with ESMTPS id 5E2CCC01F8;
        Tue,  7 May 2019 06:21:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1557210085; bh=ZyX1bcSVC5Nm0BBnvry2vHPiC0loGDjMFfJjkMtfjcg=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=WrPSrTYeHzXBLsS/ih/XXqhHHuweWveF8Nkymww/uKjvIk0vXh0tj+jQYpELQ67uo
         cfRgiz4g0HFxf33M4vhVsPVO/RZRIqMZ4ANG55W/I9QU+yxR3OAjb0SVcRb4ofG2wa
         XZ9oaVY6GTLV3fI6gSuCNXX4aDAFYiS6hd3LD8R/aZrOCrFp3xqGsO7IX61ef6VeAh
         VY5KH9CNVEdO475ORUV76u1txi2v3i+SyXirWySMe2jCGwRrqkws7da1098Sf0Wgpm
         nNjmyXBuUo/PrVpoRfI9hoH89z9fp980TcylzAJ7gOB0tBpEvHAT7SFOCNvFELSNjL
         YXxGTLmbObZ+w==
Received: from [10.116.70.206] (hminas-7480.internal.synopsys.com [10.116.70.206])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mailhost.synopsys.com (Postfix) with ESMTPSA id 5BADAA0095;
        Tue,  7 May 2019 06:21:27 +0000 (UTC)
Subject: Re: [BUG BISECT] USB on Exynos4412 fails after usb: dwc2: gadget:
 Replace phyif with phy_utmi_width
To:     Krzysztof Kozlowski <krzk@kernel.org>,
        Jules Maselbas <jmaselbas@kalray.eu>
Cc:     Felipe Balbi <felipe.balbi@linux.intel.com>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-samsung-soc@vger.kernel.org" 
        <linux-samsung-soc@vger.kernel.org>,
        Marek Szyprowski <m.szyprowski@samsung.com>
References: <20190503204958.GA12532@kozik-lap>
From:   Minas Harutyunyan <Minas.Harutyunyan@synopsys.com>
Message-ID: <d198f061-3ed6-11d9-4e92-0e0fb2705238@synopsys.com>
Date:   Tue, 7 May 2019 10:21:25 +0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190503204958.GA12532@kozik-lap>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Krzysztof,

On 5/4/2019 12:50 AM, Krzysztof Kozlowski wrote:
> Hi,
> 
> Bisect pointed commit 707d80f0a3c5 ("usb: dwc2: gadget: Replace phyif
> with phy_utmi_width") as reason for failures of USB on Exynos4412,
> Odroid U3 board (ARMv7, exynos_defconfig, TFTP boot with nfsroot from
> NFSv4):
> 
> [    4.333996] usb 1-2: new high-speed USB device number 3 using exynos-ehci
> [    4.503942] usb 1-2: device descriptor read/64, error -71
> [    4.793970] usb 1-2: device descriptor read/64, error -71
> [    4.914748] usb usb1-port2: attempt power cycle
> [    6.224267] usb 1-3: new high-speed USB device number 5 using exynos-ehci
> [    6.393983] usb 1-3: device descriptor read/64, error -71
> [    6.684243] usb 1-3: device descriptor read/64, error -71
> [    6.954259] usb 1-3: new high-speed USB device number 6 using exynos-ehci
> [    7.123980] usb 1-3: device descriptor read/64, error -71
> [    7.413969] usb 1-3: device descriptor read/64, error -71
> [    7.534778] usb usb1-port3: attempt power cycle
> 
> The boot failure is effect of lack of network adapter (USB, smsc95xx).
> Expected:
> [    4.285831] usb 1-3: New USB device found, idVendor=0424, idProduct=3503, bcdDevice=a1.a0
> [    4.288986] usb 1-3: New USB device strings: Mfr=0, Product=0, SerialNumber=0
> [    4.299596] hub 1-3:1.0: USB hub found
> [    4.300027] hub 1-3:1.0: 3 ports detected
> [    5.895541] smsc95xx 1-2:1.0 eth0: link up, 100Mbps, full-duplex, lpa 0xCDE1
> 
> Full kernel log is here:
> https://urldefense.proofpoint.com/v2/url?u=https-3A__krzk.eu_-23_builders_25_builds_1330_steps_14_logs_serial0&d=DwIBaQ&c=DPL6_X_6JkXFx7AXWqB0tg&r=6z9Al9FrHR_ZqbbtSAsD16pvOL2S3XHxQnSzq8kusyI&m=OiD-VOiMNPgl24seQpn5JKZq7f85A4LNzaz8zX0YrKs&s=WBsxDt_1PXo9t9AxxJkUTTLE6zx_UDc7ac_U3EydCzI&e=
> https://urldefense.proofpoint.com/v2/url?u=https-3A__krzk.eu_-23_builders_25_builds_1330&d=DwIBaQ&c=DPL6_X_6JkXFx7AXWqB0tg&r=6z9Al9FrHR_ZqbbtSAsD16pvOL2S3XHxQnSzq8kusyI&m=OiD-VOiMNPgl24seQpn5JKZq7f85A4LNzaz8zX0YrKs&s=Lxk4ZiitEFaod88HTY0hthrdRy_TtktU53P6UDtaCoE&e=
> 
> Let me know if you need any more details.
> 
> Best regards,
> Krzysztof
> 
> 

But fail seen on ehci driver not dwc2.

Thanks,
Minas

