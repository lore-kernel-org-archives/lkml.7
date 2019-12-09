Return-Path: <SRS0=ag/Q=Z7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80F74C2D0C0
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Dec 2019 09:02:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 53DA72075B
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Dec 2019 09:02:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=walle.cc header.i=@walle.cc header.b="BmOe7vHM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727402AbfLIJCH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Dec 2019 04:02:07 -0500
Received: from ssl.serverraum.org ([176.9.125.105]:33663 "EHLO
        ssl.serverraum.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726377AbfLIJCG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Dec 2019 04:02:06 -0500
Received: from ssl.serverraum.org (web.serverraum.org [172.16.0.2])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ssl.serverraum.org (Postfix) with ESMTPSA id 96AA423061;
        Mon,  9 Dec 2019 10:02:02 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=walle.cc; s=mail2016061301;
        t=1575882122;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=A+S+3RFjVcWK0eGQU/wCN8y+0aJTyPpQt2Yx6PrB4a0=;
        b=BmOe7vHMwSZ3b0Nh7ICW9Ztz0DnvAGQAwNpiPP7/0aSs0/MvLB0Qc7s5OA6prXbQn7MaPZ
        RO0oTQ9WohcxvPwAF/1Hc/MDA8q1Kn2dGy4mCMGB/3oz4bxbMfwhoRsTni+57+BqUwvwd1
        EcZgmdH89vEgBYG4X/gTZWwbMh2ig8Q=
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Mon, 09 Dec 2019 10:02:02 +0100
From:   Michael Walle <michael@walle.cc>
To:     Shawn Guo <shawnguo@kernel.org>
Cc:     linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Li Yang <leoyang.li@nxp.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
Subject: Re: [PATCH] arm64: dts: ls1028a: fix reboot node
In-Reply-To: <20191209034722.GZ3365@dragon>
References: <20191123000709.13162-1-michael@walle.cc>
 <20191209034722.GZ3365@dragon>
Message-ID: <67346b48fa7e236ea31e3ecb1a108f28@walle.cc>
X-Sender: michael@walle.cc
User-Agent: Roundcube Webmail/1.3.8
X-Spamd-Bar: +
X-Rspamd-Server: web
X-Rspamd-Queue-Id: 96AA423061
X-Spamd-Result: default: False [1.40 / 15.00];
         ARC_NA(0.00)[];
         FROM_HAS_DN(0.00)[];
         TO_DN_SOME(0.00)[];
         TO_MATCH_ENVRCPT_ALL(0.00)[];
         TAGGED_RCPT(0.00)[dt];
         MIME_GOOD(-0.10)[text/plain];
         DKIM_SIGNED(0.00)[];
         RCPT_COUNT_SEVEN(0.00)[7];
         NEURAL_HAM(-0.00)[-0.679];
         RCVD_COUNT_ZERO(0.00)[0];
         FROM_EQ_ENVFROM(0.00)[];
         MIME_TRACE(0.00)[0:+];
         MID_RHS_MATCH_FROM(0.00)[];
         SUSPICIOUS_RECIPS(1.50)[]
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am 2019-12-09 04:47, schrieb Shawn Guo:
> On Sat, Nov 23, 2019 at 01:07:09AM +0100, Michael Walle wrote:
>> The reboot register isn't located inside the DCFG controller, but in 
>> its
>> own RST controller. Fix it.
>> 
>> Signed-off-by: Michael Walle <michael@walle.cc>
>> ---
>>  arch/arm64/boot/dts/freescale/fsl-ls1028a.dtsi | 8 +++++++-
>>  1 file changed, 7 insertions(+), 1 deletion(-)
>> 
>> diff --git a/arch/arm64/boot/dts/freescale/fsl-ls1028a.dtsi 
>> b/arch/arm64/boot/dts/freescale/fsl-ls1028a.dtsi
>> index 72b9a75976a1..dc75534a4754 100644
>> --- a/arch/arm64/boot/dts/freescale/fsl-ls1028a.dtsi
>> +++ b/arch/arm64/boot/dts/freescale/fsl-ls1028a.dtsi
>> @@ -102,7 +102,7 @@
>> 
>>  	reboot {
>>  		compatible ="syscon-reboot";
>> -		regmap = <&dcfg>;
>> +		regmap = <&rst>;
>>  		offset = <0xb0>;
>>  		mask = <0x02>;
>>  	};
>> @@ -161,6 +161,12 @@
>>  			big-endian;
>>  		};
>> 
>> +		rst: syscon@1e60000 {
>> +			compatible = "fsl,ls1028a-rst", "syscon";
> 
> Compatible "fsl,ls1028a-rst" seems undocumented?

it is the same with fsl,ls1028a-scfg and fsl,ls1028a-dcfg. So maybe I 
should just drop the "fsl,ls1028a-rst". What do you think?

-michael

> 
> Shawn
> 
>> +			reg = <0x0 0x1e60000 0x0 0x10000>;
>> +			little-endian;
>> +		};
>> +
>>  		scfg: syscon@1fc0000 {
>>  			compatible = "fsl,ls1028a-scfg", "syscon";
>>  			reg = <0x0 0x1fc0000 0x0 0x10000>;
>> --
>> 2.20.1
>> 
