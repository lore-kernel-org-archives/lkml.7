Return-Path: <SRS0=lq4r=TU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 993CBC04AAC
	for <linux-kernel@archiver.kernel.org>; Mon, 20 May 2019 21:53:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7493D216B7
	for <linux-kernel@archiver.kernel.org>; Mon, 20 May 2019 21:53:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726839AbfETVxS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 May 2019 17:53:18 -0400
Received: from smtp.infotech.no ([82.134.31.41]:35591 "EHLO smtp.infotech.no"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725776AbfETVxS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 May 2019 17:53:18 -0400
Received: from localhost (localhost [127.0.0.1])
        by smtp.infotech.no (Postfix) with ESMTP id 17179204237;
        Mon, 20 May 2019 23:53:16 +0200 (CEST)
X-Virus-Scanned: by amavisd-new-2.6.6 (20110518) (Debian) at infotech.no
Received: from smtp.infotech.no ([127.0.0.1])
        by localhost (smtp.infotech.no [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id EHYpAQPNTTZm; Mon, 20 May 2019 23:53:09 +0200 (CEST)
Received: from [192.168.48.23] (host-45-58-224-183.dyn.295.ca [45.58.224.183])
        by smtp.infotech.no (Postfix) with ESMTPA id 25B15204145;
        Mon, 20 May 2019 23:53:08 +0200 (CEST)
Reply-To: dgilbert@interlog.com
Subject: Re: [PATCH] scsi: ses: Fix out-of-bounds memory access in
 ses_enclosure_data_process()
To:     "Martin K. Petersen" <martin.petersen@oracle.com>,
        James Bottomley <jejb@linux.ibm.com>
Cc:     Waiman Long <longman@redhat.com>, linux-scsi@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20190501180535.26718-1-longman@redhat.com>
 <1fd39969-4413-2f11-86b2-729787680efa@redhat.com>
 <1558363938.3742.1.camel@linux.ibm.com>
 <3385cf54-7b6c-3f28-e037-f0d4037368eb@redhat.com>
 <1558367212.3742.10.camel@linux.ibm.com> <yq1zhnh8625.fsf@oracle.com>
From:   Douglas Gilbert <dgilbert@interlog.com>
Message-ID: <c14d427c-1d17-fc8f-672d-d612851abcc1@interlog.com>
Date:   Mon, 20 May 2019 17:53:08 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <yq1zhnh8625.fsf@oracle.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-CA
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2019-05-20 12:05 p.m., Martin K. Petersen wrote:
> 
> James,
> 
>> Please.  What I'm interested in is whether this is simply a bug in the
>> array firmware, in which case the fix is sufficient, or whether
>> there's some problem with the parser, like mismatched expectations
>> over added trailing nulls or something.
> 
> Our support folks have been looking at this for a while. We have seen
> problems with devices from several vendors. To the extent that I gave up
> the idea of blacklisting all of them.
> 
> I am collecting "bad" SES pages from these devices. I have added support
> for RECEIVE DIAGNOSTICS to scsi_debug and added a bunch of deliberately
> broken SES pages so we could debug this

Patches ??

> It appears to be very common for devices to return inconsistent or
> invalid data. So pretty much all of the ses.c parsing needs to have
> sanity checking heuristics added to prevent KASAN hiccups.

And it is not just SES device implementations that were broken. The
relationship between Additional Element Status diagnostic page (dpage)
and the Enclosure Status dpage was under-specified in SES-2 and that
led to the EIIOE field being introduced during the SES-3 revisions.
And the meaning of EIIOE was tweaked several times *** before SES-3 was
standardized. Anyone interested in the adventures of EIIOE can see
the code of sg_ses.c in sg3_utils. The sg_ses utility is many times
more complex than anything else in the sg3_utils package.

And that complexity led me to suspect that the Linux SES driver was
broken. It should be 3 or 4 times larger than it is! It simply doesn't
do enough checking.

So yes Martin, you are on the right track.

Doug Gilbert


BTW the NVME Management Interface folks have decided to use SES-3 for
NVME enclosure management rather than invent their own can of worms :-)

*** For example EIIOE started life as a 1 bit field, but two cases
     wasn't enough, so it became a 2 bit field and now uses all
     four possibilities.


