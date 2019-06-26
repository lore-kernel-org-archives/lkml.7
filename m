Return-Path: <SRS0=hRvo=UZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3159EC48BD3
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Jun 2019 14:14:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 118F52147A
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Jun 2019 14:14:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727890AbfFZOOb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Jun 2019 10:14:31 -0400
Received: from smtp.infotech.no ([82.134.31.41]:32868 "EHLO smtp.infotech.no"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726484AbfFZOOb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jun 2019 10:14:31 -0400
Received: from localhost (localhost [127.0.0.1])
        by smtp.infotech.no (Postfix) with ESMTP id 70355204192;
        Wed, 26 Jun 2019 16:14:28 +0200 (CEST)
X-Virus-Scanned: by amavisd-new-2.6.6 (20110518) (Debian) at infotech.no
Received: from smtp.infotech.no ([127.0.0.1])
        by localhost (smtp.infotech.no [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id PwazqP0WQn-2; Wed, 26 Jun 2019 16:14:26 +0200 (CEST)
Received: from [192.168.48.23] (host-45-58-224-183.dyn.295.ca [45.58.224.183])
        by smtp.infotech.no (Postfix) with ESMTPA id CFD38204153;
        Wed, 26 Jun 2019 16:14:25 +0200 (CEST)
Reply-To: dgilbert@interlog.com
Subject: Re: [PATCH 0/2] scsi: add support for request batching
To:     Paolo Bonzini <pbonzini@redhat.com>, linux-kernel@vger.kernel.org,
        kvm@vger.kernel.org
Cc:     jejb@linux.ibm.com, martin.petersen@oracle.com,
        linux-scsi@vger.kernel.org, stefanha@redhat.com
References: <20190530112811.3066-1-pbonzini@redhat.com>
 <746ad64a-4047-1597-a0d4-f14f3529cc19@redhat.com>
From:   Douglas Gilbert <dgilbert@interlog.com>
Message-ID: <65e5ad25-a475-989a-ce3d-400a8c90cb61@interlog.com>
Date:   Wed, 26 Jun 2019 10:14:23 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.1
MIME-Version: 1.0
In-Reply-To: <746ad64a-4047-1597-a0d4-f14f3529cc19@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-CA
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2019-06-26 9:51 a.m., Paolo Bonzini wrote:
> On 30/05/19 13:28, Paolo Bonzini wrote:
>> This allows a list of requests to be issued, with the LLD only writing
>> the hardware doorbell when necessary, after the last request was prepared.
>> This is more efficient if we have lists of requests to issue, particularly
>> on virtualized hardware, where writing the doorbell is more expensive than
>> on real hardware.
>>
>> This applies to any HBA, either singlequeue or multiqueue; the second
>> patch implements it for virtio-scsi.
>>
>> Paolo
>>
>> Paolo Bonzini (2):
>>    scsi_host: add support for request batching
>>    virtio_scsi: implement request batching
>>
>>   drivers/scsi/scsi_lib.c    | 37 ++++++++++++++++++++++---
>>   drivers/scsi/virtio_scsi.c | 55 +++++++++++++++++++++++++++-----------
>>   include/scsi/scsi_cmnd.h   |  1 +
>>   include/scsi/scsi_host.h   | 16 +++++++++--
>>   4 files changed, 89 insertions(+), 20 deletions(-)
>>
> 
> 
> Ping?  Are there any more objections?

I have no objections, just a few questions.

To implement this is the scsi_debug driver, a per device queue would
need to be added, correct? Then a 'commit_rqs' call would be expected
at some later point and it would drain that queue and submit each
command. Or is the queue draining ongoing in the LLD and 'commit_rqs'
means: don't return until that queue is empty?

So does that mean in the normal (i.e. non request batching) case
there are two calls to the LLD for each submitted command? Or is
'commit_rqs' optional, a sync-ing type command?

Doug Gilbert


