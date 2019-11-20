Return-Path: <SRS0=lLEG=ZN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC83FC432C0
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Nov 2019 02:06:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BBA532075A
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Nov 2019 02:06:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="Am9AlC+y"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726333AbfKUCGV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Nov 2019 21:06:21 -0500
Received: from mail-pl1-f196.google.com ([209.85.214.196]:46634 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725936AbfKUCGV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Nov 2019 21:06:21 -0500
Received: by mail-pl1-f196.google.com with SMTP id l4so760142plt.13
        for <linux-kernel@vger.kernel.org>; Wed, 20 Nov 2019 18:06:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=uo9mEPcaYcwnzYyWGiXlb2tEqoly25jIf2ri/BJ7dDw=;
        b=Am9AlC+yrXpYjI9tLZJABP+RtHy2I4MpTU3JDy2quw9lARH0E9nsUx5sZLzW3WsDXO
         MTT+d/n1iXXdDWbHu/+5ZNlEjJkBCfuMGQ0lkn8Y7lm/Tzm4N0xy3n8V3/0Et0gCoKEN
         La77ktcLIHHNXLrDobr2UBGIDQa807YwOkRStoKCQx7d8nF5nRTY9eGyAdB04aZCf5yD
         rO4aRJlugOJko5ct311BHN7FOI/OtYpsdzrpnaN7mckQkPbFwVkF+LgJJq63UARVC8nL
         O2ZgCy5Q6Agt+f5TU+Sl3EUB3XFTfODjPAndMGYek+NU+pNGWBS4nA0GY5D6/JQ4Jzi9
         BNsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=uo9mEPcaYcwnzYyWGiXlb2tEqoly25jIf2ri/BJ7dDw=;
        b=oa6/PHB6zaxBF0Wz01lRnyrHPI4gm4HNoPlJeIkYIVv4VWaRkDB0OL6Yqt3Mbt9Q/t
         yap3q55RV8F0xwf2gd+0x2tN10+I2qHEtpfnV6L2cL5C+aMq0i4BQJ0zDCU8oVsxFF6j
         DOwz/sI5Fo6iTmP2lIm0r3u88FTcz9MVOX/ZBY7b9Z18x0HP064o/KQszFeIb1dDXKUv
         Cn6mxCHAXCUkwBU2sSam2Zz001IdO+F2wabW5HDEa5adTeQRgB4yHXT3TIu6LSmv9LhC
         6X9zJQLv15UunKAEjgJdn53Y222o7QxMB1UMSMsnnJu4siDOPRFeXLrDxJD2boEnjMr+
         YpyA==
X-Gm-Message-State: APjAAAW97WOeVYhbPb9jYea67nyMrEDOl1cEZBUxpwQefvIABmepYypa
        zIvW1sgoKFFdQb5dht+o90OYVJ179m5mdw==
X-Google-Smtp-Source: APXvYqytngQq8IjjeiFBpEFRQm5zInwYRJW6QSTLANZYdx6eBrIH2RFe+esQWcWUc+a6h1YGF2wf6w==
X-Received: by 2002:a17:90a:ec13:: with SMTP id l19mr8419701pjy.0.1574301978779;
        Wed, 20 Nov 2019 18:06:18 -0800 (PST)
Received: from [192.168.1.188] ([66.219.217.79])
        by smtp.gmail.com with ESMTPSA id s15sm541405pjp.3.2019.11.20.18.06.16
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 20 Nov 2019 18:06:17 -0800 (PST)
Subject: Re: [PATCH -next] writeback: fix -Wformat compilation warnings
To:     Qian Cai <cai@lca.pw>, Tejun Heo <tj@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     jack@suse.cz, gregkh@linuxfoundation.org, cgroups@vger.kernel.org,
        heiko.carstens@de.ibm.com, gor@linux.ibm.com,
        borntraeger@de.ibm.com, linux-s390@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20191114192118.GK4163745@devbig004.ftw2.facebook.com>
 <9D52EBB0-BE48-4C59-9145-857C3247B20D@lca.pw>
 <20191115145540.GP4163745@devbig004.ftw2.facebook.com>
 <1574279778.9585.15.camel@lca.pw>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <26dc5699-9223-3e35-65f3-955fef7a990a@kernel.dk>
Date:   Wed, 20 Nov 2019 16:17:51 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <1574279778.9585.15.camel@lca.pw>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/20/19 12:56 PM, Qian Cai wrote:
> On Fri, 2019-11-15 at 06:55 -0800, Tejun Heo wrote:
>> On Thu, Nov 14, 2019 at 07:26:21PM -0500, Qian Cai wrote:
>>>
>>>
>>>> On Nov 14, 2019, at 2:21 PM, Tejun Heo <tj@kernel.org> wrote:
>>>>
>>>> Acked-by: Tejun Heo <tj@kernel.org>
>>>
>>> Tejun, suppose you will take this patch via your tree together with the series or should I Cc Andrew who normally handle this file?
>>
>> Patches in this area usually goes through Jens's block tree.
> 
> I remember that last time Jens had no interests in picking up trivial patches
> like this one. See the commit d1a445d3b86c ("include/trace/events/writeback.h:
> fix -Wstringop-truncation warnings").
> 
> Andrew, care to pick up this again?
> 
> https://lore.kernel.org/lkml/1573751861-10303-1-git-send-email-cai@lca.pw/

I'm fine with picking it up, this one isn't trivial and it's fixing
warnings. But I didn't (and don't) carry f05499a06fb4 in my tree,
so it'd be more logical to funnel this one through the tree that
has the offending commit.

-- 
Jens Axboe

