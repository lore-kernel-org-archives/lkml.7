Return-Path: <SRS0=ag/Q=Z7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ED05DC43603
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Dec 2019 09:16:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BF3F62072D
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Dec 2019 09:16:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=raspberrypi.org header.i=@raspberrypi.org header.b="nIRaegXK";
	dkim=pass (2048-bit key) header.d=raspberrypi.org header.i=@raspberrypi.org header.b="SuMFst1G"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727506AbfLIJQn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Dec 2019 04:16:43 -0500
Received: from mx08-00252a01.pphosted.com ([91.207.212.211]:49732 "EHLO
        mx08-00252a01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727496AbfLIJQm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Dec 2019 04:16:42 -0500
Received: from pps.filterd (m0102629.ppops.net [127.0.0.1])
        by mx08-00252a01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id xB99FEFh021367
        for <linux-kernel@vger.kernel.org>; Mon, 9 Dec 2019 09:16:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=raspberrypi.org; h=subject : to :
 cc : references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=pp;
 bh=mYEfhxjM0ILb+XMlHOtp9XHaBPVEI+/6QQqocgNXGdY=;
 b=nIRaegXKspiKE88HxNH6WjH7FyQNO5dMclhW890Uu2Fdq29E7bj8StIEi3DIiLDpD5Tt
 woBdm74F/5iAx90vefct5/fTyXpfgeTkevSleiiFaEjhwa0ZYrm8fvdYIrsMzpUq+mH0
 ELbzSFy9yrBQ4PbhZpAMiUzVsUzH6WjYy1WTDwbMP8o144d1ZtWAxqy3Tk0VPIQlScaC
 AjhScw409wDtubAiG9otQOfwCsqUgFXY27h13RIYhHUErGtT+kJ2+5KD3r2I0IOe0kFd
 G/tEXbDtsONuRzRnOqZnfZ4Jzqxa4ezZmUsczCBH9Rd+D6pY2OuZQXztnpULZrn7JGlt Dg== 
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com [209.85.128.70])
        by mx08-00252a01.pphosted.com with ESMTP id 2wr1er0vff-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=OK)
        for <linux-kernel@vger.kernel.org>; Mon, 09 Dec 2019 09:16:39 +0000
Received: by mail-wm1-f70.google.com with SMTP id y125so6862285wmg.1
        for <linux-kernel@vger.kernel.org>; Mon, 09 Dec 2019 01:16:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=raspberrypi.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=mYEfhxjM0ILb+XMlHOtp9XHaBPVEI+/6QQqocgNXGdY=;
        b=SuMFst1GNtlvgI4cGzuoakXgAu2yerkgS/GDEcxL7qi9KS61f4biV8Fp04WzdqOFvn
         j1Gp7UyQPmGUKIx4MxpdKsGM24SzZGWzt/fIRXi8bPyMFBERrKD4MBhBhYMoo8ZXUIxP
         P48gvIosiJqetY/6b62Qk027EewfB7LmrwKB2YskMOKcQEClBnyig6OPlKOUeXTP095S
         EbgVNQobXZjDI8CK0EhfTfs03R7Fzsd0/Uh0xNVlFtrxShdzlqfsT/p7ZEA7VFEGhgFc
         R+Iqq3a32SCC7tlondsDN8+BEzTPt30nffEsF+4JSL4340+SFl0EpRmqR4Zs17A5lGt7
         aYsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=mYEfhxjM0ILb+XMlHOtp9XHaBPVEI+/6QQqocgNXGdY=;
        b=F1vYTkCU+svXygNYDbzt9DNHIbgnmaSsvS7d13dw1xsCbI2uWFVeHgJgXE5k6F7mri
         bOpzjuA/b+IOefeHvOxck6BZctv5UKpDlEgBrbEe1Hu78Z3DMfOyL+DQNGImv2CGeH+r
         2ivJlNWL6nG3oVm53b/E9JMan9qbfpMmlwAlPDfhjrVJoYoYbl48ZddldouXsYsStTYa
         ANter6K9xNvYP1X79SxnRIeU3iMkqLRavo7/jlpOEOJUk9etDO8Z8m3KVDJPd1Za1AHl
         EJc0TC6VMqQuLqG+MpqnyiQ/eRn77ce5KypXnorYoRSDNq5KL646m6hAG57c3wXHY9qw
         d58g==
