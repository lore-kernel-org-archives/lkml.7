Return-Path: <SRS0=fBTF=VC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7F42DC46499
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Jul 2019 17:53:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6455C20989
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Jul 2019 17:53:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727369AbfGERx1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 5 Jul 2019 13:53:27 -0400
Received: from smtp.infotech.no ([82.134.31.41]:56627 "EHLO smtp.infotech.no"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726743AbfGERx1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Jul 2019 13:53:27 -0400
Received: from localhost (localhost [127.0.0.1])
        by smtp.infotech.no (Postfix) with ESMTP id E4702204199;
        Fri,  5 Jul 2019 19:53:23 +0200 (CEST)
X-Virus-Scanned: by amavisd-new-2.6.6 (20110518) (Debian) at infotech.no
Received: from smtp.infotech.no ([127.0.0.1])
        by localhost (smtp.infotech.no [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id ISHY-xOxtrmM; Fri,  5 Jul 2019 19:53:17 +0200 (CEST)
Received: from [192.168.48.23] (host-23-251-188-50.dyn.295.ca [23.251.188.50])
        by smtp.infotech.no (Postfix) with ESMTPA id 6983E204145;
        Fri,  5 Jul 2019 19:53:15 +0200 (CEST)
Reply-To: dgilbert@interlog.com
Subject: Re: [PATCH v1] scsi: Don't select SCSI_PROC_FS by default
To:     Hannes Reinecke <hare@suse.de>,
        "Elliott, Robert (Servers)" <elliott@hpe.com>,
        Bart Van Assche <bvanassche@acm.org>,
        Marc Gonzalez <marc.w.gonzalez@free.fr>,
        James Bottomley <jejb@linux.ibm.com>,
        Martin Petersen <martin.petersen@oracle.com>
Cc:     SCSI <linux-scsi@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Christoph Hellwig <hch@lst.de>
References: <2de15293-b9be-4d41-bc67-a69417f27f7a@free.fr>
 <621306ee-7ab6-9cd2-e934-94b3d6d731fc@acm.org>
 <fb2d2e74-6725-4bf2-cf6c-63c0a2a10f4f@interlog.com>
 <da579578-349e-1320-0867-14fde659733e@acm.org>
 <AT5PR8401MB11695CC7286B2D2F98FB9EADABEA0@AT5PR8401MB1169.NAMPRD84.PROD.OUTLOOK.COM>
 <1ad3e7ba-008d-31ad-89a0-b118b36e14e2@suse.de>
From:   Douglas Gilbert <dgilbert@interlog.com>
Message-ID: <e2469890-e0ae-fb79-4aa9-125cdaeedb2b@interlog.com>
Date:   Fri, 5 Jul 2019 13:53:12 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <1ad3e7ba-008d-31ad-89a0-b118b36e14e2@suse.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-CA
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2019-07-05 3:22 a.m., Hannes Reinecke wrote:
> On 6/18/19 7:43 PM, Elliott, Robert (Servers) wrote:
>>
>>
>>> -----Original Message-----
>>> From: linux-kernel-owner@vger.kernel.org [mailto:linux-kernel-owner@vger.kernel.org] On Behalf Of Bart
>>> Van Assche
>>> Sent: Monday, June 17, 2019 10:28 PM
>>> To: dgilbert@interlog.com; Marc Gonzalez <marc.w.gonzalez@free.fr>; James Bottomley
>>> <jejb@linux.ibm.com>; Martin Petersen <martin.petersen@oracle.com>
>>> Cc: SCSI <linux-scsi@vger.kernel.org>; LKML <linux-kernel@vger.kernel.org>; Christoph Hellwig
>>> <hch@lst.de>
>>> Subject: Re: [PATCH v1] scsi: Don't select SCSI_PROC_FS by default
>>>
>>> On 6/17/19 5:35 PM, Douglas Gilbert wrote:
>>>> For sg3_utils:
>>>>
>>>> $ find . -name '*.c' -exec grep "/proc/scsi" {} \; -print
>>>> static const char * proc_allow_dio = "/proc/scsi/sg/allow_dio";
>>>> ./src/sg_read.c
>>>> static const char * proc_allow_dio = "/proc/scsi/sg/allow_dio";
>>>> ./src/sgp_dd.c
>>>> static const char * proc_allow_dio = "/proc/scsi/sg/allow_dio";
>>>> ./src/sgm_dd.c
>>>> static const char * proc_allow_dio = "/proc/scsi/sg/allow_dio";
>>>> ./src/sg_dd.c
>>>>                   "'echo 1 > /proc/scsi/sg/allow_dio'\n", q_len,
>>>> dirio_count);
>>>> ./testing/sg_tst_bidi.c
>>>> static const char * proc_allow_dio = "/proc/scsi/sg/allow_dio";
>>>> ./examples/sgq_dd.c
>>>>
>>>> That is 6 (not 38) by my count.
>>>
>>> Hi Doug,
>>>
>>> This is the command I ran:
>>>
>>> $ git grep /proc/scsi | wc -l
>>> 38
>>>
>>> I think your query excludes scripts/rescan-scsi-bus.sh.
>>>
>>> Bart.
>>
>> Here's the full list to ensure the discussion doesn't overlook anything:
>>
>> sg3_utils-1.44$ grep -R /proc/scsi .
>> ./src/sg_read.c:static const char * proc_allow_dio = "/proc/scsi/sg/allow_dio";
>> ./src/sgp_dd.c:static const char * proc_allow_dio = "/proc/scsi/sg/allow_dio";
>> ./src/sgm_dd.c:static const char * proc_allow_dio = "/proc/scsi/sg/allow_dio";
>> ./src/sg_dd.c:static const char * proc_allow_dio = "/proc/scsi/sg/allow_dio";
>> ./scripts/rescan-scsi-bus.sh:# Return hosts. /proc/scsi/HOSTADAPTER/? must exist
>> ./scripts/rescan-scsi-bus.sh:  for driverdir in /proc/scsi/*; do
>> ./scripts/rescan-scsi-bus.sh:    driver=${driverdir#/proc/scsi/}
>> ./scripts/rescan-scsi-bus.sh:      name=${hostdir#/proc/scsi/*/}
>> ./scripts/rescan-scsi-bus.sh:# Get /proc/scsi/scsi info for device $host:$channel:$id:$lun
>> ./scripts/rescan-scsi-bus.sh:    SCSISTR=$(grep -A "$LN" -e "$grepstr" /proc/scsi/scsi)
>> ./scripts/rescan-scsi-bus.sh:    DRV=`grep 'Attached drivers:' /proc/scsi/scsi 2>/dev/null`
>> ./scripts/rescan-scsi-bus.sh:      echo "scsi report-devs 1" >/proc/scsi/scsi
>> ./scripts/rescan-scsi-bus.sh:      DRV=`grep 'Attached drivers:' /proc/scsi/scsi 2>/dev/null`
>> ./scripts/rescan-scsi-bus.sh:      echo "scsi report-devs 0" >/proc/scsi/scsi
>> ./scripts/rescan-scsi-bus.sh:# Outputs description from /proc/scsi/scsi (unless arg passed)
>> ./scripts/rescan-scsi-bus.sh:        echo "scsi remove-single-device $devnr" > /proc/scsi/scsi
>> ./scripts/rescan-scsi-bus.sh:          echo "scsi add-single-device $devnr" > /proc/scsi/scsi
>> ./scripts/rescan-scsi-bus.sh:      echo "scsi add-single-device $devnr" > /proc/scsi/scsi
>> ./scripts/rescan-scsi-bus.sh:      echo "scsi add-single-device $devnr" > /proc/scsi/scsi
>> ./scripts/rescan-scsi-bus.sh:      echo "scsi add-single-device $host $channel $id $SCAN_WILD_CARD" > /proc/scsi/scsi
>> ./scripts/rescan-scsi-bus.sh:if test ! -d /sys/class/scsi_host/ -a ! -d /proc/scsi/; then
>> ./ChangeLog:    /proc/scsi/sg/allow_dio is '0'
>> ./ChangeLog:  - change sg_debug to call system("cat /proc/scsi/sg/debug");
>> ./suse/sg3_utils.changes:  * Support systems without /proc/scsi
>> ./examples/sgq_dd.c:static const char * proc_allow_dio = "/proc/scsi/sg/allow_dio";
>> ./doc/sg_read.8:If direct IO is selected and /proc/scsi/sg/allow_dio
>> ./doc/sg_read.8:"echo 1 > /proc/scsi/sg/allow_dio". An alternate way to avoid the
>> ./doc/sg_map.8:observing the output of the command: "cat /proc/scsi/scsi".
>> ./doc/sgp_dd.8:at completion. If direct IO is selected and /proc/scsi/sg/allow_dio
>> ./doc/sgp_dd.8:this at completion. If direct IO is selected and /proc/scsi/sg/allow_dio
>> ./doc/sgp_dd.8:mapping to SCSI block devices should be checked with 'cat /proc/scsi/scsi'
>> ./doc/sg_dd.8:notes this at completion. If direct IO is selected and /proc/scsi/sg/allow_dio
>> ./doc/sg_dd.8:this at completion. If direct IO is selected and /proc/scsi/sg/allow_dio
>> ./doc/sg_dd.8:with 'echo 1 > /proc/scsi/sg/allow_dio'.
>> ./doc/sg_dd.8:mapping to SCSI block devices should be checked with 'cat /proc/scsi/scsi',
>>
>>
> As mentioned, rescan-scsi-bus.sh is keeping references to /proc/scsi as
> a fall back only, as it's meant to work kernel independent. Per default
> it'll be using /sys, and will happily work without /proc/scsi.
> 
> So it's really only /proc/scsi/sg which carries some meaningful
> information; maybe we should move/copy it to somewhere else.
> 
> I personally like getting rid of /proc/scsi.

/proc/scsi/device_info doesn't seem to be in sysfs.

Could the contents of /proc/scsi/sg/* be placed in
/sys/class/scsi_generic/* ? Currently that directory only has symlinks
to the sg devices.

Doug Gilbert
