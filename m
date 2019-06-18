Return-Path: <SRS0=h0iA=UR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F7DAC31E51
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Jun 2019 07:30:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7309820823
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Jun 2019 07:30:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729040AbfFRHaA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Jun 2019 03:30:00 -0400
Received: from ns.iliad.fr ([212.27.33.1]:44094 "EHLO ns.iliad.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725870AbfFRH37 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Jun 2019 03:29:59 -0400
Received: from ns.iliad.fr (localhost [127.0.0.1])
        by ns.iliad.fr (Postfix) with ESMTP id 0410020514;
        Tue, 18 Jun 2019 09:29:57 +0200 (CEST)
Received: from [192.168.108.49] (freebox.vlq16.iliad.fr [213.36.7.13])
        by ns.iliad.fr (Postfix) with ESMTP id E080821961;
        Tue, 18 Jun 2019 09:29:56 +0200 (CEST)
Subject: Re: [PATCH v1] scsi: Don't select SCSI_PROC_FS by default
To:     Finn Thain <fthain@telegraphics.com.au>,
        Douglas Gilbert <dgilbert@interlog.com>
Cc:     Bart Van Assche <bvanassche@acm.org>,
        James Bottomley <jejb@linux.ibm.com>,
        Martin Petersen <martin.petersen@oracle.com>,
        SCSI <linux-scsi@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Christoph Hellwig <hch@lst.de>
References: <2de15293-b9be-4d41-bc67-a69417f27f7a@free.fr>
 <621306ee-7ab6-9cd2-e934-94b3d6d731fc@acm.org>
 <fb2d2e74-6725-4bf2-cf6c-63c0a2a10f4f@interlog.com>
 <alpine.LNX.2.21.1906181107240.287@nippy.intranet>
From:   Marc Gonzalez <marc.w.gonzalez@free.fr>
Message-ID: <017cf3cf-ecd8-19c2-3bbd-7e7c28042c3c@free.fr>
Date:   Tue, 18 Jun 2019 09:29:56 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <alpine.LNX.2.21.1906181107240.287@nippy.intranet>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Virus-Scanned: ClamAV using ClamSMTP ; ns.iliad.fr ; Tue Jun 18 09:29:57 2019 +0200 (CEST)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 18/06/2019 03:08, Finn Thain wrote:

> On Mon, 17 Jun 2019, Douglas Gilbert wrote:
> 
>> On 2019-06-17 5:11 p.m., Bart Van Assche wrote:
>>
>>> On 6/12/19 6:59 AM, Marc Gonzalez wrote:
>>>
>>>> According to the option's help message, SCSI_PROC_FS has been
>>>> superseded for ~15 years. Don't select it by default anymore.
>>>>
>>>> Signed-off-by: Marc Gonzalez <marc.w.gonzalez@free.fr>
>>>> ---
>>>>   drivers/scsi/Kconfig | 3 ---
>>>>   1 file changed, 3 deletions(-)
>>>>
>>>> diff --git a/drivers/scsi/Kconfig b/drivers/scsi/Kconfig
>>>> index 73bce9b6d037..8c95e9ad6470 100644
>>>> --- a/drivers/scsi/Kconfig
>>>> +++ b/drivers/scsi/Kconfig
>>>> @@ -54,14 +54,11 @@ config SCSI_NETLINK
>>>>   config SCSI_PROC_FS
>>>>       bool "legacy /proc/scsi/ support"
>>>>       depends on SCSI && PROC_FS
>>>> -    default y
>>>>       ---help---
>>>>         This option enables support for the various files in
>>>>         /proc/scsi.  In Linux 2.6 this has been superseded by
>>>>         files in sysfs but many legacy applications rely on this.
>>>> -      If unsure say Y.
>>>> -
>>>>   comment "SCSI support type (disk, tape, CD-ROM)"
>>>>       depends on SCSI
>>>
>>> Hi Doug,
>>>
>>> If I run grep "/proc/scsi" over the sg3_utils source code then grep reports
>>> 38 matches for that string. Does sg3_utils break with SCSI_PROC_FS=n?
>>
>> First, the sg driver. If placing
>> #undef CONFIG_SCSI_PROC_FS
>>
>> prior to the includes in sg.c is a valid way to test that then the
>> answer is no. Ah, but you are talking about sg3_utils .
>>
>> Or are you? For sg3_utils:
>>
>> $ find . -name '*.c' -exec grep "/proc/scsi" {} \; -print
>> static const char * proc_allow_dio = "/proc/scsi/sg/allow_dio";
>> ./src/sg_read.c
>> static const char * proc_allow_dio = "/proc/scsi/sg/allow_dio";
>> ./src/sgp_dd.c
>> static const char * proc_allow_dio = "/proc/scsi/sg/allow_dio";
>> ./src/sgm_dd.c
>> static const char * proc_allow_dio = "/proc/scsi/sg/allow_dio";
>> ./src/sg_dd.c
>>                 "'echo 1 > /proc/scsi/sg/allow_dio'\n", q_len, dirio_count);
>> ./testing/sg_tst_bidi.c
>> static const char * proc_allow_dio = "/proc/scsi/sg/allow_dio";
>> ./examples/sgq_dd.c
>>
>>
>> That is 6 (not 38) by my count. Those 6 are all for direct IO
>> (see below) which is off by default. I suspect old scanning
>> utilities like sg_scan and sg_map might also use /proc/scsi/* .
>> That is one reason why I wrote lsscsi. However I can't force folks
>> to use lsscsi. As a related example, I still get bug reports for
>> sginfo which I inherited from Eric Youngdale.
>>
>> If I was asked to debug a problem with the sg driver in a
>> system without CONFIG_SCSI_PROC_FS defined, I would decline.
>>
>> The absence of /proc/scsi/sg/debug would be my issue. Can this
>> be set up to do the same thing:
>>     cat /sys/class/scsi_generic/debug
>>   Is that breaking any sysfs rules?
>>
>>
>> Also folks who rely on this to work:
>>    cat /proc/scsi/sg/devices
>> 0	0	0	0	0	1	255	0	1
>> 0	0	0	1	0	1	255	0	1
>> 0	0	0	2	0	1	255	0	1
>>
>> would be disappointed. Further I note that setting allow_dio via
>> /proc/scsi/sg/allow_dio can also be done via /sys/module/sg/allow_dio .
>> So that would be an interface breakage, but with an alternative.
> 
> You can grep for /proc/scsi/ across all Debian packages:
> https://codesearch.debian.net/
> 
> This reveals that /proc/scsi/sg/ appears in smartmontools and other 
> packages, for example.

Hello everyone,

Please note that I am _in no way_ suggesting that we remove any code.

I just think it might be time to stop forcing CONFIG_SCSI_PROC_FS into
every config, and instead require one to explicitly request the aging
feature (which makes CONFIG_SCSI_PROC_FS show up in a defconfig).

Maybe we could add CONFIG_SCSI_PROC_FS to arch/x86/configs/foo ?
(For which foo? In a separate patch or squashed with this one?)

Regards.
