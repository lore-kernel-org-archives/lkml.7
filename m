Return-Path: <SRS0=wAGj=US=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CCEE5C31E49
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Jun 2019 11:47:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9A5312084A
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Jun 2019 11:47:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=digidescorp.com header.i=@digidescorp.com header.b="o5wUSfyX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731632AbfFSLrM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Jun 2019 07:47:12 -0400
Received: from mail-io1-f66.google.com ([209.85.166.66]:46093 "EHLO
        mail-io1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727067AbfFSLrM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Jun 2019 07:47:12 -0400
Received: by mail-io1-f66.google.com with SMTP id i10so37269430iol.13
        for <linux-kernel@vger.kernel.org>; Wed, 19 Jun 2019 04:47:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=digidescorp.com; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=TrokiQWtWasWHQHXBcBIt5pbwCkDOY1lB9EOcCpAcn0=;
        b=o5wUSfyXFk8rNDfj+nDL9Q4uT6vhYyhzhacq8YpoV6ahw1iZm7tg/+Ly3Yzm8C1jT7
         E6x8iCPGj92sOPNCgpdnjj776R0aCn2WKVgB3BMFxqI0C+tZUWUm8RK3BZEyDSIbGLgS
         roCQihgqAlBYvZYc5YxC8IxFvS8VhrbCRYsp4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=TrokiQWtWasWHQHXBcBIt5pbwCkDOY1lB9EOcCpAcn0=;
        b=NCabT0yxzU/pppm3W5Z8XrZzOr+fc+6TzYxoRsm+dRW2BKv+/MTAkOCkzeKvnA+c82
         7lyStAyQNIDOXVQu+juh/U1duk9CB3rUeWw2GxumGDmRVQLSK2baUqSSsrXSpgVm/eg5
         tmv4ykNGw9DOcoAJ9xJbja4RDiM0GOmDZhdP5oWbAz8EzP61/n81HTOJAt0sUJwo7lIx
         J7GVaIvLepJmfTnJzKIEKZoIFTqufQNcymwyehbUNV8pV4KPZwsPdYbbIAno791Q6zj8
         JPjM+5Gp44GKXx4Dz1/jsIu8MJQY3l2p1VIaVApVK3NWm/bgK/75AdthzoNYDq1z1OPx
         DvYw==
X-Gm-Message-State: APjAAAUEz9IzgX0VoZ3RlLs0lWMeTPAkDC3mT5NrEgGNRALWh9pCPVC9
        KvBexEondVvnT5nBbaoL3ukbBg==
X-Google-Smtp-Source: APXvYqyrrV67fV3R7N6dvZ3l9UhLh+zc1Z3ROwQgHN44aWMcA9/9zgZf2h0prGADuGQS3c/gUOY6yw==
X-Received: by 2002:a02:9991:: with SMTP id a17mr10182371jal.1.1560944831618;
        Wed, 19 Jun 2019 04:47:11 -0700 (PDT)
Received: from [10.10.7.162] ([50.73.98.161])
        by smtp.googlemail.com with ESMTPSA id b20sm13950317ios.44.2019.06.19.04.47.10
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 19 Jun 2019 04:47:11 -0700 (PDT)
Subject: Re: [PATCH 1/1] udf: Fix incorrect final NOT_ALLOCATED (hole) extent
 length
To:     Jan Kara <jack@suse.cz>
Cc:     Jan Kara <jack@suse.com>, linux-kernel@vger.kernel.org,
        "Steven J . Magnani" <steve@digidescorp.com>
References: <20190604123158.12741-1-steve@digidescorp.com>
 <20190604123158.12741-2-steve@digidescorp.com>
 <a6275c24-7625-d532-0842-f8b16fea5b30@digidescorp.com>
 <20190619064711.GA27954@quack2.suse.cz>
From:   Steve Magnani <steve.magnani@digidescorp.com>
Message-ID: <c0c58929-4140-6cdd-77e9-c9c9a43f174d@digidescorp.com>
Date:   Wed, 19 Jun 2019 06:47:10 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190619064711.GA27954@quack2.suse.cz>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/19/19 1:47 AM, Jan Kara wrote:
> Hi Steve!
>
> On Sun 16-06-19 11:28:46, Steve Magnani wrote:
>> On 6/4/19 7:31 AM, Steve Magnani wrote:
>>
>>> In some cases, using the 'truncate' command to extend a UDF file results
>>> in a mismatch between the length of the file's extents (specifically, due
>>> to incorrect length of the final NOT_ALLOCATED extent) and the information
>>> (file) length. The discrepancy can prevent other operating systems
>>> (i.e., Windows 10) from opening the file.
>>>
>>> Two particular errors have been observed when extending a file:
>>>
>>> 1. The final extent is larger than it should be, having been rounded up
>>>      to a multiple of the block size.
>>>
>>> B. The final extent is shorter than it should be, due to not having
>>>      been updated when the file's information length was increased.
>> Wondering if you've seen this, or if something got lost in a spam folder.
> Sorry for not getting to you earlier. I've seen the patches and they look
> reasonable to me. I just wanted to have a one more closer look but last
> weeks were rather busy so I didn't get to it. I'll look into it this week.
> Thanks a lot for debugging the problem and sending the fixes!
>
> 								Honza

No worries. If you're short on time I'd suggest looking first at the ways
udf_do_extend_file() can be called via inode_getblk(). Those were harder for
me to follow so if there is a bug it's most likely in one of those paths.

Regards,
------------------------------------------------------------------------
  Steven J. Magnani               "I claim this network for MARS!
  www.digidescorp.com              Earthling, return my space modulator!"

  #include <standard.disclaimer>

