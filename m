Return-Path: <SRS0=qq9d=V6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A6C6C433FF
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Aug 2019 14:42:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E855A21726
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Aug 2019 14:42:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1564756949;
	bh=35vK+ar+Nb48ekiE/YuVGT1lyA6NEm0vIuOltepn4ZY=;
	h=Subject:To:Cc:References:From:Date:In-Reply-To:List-ID:From;
	b=WS3mzUPdPfxG+PmdLBuaszTwwIzLg86ekmKFwOxrd2MBNP8oGyOPHMrZgqZCzofNF
	 MTkredCAr6OQzmRjvVhk09lMz6R8+ZrZ5M3QVjl1Vprqaz46CESX0a1mcI/ELmPGmm
	 9UOe7VWMJ6HbjilbeEkO4fAD86eZ7CxsxVYYmRBs=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2395011AbfHBOm2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 2 Aug 2019 10:42:28 -0400
Received: from mail.kernel.org ([198.145.29.99]:46924 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731951AbfHBOm1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Aug 2019 10:42:27 -0400
Received: from [192.168.1.17] (cpe-70-114-128-244.austin.res.rr.com [70.114.128.244])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3612220B7C;
        Fri,  2 Aug 2019 14:42:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1564756946;
        bh=35vK+ar+Nb48ekiE/YuVGT1lyA6NEm0vIuOltepn4ZY=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=boN60vKXT6tMVuyo72YVzC0IbQ+a5sXzCgdNSxA1ySbbmVs5AUtjR+c8iU0LPOnpx
         LPGiv37505ALxXQTltfl/2nOCNxXZK2ZbSklU5cFBpHD0hAuRdXedlQoejQfZDY7qu
         k6rNwRSZwBPldvBBkk+Dmk0TSbFUxWyiSUXql6iA=
Subject: Re: [PATCH] drivers/amba: add reset control to primecell probe
To:     Rob Herring <robh+dt@kernel.org>
Cc:     devicetree@vger.kernel.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Frank Rowand <frowand.list@gmail.com>,
        Kees Cook <keescook@chromium.org>,
        Anton Vorontsov <anton@enomsg.org>,
        Colin Cross <ccross@android.com>,
        Tony Luck <tony.luck@intel.com>,
        Dinh Nguyen <dinh.nguyen@intel.com>
References: <20190801184346.7015-1-dinguyen@kernel.org>
 <CAL_Jsq+PRKGwdozr3VECpk2ugrOuWd4CYnRSR7ChyPOKgheYkw@mail.gmail.com>
From:   Dinh Nguyen <dinguyen@kernel.org>
Openpgp: preference=signencrypt
Autocrypt: addr=dinguyen@kernel.org; prefer-encrypt=mutual; keydata=
 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
Message-ID: <92009928-3df1-1573-7d67-40e79d77c77e@kernel.org>
Date:   Fri, 2 Aug 2019 09:42:24 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <CAL_Jsq+PRKGwdozr3VECpk2ugrOuWd4CYnRSR7ChyPOKgheYkw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 8/2/19 9:37 AM, Rob Herring wrote:
> On Thu, Aug 1, 2019 at 12:44 PM Dinh Nguyen <dinguyen@kernel.org> wrote:
>>
>> From: Dinh Nguyen <dinh.nguyen@intel.com>
>>
>> The primecell controller on some SoCs, i.e. SoCFPGA, is held in reset by
>> default. Until recently, the DMA controller was brought out of reset by the
>> bootloader(i.e. U-Boot). But a recent change in U-Boot, the peripherals that
>> are not used are held in reset and are left to Linux to bring them out of
>> reset.
> 
> You can fix this in the kernel, but any versions before this change
> will remain broken. IMO, the u-boot change should be reverted because
> it is breaking an ABI (though not a good one).
> 

Right, there exists in U-Boot to support legacy platforms before this
recent change. This would be for future versions.

>> Add a mechanism for getting the reset property and de-assert the primecell
>> module from reset if found. This is a not a hard fail if the reset property
>> is not present in the device tree node, so the driver will continue to probe.
> 
> I think this belongs in the AMBA bus code, not the DT code, as that is
> where we already have clock control code for similar reasons.
> 

Ok.

>>
>> Signed-off-by: Dinh Nguyen <dinguyen@kernel.org>
>> ---
>>  drivers/of/platform.c | 14 ++++++++++++++
>>  1 file changed, 14 insertions(+)
>>
>> diff --git a/drivers/of/platform.c b/drivers/of/platform.c
>> index 7801e25e6895..d8945705313d 100644
>> --- a/drivers/of/platform.c
>> +++ b/drivers/of/platform.c
>> @@ -21,6 +21,7 @@
>>  #include <linux/of_irq.h>
>>  #include <linux/of_platform.h>
>>  #include <linux/platform_device.h>
>> +#include <linux/reset.h>
>>
>>  const struct of_device_id of_default_bus_match_table[] = {
>>         { .compatible = "simple-bus", },
>> @@ -229,6 +230,7 @@ static struct amba_device *of_amba_device_create(struct device_node *node,
>>         struct amba_device *dev;
>>         const void *prop;
>>         int i, ret;
>> +       struct reset_control *rstc;
>>
>>         pr_debug("Creating amba device %pOF\n", node);
>>
>> @@ -270,6 +272,18 @@ static struct amba_device *of_amba_device_create(struct device_node *node,
>>                 goto err_free;
>>         }
>>
>> +       /*
>> +        * reset control of the primecell block is optional
>> +        * and will not fail if the reset property is not found.
>> +        */
>> +       rstc = of_reset_control_get_exclusive(node, "dma");
> 
> 'dma' doesn't sound very generic.
>

how about 'primecell' ?

Thanks for the review!

Dinh
