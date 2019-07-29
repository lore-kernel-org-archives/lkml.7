Return-Path: <SRS0=K9bG=V2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D26C4C433FF
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jul 2019 04:53:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 97CE52070B
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jul 2019 04:53:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="h8r5poRK";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="SY9t6Q5j"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726436AbfG2Exr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Jul 2019 00:53:47 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:58522 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726164AbfG2Exr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Jul 2019 00:53:47 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 6C8306074F; Mon, 29 Jul 2019 04:53:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1564376025;
        bh=v+vCZH4yEGr9MM8pQs4DZYDjxgNgaGjO9aKWbuFV6Qg=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=h8r5poRKZDyjpLTBUiQl0R4XG0baxj+5kotrng8T0pwi7igBn12nNsxHRyq8IG1Ra
         m8sJhMWRGPU5nkQPDEwk8mJmalaxbvGJB1XS03qRQ0mBYwIgzaQ3KQv05Kgqa9Ru44
         dCuWC2IR3XAX1d/uwDtlcPD6IhzNWGjkTbLkR7QA=
Received: from [10.204.79.19] (blr-c-bdr-fw-01_globalnat_allzones-outside.qualcomm.com [103.229.19.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: prsood@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 92A3B60247;
        Mon, 29 Jul 2019 04:53:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1564376023;
        bh=v+vCZH4yEGr9MM8pQs4DZYDjxgNgaGjO9aKWbuFV6Qg=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=SY9t6Q5jDt0qnOgzOlg166y6nBzKiOPHhUsmWudRChh/wWaaM0ZmunX7Tzz/m9xiD
         3zsO0eISG1gN1nW23KNBlUOcDU16HdteEdJ42Vogqc7FsvkHmh7Lw073BlZaTpnBZ4
         jwU0DAyFH/XPbmzdhQ2m3YSo+vVdqIIzLTFn6WKU=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 92A3B60247
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=prsood@codeaurora.org
Subject: Re: [PATCH v7] driver core: Fix use-after-free and double free on
 glue directory
To:     Muchun Song <smuchun@gmail.com>, gregkh@linuxfoundation.org,
        rafael@kernel.org, mojha@codeaurora.org
Cc:     benh@kernel.crashing.org, gkohli@codeaurora.org,
        songmuchun@bytedance.com, linux-kernel@vger.kernel.org
References: <20190727032122.24639-1-smuchun@gmail.com>
From:   Prateek Sood <prsood@codeaurora.org>
Message-ID: <3a1884e1-7453-a938-8136-a31e5168a6f9@codeaurora.org>
Date:   Mon, 29 Jul 2019 10:23:39 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190727032122.24639-1-smuchun@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/27/19 8:51 AM, Muchun Song wrote:
> There is a race condition between removing glue directory and adding a new
> device under the glue dir. It can be reproduced in following test:
> 
> CPU1:                                         CPU2:
> 
> device_add()
>   get_device_parent()
>     class_dir_create_and_add()
>       kobject_add_internal()
>         create_dir()    // create glue_dir
> 
>                                               device_add()
>                                                 get_device_parent()
>                                                   kobject_get() // get glue_dir
> 
> device_del()
>   cleanup_glue_dir()
>     kobject_del(glue_dir)
> 
>                                                 kobject_add()
>                                                   kobject_add_internal()
>                                                     create_dir() // in glue_dir
>                                                       sysfs_create_dir_ns()
>                                                         kernfs_create_dir_ns(sd)
> 
>       sysfs_remove_dir() // glue_dir->sd=NULL
>       sysfs_put()        // free glue_dir->sd
> 
>                                                           // sd is freed
>                                                           kernfs_new_node(sd)
>                                                             kernfs_get(glue_dir)
>                                                             kernfs_add_one()
>                                                             kernfs_put()
> 
> Before CPU1 remove last child device under glue dir, if CPU2 add a new
> device under glue dir, the glue_dir kobject reference count will be
> increase to 2 via kobject_get() in get_device_parent(). And CPU2 has
> been called kernfs_create_dir_ns(), but not call kernfs_new_node().
> Meanwhile, CPU1 call sysfs_remove_dir() and sysfs_put(). This result in
> glue_dir->sd is freed and it's reference count will be 0. Then CPU2 call
> kernfs_get(glue_dir) will trigger a warning in kernfs_get() and increase
> it's reference count to 1. Because glue_dir->sd is freed by CPU1, the next
> call kernfs_add_one() by CPU2 will fail(This is also use-after-free)
> and call kernfs_put() to decrease reference count. Because the reference
> count is decremented to 0, it will also call kmem_cache_free() to free
> the glue_dir->sd again. This will result in double free.
> 
> In order to avoid this happening, we also should make sure that kernfs_node
> for glue_dir is released in CPU1 only when refcount for glue_dir kobj is
> 1 to fix this race.
> 
> The following calltrace is captured in kernel 4.14 with the following patch
> applied:
> 
> commit 726e41097920 ("drivers: core: Remove glue dirs from sysfs earlier")
> 
> --------------------------------------------------------------------------
> [    3.633703] WARNING: CPU: 4 PID: 513 at .../fs/kernfs/dir.c:494
>                 Here is WARN_ON(!atomic_read(&kn->count) in kernfs_get().
> ....
> [    3.633986] Call trace:
> [    3.633991]  kernfs_create_dir_ns+0xa8/0xb0
> [    3.633994]  sysfs_create_dir_ns+0x54/0xe8
> [    3.634001]  kobject_add_internal+0x22c/0x3f0
> [    3.634005]  kobject_add+0xe4/0x118
> [    3.634011]  device_add+0x200/0x870
> [    3.634017]  _request_firmware+0x958/0xc38
> [    3.634020]  request_firmware_into_buf+0x4c/0x70
> ....
> [    3.634064] kernel BUG at .../mm/slub.c:294!
>                 Here is BUG_ON(object == fp) in set_freepointer().
> ....
> [    3.634346] Call trace:
> [    3.634351]  kmem_cache_free+0x504/0x6b8
> [    3.634355]  kernfs_put+0x14c/0x1d8
> [    3.634359]  kernfs_create_dir_ns+0x88/0xb0
> [    3.634362]  sysfs_create_dir_ns+0x54/0xe8
> [    3.634366]  kobject_add_internal+0x22c/0x3f0
> [    3.634370]  kobject_add+0xe4/0x118
> [    3.634374]  device_add+0x200/0x870
> [    3.634378]  _request_firmware+0x958/0xc38
> [    3.634381]  request_firmware_into_buf+0x4c/0x70
> --------------------------------------------------------------------------
> 
> Fixes: 726e41097920 ("drivers: core: Remove glue dirs from sysfs earlier")
> 
> Signed-off-by: Muchun Song <smuchun@gmail.com>
> Reviewed-by: Mukesh Ojha <mojha@codeaurora.org>
> ---
> 
> Change in v7:
>        1. Update commit message.
> Change in v6:
>        1. Remove hardcoding "1 "
> Change in v5:
>        1. Revert to the v1 fix.
>        2. Add some comment to explain why we need do this in
>           cleanup_glue_dir().
> Change in v4:
>        1. Add some kerneldoc comment.
>        2. Remove unlock_if_glue_dir().
>        3. Rename get_device_parent_locked_if_glue_dir() to
>           get_device_parent_locked.
>        4. Update commit message.
> Change in v3:
>        Add change log.
> Change in v2:
>        Fix device_move() also.
> 
>  drivers/base/core.c | 53 ++++++++++++++++++++++++++++++++++++++++++++-
>  1 file changed, 52 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/base/core.c b/drivers/base/core.c
> index 4aeaa0c92bda..edc55160c5f0 100644
> --- a/drivers/base/core.c
> +++ b/drivers/base/core.c
> @@ -1820,12 +1820,63 @@ static inline struct kobject *get_glue_dir(struct device *dev)
>   */
>  static void cleanup_glue_dir(struct device *dev, struct kobject *glue_dir)
>  {
> +	unsigned int ref;
> +
>  	/* see if we live in a "glue" directory */
>  	if (!live_in_glue_dir(glue_dir, dev))
>  		return;
>  
>  	mutex_lock(&gdp_mutex);
> -	if (!kobject_has_children(glue_dir))
> +	/**
> +	 * There is a race condition between removing glue directory
> +	 * and adding a new device under the glue directory.
> +	 *
> +	 * CPU1:                                         CPU2:
> +	 *
> +	 * device_add()
> +	 *   get_device_parent()
> +	 *     class_dir_create_and_add()
> +	 *       kobject_add_internal()
> +	 *         create_dir()    // create glue_dir
> +	 *
> +	 *                                               device_add()
> +	 *                                                 get_device_parent()
> +	 *                                                   kobject_get() // get glue_dir
> +	 *
> +	 * device_del()
> +	 *   cleanup_glue_dir()
> +	 *     kobject_del(glue_dir)
> +	 *
> +	 *                                               kobject_add()
> +	 *                                                 kobject_add_internal()
> +	 *                                                   create_dir() // in glue_dir
> +	 *                                                     sysfs_create_dir_ns()
> +	 *                                                       kernfs_create_dir_ns(sd)
> +	 *
> +	 *       sysfs_remove_dir() // glue_dir->sd=NULL
> +	 *       sysfs_put()        // free glue_dir->sd
> +	 *
> +	 *                                                         // sd is freed
> +	 *                                                         kernfs_new_node(sd)
> +	 *                                                           kernfs_get(glue_dir)
> +	 *                                                           kernfs_add_one()
> +	 *                                                           kernfs_put()
> +	 *
> +	 * Before CPU1 remove last child device under glue dir, if CPU2 add
> +	 * a new device under glue dir, the glue_dir kobject reference count
> +	 * will be increase to 2 in kobject_get(k). And CPU2 has been called
> +	 * kernfs_create_dir_ns(). Meanwhile, CPU1 call sysfs_remove_dir()
> +	 * and sysfs_put(). This result in glue_dir->sd is freed.
> +	 *
> +	 * Then the CPU2 will see a stale "empty" but still potentially used
> +	 * glue dir around in kernfs_new_node().
> +	 *
> +	 * In order to avoid this happening, we also should make sure that
> +	 * kernfs_node for glue_dir is released in CPU1 only when refcount
> +	 * for glue_dir kobj is 1.
> +	 */
> +	ref = kref_read(&glue_dir->kref);
> +	if (!kobject_has_children(glue_dir) && !--ref)
>  		kobject_del(glue_dir);
>  	kobject_put(glue_dir);
>  	mutex_unlock(&gdp_mutex);
>

Looks good to me and inline with https://lkml.org/lkml/2019/5/1/3

Signed-off-by: Prateek Sood <prsood@codeaurora.org>


Thanks
Prateek

-- 
Qualcomm India Private Limited, on behalf of Qualcomm Innovation
Center, Inc., is a member of Code Aurora Forum, a Linux Foundation
Collaborative Project
