Return-Path: <SRS0=HfRD=XN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A2EF3C4CEC9
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Sep 2019 22:32:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7176E21927
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Sep 2019 22:32:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="OAguUzqo";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="Ao+QsFJR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731036AbfIRWcQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 18 Sep 2019 18:32:16 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:44830 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730847AbfIRWcQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Sep 2019 18:32:16 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 38CC5611CE; Wed, 18 Sep 2019 22:32:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1568845935;
        bh=Nn2KgLmrM9Q93wmCCCAjiSFicJ0JbQsJ0LmX1D/4XY4=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=OAguUzqoK/ugGzIxirfunhIKhnIlkT+D9gy4gHfSTFf2DXUhLi0oTF6RaF05r3bR3
         EF9YncIT19x/peVRYwf8G6mV+OYESM4wNEgf3C1EDPk/AVDV8CohnV7vgKYKMbsIWx
         K9cW7dcD5AGirHlvN3Wn/PldRxmJ+hIduVZITdYY=
Received: from mail.codeaurora.org (localhost.localdomain [127.0.0.1])
        by smtp.codeaurora.org (Postfix) with ESMTP id B039260A60;
        Wed, 18 Sep 2019 22:32:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1568845934;
        bh=Nn2KgLmrM9Q93wmCCCAjiSFicJ0JbQsJ0LmX1D/4XY4=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=Ao+QsFJRbm18x3FwzvGWCr36fGLRBW8Tq84u71Fz3Jtcyn1ve5EkHYdhE/0yM/Dk9
         HQC/WeCQ69LpHM5D3Y6Jmd4SuvmzjDswaN0BehE/dHlYbmE8nu1NW9TOUkeGX2FYwx
         bmzukqqanpxSU0TWMx+uVyL2EwaaP7tERM5f5P/M=
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Wed, 18 Sep 2019 15:32:14 -0700
From:   rananta@codeaurora.org
To:     Rob Herring <robh+dt@kernel.org>
Cc:     Frank Rowand <frowand.list@gmail.com>,
        Trilok Soni <tsoni@codeaurora.org>,
        Android Kernel Team <kernel-team@android.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] of: Add of_get_memory_prop()
In-Reply-To: <CAL_JsqJ2WeW0JHSHZuvo9bbc7JSFBr_qCuOp97i=b6Q+OPY7Cg@mail.gmail.com>
References: <20190918184656.7633-1-rananta@codeaurora.org>
 <CAL_JsqJ2WeW0JHSHZuvo9bbc7JSFBr_qCuOp97i=b6Q+OPY7Cg@mail.gmail.com>
Message-ID: <19d727bbfce08e59294920ba8097be7a@codeaurora.org>
X-Sender: rananta@codeaurora.org
User-Agent: Roundcube Webmail/1.2.5
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2019-09-18 13:13, Rob Herring wrote:
> On Wed, Sep 18, 2019 at 1:47 PM Raghavendra Rao Ananta
> <rananta@codeaurora.org> wrote:
>> 
>> On some embedded systems, the '/memory' dt-property gets updated
>> by the bootloader (for example, the DDR configuration) and then
>> gets passed onto the kernel. The device drivers may have to read
>> the properties at runtime to make decisions. Hence, add
>> of_get_memory_prop() for the device drivers to query the requested
> 
> Function name doesn't match. Device drivers don't need to access the 
> FDT.
> 
>> properties.
>> 
>> Signed-off-by: Raghavendra Rao Ananta <rananta@codeaurora.org>
>> ---
>>  drivers/of/fdt.c       | 27 +++++++++++++++++++++++++++
>>  include/linux/of_fdt.h |  1 +
>>  2 files changed, 28 insertions(+)
> 
> We don't add kernel api's without users.
> 
>> 
>> diff --git a/drivers/of/fdt.c b/drivers/of/fdt.c
>> index 223d617ecfe1..925cf2852433 100644
>> --- a/drivers/of/fdt.c
>> +++ b/drivers/of/fdt.c
>> @@ -79,6 +79,33 @@ void __init of_fdt_limit_memory(int limit)
>>         }
>>  }
>> 
>> +/**
>> + * of_fdt_get_memory_prop - Return the requested property from the 
>> /memory node
>> + *
>> + * On match, returns a non-zero positive value which represents the 
>> property
>> + * value. Otherwise returns -ENOENT.
>> + */
>> +int of_fdt_get_memory_prop(const char *pname)
>> +{
>> +       int memory;
>> +       int len;
>> +       fdt32_t *prop = NULL;
>> +
>> +       if (!pname)
>> +               return -EINVAL;
>> +
>> +       memory = fdt_path_offset(initial_boot_params, "/memory");
> 
> Memory nodes should have a unit-address, so this won't work frequently.
Sorry, can you please elaborate more on this? What do you mean by 
unit-address and working frequently?
> 
>> +       if (memory > 0)
>> +               prop = fdt_getprop_w(initial_boot_params, memory,
>> +                                 pname, &len);
>> +
>> +       if (!prop || len != sizeof(u32))
>> +               return -ENOENT;
>> +
>> +       return fdt32_to_cpu(*prop);
>> +}
>> +EXPORT_SYMBOL_GPL(of_fdt_get_memory_prop);
>> +
>>  static bool of_fdt_device_is_available(const void *blob, unsigned 
>> long node)
>>  {
>>         const char *status = fdt_getprop(blob, node, "status", NULL);
>> diff --git a/include/linux/of_fdt.h b/include/linux/of_fdt.h
>> index acf820e88952..537f29373358 100644
>> --- a/include/linux/of_fdt.h
>> +++ b/include/linux/of_fdt.h
>> @@ -38,6 +38,7 @@ extern char __dtb_end[];
>>  /* Other Prototypes */
>>  extern u64 of_flat_dt_translate_address(unsigned long node);
>>  extern void of_fdt_limit_memory(int limit);
>> +extern int of_fdt_get_memory_prop(const char *pname);
>>  #endif /* CONFIG_OF_FLATTREE */
>> 
>>  #ifdef CONFIG_OF_EARLY_FLATTREE
>> --
>> The Qualcomm Innovation Center, Inc. is a member of the Code Aurora 
>> Forum,
>> a Linux Foundation Collaborative Project
>> 
- Raghavendra
