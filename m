Return-Path: <SRS0=ICIc=WW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55E69C3A5A6
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Aug 2019 17:24:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2FEA221848
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Aug 2019 17:24:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="HBeA4vv1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732745AbfHZRY1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 26 Aug 2019 13:24:27 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:43610 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727815AbfHZRY0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Aug 2019 13:24:26 -0400
Received: by mail-pf1-f196.google.com with SMTP id v12so12213091pfn.10
        for <linux-kernel@vger.kernel.org>; Mon, 26 Aug 2019 10:24:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=rb7iuoQ+Gomsu2YAozXkWUQXactVdSD0FsFa8hD/asE=;
        b=HBeA4vv1OE7pU+fZx/EbqN3SIPc9pJCssSACM6VAx0KIsNSmqCt9TNcKSo6ViYIta8
         VnGF0hO9m6P/IFiHhsdNYqw+PIqEQWlLsr7vza+YyHFuS6wxvDtgwFRWaV3JvV8j3y0X
         ZamFoBKQfRUeDH2RTk0zPBc0yXtO9k7lpVEW4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=rb7iuoQ+Gomsu2YAozXkWUQXactVdSD0FsFa8hD/asE=;
        b=QwSwdyJtBOuicvSAQqC32ilPBHYo5aMvFAwKbose644cXh1cHZGBvvGkuqTB5trF9l
         xxb1oewgIzH+pil7I5h9MgV4OaCM9ybK9g5AGEyKv1jXW+9wgC+N/PnqGrKCmyT1O4Qo
         3qCNGx3ITJHqIgycGrcdmt8dGSgN7alHOm6Sq7p45l6/sIyDPm01k4VGxop5q62WGJdd
         am24KcTK6PX8JeyZYN6nbco28tjIH0gjLOleo60GIuuat5U9yvLwifCFcrukvVi9w3dM
         xXiHPijdPU1UpMcyft17SEu25EecnZPhw9tbbBQTdPaQdRmPbi0Ow/zcCPBOQa7C2azt
         3Ckg==
X-Gm-Message-State: APjAAAXUp/V4dUpCmCz8C/5UfoXbPgndMlYm0seUoKlXUrUDgO8ty8uV
        9+Z2HP4Sw7SHB/MwoaPgXoSdQw==
X-Google-Smtp-Source: APXvYqy2UucAHzKtHomdYNdhdeh/53QLrBQTZBYCiOe75MQZJzjbcSg4NTGKaSXApN0+GGxaWaPfYA==
X-Received: by 2002:a63:f758:: with SMTP id f24mr17277542pgk.319.1566840265911;
        Mon, 26 Aug 2019 10:24:25 -0700 (PDT)
Received: from [10.136.13.65] ([192.19.228.250])
        by smtp.gmail.com with ESMTPSA id c22sm11740149pfi.82.2019.08.26.10.24.23
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 26 Aug 2019 10:24:24 -0700 (PDT)
Subject: Re: [PATCH 2/7] firmware: add offset to request_firmware_into_buf
To:     Takashi Iwai <tiwai@suse.de>
Cc:     Luis Chamberlain <mcgrof@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        David Brown <david.brown@linaro.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Shuah Khan <shuah@kernel.org>, bjorn.andersson@linaro.org,
        Shuah Khan <skhan@linuxfoundation.org>,
        Arnd Bergmann <arnd@arndb.de>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-fsdevel@vger.kernel.org,
        BCM Kernel Feedback <bcm-kernel-feedback-list@broadcom.com>,
        Olof Johansson <olof@lixom.net>,
        Andrew Morton <akpm@linux-foundation.org>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        Colin Ian King <colin.king@canonical.com>,
        Kees Cook <keescook@chromium.org>,
        linux-kselftest@vger.kernel.org
References: <20190822192451.5983-1-scott.branden@broadcom.com>
 <20190822192451.5983-3-scott.branden@broadcom.com>
 <s5hef1crybq.wl-tiwai@suse.de>
 <10461fcf-9eca-32b6-0f9d-23c63b3f3442@broadcom.com>
 <s5hr258j6ln.wl-tiwai@suse.de>
 <93b8285a-e5eb-d4a4-545d-426bbbeb8008@broadcom.com>
 <s5ho90byhnv.wl-tiwai@suse.de>
From:   Scott Branden <scott.branden@broadcom.com>
Message-ID: <b440f372-45be-c06c-94a1-44ae6b1e7eb8@broadcom.com>
Date:   Mon, 26 Aug 2019 10:24:22 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <s5ho90byhnv.wl-tiwai@suse.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Takashi,

On 2019-08-26 10:12 a.m., Takashi Iwai wrote:
> On Mon, 26 Aug 2019 17:41:40 +0200,
> Scott Branden wrote:
>> HI Takashi,
>>
>> On 2019-08-26 8:20 a.m., Takashi Iwai wrote:
>>> On Fri, 23 Aug 2019 21:44:42 +0200,
>>> Scott Branden wrote:
>>>> Hi Takashi,
>>>>
>>>> Thanks for review.  comments below.
>>>>
>>>> On 2019-08-23 3:05 a.m., Takashi Iwai wrote:
>>>>> On Thu, 22 Aug 2019 21:24:46 +0200,
>>>>> Scott Branden wrote:
>>>>>> Add offset to request_firmware_into_buf to allow for portions
>>>>>> of firmware file to be read into a buffer.  Necessary where firmware
>>>>>> needs to be loaded in portions from file in memory constrained systems.
>>>>> AFAIU, this won't work with the fallback user helper, right?
>>>> Seems to work fine in the fw_run_tests.sh with fallbacks.
>>> But how?  You patch doesn't change anything about the fallback loading
>>> mechanism.
>> Correct - I didn't change any of the underlying mechanisms,
>> so however request_firmware_into_buf worked before it still does.
>>>    Or, if the expected behavior is to load the whole content
>>> and then copy a part, what's the merit of this API?
>> The merit of the API is that the entire file is not copied into a buffer.
>> In my use case, the buffer is a memory region in PCIe space that isn't
>> even large enough for the whole file.  So the only way to get the file
>> is to read it
>> in portions.
> BTW: does the use case above mean that the firmware API directly
> writes onto the given PCI iomem region?  If so, I'm not sure whether
> it would work as expected on all architectures.  There must be a
> reason of the presence of iomem-related API like memcpy_toio()...
Yes, we access the PCI region directly in the driver and thus also 
through request_firmware_into_buf.
I will admit I am not familiar with every subtlety of PCI accesses. Any 
comments to the Valkyrie driver in this patch series are appreciated.
But not all drivers need to work on all architectures. I can add a 
depends on x86 64bit architectures to the driver to limit it to such.
>
>
> thanks,
>
> Takashi

