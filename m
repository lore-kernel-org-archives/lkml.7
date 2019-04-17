Return-Path: <SRS0=uTOJ=ST=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2212DC10F12
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Apr 2019 04:56:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D497E204EC
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Apr 2019 04:56:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=cumulusnetworks.com header.i=@cumulusnetworks.com header.b="IvjpsbZj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728639AbfDQE4F (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Apr 2019 00:56:05 -0400
Received: from mail-pf1-f177.google.com ([209.85.210.177]:39510 "EHLO
        mail-pf1-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725844AbfDQE4E (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Apr 2019 00:56:04 -0400
Received: by mail-pf1-f177.google.com with SMTP id i17so11493867pfo.6
        for <linux-kernel@vger.kernel.org>; Tue, 16 Apr 2019 21:56:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cumulusnetworks.com; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=gxu2G3wGYcAjAQVi99x8q+SfUi8Y9o6mEIraeeqaZdo=;
        b=IvjpsbZjazYT96KHNZmCNiWmeGS6ZFbcn2IV2GoNjuA3npgyeUSgPP9KGGBI4hWT73
         wsRtwSqKckkiEDbAde9BQecmi89nSuZZKmYgWGW0GPSqjOUSTIaPslNMdgnnJhj5ymTE
         Djkccv7oYxj2x6gGePXFkN0nbQrog3RV448/A=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=gxu2G3wGYcAjAQVi99x8q+SfUi8Y9o6mEIraeeqaZdo=;
        b=kFfKDkeV/GDBILTWCbQhXWViadNEiTLsWTQczz6yJh9MPxZ9ClAAIBsOANaHuNy3NR
         AvVykuE+iryHyRIyy0gQHT8u84+Xvugv6moRU1cf7Q50ztrfjbsjje3Ay/d9z01x/rNL
         Ba2xytuDOGHiLSFg1Q6RfHFXbdTAIHxNzHDr0NGaQ7Iudy+xt74kl6BLk2iPX6RNOjYa
         Xy7qAUUPQr3nQCT2qql25diVIW+LfA+l0MC/XTv7zLcybIYhg2us9vhwLUJczl1eKdwE
         VghMkomRtBsdtiU2hT4qfsakZg+Gvr4kOJtLNVAMymIoABZAaoN2WGh+eSPi89NTzvhV
         ljXA==
X-Gm-Message-State: APjAAAXMwG4exZVJLfisQDl7QvQ4nIQOzcJZQrK3SQ5aYM1XjYT1X5zs
        6BeDn4ULU0XhlCkXNHipERaz19TrEfE=
X-Google-Smtp-Source: APXvYqyuzYphVEWTN1DUzboMm9dso2BRziWJoDAM2B4e08XetcPHvp8F+EU5wOC8wh6d2qyRAWe9kA==
X-Received: by 2002:a63:90c3:: with SMTP id a186mr71991550pge.306.1555476963966;
        Tue, 16 Apr 2019 21:56:03 -0700 (PDT)
Received: from ?IPv6:2601:282:800:fd80:14a8:cdd5:560c:a7cd? ([2601:282:800:fd80:14a8:cdd5:560c:a7cd])
        by smtp.googlemail.com with ESMTPSA id 6sm70088632pfj.95.2019.04.16.21.56.02
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 16 Apr 2019 21:56:02 -0700 (PDT)
Subject: Re: some trouble when using vrf
To:     linmiaohe <linmiaohe@huawei.com>, shrijeet@gmail.com,
        davem@davemloft.net, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Mingfangsen <mingfangsen@huawei.com>
References: <15adf635-a74b-e9e3-5dad-b35890f0a746@huawei.com>
 <e4aa6621-8d9b-8d69-0562-610bae347ad3@cumulusnetworks.com>
 <f106ad99-c0a3-346c-f01f-d6e48ab4b628@huawei.com>
From:   David Ahern <dsa@cumulusnetworks.com>
Message-ID: <f3e65ab8-0677-b2c7-2163-59b6f845a96b@cumulusnetworks.com>
Date:   Tue, 16 Apr 2019 22:56:01 -0600
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.14; rv:52.0)
 Gecko/20100101 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <f106ad99-c0a3-346c-f01f-d6e48ab4b628@huawei.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/16/19 8:22 PM, linmiaohe wrote:
> 
> 
> On 2019/4/16 23:20, David Ahern wrote:
>> On 4/16/19 5:26 AM, linmiaohe wrote:
>>>     ...
>>>     bind(sock_fd, (struct sockaddr *)&addr_serv, sizeof(addr_serv));
>>>     ...
>>>     ret = setsockopt(sock_fd, SOL_SOCKET, SO_BINDTODEVICE, bind_dev, strlen(bind_dev)+1);
>>>     ...
>>>     This code snipet doesn't work if the ip address of addr_serv is not in default vrf. And
>>> "Cannot assign requested address" will occurs.
>>
>> Applications must bind to the device first and then bind to the local
>> address. As I recall this applies regardless of whether it is a VRF or
>> other.
>>
>>
> It should be, but unfortunately some applications break this.
> 

Sure, I have an open item on my to-do list about re-verifying bound
addresses when the device binding changes (and vice versa). This is not
a problem VRF introduced, but VRF use case does bring more attention to it.
