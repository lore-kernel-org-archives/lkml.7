Return-Path: <SRS0=CEgE=VT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC357C76191
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Jul 2019 00:03:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9203320838
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Jul 2019 00:03:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="f+7EO7Fc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726547AbfGVADk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 21 Jul 2019 20:03:40 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:35506 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725904AbfGVADk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 21 Jul 2019 20:03:40 -0400
Received: by mail-pg1-f193.google.com with SMTP id s1so10462192pgr.2;
        Sun, 21 Jul 2019 17:03:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=g1PCvhRfq/dQJyYPs7WWjVIQcpVq0mXmqgBinRZQNns=;
        b=f+7EO7FcINzuo0nX+4rVTtzWDsin+r81cKKn6Lj+wD1NotUZyYSgnfqjVIpv1XiQZo
         rS/rvVoiBEZpGAO+xr8hSKqBn+rhAOUxDrmHIWRoLSKdc0ncPr7nsP/ZykETki0XO6eZ
         rBNkjbD+8xsHy1rJ3/m99yPX+7Gt0VsrZMqGV1YAyEjYDStOacLZ+xmyVr4OHax8e38J
         SAkQ0wmUD7T9BQ+4PZ8OWg8JGOrFE4UEBEdDpUchp+VcS2hau60CyKicFkfTL+gHv8uy
         kQKDE32fuXdD/DQKczu3uezL30q/0K4dXB61kdk3c4uBlTxOyy0AYHUBJIenlPBtRb+q
         Fvbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:to:cc:references:from:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=g1PCvhRfq/dQJyYPs7WWjVIQcpVq0mXmqgBinRZQNns=;
        b=FfSnarp2NHgczKubRSK+dXCD8gKPOHqtuJ1D9UPW6OzpZt20ccxYLDZMnSC+iSGTKl
         JrjyRVpazuwP05JUQOlCQEJSRNnax5Pjlvu5S82SkVQHMS1Q97N0jTWonoXJ3cl5/EzU
         Ie+w2BpwjjbJldXZDxEptVXT3eeyIMql+UKuNQBlk1FxDdD3KffHi11CD8IUeCEC3xYq
         dayUaOcqxmjW/xhBY2Z3LHmxgvHcQ5Z03gHUNIDrEvzNsdkG2gC0KjaUsFKxB4x6lqkV
         e+gc4Ll1fUANNHIDqc9MWNB/GqtGAc42zjT5DzQWwaIS7dgONzRuMD9/e+fRX7ApGPs0
         ELpQ==
X-Gm-Message-State: APjAAAUIPPGfqPKPGM7OjUPNlWFGF+VrV8SAAWZRa1ouOgH6m4EA/1Me
        Uvcfn9fgKiE6/7nIVE8GAd4tUXcF
X-Google-Smtp-Source: APXvYqw8/VEROEnmh2e8LJZGjdewdLOLXB7PQLM8vmlUZM5+yzT3CwbvpaWHgupMZJS8fO1PtFYLNA==
X-Received: by 2002:a63:4c17:: with SMTP id z23mr29848323pga.167.1563753819032;
        Sun, 21 Jul 2019 17:03:39 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id i9sm30812236pjj.2.2019.07.21.17.03.37
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 21 Jul 2019 17:03:38 -0700 (PDT)
Subject: Re: [PATCH v3 1/1] hwmon: (k8temp) update to use new hwmon
 registration API
To:     avoidr@riseup.net
Cc:     Rudolf Marek <r.marek@assembler.cz>,
        Jean Delvare <jdelvare@suse.com>, linux-hwmon@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Robert Karszniewicz <avoidr@firemail.cc>,
        linux-hwmon-owner@vger.kernel.org
References: <1d0f98fb-a0a6-38b7-98f6-ec4c365587b0@roeck-us.net>
 <20190721120051.28064-1-avoidr@riseup.net>
 <20190721151408.GA13373@roeck-us.net>
 <16e03db49372a5f240b241f985f8685c@riseup.net>
From:   Guenter Roeck <linux@roeck-us.net>
Message-ID: <91304a1b-26d5-a6a8-c89e-18cde6614d73@roeck-us.net>
Date:   Sun, 21 Jul 2019 17:03:36 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <16e03db49372a5f240b241f985f8685c@riseup.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/21/19 1:37 PM, avoidr@riseup.net wrote:
> On 2019-07-21 17:14, Guenter Roeck wrote:
>> On Sun, Jul 21, 2019 at 02:00:51PM +0200, Robert Karszniewicz wrote:
>>> Removes:
>>> - hwmon_dev from k8temp_data struct, as that is now passed
>>>    to callbacks, anyway.
>>> - other k8temp_data struct fields, too.
>>> - k8temp_update_device()
>>>
>>> Also reduces binary size:
>>>     text    data     bss     dec     hex filename
>>>     4139    1448       0    5587    15d3 drivers/hwmon/k8temp.ko.bak
>>>     3103    1220       0    4323    10e3 drivers/hwmon/k8temp.ko
>>>
>>> Signed-off-by: Robert Karszniewicz <avoidr@firemail.cc>
>>> Signed-off-by: Robert Karszniewicz <avoidr@riseup.net>
>>
>> Applied.
> 
> Thank you! It's been a joy!
> 
>>> ---
>>> Changes from v2:
>>> - if (data->swap_core_select)
>>> -     core ^= 1;
>>> + core ^= data->swap_core_select;
>>>
>>> However, that produces slightly more .text than v2, and is a tad too
>>> "tricky", I personally find.
>>>
>> Interesting - for me it produces ~30 bytes less code (with gcc 7.4.0).
> 
> Strange. I just verified to make sure and I do get ~30 bytes /more/ code
> (with gcc 9.1.0).
> 

Mine is gcc 7.4.0. Oh well...

Guenter
