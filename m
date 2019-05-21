Return-Path: <SRS0=9PYC=TV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 34E20C04AAF
	for <linux-kernel@archiver.kernel.org>; Tue, 21 May 2019 11:14:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 13FED217D4
	for <linux-kernel@archiver.kernel.org>; Tue, 21 May 2019 11:14:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727967AbfEULOC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 May 2019 07:14:02 -0400
Received: from mga17.intel.com ([192.55.52.151]:21636 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726042AbfEULOC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 May 2019 07:14:02 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga107.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 21 May 2019 04:14:01 -0700
X-ExtLoop1: 1
Received: from asaudi-mobl.ger.corp.intel.com (HELO [10.249.47.52]) ([10.249.47.52])
  by orsmga005.jf.intel.com with ESMTP; 21 May 2019 04:13:59 -0700
Subject: Re: [PATCH 32/33] fbcon: Document what I learned about fbcon locking
To:     Daniel Vetter <daniel.vetter@ffwll.ch>,
        DRI Development <dri-devel@lists.freedesktop.org>
Cc:     Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Intel Graphics Development <intel-gfx@lists.freedesktop.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Yisheng Xie <ysxie@foxmail.com>,
        Hans de Goede <hdegoede@redhat.com>,
        Daniel Vetter <daniel.vetter@intel.com>
References: <20190520082216.26273-1-daniel.vetter@ffwll.ch>
 <20190520082216.26273-33-daniel.vetter@ffwll.ch>
From:   Maarten Lankhorst <maarten.lankhorst@linux.intel.com>
Message-ID: <4ce4193c-5140-a833-28d9-72b3d673da73@linux.intel.com>
Date:   Tue, 21 May 2019 13:13:58 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190520082216.26273-33-daniel.vetter@ffwll.ch>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Op 20-05-2019 om 10:22 schreef Daniel Vetter:
> It's not pretty.
>
> Signed-off-by: Daniel Vetter <daniel.vetter@intel.com>
> Cc: Daniel Vetter <daniel.vetter@ffwll.ch>
> Cc: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
> Cc: Hans de Goede <hdegoede@redhat.com>
> Cc: Yisheng Xie <ysxie@foxmail.com>
> ---
>  drivers/video/fbdev/core/fbcon.c | 19 +++++++++++++++++++
>  1 file changed, 19 insertions(+)
>
> diff --git a/drivers/video/fbdev/core/fbcon.c b/drivers/video/fbdev/core/fbcon.c
> index b40b56702c61..cbbcf7a795f2 100644
> --- a/drivers/video/fbdev/core/fbcon.c
> +++ b/drivers/video/fbdev/core/fbcon.c
> @@ -87,6 +87,25 @@
>  #  define DPRINTK(fmt, args...)
>  #endif
>  
> +/*
> + * FIXME: Locking
> + *
> + * - fbcon state itself is protected by the console_lock, and the code does a
> + *   pretty good job at making sure that lock is held everywhere it's needed.
> + *
> + * - access to the registered_fb array is entirely unprotected. This should use
> + *   proper object lifetime handling, i.e. get/put_fb_info. This also means
> + *   switching from indices to proper pointers for fb_info everywhere.
> + *
> + * - fbcon doesn't bother with fb_lock/unlock at all. This is buggy, since it
> + *   means concurrent access to the same fbdev from both fbcon and userspace
> + *   will blow up. To fix this all fbcon calls from fbmem.c need to be moved out
> + *   of fb_lock/unlock protected sections, since otherwise we'll recurse and
> + *   deadlock eventually. Aside: Due to these deadlock issues the fbdev code in
> + *   fbmem.c cannot use locking asserts, and there's lots of callers which get
> + *   the rules wrong, e.g. fbsysfs.c entirely missed fb_lock/unlock calls too.
> + */
> +
>  enum {
>  	FBCON_LOGO_CANSHOW	= -1,	/* the logo can be shown */
>  	FBCON_LOGO_DRAW		= -2,	/* draw the logo to a console */

I did a casual review, so for whole series with the small nitpicks I had, and any feedback by others, kbuild and the arm mess being fixed up:

Reviewed-by: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>

However, according to reviewer's statement of oversight:

While I have reviewed the patch and believe it to be sound, I do not (unless explicitly stated elsewhere)
make any warranties or guarantees that it will achieve its stated purpose or function properly in any given situation.

:)

~Maarten

