Return-Path: <SRS0=D3m8=SL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 292C6C10F0E
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Apr 2019 09:33:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E515D2084C
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Apr 2019 09:33:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ulTtk/ld"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726926AbfDIJdk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Apr 2019 05:33:40 -0400
Received: from mail-lj1-f195.google.com ([209.85.208.195]:45005 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726415AbfDIJdk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Apr 2019 05:33:40 -0400
Received: by mail-lj1-f195.google.com with SMTP id h16so13792361ljg.11;
        Tue, 09 Apr 2019 02:33:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=bpEoroqe8Vp8JLe+a+fB4DDSJyjMUy4xWQYTUs11Mmk=;
        b=ulTtk/ldw8xNleyN3RVmoSUh+pryf5vYaxnMBc7yrLdV2lD5r4uN4c7PGg87IIXPEV
         cS4KKVbcPR7pyV67YkQRGRl0fx2gEDj1DBYti7JqSosJQ4Dzq0lrl0s5hwineeOvWUTt
         hhw/6o8wKDZUTCb/hfqvGsVaNRPC8sK9yS6pDgc+RDrtGM1lak29gs1TSQgjrmVdhcob
         MDvKQ/kwJkcY3KyzCKqz+z5/OU4sAr4CIgjzwoNTSbWyvJmVPghVMrpYTx226hu+S/Nw
         AB65htVdPEDo1eTWkSrSYVcrvVN910btnUMtMb6nm+7CNAIaVNgyC67cBZpgoIrhpp8d
         dWNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=bpEoroqe8Vp8JLe+a+fB4DDSJyjMUy4xWQYTUs11Mmk=;
        b=jDvy1FVjRxGWSO5L0j5k8vN51Qv1SHLrvPuvDVYodHWCC/bAroyKLuES9DfB+BhZmm
         n/5OvQZFJuuOjkZUYXrcBiCouRHnzfuAdhB8RtUMpv5fOQedR3O+VMA1io9A4CBbxYBE
         c8/BOSUuETmRpwOf12XCKjME1sEiJTyis9goToJF2rDQqyHBdrLdxE3qPR873Op1E2+X
         CWNHuq6WCgDR+od4xg8CjRC385A8EL9CB6NGHraQSJDmt2sP8gQhhKG+USlA0+X2I35B
         nsmyBQ61gufNZgfLz7JNN77hcaoSir5u5fBtv7cbzyKaCaRgmoUUl2QdtidjE3UJmRtz
         fecQ==
X-Gm-Message-State: APjAAAU2mN27jxu0Wkvxb2G/vuziz20Ny3fmtxilHU9Oz/AUQ/0mDt/F
        Ic4ZFLp5Kf6n1R0TGEpmXnA=
X-Google-Smtp-Source: APXvYqxekaf2DHxVXGAH2Dwda6xobUOhybMUtpuSHHOTSQK0kCJME2+6aS3ngvsCpi9qdcBI+kHdtQ==
X-Received: by 2002:a2e:128a:: with SMTP id 10mr18570150ljs.170.1554802417981;
        Tue, 09 Apr 2019 02:33:37 -0700 (PDT)
Received: from [10.17.182.20] (ll-74.141.223.85.sovam.net.ua. [85.223.141.74])
        by smtp.gmail.com with ESMTPSA id a7sm6398830lfo.8.2019.04.09.02.33.36
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 09 Apr 2019 02:33:37 -0700 (PDT)
Subject: Re: [Xen-devel][PATCH] xen/cameraif: add ABI for para-virtual camera
To:     Juergen Gross <jgross@suse.com>, xen-devel@lists.xenproject.org,
        linux-kernel@vger.kernel.org, linux-media@vger.kernel.org,
        konrad.wilk@oracle.com, hverkuil@xs4all.nl,
        boris.ostrovsky@oracle.com
Cc:     Oleksandr Andrushchenko <oleksandr_andrushchenko@epam.com>
References: <20190409091546.9606-1-andr2000@gmail.com>
 <9b9ba6b9-f045-80e2-fe8a-595728fb1ec0@suse.com>
From:   Oleksandr Andrushchenko <andr2000@gmail.com>
Message-ID: <5bb8c828-b0ae-86c3-dacf-88bf6032dd6f@gmail.com>
Date:   Tue, 9 Apr 2019 12:33:36 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <9b9ba6b9-f045-80e2-fe8a-595728fb1ec0@suse.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/9/19 12:28 PM, Juergen Gross wrote:
> On 09/04/2019 11:15, Oleksandr Andrushchenko wrote:
>> From: Oleksandr Andrushchenko <oleksandr_andrushchenko@epam.com>
>>
>> This is the ABI for the two halves of a para-virtualized
>> camera driver which extends Xen's reach multimedia capabilities even
>> further enabling it for video conferencing, In-Vehicle Infotainment,
>> high definition maps etc.
>>
>> The initial goal is to support most needed functionality with the
>> final idea to make it possible to extend the protocol if need be:
>>
>> 1. Provide means for base virtual device configuration:
>>   - pixel formats
>>   - resolutions
>>   - frame rates
>> 2. Support basic camera controls:
>>   - contrast
>>   - brightness
>>   - hue
>>   - saturation
>> 3. Support streaming control
>>
>> Signed-off-by: Oleksandr Andrushchenko <oleksandr_andrushchenko@epam.com>
>> Cc: Juergen Gross <jgross@suse.com>
>> Cc: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
>> Cc: Hans Verkuil <hverkuil@xs4all.nl>
> I'm in principle fine with this patch, but it should be sent as part of
> a series using that header. In case the related driver isn't accepted
> we'd end up with a stale header file.
Hm, I am doing this as I did for the rest of protocols before:
1. Get the protocol in Xen
2. Get the copy in Linux
3. Upstream driver (use header)

Even if the driver is not accepted (hope this won't happen)
then this patch makes Xen and Linux properly aligned anyway.
Which is IMO good
>
> Juergen
Thank you,
Oleksandr
