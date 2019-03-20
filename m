Return-Path: <SRS0=4Jrr=RX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 90FBDC43381
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Mar 2019 16:26:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5C7E72146E
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Mar 2019 16:26:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="mRhyIfq9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727923AbfCTQ0J (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Mar 2019 12:26:09 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:50522 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727234AbfCTQ0I (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Mar 2019 12:26:08 -0400
Received: by mail-wm1-f66.google.com with SMTP id z11so12843116wmi.0
        for <linux-kernel@vger.kernel.org>; Wed, 20 Mar 2019 09:26:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=l1PRcY7PKhUY/cb04a6pTbr0TcayK9IZi9U8GdV3RDU=;
        b=mRhyIfq9ThfmDX+W8SiSn35Cwz+8nhq0Pww1fWdtPjADvk/3L1R4MpmNXvBlYkT4Vw
         CKixaYM9AMjDaTV66yQKREg3pVMOinSj5IETbcsDK0+M0XcFCHccu6w718Eziz7PU+zp
         1wcpCqPtUCyj1uJySAEBpvS2y6f47TgQ9E7sN+txSiSBPMw+ub1+jnjb82gTVYJ35tcI
         JhmO5GbiSEIbkPToCzpyUhRBaOYtE7r5E1xThNlfJDm1XcLkedW3K1AvCnRzYmz/9Khy
         fn3VeiMXGQ2gvLg15Nwnw0l+aKf8oZ68CqJ60PicrNtJy/PPpOlfjk7svdW0C+RunyZo
         7BiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=l1PRcY7PKhUY/cb04a6pTbr0TcayK9IZi9U8GdV3RDU=;
        b=Ww++xtz+sdU7j/ktWl5p8kMF5becZLJtzDKYBivEk86SAfMEJOT+xKR6qV7xVPOipk
         n56UjL8gygBAIwgSMtJtwYgBy0EsKd5L7/tHXpBDHmcapef5Sx9scLyp7sCvE16ANnUk
         jZSCgPfCwMmzr93v07rDzdTKjUUh+hOo1JIR2sKgSG0NV95dTtyMfPyv79mJyS0KBw2r
         +gw8xOrZTIeFOpnH1K2TA9Hyj7KpYDrEBkIJAE/WEf9oxtlW0KC0bGoPYFiNuywaCCf9
         zDaC0diP4TDTOLILAji4+2CoYmylFD7Z0XmMT8pD/wdMMAZgFBEkodT84sXqhmBLWQxf
         svTw==
X-Gm-Message-State: APjAAAW1gOrJfvGmOHH287pvIu5bmioWo5RkOIRzxahSPAx31RoLnbrE
        0EldDNfKK3XdugIWJGO1aWWKrA==
X-Google-Smtp-Source: APXvYqyT+2lN8nONvMCn7NwLLWLvYxZeqn8XJzdFiUBdUVdNIcgakkqmduaJPhEBfO5qXP13/3xcLQ==
X-Received: by 2002:a1c:4105:: with SMTP id o5mr7796600wma.35.1553099166859;
        Wed, 20 Mar 2019 09:26:06 -0700 (PDT)
Received: from [192.168.86.34] (cpc89974-aztw32-2-0-cust43.18-1.cable.virginm.net. [86.30.250.44])
        by smtp.googlemail.com with ESMTPSA id e135sm4110292wmg.24.2019.03.20.09.26.05
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 20 Mar 2019 09:26:06 -0700 (PDT)
Subject: Re: [PATCH v2] nvmem: core: Set no-read-write provider to avoid
 userspace read/write
To:     Gaurav Kohli <gkohli@codeaurora.org>, linux-kernel@vger.kernel.org
Cc:     linux-arm-msm@vger.kernel.org
References: <1552831940-7327-1-git-send-email-gkohli@codeaurora.org>
 <48a71861-c60b-7fe7-d4af-5269cd7c20eb@linaro.org>
 <5f11070f-bf9b-c313-9a78-e412a2fb2908@codeaurora.org>
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Message-ID: <865519b5-62c9-3eb3-3855-eebf98bded85@linaro.org>
Date:   Wed, 20 Mar 2019 16:26:05 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.1
MIME-Version: 1.0
In-Reply-To: <5f11070f-bf9b-c313-9a78-e412a2fb2908@codeaurora.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 20/03/2019 15:50, Gaurav Kohli wrote:
> 
> On 3/20/2019 8:04 PM, Srinivas Kandagatla wrote:
>>
>>
>> On 17/03/2019 14:12, Gaurav Kohli wrote:
>>> Current nvmem framework allows user space to read all register space
>>> populated by nvmem binary file, In case we don't want to expose value
>>> of registers to userspace and only want kernel space to read cell
>>> value from nvmem_cell_read_u32.
>>>
>>> To protect the same, Add no-read-write property to prevent read
>>> from userspace.
>>>
>>
>> Can you explain the real need of this?
>> Is there any issue you are noticing while reading nvmem content from 
>> userspace?
>>
> Hi Srinivas,
> 
> 
> No, We are not observing any issue, nvmem is dumping the data properly.
> 
> But there are certain register, which we don't want to expose to user 
> space and want kernel space can only read via nvmem_cell_read.
Am guessing these are some kind of keys or something that you do not 
want user to see.

Is root only option not helping you in this case?

We could go down the route of adding new config option something like 
CONFIG_NVMEM_NO_SYSFS_ENTRY to prevent adding nvmem entry in userspace.

Let me know if you are happy to create a patch for this change?

Thanks,
srini

> 
> In existing design, even if we read cell from kernel space, nvmem binary 
> files is still populated to user space unconditionally.
> 
> Regards
> 
> Gaurav
