Return-Path: <SRS0=/BZh=RY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15F8CC43381
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Mar 2019 07:55:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DA26B218B0
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Mar 2019 07:55:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="KRDQgFpY";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="PnVZL893"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727903AbfCUHzJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Mar 2019 03:55:09 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:47014 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727776AbfCUHzI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Mar 2019 03:55:08 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 3F81D60A43; Thu, 21 Mar 2019 07:55:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1553154907;
        bh=6HLZLXqAu+OAKx0tuTz/DZ4oCpkPVKbmwROnZg1VfXk=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=KRDQgFpYsB3A5Tx0iOYsHv1te4pgAWUxFMn4rWhxz8GWXvgpFS2rXHv0oLAT1qjTZ
         LjAiMpTTTcHwJHQlZVgdtKBU6kU7OP8RdoR4b/mrME7vAhBkZomTtOqgWy220lnAih
         U2qCFs8+xS27+aK2ATESa+INacXW+lMKP9l5T/s4=
Received: from [10.79.163.157] (blr-bdr-fw-01_globalnat_allzones-outside.qualcomm.com [103.229.18.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: mojha@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 62BC4608FC;
        Thu, 21 Mar 2019 07:54:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1553154906;
        bh=6HLZLXqAu+OAKx0tuTz/DZ4oCpkPVKbmwROnZg1VfXk=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=PnVZL893t+ixLUwW4luUHWSCkcCitXMUk8LmenhDESWp1q0HI9CdaUZdbxhy9EYju
         nvNFiB5MY3JYgx2AOYcDd2NUfOdTasWGq5ab1Gt2UHoOxzJKlWWzMzJbVviO4bBiYA
         4xSRTQ0P3Qiq2yIy57Vb16h6nVuwCmpvH0Ik9q4E=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 62BC4608FC
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=mojha@codeaurora.org
Subject: Re: [PATCH -next] ubifs: remove unused function __ubifs_shash_final
To:     Richard Weinberger <richard@nod.at>
Cc:     Yue Haibing <yuehaibing@huawei.com>, dedekind1@gmail.com,
        adrian.hunter@intel.com, linux-kernel@vger.kernel.org,
        linux-mtd@lists.infradead.org
References: <20190320140955.11576-1-yuehaibing@huawei.com>
 <97289b81-ed73-002a-504d-2e82fad153e7@codeaurora.org>
 <2691086.gDEv9kBeKS@blindfold>
From:   Mukesh Ojha <mojha@codeaurora.org>
Message-ID: <289f9994-0980-081e-f913-5729b16d16f4@codeaurora.org>
Date:   Thu, 21 Mar 2019 13:24:55 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <2691086.gDEv9kBeKS@blindfold>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 3/21/2019 1:48 AM, Richard Weinberger wrote:
> Am Mittwoch, 20. März 2019, 21:05:37 CET schrieb Mukesh Ojha:
>> On 3/20/2019 7:39 PM, Yue Haibing wrote:
>>> From: YueHaibing <yuehaibing@huawei.com>
>>>
>>> There is no callers in tree, and can be removed.
>>>
>>> Signed-off-by: YueHaibing <yuehaibing@huawei.com>
>>> ---
>>>    fs/ubifs/auth.c | 18 ------------------
>>>    1 file changed, 18 deletions(-)
>>>
>>> diff --git a/fs/ubifs/auth.c b/fs/ubifs/auth.c
>>> index 5bf5fd0..2a40ccce 100644
>>> --- a/fs/ubifs/auth.c
>>> +++ b/fs/ubifs/auth.c
>>> @@ -147,24 +147,6 @@ struct shash_desc *__ubifs_hash_get_desc(const struct ubifs_info *c)
>>>    }
>>>    
>>>    /**
>>> - * __ubifs_shash_final - finalize shash
>>> - * @c: UBIFS file-system description object
>>> - * @desc: the descriptor
>>> - * @out: the output hash
>>> - *
>>> - * Simple wrapper around crypto_shash_final(), safe to be called with
>>> - * disabled authentication.
>>> - */
>>> -int __ubifs_shash_final(const struct ubifs_info *c, struct shash_desc *desc,
>>> -			u8 *out)
>>> -{
>>> -	if (ubifs_authenticated(c))
>>> -		return crypto_shash_final(desc, out);
>>> -
>>> -	return 0;
>>> -}
>>> -
>>> -/**
>>>     * ubifs_bad_hash - Report hash mismatches
>>>     * @c: UBIFS file-system description object
>>>     * @node: the node
>>
>>
>> Looks fine to be removed.
>>
>> Acked-by: Mukesh Ojha <mojha@codeaurora.org>
> I guess you mean Reviewed-by?

As i am unsure about future scope of this func. i.e why Acked.


-Mukesh



>
> Thanks,
> //richard
>
>
>
