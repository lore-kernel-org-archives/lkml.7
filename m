Return-Path: <SRS0=Iew4=V3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1492C0650F
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jul 2019 16:46:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BFA3020693
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jul 2019 16:46:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1564505196;
	bh=Jv3sZV+amDx4LXh0EqyZi1UJfocfNlAOBczaY3hh4+I=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=py3lq8symFdz9VLCETc2PuT76vv2/4XYhnU0JrhujGoFIGfuKVITqzlndMKv8vIKL
	 CsQ4E5kkMGPoQPNl2QcMhkogipby2sjjWj+csJxD8+n35w9UnRe1PkWFT5b4QP+usx
	 DTnoahARZKlA1I5EZH7hZHUjAkLKrZB93r4nMkDQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728664AbfG3Qqf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Jul 2019 12:46:35 -0400
Received: from mail.kernel.org ([198.145.29.99]:57998 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725934AbfG3Qqf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Jul 2019 12:46:35 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id F400520693;
        Tue, 30 Jul 2019 16:46:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1564505194;
        bh=Jv3sZV+amDx4LXh0EqyZi1UJfocfNlAOBczaY3hh4+I=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=DvcMpS/tjf/d16GEeV1oqPaKk5i6GjYjrOCE5pjHrEeAAvXauPSobhCoVdXKM+7TK
         ZqQDdEQGMawOGnLEKlknWApv8DlL9oznPgYPhUgFo4FR9LTzvk2sMDtli9u2oDaSN/
         SD9ZhxDKMEUuWFac8Ol58ZuF+3NH9cilG1gQzTfY=
Date:   Tue, 30 Jul 2019 18:46:31 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Muchun Song <smuchun@gmail.com>
Cc:     rafael@kernel.org, mojha@codeaurora.org, benh@kernel.crashing.org,
        prsood@codeaurora.org, gkohli@codeaurora.org,
        songmuchun@bytedance.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v7] driver core: Fix use-after-free and double free on
 glue directory
Message-ID: <20190730164631.GA17604@kroah.com>
References: <20190727032122.24639-1-smuchun@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190727032122.24639-1-smuchun@gmail.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jul 27, 2019 at 11:21:22AM +0800, Muchun Song wrote:
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
> Signed-off-by: Muchun Song <smuchun@gmail.com>
> Reviewed-by: Mukesh Ojha <mojha@codeaurora.org>
> Signed-off-by: Prateek Sood <prsood@codeaurora.org>
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

Now queued up, thanks for sticking with this.

greg k-h
