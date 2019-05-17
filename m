Return-Path: <SRS0=M1fl=TR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C483FC04E84
	for <linux-kernel@archiver.kernel.org>; Fri, 17 May 2019 22:59:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9137D2087E
	for <linux-kernel@archiver.kernel.org>; Fri, 17 May 2019 22:59:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="P/9e6bjo"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727543AbfEQW7v (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 17 May 2019 18:59:51 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:37768 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726519AbfEQW7v (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 May 2019 18:59:51 -0400
Received: by mail-pg1-f195.google.com with SMTP id n27so1358621pgm.4
        for <linux-kernel@vger.kernel.org>; Fri, 17 May 2019 15:59:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:from:to:cc:references:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=tug9Q9th898cY2omkiw7RTZyUw2WfPSXBZQ/FeXbAkQ=;
        b=P/9e6bjo8XAXrsrhceXhy1vMAWDMoJZvh0+VVomH8QiSlrxWj5aKukK/r4GQwxPScU
         91rCXDtK+XUh6a1f0WCMFc4mqy6TqQES0dPwWcwYRX1R0OuswZT8vkrN1Ls8XsyZWk+a
         0c/uo4hCwxGBfT8C+LUr90jq9DYRVKxiR9+JrdR5k6gNuQe+nBR+pI6w/pssqY66AF2m
         kNFbV+Nc6qKDgd+Xb/WhOeWQECNeMleNE7G3x2DftJ9e9hw4ZAjpxEJ5FFUW9I91v/vU
         yqw6Q85JLu96eLX0ZkwtL70As140+R8GlCNEFDf9v54t4LmjGcFHKH+0aHz3gcgQIRCr
         VNMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:from:to:cc:references:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=tug9Q9th898cY2omkiw7RTZyUw2WfPSXBZQ/FeXbAkQ=;
        b=NyHw8ci1GSrht8gKFw9cnYW59rvcKCDT6j9SDpOS4jiMT8QHnl6Cbm3JukJVulu/UB
         QZCUa8nSQtLyBYbyQ2yHC9YhudCaTJtyGGMyuodTPQJ4cABXDfk5u/VPPl4T/F2ZwWV+
         0s3dzSZKbSlq8G1NIBuan01KWLzWsMvDo80QSBQu2SSz8PRycBeGQB3N5N56QVl3zkTC
         FHpFEYykvf9dR5vixvAw8U50odV31TqdGoveCOaWEbdITmSdyCujquYM2SI99XeVI0Wn
         BClri8zPXuUFrwWO//apYqSSA6ut7Z7HN824c4unpmd+VY7kvm9ge2Krltnod8XCvUak
         ow1w==
X-Gm-Message-State: APjAAAVWmzCvdEKLfHNhuo/Ky1o+0hj+k3OjOciKxgRfpjwyuTsHQ9zJ
        1wsZyCwl9XYjOqHzdkpd8DvHreTK1Wew4Q==
X-Google-Smtp-Source: APXvYqy8iHrZkCavlke8rQpzQn5yluUHlir/Gv0jbaU44MC2q70NK8Q9AZVp0wcuECl1ZxT6WDHf5A==
X-Received: by 2002:a63:754b:: with SMTP id f11mr59810851pgn.32.1558133989966;
        Fri, 17 May 2019 15:59:49 -0700 (PDT)
Received: from [192.168.1.121] (66.29.164.166.static.utbb.net. [66.29.164.166])
        by smtp.gmail.com with ESMTPSA id v66sm22027626pfa.38.2019.05.17.15.59.48
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 17 May 2019 15:59:48 -0700 (PDT)
Subject: Re: [PATCH] block: bio: use struct_size() in kmalloc()
From:   Jens Axboe <axboe@kernel.dk>
To:     xiaolinkui <xiaolinkui@kylinos.cn>
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
References: <1558084350-25632-1-git-send-email-xiaolinkui@kylinos.cn>
 <e46a73e2-b04d-371b-f199-e789dbdbd9fc@kernel.dk>
Message-ID: <d83390a9-33be-3d76-3e23-b97f0a05b72f@kernel.dk>
Date:   Fri, 17 May 2019 16:59:47 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <e46a73e2-b04d-371b-f199-e789dbdbd9fc@kernel.dk>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/17/19 3:17 PM, Jens Axboe wrote:
> On 5/17/19 3:12 AM, xiaolinkui wrote:
>> One of the more common cases of allocation size calculations is finding
>> the size of a structure that has a zero-sized array at the end, along
>> with memory for some number of elements for that array. For example:
>>
>> struct foo {
>>     int stuff;
>>     struct boo entry[];
>> };
>>
>> instance = kmalloc(sizeof(struct foo) + count * sizeof(struct boo), GFP_KERNEL);
>>
>> Instead of leaving these open-coded and prone to type mistakes, we can
>> now use the new struct_size() helper:
>>
>> instance = kmalloc(struct_size(instance, entry, count), GFP_KERNEL);
> 
> Applied, thanks.

I take that back, you obviously didn't even compile this patch. Never
send untested crap, without explicitly saying so.

-- 
Jens Axboe

