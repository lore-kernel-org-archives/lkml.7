Return-Path: <SRS0=pFUE=23=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF62AC32771
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Jan 2020 08:37:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A558F21775
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Jan 2020 08:37:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726497AbgAFIhL convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 Jan 2020 03:37:11 -0500
Received: from youngberry.canonical.com ([91.189.89.112]:38255 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725821AbgAFIhK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Jan 2020 03:37:10 -0500
Received: from mail-pj1-f72.google.com ([209.85.216.72])
        by youngberry.canonical.com with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <kai.heng.feng@canonical.com>)
        id 1ioNsq-0003OA-AZ
        for linux-kernel@vger.kernel.org; Mon, 06 Jan 2020 08:37:08 +0000
Received: by mail-pj1-f72.google.com with SMTP id 14so12203120pjo.3
        for <linux-kernel@vger.kernel.org>; Mon, 06 Jan 2020 00:37:08 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=SNXkADHZhyJy0Bp0apNiPJvlafdrd5bDbFyFMJQ4dXU=;
        b=WDJZI1IKwsc+InPUKE3Bh+wD9OV378EmKK9dZgVrLBrsII1zWSJSxUqOTSuzae3T1c
         +dF+RG/8LoEiB5k6FOsH0TYrEFzoszV0i3OXaZQHJ1scQyzR3MbIu16DlGTO3qqkbLKw
         eU2ixG+nQ6vux0L++H480v1HrNE1A6dCwOKv+ut8YzSNXGKlqKFPyZNyd+1Fjjqz+q9B
         LXr+sOVFPFhPs0WS52sRf30yRlItuChBsspNuxmyvBTL8vYiJncLeFz4LcWqrhP6ePPS
         6lJTU1b21mcq9UDmJB+YKsTy14/eit/PubGj3ffMG022z/1lQEFRHdsF++7yv7Kim1Z8
         Xrug==
X-Gm-Message-State: APjAAAV/rax63HvlqJjP7zGAXz0L+lKqJ+MNANzCBb6Y7HwluJsJucgN
        7gSvORLourlCAULzbFzkSft4fvgFvc+I8NUUHeFpqJ6gLGfvAOPkayWTk9maEH5Gb/IRS4VjBgD
        Z9xq2dSPqbraqEjiJPEL9sRzMrQVYs2S32HRQpCnqgA==
X-Received: by 2002:a17:90a:d78f:: with SMTP id z15mr41730961pju.36.1578299826804;
        Mon, 06 Jan 2020 00:37:06 -0800 (PST)
X-Google-Smtp-Source: APXvYqzEWrpnG0Qq6ElKUrUWzb4feESIT75MmnAI+RtORJgSr8PQwJVAJItr4+ahT0t2D7LvT5sagw==
X-Received: by 2002:a17:90a:d78f:: with SMTP id z15mr41730949pju.36.1578299826569;
        Mon, 06 Jan 2020 00:37:06 -0800 (PST)
Received: from 2001-b011-380f-35a3-2839-ccbd-36ed-2f4a.dynamic-ip6.hinet.net (2001-b011-380f-35a3-2839-ccbd-36ed-2f4a.dynamic-ip6.hinet.net. [2001:b011:380f:35a3:2839:ccbd:36ed:2f4a])
        by smtp.gmail.com with ESMTPSA id o31sm72172458pgb.56.2020.01.06.00.37.05
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 06 Jan 2020 00:37:06 -0800 (PST)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 13.0 \(3608.40.2.2.4\))
Subject: Re: [PATCH v2] iommu/amd: Disable IOMMU on Stoney Ridge systems
From:   Kai-Heng Feng <kai.heng.feng@canonical.com>
In-Reply-To: <84CFD1EE-2DB7-451F-98E4-58C4B0046A81@canonical.com>
Date:   Mon, 6 Jan 2020 16:37:04 +0800
Cc:     Joerg Roedel <joro@8bytes.org>,
        Christoph Hellwig <hch@infradead.org>,
        "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
        Kernel development list <linux-kernel@vger.kernel.org>
Content-Transfer-Encoding: 8BIT
Message-Id: <C4ADFDF0-8252-412A-8CFE-8E5ACE853B0A@canonical.com>
References: <20191129142154.29658-1-kai.heng.feng@canonical.com>
 <20191202170011.GC30032@infradead.org>
 <974A8EB3-70B6-4A33-B36C-CFF69464493C@canonical.com>
 <20191217095341.GG8689@8bytes.org>
 <6DC0EAB3-89B5-4A16-9A38-D7AD954DDF1C@canonical.com>
 <CY4PR12MB13505BE6EFF95F7C48253120F7520@CY4PR12MB1350.namprd12.prod.outlook.com>
 <84CFD1EE-2DB7-451F-98E4-58C4B0046A81@canonical.com>
