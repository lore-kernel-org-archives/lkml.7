Return-Path: <SRS0=eZ3S=UF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0E77C28CC5
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Jun 2019 02:51:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9E77F20684
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Jun 2019 02:51:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="e8Np/LZT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726638AbfFFCv5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Jun 2019 22:51:57 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:46756 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726427AbfFFCv4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Jun 2019 22:51:56 -0400
Received: by mail-pg1-f195.google.com with SMTP id v9so428011pgr.13;
        Wed, 05 Jun 2019 19:51:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:openpgp:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=wq0lK3Zs3odh/+c4J9zbeW7G1JU08TzCFECFGMK2fpY=;
        b=e8Np/LZTxQzD/6Uh6Q79/22rjVc7dtqAMeruis+e24ETjCOyOqY6ecBisx2Z8W1unm
         k47XZpTffFxMkYmLaPOeqvqbYTalqof6nyRnL8dpP7zRX+eYI4aZ/re3P9Ca7In5beUf
         ilh7VWBJie9rqLtFkT2NJSAPQR7bN5mSIkDXcY8aS8qTBXQ3ldecMPKcZBKBILi2uxUa
         r6KUo3ctYg0jlbq1FO46N7WaoJLY2mDq90Uc4gWae88xE/9rJrxz/LgJ6kdZFzFTRyBg
         qcanDnpm4YxMpfNZNBwzIUb4Uo57RYsD8T/xOsM2Z4zoCULBgJBsRSQEj7hjN9db2z5W
         1FjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=wq0lK3Zs3odh/+c4J9zbeW7G1JU08TzCFECFGMK2fpY=;
        b=ZPxxClnIgLjt2tD4uBEde8UtZYR8O61WJqoBiVtPcam+YOPEQN/3DBBefWVsn2zHc0
         tePbGsZTigqvIdqjMd6QS2yYVBZi1XXyvImqchd+TmY60v6X+NTcsHt1k1kA7smUbgNf
         peCNuh/FclzbZ/2rtcUZZID92iJnS68Hvi+PeiajT9YxlikSSnCwgDLrzp/DE/puyYoe
         7UJt1NPT8pfVPYEtP5NMc4l+ezb2+lo7Hp2za0zKswNbZtiSzymnNSsUh+aA8ootiprH
         9tG2iRJ+ezOI9rFFUlDeZlcDlQXQ/K1skWKIyovL2ZYKub6vXS3+j/xcCbdDM6r3ITO5
         g0sQ==
X-Gm-Message-State: APjAAAW2SefQXyaNHojSlTpSi4BivryDkv65lcXycoYsizy8eBlWC2Nf
        80IePzOExPqA9bv5M6wtRI8=
X-Google-Smtp-Source: APXvYqzHvWobJ+2GneUHS2Wl7McaI0UKtgaYOo1NjVHeXyz1XitFnoDHRCR0oSuvRLB3klf2hfefAg==
X-Received: by 2002:a17:90a:cf0b:: with SMTP id h11mr41868070pju.90.1559789515484;
        Wed, 05 Jun 2019 19:51:55 -0700 (PDT)
Received: from [192.168.1.3] (ip68-101-123-102.oc.oc.cox.net. [68.101.123.102])
        by smtp.gmail.com with ESMTPSA id h14sm242352pgj.8.2019.06.05.19.51.53
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 05 Jun 2019 19:51:54 -0700 (PDT)
Subject: Re: [PATCH V2 1/2] DT: mailbox: add binding doc for the ARM SMC
 mailbox
To:     Andre Przywara <andre.przywara@arm.com>,
        Sudeep Holla <sudeep.holla@arm.com>
Cc:     peng.fan@nxp.com, robh+dt@kernel.org, mark.rutland@arm.com,
        jassisinghbrar@gmail.com, kernel@pengutronix.de, linux-imx@nxp.com,
        shawnguo@kernel.org, festevam@gmail.com,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, van.freenix@gmail.com
References: <20190603083005.4304-1-peng.fan@nxp.com>
 <20190603083005.4304-2-peng.fan@nxp.com>
 <ae4c79f0-4aec-250e-e312-20aba5554665@gmail.com>
 <20190603165651.GA12196@e107155-lin>
 <20190603181856.34996aaa@donnerap.cambridge.arm.com>
