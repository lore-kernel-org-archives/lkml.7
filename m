Return-Path: <SRS0=nVcb=SO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C17CBC10F14
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Apr 2019 13:55:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 898922084D
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Apr 2019 13:55:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726946AbfDLNzu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 12 Apr 2019 09:55:50 -0400
Received: from lb1-smtp-cloud8.xs4all.net ([194.109.24.21]:43464 "EHLO
        lb1-smtp-cloud8.xs4all.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726825AbfDLNzt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Apr 2019 09:55:49 -0400
Received: from [IPv6:2001:983:e9a7:1:207b:e0d6:befb:1b63] ([IPv6:2001:983:e9a7:1:207b:e0d6:befb:1b63])
        by smtp-cloud8.xs4all.net with ESMTPA
        id EweehA2LUUjKfEwefhrLsj; Fri, 12 Apr 2019 15:55:46 +0200
Subject: Re: [Patch V2] v4l2-core: fix use-after-free error
To:     Sumit Gupta <sumitg@nvidia.com>,
        "mchehab@kernel.org" <mchehab@kernel.org>,
        "sakari.ailus@linux.intel.com" <sakari.ailus@linux.intel.com>,
        "paul.kocialkowski@bootlin.com" <paul.kocialkowski@bootlin.com>,
        "tfiga@chromium.org" <tfiga@chromium.org>,
        "keiichiw@chromium.org" <keiichiw@chromium.org>,
        Bibek Basu <bbasu@nvidia.com>
Cc:     "linux-media@vger.kernel.org" <linux-media@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <1554998478-30349-1-git-send-email-sumitg@nvidia.com>
 <b4519134-3053-f80a-ac03-3301abd9e63a@xs4all.nl>
 <SN6PR12MB2832D36A4D06668F30DABD12B9280@SN6PR12MB2832.namprd12.prod.outlook.com>
From:   Hans Verkuil <hverkuil-cisco@xs4all.nl>
Message-ID: <30ea73dc-7be7-1fe4-5270-fb94df5184e9@xs4all.nl>
Date:   Fri, 12 Apr 2019 15:55:44 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <SN6PR12MB2832D36A4D06668F30DABD12B9280@SN6PR12MB2832.namprd12.prod.outlook.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-CMAE-Envelope: MS4wfGJhu86HOXasBp33jOayrWG//4LqIMGN4V8om7IOUxd5DOkhvINDL/UpMCUvE16tfxnPU7Hq9TKo1W5ka5+B/UhMX+g2CY1UVkpe32TTIVHLvhDnIU9l
 aOBJk8LyoxYWtPKEn1Ul1Bzxwg0+o2t+L3U6VHdf/0rY55poQAvz1q8thpaD4ds6oE63NGilKN/3wkcKkXeukPsshtwcZHbvJ6BM1eIfGWgE1/IMO/SNmex2
 v+BGSt8KkWpA419hu+s/kLRLIaqnwaPLcleBpitKybNMw/+YWZCBVoHlsQrdHi2KCK2W5kE2rbyTjG2UJe0RVKfPOjZKc85Lw5y2xNjjOLACZF7UOHYxuqv5
 gHANNHt3H0no9Bem1Gh++W3bP/9lnA0ABX8/a/+s3SlLtyq7XhGAb686EpuwRPxEWB8M6zjrkc+puRf4QRpBC5QhaLX5Ae6OfC2pZKexTeeR89SDiCNm929l
 MzEBM7Z9Lj872G+WiBd0KlLvswGoA3xz3jdfZzAeHWkqlBnLMJdN047l42GNiJa1tzpKgZNxMblcheY6iZ/fy5Rav9WJNWYvtHLr7w==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/12/19 3:47 PM, Sumit Gupta wrote:
> 
> On 4/11/19 6:01 PM, Sumit Gupta wrote:
>> From: sumitg <sumitg@nvidia.com>
>>
>> Fixing use-after-free within __v4l2_ctrl_handler_setup().
>> Memory is being freed with kfree(new_ref) for duplicate control 
>> reference entry but cluster is still referring to the duplicate entry. 
>> Change done to update ctrl->cluster only when new control reference is 
>> added. Also, checking if
>> ctrl->ncontrols is non-zero before accessing controls from
>> cluster pointer to avoid illegal access when cluster has zero 
>> controls.
>>
>>  ==================================================================
>>  BUG: KASAN: use-after-free in __v4l2_ctrl_handler_setup+0x388/0x428
>>  Read of size 8 at addr ffffffc324e78618 by task systemd-udevd/312
>>
>>  Allocated by task 312:
>>
>>  Freed by task 312:
>>
>>  The buggy address belongs to the object at ffffffc324e78600
>>   which belongs to the cache kmalloc-64 of size 64  The buggy address 
>> is located 24 bytes inside of
>>   64-byte region [ffffffc324e78600, ffffffc324e78640)  The buggy 
>> address belongs to the page:
>>  page:ffffffbf0c939e00 count:1 mapcount:0 mapping:
>> 					(null) index:0xffffffc324e78f80
>>  flags: 0x4000000000000100(slab)
>>  raw: 4000000000000100 0000000000000000 ffffffc324e78f80 
>> 000000018020001a
>>  raw: 0000000000000000 0000000100000001 ffffffc37040fb80 
>> 0000000000000000  page dumped because: kasan: bad access detected
>>
>>  Memory state around the buggy address:
>>   ffffffc324e78500: fb fb fb fb fb fb fb fb fc fc fc fc fc fc fc fc
>>   ffffffc324e78580: fb fb fb fb fb fb fb fb fc fc fc fc fc fc fc fc
>>  >ffffffc324e78600: fb fb fb fb fb fb fb fb fc fc fc fc fc fc fc fc
>>                              ^
>>   ffffffc324e78680: 00 00 00 00 00 00 00 00 fc fc fc fc fc fc fc fc
>>   ffffffc324e78700: 00 00 00 00 00 fc fc fc fc fc fc fc fc fc fc fc  
>> ==================================================================
>>
>> Suggested-by: Hans Verkuil <hverkuil-cisco@xs4all.nl>
>> Signed-off-by: Sumit Gupta <sumitg@nvidia.com>
>> ---
>> v2:
>> * update ctrl->cluster only when new control reference is added.
>> * check ctrl->ncontrols to avoid illegal access when cluster has zero controls.
>>
>>  drivers/media/v4l2-core/v4l2-ctrls.c | 53 
>> +++++++++++++++++++-----------------
>>  1 file changed, 28 insertions(+), 25 deletions(-)
>>
>> diff --git a/drivers/media/v4l2-core/v4l2-ctrls.c 
>> b/drivers/media/v4l2-core/v4l2-ctrls.c
>> index 5e3806f..3d0a952 100644
>> --- a/drivers/media/v4l2-core/v4l2-ctrls.c
>> +++ b/drivers/media/v4l2-core/v4l2-ctrls.c
>> @@ -2154,15 +2154,6 @@ static int handler_new_ref(struct v4l2_ctrl_handler *hdl,
>>  	if (size_extra_req)
>>  		new_ref->p_req.p = &new_ref[1];
>>  
>> -	if (ctrl->handler == hdl) {
>> -		/* By default each control starts in a cluster of its own.
>> -		   new_ref->ctrl is basically a cluster array with one
>> -		   element, so that's perfect to use as the cluster pointer.
>> -		   But only do this for the handler that owns the control. */
>> -		ctrl->cluster = &new_ref->ctrl;
>> -		ctrl->ncontrols = 1;
>> -	}
>> -
>>  	INIT_LIST_HEAD(&new_ref->node);
>>  
>>  	mutex_lock(hdl->lock);
>> @@ -2195,6 +2186,15 @@ static int handler_new_ref(struct v4l2_ctrl_handler *hdl,
>>  	hdl->buckets[bucket] = new_ref;
>>  	if (ctrl_ref)
>>  		*ctrl_ref = new_ref;
>> +	if (ctrl->handler == hdl) {
>> +		/* By default each control starts in a cluster of its own.
>> +		 * new_ref->ctrl is basically a cluster array with one
>> +		 * element, so that's perfect to use as the cluster pointer.
>> +		 * But only do this for the handler that owns the control.
>> +		 */
>> +		ctrl->cluster = &new_ref->ctrl;
>> +		ctrl->ncontrols = 1;
>> +	}
>>  
>>  unlock:
>>  	mutex_unlock(hdl->lock);
> 
> This looks good.
> 
>> @@ -2725,25 +2725,28 @@ int __v4l2_ctrl_handler_setup(struct v4l2_ctrl_handler *hdl)
>>  		ctrl->done = false;
>>  
>>  	list_for_each_entry(ctrl, &hdl->ctrls, node) {
>> -		struct v4l2_ctrl *master = ctrl->cluster[0];
>> -		int i;
>> -
>> -		/* Skip if this control was already handled by a cluster. */
>> -		/* Skip button controls and read-only controls. */
>> -		if (ctrl->done || ctrl->type == V4L2_CTRL_TYPE_BUTTON ||
>> -		    (ctrl->flags & V4L2_CTRL_FLAG_READ_ONLY))
>> -			continue;
>> +		if (ctrl->ncontrols) {
>> +			struct v4l2_ctrl *master = ctrl->cluster[0];
>> +			int i;
>> +
>> +			/* Skip if this control was already handled by a */
>> +			/* cluster. Skip button controls and read-only */
>> +			/* controls. */
>> +			if (ctrl->done || ctrl->type == V4L2_CTRL_TYPE_BUTTON ||
>> +				(ctrl->flags & V4L2_CTRL_FLAG_READ_ONLY))
>> +				continue;
>>  
>> -		for (i = 0; i < master->ncontrols; i++) {
>> -			if (master->cluster[i]) {
>> -				cur_to_new(master->cluster[i]);
>> -				master->cluster[i]->is_new = 1;
>> -				master->cluster[i]->done = true;
>> +			for (i = 0; i < master->ncontrols; i++) {
>> +				if (master->cluster[i]) {
>> +					cur_to_new(master->cluster[i]);
>> +					master->cluster[i]->is_new = 1;
>> +					master->cluster[i]->done = true;
>> +				}
>>  			}
>> +			ret = call_op(master, s_ctrl);
>> +			if (ret)
>> +				break;
>>  		}
>> -		ret = call_op(master, s_ctrl);
>> -		if (ret)
>> -			break;
>>  	}
>>  
>>  	return ret;
>>
> 
> These changes shouldn't be needed: when you get here all controls are guaranteed to have a non-0 ncontrols value.
> 
> If it is possible to encounter a control where ncontrols == 0, then that's a bug elsewhere. But as far as I can tell that isn't the case.
> 
> Regards,
> 
> 	Hans
> 
> Yes, I am getting a control where ncontrols is zero as printed below.
> It can be another bug as you said. I think, adding check here will be
> helpful to not crash in such cases. Please share if you think otherwise,
> then will remove the check.
> 
>   int __v4l2_ctrl_handler_setup(struct v4l2_ctrl_handler *hdl)
>                   ctrl->done = false;
>  
>           list_for_each_entry(ctrl, &hdl->ctrls, node) {
>   +               if (ctrl->ncontrols == 0)
>   +                       pr_crit("<func:%s><ctrl->name:%s><ctrl->ncontrols:%d>\n",
>   +                                       __func__, ctrl->name, ctrl->ncontrols);
> 
> Log:
>   [    8.354464] <func:__v4l2_ctrl_handler_setup><ctrl->name:Group Hold><ctrl->ncontrols:0>

Something went wrong if you get this.

This should never happen. Dig a bit deeper to find out how you get into this situation.

You did check hdl->error before calling v4l2_ctrl_handler_setup? Although even if an error
occurred when adding controls, this should still not happen.

Regards,

	Hans

> 
> 
> Regards,
> Sumit Gupta
> 

