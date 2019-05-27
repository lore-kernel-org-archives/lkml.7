Return-Path: <SRS0=8QAT=T3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BFE2AC07542
	for <linux-kernel@archiver.kernel.org>; Mon, 27 May 2019 06:10:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7AA0A2075E
	for <linux-kernel@archiver.kernel.org>; Mon, 27 May 2019 06:10:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=ffwll.ch header.i=@ffwll.ch header.b="Z+eTylDr"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726183AbfE0GKs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 May 2019 02:10:48 -0400
Received: from mail-ed1-f68.google.com ([209.85.208.68]:40356 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725907AbfE0GKs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 May 2019 02:10:48 -0400
Received: by mail-ed1-f68.google.com with SMTP id j12so24983639eds.7
        for <linux-kernel@vger.kernel.org>; Sun, 26 May 2019 23:10:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=sender:date:from:to:cc:subject:message-id:mail-followup-to
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=aHQcZA86QadOz+hqte+kGa5A/aXSBOF9jgEN8JYF4HM=;
        b=Z+eTylDr8v0NnqgdFOxT1FsB+Gv/PP4fKMnQokTae0Nh6mADuZnJH5r9rleXV/+6NP
         CHmTMRs3RV7wt5U1LiOWfNYHss2hDXFFuXDLBEQSqOKgpzz0sQvchRSC8h/GQJsRIagy
         JdmFva87UC/Rh7hBX51Sp2WcMN/L9yZQ9fA6M=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :in-reply-to:user-agent;
        bh=aHQcZA86QadOz+hqte+kGa5A/aXSBOF9jgEN8JYF4HM=;
        b=EpZezh7MuZfuFlK8EE2wTkYXvoAJfgHVVXE5Dqt/zoEJqGth9aG8pZMv8PiW2i6DQm
         HHYHFgOILGKgylnnAYskx4xN2m6FHFzakR/G8AS1OH4jz+LJfOcvCDerP+woIyCAddTk
         2adOrB9+/TJM9GW92/6B7ouBwO5o5f0tuFZ+P9cKP98ZoVBVgY4NF5vacFRiKGha1jPZ
         hONgXR/kVQalYJpzp64NQ6ukkZUx5bjxE+8Qw4yu/9AEE77sIWIHeijbBxbFCINxmtb2
         mWiMiuel/ADhCVtgE7U4esU4D26R6rL+JJNwmNI5cPMmuEU/nr/SfWy3EWeChox2b2Ft
         SS3Q==
X-Gm-Message-State: APjAAAV97ZH02dY58Z9Gi+TcFvu5qUOk3dEgsMNSV/1dxAHarw7M0jDe
        BAulxXxqtbXeWz3ts1fMoLExVQ==
X-Google-Smtp-Source: APXvYqw5DeaRhyIeIlB5ezWdqfd/I3KorqeJKmhUNN+wTqwQrdBepsfLJvMmK2DS7vWCzfiPR73EWg==
X-Received: by 2002:a17:906:5e16:: with SMTP id n22mr53158605eju.28.1558937446036;
        Sun, 26 May 2019 23:10:46 -0700 (PDT)
Received: from phenom.ffwll.local ([2a02:168:569e:0:3106:d637:d723:e855])
        by smtp.gmail.com with ESMTPSA id h8sm1570633ejf.73.2019.05.26.23.10.44
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 26 May 2019 23:10:45 -0700 (PDT)
Date:   Mon, 27 May 2019 08:10:42 +0200
From:   Daniel Vetter <daniel@ffwll.ch>
To:     Sam Ravnborg <sam@ravnborg.org>
Cc:     Daniel Vetter <daniel.vetter@ffwll.ch>,
        LKML <linux-kernel@vger.kernel.org>,
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
Message-ID: <20190527061042.GF21222@phenom.ffwll.local>
Mail-Followup-To: Sam Ravnborg <sam@ravnborg.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Prarit Bhargava <prarit@redhat.com>,
        Kees Cook <keescook@chromium.org>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Intel Graphics Development <intel-gfx@lists.freedesktop.org>,
        DRI Development <dri-devel@lists.freedesktop.org>,
        Yisheng Xie <ysxie@foxmail.com>,
        Hans de Goede <hdegoede@redhat.com>,
        Daniel Vetter <daniel.vetter@intel.com>,
        Konstantin Khorenko <khorenko@virtuozzo.com>
References: <20190524085354.27411-1-daniel.vetter@ffwll.ch>
 <20190524085354.27411-10-daniel.vetter@ffwll.ch>
 <20190525153826.GA8661@ravnborg.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190525153826.GA8661@ravnborg.org>
X-Operating-System: Linux phenom 4.14.0-3-amd64 
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, May 25, 2019 at 05:38:26PM +0200, Sam Ravnborg wrote:
> Hi Daniel.
> 
> One detail I noticed while brosing the changes.
> 
> >  
> > @@ -1064,9 +1062,13 @@ static void fbcon_init(struct vc_data *vc, int init)
> >  	int logo = 1, new_rows, new_cols, rows, cols, charcnt = 256;
> >  	int cap, ret;
> >  
> > -	if (info_idx == -1 || info == NULL)
> > +	if (WARN_ON(info_idx == -1))
> >  	    return;
> >  
> > +	if (con2fb_map[vc->vc_num] == -1)
> > +		con2fb_map[vc->vc_num] = info_idx;
> > +
> > +	info = registered_fb[con2fb_map[vc->vc_num]];
> >  	cap = info->flags;
> 
> When info is defined it is also assigned:
> struct fb_info *info = registered_fb[con2fb_map[vc->vc_num]];
> 
> As the test for info is gone this assignment is no longer
> requrired and can be deleted.

We use it later on, so we definitely still need info. But I indeed forgot
to delete the initial assignment of info at the function start. Is that
what you mean here?
>
> The code now assumes that there is always an fb_info if con2fb_map[]
> is not set to -1. I could not determine if this is OK, but this
> likely boils down to your locking concern of registered_fb.

Yup, see how fb_registered/unregistered manage this. I think that part
actually all works out correctly (as long as everyone is holding
console_lock). But it's a bit unpretty that fbcon digs around in the raw
registered_fb array instead of going through the refcounted helpers, and
having a full refcounted pointer. Much easier to convince yourself of that
than chasing indices assigments all over imo.
-Daniel

> 
> 	Sam
> 
> >  
> >  	if (logo_shown < 0 && console_loglevel <= CONSOLE_LOGLEVEL_QUIET)
> > @@ -3336,14 +3338,6 @@ static int fbcon_event_notify(struct notifier_block *self,
> >  	struct fb_blit_caps *caps;
> >  	int idx, ret = 0;
> >  
> > -	/*
> > -	 * ignore all events except driver registration and deregistration
> > -	 * if fbcon is not active
> > -	 */
> > -	if (fbcon_has_exited && !(action == FB_EVENT_FB_REGISTERED ||
> > -				  action == FB_EVENT_FB_UNREGISTERED))
> > -		goto done;
> > -
> >  	switch(action) {
> >  	case FB_EVENT_SUSPEND:
> >  		fbcon_suspended(info);
> > @@ -3396,7 +3390,6 @@ static int fbcon_event_notify(struct notifier_block *self,
> >  		fbcon_remap_all(idx);
> >  		break;
> >  	}
> > -done:
> >  	return ret;
> >  }
> >  
> > @@ -3443,9 +3436,6 @@ static ssize_t store_rotate(struct device *device,
> >  	int rotate, idx;
> >  	char **last = NULL;
> >  
> > -	if (fbcon_has_exited)
> > -		return count;
> > -
> >  	console_lock();
> >  	idx = con2fb_map[fg_console];
> >  
> > @@ -3468,9 +3458,6 @@ static ssize_t store_rotate_all(struct device *device,
> >  	int rotate, idx;
> >  	char **last = NULL;
> >  
> > -	if (fbcon_has_exited)
> > -		return count;
> > -
> >  	console_lock();
> >  	idx = con2fb_map[fg_console];
> >  
> > @@ -3491,9 +3478,6 @@ static ssize_t show_rotate(struct device *device,
> >  	struct fb_info *info;
> >  	int rotate = 0, idx;
> >  
> > -	if (fbcon_has_exited)
> > -		return 0;
> > -
> >  	console_lock();
> >  	idx = con2fb_map[fg_console];
> >  
> > @@ -3514,9 +3498,6 @@ static ssize_t show_cursor_blink(struct device *device,
> >  	struct fbcon_ops *ops;
> >  	int idx, blink = -1;
> >  
> > -	if (fbcon_has_exited)
> > -		return 0;
> > -
> >  	console_lock();
> >  	idx = con2fb_map[fg_console];
> >  
> > @@ -3543,9 +3524,6 @@ static ssize_t store_cursor_blink(struct device *device,
> >  	int blink, idx;
> >  	char **last = NULL;
> >  
> > -	if (fbcon_has_exited)
> > -		return count;
> > -
> >  	console_lock();
> >  	idx = con2fb_map[fg_console];
> >  
> > @@ -3668,9 +3646,6 @@ static void fbcon_exit(void)
> >  	struct fb_info *info;
> >  	int i, j, mapped;
> >  
> > -	if (fbcon_has_exited)
> > -		return;
> > -
> >  #ifdef CONFIG_FRAMEBUFFER_CONSOLE_DEFERRED_TAKEOVER
> >  	if (deferred_takeover) {
> >  		dummycon_unregister_output_notifier(&fbcon_output_nb);
> > @@ -3695,7 +3670,7 @@ static void fbcon_exit(void)
> >  		for (j = first_fb_vc; j <= last_fb_vc; j++) {
> >  			if (con2fb_map[j] == i) {
> >  				mapped = 1;
> > -				break;
> > +				con2fb_map[j] = -1;
> >  			}
> >  		}
> >  
> > @@ -3718,8 +3693,6 @@ static void fbcon_exit(void)
> >  				info->queue.func = NULL;
> >  		}
> >  	}
> > -
> > -	fbcon_has_exited = 1;
> >  }
> >  
> >  void __init fb_console_init(void)
> > -- 
> > 2.20.1
> > 
> > _______________________________________________
> > dri-devel mailing list
> > dri-devel@lists.freedesktop.org
> > https://lists.freedesktop.org/mailman/listinfo/dri-devel

-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
