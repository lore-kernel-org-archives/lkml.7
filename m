Return-Path: <SRS0=kpxk=YC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 81A3BC47404
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Oct 2019 13:22:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 64A07206B6
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Oct 2019 13:22:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731317AbfJINWu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 9 Oct 2019 09:22:50 -0400
Received: from mga04.intel.com ([192.55.52.120]:6897 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729883AbfJINWt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Oct 2019 09:22:49 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga104.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 09 Oct 2019 06:22:44 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.67,276,1566889200"; 
   d="scan'208";a="198008090"
Received: from rjwysock-mobl1.ger.corp.intel.com (HELO [10.249.132.152]) ([10.249.132.152])
  by orsmga006.jf.intel.com with ESMTP; 09 Oct 2019 06:22:42 -0700
Subject: Re: System hangs if NVMe/SSD is removed during suspend
To:     Jan Kara <jack@suse.cz>
Cc:     Jens Axboe <axboe@kernel.dk>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>, Tejun Heo <tj@kernel.org>,
        AceLan Kao <acelan.kao@canonical.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org
References: <20191002122136.GD2819@lahna.fi.intel.com>
 <20191003165033.GC3247445@devbig004.ftw2.facebook.com>
 <20191004080340.GB2819@lahna.fi.intel.com> <2367934.HCQFgJ56tP@kreacher>
 <20191004110151.GH2819@lahna.fi.intel.com>
 <99b3ffb8-4205-9795-a48a-09125f5fceec@kernel.dk>
 <20191007100838.GA24366@quack2.suse.cz>
From:   "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>
Organization: Intel Technology Poland Sp. z o. o., KRS 101882, ul. Slowackiego
 173, 80-298 Gdansk
Message-ID: <dd8cf8e0-f3f2-ed99-e7ca-838351fa6c3f@intel.com>
Date:   Wed, 9 Oct 2019 15:22:41 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20191007100838.GA24366@quack2.suse.cz>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/7/2019 12:08 PM, Jan Kara wrote:
> On Fri 04-10-19 07:32:40, Jens Axboe wrote:
>> On 10/4/19 5:01 AM, Mika Westerberg wrote:
>>> On Fri, Oct 04, 2019 at 11:59:26AM +0200, Rafael J. Wysocki wrote:
>>>> On Friday, October 4, 2019 10:03:40 AM CEST Mika Westerberg wrote:
>>>>> On Thu, Oct 03, 2019 at 09:50:33AM -0700, Tejun Heo wrote:
>>>>>> Hello, Mika.
>>>>>>
>>>>>> On Wed, Oct 02, 2019 at 03:21:36PM +0300, Mika Westerberg wrote:
>>>>>>> but from that discussion I don't see more generic solution to be
>>>>>>> implemented.
>>>>>>>
>>>>>>> Any ideas we should fix this properly?
>>>>>> Yeah, the only fix I can think of is not using freezable wq.  It's
>>>>>> just not a good idea and not all that difficult to avoid using.
>>>>> OK, thanks.
>>>>>
>>>>> In that case I will just make a patch that removes WQ_FREEZABLE from
>>>>> bdi_wq and see what people think about it :)
>>>> I guess that depends on why WQ_FREEZABLE was added to it in the first place. :-)
>>>>
>>>> The reason might be to avoid writes to persistent storage after creating an
>>>> image during hibernation, since wqs remain frozen throughout the entire
>>>> hibernation including the image saving phase.
>>> Good point.
>>>
>>>> Arguably, making the wq freezable is kind of a sledgehammer approach to that
>>>> particular issue, but in principle it may prevent data corruption from
>>>> occurring, so be careful there.
>>> I tried to find the commit that introduced the "freezing" and I think it
>>> is this one:
>>>
>>>     03ba3782e8dc writeback: switch to per-bdi threads for flushing data
>>>
>>> Unfortunately from that commit it is not clear (at least to me) why it
>>> calls set_freezable() for the bdi task. It does not look like it has
>>> anything to do with blocking writes to storage while entering
>>> hibernation but I may be mistaken.
>> Wow, a decade ago...
>>
>> Honestly, I don't recall why these were marked freezable, and as I wrote
>> in the other reply, I don't think there's a good reason for that to be
>> the case.
> Well, cannot it happen that the flush worker will get stuck in D state
> because some subsystem is already suspended and thus hibernation fails
> (because AFAIK processes in uninterruptible sleep block hibernation)?
>
> I was also somewhat worried that the hibernation image could be
> inconsistent if flush workers do something while hibernation image is being
> taken but that does not seem to be a valid concern as all kernel processes
> get frozen before hibernation image is taken.

To be precise, nothing is scheduled while creating a hibernation image, 
but once the image has been created, threads that are not frozen can be 
scheduled again and there are kernel threads which aren't frozen.

So the question is whether or not any of the kernel threads which are 
not frozen can do anything potentially unsafe if the bdi wq is not 
freezable and I don't quite see what that might be.


