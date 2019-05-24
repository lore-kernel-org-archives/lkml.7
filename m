Return-Path: <SRS0=Z4g5=TY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8DEA2C282E3
	for <linux-kernel@archiver.kernel.org>; Fri, 24 May 2019 05:01:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 536E5217D7
	for <linux-kernel@archiver.kernel.org>; Fri, 24 May 2019 05:01:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="S459Uf15"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731850AbfEXFBp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 May 2019 01:01:45 -0400
Received: from mail-ed1-f65.google.com ([209.85.208.65]:46388 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726156AbfEXFBp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 May 2019 01:01:45 -0400
Received: by mail-ed1-f65.google.com with SMTP id f37so12411379edb.13
        for <linux-kernel@vger.kernel.org>; Thu, 23 May 2019 22:01:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=kmmnQ1PQsbdTYCzZ/HEaFotM4QJObrpCCDw2bx+M+xs=;
        b=S459Uf15R2RJEssnzNPufv6/a8aVmoVgksRVougjaRpj7VxQS5M7JBFKQ5Zz8gqucW
         0sHzOvkav7o0EYtX/irdUc51N9Qe8jT0rGaLKU/epZCjpMQNYX2yybRxt4FJEmPWiVHw
         nvWhBCB8FnMp1ByZJRYHLyT1l8rZeuH11Vz98=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=kmmnQ1PQsbdTYCzZ/HEaFotM4QJObrpCCDw2bx+M+xs=;
        b=CQdJx5qVPCMImCp7Fif1neK/B5sgkEzYYhB3ASh/m0caDOC8RZiX3fuzJxM5mYFH/h
         fif1Si6eILeVghjujMCAJp5LiSe44g+vrfwRlZW6/YykJEPcUZJ7Hhwb9s3+ZsCILw+W
         eh4aGV7brQ07r3xCePIRr4scG1m7uFvVKLs/8MzlAjiyCZqPYG+zH6YMdzxhMI3DF+3j
         0N9smHNfZ2t7gAFn5+j37UT1+oRTtqcIKqoROS68mhjMOG9aG4ioOWWtipgeooUSJO+p
         nungGIdst3Xeeh4YYEMIsj0tp45PUVfN8RF++H5fwwGVotuwz7EfM03FhgyQ11xWb1lX
         KZmw==
X-Gm-Message-State: APjAAAWKsJoXGVKoG5qY3vAkCmlogAsFQ4roTpGyP6zRqknIEtlcGnxj
        Lgy+Rouw7ke3C+ABTbxwV3/m1w==
X-Google-Smtp-Source: APXvYqySllg1ueDxIeXuHg1ZrfXcXrwn7NTJLNoGRkLKYpkhj6hT1SS5z1gJmbLv9DigpkSrjZiYbQ==
X-Received: by 2002:a50:8965:: with SMTP id f34mr101190832edf.296.1558674103734;
        Thu, 23 May 2019 22:01:43 -0700 (PDT)
Received: from [10.136.13.65] ([192.19.228.250])
        by smtp.gmail.com with ESMTPSA id j10sm195425ejk.49.2019.05.23.22.01.40
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 23 May 2019 22:01:42 -0700 (PDT)
Subject: Re: [PATCH 2/3] firmware: add offset to request_firmware_into_buf
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Luis Chamberlain <mcgrof@kernel.org>,
        David Brown <david.brown@linaro.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-fsdevel@vger.kernel.org,
        BCM Kernel Feedback <bcm-kernel-feedback-list@broadcom.com>,
        Olof Johansson <olof@lixom.net>
References: <20190523025113.4605-1-scott.branden@broadcom.com>
 <20190523025113.4605-3-scott.branden@broadcom.com>
 <20190523055233.GB22946@kroah.com>
 <15c47e4d-e70d-26bb-9747-0ad0aa81597b@broadcom.com>
 <20190523165424.GA21048@kroah.com>
From:   Scott Branden <scott.branden@broadcom.com>
Message-ID: <44282070-ddaf-3afb-9bdc-4751e3f197ac@broadcom.com>
Date:   Thu, 23 May 2019 22:01:38 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190523165424.GA21048@kroah.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 2019-05-23 9:54 a.m., Greg Kroah-Hartman wrote:
> On Thu, May 23, 2019 at 09:36:02AM -0700, Scott Branden wrote:
>> Hi Greg,
>>
>> On 2019-05-22 10:52 p.m., Greg Kroah-Hartman wrote:
>>> On Wed, May 22, 2019 at 07:51:12PM -0700, Scott Branden wrote:
>>>> Add offset to request_firmware_into_buf to allow for portions
>>>> of firmware file to be read into a buffer.  Necessary where firmware
>>>> needs to be loaded in portions from file in memory constrained systems.
>>>>
>>>> Signed-off-by: Scott Branden <scott.branden@broadcom.com>
>>>> ---
>>>>    drivers/base/firmware_loader/firmware.h |  5 +++
>>>>    drivers/base/firmware_loader/main.c     | 49 +++++++++++++++++--------
>>>>    include/linux/firmware.h                |  8 +++-
>>>>    3 files changed, 45 insertions(+), 17 deletions(-)
>>> No new firmware test for this new option?  How do we know it even works?
>> I was unaware there are existing firmware tests.  Please let me know where
>> these tests exists and I can add a test for this new option.
> tools/testing/selftests/firmware/

Unfortunately, there doesn't seem to be a test for the existing 
request_firmware_into_buf api.

Looks like it will be more work that I thought enhancing a test that 
doesn't exist.


>
>> We have tested this with a new driver in development which requires the
>> firmware file to be read in portions into memory.  I can add my tested-by
>> and others to the commit message if desired.
> I can't take new apis without an in-kernel user, you all know this...

OK, It will have to wait then as I was hoping to get this in before my 
leave.

But adding a selftest and upstreaming the necessary driver

won't be possible for a few months now.

>
> thanks,
>
> greg k-h

Thanks for explaining the requirements.


Scott