From:   Florian Fainelli <f.fainelli@gmail.com>
Openpgp: preference=signencrypt
Message-ID: <19931084-8b12-c510-8856-5cc869e4f9ff@gmail.com>
Date:   Wed, 5 Jun 2019 19:51:52 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <20190603181856.34996aaa@donnerap.cambridge.arm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 6/3/2019 10:18 AM, Andre Przywara wrote:
> On Mon, 3 Jun 2019 17:56:51 +0100
> Sudeep Holla <sudeep.holla@arm.com> wrote:
> 
> Hi,
> 
>> On Mon, Jun 03, 2019 at 09:22:16AM -0700, Florian Fainelli wrote:
>>> On 6/3/19 1:30 AM, peng.fan@nxp.com wrote:  
>>>> From: Peng Fan <peng.fan@nxp.com>
>>>>
>>>> The ARM SMC mailbox binding describes a firmware interface to trigger
>>>> actions in software layers running in the EL2 or EL3 exception levels.
>>>> The term "ARM" here relates to the SMC instruction as part of the ARM
>>>> instruction set, not as a standard endorsed by ARM Ltd.
>>>>
>>>> Signed-off-by: Peng Fan <peng.fan@nxp.com>
>>>> ---
>>>>
>>>> V2:
>>>> Introduce interrupts as a property.
>>>>
>>>> V1:
>>>> arm,func-ids is still kept as an optional property, because there is no
>>>> defined SMC funciton id passed from SCMI. So in my test, I still use
>>>> arm,func-ids for ARM SIP service.
>>>>
>>>>  .../devicetree/bindings/mailbox/arm-smc.txt        | 101 +++++++++++++++++++++
>>>>  1 file changed, 101 insertions(+)
>>>>  create mode 100644 Documentation/devicetree/bindings/mailbox/arm-smc.txt
>>>>
>>>> diff --git a/Documentation/devicetree/bindings/mailbox/arm-smc.txt b/Documentation/devicetree/bindings/mailbox/arm-smc.txt
>>>> new file mode 100644
>>>> index 000000000000..401887118c09
>>>> --- /dev/null
>>>> +++ b/Documentation/devicetree/bindings/mailbox/arm-smc.txt
>>>> @@ -0,0 +1,101 @@  
>>
>> [...]
>>
>>>> +Optional properties:
>>>> +- arm,func-ids		An array of 32-bit values specifying the function
>>>> +			IDs used by each mailbox channel. Those function IDs
>>>> +			follow the ARM SMC calling convention standard [1].
>>>> +			There is one identifier per channel and the number
>>>> +			of supported channels is determined by the length
>>>> +			of this array.
>>>> +- interrupts		SPI interrupts may be listed for notification,
>>>> +			each channel should use a dedicated interrupt
>>>> +			line.  
>>>
>>> I would not go about defining a specific kind of interrupt, since SPI is
>>> a GIC terminology, this firmware interface could be used in premise with
>>> any parent interrupt controller, for which the concept of a SPI/PPI/SGI
>>> may not be relevant.
>>>  
>>
>> While I agree the binding document may not contain specifics, I still
>> don't see how to use SGI with this. Also note it's generally reserved
>> for OS future use(IPC) and using this for other than IPC may be bit
>> challenging IMO. It opens up lots of questions.
> 
> Well, a PPI might be possible to use, although it's somewhat dodgy to hijack the GIC's (re-)distributor from EL3 to write to GICD_ISPENDR<n>. Need to ask Marc about his feelings towards this. But it's definitely possible from a hypervisor to inject arbitrary interrupts into a guest.
> 
> But more importantly: is there any actual reason this needs to be a GIC interrupt? If I understand the code correctly, this could just be any interrupt, including one of an interrupt combiner or a GPIO chip. So why not just use the standard wording of: "exactly one interrupt specifier for each channel"?

That was my point, I am not stuck on using an SGI, or PPI, or anything
(even if that's what we have been using at the moment), any interrupt
would/should do here so the wording should be exactly as you indicated.
-- 
Florian
