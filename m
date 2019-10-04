Return-Path: <SRS0=OvUS=X5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2014BC47404
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Oct 2019 13:22:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E5FF921D81
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Oct 2019 13:22:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="vUmqqKfe"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388475AbfJDNW3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 4 Oct 2019 09:22:29 -0400
Received: from mail-io1-f65.google.com ([209.85.166.65]:38245 "EHLO
        mail-io1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387952AbfJDNW2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Oct 2019 09:22:28 -0400
Received: by mail-io1-f65.google.com with SMTP id u8so13465900iom.5
        for <linux-kernel@vger.kernel.org>; Fri, 04 Oct 2019 06:22:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=LEJ9dg5xbbVV3C3q2sRRPp0B1uzrgFWed1hhJkYm69Y=;
        b=vUmqqKfe0iMgqQT1tBxf5L1Tzjr/8LsPzYoTRi5HnnZQi6OPLN+MSrqfkvxFB+KJ8g
         J9TSTshM2pCNFHqUrXr7VWcEaqbB0zClY5hRVcYS7c2VS3XzldzVcvDZUD/4jUzEglN1
         L3MxWuOxvJNCHRVQv2ut5Dp0i++aZiOmqPOxf6g80n4QyQWCc9NDVP195xFSbZmFsSw5
         qSC6svrQG+aRjdCg3/AzDyeO2ufS+lVeOTC8evuIySD7T9s0N44Vh8tGGxGKbex5JbSN
         xA3mBb26Yj7FdvVCNxGaldGhi0xovY9K+VXUkqFx9sFpxVxMOY6Fln1oLJIdiGCqg6vZ
         VCmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=LEJ9dg5xbbVV3C3q2sRRPp0B1uzrgFWed1hhJkYm69Y=;
        b=YukR7eWFGlOMwXQySr/I6fCX/kkv7jr5zGCj2sRmKa9P8HmdiVAlk6Cm/kiDX0T2KR
         mWfoLSZ12TXSu+kBgK0hVs/ZZ+yxFABKewuQXMsniSfS82/jsXi9Kxi5nkRjRDq4jPFZ
         wHW7oQZbbjtK8R9Yw2Io/SpglMSb5mMa3JV3v5MLUv4fKL1qeZKcLuVCmcgZEMv1ayog
         CE9eRTRnYYS3iKsDSLY8RflRWkzSQ7y8XQw6h4Rp80Dm/YK0wr4bkrWEbTOAhjADf/ab
         h+Ov8AZTEA6L/1fb6c4j7krhBw0CpvfK8ayK7t8nVRKmMPNDSsGDrJV0wcC60riMAelT
         3MQw==
X-Gm-Message-State: APjAAAVDulIc6224tRHykr5tLm9vTuvGa+Mg9jgxWwKdkOyovoD8zi9e
        TKPrdH/hFh5w0DuZ0LRdd2P85Q==
X-Google-Smtp-Source: APXvYqwQrXsm+JA/LtxH6GpCLZs4bFRPqRu7If4SldN0S4B5xsUwRTuxEufarPrQTL32YciKOaVH/Q==
X-Received: by 2002:a02:7f49:: with SMTP id r70mr14623123jac.85.1570195347722;
        Fri, 04 Oct 2019 06:22:27 -0700 (PDT)
Received: from [192.168.1.50] ([65.144.74.34])
        by smtp.gmail.com with ESMTPSA id c65sm3169547ilg.26.2019.10.04.06.22.26
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 04 Oct 2019 06:22:26 -0700 (PDT)
Subject: Re: [PATCH 1/2] bdi: Do not use freezable workqueue
To:     Mika Westerberg <mika.westerberg@linux.intel.com>,
        "Rafael J . Wysocki" <rjw@rjwysocki.net>
Cc:     Pavel Machek <pavel@ucw.cz>, Jan Kara <jack@suse.cz>,
        Tejun Heo <tj@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        AceLan Kao <acelan.kao@canonical.com>,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
References: <20191004100025.70798-1-mika.westerberg@linux.intel.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <0002b2f3-d17c-0d49-52f4-b2ce31832e6c@kernel.dk>
Date:   Fri, 4 Oct 2019 07:22:25 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20191004100025.70798-1-mika.westerberg@linux.intel.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/4/19 4:00 AM, Mika Westerberg wrote:
> A removable block device, such as NVMe or SSD connected over Thunderbolt
> can be hot-removed any time including when the system is suspended. When
> device is hot-removed during suspend and the system gets resumed, kernel
> first resumes devices and then thaws the userspace including freezable
> workqueues. What happens in that case is that the NVMe driver notices
> that the device is unplugged and removes it from the system. This ends
> up calling bdi_unregister() for the gendisk which then schedules
> wb_workfn() to be run one more time.
> 
> However, since the bdi_wq is still frozen flush_delayed_work() call in
> wb_shutdown() blocks forever halting system resume process. User sees
> this as hang as nothing is happening anymore.
> 
> Triggering sysrq-w reveals this:
> 
>    Workqueue: nvme-wq nvme_remove_dead_ctrl_work [nvme]
>    Call Trace:
>     ? __schedule+0x2c5/0x630
>     ? wait_for_completion+0xa4/0x120
>     schedule+0x3e/0xc0
>     schedule_timeout+0x1c9/0x320
>     ? resched_curr+0x1f/0xd0
>     ? wait_for_completion+0xa4/0x120
>     wait_for_completion+0xc3/0x120
>     ? wake_up_q+0x60/0x60
>     __flush_work+0x131/0x1e0
>     ? flush_workqueue_prep_pwqs+0x130/0x130
>     bdi_unregister+0xb9/0x130
>     del_gendisk+0x2d2/0x2e0
>     nvme_ns_remove+0xed/0x110 [nvme_core]
>     nvme_remove_namespaces+0x96/0xd0 [nvme_core]
>     nvme_remove+0x5b/0x160 [nvme]
>     pci_device_remove+0x36/0x90
>     device_release_driver_internal+0xdf/0x1c0
>     nvme_remove_dead_ctrl_work+0x14/0x30 [nvme]
>     process_one_work+0x1c2/0x3f0
>     worker_thread+0x48/0x3e0
>     kthread+0x100/0x140
>     ? current_work+0x30/0x30
>     ? kthread_park+0x80/0x80
>     ret_from_fork+0x35/0x40
> 
> This is not limited to NVMes so exactly same issue can be reproduced by
> hot-removing SSD (over Thunderbolt) while the system is suspended.
> 
> Prevent this from happening by removing WQ_FREEZABLE from bdi_wq.

This series looks good for me, I don't think there's a reason for
the workers to be marked freezable.

-- 
Jens Axboe

