Return-Path: <SRS0=FHjv=VA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5D769C0650E
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Jul 2019 19:36:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 25C6121882
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Jul 2019 19:36:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1562182572;
	bh=X+w6oEZ7Oqtw7OosCBFQMbPj6yt8YZdBW+clG6vdnHQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=amrbrf5pMDaxFkCveWa2xix43cY7pcFDygB5IRnTkxk0q+2OMyEgobfCbb2HSXnrh
	 5igAGDHacYU6pBF8IAqOBssRIJH96e5Pmi8wNg5GX3B1cgFr3H7ZzUAr9cbVQSTuK2
	 dfNNtaUXrmyy1YmR3bpi1Sh2j56i1VWkGXfSw+Ks=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727006AbfGCTgK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Jul 2019 15:36:10 -0400
Received: from mail.kernel.org ([198.145.29.99]:50094 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726473AbfGCTgK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Jul 2019 15:36:10 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 676DA21882;
        Wed,  3 Jul 2019 19:36:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1562182568;
        bh=X+w6oEZ7Oqtw7OosCBFQMbPj6yt8YZdBW+clG6vdnHQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=2T9R9p660mrCBOPbl9g/ChqJBQafKQl67BXZD5ysSIcaSD+6TDhuDPXViFoptsUSx
         RxFferRwXB1GCPM3giZfseHqXkpcx7gFN49VKVLhwE4HUOJ1hh16r56pFUX2aIXJyv
         Kd4ieqQiBAHrWTl/Holq52hq2voLL/TPoeg8cS9Y=
Date:   Wed, 3 Jul 2019 21:36:06 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Muchun Song <smuchun@gmail.com>
Cc:     rafael@kernel.org, benh@kernel.crashing.org, prsood@codeaurora.org,
        mojha@codeaurora.org, gkohli@codeaurora.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 OPT2] driver core: Fix use-after-free and double free
 on glue directory
Message-ID: <20190703193606.GA8452@kroah.com>
References: <20190626144021.7249-1-smuchun@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190626144021.7249-1-smuchun@gmail.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 26, 2019 at 10:40:21PM +0800, Muchun Song wrote:
> There is a race condition between removing glue directory and adding a new
> device under the glue directory. It can be reproduced in following test:
> 
> path 1: Add the child device under glue dir
> device_add()
>     get_device_parent()
>         mutex_lock(&gdp_mutex);
>         ....
>         /*find parent from glue_dirs.list*/
>         list_for_each_entry(k, &dev->class->p->glue_dirs.list, entry)
>             if (k->parent == parent_kobj) {
>                 kobj = kobject_get(k);
>                 break;
>             }
>         ....
>         mutex_unlock(&gdp_mutex);
>         ....
>     ....
>     kobject_add()
>         kobject_add_internal()
>             create_dir()
>                 sysfs_create_dir_ns()
>                     if (kobj->parent)
>                         parent = kobj->parent->sd;
>                     ....
>                     kernfs_create_dir_ns(parent)
>                         kernfs_new_node()
>                             kernfs_get(parent)
>                         ....
>                         /* link in */
>                         rc = kernfs_add_one(kn);
>                         if (!rc)
>                             return kn;
> 
>                         kernfs_put(kn)
>                             ....
>                             repeat:
>                             kmem_cache_free(kn)
>                             kn = parent;
> 
>                             if (kn) {
>                                 if (atomic_dec_and_test(&kn->count))
>                                     goto repeat;
>                             }
>                         ....
> 
> path2: Remove last child device under glue dir
> device_del()
>     cleanup_device_parent()
>         cleanup_glue_dir()
>             mutex_lock(&gdp_mutex);
>             if (!kobject_has_children(glue_dir))
>                 kobject_del(glue_dir);
>             kobject_put(glue_dir);
>             mutex_unlock(&gdp_mutex);
> 
> Before path2 remove last child device under glue dir, If path1 add a new
> device under glue dir, the glue_dir kobject reference count will be
> increase to 2 via kobject_get(k) in get_device_parent(). And path1 has
> been called kernfs_new_node(), but not call kernfs_get(parent).
> Meanwhile, path2 call kobject_del(glue_dir) beacause 0 is returned by
> kobject_has_children(). This result in glue_dir->sd is freed and it's
> reference count will be 0. Then path1 call kernfs_get(parent) will trigger
> a warning in kernfs_get()(WARN_ON(!atomic_read(&kn->count))) and increase
> it's reference count to 1. Because glue_dir->sd is freed by path2, the next
> call kernfs_add_one() by path1 will fail(This is also use-after-free)
> and call atomic_dec_and_test() to decrease reference count. Because the
> reference count is decremented to 0, it will also call kmem_cache_free()
> to free glue_dir->sd again. This will result in double free.
> 
> In order to avoid this happening, we can ensure the lookup of the glue
> dir and creation of the child object(s) are done under a single instance
> of gdp_mutex so we never see a stale "empty" but still poentially used
> glue dir around.
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
> ---
> 
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
>  drivers/base/core.c | 108 +++++++++++++++++++++++++++++++++++++-------
>  1 file changed, 92 insertions(+), 16 deletions(-)
> 
> diff --git a/drivers/base/core.c b/drivers/base/core.c
> index 4aeaa0c92bda..2251e391a352 100644
> --- a/drivers/base/core.c
> +++ b/drivers/base/core.c
> @@ -1739,8 +1739,23 @@ class_dir_create_and_add(struct class *class, struct kobject *parent_kobj)
>  
>  static DEFINE_MUTEX(gdp_mutex);
>  
> -static struct kobject *get_device_parent(struct device *dev,
> -					 struct device *parent)
> +/**
> + * __get_device_parent() - Get the parent device kobject.
> + * @dev: Pointer to the device structure.
> + * @parent: Pointer to the parent device structure.
> + * @lock: When we live in a glue directory, should we hold the
> + *        gdp_mutex lock when this function returns? If @lock
> + *        is true, this function returns with the gdp_mutex
> + *        holed. Otherwise it will not.

Ugh, if you are trying to get me to hate one version of these patches,
this is how you do it :)

A function should not "sometimes takes a lock, sometimes does not,
depending on a parameter passed into it"  That way lies madness...


> + *
> + * Note: Only when we live in a glue directory and @lock is
> + * true, the function will return with the gdp_mutex holed.
> + * In this case, The caller is responsible for releasing the
> + * gdp_mutex lock.
> + */
> +static struct kobject *__get_device_parent(struct device *dev,
> +					   struct device *parent,
> +					   bool lock)
>  {
>  	if (dev->class) {
>  		struct kobject *kobj = NULL;
> @@ -1778,16 +1793,32 @@ static struct kobject *get_device_parent(struct device *dev,
>  				break;
>  			}
>  		spin_unlock(&dev->class->p->glue_dirs.list_lock);
> -		if (kobj) {
> -			mutex_unlock(&gdp_mutex);
> -			return kobj;
> -		}
>  
> -		/* or create a new class-directory at the parent device */
> -		k = class_dir_create_and_add(dev->class, parent_kobj);
> -		/* do not emit an uevent for this simple "glue" directory */
> -		mutex_unlock(&gdp_mutex);
> -		return k;
> +		/**

Note, in the future, you don't need to use /** for comments in a
function, those are only for kernel doc markers for a _global_ function
that gets pulled into the larger documentation documents.  So even
__get_device_parent() here does not need this.

Anyway, this is a mess.

Ugh I hate glue dirs...

greg k-h
