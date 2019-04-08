Return-Path: <SRS0=N68d=SK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E1E9C282DD
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Apr 2019 08:54:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 663F020880
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Apr 2019 08:54:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726688AbfDHIyq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Apr 2019 04:54:46 -0400
Received: from ns.iliad.fr ([212.27.33.1]:45356 "EHLO ns.iliad.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726189AbfDHIyq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Apr 2019 04:54:46 -0400
Received: from ns.iliad.fr (localhost [127.0.0.1])
        by ns.iliad.fr (Postfix) with ESMTP id 6759A21931;
        Mon,  8 Apr 2019 10:54:44 +0200 (CEST)
Received: from [192.168.108.8] (freebox.vlq16.iliad.fr [213.36.7.13])
        by ns.iliad.fr (Postfix) with ESMTP id 576DB2192F;
        Mon,  8 Apr 2019 10:54:44 +0200 (CEST)
Subject: Re: [PATCH v3 8/9] soc: qcom: rpmpd: Add MSM8998 power-domains
To:     Sibi Sankar <sibis@codeaurora.org>
Cc:     MSM <linux-arm-msm@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
References: <20190327123832.11566-1-sibis@codeaurora.org>
 <20190327123832.11566-9-sibis@codeaurora.org>
 <3b3bd18b-4491-c290-a421-7be8df371925@free.fr>
 <a5e9aef9c8d972424f14d5af96a9af58@codeaurora.org>
From:   Marc Gonzalez <marc.w.gonzalez@free.fr>
Message-ID: <e4506b18-597e-4537-fba1-1cf7ffa60929@free.fr>
Date:   Mon, 8 Apr 2019 10:54:44 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <a5e9aef9c8d972424f14d5af96a9af58@codeaurora.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Virus-Scanned: ClamAV using ClamSMTP ; ns.iliad.fr ; Mon Apr  8 10:54:44 2019 +0200 (CEST)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 08/04/2019 10:30, Sibi Sankar wrote:
> On 2019-04-05 20:38, Marc Gonzalez wrote:
>> On 27/03/2019 13:38, Sibi Sankar wrote:
>>
>>> Add the shared cx/mx and sensor sub-system's cx and mx
>>> power-domains found on MSM8998.
>>>
>>> Signed-off-by: Sibi Sankar <sibis@codeaurora.org>
>>> ---
>>>  drivers/soc/qcom/rpmpd.c | 36 ++++++++++++++++++++++++++++++++++++
>>>  1 file changed, 36 insertions(+)
>>>
>>> diff --git a/drivers/soc/qcom/rpmpd.c b/drivers/soc/qcom/rpmpd.c
>>> index 238a9e02e890..706a3f63038e 100644
>>> --- a/drivers/soc/qcom/rpmpd.c
>>> +++ b/drivers/soc/qcom/rpmpd.c
>>> @@ -19,9 +19,12 @@
>>>  /* Resource types */
>>>  #define RPMPD_SMPA 0x61706d73 /* smpa */
>>>  #define RPMPD_LDOA 0x616f646c /* ldoa */
>>> +#define RPMPD_RWCX 0x78637772 /* rwcx */
>>>  #define RPMPD_RWMX 0x786d7772 /* rwmx */
>>>  #define RPMPD_RWLC 0x636c7772 /* rwlc */
>>>  #define RPMPD_RWLM 0x6d6c7772 /* rwlm */
>>> +#define RPMPD_RWSC 0x63737772 /* rwsc */
>>> +#define RPMPD_RWSM 0x6d737772 /* rwsm */
>>
>> I do not see any value in the comments. Maybe remove them?
> 
> comments were included to add value
> though, however I guess the comments
> were definitely not clear enough.
> The magic values for the resources
> are calculated as follows:
> 
> ascii to hex in reverse order
> eg: smpa -> 0x61706d73
> 
> 0x61 0x70 0x6d 0x73
>    a    p    m    s

Ah... I see now.

I agree that explaining *why* e.g. RPMPD_SMPA is defined as 0x61706d73
is worthwhile indeed.

What I meant is that adding /* smpa */ to a macro named RPMPD_SMPA does
not really bring any new information ;-)

How about prefixing the whole block with a small blurb, for example

/* The value of RPMPD_X is X encoded as a little-endian, lower-case, ASCII string */

Regards.
