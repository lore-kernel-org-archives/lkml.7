Return-Path: <SRS0=lMFC=TN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4494AC46470
	for <linux-kernel@archiver.kernel.org>; Mon, 13 May 2019 14:08:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1775620862
	for <linux-kernel@archiver.kernel.org>; Mon, 13 May 2019 14:08:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729513AbfEMOIq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 13 May 2019 10:08:46 -0400
Received: from bhuna.collabora.co.uk ([46.235.227.227]:45350 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727202AbfEMOIp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 May 2019 10:08:45 -0400
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: andrzej.p)
        with ESMTPSA id 9B26A28395B
Subject: Re: [REGRESSION] usb: gadget: f_fs: Allow scatter-gather buffers
To:     John Stultz <john.stultz@linaro.org>
Cc:     Felipe Balbi <balbi@kernel.org>, "Yang, Fei" <fei.yang@intel.com>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Chen Yu <chenyu56@huawei.com>,
        lkml <linux-kernel@vger.kernel.org>,
        Linux USB List <linux-usb@vger.kernel.org>,
        Amit Pundir <amit.pundir@linaro.org>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        "kernel@collabora.com" <kernel@collabora.com>
References: <CALAqxLUMRaNxwTUi9QS7-Cy-Ve4+vteBm8-jW4yzZg_QTJVChA@mail.gmail.com>
 <7caebeb2-ea96-2276-3078-1e53f09ce227@collabora.com>
 <CALAqxLUfJYUtmQDC_aDMxW7KcPUawGoRq-PNUfmzQuNKh97FmQ@mail.gmail.com>
 <CALAqxLVUFfrPVVjR74V3PhhtcCytfp=cUYjo=BcJ14D1fkVXTw@mail.gmail.com>
From:   Andrzej Pietrasiewicz <andrzej.p@collabora.com>
Message-ID: <7ec57c29-d1ab-dc4c-755d-a6009b9132b5@collabora.com>
Date:   Mon, 13 May 2019 16:08:41 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <CALAqxLVUFfrPVVjR74V3PhhtcCytfp=cUYjo=BcJ14D1fkVXTw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi John,

W dniu 09.05.2019 o 23:23, John Stultz pisze:
> On Thu, May 9, 2019 at 11:25 AM John Stultz <john.stultz@linaro.org> wrote:
>>
>> On Thu, May 9, 2019 at 7:02 AM Andrzej Pietrasiewicz
>> <andrzej.p@collabora.com> wrote:
>>>

<snip>

> 
> Ok. Apologies for earlier confusion.
> 
> So the kzalloc/memset fix you sent for f_fs.c does seem to avoid the
> crash on bootup I was seeing w/  HiKey/dwc2 (previously I had only
> tested it on HiKey960/dwc3).
> 
> However with that patch, I still see tranfer problems with adb, unless
> I comment out setting sg_supported in dwc2/gadget.c (in the same
> fashion I have to with HiKey960/dwc3).
> 
> The dwc2 zlp patch doesn't seem to affect things much either way in my
> testing. But maybe I'm just not tripping on that issue yet.
> 
> So yes, the kzalloc/memset patch is a clear improvement, as it avoids
> the bootup crash on dwc2, and seems like it should go in.
> 
> However, there is still the outstanding issue w/  functionfs sg
> support stalling on larger transfers.

Do you get "functionfs read size 512 > requested size 24, splitting
request into multiple reads" message when problems happen?

Is there anything in the kernel log?

I'm unable to reproduce your problems. I thought I was able, but
it was another problem, which is fixed with:

5acb4b970184d189d901192d075997c933b82260
dwc2: gadget: Fix completed transfer size calculation in DDMA

(or you can simply take upstream drivers/usb/dwc2).

Do your problems happen on dwc2 or dwc3?

Is there a way to try your adb without building and running the
whole Android?

Andrzej
