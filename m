Return-Path: <SRS0=qq9d=V6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3C2D8C32750
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Aug 2019 19:59:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0495D2087E
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Aug 2019 19:59:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406890AbfHBT7J (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 2 Aug 2019 15:59:09 -0400
Received: from mx3.molgen.mpg.de ([141.14.17.11]:44747 "EHLO mx1.molgen.mpg.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2406868AbfHBT7I (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Aug 2019 15:59:08 -0400
Received: from [10.0.101.109] (unknown [62.214.191.65])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: pmenzel)
        by mx.molgen.mpg.de (Postfix) with ESMTPSA id 90CDF201A3C39;
        Fri,  2 Aug 2019 21:59:06 +0200 (CEST)
Subject: Re: Device to write to all (serial) consoles
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-serial@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Donald Buczek <buczek@molgen.mpg.de>
References: <32c2d26f-ec4a-b9a6-b42c-07b27f99ea28@molgen.mpg.de>
 <20190802160243.GA15484@kroah.com>
From:   Paul Menzel <pmenzel@molgen.mpg.de>
Message-ID: <cab1fe06-0dc7-e7c1-50ac-cc01773c5ef5@molgen.mpg.de>
Date:   Fri, 2 Aug 2019 21:59:06 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190802160243.GA15484@kroah.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Dear Greg,


On 02.08.19 18:02, Greg Kroah-Hartman wrote:
> On Fri, Aug 02, 2019 at 03:23:08PM +0200, Paul Menzel wrote:

>> On a lot of devices, like servers, you have more than one serial console,
>> and you do not always know, how they are numbered. Therefore, we start a
>> console on ttyS0 and ttyS1.
>>
>> In user space, we also would like to write to both consoles to not worry
>> about the numbering. Writing to `/dev/console` only write to the active
>> console.
> 
> So the same data to multiple console devices with just one userspace
> call?  Why?

Because the cable is always connected to the port on the back side, and 
sometimes the port in the front has ID 0, and the one in the back 1, and 
other times vice versa. We do not want to track that, and it would be 
convenient to just write to both ports.

>>      $ more /proc/consoles # I think
>>      tty0                 -WU (EC p  )    4:1
>>      ttyS0                -W- (E  p a)    4:65
>>      ttyS1                -W- (E  p a)    4:65
>>
>> Does a device exist, or can a device be configured so you can write to
>> all (serial) consoles from user space?
> 
> With one syscall, not that I know of, sorry.

Can such a device be created with udev or so?


Kind regards,

Paul
