Return-Path: <SRS0=dUEL=RQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3AABBC43381
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Mar 2019 20:11:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EC87120854
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Mar 2019 20:11:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="jPoN0OgG";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="JeREGWIa"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727197AbfCMULc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Mar 2019 16:11:32 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:60918 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726850AbfCMULb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Mar 2019 16:11:31 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 3D03B60386; Wed, 13 Mar 2019 20:11:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1552507890;
        bh=qK2c72XP1M3htngDtJG3/h4XZVvLv/+mUdau+/gcYdk=;
        h=Date:From:To:cc:Subject:In-Reply-To:References:From;
        b=jPoN0OgGzdCF0OUD3USY/BaKR9asBhwg4FiIpmbrbrLg/uEb+Hj9I9o7RpyEWKYt4
         n+tXIn3AAU0WfDwYXm/m7793kjgcVO4npSoWh+bz8ZtGSMEk+GFt6jzNUisLsc3BBW
         rcO2W+ijZOjGKZMX3kcEFAY56Vl0bk4qCL2sSugk=
Received: from lmark-linux.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: lmark@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 9BDC960312;
        Wed, 13 Mar 2019 20:11:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1552507889;
        bh=qK2c72XP1M3htngDtJG3/h4XZVvLv/+mUdau+/gcYdk=;
        h=Date:From:To:cc:Subject:In-Reply-To:References:From;
        b=JeREGWIa6/Tk94IVW8ffE6OF4iK9plbLaSbEheV8PedM/Fr7fEFISh/uyHlXiQh7l
         Y4zY2vX+PVorZpAGPWNvmZWFJCBaYGIqjHck9BkI8RKU04s9T9hPq//BGsXPQfGRX7
         5tTDlg9CaA6X4WBTTgEhIyS1nV/XFZYmcowXQ4uo=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 9BDC960312
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=lmark@codeaurora.org
Date:   Wed, 13 Mar 2019 13:11:28 -0700 (PDT)
From:   Liam Mark <lmark@codeaurora.org>
X-X-Sender: lmark@lmark-linux.qualcomm.com
To:     John Stultz <john.stultz@linaro.org>
cc:     lkml <linux-kernel@vger.kernel.org>,
        Laura Abbott <labbott@redhat.com>,
        Benjamin Gaignard <benjamin.gaignard@linaro.org>,
        Greg KH <gregkh@linuxfoundation.org>,
        Sumit Semwal <sumit.semwal@linaro.org>,
        Brian Starkey <Brian.Starkey@arm.com>,
        "Andrew F . Davis" <afd@ti.com>, Chenbo Feng <fengc@google.com>,
        Alistair Strachan <astrachan@google.com>,
        dri-devel <dri-devel@lists.freedesktop.org>
Subject: Re: [RFC][PATCH 0/5 v2] DMA-BUF Heaps (destaging ION)
In-Reply-To: <1551819273-640-1-git-send-email-john.stultz@linaro.org>
Message-ID: <alpine.DEB.2.10.1903131309260.5023@lmark-linux.qualcomm.com>
References: <1551819273-640-1-git-send-email-john.stultz@linaro.org>
User-Agent: Alpine 2.10 (DEB 1266 2009-07-14)
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 5 Mar 2019, John Stultz wrote:

> Here is a initial RFC of the dma-buf heaps patchset Andrew and I
> have been working on which tries to destage a fair chunk of ION
> functionality.
> 
> The patchset implements per-heap devices which can be opened
> directly and then an ioctl is used to allocate a dmabuf from the
> heap.
> 
> The interface is similar, but much simpler then IONs, only
> providing an ALLOC ioctl.
> 
> Also, I've provided simple system and cma heaps. The system
> heap in particular is missing the page-pool optimizations ION
> had, but works well enough to validate the interface.
> 
> I've booted and tested these patches with AOSP on the HiKey960
> using the kernel tree here:
>   https://git.linaro.org/people/john.stultz/android-dev.git/log/?h=dev/dma-buf-heap
> 
> And the userspace changes here:
>   https://android-review.googlesource.com/c/device/linaro/hikey/+/909436
> 
> 
> Compared to ION, this patchset is missing the system-contig,
> carveout and chunk heaps, as I don't have a device that uses
> those, so I'm unable to do much useful validation there.
> Additionally we have no upstream users of chunk or carveout,
> and the system-contig has been deprecated in the common/andoid-*
> kernels, so this should be ok.
> 
> I've also removed the stats accounting for now, since it should
> be implemented by the heaps themselves.
> 
> Eventual TODOS:
> * Reimplement page-pool for system heap (working on this)
> * Add stats accounting to system/cma heaps
> * Make the kselftest actually useful
> * Add other heaps folks see as useful (would love to get
>   some help from actual carveout/chunk users)!

We use a modified carveout heap for certain secure use cases.
Although there would probably be some benefit in discssing how the dma-buf 
heap framework may want to support 
secure heaps in the future it is a large topic which I assume you don't 
want to tackle now.

We don't have any non-secure carveout heap use cases but the client use 
case I have seen usually revolve around
wanting large allocations to succeed very quickly.
For example I have seen camera use cases which do very large allocations 
on camera bootup from the carveout heap, these allocations would come from 
the carveout heap and fallback to the system heap when the carveout heap 
was full.
Actual non-secure carveout heap can perhaps provide more detail.

> 
> That said, the main user-interface is shaping up and I wanted
> to get some input on the device model (particularly from GreKH)
> and any other API/ABI specific input. 
> 
> thanks
> -john

Thanks John and Andrew, it's great to see this effort to get this 
functionality out of staging.

Since we are making some fundamental changes to how ION worked and since 
Android is likely also be the largest user of the dma-buf heaps framework 
I think it would be good
to have a path to resolve the issues which are currently preventing 
commercial Android releases from moving to the upstream version of ION.

I can understand if you don't necessarily want to put all/any of these 
changes into the dma-buf heaps framework as part of this series, but my 
hope is we can get 
the upstream community and the Android framework team to agree on what 
upstreamable changes to dma-buf heaps framework, and/or the Android 
framework, would be required in order for Android to move to the upstream 
dma-buf heaps framework for commercial devices.

I don't mean to make this specific to Android, but my assumption is that 
many of the ION/dma-buf heaps issues which affect Android would likely 
affect other new large users of the dma-buf heaps framework, so if we 
resolve it for Android we would be helping these future users as well.
And I do understand that some the issues facing Android may need to be 
resolved by making changes to Android framework.

I think it would be helpful to try and get as much of this agreed upon as 
possible before the dma-buf heaps framework moves out of staging.

As part of my review I will highlight some of the issues which would 
affect Android. 
In my comments I will apply them to the system heap since that is what 
Android currently uses for a lot of its use cases. 
I realize that this new framework provides more flexibility to heaps, so 
perhaps some of these issues can be solved by creating a new type of 
system heap which Android can use, but even if the solution involves 
creating a new system heap I would like to make sure that this "new" 
system heap is upstreamable.

Liam

Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project
