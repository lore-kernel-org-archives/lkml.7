Return-Path: <SRS0=rNeM=SR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E948AC10F0E
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Apr 2019 10:16:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C29CA2147C
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Apr 2019 10:16:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727208AbfDOKQA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Apr 2019 06:16:00 -0400
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:60016 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725939AbfDOKP7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Apr 2019 06:15:59 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 3356180D;
        Mon, 15 Apr 2019 03:15:59 -0700 (PDT)
Received: from [10.1.196.72] (e119884-lin.cambridge.arm.com [10.1.196.72])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 69AA03F557;
        Mon, 15 Apr 2019 03:15:58 -0700 (PDT)
Subject: Re: [PATCH 2/3] x86/vdso: Allow clock specific mult and shift values
To:     Thomas Gleixner <tglx@linutronix.de>,
        Huw Davies <huw@codeweavers.com>
Cc:     linux kernel <linux-kernel@vger.kernel.org>,
        Andy Lutomirski <luto@kernel.org>
References: <20190411101205.10006-1-huw@codeweavers.com>
 <20190411101205.10006-3-huw@codeweavers.com>
 <alpine.DEB.2.21.1904141229380.4917@nanos.tec.linutronix.de>
 <20190415093042.GA21726@merlot.physics.ox.ac.uk>
 <alpine.DEB.2.21.1904151148160.17231@nanos.tec.linutronix.de>
From:   Vincenzo Frascino <vincenzo.frascino@arm.com>
Message-ID: <82a61daf-f6f9-8be0-2157-e9f9d7ba1cdf@arm.com>
Date:   Mon, 15 Apr 2019 11:15:56 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <alpine.DEB.2.21.1904151148160.17231@nanos.tec.linutronix.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Thomas,

On 15/04/2019 10:51, Thomas Gleixner wrote:
> On Mon, 15 Apr 2019, Huw Davies wrote:
> 
>> On Sun, Apr 14, 2019 at 12:53:32PM +0200, Thomas Gleixner wrote:
>>> So it stays in the same cache line, but as we move the VDSO to generic
>>> code, the mask field needs to stay and this will make basetime[CLOCK_MONOTONIC] 
>>> overlap into the next cache line.
>>
>> Thanks for the great review; this is a good point.
>>
>>> See https://lkml.kernel.org/r/alpine.DEB.2.21.1902231727060.1666@nanos.tec.linutronix.de
>>> for an alternate solution to this problem, which avoids this and just gives
>>> CLOCK_MONOTONIC_RAW a separate storage space alltogether.
>>
>> I can certainly do this for the x86 vdso.  Would that be useful or
>> should I wait for Vincenzo's work on the generic vdso first?
> 
> Depends. If Vincenzo comes along with his new version soon, then you might
> get this for free :)
> 
> Vincenzo, what's the state of your work?
>

I am mostly done with the development, the only thing missing is the integration
of the generic update_vsyscall. After this is complete, I will need to do some
testing and extract the performance numbers.

Considering that I will be on Easter holiday from this Wednesday till the end of
April, I think v6 will be ready around second week of May.

> Thanks,
> 
> 	tglx
> 

-- 
Regards,
Vincenzo
