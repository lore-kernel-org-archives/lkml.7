Return-Path: <SRS0=EIds=SH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C209C4360F
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Apr 2019 07:08:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3980421855
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Apr 2019 07:08:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="dexuZiR6";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="TLnTRVlK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730156AbfDEHIZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 5 Apr 2019 03:08:25 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:46234 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726726AbfDEHIZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Apr 2019 03:08:25 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 3A3C260AD1; Fri,  5 Apr 2019 07:08:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1554448104;
        bh=9Q6Ci0zJvwTg8tN9SeM3mZCRvrTCgqYLofAnl/pEZ54=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=dexuZiR6D7e9tMktk2Y4PUhH7spkHrmObbPfkUWkBzYW2lhV9DsJ9GdpTTOYVW/6G
         NADybdBk7QsiWd1GRMWVc+o2LkRNX+ZZeBxx+4AFxpO4UNXYCmsw72z12/Ac1skmti
         ZeH6vw0BRsVdcnBOzroDelGlYeGmA7ZEJs+SNkbs=
Received: from [10.204.79.83] (blr-c-bdr-fw-01_globalnat_allzones-outside.qualcomm.com [103.229.19.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: mojha@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id CB0FC60A44;
        Fri,  5 Apr 2019 07:08:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1554448103;
        bh=9Q6Ci0zJvwTg8tN9SeM3mZCRvrTCgqYLofAnl/pEZ54=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=TLnTRVlKy3iA2OJtNMbj1Ho/kH89lDEzTrxx3AOTFO0kYg2LFu2RPaTaJvGt2EuYc
         vsPOv1yNNlvje+VUoxr1h+0Y4iM6+9vqI+sm5cfR7CqhvAJulzftFkjjM4xt8EM0/5
         7/xAz+JLaTQloehnHWWX2Xgg3zEaeY0l/z/zFynI=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org CB0FC60A44
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=mojha@codeaurora.org
Subject: Re: [PATCH] remoteproc: silence an uninitialized variable warning
To:     Dan Carpenter <dan.carpenter@oracle.com>
Cc:     Andy Gross <andy.gross@linaro.org>,
        David Brown <david.brown@linaro.org>,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-janitors@vger.kernel.org
References: <20190404084204.GA20193@kadam>
 <a08db945-44d3-ff99-7a89-75367f314855@codeaurora.org>
 <20190404093622.GM32613@kadam>
From:   Mukesh Ojha <mojha@codeaurora.org>
Message-ID: <f570c0c0-1493-88d7-474c-ad7437e6a1d0@codeaurora.org>
Date:   Fri, 5 Apr 2019 12:38:19 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190404093622.GM32613@kadam>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 4/4/2019 3:06 PM, Dan Carpenter wrote:
> On Thu, Apr 04, 2019 at 02:47:39PM +0530, Mukesh Ojha wrote:
>> On 4/4/2019 2:12 PM, Dan Carpenter wrote:
>>> Smatch complains that "ret" might be uninitialized.  I can see why it
>>> generates the warning, but I don't know if it's actually possible.
>>> Anyway initializing "ret" here is harmless.
>>>
>>> Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
>>> ---
>>>    drivers/soc/qcom/mdt_loader.c | 2 +-
>>>    1 file changed, 1 insertion(+), 1 deletion(-)
>>>
>>> diff --git a/drivers/soc/qcom/mdt_loader.c b/drivers/soc/qcom/mdt_loader.c
>>> index 1c488024c698..fc58d660692f 100644
>>> --- a/drivers/soc/qcom/mdt_loader.c
>>> +++ b/drivers/soc/qcom/mdt_loader.c
>>> @@ -188,7 +188,7 @@ static int __qcom_mdt_load(struct device *dev, const struct firmware *fw,
>>>    	if (reloc_base)
>>>    		*reloc_base = mem_reloc;
>>> -
>>> +	ret = 0;
>>
>> You are overriding the value here, better keep it at the start.
> I like how I wrote it.  It makes it clear that this is the success path.


But think about a case when this request_firmware_into_buf fails or the 
snippet above that can set the ret with error value

right.. is not that possible?..and ret = 0 stops propagating the error 
properly.

Thanks
Mukesh

>
> regards,
> dan carpenter
>
