Return-Path: <SRS0=TKbG=UN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D5B6EC31E50
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Jun 2019 23:26:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A9F00217D6
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Jun 2019 23:26:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1560554809;
	bh=OnhDQrubH4/9j8Vym32fyb+MvNHZxTLkb5f+IClKMRY=;
	h=Subject:To:Cc:References:From:Date:In-Reply-To:List-ID:From;
	b=hPvednsUEC8Uf9CHZDp8AMOqOV3yIM9oah68eKZUpTisZG5RPbNinHfqxZdd5eZ/+
	 BsocA2DO8YCKuaA5L22LpRK7Umo0Q4dfqFj2clxGlyQgSUBEVlHXQQsTpikeEfnN8+
	 n9poHMz3b2WHTqIHAy0wUSERhn7E+LKSY+OB+pqM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725809AbfFNX0s (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Jun 2019 19:26:48 -0400
Received: from mail-io1-f68.google.com ([209.85.166.68]:32856 "EHLO
        mail-io1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725837AbfFNX0s (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Jun 2019 19:26:48 -0400
Received: by mail-io1-f68.google.com with SMTP id u13so9420105iop.0
        for <linux-kernel@vger.kernel.org>; Fri, 14 Jun 2019 16:26:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=BgBzUprMwzxsPrUZNWFb4TI8c1DrqIQ3OMpOfxCgcVs=;
        b=MYEZ7rV6UMaiVgCFYJK+xu/nqaoPXZxT6oh0Pv0vsmoNEWPLqK8YlLR3v8iSy8V42X
         awYvACi/szyb7fIaoWUsI0FWo5Mzm3DoAf+clHBsjkN0aXAjD8KvE6GCxiX/TbgP+t4g
         PFvfSpT3DKHUCpLTfTUtcF4c0qttULVKYylIk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=BgBzUprMwzxsPrUZNWFb4TI8c1DrqIQ3OMpOfxCgcVs=;
        b=Z5Jm0QKdgQ3GWa+vTdKygc5xCO9Gd232CPwyv5ttZ84+67mATKgdRhujZ7VLKbF5Y1
         jWA8sfnhnHD9GRrSQkJUnTATNlMb3XoSiMf0L1c9FVhNucEiYDjz6Gx7gV1g2yMjZ+ym
         esgSKLHya1aHLYRJE/5J0GjkzvE1D4kP9GeydpPtkzBF3yiLDKwnu4bu3PVymfEAAtWa
         +KF6kx1rjxL1q5Pr2e2N2qFCxQRvZgVF+lk/D7GrjcZA25rI6YhqPEudLkn01CdeSA5r
         ZmxhyS/+wT81AYqpPQe5B70MOkVnlEdRHqWo0khp3slvc20VOKei1ylrUT2aRRtxNsR8
         JD9A==
X-Gm-Message-State: APjAAAVwgVcEIqJI8tCv7OsbJTGRq1wQ+S853no2w9QuecF6MO5k1lGV
        W2l8666o6sRHkgJ9+1FT5dW91z6D3hg=
X-Google-Smtp-Source: APXvYqxgmtCNsTmHG+dcHz1s0SZYMqut7P+FjNnZMFVIaHax7HqhzzuNcY6lDvMQIrBHy7YoUNYJOQ==
X-Received: by 2002:a05:6602:218b:: with SMTP id b11mr6217236iob.264.1560554807498;
        Fri, 14 Jun 2019 16:26:47 -0700 (PDT)
Received: from [192.168.1.112] (c-24-9-64-241.hsd1.co.comcast.net. [24.9.64.241])
        by smtp.gmail.com with ESMTPSA id o7sm3931020ioo.81.2019.06.14.16.26.46
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 14 Jun 2019 16:26:47 -0700 (PDT)
Subject: Re: [PATCH 0/2] Use Media Dev Allocator to fix vimc dev lifetime bugs
To:     Helen Koike <helen.koike@collabora.com>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>
Cc:     linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        Shuah Khan <skhan@linuxfoundation.org>
References: <cover.1558667245.git.skhan@linuxfoundation.org>
 <c9160fe7-e880-4070-3959-b9e9177acf54@xs4all.nl>
 <2862ebca-c58f-c265-cc74-8d0f9b943275@collabora.com>
From:   Shuah Khan <skhan@linuxfoundation.org>
Message-ID: <1c794ca1-5490-26a4-dc39-f86e05fadc46@linuxfoundation.org>
Date:   Fri, 14 Jun 2019 17:26:46 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <2862ebca-c58f-c265-cc74-8d0f9b943275@collabora.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/13/19 7:24 AM, Helen Koike wrote:
> 
> 
> On 6/13/19 2:44 AM, Hans Verkuil wrote:
>> On 5/24/19 5:31 AM, Shuah Khan wrote:
>>> media_device is embedded in struct vimc_device and when vimc is removed
>>> vimc_device and the embedded media_device goes with it, while the active
>>> stream and vimc_capture continue to access it.
>>>
>>> Fix the media_device lifetime problem by changing vimc to create shared
>>> media_device using Media Device Allocator API and vimc_capture getting
>>> a reference to vimc module. With this change, vimc module can be removed
>>> only when the references are gone. vimc can be removed after vimc_capture
>>> is removed.
>>>
>>> Media Device Allocator API supports just USB devices. Enhance it
>>> adding a genetic device allocate interface to support other media
>>> drivers.
>>>
>>> The new interface takes pointer to struct device instead and creates
>>> media device. This interface allows a group of drivers that have a
>>> common root device to share media device resource and ensure media
>>> device doesn't get deleted as long as one of the drivers holds its
>>> reference.
>>>
>>> The new interface has been tested with vimc component driver to fix
>>> panics when vimc module is removed while streaming is in progress.
>>
>> Helen, can you review this series? I'm not sure this is the right approach
>> for a driver like vimc, and even if it is, then it is odd that vimc-capture
>> is the only vimc module that's handled here.
> 
> Hi Hans,
> 
> Yes, I can take a look. Sorry, I've been a bit busy these days but I'll
> try to take a look at this patch series (and the others) asap.
> 
> Helen
> 
>>
>> My gut feeling is that this should be handled inside vimc directly and not
>> using the media-dev-allocator.
>>

Hi Hans and Helen,

I explored fixing the problem within vimc before I went down the path to
use Media Device Allocator API. I do think that it is cleaner to go this
way and easier to maintain.

vimc is a group pf component drivers that rely on the media device vimc
in vimc and falls into the use-case Media Device Allocator API is added
to address. The release and life-time management happens without vimc
component drivers being changed other than using the API to get and put
media device reference.

thanks,
-- Shuah


