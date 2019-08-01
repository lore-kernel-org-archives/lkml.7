Return-Path: <SRS0=wo+8=V5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 81273C19759
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Aug 2019 18:15:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5A0A620838
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Aug 2019 18:15:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="Q2Yn9bpZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733119AbfHASPY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 1 Aug 2019 14:15:24 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:34842 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731713AbfHASPY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Aug 2019 14:15:24 -0400
Received: by mail-pf1-f194.google.com with SMTP id u14so34551609pfn.2
        for <linux-kernel@vger.kernel.org>; Thu, 01 Aug 2019 11:15:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=A/2U3sBSUHvfzL5QT64+0anCBzLTLTL1IfUmHYOzv8M=;
        b=Q2Yn9bpZT7MTiS2Fuhc1CBYlxs3phQsozr5LA/k6MqS/FzmEF5/uvtngkdC0Z2cf8S
         i6Qt/32fnNBpI5AKyVyX9TftvzDm1tJ82Db4g7d60SPTRnS4bZNCEt5m0QZ2Zlbp0Iez
         WL0wC61c9DxrPRDpQVe+/uAJ51y4acrhIbDlw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=A/2U3sBSUHvfzL5QT64+0anCBzLTLTL1IfUmHYOzv8M=;
        b=Y5y3QvZvTySAilSCSH1hUccHUm1Xe+KIJ/9E81sBd1dB3sjufgAo/bu8KIlSowwGa8
         on2ILzb4ztUv7Nqqd3r6za9Xbfsq6Xh5ziwx4m6S0U4Gm7fmohrdMuWo2lNRSCfJkKZy
         ANpodUJjlHP8l0kprxktbetjmI5Do7gvYbFmExYf0C9QPevAWtes1QeEsUeKuEdN52H5
         sG7p6qS6+fBqQzScP9CWS8kH/UHUFS2vCNB1Vuf65jvjxr/hE8i2MceoP86Dz9LFZ7xQ
         lf6DMCUg24N7rJqp+89KxttwOliPwgZXPvV4z1pNERBYJzdwEK7cqyUDB0vSx7FTW6gB
         4w7Q==
X-Gm-Message-State: APjAAAVxCkh2L58JlPglx9ahH5v0UrTzC+XJLceeQbj+DMOIHywKsb5O
        uQLHaeQ/dwxpjLEW3LEM6KCWDA==
X-Google-Smtp-Source: APXvYqy5YxYnI0i+UvSKVSvJD5W3X8Ct2hIIE5d7R1nII78ojNXg/Ndq9IbIMXECeg+nkbwLTBNsVQ==
X-Received: by 2002:a17:90a:2562:: with SMTP id j89mr74708pje.123.1564683322929;
        Thu, 01 Aug 2019 11:15:22 -0700 (PDT)
Received: from [10.136.13.65] ([192.19.228.250])
        by smtp.gmail.com with ESMTPSA id l26sm84023425pgb.90.2019.08.01.11.15.20
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 01 Aug 2019 11:15:21 -0700 (PDT)
Subject: Re: [PATCH 2/3] firmware: add offset to request_firmware_into_buf
To:     Luis Chamberlain <mcgrof@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     David Brown <david.brown@linaro.org>,
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
 <44282070-ddaf-3afb-9bdc-4751e3f197ac@broadcom.com>
 <20190524052258.GB28229@kroah.com>
 <2f67db0a-27c3-d13c-bbe0-0af5edd4f0da@broadcom.com>
 <20190801061801.GA4338@kroah.com>
 <20190801174215.GB16384@42.do-not-panic.com>
From:   Scott Branden <scott.branden@broadcom.com>
Message-ID: <74be1aa7-0e10-51dc-bbbf-94bb5f4bf7c4@broadcom.com>
Date:   Thu, 1 Aug 2019 11:15:19 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190801174215.GB16384@42.do-not-panic.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Luis,

