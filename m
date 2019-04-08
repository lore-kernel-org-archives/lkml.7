Return-Path: <SRS0=N68d=SK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D953EC282CE
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Apr 2019 08:30:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A772D20880
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Apr 2019 08:30:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="n6meKKVg";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="n6meKKVg"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726638AbfDHIaH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Apr 2019 04:30:07 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:37770 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725877AbfDHIaH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Apr 2019 04:30:07 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 6146D60303; Mon,  8 Apr 2019 08:30:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1554712206;
        bh=vZHJYlUVSmUj01uqqs7HE5xFWJMWqEwfjF2MB0zqafw=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=n6meKKVgIU6S2entYSpXrxGF3n/1PZ6xLanFcYwhkZoC+GLFeTlwKZAOAwNXOhRvS
         p7sxwXgkJvSJuk4ZdWfHffzctCCxBx++8+0iy96qxtEfvUl03ZCRAtICEBEte+eQrO
         rmEoiZ/cZG+ChK8YvM3qynmfXrFwDw7wyNTYv8W0=
Received: from mail.codeaurora.org (localhost.localdomain [127.0.0.1])
        by smtp.codeaurora.org (Postfix) with ESMTP id E394E60303;
        Mon,  8 Apr 2019 08:30:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1554712206;
        bh=vZHJYlUVSmUj01uqqs7HE5xFWJMWqEwfjF2MB0zqafw=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=n6meKKVgIU6S2entYSpXrxGF3n/1PZ6xLanFcYwhkZoC+GLFeTlwKZAOAwNXOhRvS
         p7sxwXgkJvSJuk4ZdWfHffzctCCxBx++8+0iy96qxtEfvUl03ZCRAtICEBEte+eQrO
         rmEoiZ/cZG+ChK8YvM3qynmfXrFwDw7wyNTYv8W0=
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Mon, 08 Apr 2019 14:00:05 +0530
From:   Sibi Sankar <sibis@codeaurora.org>
To:     Marc Gonzalez <marc.w.gonzalez@free.fr>
Cc:     MSM <linux-arm-msm@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-kernel-owner@vger.kernel.org
Subject: Re: [PATCH v3 8/9] soc: qcom: rpmpd: Add MSM8998 power-domains
In-Reply-To: <3b3bd18b-4491-c290-a421-7be8df371925@free.fr>
References: <20190327123832.11566-1-sibis@codeaurora.org>
 <20190327123832.11566-9-sibis@codeaurora.org>
 <3b3bd18b-4491-c290-a421-7be8df371925@free.fr>
Message-ID: <a5e9aef9c8d972424f14d5af96a9af58@codeaurora.org>
X-Sender: sibis@codeaurora.org
User-Agent: Roundcube Webmail/1.2.5
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2019-04-05 20:38, Marc Gonzalez wrote:
> On 27/03/2019 13:38, Sibi Sankar wrote:
> 
>> Add the shared cx/mx and sensor sub-system's cx and mx
>> power-domains found on MSM8998.
>> 
>> Signed-off-by: Sibi Sankar <sibis@codeaurora.org>
>> ---
>>  drivers/soc/qcom/rpmpd.c | 36 ++++++++++++++++++++++++++++++++++++
>>  1 file changed, 36 insertions(+)
>> 
>> diff --git a/drivers/soc/qcom/rpmpd.c b/drivers/soc/qcom/rpmpd.c
>> index 238a9e02e890..706a3f63038e 100644
>> --- a/drivers/soc/qcom/rpmpd.c
>> +++ b/drivers/soc/qcom/rpmpd.c
>> @@ -19,9 +19,12 @@
>>  /* Resource types */
>>  #define RPMPD_SMPA 0x61706d73 /* smpa */
>>  #define RPMPD_LDOA 0x616f646c /* ldoa */
>> +#define RPMPD_RWCX 0x78637772 /* rwcx */
>>  #define RPMPD_RWMX 0x786d7772 /* rwmx */
>>  #define RPMPD_RWLC 0x636c7772 /* rwlc */
>>  #define RPMPD_RWLM 0x6d6c7772 /* rwlm */
>> +#define RPMPD_RWSC 0x63737772 /* rwsc */
>> +#define RPMPD_RWSM 0x6d737772 /* rwsm */
> 
> I do not see any value in the comments. Maybe remove them?

comments were included to add value
though, however I guess the comments
were definitely not clear enough.
The magic values for the resources
are calculated as follows:

ascii to hex in reverse order
eg: smpa -> 0x61706d73

0x61 0x70 0x6d 0x73
   a    p    m    s

> 
> I will take a closer look at patches 7-9 on Monday.

Thanks for taking time to review
this series.

> 
> Regards.

-- 
-- Sibi Sankar --
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project.
