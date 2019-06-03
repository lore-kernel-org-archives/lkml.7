Return-Path: <SRS0=cV2B=UC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNPARSEABLE_RELAY autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 18F16C04AB5
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Jun 2019 20:13:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D6A9A26CBF
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Jun 2019 20:13:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726736AbfFCUNr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Jun 2019 16:13:47 -0400
Received: from bhuna.collabora.co.uk ([46.235.227.227]:36348 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726173AbfFCUNq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Jun 2019 16:13:46 -0400
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: koike)
        with ESMTPSA id 23EA8276DCD
Subject: Re: [PATCH v4 1/5] drm/rockchip: fix fb references in async update
To:     dri-devel@lists.freedesktop.org, nicholas.kazlauskas@amd.com
Cc:     andrey.grodzovsky@amd.com, daniel.vetter@ffwll.ch,
        linux-kernel@vger.kernel.org, Tomasz Figa <tfiga@chromium.org>,
        boris.brezillon@collabora.com, David Airlie <airlied@linux.ie>,
        Sean Paul <seanpaul@google.com>, kernel@collabora.com,
        harry.wentland@amd.com,
        =?UTF-8?Q?St=c3=a9phane_Marchesin?= <marcheu@google.com>,
        Sandy Huang <hjc@rock-chips.com>,
        linux-rockchip@lists.infradead.org,
        =?UTF-8?Q?Heiko_St=c3=bcbner?= <heiko@sntech.de>,
        linux-arm-kernel@lists.infradead.org,
        Daniel Vetter <daniel@ffwll.ch>
References: <20190603165610.24614-1-helen.koike@collabora.com>
 <20190603165610.24614-2-helen.koike@collabora.com>
