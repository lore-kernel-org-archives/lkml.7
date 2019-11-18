Return-Path: <SRS0=CA45=ZK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E6D97C43215
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Nov 2019 22:13:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B9E3822312
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Nov 2019 22:13:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="eQ0ftPXL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727110AbfKRWNv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Nov 2019 17:13:51 -0500
Received: from lelv0142.ext.ti.com ([198.47.23.249]:44824 "EHLO
        lelv0142.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726272AbfKRWNu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Nov 2019 17:13:50 -0500
Received: from fllv0034.itg.ti.com ([10.64.40.246])
        by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id xAIMDj7L074657;
        Mon, 18 Nov 2019 16:13:45 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1574115225;
        bh=ciTDuWGfvpo0hpX5zn9uvvZx/oLJkM/2ttfzjme3X0E=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=eQ0ftPXL7JFkAQqXrkP0XewTQXg66xO/2PZm03/OdMti+jjQxIO/AfkBRS2I6yovl
         5hGXWF2yA0s9QF88QDMa5hhhVquAS2MZtsF7pFk/WexFQT6A7ZoDqKtQ/5i/YOrvgO
         QRYispLswbLTS61cQGa83kbjNS9koOjbLRPHjNOA=
Received: from DLEE110.ent.ti.com (dlee110.ent.ti.com [157.170.170.21])
        by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id xAIMDj79076237
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 18 Nov 2019 16:13:45 -0600
Received: from DLEE101.ent.ti.com (157.170.170.31) by DLEE110.ent.ti.com
 (157.170.170.21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1847.3; Mon, 18
 Nov 2019 16:13:44 -0600
Received: from lelv0326.itg.ti.com (10.180.67.84) by DLEE101.ent.ti.com
 (157.170.170.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1847.3 via
 Frontend Transport; Mon, 18 Nov 2019 16:13:44 -0600
Received: from [10.250.45.147] (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id xAIMDine017119;
        Mon, 18 Nov 2019 16:13:44 -0600
Subject: Re: [PATCH] ARM: OMAP: Use ARM SMC Calling Convention when OP-TEE is
 available
To:     Tony Lindgren <tony@atomide.com>,
        Mark Rutland <mark.rutland@arm.com>
CC:     <linux-omap@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <20191118165236.22136-1-afd@ti.com>
 <20191118215759.GD35479@atomide.com>
From:   "Andrew F. Davis" <afd@ti.com>
Message-ID: <b86e1d66-1566-521c-a445-4f0ae2fd95d6@ti.com>
Date:   Mon, 18 Nov 2019 17:13:44 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20191118215759.GD35479@atomide.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/18/19 4:57 PM, Tony Lindgren wrote:
> Hi,
> 
> * Andrew F. Davis <afd@ti.com> [191118 08:53]:
>> +#define OMAP_SIP_SMC_STD_CALL_VAL(func_num) \
>> +	ARM_SMCCC_CALL_VAL(ARM_SMCCC_STD_CALL, ARM_SMCCC_SMC_32, \
>> +	ARM_SMCCC_OWNER_SIP, (func_num))
>> +
>> +void omap_smc1(u32 fn, u32 arg)
>> +{
>> +	struct device_node *optee;
>> +	struct arm_smccc_res res;
>> +
>> +	/*
>> +	 * If this platform has OP-TEE installed we use ARM SMC calls
>> +	 * otherwise fall back to the OMAP ROM style calls.
>> +	 */
>> +	optee = of_find_node_by_path("/firmware/optee");
>> +	if (optee) {
>> +		arm_smccc_smc(OMAP_SIP_SMC_STD_CALL_VAL(fn), arg,
>> +			      0, 0, 0, 0, 0, 0, &res);
>> +		WARN(res.a0, "Secure function call 0x%08x failed\n", fn);
>> +	} else {
>> +		_omap_smc1(fn, arg);
>> +	}
>> +}
> 
> I think we're better off just making arm_smccc_smc() work properly.
> See cat arch/arm*/kernel/smccc-call.S.
> 


arm_smccc_smc() does work properly already, I'm using it here.


> If quirk handling is needed, looks like ARM_SMCCC_QUIRK_STATE_OFFS
> can be used.
> 


Tried that [0], was NAKd. Making quirk-free SMCCC calls if OP-TEE is
detected seems to be the suggested path forward, QCOM got a pass,
doesn't look like we will get the same.

+Mark, in case you want to comment if this patch matches what you had in
mind.

[0] https://www.spinics.net/lists/arm-kernel/msg607263.html

Andrew


> AFAIK this should work both for optee and the current use cases.
> 
> Regards,
> 
> Tony
> 
