Return-Path: <SRS0=GgR0=RR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8537DC43381
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Mar 2019 15:27:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3BF712087C
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Mar 2019 15:27:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=umn.edu header.i=@umn.edu header.b="l/VXi49B"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727170AbfCNP1G (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Mar 2019 11:27:06 -0400
Received: from mta-p6.oit.umn.edu ([134.84.196.206]:42566 "EHLO
        mta-p6.oit.umn.edu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726733AbfCNP1F (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Mar 2019 11:27:05 -0400
Received: from localhost (unknown [127.0.0.1])
        by mta-p6.oit.umn.edu (Postfix) with ESMTP id E7B44C9B
        for <linux-kernel@vger.kernel.org>; Thu, 14 Mar 2019 15:27:03 +0000 (UTC)
X-Virus-Scanned: amavisd-new at umn.edu
Received: from mta-p6.oit.umn.edu ([127.0.0.1])
        by localhost (mta-p6.oit.umn.edu [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id LtrfTXzI1_23 for <linux-kernel@vger.kernel.org>;
        Thu, 14 Mar 2019 10:27:03 -0500 (CDT)
Received: from mail-it1-f197.google.com (mail-it1-f197.google.com [209.85.166.197])
        (using TLSv1.2 with cipher AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mta-p6.oit.umn.edu (Postfix) with ESMTPS id BD72C75D
        for <linux-kernel@vger.kernel.org>; Thu, 14 Mar 2019 10:27:03 -0500 (CDT)
Received: by mail-it1-f197.google.com with SMTP id 142so4992403itx.0
        for <linux-kernel@vger.kernel.org>; Thu, 14 Mar 2019 08:27:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=umn.edu; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=DoQjatCc8NV1zqyAOpY6g4GBsJGsUH2T49/BC04TZIM=;
        b=l/VXi49BHToABqi7TghjFxKekwFKJHH/PqvTnMa3Jvxrcib/+jHEh0tDU3H3IaiX0n
         JEwoyZZVWSLdnKBaMh/MTRY2JwJ+deLdTDFGBAlDQ/axB06BcCgqXDRaYoGszEteqp09
         kPhrMLSrSJlTd0F9p/6ciKpY4R99kYuHiQhHW4aO7WXRGG7RFz70Kuf8ETTpeE96Kkpr
         e+4CzTC7pIJa4xNSWxo4nAD8dxY6fiVS9/9VGAHb2xR3wAONts0SKCVo6IQGPCt2UImo
         k8BCojzuJAB91Uef3k22GbSijWGcj1fhWAQ5EuzTCvp8f0mj0/+aYe9Oy0IapM6ZeDBT
         Gw8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=DoQjatCc8NV1zqyAOpY6g4GBsJGsUH2T49/BC04TZIM=;
        b=DmiuiE+26EVTXmcNd75R+y0quDHYwi1R8b/Gq/9xpHQYhbfq1VHX/dUMeMIkvxnT/w
         uN0xACf2DlvRs6xsoe5OFA724gLQu9mYltsupdSUKSYECuvM0uz8/ToyiKDbd+g0Rbrt
         BPdUltk8hIlGsuFbyyuoW2soyGHDY1l4JJhAfMdzefbNMo6iv3cUYG/YpXjWl9mNuBo4
         R9h8rdraUQps/Eeu42g1YN1kfvXxMSWk8fvbhsT/ahs5AzEDLjUeRJvoOwyzEOurYFkc
         PmNsSaUny8gRN2tf5fgyR8wBBmMC6zhA0zABNVhyw+0A27IIY6Xk8yrtszhG/2AGmHl9
         IheQ==
X-Gm-Message-State: APjAAAWAoItvUB9y4F4vJgAvNnk/CMYeBsOufF1UnLYV9f8R2blgGjGp
        EnexeFn+0Psic9ozrUNCaip9fMWRiJGfgBICs47wOapaR1Izwlefr7ujlCifC6AuJhOFQWC9XQC
        NjDhgP6SabxQvOZpRM8uG5SRz6B7s
X-Received: by 2002:a5d:97c8:: with SMTP id k8mr28040423ios.267.1552577222813;
        Thu, 14 Mar 2019 08:27:02 -0700 (PDT)
X-Google-Smtp-Source: APXvYqz6JOW5GWjs/4B3aiko/w2q1vi1OABSjfFs6xNTAig5EL63nZ9abfGs633jf8TjSgiEzE/1nA==
X-Received: by 2002:a5d:97c8:: with SMTP id k8mr28040399ios.267.1552577222398;
        Thu, 14 Mar 2019 08:27:02 -0700 (PDT)
Received: from [128.101.106.63] (cs-bee-u.cs.umn.edu. [128.101.106.63])
        by smtp.gmail.com with ESMTPSA id t19sm761233iol.72.2019.03.14.08.26.59
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 14 Mar 2019 08:27:00 -0700 (PDT)
Subject: Re: [PATCH] btrfs: fix a NULL pointer dereference
To:     Qu Wenruo <quwenruo.btrfs@gmx.com>,
        Nikolay Borisov <nborisov@suse.com>
Cc:     pakki001@umn.edu, Chris Mason <clm@fb.com>,
        Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>, linux-btrfs@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20190314075041.28966-1-kjlu@umn.edu>
 <b0b494f4-8686-8e50-faca-625d6f89bbe3@suse.com>
 <50fa02f1-18c0-b039-ec2f-e16b715f53ff@gmx.com>
 <fcdf722f-d128-03c0-99fb-a220f680193c@suse.com>
 <641736e8-6965-16c6-5b2e-2474d6b72616@gmx.com>
From:   Kangjie Lu <kjlu@umn.edu>
Message-ID: <9c9159c6-0807-65a5-5c26-30134dbb318e@umn.edu>
Date:   Thu, 14 Mar 2019 10:26:58 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.1
MIME-Version: 1.0
In-Reply-To: <641736e8-6965-16c6-5b2e-2474d6b72616@gmx.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 3/14/19 4:15 AM, Qu Wenruo wrote:
>
> On 2019/3/14 下午4:03, Nikolay Borisov wrote:
>>
>> On 14.03.19 г. 10:02 ч., Qu Wenruo wrote:
>>>
>>> On 2019/3/14 下午3:54, Nikolay Borisov wrote:
>>>>
>>>> On 14.03.19 г. 9:50 ч., Kangjie Lu wrote:
>>>>> btrfs_lookup_block_group may fail and return NULL. The fix goes
>>>>> to out when it fails to avoid NULL pointer dereference.
>>>> Actually no, in this case btrfs_lookup_block_group must never fail
>>>> because if we have an allocated eb then it must have been allocated from
>>>> a bg.
>>> Yep, that's the normal case.
>>>
>>> However I'm wondering if it's possible to get a bad eb which is cached.
>>>
>>> Then we could hit such situation.
>>>
>>> So I still believe being safe here still makes sense, especially who
>>> knows future fuzzed image will be.
>> Then I'd rather have ASSERT(cache)
> Isn't assert() a bad idea for production build without assert() support?

I also agree with that, in general, assert should not be used in

production runs. The first patch might be better.


>
> Thanks,
> Qu
>
>>> Thanks,
>>> Qu
>>>
>>>>> Signed-off-by: Kangjie Lu <kjlu@umn.edu>
>>>>> ---
>>>>>   fs/btrfs/extent-tree.c | 2 ++
>>>>>   1 file changed, 2 insertions(+)
>>>>>
>>>>> diff --git a/fs/btrfs/extent-tree.c b/fs/btrfs/extent-tree.c
>>>>> index 994f0cc41799..b1e7985bcb9d 100644
>>>>> --- a/fs/btrfs/extent-tree.c
>>>>> +++ b/fs/btrfs/extent-tree.c
>>>>> @@ -7303,6 +7303,8 @@ void btrfs_free_tree_block(struct btrfs_trans_handle *trans,
>>>>>   
>>>>>   		pin = 0;
>>>>>   		cache = btrfs_lookup_block_group(fs_info, buf->start);
>>>>> +		if (!cache)
>>>>> +			goto out;
>>>>>   
>>>>>   		if (btrfs_header_flag(buf, BTRFS_HEADER_FLAG_WRITTEN)) {
>>>>>   			pin_down_extent(fs_info, cache, buf->start,
>>>>>
