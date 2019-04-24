Return-Path: <SRS0=L2S5=S2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 48D7BC282CE
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 21:54:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 18D2620685
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 21:54:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="vDLzFkyA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387651AbfDXVyj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Apr 2019 17:54:39 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:37552 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731991AbfDXVye (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Apr 2019 17:54:34 -0400
Received: by mail-wm1-f66.google.com with SMTP id v14so7215642wmf.2;
        Wed, 24 Apr 2019 14:54:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:openpgp:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=Ywa0GEr5+q0J+nngfui2wYXLreCJ8XAINJaGFZe1lxs=;
        b=vDLzFkyAs+wEzOy2Od8tacpEMYFx+rFXjNYCIwUtbWf1Cj0JsXBwYhi04ne6PQfq7T
         pf12d1miumwEVHNPp9wMJCTOk+3L8lkRFvyPT9Srhr0rSnVNIpue+9SaLDtRdB8GU71n
         A7oZP+ZunAPfXEOqWYX4Oq8glSmNBnM9XSWOLdJMIftHHw6qoSgtLyuXov4jqXL4DQB9
         EJGxMeoIrw1dtgObIxTzcZOLcHKA2tzvBBVfUBZafprJf0lITnH6OWn+HReIyRnEzU1R
         272Bu9Ag//AwLu0dMosw1MHynFQYk0LfVaXeuitFF/iOt0GWq2JmrtvahFi+t7Z0gPVX
         BUfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=Ywa0GEr5+q0J+nngfui2wYXLreCJ8XAINJaGFZe1lxs=;
        b=cAUIJnKhF28H8O4Ff4/WzczV8wvxKr5C6/jGizQf4Grl2Wx55t2B+1d3mcEtTFdhEO
         AaFcqtaX5fcMjLyZ/nHLgDx7AxIh76jvE4INeXRk5CLBwEbvsJfsZyTaTXPjAeP5YsuO
         xL20QK07nxM+f1TNjZKfaZlhr8roN3j2bTPBOy3msj5gM38ysL5a8ZEP8QecgdNtEdhV
         eM0AOhlgq243+DJQu7ulNdRMpNaxPAT2CvX7eTPcCEAjhx4/b8rT16KyHYPHMbMv07/h
         nyczA0yzEzRaFUPJe/zoiWPPNagvp2jDC1dH5hRp2nkrPXP+alt2VSRZwQx/BmQq8SJE
         pfKA==
X-Gm-Message-State: APjAAAXJTtF5bafORuoBohzXMbW0pgqzLhZnmbnaI8O8DJItoTy4/mlY
        rt++xpLiqCWUJLdT5GEX3fQ=
X-Google-Smtp-Source: APXvYqyAd29gP7tqIiGQen0CPRr7KbXNk1rSvbM2VpDDHWajFtuidQPb2du+AiMdIdhNMHNXH+jIyQ==
X-Received: by 2002:a1c:a384:: with SMTP id m126mr791478wme.99.1556142872203;
        Wed, 24 Apr 2019 14:54:32 -0700 (PDT)
