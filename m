Return-Path: <SRS0=qq9d=V6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C1BD3C433FF
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Aug 2019 12:55:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9F1132064A
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Aug 2019 12:55:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389677AbfHBMzO convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 2 Aug 2019 08:55:14 -0400
Received: from mail.fireflyinternet.com ([109.228.58.192]:51617 "EHLO
        fireflyinternet.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S2392687AbfHBMyu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Aug 2019 08:54:50 -0400
X-Default-Received-SPF: pass (skip=forwardok (res=PASS)) x-ip-name=78.156.65.138;
Received: from localhost (unverified [78.156.65.138]) 
        by fireflyinternet.com (Firefly Internet (M1)) with ESMTP (TLS) id 17816996-1500050 
        for multiple; Fri, 02 Aug 2019 13:54:45 +0100
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
To:     Jani Nikula <jani.nikula@linux.intel.com>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
From:   Chris Wilson <chris@chris-wilson.co.uk>
In-Reply-To: <20190802123956.2450-1-sergey.senozhatsky@gmail.com>
Cc:     David Airlie <airlied@linux.ie>, Daniel Vetter <daniel@ffwll.ch>,
        intel-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
References: <20190802123956.2450-1-sergey.senozhatsky@gmail.com>
Message-ID: <156475048333.6598.10268421599352645066@skylake-alporthouse-com>
User-Agent: alot/0.6
Subject: Re: [PATCH 1/2] i915: convert to new mount API
Date:   Fri, 02 Aug 2019 13:54:43 +0100
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Sergey Senozhatsky (2019-08-02 13:39:55)
> tmpfs does not set ->remount_fs() anymore and its users need
> to be converted to new mount API.
> 
>  BUG: kernel NULL pointer dereference, address: 0000000000000000
>  PF: supervisor instruction fetch in kernel mode
>  PF: error_code(0x0010) - not-present page
>  RIP: 0010:0x0
>  Code: Bad RIP value.
>  Call Trace:
>   i915_gemfs_init+0x6e/0xa0 [i915]
>   i915_gem_init_early+0x76/0x90 [i915]
>   i915_driver_probe+0x30a/0x1640 [i915]
>   ? kernfs_activate+0x5a/0x80
>   ? kernfs_add_one+0xdd/0x130
>   pci_device_probe+0x9e/0x110
>   really_probe+0xce/0x230
>   driver_probe_device+0x4b/0xc0
>   device_driver_attach+0x4e/0x60
>   __driver_attach+0x47/0xb0
>   ? device_driver_attach+0x60/0x60
>   bus_for_each_dev+0x61/0x90
>   bus_add_driver+0x167/0x1b0
>   driver_register+0x67/0xaa
> 
> Signed-off-by: Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
> ---
>  drivers/gpu/drm/i915/gem/i915_gemfs.c | 28 ++++++++++++++++++++-------
>  1 file changed, 21 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/gpu/drm/i915/gem/i915_gemfs.c b/drivers/gpu/drm/i915/gem/i915_gemfs.c
> index 099f3397aada..cf05ba72df9d 100644
> --- a/drivers/gpu/drm/i915/gem/i915_gemfs.c
> +++ b/drivers/gpu/drm/i915/gem/i915_gemfs.c
> @@ -7,14 +7,17 @@
>  #include <linux/fs.h>
>  #include <linux/mount.h>
>  #include <linux/pagemap.h>
> +#include <linux/fs_context.h>
>  
>  #include "i915_drv.h"
>  #include "i915_gemfs.h"
>  
>  int i915_gemfs_init(struct drm_i915_private *i915)
>  {
> +       struct fs_context *fc = NULL;
>         struct file_system_type *type;
>         struct vfsmount *gemfs;
> +       bool ok = true;

Start with ok = false, we only need to set to true if we succeed in
reconfiguring.

>         type = get_fs_type("tmpfs");
>         if (!type)
> @@ -36,18 +39,29 @@ int i915_gemfs_init(struct drm_i915_private *i915)
>                 struct super_block *sb = gemfs->mnt_sb;
>                 /* FIXME: Disabled until we get W/A for read BW issue. */
>                 char options[] = "huge=never";
> -               int flags = 0;
> -               int err;

Hmm, we could avoid this if we used vfs_kernel_mount() directly rather
than the kern_mount wrapper, as then we pass options through to
parse_monotithic_mount_data(). Or am I barking up the wrong tree?

>  
> -               err = sb->s_op->remount_fs(sb, &flags, options);
> -               if (err) {
> -                       kern_unmount(gemfs);
> -                       return err;
> +               fc = fs_context_for_reconfigure(sb->s_root, 0, 0);
> +               if (IS_ERR(fc)) {
> +                       ok = false;
> +                       goto out;
>                 }
> +
> +               if (!fc->ops->parse_monolithic ||
> +                               fc->ops->parse_monolithic(fc, options)) {

checkpatch.pl will complain that this should line up with the '('

> +                       ok = false;
> +                       goto out;
> +               }
> +
> +               if (!fc->ops->reconfigure || fc->ops->reconfigure(fc))
> +                       ok = false;
>         }
>  
> +out:
> +       if (!ok)
> +               pr_err("i915 gemfs reconfiguration failed\n");

Let's make it a bit more user friendly,

dev_err(i915->drm.dev,
	"Unable to reconfigure internal shmemfs for preferred"
	" allocation strategy; continuing, but performance may suffer.\n");

Assuming that we can't just use vfs_kern_mount() instead, with the nits
Reviewed-by: Chris Wilson <chris@chris-wilson.co.uk>
-Chris
