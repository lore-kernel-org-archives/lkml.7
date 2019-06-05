Return-Path: <SRS0=eu/B=UE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1B73C28CC5
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Jun 2019 12:23:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7D919206C3
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Jun 2019 12:23:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=ffwll.ch header.i=@ffwll.ch header.b="JA89mj9L"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727820AbfFEMXC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Jun 2019 08:23:02 -0400
Received: from mail-ed1-f67.google.com ([209.85.208.67]:43040 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727337AbfFEMXB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Jun 2019 08:23:01 -0400
Received: by mail-ed1-f67.google.com with SMTP id w33so5471965edb.10
        for <linux-kernel@vger.kernel.org>; Wed, 05 Jun 2019 05:23:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=sender:date:from:to:cc:subject:message-id:mail-followup-to
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=kn7L2PqRa1fGEOO9Zxax19qGHTC2cJnJMInOPgMzeKs=;
        b=JA89mj9LtX/N7h/odMfvFdmQTVWkpB+/hAE8l3AaDFbfhzVkI0Oy43kpxX8jQpzBEt
         SbBr0vvdZFJRPGbB/VO47hbZ0Nhs+ROK46P1Gf1TALc3nVYUUrKgWDDv65ETI3G7aeUF
         Vizn5WJyb8jur9B45ljnu7e1s6ik1ATeJT+x4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :in-reply-to:user-agent;
        bh=kn7L2PqRa1fGEOO9Zxax19qGHTC2cJnJMInOPgMzeKs=;
        b=bEFgYK/L8JQ1UJiTqZYuVX4YvWaqYq1XzU8De08yu98f94xGjbtLQxbzxfTol/3CO2
         f17aa6u6DGs7JdVH9cDO/5dqu8U5/iXjzQDZdOxrOlG64pPRaMQ/e/7jD6ZeT0On7bpC
         zfDgFfiC37gv10IJW7RKwqanJIs6JURTaeh6Xg19kTt46NctW57YIOTCrZhD2AlHqVhb
         dsA1P3MrdopKC1DRzYJtlIcbrOsKLahWMfFib0XHvdcfiyWoBXEq6eBx5LipkCzIy7cO
         3d4Rf9oUSVBzoyN0nN0EwPCJGqlovWBT3qi1QD7xZ4B4kCs82V+2hsNWsDVnV1t8vZJB
         MREQ==
X-Gm-Message-State: APjAAAUp6Q/wsiiGwB0wLXuVvlDhlaMLIMI7sXq0wV/iFvyqkJZAlGex
        3nNQwMrreHExli/BZq+Mbzr1wQ==
X-Google-Smtp-Source: APXvYqxSH/zkD/h6sKRvHharGsaYNwbos67OvbuVupAmgBDFYXgLxqjWvfdInzHGD1vuxOUTsRjoww==
X-Received: by 2002:a05:6402:1819:: with SMTP id g25mr33808810edy.56.1559737379986;
        Wed, 05 Jun 2019 05:22:59 -0700 (PDT)
Received: from phenom.ffwll.local ([2a02:168:569e:0:3106:d637:d723:e855])
        by smtp.gmail.com with ESMTPSA id r9sm5062445eds.61.2019.06.05.05.22.58
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 05 Jun 2019 05:22:59 -0700 (PDT)
Date:   Wed, 5 Jun 2019 14:22:57 +0200
From:   Daniel Vetter <daniel@ffwll.ch>
To:     Rodrigo Siqueira <rodrigosiqueiramelo@gmail.com>
Cc:     Simon Ser <simon.ser@intel.com>,
        Ville Syrjala <ville.syrjala@linux.intel.com>,
        Shayenne Moura <shayenneluzmoura@gmail.com>,
        Haneen Mohammed <hamohammed.sa@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        David Airlie <airlied@linux.ie>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        18oliveira.charles@gmail.com
Subject: Re: [PATCH V2] drm/vkms: Avoid extra discount in the timestamp value
Message-ID: <20190605122257.GQ21222@phenom.ffwll.local>
Mail-Followup-To: Rodrigo Siqueira <rodrigosiqueiramelo@gmail.com>,
        Simon Ser <simon.ser@intel.com>,
        Ville Syrjala <ville.syrjala@linux.intel.com>,
        Shayenne Moura <shayenneluzmoura@gmail.com>,
        Haneen Mohammed <hamohammed.sa@gmail.com>,
        David Airlie <airlied@linux.ie>, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, 18oliveira.charles@gmail.com
References: <20190605024543.pcsnkf74mmgfhtuh@smtp.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190605024543.pcsnkf74mmgfhtuh@smtp.gmail.com>
X-Operating-System: Linux phenom 4.14.0-3-amd64 
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 04, 2019 at 11:45:43PM -0300, Rodrigo Siqueira wrote:
> After the commit def35e7c5926 ("drm/vkms: Bugfix extra vblank frame")
> some of the crc tests started to fail in the vkms with the following
> error:
> 
>  [drm:drm_crtc_add_crc_entry [drm]] *ERROR* Overflow of CRC buffer,
>     userspace reads too slow.
>  [drm] failed to queue vkms_crc_work_handle
>  ...
> 
> The aforementioned commit fixed the extra vblank added by
> `drm_crtc_arm_vblank_event()` which is invoked inside
> `vkms_crtc_atomic_flush()` if the vblank event count was zero, otherwise
> `drm_crtc_send_vblank_event()` is invoked. The fix was implemented in
> `vkms_get_vblank_timestamp()` by subtracting one period from the current
> timestamp, as the code snippet below illustrates:
> 
>  if (!in_vblank_irq)
>   *vblank_time -= output->period_ns;
> 
> The above fix works well when `drm_crtc_arm_vblank_event()` is invoked.
> However, it does not properly work when `drm_crtc_send_vblank_event()`
> executes since it subtracts the correct timestamp, which it shouldn't.
> In this case, the `drm_crtc_accurate_vblank_count()` function will
> returns the wrong frame number, which generates the aforementioned
> error. Such decrease in `get_vblank_timestamp()` produce a negative
> number in the following calculation within `drm_update_vblank_count()`:
> 
>  u64 diff_ns = ktime_to_ns(ktime_sub(t_vblank, vblank->time));
> 
> After this operation, the DIV_ROUND_CLOSEST_ULL macro is invoked using
> diff_ns with a negative number, which generates an undefined result;
> therefore, the returned frame is a huge and incorrect number. Finally,
> the code below is part of the `vkms_crc_work_handle()`, note that the
> while loop depends on the returned value from
> `drm_crtc_accurate_vblank_count()` which may cause the loop to take a
> long time to finish in case of huge value.
> 
>  frame_end = drm_crtc_accurate_vblank_count(crtc);
>  while (frame_start <= frame_end)
>    drm_crtc_add_crc_entry(crtc, true, frame_start++, &crc32);
> 
> This commit fixes this issue by checking if the vblank timestamp
> corresponding to the current software vblank counter is equal to the
> current vblank; if they are equal, it means that
> `drm_crtc_send_vblank_event()` was invoked and vkms does not need to
> discount the extra vblank, otherwise, `drm_crtc_arm_vblank_event()` was
> executed and vkms have to discount the extra vblank. This fix made the
> CRC tests work again whereas keep all tests from kms_flip working as
> well.
> 
> V2: Update commit message
> 
> Signed-off-by: Rodrigo Siqueira <rodrigosiqueiramelo@gmail.com>
> Signed-off-by: Shayenne Moura <shayenneluzmoura@gmail.com>

Thanks a lot for typing up this commit message. I'm still not following
what's going on (this stuff is tricky), but now I think I can at least ask
useful scenarios.

For my understanding: Things go wrong when in the function
vkms_crtc_atomic_flush() the call to drm_crtc_vblank_get() returns 0, and
we call drm_crtc_send_vblank_event() directly? I'm not 100% from your
description above whether that's the failure case where everything blows
up.

The other part I'm having a hard time understanding: If we are in the case
where we call drm_crtc_send_vblank_event() directly, how do we end up in
the vkms_get_vblank_timestamp().

From what I can see there's not caller to where we sample a new vblank ...
I think a full backtrace that hits the new condition you're adding to
understand when exactly we're hitting it would be perfect.

> ---
>  drivers/gpu/drm/vkms/vkms_crtc.c | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/drivers/gpu/drm/vkms/vkms_crtc.c b/drivers/gpu/drm/vkms/vkms_crtc.c
> index 7508815fac11..3ce60e66673e 100644
> --- a/drivers/gpu/drm/vkms/vkms_crtc.c
> +++ b/drivers/gpu/drm/vkms/vkms_crtc.c
> @@ -74,9 +74,13 @@ bool vkms_get_vblank_timestamp(struct drm_device *dev, unsigned int pipe,
>  {
>  	struct vkms_device *vkmsdev = drm_device_to_vkms_device(dev);
>  	struct vkms_output *output = &vkmsdev->output;
> +	struct drm_vblank_crtc *vblank = &dev->vblank[pipe];
>  
>  	*vblank_time = output->vblank_hrtimer.node.expires;
>  
> +	if (*vblank_time == vblank->time)
> +		return true;

Ok, I think with the above I do now have a rough idea what's going wrong.
I think that would be a bug in the drm_vblank.c. Or at least it could be,
I think I first need to better understand still what's going on here to
decided that.

I have a bit a hunch this is fallout from our vblank fudging, but I guess
we'll see.

It's definitely clear that things blow up if the vblank time somehow goes
backwards, but I don't understand yet how that's possible.
-Daniel
> +
>  	if (!in_vblank_irq)
>  		*vblank_time -= output->period_ns;
>  
> -- 
> 2.21.0
> 



-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
