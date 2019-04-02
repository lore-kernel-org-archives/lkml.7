Return-Path: <SRS0=bo2+=SE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E5A5C4360F
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Apr 2019 14:39:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3DDC22133D
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Apr 2019 14:39:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1554215943;
	bh=u38hid6hXpdJ0hs9XdoK59gdN1drfdwff6ScxKdFEfI=;
	h=Subject:To:Cc:References:From:Date:In-Reply-To:List-ID:From;
	b=H3DM7gmk9r04Oop64rBN8S8GoMr8qH/SQSV0NYyC/hdRw9MrVdVFfmrvaBiAv07AB
	 +u2gl2IFHoRp6H3ofrVKeCEjS/CTGOGT1gqUhY3PT6d0UTeXssEpWSRk5Rx9c0SpdB
	 ZEckyKja29HEk10pfovBKShhzKxFcLyfI9hQIg/M=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732086AbfDBOjC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Apr 2019 10:39:02 -0400
Received: from mail.kernel.org ([198.145.29.99]:44290 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731973AbfDBOi6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Apr 2019 10:38:58 -0400
Received: from [192.168.1.112] (c-24-9-64-241.hsd1.co.comcast.net [24.9.64.241])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3E18520857;
        Tue,  2 Apr 2019 14:38:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1554215937;
        bh=u38hid6hXpdJ0hs9XdoK59gdN1drfdwff6ScxKdFEfI=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=IyGOHVUwiY83LrSlMMhXARMZQRJ+vMYMrCLaQ9N3aEUB/A7uKmB8SP+E8CYWR/NOW
         UviZU8mJ99a4xvhqrcjcu2ur3pkvP4XTsxnTY8TdMvoFrh757306yNN2JGytMqXt9e
         6D4KcpQhxCH5swVr1ujVxRoMUMaopOthdIngSqg8=
Subject: Re: [PATCH v15 0/6] Media Device Allocator API
To:     Hans Verkuil <hverkuil@xs4all.nl>, mchehab@kernel.org,
        perex@perex.cz, tiwai@suse.com
Cc:     linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        alsa-devel@alsa-project.org, shuah <shuah@kernel.org>
References: <cover.1554155701.git.shuah@kernel.org>
 <fb0b46d3-a8a5-c5b5-7f3e-08ddfd27235b@xs4all.nl>
From:   shuah <shuah@kernel.org>
Message-ID: <829089d0-8cef-bce5-6717-9a39522f7be1@kernel.org>
Date:   Tue, 2 Apr 2019 08:38:56 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.1
MIME-Version: 1.0
In-Reply-To: <fb0b46d3-a8a5-c5b5-7f3e-08ddfd27235b@xs4all.nl>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/2/19 1:38 AM, Hans Verkuil wrote:
> On 4/2/19 2:40 AM, Shuah Khan wrote:
>> Media Device Allocator API to allows multiple drivers share a media device.
>> This API solves a very common use-case for media devices where one physical
>> device (an USB stick) provides both audio and video. When such media device
>> exposes a standard USB Audio class, a proprietary Video class, two or more
>> independent drivers will share a single physical USB bridge. In such cases,
>> it is necessary to coordinate access to the shared resource.
>>
>> Using this API, drivers can allocate a media device with the shared struct
>> device as the key. Once the media device is allocated by a driver, other
>> drivers can get a reference to it. The media device is released when all
>> the references are released.
>>
>> The primary focus for testing The patch series is making sure media
>> device is released when both drivers release the media device with
>> a series of unbind/binds on both drivers.
>>
>> - both au0828 and snd-usb-aduio as built-in
>> - both au0828 and snd-usb-aduio as modules
>> - au0828 as module and snd-usb-aduio as built-in
>> - au0828 as built-in and snd-usb-aduio as module
>>
>> Test results can be found at:
>>
>> https://docs.google.com/document/d/1RMF8Rwj7xHJEoOx6_K2f-REgZJ63BMeAVEf-CV-0HsM/edit?usp=sharing
> 
> Phew, after posting v2 of my patch "au0828: stop video streaming only when last
> user stops" everything now works as it should, including the issue with two VBI
> streams you found.
> 

Awesome. Thanks for taking care of this. Looks good. I tested the
patch and sent Tested-by for it.

> Should I take the selftest patch or will you take that yourself?

Please take this through your pull request. Bundling the test with the
feature will help promote use of this test :)

Please pick up the null pointer dereference fix in bind path when unbind
happens while bind is in progress.

> 
> Let me know so I can make the pull request for this. It's been a long journey
> since the first post on April 9th, 2014: "[RFC PATCH 0/2] managed token devres
> interfaces".
>

Please send the pull request.

> Almost exactly five years of work!
> 
Amazing. We ended up with a far better solution than the the first patch
series ! Thanks to everybody that helped me with reviews and testing.

thanks,
-- Shuah