From:   Helen Koike <helen.koike@collabora.com>
Openpgp: preference=signencrypt
Autocrypt: addr=helen.koike@collabora.com; keydata=
 mQINBFmOMD4BEADb2nC8Oeyvklh+ataw2u/3mrl+hIHL4WSWtii4VxCapl9+zILuxFDrxw1p
 XgF3cfx7g9taWBrmLE9VEPwJA6MxaVnQuDL3GXxTxO/gqnOFgT3jT+skAt6qMvoWnhgurMGH
 wRaA3dO4cFrDlLsZIdDywTYcy7V2bou81ItR5Ed6c5UVX7uTTzeiD/tUi8oIf0XN4takyFuV
 Rf09nOhi24bn9fFN5xWHJooFaFf/k2Y+5UTkofANUp8nn4jhBUrIr6glOtmE0VT4pZMMLT63
 hyRB+/s7b1zkOofUGW5LxUg+wqJXZcOAvjocqSq3VVHcgyxdm+Nv0g9Hdqo8bQHC2KBK86VK
 vB+R7tfv7NxVhG1sTW3CQ4gZb0ZugIWS32Mnr+V+0pxci7QpV3jrtVp5W2GA5HlXkOyC6C7H
 Ao7YhogtvFehnlUdG8NrkC3HhCTF8+nb08yGMVI4mMZ9v/KoIXKC6vT0Ykz434ed9Oc9pDow
 VUqaKi3ey96QczfE4NI029bmtCY4b5fucaB/aVqWYRH98Jh8oIQVwbt+pY7cL5PxS7dQ/Zuz
 6yheqDsUGLev1O3E4R8RZ8jPcfCermL0txvoXXIA56t4ZjuHVcWEe2ERhLHFGq5Zw7KC6u12
 kJoiZ6WDBYo4Dp+Gd7a81/WsA33Po0j3tk/8BWoiJCrjXzhtRwARAQABtCdIZWxlbiBLb2lr
 ZSA8aGVsZW4ua29pa2VAY29sbGFib3JhLmNvbT6JAlQEEwEKAD4CGwEFCwkIBwMFFQoJCAsF
 FgIDAQACHgECF4AWIQSofQA6zrItXEgHWTzAfqwo9yFiXQUCXEz3bwUJBKaPRQAKCRDAfqwo
 9yFiXdUCD/4+WZr503hQ13KB4DijOW76ju8JDPp4p++qoPxtoAsld3yROoTI+VPWmt7ojHrr
 TZc7sTLxOFzaUC8HjGTb3r9ilIhIKf/M9KRLkpIJ+iLA+VoUbcSOMYWoVNfgLmbnqoezjPcy
 OHJwVw9dzEeYpvG6nkY6E4UktANySp27AniSXNuHOvYsOsXmUOqU1ScdsrQ9s732p/OGdTyw
 1yd3gUMLZvCKFOBVHILH59HCRJgpwUPiws8G4dGMs4GTRvHT2s2mDQdQ0HEvcM9rvCRVixuC
 5ZeOymZNi6lDIUIysgiZ+yzk6i5l/Ni6r7v20N3JppZvhPK6LqtaYceyAGyc3jjnOqoHT/qR
 kPjCwzmKiPtXjLw6HbRXtGgGtP5m3y8v6bfHH+66zd2vGCY0Z9EsqcnK4DCqRkLncFLPM2gn
 9cZcCmO4ZqXUhTyn1nHM494kd5NX1Op4HO+t9ErnpufkVjoMUeBwESdQwwwHT3rjUueGmCrn
 VJK69/qhA4La72VTxHutl+3Z0Xy20HWsZS8Gsam39f95/LtPLzbBwnOOi5ZoXnm97tF8HrAZ
 2h+kcRLMWw3BXy5q4gic+oFZMZP9oq1G9XTFld4FGgJ9ys8aGmhLM+uB1pFxb3XFtWQ2z4AJ
 iEp2VLl34quwfD6Gg4csiZe2KzvQHUe0w8SJ9LplrHPPprkCDQRZjjChARAAzISLQaHzaDOv
 ZxcoCNBk/hUGo2/gsmBW4KSj73pkStZ+pm3Yv2CRtOD4jBlycXjzhwBV7/70ZMH70/Y25dJa
 CnJKl/Y76dPPn2LDWrG/4EkqUzoJkhRIYFUTpkPdaVYznqLgsho19j7HpEbAum8r3jemYBE1
 AIuVGg4bqY3UkvuHWLVRMuaHZNy55aYwnUvd46E64JH7O990mr6t/nu2a1aJ0BDdi8HZ0RMo
 Eg76Avah+YR9fZrhDFmBQSL+mcCVWEbdiOzHmGYFoToqzM52wsNEpo2aStH9KLk8zrCXGx68
 ohJyQoALX4sS03RIWh1jFjnlw2FCbEdj/HDX0+U0i9COtanm54arYXiBTnAnx0F7LW7pv7sb
 6tKMxsMLmprP/nWyV5AfFRi3jxs5tdwtDDk/ny8WH6KWeLR/zWDwpYgnXLBCdg8l97xUoPQO
 0VkKSa4JEXUZWZx9q6kICzFGsuqApqf9gIFJZwUmirsxH80Fe04Tv+IqIAW7/djYpOqGjSyk
 oaEVNacwLLgZr+/j69/1ZwlbS8K+ChCtyBV4kEPzltSRZ4eU19v6sDND1JSTK9KSDtCcCcAt
 VGFlr4aE00AD/aOkHSylc93nPinBFO4AGhcs4WypZ3GGV6vGWCpJy9svfWsUDhSwI7GS/i/v
 UQ1+bswyYEY1Q3DjJqT7fXcAEQEAAYkEcgQYAQoAJgIbAhYhBKh9ADrOsi1cSAdZPMB+rCj3
 IWJdBQJcTPfVBQkEpo7hAkDBdCAEGQEKAB0WIQSomGMEg78Cd/pMshveCRfNeJ05lgUCWY4w
 oQAKCRDeCRfNeJ05lp0gD/49i95kPKjpgjUbYeidjaWuINXMCA171KyaBAp+Jp2Qrun4sIJB
 Z6srMj6O/gC34AhZln2sXeQdxe88sNbg6HjlN+4AkhTd6DttjOfUwnamLDA7uw+YIapGgsgN
 lznjLnqOaQ9mtEwRbZMUOdyRf9osSuL14vHl4ia3bYNJ52WYre6gLMu4K+Ghd02og+ILgIio
 Q827h0spqIJYHrR3Ynnhxdlv5GPCobh+AKsQMdTIuCzR6JSCBk6GHkg33SiWScKMUzT8B/cn
 ypLfGnfV/LDZ9wS2TMzIlK/uv0Vd4C0OGDd/GCi5Gwu/Ot0aY7fzZo2CiRV+/nJBWPRRBTji
 bE4FG2rt7WSRLO/QmH2meIW4f0USDiHeNwznHkPei59vRdlMyQdsxrmgSRDuX9Y3UkERxbgd
 uscqC8Cpcy5kpF11EW91J8aGpcxASc+5Pa66/+7CrpBC2DnfcfACdMAje7yeMn9XlHrqXNlQ
 GaglEcnGN2qVqRcKgcjJX+ur8l56BVpBPFYQYkYkIdQAuhlPylxOvsMcqI6VoEWNt0iFF3dA
 //0MNb8fEqw5TlxDPOt6BDhDKowkxOGIA9LOcF4PkaR9Qkvwo2P4vA/8fhCnMqlSPom4xYdk
 Ev8P554zDoL/XMHl+s7A0MjIJzT253ejZKlWeO68pAbNy/z7QRn2lFDnjwkQwH6sKPchYl2f
 0g//Yu3vDkqk8+mi2letP3XBl2hjv2eCZjTh34VvtgY5oeL2ROSJWNd18+7O6q3hECZ727EW
 gIb3LK9g4mKF6+Rch6Gwz1Y4fmC5554fd2Y2XbVzzz6AGUC6Y+ohNg7lTAVO4wu43+IyTB8u
 ip5rX/JDGFv7Y1sl6tQJKAVIKAJE+Z3Ncqh3doQr9wWHl0UiQYKbSR9HpH1lmC1C3EEbTpwK
 fUIpZd1eQNyNJl1jHsZZIBYFsAfVNH/u6lB1TU+9bSOsV5SepdIb88d0fm3oZ4KzjhRHLFQF
 RwNUNn3ha6x4fbxYcwbvu5ZCiiX6yRTPoage/LUNkgQNX2PtPcur6CdxK6Pqm8EAI7PmYLfN
 NY3y01XhKNRvaVZoH2FugfUkhsBITglTIpI+n6YU06nDAcbeINFo67TSE0iL6Pek5a6gUQQC
 6w+hJCaMr8KYud0q3ccHyU3TlAPDe10En3GsVz7Y5Sa3ODGdbmkfjK8Af3ogGNBVmpV16Xl8
 4rETFv7POSUB2eMtbpmBopd+wKqHCwUEy3fx1zDbM9mp+pcDoL73rRZmlgmNfW/4o4qBzxRf
 FYTQLE69wAFU2IFce9PjtUAlBdC+6r3X24h3uD+EC37s/vWhxuKj2glaU9ONrVJ/SPvlqXOO
 WR1Zqw57vHMKimLdG3c24l8PkSw1usudgAA5OyO5Ag0EWY4wyQEQAMVp0U38Le7d80Mu6AT+
 1dMes87iKn30TdMuLvSg2uYqJ1T2riRBF7zU6u74HF6zps0rPQviBXOgoSuKa1hnS6OwFb9x
 yQPlk76LY96SUB5jPWJ3fO78ZGSwkVbJFuG9gpD/41n8Unn1hXgDb2gUaxD0oXv/723EmTYC
 vSo3z6Y8A2aBQNr+PyhQAPDazvVQ+P7vnZYq1oK0w+D7aIix/Bp4mo4VbgAeAeMxXWSZs8N5
 NQtXeTBgB7DqrfJP5wWwgCsROfeds6EoddcYgqhG0zVU9E54C8JcPOA0wKVs+9+gt2eyRNtx
 0UhFbah7qXuJGhWy/0CLXvVoCoS+7qpWz070TBAlPZrg9D0o2gOw01trQgoKAYBKKgJhxaX/
 4gzi+5Ccm33LYH9lAVTdzdorejuV1xWdsnNyc8OAPeoXBf9RIIWfQVmbhVXBp2DAPjV6/kIJ
 Eml7MNJfEvqjV9zKsWF9AFlsqDWZDCyUdqR96ahTSD34pRwb6a9H99/GrjeowKaaL95DIVZT
 C6STvDNL6kpys4sOe2AMmQGv2MMcJB3aYLzH8f1sEQ9S0UMX7/6CifEG6JodG6Y/W/lLo1Vv
 DxeDA+u4Lgq6qxlksp8M78FjcmxFVlf4cpCi2ucbZxurhlBkjtZZ8MVAEde3hlqjcBl2Ah6Q
 D826FTxscOGlHEfNABEBAAGJAjwEGAEKACYCGwwWIQSofQA6zrItXEgHWTzAfqwo9yFiXQUC
 XEz31QUJBKaOuQAKCRDAfqwo9yFiXUvnEACBWe8wSnIvSX+9k4LxuLq6GQTOt+RNfliZQkCW
 5lT3KL1IJyzzOm4x+/slHRBl8bF7KEZyOPinXQXyJ/vgIdgSYxDqoZ7YZn3SvuNe4aT6kGwL
 EYYEV8Ecj4ets15FR2jSUNnVv5YHWtZ7bP/oUzr2LT54fjRcstYxgwzoj8AREtHQ4EJWAWCO
 ZuEHTSm5clMFoi41CmG4DlJbzbo4YfilKYm69vwh50Y8WebcRN31jh0g8ufjOJnBldYYBLwN
 Obymhlfy/HKBDIbyCGBuwYoAkoJ6LR/cqzl/FuhwhuDocCGlXyYaJOwXgHaCvVXI3PLQPxWZ
 +vPsD+TSVHc9m/YWrOiYDnZn6aO0Uk1Zv/m9+BBkWAwsreLJ/evn3SsJV1omNBTITG+uxXcf
 JkgmmesIAw8mpI6EeLmReUJLasz8QkzhZIC7t5rGlQI94GQG3Jg2dC+kpaGWOaT5G4FVMcBj
 iR1nXfMxENVYnM5ag7mBZyD/kru5W1Uj34L6AFaDMXFPwedSCpzzqUiHb0f+nYkfOodf5xy0
 46+3THy/NUS/ZZp/rI4F7Y77+MQPVg7vARfHHX1AxYUKfRVW5j88QUB70txn8Vgi1tDrOr4J
 eD+xr0CvIGa5lKqgQacQtGkpOpJ8zY4ObSvpNubey/qYUE3DCXD0n2Xxk4muTvqlkFpOYA==
