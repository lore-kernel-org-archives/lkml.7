Return-Path: <SRS0=L2S5=S2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF81CC10F11
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 11:07:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CCE4D218B0
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 11:07:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729335AbfDXLHW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Apr 2019 07:07:22 -0400
Received: from lb2-smtp-cloud7.xs4all.net ([194.109.24.28]:50857 "EHLO
        lb2-smtp-cloud7.xs4all.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729236AbfDXLHU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Apr 2019 07:07:20 -0400
Received: from [IPv6:2001:420:44c1:2579:8575:c0e0:a08:6676] ([IPv6:2001:420:44c1:2579:8575:c0e0:a08:6676])
        by smtp-cloud7.xs4all.net with ESMTPA
        id JFkAhJpLXZVjxJFkEhaD1V; Wed, 24 Apr 2019 13:07:18 +0200
Subject: Re: [Patch V3] v4l2-core: fix use-after-free error
To:     Sumit Gupta <sumitg@nvidia.com>, mchehab@kernel.org,
        sakari.ailus@linux.intel.com, paul.kocialkowski@bootlin.com,
        tfiga@chromium.org, keiichiw@chromium.org, bbasu@nvidia.com
Cc:     linux-media@vger.kernel.org, linux-kernel@vger.kernel.org
References: <1555342574-15940-1-git-send-email-sumitg@nvidia.com>
From:   Hans Verkuil <hverkuil-cisco@xs4all.nl>
Message-ID: <16a25e01-7ebe-f0c9-2915-bd811b28c9c0@xs4all.nl>
Date:   Wed, 24 Apr 2019 13:07:14 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.1
MIME-Version: 1.0
In-Reply-To: <1555342574-15940-1-git-send-email-sumitg@nvidia.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-CMAE-Envelope: MS4wfA2XhjIQB4gHBL8JP6auKKD3VejLnQzgLXd6P6csEpG1WFXLG3Zdog5kAv8niRXH6VcZhn3AVR23DKFuarf3QdbeRbmUxDz3PdCGhnDojFBQ8qHYT6a9
 cHqn4jefYy8ZMxNz36pyQYe0GON2PSgGMuTRUZf4IlevDOf0AbfGiBG+dVkDI7D49OijKbFYmN2lVPSdbIgHGXWh5qxIiSrFaAiJ4pkPAJN+vC15A7Y9Mg82
 Zt8uZiaG/IrAMHQaLKIIIT48RqbhouM0Whk4fwzeO0+PC/4CXyYviq8JClliSK85D2FH9XtgI91E6z01GpjoTe/Jhfzg/GqQd9pd+xNXWWRmHxIjqNRxMmXK
 NDEmNYh3l0cmdlCgXPeLwVdGMg4n1ij/EJZo6GDiJzOplFQIAJNeIU8W9/FeSfuQ2TZk6BPHYx3KP/ZDQ0XdeauX8FL6WYGS4ejF3W50hLT+r+Cgxf8sYUI0
 l2GMTLAZeCwvPVHWmNgEze6N90Gz48R8fHcdrgfChjo5YBIeVx/JMQw4jl3Pj8bKWLHKvRCRm+EazpOW99YSbGvq7D5dVkL1NggeTw==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/15/19 5:36 PM, Sumit Gupta wrote:
> From: sumitg <sumitg@nvidia.com>
> 
> Fixing use-after-free within __v4l2_ctrl_handler_setup().
> Memory is being freed with kfree(new_ref) for duplicate
> control reference entry but ctrl->cluster pointer is still
> referring to freed duplicate entry resulting in error on
> access. Change done to update cluster pointer only when new
> control reference is added. Also, added check to add new
> ctrl to handler only if the cluster points to an entry.
> 
>  ==================================================================
>  BUG: KASAN: use-after-free in __v4l2_ctrl_handler_setup+0x388/0x428
>  Read of size 8 at addr ffffffc324e78618 by task systemd-udevd/312
> 
>  Allocated by task 312:
> 
>  Freed by task 312:
> 
>  The buggy address belongs to the object at ffffffc324e78600
>   which belongs to the cache kmalloc-64 of size 64
>  The buggy address is located 24 bytes inside of
>   64-byte region [ffffffc324e78600, ffffffc324e78640)
>  The buggy address belongs to the page:
>  page:ffffffbf0c939e00 count:1 mapcount:0 mapping:
> 					(null) index:0xffffffc324e78f80
>  flags: 0x4000000000000100(slab)
>  raw: 4000000000000100 0000000000000000 ffffffc324e78f80 000000018020001a
>  raw: 0000000000000000 0000000100000001 ffffffc37040fb80 0000000000000000
>  page dumped because: kasan: bad access detected
> 
>  Memory state around the buggy address:
>   ffffffc324e78500: fb fb fb fb fb fb fb fb fc fc fc fc fc fc fc fc
>   ffffffc324e78580: fb fb fb fb fb fb fb fb fc fc fc fc fc fc fc fc
>  >ffffffc324e78600: fb fb fb fb fb fb fb fb fc fc fc fc fc fc fc fc
>                              ^
>   ffffffc324e78680: 00 00 00 00 00 00 00 00 fc fc fc fc fc fc fc fc
>   ffffffc324e78700: 00 00 00 00 00 fc fc fc fc fc fc fc fc fc fc fc
>  ==================================================================
> 
> Suggested-by: Hans Verkuil <hverkuil-cisco@xs4all.nl>
> Signed-off-by: Sumit Gupta <sumitg@nvidia.com>
> ---
> 
> v3:
> * update ctrl->cluster only when new control reference is added.
> * add new ctrl to handler only if the cluster points to an entry.
> 
> v2:
> * update ctrl->cluster only when new control reference is added.
> * check ctrl->ncontrols to avoid illegal access when cluster has zero controls.
> 
>  drivers/media/v4l2-core/v4l2-ctrls.c | 26 ++++++++++++++------------
>  1 file changed, 14 insertions(+), 12 deletions(-)
> 
> diff --git a/drivers/media/v4l2-core/v4l2-ctrls.c b/drivers/media/v4l2-core/v4l2-ctrls.c
> index 5e3806f..877c2ab 100644
> --- a/drivers/media/v4l2-core/v4l2-ctrls.c
> +++ b/drivers/media/v4l2-core/v4l2-ctrls.c
> @@ -2154,15 +2154,6 @@ static int handler_new_ref(struct v4l2_ctrl_handler *hdl,
>  	if (size_extra_req)
>  		new_ref->p_req.p = &new_ref[1];
>  
> -	if (ctrl->handler == hdl) {
> -		/* By default each control starts in a cluster of its own.
> -		   new_ref->ctrl is basically a cluster array with one
> -		   element, so that's perfect to use as the cluster pointer.
> -		   But only do this for the handler that owns the control. */
> -		ctrl->cluster = &new_ref->ctrl;
> -		ctrl->ncontrols = 1;
> -	}
> -
>  	INIT_LIST_HEAD(&new_ref->node);
>  
>  	mutex_lock(hdl->lock);
> @@ -2195,6 +2186,15 @@ static int handler_new_ref(struct v4l2_ctrl_handler *hdl,
>  	hdl->buckets[bucket] = new_ref;
>  	if (ctrl_ref)
>  		*ctrl_ref = new_ref;
> +	if (ctrl->handler == hdl) {
> +		/* By default each control starts in a cluster of its own.
> +		 * new_ref->ctrl is basically a cluster array with one
> +		 * element, so that's perfect to use as the cluster pointer.
> +		 * But only do this for the handler that owns the control.
> +		 */
> +		ctrl->cluster = &new_ref->ctrl;
> +		ctrl->ncontrols = 1;
> +	}

This is good.

>  
>  unlock:
>  	mutex_unlock(hdl->lock);
> @@ -2346,9 +2346,11 @@ static struct v4l2_ctrl *v4l2_ctrl_new(struct v4l2_ctrl_handler *hdl,
>  		kvfree(ctrl);
>  		return NULL;
>  	}
> -	mutex_lock(hdl->lock);
> -	list_add_tail(&ctrl->node, &hdl->ctrls);
> -	mutex_unlock(hdl->lock);
> +	if (ctrl->cluster) {
> +		mutex_lock(hdl->lock);
> +		list_add_tail(&ctrl->node, &hdl->ctrls);
> +		mutex_unlock(hdl->lock);
> +	}

But why change this? ctrl->cluster can never be NULL here.

If ctrl->cluster really is NULL for you, then something else
is wrong.

Regards,

	Hans

>  	return ctrl;
>  }
>  
> 

