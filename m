Return-Path: <SRS0=SZ1Q=SM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 06ACDC10F11
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Apr 2019 14:52:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D4B212064A
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Apr 2019 14:52:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732905AbfDJOws (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Apr 2019 10:52:48 -0400
Received: from lb1-smtp-cloud7.xs4all.net ([194.109.24.24]:35868 "EHLO
        lb1-smtp-cloud7.xs4all.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1732881AbfDJOwp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Apr 2019 10:52:45 -0400
Received: from [IPv6:2001:983:e9a7:1:5c18:3544:e4bb:f52f] ([IPv6:2001:983:e9a7:1:5c18:3544:e4bb:f52f])
        by smtp-cloud7.xs4all.net with ESMTPA
        id EEafhlahzNG8zEEahh1jcf; Wed, 10 Apr 2019 16:52:43 +0200
Subject: Re: [PATCH] [media] v4l2-core: fix use-after-free error
To:     Sumit Gupta <sumitg@nvidia.com>, mchehab@kernel.org,
        sakari.ailus@linux.intel.com, paul.kocialkowski@bootlin.com,
        tfiga@chromium.org, keiichiw@chromium.org
Cc:     linux-media@vger.kernel.org, linux-kernel@vger.kernel.org
References: <1554906508-17192-1-git-send-email-sumitg@nvidia.com>
From:   Hans Verkuil <hverkuil-cisco@xs4all.nl>
Message-ID: <0480272b-4b36-0782-b501-28f305bb7903@xs4all.nl>
Date:   Wed, 10 Apr 2019 16:52:41 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.1
MIME-Version: 1.0
In-Reply-To: <1554906508-17192-1-git-send-email-sumitg@nvidia.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-CMAE-Envelope: MS4wfNVG/QHVlHN/BttHCEQu5shGFOQVnHfCSwCcHrd4ypVOzjbFxUPljsWhgQgL4q62j4c/mxnapkPBSNdgilPEboQvFlUFGsGw32vSAsEvXcPJoQPE7uuW
 6aUpWl5Ys4FrxJ1uScBKu/xBZIrY7VXkWnov6td2II00MIscMtRvVhN/qx8InRFwD1CdRysBPkyWJOfAEUp5l4N61DN5VXvA1V7ufi0DZ4AVjUadF2rrgJG3
 cGaGbcIqw1LyMptwQtDYZ92i3LnfgyCrh2Jmv8NSjdidq2az7PZbrPBwD/xImUp70JKw0GbBqhiZxl6ezrObvibnnBeVkQNwCNU330Rt3SQlxKD/4STdbhDs
 aslLJBAlcY8kqwF7ZNYI0UDoW+Nwj6Vc0xssUsVsWR0y6n5SsNUWm+rYueEsqdH06LkO8Sk2Twl6AGBJ9bx8NvUNulEdIKJrGV4hzlrBfp26QRfGgiuFNJnH
 nGXGbUMqElz3St5nqbWUFPtglLuooqQHxvFP1pBQRmjBSZeieLPtxzhBHPM=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/10/19 4:28 PM, Sumit Gupta wrote:
> From: sumitg <sumitg@nvidia.com>
> 
> Fixing use-after-free within __v4l2_ctrl_handler_setup().
> Memory is being freed with kfree(new_ref) for duplicate
> control reference entry but cluster is still referring
> to the duplicate entry. Change done to point cluster to
> original reference instead of duplicate which is freed.
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
> Signed-off-by: sumitg <sumitg@nvidia.com>
> ---
>  drivers/media/v4l2-core/v4l2-ctrls.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/media/v4l2-core/v4l2-ctrls.c b/drivers/media/v4l2-core/v4l2-ctrls.c
> index 5e3806f..e971bab 100644
> --- a/drivers/media/v4l2-core/v4l2-ctrls.c
> +++ b/drivers/media/v4l2-core/v4l2-ctrls.c
> @@ -2182,6 +2182,7 @@ static int handler_new_ref(struct v4l2_ctrl_handler *hdl,
>  			continue;
>  		/* Don't add duplicates */
>  		if (ref->ctrl->id == id) {
> +			ctrl->cluster = &ref->ctrl;
>  			kfree(new_ref);
>  			goto unlock;
>  		}
> 

I don't like this solution. Instead move this code:

        if (ctrl->handler == hdl) {
                /* By default each control starts in a cluster of its own.
                   new_ref->ctrl is basically a cluster array with one
                   element, so that's perfect to use as the cluster pointer.
                   But only do this for the handler that owns the control. */
                ctrl->cluster = &new_ref->ctrl;
                ctrl->ncontrols = 1;
        }

to after the insert_in_hash label.

That way the ctrl->cluster pointer is only updated if everything is OK.

Nice catch, BTW!

Regards,

	Hans
