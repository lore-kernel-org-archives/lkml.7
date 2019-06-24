Return-Path: <SRS0=hO5d=UX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4A504C43613
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Jun 2019 17:08:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1FAEA20657
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Jun 2019 17:08:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732253AbfFXRI4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Jun 2019 13:08:56 -0400
Received: from sobre.alvarezp.com ([173.230.155.94]:36230 "EHLO
        sobre.alvarezp.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729008AbfFXRI4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jun 2019 13:08:56 -0400
Received: from [192.168.15.4] (187-177-154-156.dynamic.axtel.net [187.177.154.156])
        by sobre.alvarezp.com (Postfix) with ESMTPSA id 8D9F221CBC;
        Mon, 24 Jun 2019 12:08:54 -0500 (CDT)
From:   Octavio Alvarez <octallk1@alvarezp.org>
Subject: Re: PROBLEM: Marvell 88E8040 (sky2) fails after hibernation
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>, x86@kernel.org,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Marc Zyngier <marc.zyngier@arm.com>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        "Steven Rostedt (VMware)" <rostedt@goodmis.org>,
        Jiang Biao <jiang.biao2@zte.com.cn>,
        Yi Wang <wang.yi59@zte.com.cn>,
        Dou Liyang <douly.fnst@cn.fujitsu.com>,
        Nicolai Stange <nstange@suse.de>,
        Mirko Lindner <mlindner@marvell.com>,
        Stephen Hemminger <stephen@networkplumber.org>
References: <aba1c363-92de-66d7-4aac-b555f398e70a@alvarezp.org>
 <2cf2f745-0e29-13a7-6364-0a981dae758c@alvarezp.org>
 <alpine.DEB.2.21.1906132229540.1791@nanos.tec.linutronix.de>
 <95539fd9-ffdb-b91c-935f-7fd54d048fdf@alvarezp.org>
 <alpine.DEB.2.21.1906221523340.5503@nanos.tec.linutronix.de>
 <alpine.DEB.2.21.1906231448540.32342@nanos.tec.linutronix.de>
Message-ID: <098de4c3-5f71-f84d-8b49-d2f43e18ed91@alvarezp.org>
Date:   Mon, 24 Jun 2019 12:08:52 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.0
MIME-Version: 1.0
In-Reply-To: <alpine.DEB.2.21.1906231448540.32342@nanos.tec.linutronix.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: es-MX
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/23/19 7:54 AM, Thomas Gleixner wrote:
>>> I will keep trying 4.14, unless you say otherwise.
>>
>> It would be interesting though I don't expect too much data.
>>
>> So all of the above use PCI/MSI. That's at least a data point. I need to
>> stare into that driver again to figure out why this might make a
>> difference, but right now I'm lost.
> 
> One other data point you could provide please:
> 
>   Load the driver on Linus master with the following module parameter:
> 
>     disable_msi=1
> 
> That switches to INTx usage. Does the machine resume proper with that?

Hi, Thomas,

I did two tests:

If I boot with sky2.disable_msi=1 on the kernel cmdline then the problem 
goes away (when back from hibernation, the NIC works OK).

If I boot regularly (disable_msi not set) and then do modprobe -r sky2; 
modprobe sky2 disable_msi=1, the problem stays (when back from 
hibernation, the NIC does not work).

Tested on master (5.2-rc6).

Thanks,
Octavio.