To:     "Deucher, Alexander" <Alexander.Deucher@amd.com>
X-Mailer: Apple Mail (2.3608.40.2.2.4)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> On Dec 20, 2019, at 10:13, Kai-Heng Feng <kai.heng.feng@canonical.com> wrote:
> 
> 
> 
>> On Dec 20, 2019, at 03:15, Deucher, Alexander <Alexander.Deucher@amd.com> wrote:
>> 
>>> -----Original Message-----
>>> From: Kai-Heng Feng <kai.heng.feng@canonical.com>
>>> Sent: Wednesday, December 18, 2019 12:45 PM
>>> To: Joerg Roedel <joro@8bytes.org>
>>> Cc: Christoph Hellwig <hch@infradead.org>; Deucher, Alexander
>>> <Alexander.Deucher@amd.com>; iommu@lists.linux-foundation.org; Kernel
>>> development list <linux-kernel@vger.kernel.org>
>>> Subject: Re: [PATCH v2] iommu/amd: Disable IOMMU on Stoney Ridge
>>> systems
>>> 
>>> 
>>> 
>>>> On Dec 17, 2019, at 17:53, Joerg Roedel <joro@8bytes.org> wrote:
>>>> 
>>>> On Fri, Dec 06, 2019 at 01:57:41PM +0800, Kai-Heng Feng wrote:
>>>>> Hi Joerg,
>>>>> 
>>>>>> On Dec 3, 2019, at 01:00, Christoph Hellwig <hch@infradead.org> wrote:
>>>>>> 
>>>>>> On Fri, Nov 29, 2019 at 10:21:54PM +0800, Kai-Heng Feng wrote:
>>>>>>> Serious screen flickering when Stoney Ridge outputs to a 4K monitor.
>>>>>>> 
>>>>>>> According to Alex Deucher, IOMMU isn't enabled on Windows, so let's
>>>>>>> do the same here to avoid screen flickering on 4K monitor.
>>>>>> 
>>>>>> Disabling the IOMMU entirely seem pretty severe.  Isn't it enough to
>>>>>> identity map the GPU device?
>>>>> 
>>>>> Ok, there's set_device_exclusion_range() to exclude the device from
>>> IOMMU.
>>>>> However I don't know how to generate range_start and range_length,
>>> which are read from ACPI.
>>>> 
>>>> set_device_exclusion_range() is not the solution here. The best is if
>>>> the GPU device is put into a passthrough domain at boot, in which it
>>>> will be identity mapped. DMA still goes through the IOMMU in this
>>>> case, but it only needs to lookup the device-table, page-table walks
>>>> will not be done anymore.
>>>> 
>>>> The best way to implement this is to put it into the
>>>> amd_iommu_add_device() in drivers/iommu/amd_iommu.c. There is this
>>>> check:
>>>> 
>>>>      if (dev_data->iommu_v2)
>>>> 		iommu_request_dm_for_dev(dev);
>>>> 
>>>> The iommu_request_dm_for_dev() function causes the device to be
>>>> identity mapped. The check can be extended to also check for a device
>>>> white-list for devices that need identity mapping.
>>> 
>>> My patch looks like this but the original behavior (4K screen flickering) is still
>>> the same:
>> 
>> Does reverting the patch to disable ATS along with this patch help?
> 
> Unfortunately it doesn't help.

Any further suggestion to let me try?

Kai-Heng

> 
> Kai-Heng
> 
>> 
>> Alex
>> 
>>> 
>>> diff --git a/drivers/iommu/amd_iommu.c b/drivers/iommu/amd_iommu.c
>>> index bd25674ee4db..f913a25c9e92 100644
>>> --- a/drivers/iommu/amd_iommu.c
>>> +++ b/drivers/iommu/amd_iommu.c
>>> @@ -42,6 +42,7 @@
>>> #include <asm/iommu.h>
>>> #include <asm/gart.h>
>>> #include <asm/dma.h>
>>> +#include <asm/pci-direct.h>
>>> 
>>> #include "amd_iommu_proto.h"
>>> #include "amd_iommu_types.h"
>>> @@ -2159,6 +2160,8 @@ static int amd_iommu_add_device(struct device
>>> *dev)
>>>       struct iommu_domain *domain;
>>>       struct amd_iommu *iommu;
>>>       int ret, devid;
>>> +       bool need_identity_mapping = false;
>>> +       u32 header;
>>> 
>>>       if (!check_device(dev) || get_dev_data(dev))
>>>               return 0;
>>> @@ -2184,7 +2187,11 @@ static int amd_iommu_add_device(struct device
>>> *dev)
>>> 
>>>       BUG_ON(!dev_data);
>>> 
>>> -       if (dev_data->iommu_v2)
>>> +       header = read_pci_config(0, PCI_BUS_NUM(devid), PCI_SLOT(devid),
>>> PCI_FUNC(devid));
>>> +       if ((header & 0xffff) == 0x1002 && (header >> 16) == 0x98e4)
>>> +               need_identity_mapping = true;
>>> +
>>> +       if (dev_data->iommu_v2 || need_identity_mapping)
>>>               iommu_request_dm_for_dev(dev);
>>> 
>>>       /* Domains are initialized for this device - have a look what we ended up
>>> with */
>>> 
>>> 
>>> $ dmesg | grep -i direct
>>> [    0.011446] Using GB pages for direct mapping
>>> [    0.703369] pci 0000:00:01.0: Using iommu direct mapping
>>> [    0.703830] pci 0000:00:08.0: Using iommu direct mapping
>>> 
>>> So the graphics device (pci 0000:00:01.0:) is using direct mapping after the
>>> change.
>>> 
>>> Kai-Heng
>>> 
>>>> 
>>>> HTH,
>>>> 
>>>> 	Joerg

