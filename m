Return-Path: <SRS0=N68d=SK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 16BADC282DD
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Apr 2019 09:03:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D6A2820870
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Apr 2019 09:03:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="I2XoIgar";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="oQkFSLUV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726693AbfDHJDC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Apr 2019 05:03:02 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:54818 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726189AbfDHJDC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Apr 2019 05:03:02 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 42E8E6115D; Mon,  8 Apr 2019 09:03:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1554714180;
        bh=JAudSvMo+oKPB4Yh7pCj14FuEBLsX7U+V8OSf8cUK3A=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=I2XoIgar5V+FIeyPv03a6XzUchhRagm7E9f9nqP+PECqrn7fR5hQ8M5TauyJgtEVf
         VhfmSl4RKKpZHpCkNWGkfe2m2fwLLD7GA9EGZpoy0Otsm4UgslFN69wohcegi7aP+L
         rBB2dWWxotVOjRCzzI6nZHixU93lpN+jlQpUzeE0=
Received: from mail.codeaurora.org (localhost.localdomain [127.0.0.1])
        by smtp.codeaurora.org (Postfix) with ESMTP id EF8CE60712;
        Mon,  8 Apr 2019 09:02:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1554714179;
        bh=JAudSvMo+oKPB4Yh7pCj14FuEBLsX7U+V8OSf8cUK3A=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=oQkFSLUVR+lxyUojY21goKBfnyIpeByazeUDXgODc9OR2Fd/P81YN50fyrPy20axN
         bEXjmNYb0WBCxjtYu+tkPz+wfs3BHTjk2PJaCwAHoAs7OXzcYyBJWFcito3YWMS7y4
         MkTZFM4BF+Fdk1zRc57xpLPWpjVMSeIlxil1bzFQ=
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Mon, 08 Apr 2019 14:32:58 +0530
From:   Sibi Sankar <sibis@codeaurora.org>
To:     Marc Gonzalez <marc.w.gonzalez@free.fr>
Cc:     MSM <linux-arm-msm@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v3 8/9] soc: qcom: rpmpd: Add MSM8998 power-domains
In-Reply-To: <e4506b18-597e-4537-fba1-1cf7ffa60929@free.fr>
References: <20190327123832.11566-1-sibis@codeaurora.org>
 <20190327123832.11566-9-sibis@codeaurora.org>
 <3b3bd18b-4491-c290-a421-7be8df371925@free.fr>
 <a5e9aef9c8d972424f14d5af96a9af58@codeaurora.org>
 <e4506b18-597e-4537-fba1-1cf7ffa60929@free.fr>
Message-ID: <075fecfb62764c2709adb6f252ea7224@codeaurora.org>
X-Sender: sibis@codeaurora.org
User-Agent: Roundcube Webmail/1.2.5
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hey Marc,
Thanks for the review!

On 2019-04-08 14:24, Marc Gonzalez wrote:
> On 08/04/2019 10:30, Sibi Sankar wrote:
>> On 2019-04-05 20:38, Marc Gonzalez wrote:
>>> On 27/03/2019 13:38, Sibi Sankar wrote:
>>> 
>>>> Add the shared cx/mx and sensor sub-system's cx and mx
>>>> power-domains found on MSM8998.
>>>> 
>>>> Signed-off-by: Sibi Sankar <sibis@codeaurora.org>
>>>> ---
>>>>  drivers/soc/qcom/rpmpd.c | 36 ++++++++++++++++++++++++++++++++++++
>>>>  1 file changed, 36 insertions(+)
>>>> 
>>>> diff --git a/drivers/soc/qcom/rpmpd.c b/drivers/soc/qcom/rpmpd.c
>>>> index 238a9e02e890..706a3f63038e 100644
>>>> --- a/drivers/soc/qcom/rpmpd.c
>>>> +++ b/drivers/soc/qcom/rpmpd.c
>>>> @@ -19,9 +19,12 @@
>>>>  /* Resource types */
>>>>  #define RPMPD_SMPA 0x61706d73 /* smpa */
>>>>  #define RPMPD_LDOA 0x616f646c /* ldoa */
>>>> +#define RPMPD_RWCX 0x78637772 /* rwcx */
>>>>  #define RPMPD_RWMX 0x786d7772 /* rwmx */
>>>>  #define RPMPD_RWLC 0x636c7772 /* rwlc */
>>>>  #define RPMPD_RWLM 0x6d6c7772 /* rwlm */
>>>> +#define RPMPD_RWSC 0x63737772 /* rwsc */
>>>> +#define RPMPD_RWSM 0x6d737772 /* rwsm */
>>> 
>>> I do not see any value in the comments. Maybe remove them?
>> 
>> comments were included to add value
>> though, however I guess the comments
>> were definitely not clear enough.
>> The magic values for the resources
>> are calculated as follows:
>> 
>> ascii to hex in reverse order
>> eg: smpa -> 0x61706d73
>> 
>> 0x61 0x70 0x6d 0x73
>>    a    p    m    s
> 
> Ah... I see now.
> 
> I agree that explaining *why* e.g. RPMPD_SMPA is defined as 0x61706d73
> is worthwhile indeed.
> 
> What I meant is that adding /* smpa */ to a macro named RPMPD_SMPA does
> not really bring any new information ;-)

yeah I got that

> 
> How about prefixing the whole block with a small blurb, for example
> 
> /* The value of RPMPD_X is X encoded as a little-endian, lower-case,
> ASCII string */

sure will add this ^^ instead in the next
re-spin

> 
> Regards.

-- 
-- Sibi Sankar --
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project.
