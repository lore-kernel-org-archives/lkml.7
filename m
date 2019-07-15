Return-Path: <SRS0=zSVa=VM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 245CDC7618F
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Jul 2019 09:01:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EDEC320868
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Jul 2019 09:01:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729511AbfGOJBK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Jul 2019 05:01:10 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:42940 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729257AbfGOJBJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Jul 2019 05:01:09 -0400
Received: from mail-pf1-f197.google.com ([209.85.210.197])
        by youngberry.canonical.com with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
        (Exim 4.76)
        (envelope-from <kai.heng.feng@canonical.com>)
        id 1hmwr4-0006kv-Of
        for linux-kernel@vger.kernel.org; Mon, 15 Jul 2019 09:01:06 +0000
Received: by mail-pf1-f197.google.com with SMTP id 6so9927262pfz.10
        for <linux-kernel@vger.kernel.org>; Mon, 15 Jul 2019 02:01:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=MOsl4AhIsunHwA3k/fkhj25jEpHtngxyDrwZz01koT0=;
        b=trhqK4tV8VbclgSsBg6q//G+Aaj4ZW0Ijsgb/43BEC0074MnYj2hIUj5KWQ0+KOOW7
         0FDMc8lSZT6rGC2hNbbG1tDKbd9PJFl7Wr78C7jztFAGOPOL7Z8PtNHZcCzDgHE0FU7s
         Nn/WsKsIfj5ddHlAspX1xF9v+EELxgonqKRnpdyCtHPSbYLLV3/BX2LoOKJed7bqXe0X
         tSeIi2pbEfPJV1CynXeoPTFXmWhqnXPdzcl9QmaN2TLeai7EaR0T/EgMm+GXYpOOzQM1
         dSqPjPt3gyhrAG4HGCfioVVET5oTQTJW+z7G9nOa6xVCMSyV9Z5x4xoVdj44mFcO4vI2
         OVwg==
X-Gm-Message-State: APjAAAXonMZ83/AcUw0bpuQSO7ActNy33IkQhtHOfwDyQ0QVarfAktmj
        5Ft4HeS32Z+QrJZCOvUbDLY6TjfQ8f9GzFFYf+jssdy9tOlVsuzp9Pr1od5O9UDOJ1hzzzpVzA6
        fbhaZ7iBe/jX76vHaLniodEJXR3lDSXVMCo29+q438w==
X-Received: by 2002:a63:3d8f:: with SMTP id k137mr26092748pga.337.1563181265429;
        Mon, 15 Jul 2019 02:01:05 -0700 (PDT)
X-Google-Smtp-Source: APXvYqw0AEvG35y4C+S8NXLLv1mZ8r7lerqI602RiHBwzppSmKP6ahfLaL+QdL1GtKyDJq0iKsYY4g==
X-Received: by 2002:a63:3d8f:: with SMTP id k137mr26092703pga.337.1563181264969;
        Mon, 15 Jul 2019 02:01:04 -0700 (PDT)
Received: from [10.101.46.105] (61-220-137-37.HINET-IP.hinet.net. [61.220.137.37])
        by smtp.gmail.com with ESMTPSA id k3sm13854510pgo.81.2019.07.15.02.01.02
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 15 Jul 2019 02:01:04 -0700 (PDT)
Content-Type: text/plain;
        charset=utf-8;
        delsp=yes;
        format=flowed
Mime-Version: 1.0 (Mac OS X Mail 12.4 \(3445.104.11\))
Subject: Re: [Intel-wired-lan] [PATCH] e1000e: Make speed detection on
 hotplugging cable more reliable
From:   Kai Heng Feng <kai.heng.feng@canonical.com>
In-Reply-To: <017771d5-f168-493a-46a1-88e513941ba1@molgen.mpg.de>
Date:   Mon, 15 Jul 2019 17:00:58 +0800
Cc:     Jeff Kirsher <jeffrey.t.kirsher@intel.com>, netdev@vger.kernel.org,
        intel-wired-lan@lists.osuosl.org, linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8bit
Message-Id: <F9859C57-4F6D-4685-B4B6-D1D7DCB50D27@canonical.com>
References: <20190715084355.9962-1-kai.heng.feng@canonical.com>
 <017771d5-f168-493a-46a1-88e513941ba1@molgen.mpg.de>
To:     Paul Menzel <pmenzel@molgen.mpg.de>
X-Mailer: Apple Mail (2.3445.104.11)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

at 4:52 PM, Paul Menzel <pmenzel@molgen.mpg.de> wrote:

> Dear Kai-Heng,
>
>
> Thank you for the patch.
>
> On 7/15/19 10:43 AM, Kai-Heng Feng wrote:
>> After hotplugging an 1Gbps ethernet cable with 1Gbps link partner, the
>> MII_BMSR may reports 10Mbps, renders the network rather slow.
>
> s/may reports/may report/
> s/renders/rendering/

Apparently English isn’t my mother tongue ;)

>
>> The issue has much lower fail rate after commit 59653e6497d1 ("e1000e:
>> Make watchdog use delayed work"), which esssentially introduces some
>
> essentially

Ok.

>
>> delay before running the watchdog task.
>>
>> But there's still a chance that the hotplugging event and the queued
>> watchdog task gets run at the same time, then the original issue can be
>> observed once again.
>>
>> So let's use mod_delayed_work() to add a deterministic 1 second delay
>> before running watchdog task, after an interrupt.
>
> I am not clear about the effects for the user. Could you elaborate
> please? Does the link now come up up to one second later?

Yes, the link will be up on a fixed one second later.

The delay varies between 0 to 2 seconds without this patch.

>
>> Signed-off-by: Kai-Heng Feng <kai.heng.feng@canonical.com>
>
> Any bug URL?

If maintainers think it’s necessary then I’ll file one.

Kai-Heng

>
>> ---
>>  drivers/net/ethernet/intel/e1000e/netdev.c | 12 ++++++------
>>  1 file changed, 6 insertions(+), 6 deletions(-)
>
>
> Kind regards,
>
> Paul


