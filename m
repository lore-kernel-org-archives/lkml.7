Return-Path: <SRS0=YpA9=XT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D1973C432C1
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Sep 2019 13:16:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9E0CD214AF
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Sep 2019 13:16:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1569330987;
	bh=dBf16uSBC3fnl+ZQos6hHoXefs1lQfAvZkI2t8GiKec=;
	h=Subject:To:Cc:References:From:Date:In-Reply-To:List-ID:From;
	b=rUOjHPyPkZwnDPv0+nLAYD+qD3+RF5M0QvXwKF9WwBwzO6MGE5Kj3hksVoofgtImL
	 mCMWE7PeuY3/d/k6CpMhYFR2k8ul5ejzW7Td+KuWzyc86/4RAZZZDvXjiBW8NEsZIg
	 QkYUjcOUbBgMTGeGcyx66cdJAj1apAF6Nk/ExYTE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2441118AbfIXNQ0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 24 Sep 2019 09:16:26 -0400
Received: from mail-io1-f68.google.com ([209.85.166.68]:40454 "EHLO
        mail-io1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2441095AbfIXNQ0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Sep 2019 09:16:26 -0400
Received: by mail-io1-f68.google.com with SMTP id h144so4276279iof.7
        for <linux-kernel@vger.kernel.org>; Tue, 24 Sep 2019 06:16:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=zmFb2EMPloIisV5Kbr6QTdeXVJWyxzGPjlF8jdYtZhY=;
        b=R97y2O7h9JpTxo7iTteQf4D7XlmtHn3jhm1kp3BIoSz5set7pFabIamGi+la/YSSwA
         FKGjyThEpL1gPa7KpFIFBs3epahZfzxtyBidNH8SkuXbdY3QtCuTYSJcrgmpZAAcjCA0
         w+ios0UGkygezyBYMaYxt8h+ryzqSF2ubgvrQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=zmFb2EMPloIisV5Kbr6QTdeXVJWyxzGPjlF8jdYtZhY=;
        b=A5TiAUOdOG0KjXkQpRW1mpE7zd325xJProoan3jJxAoe+KjAcgvGNHxhBLC/IXp8my
         Q6HptNVqxSkkJN0UJQbLEm8mAlR2V+hGVyCELtgJPCtLmz7TVfheim3iiDpA33EUYAEz
         wjwzLsZ5zUqycGqBp4WNZjnNSOWqcJmlzj14aiSydVfqEpodiOCN59Qby1xD7YJwJoeX
         iGUq/1ZEKXuNZI7wxUGmo8J0p6ntPRWI0LsMMVjsgfBZIMrBaicvzCRTC52F6u7/gHPQ
         E1EVMcfmnr91LREI4fi85nn8e2cC+sdOeiDzKRy8n5wCt6x82dv1GGg8XUk/MARlarp1
         wZBA==
X-Gm-Message-State: APjAAAVscv8wdUV6IplM/BkGi0Jut7lBhF60KSr8sEmK3rSVzmCN/3AT
        G0szeH6rJr0dOTBhS8sUD2LPDA==
X-Google-Smtp-Source: APXvYqy0/c6Bw5NCycjajmI4b6HkHz357M5g1ZkwNKeK3jsgURWsZ+G/d89Bw77UGLHILQXiWxk1Ww==
X-Received: by 2002:a6b:7d4c:: with SMTP id d12mr72693ioq.165.1569330985186;
        Tue, 24 Sep 2019 06:16:25 -0700 (PDT)
Received: from [192.168.1.112] (c-24-9-64-241.hsd1.co.comcast.net. [24.9.64.241])
        by smtp.gmail.com with ESMTPSA id m67sm3374880iof.21.2019.09.24.06.16.23
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 24 Sep 2019 06:16:24 -0700 (PDT)
Subject: Re: [Linux-kernel-mentees] [PATCH] fs: direct-io: Fixed a
 Documentation build warn
To:     Matthew Wilcox <willy@infradead.org>,
        Madhuparna Bhowmik <madhuparnabhowmik04@gmail.com>
Cc:     linux-fsdevel@vger.kernel.org,
        linux-kernel-mentees@lists.linuxfoundation.org,
        linux-kernel@vger.kernel.org,
        "skh >> Shuah Khan" <skhan@linuxfoundation.org>
References: <20190924121920.GA4593@madhuparna-HP-Notebook>
 <20190924122310.GF1855@bombadil.infradead.org>
From:   Shuah Khan <skhan@linuxfoundation.org>
Message-ID: <684ef896-5062-0997-99fe-8395e9f05d9b@linuxfoundation.org>
Date:   Tue, 24 Sep 2019 07:16:23 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190924122310.GF1855@bombadil.infradead.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/24/19 6:23 AM, Matthew Wilcox wrote:
> On Tue, Sep 24, 2019 at 05:49:25PM +0530, Madhuparna Bhowmik wrote:
>> Adds the description about
>> offset within the code.
> 
> Why?
> 
>> @@ -255,6 +254,7 @@ void dio_warn_stale_pagecache(struct file *filp)
>>    */
>>   static ssize_t dio_complete(struct dio *dio, ssize_t ret, unsigned int flags)
>>   {
>> +	/* offset: the byte offset in the file of the completed operation */
>>   	loff_t offset = dio->iocb->ki_pos;
>>   	ssize_t transferred = 0;
>>   	int err;
> 
> This is not normal practice within the Linux kernel.  I suggest reading
> section 8 of Documentation/process/coding-style.rst
> 

You don't combine documentation and code patches. I don't think you need
to add this comment in here.

thanks,
-- Shuah

