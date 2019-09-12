Return-Path: <SRS0=nCuq=XH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B4018C4CEC6
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Sep 2019 14:09:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 84AFE2053B
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Sep 2019 14:09:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="JOU6finH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732514AbfILOJu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 12 Sep 2019 10:09:50 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:37176 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732256AbfILOJu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Sep 2019 10:09:50 -0400
Received: by mail-pf1-f194.google.com with SMTP id y5so13340855pfo.4
        for <linux-kernel@vger.kernel.org>; Thu, 12 Sep 2019 07:09:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=ZnvkXeE/NouRTMjADqsNxsh5aVxw8JSpgJbJ0q6Dnh8=;
        b=JOU6finHwkFSER4Suo7KJDClkDEqCW59YUrMvHJi2QaxYSV05gnVnOoi6bVk7tR2Da
         +sVA2IJda6RA4rkuqADMyJHu5r+5C6Kml6apsJcfL/rwM/R+vQ1cP2eczM4BjqV9KjqQ
         P4MSoMKCtiqS20IPGvZ1/s13xmz9/jUCev55Z3cvc0q/p53+cqVF5eTYPLp7LoKBLuaV
         gdenMC4VrJyHp+iJeUQqZVisTRseTraT4j299s8RcceOy526feL6ie2qFh5VFMMQqgRB
         0mQ2ecrs/WbjElm+l3+5Nc2H/83YkmgEaMzaSyyNaEFuUAzurWgIAxbjPtcAooyep4yc
         mNpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=ZnvkXeE/NouRTMjADqsNxsh5aVxw8JSpgJbJ0q6Dnh8=;
        b=hmAoW3TbXO1wkPe7Ni3TvmVcfHrT2220K1gqKfEyMM0rzny6ZG0S09Nf2gNJ88JqeP
         Is7o7FWmHU0tF6ZE/lftLnn5Ao1b78H0aHj9YtBzELY5j2y5jYhVPu5HayOYvk67B2V4
         XibCw2o9mWcCi+Ql8bShh4kDZ1rNanwHUTkWFkHh4pZaXFpuUJRDrZxYA6Rmc4TL5gPg
         3NMPIdOMtyx37OD7+/FVqnnG/iBrTB6FNgbaE3/+qAPvF1Ci7mJKt7A3BJTeYAHq3/Wp
         LbGguPX7PdIaUQDkIp/0Y0mYZ/vy3nngpETgv6O0UiXChWynKoYU+OOiTwazCLGpf2GZ
         4JYA==
X-Gm-Message-State: APjAAAWFDAhKqpCqwPvy/2v0bV4MZfZIVGQdnfaHkqo4mWIbsWhiZazz
        kN5VaWVzh9Mv0uLQCKwDEH6NDw==
X-Google-Smtp-Source: APXvYqxVkGAME+kwdUcczJkM7udi5U9zCXsnMS1DkBi2oDVekxtHBpXR6skwlwOKFcOmGW+Wk/lI7A==
X-Received: by 2002:aa7:9794:: with SMTP id o20mr50505121pfp.8.1568297389838;
        Thu, 12 Sep 2019 07:09:49 -0700 (PDT)
Received: from [10.69.0.162] ([193.187.117.163])
        by smtp.gmail.com with ESMTPSA id b5sm44795991pfp.38.2019.09.12.07.09.41
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 12 Sep 2019 07:09:49 -0700 (PDT)
Subject: Re: [PATCH v3 2/2] uacce: add uacce driver
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Arnd Bergmann <arnd@arndb.de>, jonathan.cameron@huawei.com,
        kenneth-lee-2012@foxmail.com, Wangzhou <wangzhou1@hisilicon.com>,
        linux-accelerators@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        Kenneth Lee <liguozhu@hisilicon.com>,
        Zaibo Xu <xuzaibo@huawei.com>
References: <1567482778-5700-1-git-send-email-zhangfei.gao@linaro.org>
 <1567484087-8071-1-git-send-email-zhangfei.gao@linaro.org>
 <1567484087-8071-2-git-send-email-zhangfei.gao@linaro.org>
 <20190904123803.GC5043@kroah.com>
From:   zhangfei <zhangfei.gao@linaro.org>
Message-ID: <c4c53513-a5f1-ce02-c108-2d0e05dd0236@linaro.org>
Date:   Thu, 12 Sep 2019 22:09:36 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190904123803.GC5043@kroah.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2019/9/4 下午8:38, Greg Kroah-Hartman wrote:
> On Tue, Sep 03, 2019 at 12:14:47PM +0800, Zhangfei Gao wrote:
>> From: Kenneth Lee <liguozhu@hisilicon.com>
>>
>> Uacce (Unified/User-space-access-intended Accelerator Framework) targets to
>> provide Shared Virtual Addressing (SVA) between accelerators and processes.
>> So accelerator can access any data structure of the main cpu.
>> This differs from the data sharing between cpu and io device, which share
>> data content rather than address.
>> Since unified address, hardware and user space of process can share the
>> same virtual address in the communication.
>>
>> Uacce create a chrdev for every registration, the queue is allocated to
>> the process when the chrdev is opened. Then the process can access the
>> hardware resource by interact with the queue file. By mmap the queue
>> file space to user space, the process can directly put requests to the
>> hardware without syscall to the kernel space.
>>
>> Signed-off-by: Kenneth Lee <liguozhu@hisilicon.com>
>> Signed-off-by: Zaibo Xu <xuzaibo@huawei.com>
>> Signed-off-by: Zhou Wang <wangzhou1@hisilicon.com>
>> Signed-off-by: Zhangfei Gao <zhangfei.gao@linaro.org>
>> ---
>>   Documentation/ABI/testing/sysfs-driver-uacce |   47 ++
>>   drivers/misc/Kconfig                         |    1 +
>>   drivers/misc/Makefile                        |    1 +
>>   drivers/misc/uacce/Kconfig                   |   13 +
>>   drivers/misc/uacce/Makefile                  |    2 +
>>   drivers/misc/uacce/uacce.c                   | 1096 ++++++++++++++++++++++++++
>>   include/linux/uacce.h                        |  172 ++++
>>   include/uapi/misc/uacce.h                    |   39 +
>>   8 files changed, 1371 insertions(+)
>>   create mode 100644 Documentation/ABI/testing/sysfs-driver-uacce
>>   create mode 100644 drivers/misc/uacce/Kconfig
>>   create mode 100644 drivers/misc/uacce/Makefile
>>   create mode 100644 drivers/misc/uacce/uacce.c
>>   create mode 100644 include/linux/uacce.h
>>   create mode 100644 include/uapi/misc/uacce.h
>>
>> diff --git a/Documentation/ABI/testing/sysfs-driver-uacce b/Documentation/ABI/testing/sysfs-driver-uacce
>> new file mode 100644
>> index 0000000..ee0a66e
>> --- /dev/null
>> +++ b/Documentation/ABI/testing/sysfs-driver-uacce
>> @@ -0,0 +1,47 @@
>> +What:           /sys/class/uacce/hisi_zip-<n>/id
>> +Date:           Sep 2019
>> +KernelVersion:  5.3
> 5.3 will be released in a week or so, without this file in it, so that's
> not ok here :(
>
Thanks, will use 5.4 instead.
Since 5.4-rc1 still need some time, can I send updated version based on 
5.3-rc8 for more review.
And I found smmu in 5.3-rc1 have issue, and rc8 is OK.

Thanks
