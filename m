Return-Path: <SRS0=/BZh=RY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C58A9C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Mar 2019 07:39:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8CCDF218A5
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Mar 2019 07:39:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="Jw0H8Q6n";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="ZmZw3MFQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727891AbfCUHjl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Mar 2019 03:39:41 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:58536 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727823AbfCUHjl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Mar 2019 03:39:41 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 87A81608FC; Thu, 21 Mar 2019 07:39:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1553153979;
        bh=fDvqsOk8Rt/90b31egkgx5yxgXYeCId78ts4V1rUheY=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=Jw0H8Q6nbJgQ8ft08/ZzqMLZSitaYfa0nyAeYvLC4G/P1TS7ygKQX3TLfWh9ssuB9
         V0cW3DfTLEb8StgyzOwwUHq0U+wyVGeoQ8rUA+bzaUwCqpZlcnX3kbFBMiaNgzALPR
         SDX0RkW3ZhetZOZ3R8Ca1zHXp8Ez6Y6F52b1Q9LY=
Received: from [10.79.163.157] (blr-bdr-fw-01_globalnat_allzones-outside.qualcomm.com [103.229.18.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: mojha@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 8B45D6086B;
        Thu, 21 Mar 2019 07:39:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1553153978;
        bh=fDvqsOk8Rt/90b31egkgx5yxgXYeCId78ts4V1rUheY=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=ZmZw3MFQ7oan2orzohCBMWpTCxrKj8kTPkGIj0sDRJgSBu5sObXsLD1MK0LfShCYa
         c+sgCsJabUiCGujGLO7KGCfHHDKbMR7MDN7oJnz95YMJHKDqzkcKCcep6OyKZ2NXlw
         vYo1dYdD5IZSqU9Zf1MeDYgUFBPOp053rzwUHZyY=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 8B45D6086B
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=mojha@codeaurora.org
Subject: Re: [PATCH] of: Drop redundant check in linker section OF match table
To:     Frank Rowand <frowand.list@gmail.com>, linux-kernel@vger.kernel.org
Cc:     Rob Herring <robh@kernel.org>,
        Pantelis Antoniou <pantelis.antoniou@konsulko.com>,
        devicetree@vger.kernel.org
References: <1553078940-9907-1-git-send-email-mojha@codeaurora.org>
 <67db2d00-26d0-f9e3-f4dd-0f48633142a9@gmail.com>
From:   Mukesh Ojha <mojha@codeaurora.org>
Message-ID: <44f8ba04-8a50-fa81-8784-aaffc4f7c3cc@codeaurora.org>
Date:   Thu, 21 Mar 2019 13:09:29 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <67db2d00-26d0-f9e3-f4dd-0f48633142a9@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 3/21/2019 1:25 AM, Frank Rowand wrote:
> On 3/20/19 3:49 AM, Mukesh Ojha wrote:
>> Existing check of `fn` against NULL inside OF match table
>> is redundant. Remove the check.
>>
>> Signed-off-by: Mukesh Ojha <mojha@codeaurora.org>
>> Cc: Rob Herring <robh@kernel.org>
>> Cc: Frank Rowand <frowand.list@gmail.com>
>> Cc: Pantelis Antoniou <pantelis.antoniou@konsulko.com>
>> Cc: devicetree@vger.kernel.org
>> ---
>>   include/linux/of.h | 4 ++--
>>   1 file changed, 2 insertions(+), 2 deletions(-)
>>
>> diff --git a/include/linux/of.h b/include/linux/of.h
>> index e240992..b86c00a 100644
>> --- a/include/linux/of.h
>> +++ b/include/linux/of.h
>> @@ -1283,13 +1283,13 @@ static inline int of_get_available_child_count(const struct device_node *np)
>>   	static const struct of_device_id __of_table_##name		\
>>   		__used __section(__##table##_of_table)			\
>>   		 = { .compatible = compat,				\
>> -		     .data = (fn == (fn_type)NULL) ? fn : fn  }
>> +		     .data = fn }
>>   #else
>>   #define _OF_DECLARE(table, name, compat, fn, fn_type)			\
>>   	static const struct of_device_id __of_table_##name		\
>>   		__attribute__((unused))					\
>>   		 = { .compatible = compat,				\
>> -		     .data = (fn == (fn_type)NULL) ? fn : fn }
>> +		     .data = fn }
>>   #endif
>>   
>>   typedef int (*of_init_fn_2)(struct device_node *, struct device_node *);
>>
> The check is not redundant and does serve a purpose.
>
> The purpose is not very obvious on the surface, but it is checking that
> the function fn() is of the proper type.

Frank,

Thanks for taking out time to explain the stuff, Yeah some miscellaneous 
driver can do this type of mistake.

-Mukesh


> An example of a compiler warning with a bad function type is created
> by applying the following patch:
>
>     drivers/of/unittest.c:62:1: warning: comparison of distinct pointer types lacks a cast [enabled by default]
>
> Note that you need to have CONFIG_UNITTEST enabled to compile unittest.c.
>
> Line 62 is
>     OF_DECLARE_1(__unittest_of_table, unittest_setup_2_bad, "unittest_compat",
>
> ---
>   drivers/of/unittest.c |   17 +++++++++++++++++
>   1 file changed, 17 insertions(+)
>
> Index: b/drivers/of/unittest.c
> ===================================================================
> --- a/drivers/of/unittest.c
> +++ b/drivers/of/unittest.c
> @@ -45,6 +45,23 @@ static struct unittest_results {
>   	failed; \
>   })
>   
> +struct of_device_id __unittest_of_table;
> +
> +static void __init unittest_setup_1_good(struct device_node *np)
> +{
> +}
> +
> +static void __init unittest_setup_2_bad(struct device_node *np_1,
> +	struct device_node *np_2)
> +{
> +}
> +
> +OF_DECLARE_1(__unittest_of_table, unittest_setup_1_good, "unittest_compat",
> +	unittest_setup_1_good);
> +
> +OF_DECLARE_1(__unittest_of_table, unittest_setup_2_bad, "unittest_compat",
> +	unittest_setup_2_bad);
> +
>   static void __init of_unittest_find_node_by_name(void)
>   {
>   	struct device_node *np;