Message-ID: <aecadca2-f67b-5d9d-550e-f90cbca5fd3f@collabora.com>
Date:   Mon, 3 Jun 2019 17:13:34 -0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190603165610.24614-2-helen.koike@collabora.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 6/3/19 1:56 PM, Helen Koike wrote:
> In the case of async update, modifications are done in place, i.e. in the
> current plane state, so the new_state is prepared and the new_state is
> cleaned up (instead of the old_state, unlike what happens in a
> normal sync update).
> To cleanup the old_fb properly, it needs to be placed in the new_state
> in the end of async_update, so cleanup call will unreference the old_fb
> correctly.
> 
> Also, the previous code had a:
> 
> 	plane_state = plane->funcs->atomic_duplicate_state(plane);
> 	...
> 	swap(plane_state, plane->state);
> 
> 	if (plane->state->fb && plane->state->fb != new_state->fb) {
> 	...
> 	}
> 
> Which was wrong, as the fb were just assigned to be equal, so this if
> statement nevers evaluates to true.
> 
> Another details is that the function drm_crtc_vblank_get() can only be
> called when vop->is_enabled is true, otherwise it has no effect and
> trows a WARN_ON().
> 
> Calling drm_atomic_set_fb_for_plane() (which get a referent of the new
> fb and pus the old fb) is not required, as it is taken care by
> drm_mode_cursor_universal() when calling
> drm_atomic_helper_update_plane().
> 
> Signed-off-by: Helen Koike <helen.koike@collabora.com>

