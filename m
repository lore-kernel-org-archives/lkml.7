Return-Path: <SRS0=EIds=SH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5FBCCC4360F
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Apr 2019 12:31:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2423F2186A
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Apr 2019 12:31:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="corF11M1";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="Jpt699g+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730929AbfDEMbY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 5 Apr 2019 08:31:24 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:51268 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730329AbfDEMbX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Apr 2019 08:31:23 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id DB3756141D; Fri,  5 Apr 2019 12:31:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1554467481;
        bh=R4NzVp2BiDHcxcbakRqk/K2HHSaHW6gyMsaAUCyuPgg=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=corF11M1tsgdl4nqD8SEw+wJh2n6GCPtuvoYbxDSiGutF8XuHeKNmW9JTzubL/65v
         asSc3NxImEmhPCQj3SiJyd8EIwEZOOo/1uPTkAHDWfSUnnjpwqmn93ZrxwdcOpQ68R
         ITJgt/NZdObQR2YqM7rpr/DrAJMFho1Ok17evzm8=
Received: from [10.204.79.83] (blr-c-bdr-fw-01_globalnat_allzones-outside.qualcomm.com [103.229.19.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: mojha@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id AFB5D6141D;
        Fri,  5 Apr 2019 12:31:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1554467479;
        bh=R4NzVp2BiDHcxcbakRqk/K2HHSaHW6gyMsaAUCyuPgg=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=Jpt699g+S9Mq2GJ1rk8KvppgP4K5o1L03KSipBM+sWvo3mMSmpsbaqSxcSs78ovHU
         Rw40wFPeT+0NpguSuIzfiGCvsGU5+vW2mmNraad5pNQ+C5wUImPCZkdtWkdXD0nPY1
         WOJEDqJNNk7401twoe1o4hcr+C5Sv8Vf39e3ofAM=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org AFB5D6141D
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=mojha@codeaurora.org
Subject: Re: [PATCH v0] kernfs: Skip kernfs_put of parent from child node
To:     Greg KH <gregkh@linuxfoundation.org>,
        Gaurav Kohli <gkohli@codeaurora.org>
Cc:     tj@kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org
References: <1554463267-30841-1-git-send-email-gkohli@codeaurora.org>
 <20190405113304.GA28420@kroah.com>
 <a491b524-54e2-839d-d8e6-c21e7ab7fdd1@codeaurora.org>
 <20190405121020.GA32479@kroah.com>
From:   Mukesh Ojha <mojha@codeaurora.org>
Message-ID: <50a69f9a-506c-c83c-0289-2a739d42f35b@codeaurora.org>
Date:   Fri, 5 Apr 2019 18:01:15 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190405121020.GA32479@kroah.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 4/5/2019 5:40 PM, Greg KH wrote:
> On Fri, Apr 05, 2019 at 05:13:00PM +0530, Gaurav Kohli wrote:
>> On 4/5/2019 5:03 PM, Greg KH wrote:
>>> On Fri, Apr 05, 2019 at 04:51:07PM +0530, Gaurav Kohli wrote:
>>>> While adding kernfs node for child to the parent kernfs
>>>> node and when child node founds that parent kn count is
>>>> zero, then below comes like:
>>>>
>>>> WARNING: fs/kernfs/dir.c:494 kernfs_get+0x64/0x88
>>>>
>>>> This indicates that parent is in kernfs_put path/ or already
>>>> freed, and if the child node keeps continue to
>>>> make new kernfs node, then there is chance of
>>>> below race for parent node:
>>>>
>>>> CPU0				         CPU1
>>>> //Parent node			         //child node
>>>> kernfs_put
>>>> atomic_dec_and_test(&kn->count)
>>>> //count is 0, so continue
>>>> 					  kernfs_new_node(child)
>>>> 					  kernfs_get(parent);
>>>> 					  //increment parent count to 1
>>>> 					  //warning come as parent count is 0
>>>> 					  /* link in */
>>>> 					  kernfs_add_one(kn);
>>>> 					  // this should fail as parent is
>>>> 					  //in free path.
>>>> 					  kernfs_put(child)
>>>> kmem_cache_free(parent)
>>>> 					  kmem_cache_free(child)
>>>> 					  kn = parent
>>>> 					  atomic_dec_and_test(&kn->count))
>>>> 					  //this is 0 now, so release will
>>>> 					  continue for parent.
>>>> 					  kmem_cache_free(parent)
>>>>
>>>> To prevent this race, child simply has to decrement count of parent
>>>> kernfs node and keep continue the free path for itself.
>>>>
>>>> Signed-off-by: Gaurav Kohli <gkohli@codeaurora.org>
>>>> Signed-off-by: Mukesh Ojha <mojha@codeaurora.org>
>>>>
>>>> diff --git a/fs/kernfs/dir.c b/fs/kernfs/dir.c
>>>> index b84d635..d5a36e8 100644
>>>> --- a/fs/kernfs/dir.c
>>>> +++ b/fs/kernfs/dir.c
>>>> @@ -515,7 +515,6 @@ void kernfs_put(struct kernfs_node *kn)
>>>>    	if (!kn || !atomic_dec_and_test(&kn->count))
>>>>    		return;
>>>>    	root = kernfs_root(kn);
>>>> - repeat:
>>>>    	/*
>>>>    	 * Moving/renaming is always done while holding reference.
>>>>    	 * kn->parent won't change beneath us.
>>>> @@ -545,8 +544,8 @@ void kernfs_put(struct kernfs_node *kn)
>>>>    	kn = parent;
>>>>    	if (kn) {
>>>> -		if (atomic_dec_and_test(&kn->count))
>>>> -			goto repeat;
>>>> +	/* Parent may be on free path, so simply decrement the count */
>>> That's the wrong indentation :(
>>>
>>> And how are you hitting this issue?  What user of kernfs is causing
>>> this?
>> Hi Greg,
>>
>> Thanks,  will fix comment indentation, seen during sys-executor running:
>>
>> We have only one instance , In logs below warning also came:
>>
>> WARNING: CPU: 4 kernel/msm-4.14/fs/kernfs/dir.c:494 kernfs_get+0x64/0x88
>>
>> which indicated parent is in put path.
>>
>> [  160.125151] Disabling lock debugging due to kernel taint
>> [  160.130626] INFO: Allocated in __kernfs_new_node+0x8c/0x3c0 age=11 cpu=2
>> pid=7098
>> [  160.138314]     kmem_cache_alloc+0x358/0x388
>> [  160.142445]     __kernfs_new_node+0x8c/0x3c0
>> [  160.146590]     kernfs_new_node+0x80/0xc8
>> [  160.150462]     kernfs_create_dir_ns+0x44/0xfc
>> [  160.154777]     sysfs_create_dir_ns+0xa8/0x130
>> [  160.158416] CPU5: update max cpu_capacity 1024
>> [  160.159085]     kobject_add_internal+0x278/0x650
>> [  160.163567]     kobject_add_varg+0xe0/0x130
>> [  160.167606]     kobject_add+0x15c/0x1d0
>> [  160.168452] CPU5: update max cpu_capacity 780
>> [  160.171287]     get_device_parent+0x2d0/0x34c
>> [  160.175510]     device_add+0x240/0xde0
>> [  160.178371] CPU6: update max cpu_capacity 916
>> [  160.179108]     input_register_device+0x5f4/0xa0c
>> [  160.183686]     uinput_ioctl_handler+0x1184/0x2198
>> [  160.202436] INFO: Freed in kernfs_put+0x2c8/0x434 age=14 cpu=0 pid=7096
>> [  160.209230]     kernfs_put+0x2c8/0x434
>> [  160.212825]     kobject_del+0x50/0xcc
>> [  160.216332]     cleanup_glue_dir+0x124/0x16c
>> [  160.220456]     device_del+0x55c/0x5c8
>> [  160.224047]     __input_unregister_device+0x274/0x2a8
>> [  160.228974]     input_unregister_device+0x90/0xd0
>> [  160.233553]     uinput_destroy_device+0x15c/0x1dc
>> [  160.238131]     uinput_release+0x44/0x5c
>> [  160.241898]     __fput+0x1f4/0x4e4
>> [  160.245127]     ____fput+0x20/0x2c
>>
>>
>> during code review, I have found race between kernfs parent put call and
>> child get call.
> So this is a sysfs usage of this?
>
yes

>    Using input devices or cpu devices
> for the stress test?

input devices ..

[ 1714.090310] input: syz1 as /devices/virtual/input/input191
[ 1714.223037] input: syz1 as /devices/virtual/input/input192

..

[ 1714.428228] input: syz1 as /devices/virtual/input/input193

..
[ 1714.528256] input: syz1 as /devices/virtual/input/input194
..

[ 1714.756481] input: syz1 as /devices/virtual/input/input195
..
[ 1714.831920] input: syz1 as /devices/virtual/input/input196

..

Cheers,
Mukesh

>
> thanks,
>
> greg k-h
