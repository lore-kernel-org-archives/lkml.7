Return-Path: <SRS0=wu79=TZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DACEAC46460
	for <linux-kernel@archiver.kernel.org>; Sat, 25 May 2019 15:40:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BE4F62168B
	for <linux-kernel@archiver.kernel.org>; Sat, 25 May 2019 15:40:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727121AbfEYPid (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 25 May 2019 11:38:33 -0400
Received: from asavdk3.altibox.net ([109.247.116.14]:41204 "EHLO
        asavdk3.altibox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726971AbfEYPic (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 25 May 2019 11:38:32 -0400
Received: from ravnborg.org (unknown [158.248.194.18])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by asavdk3.altibox.net (Postfix) with ESMTPS id 8CEE0200EF;
        Sat, 25 May 2019 17:38:27 +0200 (CEST)
Date:   Sat, 25 May 2019 17:38:26 +0200
From:   Sam Ravnborg <sam@ravnborg.org>
To:     Daniel Vetter <daniel.vetter@ffwll.ch>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Prarit Bhargava <prarit@redhat.com>,
        Kees Cook <keescook@chromium.org>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Intel Graphics Development <intel-gfx@lists.freedesktop.org>,
        DRI Development <dri-devel@lists.freedesktop.org>,
        Yisheng Xie <ysxie@foxmail.com>,
        Hans de Goede <hdegoede@redhat.com>,
        Daniel Vetter <daniel.vetter@intel.com>,
        Konstantin Khorenko <khorenko@virtuozzo.com>
Subject: Re: [PATCH 09/33] fbcon: Remove fbcon_has_exited
Message-ID: <20190525153826.GA8661@ravnborg.org>
References: <20190524085354.27411-1-daniel.vetter@ffwll.ch>
 <20190524085354.27411-10-daniel.vetter@ffwll.ch>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190524085354.27411-10-daniel.vetter@ffwll.ch>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-CMAE-Score: 0
X-CMAE-Analysis: v=2.3 cv=dqr19Wo4 c=1 sm=1 tr=0
        a=UWs3HLbX/2nnQ3s7vZ42gw==:117 a=UWs3HLbX/2nnQ3s7vZ42gw==:17
        a=jpOVt7BSZ2e4Z31A5e1TngXxSK0=:19 a=kj9zAlcOel0A:10 a=e5mUnYsNAAAA:8
        a=DzVgexfn9IsVGKuEcHIA:9 a=mS0BKyo6H8Xd97p-:21 a=5wqHtdtA96AT7Bqp:21
        a=CjuIK1q_8ugA:10 a=Vxmtnl_E_bksehYqCbjh:22
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Daniel.

One detail I noticed while brosing the changes.

>  
> @@ -1064,9 +1062,13 @@ static void fbcon_init(struct vc_data *vc, int init)
>  	int logo = 1, new_rows, new_cols, rows, cols, charcnt = 256;
>  	int cap, ret;
>  
> -	if (info_idx == -1 || info == NULL)
> +	if (WARN_ON(info_idx == -1))
>  	    return;
>  
> +	if (con2fb_map[vc->vc_num] == -1)
> +		con2fb_map[vc->vc_num] = info_idx;
> +
> +	info = registered_fb[con2fb_map[vc->vc_num]];
>  	cap = info->flags;

When info is defined it is also assigned:
struct fb_info *info = registered_fb[con2fb_map[vc->vc_num]];

As the test for info is gone this assignment is no longer
requrired and can be deleted.

The code now assumes that there is always an fb_info if con2fb_map[]
is not set to -1. I could not determine if this is OK, but this
likely boils down to your locking concern of registered_fb.

	Sam

>  
>  	if (logo_shown < 0 && console_loglevel <= CONSOLE_LOGLEVEL_QUIET)
> @@ -3336,14 +3338,6 @@ static int fbcon_event_notify(struct notifier_block *self,
>  	struct fb_blit_caps *caps;
>  	int idx, ret = 0;
>  
> -	/*
> -	 * ignore all events except driver registration and deregistration
> -	 * if fbcon is not active
> -	 */
> -	if (fbcon_has_exited && !(action == FB_EVENT_FB_REGISTERED ||
> -				  action == FB_EVENT_FB_UNREGISTERED))
> -		goto done;
> -
>  	switch(action) {
>  	case FB_EVENT_SUSPEND:
>  		fbcon_suspended(info);
> @@ -3396,7 +3390,6 @@ static int fbcon_event_notify(struct notifier_block *self,
>  		fbcon_remap_all(idx);
>  		break;
>  	}
> -done:
>  	return ret;
>  }
>  
> @@ -3443,9 +3436,6 @@ static ssize_t store_rotate(struct device *device,
>  	int rotate, idx;
>  	char **last = NULL;
>  
> -	if (fbcon_has_exited)
> -		return count;
> -
>  	console_lock();
>  	idx = con2fb_map[fg_console];
>  
> @@ -3468,9 +3458,6 @@ static ssize_t store_rotate_all(struct device *device,
>  	int rotate, idx;
>  	char **last = NULL;
>  
> -	if (fbcon_has_exited)
> -		return count;
> -
>  	console_lock();
>  	idx = con2fb_map[fg_console];
>  
> @@ -3491,9 +3478,6 @@ static ssize_t show_rotate(struct device *device,
>  	struct fb_info *info;
>  	int rotate = 0, idx;
>  
> -	if (fbcon_has_exited)
> -		return 0;
> -
>  	console_lock();
>  	idx = con2fb_map[fg_console];
>  
> @@ -3514,9 +3498,6 @@ static ssize_t show_cursor_blink(struct device *device,
>  	struct fbcon_ops *ops;
>  	int idx, blink = -1;
>  
> -	if (fbcon_has_exited)
> -		return 0;
> -
>  	console_lock();
>  	idx = con2fb_map[fg_console];
>  
> @@ -3543,9 +3524,6 @@ static ssize_t store_cursor_blink(struct device *device,
>  	int blink, idx;
>  	char **last = NULL;
>  
> -	if (fbcon_has_exited)
> -		return count;
> -
>  	console_lock();
>  	idx = con2fb_map[fg_console];
>  
> @@ -3668,9 +3646,6 @@ static void fbcon_exit(void)
>  	struct fb_info *info;
>  	int i, j, mapped;
>  
> -	if (fbcon_has_exited)
> -		return;
> -
>  #ifdef CONFIG_FRAMEBUFFER_CONSOLE_DEFERRED_TAKEOVER
>  	if (deferred_takeover) {
>  		dummycon_unregister_output_notifier(&fbcon_output_nb);
> @@ -3695,7 +3670,7 @@ static void fbcon_exit(void)
>  		for (j = first_fb_vc; j <= last_fb_vc; j++) {
>  			if (con2fb_map[j] == i) {
>  				mapped = 1;
> -				break;
> +				con2fb_map[j] = -1;
>  			}
>  		}
>  
> @@ -3718,8 +3693,6 @@ static void fbcon_exit(void)
>  				info->queue.func = NULL;
>  		}
>  	}
> -
> -	fbcon_has_exited = 1;
>  }
>  
>  void __init fb_console_init(void)
> -- 
> 2.20.1
> 
> _______________________________________________
> dri-devel mailing list
> dri-devel@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/dri-devel