Cc: <stable@vger.kernel.org> # v4.20+
Fixes: 15609559a834 ("drm/rockchip: update cursors asynchronously
through atomic.")

> 
> ---
> Hello,
> 
> I tested on the rockchip ficus v1.1 using igt plane_cursor_legacy and
> kms_cursor_legacy and I didn't see any regressions.
> 
> Changes in v4: None
> Changes in v3:
> - use swap() to swap old and new framebuffers in async_update
> - get the reference to old_fb and set the worker after vop_plane_atomic_update()
> - add a FIXME tag for when we have multiple fbs to be released when
> vblank happens.
> - update commit message
> 
> Changes in v2: None
> 
>  drivers/gpu/drm/rockchip/rockchip_drm_vop.c | 51 +++++++++++----------
>  1 file changed, 26 insertions(+), 25 deletions(-)
> 
> diff --git a/drivers/gpu/drm/rockchip/rockchip_drm_vop.c b/drivers/gpu/drm/rockchip/rockchip_drm_vop.c
> index 4189ca17f381..b7c47d1153c6 100644
> --- a/drivers/gpu/drm/rockchip/rockchip_drm_vop.c
> +++ b/drivers/gpu/drm/rockchip/rockchip_drm_vop.c
> @@ -919,29 +919,17 @@ static void vop_plane_atomic_async_update(struct drm_plane *plane,
>  					  struct drm_plane_state *new_state)
>  {
>  	struct vop *vop = to_vop(plane->state->crtc);
> -	struct drm_plane_state *plane_state;
> -
> -	plane_state = plane->funcs->atomic_duplicate_state(plane);
> -	plane_state->crtc_x = new_state->crtc_x;
> -	plane_state->crtc_y = new_state->crtc_y;
> -	plane_state->crtc_h = new_state->crtc_h;
> -	plane_state->crtc_w = new_state->crtc_w;
> -	plane_state->src_x = new_state->src_x;
> -	plane_state->src_y = new_state->src_y;
> -	plane_state->src_h = new_state->src_h;
> -	plane_state->src_w = new_state->src_w;
> -
> -	if (plane_state->fb != new_state->fb)
> -		drm_atomic_set_fb_for_plane(plane_state, new_state->fb);
> -
> -	swap(plane_state, plane->state);
> -
> -	if (plane->state->fb && plane->state->fb != new_state->fb) {
> -		drm_framebuffer_get(plane->state->fb);
> -		WARN_ON(drm_crtc_vblank_get(plane->state->crtc) != 0);
> -		drm_flip_work_queue(&vop->fb_unref_work, plane->state->fb);
> -		set_bit(VOP_PENDING_FB_UNREF, &vop->pending);
> -	}
> +	struct drm_framebuffer *old_fb = plane->state->fb;
> +
> +	plane->state->crtc_x = new_state->crtc_x;
> +	plane->state->crtc_y = new_state->crtc_y;
> +	plane->state->crtc_h = new_state->crtc_h;
> +	plane->state->crtc_w = new_state->crtc_w;
> +	plane->state->src_x = new_state->src_x;
> +	plane->state->src_y = new_state->src_y;
> +	plane->state->src_h = new_state->src_h;
> +	plane->state->src_w = new_state->src_w;
> +	swap(plane->state->fb, new_state->fb);
>  
>  	if (vop->is_enabled) {
>  		rockchip_drm_psr_inhibit_get_state(new_state->state);
> @@ -950,9 +938,22 @@ static void vop_plane_atomic_async_update(struct drm_plane *plane,
>  		vop_cfg_done(vop);
>  		spin_unlock(&vop->reg_lock);
>  		rockchip_drm_psr_inhibit_put_state(new_state->state);
> -	}
>  
> -	plane->funcs->atomic_destroy_state(plane, plane_state);
> +		/*
> +		 * A scanout can still be occurring, so we can't drop the
> +		 * reference to the old framebuffer. To solve this we get a
> +		 * reference to old_fb and set a worker to release it later.
> +		 * FIXME: if we perform 500 async_update calls before the
> +		 * vblank, then we can have 500 different framebuffers waiting
> +		 * to be released.
> +		 */
> +		if (old_fb && plane->state->fb != old_fb) {
> +			drm_framebuffer_get(old_fb);
> +			WARN_ON(drm_crtc_vblank_get(plane->state->crtc) != 0);
> +			drm_flip_work_queue(&vop->fb_unref_work, old_fb);
> +			set_bit(VOP_PENDING_FB_UNREF, &vop->pending);
> +		}
> +	}
>  }
>  
>  static const struct drm_plane_helper_funcs plane_helper_funcs = {
> 
