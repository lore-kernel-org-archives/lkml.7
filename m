Return-Path: <SRS0=Exau=WQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 56116C3A589
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Aug 2019 14:26:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1FB0520673
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Aug 2019 14:26:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="w4BvD/kR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730261AbfHTO0q (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 20 Aug 2019 10:26:46 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:42843 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729137AbfHTO0p (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Aug 2019 10:26:45 -0400
Received: by mail-pf1-f194.google.com with SMTP id i30so3487666pfk.9
        for <linux-kernel@vger.kernel.org>; Tue, 20 Aug 2019 07:26:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=eKv56ZEwFrpcgGkKBcVZG6NhOyTxEsRDf/eV3W6TI/s=;
        b=w4BvD/kRr2PB3ha9zS1t0c0CTnwISrm7Pj+aaJofz63lfM9qcZ/YPkI/je69vRnnBx
         xA4brywz97Lxb716b1Vu1RYsQJiApnUK+r1rsf2+XkQB16EHCDffIObMQXE+ZTD6MTHP
         wXOjDDluzHVKFioKHkSSrtgbKVGRvgsxYKJFN6d0opkHiVxY+iTnve/a6Opn2DLKtmxN
         AjAAcL/G6jT6MXHSH5HS5Dw1jCewqGNb5POBRXSNigcjxISqdMABTgdB8UqEzZ+j2GOr
         NKMmbqgp29UZR6qCLO6HXMOlx03NNTIw38MuD9YQMXmh/tUZYOU7Lm7Bd3xb/hiKVepz
         H/Sg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=eKv56ZEwFrpcgGkKBcVZG6NhOyTxEsRDf/eV3W6TI/s=;
        b=qH+yf7HSlsKnOGTkFNalLdLLy7j0EsvuRRly6K1tas9Rua4YKXrv4x+ydcuYuXoXzh
         QgEdOmOKq/kUikCA2xkFVvKNVfDF81T0I00GblQR2EYOTPRwJBo/LH+Lrt+vrcnElJe+
         exLgtL9ahBRybHwJWtKptBh4bo03XWYWqKAr8DXIVhYb0nM0GGWRx+K9w7E/NBtFAQzf
         iAkDsQlPNWsjdkCWlIMySSwJeStGK7tF4hdC329iG9dBHF9155KA6aFOoF86Bd2naeSI
         8rFlMQ+6lowXsrLfE2npo+1mOAXr8xgV4u4qNqkcWNsh08GYE6MZfsgcy6S7ObhjbfY8
         lRgQ==
X-Gm-Message-State: APjAAAXaOpR+L3QRrlTi+E+TnmYC7Viw2DvyRdZANN7zSERDZhSIWswU
        MTUx79yidIo7PrLFt4VfkK4Olw==
X-Google-Smtp-Source: APXvYqzamelmb/oiJ+EoJwFHl8UE4By05zyt1pVHF4LLgGHJZCd/g+PNDC4dtPz3TknjAPHOlV7gyg==
X-Received: by 2002:a17:90a:9386:: with SMTP id q6mr249603pjo.81.1566311205012;
        Tue, 20 Aug 2019 07:26:45 -0700 (PDT)
Received: from ?IPv6:240e:362:43e:2200:6d55:ae74:3a5b:9669? ([240e:362:43e:2200:6d55:ae74:3a5b:9669])
        by smtp.gmail.com with ESMTPSA id d129sm19206549pfc.168.2019.08.20.07.26.40
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 20 Aug 2019 07:26:44 -0700 (PDT)
Subject: Re: [PATCH 0/2] A General Accelerator Framework, WarpDrive
To:     Jerome Glisse <jglisse@redhat.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Arnd Bergmann <arnd@arndb.de>, linux-kernel@vger.kernel.org,
        linux-accelerators@lists.ozlabs.org
References: <1565775265-21212-1-git-send-email-zhangfei.gao@linaro.org>
 <20190815170424.GA30916@redhat.com>
From:   zhangfei <zhangfei.gao@linaro.org>
Message-ID: <025f1139-d604-7800-64a8-fc2418980fc5@linaro.org>
Date:   Tue, 20 Aug 2019 22:26:30 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190815170424.GA30916@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, Jerome

Thanks for your suggestion

On 2019/8/16 上午1:04, Jerome Glisse wrote:
> On Wed, Aug 14, 2019 at 05:34:23PM +0800, Zhangfei Gao wrote:
>> *WarpDrive* is a general accelerator framework for the user application to
>> access the hardware without going through the kernel in data path.
>>
>> WarpDrive is the name for the whole framework. The component in kernel
>> is called uacce, meaning "Unified/User-space-access-intended Accelerator
>> Framework". It makes use of the capability of IOMMU to maintain a
>> unified virtual address space between the hardware and the process.
>>
>> WarpDrive is intended to be used with Jean Philippe Brucker's SVA
>> patchset[1], which enables IO side page fault and PASID support.
>> We have keep verifying with Jean's sva/current [2]
>> We also keep verifying with Eric's SMMUv3 Nested Stage patch [3]
>>
>> This series and related zip & qm driver as well as dummy driver for qemu test:
>> https://github.com/Linaro/linux-kernel-warpdrive/tree/5.3-rc1-warpdrive-v1
>> zip driver already been upstreamed.
>> zip supporting uacce will be the next step.
>>
>> The library and user application:
>> https://github.com/Linaro/warpdrive/tree/wdprd-v1-current
> Do we want a new framework ? I think that is the first question that
> should be answer here. Accelerator are in many forms and so far they
> never have been enough commonality to create a framework, even GPUs
> with the drm is an example of that, drm only offer share framework
> for the modesetting part of the GPU (as thankfully monitor connector
> are not specific to GPU brands :))
>
> FPGA is another example the only common code expose to userspace is
> about bitstream management AFAIK.
>
> I would argue that a framework should only be created once there is
> enough devices with same userspace API. Meanwhile you can provide
> in kernel helper that allow driver to expose same API. If after a
> while we have enough device driver which all use that same in kernel
> helpers API then it will a good time to introduce a new framework.
> Meanwhile this will allow individual device driver to tinker with
> their API and maybe get to something useful to more devices in the
> end.
>
> Note that what i propose also allow userspace code sharing for all
> driver that use the same in kernel helper.
>
Yes, we understand it is not easy for a new framework.
There are discussions in rfc2 (2018/9) and rfc3 (2018/11).
To make life easier, we plan to move the uacce to driver/misc to support 
our own product first until it is mature.
Using uacce, Currently we get quite a big performance improvement in our 
crypto product, like zip, hpre, sec.
Our final goal is "A General Accelerator Framework", which maybe ambitious.
So uacce is designed to be a common framework, can be easily supporting 
more accelerators.
And we are happy to get more requirements and make it mature.

Another good point is SVA support in ongoing, http://jpbrucker.net/sva/
After sva mature, the accelerators support will be much easier.

Thanks
