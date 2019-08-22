Return-Path: <SRS0=/WLL=WS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC423C3A5A3
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Aug 2019 20:07:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A130C21848
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Aug 2019 20:07:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="C3g11sbi"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388439AbfHVUHq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 22 Aug 2019 16:07:46 -0400
Received: from mail-pl1-f195.google.com ([209.85.214.195]:35364 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731461AbfHVUHq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Aug 2019 16:07:46 -0400
Received: by mail-pl1-f195.google.com with SMTP id gn20so4081220plb.2
        for <linux-kernel@vger.kernel.org>; Thu, 22 Aug 2019 13:07:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=T7WELdrj1lpZKb10glO64Ci1A/cHC9qRquQl0ZBFVYE=;
        b=C3g11sbiJLWJXhTVKSRs7RsmwmyNDMWE2NR02ihZhTaX8aV3FEKZ5YdkwOxo6qCVWq
         m8jJkKYj85QU0HpYZJ1Drc4qi0TJV0r3IGjyGWOOP0/s3ieUNAmBO2MVB0IRxNYezn93
         Ta1X+nvAuArVldordiVEZgCtlKT/kaqGj7nFc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=T7WELdrj1lpZKb10glO64Ci1A/cHC9qRquQl0ZBFVYE=;
        b=PDIZWCQXBHg5tBx94xIL6FL8yU8hbQzS97j9HV2ZXTU4rDd360+JSbDj1cZtxmdKhF
         P8e56BVm1oD5BV+eIXlQ8p5m4mgmUJx573eQXppmv5AHIOgY+uNbXD5lsHwz4yrV3vtV
         ZO5km3dMne11B6waGLfN1KEs2liS3uscicUDQLyowT93/8B7XX5k27WeVIWAeUIl/aqJ
         WmUq0v0P6riJ4amlzf7R50qQn7+6+jBH3QUyV4uHyF9kGPyK2Of4sYHI5rtQYzL4+fWb
         Y+puBM1cRD9JqIRrcnfb9IFhwn4RUnMSupI0D2/2z5ZAr//g6MTQsy3QLEMxNrXAnqX2
         VYIA==
X-Gm-Message-State: APjAAAUZTbrfQMBQGMCyDMNZk77fKs3ZOIj9PzsbT3uQ4I3/obKS9xib
        wYbnP8AtKkCEQV8lIW7Trl4+/w==
X-Google-Smtp-Source: APXvYqwPgliCGszErOKKFpnP9RfEOJ+aybpl80q46iwpUnIp/wgrGOyV1u3N0905b4Kuaoc0P8jo7w==
X-Received: by 2002:a17:902:1027:: with SMTP id b36mr585958pla.203.1566504465286;
        Thu, 22 Aug 2019 13:07:45 -0700 (PDT)
Received: from [10.136.13.65] ([192.19.228.250])
        by smtp.gmail.com with ESMTPSA id k5sm229441pfg.167.2019.08.22.13.07.42
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 22 Aug 2019 13:07:44 -0700 (PDT)
Subject: Re: [PATCH 2/7] firmware: add offset to request_firmware_into_buf
To:     Luis Chamberlain <mcgrof@kernel.org>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
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
        Takashi Iwai <tiwai@suse.de>, linux-kselftest@vger.kernel.org
References: <20190822192451.5983-1-scott.branden@broadcom.com>
 <20190822192451.5983-3-scott.branden@broadcom.com>
 <20190822194712.GG16384@42.do-not-panic.com>
From:   Scott Branden <scott.branden@broadcom.com>
Message-ID: <7ee02971-e177-af05-28e0-90575ebe12e0@broadcom.com>
Date:   Thu, 22 Aug 2019 13:07:41 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190822194712.GG16384@42.do-not-panic.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Luis,

On 2019-08-22 12:47 p.m., Luis Chamberlain wrote:
> On Thu, Aug 22, 2019 at 12:24:46PM -0700, Scott Branden wrote:
>> @@ -923,16 +936,22 @@ EXPORT_SYMBOL_GPL(firmware_request_cache);
>>    */
>>   int
>>   request_firmware_into_buf(const struct firmware **firmware_p, const char *name,
>> -			  struct device *device, void *buf, size_t size)
>> +			  struct device *device, void *buf, size_t size,
>> +			  size_t offset, unsigned int pread_flags)
> This implies you having to change the other callers, and while currently
> our list of drivers is small,

Yes, the list is small, very small.

There is a single driver making a call to the existing API.

And, the existing API was never tested until I submitted a test case.

And, the maintainer of that driver wanted

to start utilizing my enhanced API instead of the current API.

As such I think it is very reasonable to update the API right now.

> following the history of the firmware API
> and the long history of debate of *how* we should evolve its API, its
> preferred we add yet another new caller for this functionality. So
> please add a new caller, and use EXPORT_SYMBOL_GPL().
>
> And while at it, pleaase use firmware_request_*() as the prefix, as we
> have want to use that as the instilled prefix. We have yet to complete
> the rename of the others older callers but its just a matter of time.
>
> So something like: firmware_request_into_buf_offset()

I would prefer to rename the API at this time given there is only a 
single user.

Otherwise I would need to duplicate quite a bit in the test code to 
support testing

the single user of the old api and then enhanced API.

Or, I can leave existing API in place and change the test case to

just test the enhanced API to keep things simpler in the test code?

>
> And thanks for adding a test case!
>
>    Luis

Regards,

  Scott