Received: from [192.168.1.4] (ip-86-49-110-70.net.upcbroadband.cz. [86.49.110.70])
        by smtp.gmail.com with ESMTPSA id r6sm14732088wmc.11.2019.04.24.14.54.30
        (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
        Wed, 24 Apr 2019 14:54:31 -0700 (PDT)
Subject: Re: [PATCH v12 3/3] dt-bindings: mfd: Document Renesas R-Car Gen3
 RPC-IF MFD bindings
To:     Rob Herring <robh@kernel.org>, Mason Yang <masonccyang@mxic.com.tw>
Cc:     broonie@kernel.org, linux-kernel@vger.kernel.org,
        linux-spi@vger.kernel.org, bbrezillon@kernel.org,
        linux-renesas-soc@vger.kernel.org,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        lee.jones@linaro.org, sergei.shtylyov@cogentembedded.com,
        mark.rutland@arm.com, devicetree@vger.kernel.org,
        juliensu@mxic.com.tw, Simon Horman <horms@verge.net.au>,
        zhengxunli@mxic.com.tw
References: <1556092536-17095-1-git-send-email-masonccyang@mxic.com.tw>
 <1556092536-17095-4-git-send-email-masonccyang@mxic.com.tw>
 <20190424212356.GA27103@bogus>
From:   Marek Vasut <marek.vasut@gmail.com>
Openpgp: preference=signencrypt
Message-ID: <65853dc2-6f3c-1494-7e72-54877797cdd2@gmail.com>
Date:   Wed, 24 Apr 2019 23:54:30 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190424212356.GA27103@bogus>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/24/19 11:23 PM, Rob Herring wrote:
> On Wed, Apr 24, 2019 at 03:55:36PM +0800, Mason Yang wrote:
>> Document the bindings used by the Renesas R-Car Gen3 RPC-IF MFD.
>>
>> Signed-off-by: Mason Yang <masonccyang@mxic.com.tw>
>> ---
>>  .../devicetree/bindings/mfd/mfd-renesas-rpc.txt    | 40 ++++++++++++++++++++++
>>  1 file changed, 40 insertions(+)
>>  create mode 100644 Documentation/devicetree/bindings/mfd/mfd-renesas-rpc.txt
>>
>> diff --git a/Documentation/devicetree/bindings/mfd/mfd-renesas-rpc.txt b/Documentation/devicetree/bindings/mfd/mfd-renesas-rpc.txt
>> new file mode 100644
>> index 0000000..668b822
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/mfd/mfd-renesas-rpc.txt
>> @@ -0,0 +1,40 @@
>> +Renesas R-Car Gen3 RPC-IF MFD Device Tree Bindings
>> +--------------------------------------------------
> 
> Looks like a SPI flash controller from the example. What makes it an 
> MFD?

It supports both SPI NOR and HyperFlash (CFI-compliant flash with
different bus interface).

>> +
>> +Required properties:
>> +- compatible: should be an SoC-specific compatible value, followed by
>> +		"renesas,rcar-gen3-rpc" as a fallback.
>> +		supported SoC-specific values are:
>> +		"renesas,r8a77995-rpc"	(R-Car D3)
>> +- reg: should contain three register areas:
>> +	first for the base address of RPC-IF registers,
>> +	second for the direct mapping read mode and
>> +	third for the write buffer area.
>> +- reg-names: should contain "regs", "dirmap" and "wbuf"
>> +- clocks: should contain 1 entries for the module's clock
>> +- clock-names: should contain "rpc"
>> +- #address-cells: should be 1
>> +- #size-cells: should be 0
>> +
>> +Example:
>> +
>> +	rpc: rpc-if@ee200000 {
>> +		compatible = "renesas,r8a77995-rpc", "renesas,rcar-gen3-rpc";
>> +		reg = <0 0xee200000 0 0x200>, <0 0x08000000 0 0x4000000>,
>> +		      <0 0xee208000 0 0x100>;
>> +		reg-names = "regs", "dirmap", "wbuf";
>> +		clocks = <&cpg CPG_MOD 917>;
>> +		clock-names = "rpc";
>> +		power-domains = <&sysc R8A77995_PD_ALWAYS_ON>;
>> +		resets = <&cpg 917>;
>> +		#address-cells = <1>;
>> +		#size-cells = <0>;
>> +
>> +		flash@0 {
>> +			compatible = "jedec,spi-nor";
>> +			reg = <0>;
>> +			spi-max-frequency = <40000000>;
>> +			spi-tx-bus-width = <1>;
>> +			spi-rx-bus-width = <1>;
>> +		};
>> +	};
>> -- 
>> 1.9.1
>>


-- 
Best regards,
Marek Vasut
