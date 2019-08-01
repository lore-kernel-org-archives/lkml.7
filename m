Return-Path: <SRS0=wo+8=V5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 29B29C433FF
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Aug 2019 11:26:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 050C6206B8
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Aug 2019 11:26:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730681AbfHAL0p (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 1 Aug 2019 07:26:45 -0400
Received: from smtp.infotech.no ([82.134.31.41]:47686 "EHLO smtp.infotech.no"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725804AbfHAL0p (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Aug 2019 07:26:45 -0400
Received: from localhost (localhost [127.0.0.1])
        by smtp.infotech.no (Postfix) with ESMTP id 028AF204247;
        Thu,  1 Aug 2019 13:26:42 +0200 (CEST)
X-Virus-Scanned: by amavisd-new-2.6.6 (20110518) (Debian) at infotech.no
Received: from smtp.infotech.no ([127.0.0.1])
        by localhost (smtp.infotech.no [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id RyxebIhi31SA; Thu,  1 Aug 2019 13:26:41 +0200 (CEST)
Received: from [82.134.31.183] (unknown [82.134.31.183])
        by smtp.infotech.no (Postfix) with ESMTPA id A5A80204170;
        Thu,  1 Aug 2019 13:26:41 +0200 (CEST)
Reply-To: dgilbert@interlog.com
Subject: Re: [PATCH v2] usb: typec: tcpm: Add NULL check before dereferencing
 config
From:   Douglas Gilbert <dgilbert@interlog.com>
To:     Guenter Roeck <linux@roeck-us.net>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
References: <1563979112-22483-1-git-send-email-linux@roeck-us.net>
 <c9dc11ff-2303-7cce-10a8-9a6a1ef72db3@interlog.com>
Message-ID: <a4bd4df7-a16c-3002-e42c-066406cab3bd@interlog.com>
Date:   Thu, 1 Aug 2019 13:26:41 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <c9dc11ff-2303-7cce-10a8-9a6a1ef72db3@interlog.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-CA
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2019-07-31 6:47 p.m., Douglas Gilbert wrote:
> On 2019-07-24 4:38 p.m., Guenter Roeck wrote:
>> When instantiating tcpm on an NXP OM 13588 board with NXP PTN5110,
>> the following crash is seen when writing into the 'preferred_role'
>> sysfs attribute.
>>
>> Unable to handle kernel NULL pointer dereference at virtual address 00000028
>> pgd = f69149ad
>> [00000028] *pgd=00000000
>> Internal error: Oops: 5 [#1] THUMB2
>> Modules linked in: tcpci tcpm
>> CPU: 0 PID: 1882 Comm: bash Not tainted 5.1.18-sama5-armv7-r2 #4
>> Hardware name: Atmel SAMA5
>> PC is at tcpm_try_role+0x3a/0x4c [tcpm]
>> LR is at tcpm_try_role+0x15/0x4c [tcpm]
>> pc : [<bf8000e2>]    lr : [<bf8000bd>]    psr: 60030033
>> sp : dc1a1e88  ip : c03fb47d  fp : 00000000
>> r10: dc216190  r9 : dc1a1f78  r8 : 00000001
>> r7 : df4ae044  r6 : dd032e90  r5 : dd1ce340  r4 : df4ae054
>> r3 : 00000000  r2 : 00000000  r1 : 00000000  r0 : df4ae044
>> Flags: nZCv  IRQs on  FIQs on  Mode SVC_32  ISA Thumb  Segment none
>> Control: 50c53c7d  Table: 3efec059  DAC: 00000051
>> Process bash (pid: 1882, stack limit = 0x6a6d4aa5)
>> Stack: (0xdc1a1e88 to 0xdc1a2000)
>> 1e80:                   dd05d808 dd1ce340 00000001 00000007 dd1ce340 c03fb4a7
>> 1ea0: 00000007 00000007 dc216180 00000000 00000000 c01e1e03 00000000 00000000
>> 1ec0: c0907008 dee98b40 c01e1d5d c06106c4 00000000 00000000 00000007 c0194e8b
>> 1ee0: 0000000a 00000400 00000000 c01a97db dc22bf00 ffffe000 df4b6a00 df745900
>> 1f00: 00000001 00000001 000000dd c01a9c2f 7aeab3be c0907008 00000000 dc22bf00
>> 1f20: c0907008 00000000 00000000 00000000 00000000 7aeab3be 00000007 dee98b40
>> 1f40: 005dc318 dc1a1f78 00000000 00000000 00000007 c01969f7 0000000a c01a20cb
>> 1f60: dee98b40 c0907008 dee98b40 005dc318 00000000 c0196b9b 00000000 00000000
>> 1f80: dee98b40 7aeab3be 00000074 005dc318 b6f3bdb0 00000004 c0101224 dc1a0000
>> 1fa0: 00000004 c0101001 00000074 005dc318 00000001 005dc318 00000007 00000000
>> 1fc0: 00000074 005dc318 b6f3bdb0 00000004 00000007 00000007 00000000 00000000
>> 1fe0: 00000004 be800880 b6ed35b3 b6e5c746 60030030 00000001 00000000 00000000
>> [<bf8000e2>] (tcpm_try_role [tcpm]) from [<c03fb4a7>] 
>> (preferred_role_store+0x2b/0x5c)
>> [<c03fb4a7>] (preferred_role_store) from [<c01e1e03>] 
>> (kernfs_fop_write+0xa7/0x150)
>> [<c01e1e03>] (kernfs_fop_write) from [<c0194e8b>] (__vfs_write+0x1f/0x104)
>> [<c0194e8b>] (__vfs_write) from [<c01969f7>] (vfs_write+0x6b/0x104)
>> [<c01969f7>] (vfs_write) from [<c0196b9b>] (ksys_write+0x43/0x94)
>> [<c0196b9b>] (ksys_write) from [<c0101001>] (ret_fast_syscall+0x1/0x62)
>>
>> Since commit 96232cbc6c994 ("usb: typec: tcpm: support get typec and pd
>> config from device properties"), the 'config' pointer in struct tcpc_dev
>> is optional when registering a Type-C port. Since it is optional, we have
>> to check if it is NULL before dereferencing it.
>>
>> Reported-by: Douglas Gilbert <dgilbert@interlog.com>
>> Cc: Douglas Gilbert <dgilbert@interlog.com>
>> Fixes: 96232cbc6c994 ("usb: typec: tcpm: support get typec and pd config from 
>> device properties")
>> Signed-off-by: Guenter Roeck <linux@roeck-us.net>
>> ---
>> v2: Added missing Cc:. Sorry for the noise.
>>
>> Doug:
>>      I didn't add your Tested-by: since I added more code.
>>      It would be great if you can re-test.
>>
>>   drivers/usb/typec/tcpm/tcpm.c | 7 ++++---
>>   1 file changed, 4 insertions(+), 3 deletions(-)
> 
> Tested-by: Douglas Gilbert <dgilbert@interlog.com>
> 
> 
> This time the Linux system is an Acme Systems Arietta which is a
> Atmel at91sam9g25 based board. Test was run with lk 5.1.19 .
> Without the patch I got the oops described above ("PC is at
> tcpm_try_role+0x40/0x74 [tcpm]") when writing into the 'preferred_role'
> sysfs attribute. With this patch it worked okay.

Today I tried this patch on lk 5.2.5 with the same hardware and it
worked, as expected.

Doug Gilbert

> Can't test the "out of protocol" PD Attention command oops because I
> don't have another OM13588 at the other end (of the USB-C cable) to
> send it. I may be able to solve that problem as well. The OM13588
> seems like a good attack vector ... and NXP continue to improve
> its software (I'm talking about when it runs with a KL27Z which is
> an Arduino clone). It can now read the current capability of an
> E-marked USB-C (M to M) cable. The only 5 Amp cable I have is
> the one that Apple sells (as an _extra_ (cheapskates) to their 87W
> USB-C power adapter (for MacBooks)).

