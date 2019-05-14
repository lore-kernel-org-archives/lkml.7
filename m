Return-Path: <SRS0=uOpN=TO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,UNPARSEABLE_RELAY autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15326C04AB4
	for <linux-kernel@archiver.kernel.org>; Tue, 14 May 2019 10:15:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D87D22147A
	for <linux-kernel@archiver.kernel.org>; Tue, 14 May 2019 10:15:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726830AbfENKPA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 May 2019 06:15:00 -0400
Received: from bhuna.collabora.co.uk ([46.235.227.227]:50834 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726659AbfENKOh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 May 2019 06:14:37 -0400
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: andrzej.p)
        with ESMTPSA id 2338D283123
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
 <7ec57c29-d1ab-dc4c-755d-a6009b9132b5@collabora.com>
 <CALAqxLUgnTB7aZ4edXCaG8SJsJzfY1_yNEPc6Losssw5Xy9-XA@mail.gmail.com>
From:   Andrzej Pietrasiewicz <andrzej.p@collabora.com>
Message-ID: <36620156-d119-b1b2-989e-0c13b783296e@collabora.com>
Date:   Tue, 14 May 2019 12:14:32 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <CALAqxLUgnTB7aZ4edXCaG8SJsJzfY1_yNEPc6Losssw5Xy9-XA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

W dniu 13.05.2019 o 20:09, John Stultz pisze:
> On Mon, May 13, 2019 at 7:08 AM Andrzej Pietrasiewicz
> <andrzej.p@collabora.com> wrote:

<snip>

>>
>> Do you get "functionfs read size 512 > requested size 24, splitting
>> request into multiple reads" message when problems happen?
> 
> Unfortunately no.

Actually that's a fortunate outcome :)

> 
>> Is there anything in the kernel log?
> 
> Nope. Just the transfers stall/hang and further attempts at adb
> connections fail until the USB cable is unplugged and replugged.
> 

<snip>

> 
>> Is there a way to try your adb without building and running the
>> whole Android?
> 
> Maybe? I have heard of folks doing it in the past, though I don't
> really know a quick path to get there.
> 
> Is there anything else I can try for you?

Have you tried compiling FunctionFS with debugging enabled?
You do so bu uncommenting:

/* #define DEBUG */
/* #define VERBOSE_DEBUG */

at the beginning of drivers/usb/gadget/function/f_fs.c

Is there anything suspicious in the kernel log when you run it then?

Remote debugging through this mailing list will incur enormous
round trip time ;) The most valuable help would be helping in
reproducing the problem you encounter.

One question that comes to my mind is this: Does the USB transmission
stall (e.g. endpoint stall) or not? In other words, is adb connection
broken because USB stops transmitting anything, or because the
data is transmitted but its integrity is broken during transmission
and that causes adb/adbd confusion which results in stopping their
operation? Does anything keep happening on FunctionFS when adb
connection is broken?

Andrzej
