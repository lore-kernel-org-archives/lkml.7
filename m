Return-Path: <SRS0=4ODY=VF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0615C606AF
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Jul 2019 13:02:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CAE4E2064B
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Jul 2019 13:02:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731183AbfGHNCk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Jul 2019 09:02:40 -0400
Received: from smtp.infotech.no ([82.134.31.41]:49530 "EHLO smtp.infotech.no"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728242AbfGHNCk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Jul 2019 09:02:40 -0400
Received: from localhost (localhost [127.0.0.1])
        by smtp.infotech.no (Postfix) with ESMTP id B2ADC20423F;
        Mon,  8 Jul 2019 15:02:37 +0200 (CEST)
X-Virus-Scanned: by amavisd-new-2.6.6 (20110518) (Debian) at infotech.no
Received: from smtp.infotech.no ([127.0.0.1])
        by localhost (smtp.infotech.no [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id 7Hwv6m74jWwG; Mon,  8 Jul 2019 15:02:28 +0200 (CEST)
Received: from [192.168.48.23] (host-23-251-188-50.dyn.295.ca [23.251.188.50])
        by smtp.infotech.no (Postfix) with ESMTPA id C280620416A;
        Mon,  8 Jul 2019 15:02:26 +0200 (CEST)
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
 <e2469890-e0ae-fb79-4aa9-125cdaeedb2b@interlog.com>
 <284c3ecc-b3a8-eeec-92d5-5eda1f20f691@suse.de>
From:   Douglas Gilbert <dgilbert@interlog.com>
Message-ID: <5155c7bd-f339-33bb-1a84-18ea75963db2@interlog.com>
Date:   Mon, 8 Jul 2019 09:02:23 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <284c3ecc-b3a8-eeec-92d5-5eda1f20f691@suse.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-CA
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2019-07-08 2:01 a.m., Hannes Reinecke wrote:
> On 7/5/19 7:53 PM, Douglas Gilbert wrote:
>> On 2019-07-05 3:22 a.m., Hannes Reinecke wrote:
> [ .. ]
>>> As mentioned, rescan-scsi-bus.sh is keeping references to /proc/scsi as
>>> a fall back only, as it's meant to work kernel independent. Per default
>>> it'll be using /sys, and will happily work without /proc/scsi.
>>>
>>> So it's really only /proc/scsi/sg which carries some meaningful
>>> information; maybe we should move/copy it to somewhere else.
>>>
>>> I personally like getting rid of /proc/scsi.
>>
>> /proc/scsi/device_info doesn't seem to be in sysfs.
>>
>> Could the contents of /proc/scsi/sg/* be placed in
>> /sys/class/scsi_generic/* ? Currently that directory only has symlinks
>> to the sg devices.
>>
> The sg parameters are already available in /sys/module/sg/parameters;
> so from that perspective I feel we're good.

# ls /sys/module/sg/parameters/
allow_dio  def_reserved_size  scatter_elem_sz

# ls /proc/scsi/sg/
allow_dio  debug  def_reserved_size  device_hdr  devices  device_strs
red_debug  version

So that doesn't work, what are in 'parameters' are passed in at
module/driver initialization. Back to my original question: Could the
contents of /proc/scsi/sg/* be placed in /sys/class/scsi_generic/* ?

> Problem is /proc/scsi/device_info, for which we currently don't have any
> other location to store it at.
> Hmm.

Doug Gilbert

