Return-Path: <SRS0=ag/Q=Z7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B0FECC43603
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Dec 2019 14:41:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7F3E8207FD
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Dec 2019 14:41:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727743AbfLIOlQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Dec 2019 09:41:16 -0500
Received: from mx2.suse.de ([195.135.220.15]:60572 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726687AbfLIOlQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Dec 2019 09:41:16 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 7080AB201;
        Mon,  9 Dec 2019 14:41:13 +0000 (UTC)
Subject: Re: [Xen-devel] [PATCH 2/4] xenbus: limit when state is forced to
 closed
To:     "Durrant, Paul" <pdurrant@amazon.com>,
        =?UTF-8?Q?Roger_Pau_Monn=c3=a9?= <roger.pau@citrix.com>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "xen-devel@lists.xenproject.org" <xen-devel@lists.xenproject.org>,
        Stefano Stabellini <sstabellini@kernel.org>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>
References: <20191205140123.3817-1-pdurrant@amazon.com>
 <20191205140123.3817-3-pdurrant@amazon.com>
 <20191209113926.GS980@Air-de-Roger>
 <b8a138ad-5770-65fa-f368-f7b4063702fa@suse.com>
 <3412e42d13224b6786613e58dc189ebf@EX13D32EUC003.ant.amazon.com>
 <8d66e520-3009-cde1-e24c-26d7476e5873@suse.com>
 <63d653a04207451e9041c89acd04f2a2@EX13D32EUC003.ant.amazon.com>
 <2cd2a27e-2bb8-bd9d-45d8-1710038fb97a@suse.com>
 <c86eadaf008f48aeb4bb7140a80b69e6@EX13D32EUC003.ant.amazon.com>
 <1c4c9b3e-31a5-d8b3-01de-3ad84db6390a@suse.com>
 <380d160eb06c45e5962fe85aedd79ed5@EX13D32EUC003.ant.amazon.com>
From:   =?UTF-8?B?SsO8cmdlbiBHcm/Dnw==?= <jgross@suse.com>
Message-ID: <208da9ea-738d-f4f8-fc0d-71523148deeb@suse.com>
Date:   Mon, 9 Dec 2019 15:41:12 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.1
MIME-Version: 1.0
In-Reply-To: <380d160eb06c45e5962fe85aedd79ed5@EX13D32EUC003.ant.amazon.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 09.12.19 15:23, Durrant, Paul wrote:
>> -----Original Message-----
>> From: Jürgen Groß <jgross@suse.com>
>> Sent: 09 December 2019 14:10
>> To: Durrant, Paul <pdurrant@amazon.com>; Roger Pau Monné
>> <roger.pau@citrix.com>
>> Cc: linux-kernel@vger.kernel.org; xen-devel@lists.xenproject.org; Stefano
>> Stabellini <sstabellini@kernel.org>; Boris Ostrovsky
>> <boris.ostrovsky@oracle.com>
>> Subject: Re: [Xen-devel] [PATCH 2/4] xenbus: limit when state is forced to
>> closed
>>
>> On 09.12.19 15:06, Durrant, Paul wrote:
>>>> -----Original Message-----
>>>> From: Jürgen Groß <jgross@suse.com>
>>>> Sent: 09 December 2019 13:39
>>>> To: Durrant, Paul <pdurrant@amazon.com>; Roger Pau Monné
>>>> <roger.pau@citrix.com>
>>>> Cc: linux-kernel@vger.kernel.org; xen-devel@lists.xenproject.org;
>> Stefano
>>>> Stabellini <sstabellini@kernel.org>; Boris Ostrovsky
>>>> <boris.ostrovsky@oracle.com>
>>>> Subject: Re: [Xen-devel] [PATCH 2/4] xenbus: limit when state is forced
>> to
>>>> closed
>>>>
>>>> On 09.12.19 13:19, Durrant, Paul wrote:
>>>>>> -----Original Message-----
>>>>>> From: Jürgen Groß <jgross@suse.com>
>>>>>> Sent: 09 December 2019 12:09
>>>>>> To: Durrant, Paul <pdurrant@amazon.com>; Roger Pau Monné
>>>>>> <roger.pau@citrix.com>
>>>>>> Cc: linux-kernel@vger.kernel.org; xen-devel@lists.xenproject.org;
>>>> Stefano
>>>>>> Stabellini <sstabellini@kernel.org>; Boris Ostrovsky
>>>>>> <boris.ostrovsky@oracle.com>
>>>>>> Subject: Re: [Xen-devel] [PATCH 2/4] xenbus: limit when state is
>> forced
>>>> to
>>>>>> closed
>>>>>>
>>>>>> On 09.12.19 13:03, Durrant, Paul wrote:
>>>>>>>> -----Original Message-----
>>>>>>>> From: Jürgen Groß <jgross@suse.com>
>>>>>>>> Sent: 09 December 2019 11:55
>>>>>>>> To: Roger Pau Monné <roger.pau@citrix.com>; Durrant, Paul
>>>>>>>> <pdurrant@amazon.com>
>>>>>>>> Cc: linux-kernel@vger.kernel.org; xen-devel@lists.xenproject.org;
>>>>>> Stefano
>>>>>>>> Stabellini <sstabellini@kernel.org>; Boris Ostrovsky
>>>>>>>> <boris.ostrovsky@oracle.com>
>>>>>>>> Subject: Re: [Xen-devel] [PATCH 2/4] xenbus: limit when state is
>>>> forced
>>>>>> to
>>>>>>>> closed
>>>>>>>>
>>>>>>>> On 09.12.19 12:39, Roger Pau Monné wrote:
>>>>>>>>> On Thu, Dec 05, 2019 at 02:01:21PM +0000, Paul Durrant wrote:
>>>>>>>>>> Only force state to closed in the case when the toolstack may
>> need
>>>> to
>>>>>>>>>> clean up. This can be detected by checking whether the state in
>>>>>>>> xenstore
>>>>>>>>>> has been set to closing prior to device removal.
>>>>>>>>>
>>>>>>>>> I'm not sure I see the point of this, I would expect that a
>> failure
>>>> to
>>>>>>>>> probe or the removal of the device would leave the xenbus state as
>>>>>>>>> closed, which is consistent with the actual driver state.
>>>>>>>>>
>>>>>>>>> Can you explain what's the benefit of leaving a device without a
>>>>>>>>> driver in such unknown state?
>>>>>>>>
>>>>>>>> And more concerning: did you check that no frontend/backend is
>>>>>>>> relying on the closed state to be visible without closing having
>> been
>>>>>>>> set before?
>>>>>>>
>>>>>>> Blkfront doesn't seem to mind and I believe the Windows PV drivers
>>>> cope,
>>>>>> but I don't really understand the comment since this patch is
>> actually
>>>>>> removing a case where the backend transitions directly to closed.
>>>>>>
>>>>>> I'm not speaking of blkfront/blkback only, but of net, tpm, scsi,
>>>> pvcall
>>>>>> etc. frontends/backends. After all you are modifying a function
>> common
>>>>>> to all PV driver pairs.
>>>>>>
>>>>>> You are removing a state switc to "closed" in case the state was
>> _not_
>>>>>> "closing" before.
>>>>>
>>>>> Yes, which AFAIK is against the intention of the generic PV protocol
>>>> such that it ever existed anyway.
>>>>
>>>> While this might be the case we should _not_ break any guests
>>>> running now. So this kind of reasoning is dangerous.
>>>>
>>>>>
>>>>>> So any PV driver reacting to "closed" of the other end
>>>>>> in case the previous state might not have been "closing" before is at
>>>>>> risk to misbehave with your patch.
>>>>>
>>>>> Well, they will see nothing now. If the state was not closing, it gets
>>>> left alone, so the frontend shouldn't do anything. The only risk that I
>>>> can see is that some frontend/backend pair needed a direct 4 -> 6
>>>> transition to support 'unbind' before but AFAIK nothing has ever
>> supported
>>>> that, and blk and net crash'n'burn if you try that on upstream as it
>>>> stands. A clean unplug would always set state to 5 first, since that's
>>>> part of the unplug protocol.
>>>>
>>>> That was my question: are you sure all current and previous
>>>> guest frontends and backends are handling unplug this way?
>>>>
>>>> Not "should handle", but "do handle".
>>>
>>> That depends on the toolstack. IIUC the only 'supported' toolstack is
>> xl/libxl, which will set 'state' to 5 and 'online' to 0 to initiate an
>> unplug.
>>
>> I guess libvirt/libxl is doing the same?
>>
> 
> The unplug mechansism is all in libxl AFAICT, so it should be identical.
> 
>> At least at SUSE we still have some customers running xend based
>> Xen installations with recent Linux or Windows guests.
>>
> 
> Is that something the upstream code can/should support though? I'd be surprised if xend is actually doing anything different to libxl since I've been coding the Windows PV drivers to trigger off the combined closing/online transition for as long as I can remember.

I'd rather not have to carry a private patch for new Linux kernel to be
able to run on those hosts.

AFAIK you at Amazon have some quite old Xen installations, too. How are
you handling that (assuming the customer is updating the kernel to a
recent version in his guest)?


Juergen
