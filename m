Return-Path: <SRS0=LniW=ZY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B421C43215
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Dec 2019 23:13:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7A525206F0
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Dec 2019 23:13:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726138AbfLBXNB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 2 Dec 2019 18:13:01 -0500
Received: from mx2.suse.de ([195.135.220.15]:35904 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725834AbfLBXNB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Dec 2019 18:13:01 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 49046B331;
        Mon,  2 Dec 2019 23:12:59 +0000 (UTC)
Subject: Re: [RFC 5/5] arm64: dts: realtek: rtd139x: Add SB2 sem nodes
To:     linux-realtek-soc@lists.infradead.org,
        Cheng-Yu Lee <cylee12@realtek.com>,
        James Tai <james.tai@realtek.com>
Cc:     Mark Rutland <mark.rutland@arm.com>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        linux-arm-kernel@lists.infradead.org
References: <20191202220535.6208-1-afaerber@suse.de>
 <20191202220535.6208-6-afaerber@suse.de>
From:   =?UTF-8?Q?Andreas_F=c3=a4rber?= <afaerber@suse.de>
Organization: SUSE Software Solutions Germany GmbH
Message-ID: <15898d07-ba67-f790-723d-33b0fe5363c8@suse.de>
Date:   Tue, 3 Dec 2019 00:12:57 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.1
MIME-Version: 1.0
In-Reply-To: <20191202220535.6208-6-afaerber@suse.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am 02.12.19 um 23:05 schrieb Andreas Färber:
> Add DT nodes to SB2 for hardware semaphores in RTD1395 SoC family.
> 
> Signed-off-by: Andreas Färber <afaerber@suse.de>
> ---
>  arch/arm64/boot/dts/realtek/rtd139x.dtsi | 14 ++++++++++++++
>  1 file changed, 14 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/realtek/rtd139x.dtsi b/arch/arm64/boot/dts/realtek/rtd139x.dtsi
> index a3c10ceeb586..586b05350274 100644
> --- a/arch/arm64/boot/dts/realtek/rtd139x.dtsi
> +++ b/arch/arm64/boot/dts/realtek/rtd139x.dtsi
> @@ -191,3 +191,17 @@
>  		status = "disabled";
>  	};
>  };
> +
> +&sb2 {
> +	sb2_hd_sem: hwspinlock@0 {
> +		compatible = "realtek,rtd1195-sb2-sem";
> +		reg = <0x0 0x4>;
> +		#hwlock-cells = <0>;
> +	};
> +
> +	sb2_hd_sem_new: hwspinlock@620 {
> +		compatible = "realtek,rtd1195-sb2-sem";
> +		reg = <0x620 0x20>;
> +		#hwlock-cells = <1>;
> +	};

Forgot to mention: These last 8 registers (0x20) are a guess, untested.
@Realtek: Can someone please check whether RTD1395 has the same nine sem
registers as RTD1295?

Similarly, this series is lacking a patch for RTD1619 because - same as
for RTD1295/RTD1395 - BSP DT only shows the first one (cf. coverletter).
Same issue for RTD1319 while at it.

Thanks,
Andreas

> +};

-- 
SUSE Software Solutions Germany GmbH
Maxfeldstr. 5, 90409 Nürnberg, Germany
GF: Felix Imendörffer
HRB 36809 (AG Nürnberg)