X-Gm-Message-State: APjAAAXK+rMUPq6efVDSt9JTAq06REVB1LTM22eKH6xIA1pZ8idVUoeK
        S1xiytT8g/94znFbUIhF6LZTdGqw+YgsJl4BbXBw++J5hidxfRbEJop/Q8OhiY87ToBaWPQfUhr
        7IWF7f3GYFcClbYKgC9a272I+
X-Received: by 2002:adf:d4ca:: with SMTP id w10mr845429wrk.53.1575882998149;
        Mon, 09 Dec 2019 01:16:38 -0800 (PST)
X-Google-Smtp-Source: APXvYqzT3Io5pOspq+kl6pPKQBqKVgBf9LVLOJQm7nVHNRzkVmlSJL3zQmrWoRTiXlnHeBQS8aQY4w==
X-Received: by 2002:adf:d4ca:: with SMTP id w10mr845391wrk.53.1575882997834;
        Mon, 09 Dec 2019 01:16:37 -0800 (PST)
Received: from ?IPv6:2a00:1098:3142:14:340b:2c9a:9ebb:aeea? ([2a00:1098:3142:14:340b:2c9a:9ebb:aeea])
        by smtp.gmail.com with ESMTPSA id f1sm12909270wml.11.2019.12.09.01.16.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 09 Dec 2019 01:16:36 -0800 (PST)
Subject: Re: [PATCH] ARM: dts: bcm2711: fix soc's node dma-ranges
To:     Florian Fainelli <f.fainelli@gmail.com>,
        Nicolas Saenz Julienne <nsaenzjulienne@suse.de>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Eric Anholt <eric@anholt.net>, Stefan Wahren <wahrenst@gmx.net>
Cc:     mbrugger@suse.com, devicetree@vger.kernel.org,
        bcm-kernel-feedback-list@broadcom.com,
        linux-rpi-kernel@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20191204125633.27696-1-nsaenzjulienne@suse.de>
 <711470d3-e683-69d4-8f4e-791a76faab29@gmail.com>
 <e72de603-2ad9-5a3b-109e-8ee14bf3293c@raspberrypi.org>
 <b778e086-378d-9271-6370-7fd4e60ae250@gmail.com>
From:   Phil Elwell <phil@raspberrypi.org>
Message-ID: <c085e99f-c1b3-1729-0170-fa17a1aea995@raspberrypi.org>
Date:   Mon, 9 Dec 2019 09:16:35 +0000
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:68.0) Gecko/20100101
 Thunderbird/68.3.0
MIME-Version: 1.0
In-Reply-To: <b778e086-378d-9271-6370-7fd4e60ae250@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.95,18.0.572
 definitions=2019-12-09_01:2019-12-09,2019-12-08 signatures=0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 06/12/2019 18:13, Florian Fainelli wrote:
> On 12/6/19 2:16 AM, Phil Elwell wrote:
>> Hi Nicolas,
>>
>> On 06/12/2019 00:08, Florian Fainelli wrote:
>>> On 12/4/19 4:56 AM, Nicolas Saenz Julienne wrote:
>>>> Raspberry Pi's firmware has a feature to select how much memory to
>>>> reserve for its GPU called 'gpu_mem'. The possible values go from 16MB
>>>> to 944MB, with a default of 64MB. This memory resides in the topmost
>>>> part of the lower 1GB memory area and grows bigger expanding towards the
>>>> begging of memory.
>>>>
>>>> It turns out that with low 'gpu_mem' values (16MB and 32MB) the size of
>>>> the memory available to the system in the lower 1GB area can outgrow the
>>>> interconnect's dma-range as its size was selected based on the maximum
>>>> system memory available given the default gpu_mem configuration. This
>>>> makes that memory slice unavailable for DMA. And may cause nasty kernel
>>>> warnings if CMA happens to include it.
>>>>
>>>> Change soc's dma-ranges to really reflect it's HW limitation, which is
>>>> being able to only DMA to the lower 1GB area.
>>>>
>>>> Fixes: 7dbe8c62ceeb ("ARM: dts: Add minimal Raspberry Pi 4 support")
>>>> Signed-off-by: Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
>>>> ---
>>>>
>>>> NOTE: I'd appreciate if someone from the RPi foundation commented on
>>>> this as it's something that I'll propose to be backported to their tree.
>>
>> The 0x3c000000 size was a mistake that arose from c0000000 + 3c000000 =
>> fc000000, but that is mixing apples and oranges (actually DMA addresses
>> and host physical addresses). Please correct it as you are proposing.
> 
> Do you want to add an Acked-by or Reviewed-by tag to make this statement
> official?

Here you go:

Reviewed-by: Phil Elwell <phil@raspberrypi.org>