On 2019-08-01 10:42 a.m., Luis Chamberlain wrote:
> On Thu, Aug 01, 2019 at 08:18:01AM +0200, Greg Kroah-Hartman wrote:
>> On Wed, Jul 31, 2019 at 05:18:32PM -0700, Scott Branden wrote:
>>> Hi Greg,
>>>
>>> I am now back from leave to continue this patch.  Comment below.
>>>
>>> On 2019-05-23 10:22 p.m., Greg Kroah-Hartman wrote:
>>>> On Thu, May 23, 2019 at 10:01:38PM -0700, Scott Branden wrote:
>>>>> On 2019-05-23 9:54 a.m., Greg Kroah-Hartman wrote:
>>>>>> On Thu, May 23, 2019 at 09:36:02AM -0700, Scott Branden wrote:
>>>>>>> Hi Greg,
>>>>>>>
>>>>>>> On 2019-05-22 10:52 p.m., Greg Kroah-Hartman wrote:
>>>>>>>> On Wed, May 22, 2019 at 07:51:12PM -0700, Scott Branden wrote:
>>>>>>>>> Add offset to request_firmware_into_buf to allow for portions
>>>>>>>>> of firmware file to be read into a buffer.  Necessary where firmware
>>>>>>>>> needs to be loaded in portions from file in memory constrained systems.
>>>>>>>>>
>>>>>>>>> Signed-off-by: Scott Branden <scott.branden@broadcom.com>
>>>>>>>>> ---
>>>>>>>>>      drivers/base/firmware_loader/firmware.h |  5 +++
>>>>>>>>>      drivers/base/firmware_loader/main.c     | 49 +++++++++++++++++--------
>>>>>>>>>      include/linux/firmware.h                |  8 +++-
>>>>>>>>>      3 files changed, 45 insertions(+), 17 deletions(-)
>>>>>>>> No new firmware test for this new option?  How do we know it even works?
>>>>>>> I was unaware there are existing firmware tests.  Please let me know where
>>>>>>> these tests exists and I can add a test for this new option.
>>>>>> tools/testing/selftests/firmware/
>>>>> Unfortunately, there doesn't seem to be a test for the existing
>>>>> request_firmware_into_buf api.
>>>> Are you sure?  The test is for userspace functionality, there isn't
>>>> kernel unit tests here.  You need to verify that you didn't break
>>>> existing functionality as well as verify that your new functionality
>>>> works.
>>> I managed to figure out how to build and run
>>> tools/testing/selftest/firmware/fw_run_tests.sh
>>>
>>> and my changes don't break existing functionality.
> I'm soon going to release something that is going to let you do this
> faster and easier, let me know if you had troubles in trying to figure
> out how to not regress the kernel using this.

Yes, I had troubles in trying to figure it out.  The kernel build should

create an entire initrd with all the necessary components in it for 
testing purposes.

And the firmware test will now take me some time to figure out how it 
all works.

Could you please explain what you are going to release soon?  I don't 
want to waste

my time getting something working if everything is going to change on me 
right away?

>
>>> But, I find no use of request_firmware_into_buf in lib/test_firmware.c
>>> (triggered by fw_run_tests.sh).
>>>
>>> Is there another test for request_firmware_into_buf?
>> I have no idea, sorry.
> The folks who implemented request_firmware_into_buf() didn't add a
> respective test, because, well, this API went upstream IMO without much
> ACKs / review, and even no damn users. Now we have a user so we're stuck
> with it.

The request_firmware_into_buf is a necessity for me as well

(along with the need for a partial request of the file which I'm adding).

>
> So new testing calls for it would be appreciated. If you have questions
> I am happy to help.

If you're an expert on the firmware test and can quickly add a simple 
test of request_firmware_into_buf

it would be appreciated.  If not, I'm going to have to dig further into 
this and send early versions of

a test out which would be great for you to comment on.

>
>    Luis

Thanks,

Scott

