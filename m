Return-Path: <SRS0=/BGd=SD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E37AC43381
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Apr 2019 11:14:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 09E0F2133D
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Apr 2019 11:14:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726858AbfDALOm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Apr 2019 07:14:42 -0400
Received: from lb3-smtp-cloud8.xs4all.net ([194.109.24.29]:43822 "EHLO
        lb3-smtp-cloud8.xs4all.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725882AbfDALOm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Apr 2019 07:14:42 -0400
Received: from [192.168.2.10] ([212.251.195.8])
        by smtp-cloud8.xs4all.net with ESMTPA
        id AutfhgiBGUjKfAutih4eY1; Mon, 01 Apr 2019 13:14:39 +0200
Subject: Re: [PATCH v14 5/6] au0828: fix enable and disable source audio and
 video inconsistencies
To:     Shuah Khan <shuah@kernel.org>, mchehab@kernel.org, perex@perex.cz,
        tiwai@suse.com
Cc:     linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        alsa-devel@alsa-project.org
References: <cover.1553909892.git.shuah@kernel.org>
 <a314cc4fbfa5ae928cd9f13b8e16046e38418273.1553909893.git.shuah@kernel.org>
From:   Hans Verkuil <hverkuil@xs4all.nl>
Message-ID: <b67b2a75-ef2a-08df-c67c-c14bd9e33303@xs4all.nl>
Date:   Mon, 1 Apr 2019 13:14:35 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <a314cc4fbfa5ae928cd9f13b8e16046e38418273.1553909893.git.shuah@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-CMAE-Envelope: MS4wfNJ6fFKeRE6p8qq3Fos6jLxDQgCCF3eFz0lSPPpoN+RkhPI5L2m5QOejnsGJ6jSlNvqYqEh1dJDM4ZkSaC3NpReh4z9d66ks7gvwE4kFCPJ+nYOESp0W
 v4zJhF4FlIAqR6J+6FNgasNI8pKEidIddQYOgIiePsVFVnHmw0A/vPhk4ksfQoJcFHRuIhV6wztrKszPn0tgmHdmYXHb6YDTRRl3crzHIjlytCmL4l/RAWVl
 1a9tplA/wxLXbh6/GSkA6Uw5JX5kYDrzQQiQaObUXtWrTz0b9vATLs6T9SKkmQNADyK5Fd914NQn9Nz3FOxbVufkipu4secF+1qj7lcerCA2u4v3AN6RIWo3
 YJYkuL4NerzK7gZSzddDNO1yS2hSZw==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Shuah,

On 3/30/19 2:54 AM, Shuah Khan wrote:
> Enable and disable source interfaces aren't consistent in enforcing
> how video and audio share the tuner resource.
> 
> Fix these issues to enforce the following rules and allow
> sharing between audio and video applications.
> 
> - When DVB is streaming, audio/video/vbi/s-video/composite
>   should find the resource busy. DVB holds the tuner in
>   exclusive mode.
> - When video is streaming, audio can share the tuner and vice versa.
> - v4l2 allows multiple applications to open video device.
> - Video applications call enable source multiple times during their
>   run-time. Resource should stay locked until the last application
>   releases it.
> - A shared resource should stay in shared state and locked when it is
>   in use by audio and video. More than one video application is allowed
>   to use the tuner as long as video streaming protocol allows such usage.
>   Resource is released when the last video/audio application releases it.
> - S-Video and Composite hold the resource in exclusive mode.
> - VBI allows more than vbi applications sharing and will not share
>   with another type. When resource is locked by VBI and in use by
>   multiple VBI applications, it should stay locked until the last
>   application disables it.

This isn't correct: only one application at most can stream VBI, but
VBI can be shared with video and audio streaming.

All three come from the same source (analog TV), so as long as one of
these is streaming the analog tuner resource is in use.

With this patch it seems that streaming VBI blocks streaming audio/video
and vice versa. That's wrong.

Otherwise everything looks OK, except for a typo below.

> 
> Signed-off-by: Shuah Khan <shuah@kernel.org>
> ---
>  drivers/media/usb/au0828/au0828-core.c | 182 +++++++++++++++++++------
>  drivers/media/usb/au0828/au0828.h      |   5 +-
>  2 files changed, 148 insertions(+), 39 deletions(-)
> 
> diff --git a/drivers/media/usb/au0828/au0828-core.c b/drivers/media/usb/au0828/au0828-core.c
> index 4f8ba6f64d3c..b8bcab2fa1dc 100644
> --- a/drivers/media/usb/au0828/au0828-core.c
> +++ b/drivers/media/usb/au0828/au0828-core.c
> @@ -272,6 +272,27 @@ static void au0828_media_graph_notify(struct media_entity *new,
>  	}
>  }
>  
> +static bool au0828_is_link_sharable(struct media_entity *owner,
> +				    struct media_entity *entity)
> +{
> +	bool sharable = false;

typo: sharable -> shareable

Also in the function name: do a search-and-replace for this.

> +
> +	/* Tuner link can be shared by audio and video */

add: and VBI

I think the core issue is here since VBI should be included with
IO_V4L and AUDIO_CAPTURE.

> +	switch (owner->function) {
> +	case MEDIA_ENT_F_IO_V4L:
> +	case MEDIA_ENT_F_AUDIO_CAPTURE:
> +		if (entity->function == MEDIA_ENT_F_IO_V4L ||
> +		    entity->function == MEDIA_ENT_F_AUDIO_CAPTURE)
> +			sharable = true;
> +		break;
> +	case MEDIA_ENT_F_DTV_DEMOD:
> +	case MEDIA_ENT_F_IO_VBI:
> +	default:
> +		break;
> +	}
> +	return sharable;

I hacked this function so VBI is included with IO_V4L/AUDIO_CAPTURE
and now it works.

There is one remaining issue (but that was always a problem with au0828):
when streaming is in progress from both video and vbi, and then you stop
the video streaming, then vbi stops as well.

au0828_stop_streaming() calls v4l2_device_call_all(&dev->v4l2_dev, 0, video, s_stream, 0);
which it should only do when the last user disappears. I'll post a patch
for au0828 to fix this.

Regards,

	Hans

> +}
> +
>  /* Callers should hold graph_mutex */
>  static int au0828_enable_source(struct media_entity *entity,
>  				struct media_pipeline *pipe)
> @@ -314,18 +335,20 @@ static int au0828_enable_source(struct media_entity *entity,
>  		/*
>  		 * Default input is tuner and default input_type
>  		 * is AU0828_VMUX_TELEVISION.
> -		 * FIXME:
> +		 *
>  		 * There is a problem when s_input is called to
>  		 * change the default input. s_input will try to
>  		 * enable_source before attempting to change the
>  		 * input on the device, and will end up enabling
>  		 * default source which is tuner.
>  		 *
> -		 * Additional logic is necessary in au0828
> -		 * to detect that the input has changed and
> -		 * enable the right source.
> +		 * Additional logic is necessary in au0828 to detect
> +		 * that the input has changed and enable the right
> +		 * source. au0828 handles this case in its s_input.
> +		 * It will disable the old source and enable the new
> +		 * source.
> +		 *
>  		*/
> -
>  		if (dev->input_type == AU0828_VMUX_TELEVISION)
>  			find_source = dev->tuner;
>  		else if (dev->input_type == AU0828_VMUX_SVIDEO ||
> @@ -338,27 +361,33 @@ static int au0828_enable_source(struct media_entity *entity,
>  		}
>  	}
>  
> -	/* Is an active link between sink and source */
> +	/* Is there an active link between sink and source */
>  	if (dev->active_link) {
> -		/*
> -		 * If DVB is using the tuner and calling entity is
> -		 * audio/video, the following check will be false,
> -		 * since sink is different. Result is Busy.
> -		 */
> -		if (dev->active_link->sink->entity == sink &&
> -		    dev->active_link->source->entity == find_source) {
> -			/*
> -			 * Either ALSA or Video own tuner. sink is
> -			 * the same for both. Prevent Video stepping
> -			 * on ALSA when ALSA owns the source.
> +		if (dev->active_link_owner == entity) {
> +			/* This check is necessary to handle multiple
> +			 * enable_source calls from v4l_ioctls during
> +			 * the course of video/vbi application run-time.
>  			*/
> -			if (dev->active_link_owner != entity &&
> -			    dev->active_link_owner->function ==
> -						MEDIA_ENT_F_AUDIO_CAPTURE) {
> -				pr_debug("ALSA has the tuner\n");
> -				ret = -EBUSY;
> -				goto end;
> -			}
> +			pr_debug("%s already owns the tuner\n", entity->name);
> +			ret = 0;
> +			goto end;
> +		} else if (au0828_is_link_sharable(dev->active_link_owner,
> +			   entity)) {
> +			/* Either ALSA or Video own tuner. Sink is the same
> +			 * for both. Allow sharing the active link between
> +			 * their common source (tuner) and sink (decoder).
> +			 * Starting pipeline between sharing entity and sink
> +			 * will fail with pipe mismatch, while owner has an
> +			 * active pipeline. Switch pipeline ownership from
> +			 * user to owner when owner disables the source.
> +			 */
> +			dev->active_link_shared = true;
> +			/* save the user info to use from disable */
> +			dev->active_link_user = entity;
> +			dev->active_link_user_pipe = pipe;
> +			pr_debug("%s owns the tuner %s can share!\n",
> +				 dev->active_link_owner->name,
> +				 entity->name);
>  			ret = 0;
>  			goto end;
>  		} else {
> @@ -385,7 +414,7 @@ static int au0828_enable_source(struct media_entity *entity,
>  	source = found_link->source->entity;
>  	ret = __media_entity_setup_link(found_link, MEDIA_LNK_FL_ENABLED);
>  	if (ret) {
> -		pr_err("Activate tuner link %s->%s. Error %d\n",
> +		pr_err("Activate link from %s->%s. Error %d\n",
>  			source->name, sink->name, ret);
>  		goto end;
>  	}
> @@ -395,25 +424,26 @@ static int au0828_enable_source(struct media_entity *entity,
>  		pr_err("Start Pipeline: %s->%s Error %d\n",
>  			source->name, entity->name, ret);
>  		ret = __media_entity_setup_link(found_link, 0);
> -		pr_err("Deactivate link Error %d\n", ret);
> +		if (ret)
> +			pr_err("Deactivate link Error %d\n", ret);
>  		goto end;
>  	}
> -	/*
> -	 * save active link and active link owner to avoid audio
> -	 * deactivating video owned link from disable_source and
> -	 * vice versa
> +
> +	/* save link state to allow audio and video share the link
> +	 * and not disable the link while the other is using it.
> +	 * active_link_owner is used to deactivate the link.
>  	*/
>  	dev->active_link = found_link;
>  	dev->active_link_owner = entity;
>  	dev->active_source = source;
>  	dev->active_sink = sink;
>  
> -	pr_debug("Enabled Source: %s->%s->%s Ret %d\n",
> +	pr_info("Enabled Source: %s->%s->%s Ret %d\n",
>  		 dev->active_source->name, dev->active_sink->name,
>  		 dev->active_link_owner->name, ret);
>  end:
> -	pr_debug("au0828_enable_source() end %s %d %d\n",
> -		 entity->name, entity->function, ret);
> +	pr_debug("%s end: ent:%s fnc:%d ret %d\n",
> +		 __func__, entity->name, entity->function, ret);
>  	return ret;
>  }
>  
> @@ -432,21 +462,95 @@ static void au0828_disable_source(struct media_entity *entity)
>  	if (!dev->active_link)
>  		return;
>  
> -	/* link is active - stop pipeline from source (tuner) */
> +	/* link is active - stop pipeline from source
> +	 * (tuner/s-video/Composite) to the entity
> +	 * When DVB/s-video/Composite owns tuner, it won't be in
> +	 * shared state.
> +	 */
>  	if (dev->active_link->sink->entity == dev->active_sink &&
>  	    dev->active_link->source->entity == dev->active_source) {
>  		/*
> -		 * prevent video from deactivating link when audio
> -		 * has active pipeline
> +		 * Prevent video from deactivating link when audio
> +		 * has active pipeline and vice versa. In addition
> +		 * handle the case when more than one video/vbi
> +		 * application is sharing the link.
>  		*/
> +		bool owner_is_audio = false;
> +
> +		if (dev->active_link_owner->function ==
> +		    MEDIA_ENT_F_AUDIO_CAPTURE)
> +			owner_is_audio = true;
> +
> +		if (dev->active_link_shared) {
> +			pr_debug("Shared link owner %s user %s %d\n",
> +				 dev->active_link_owner->name,
> +				 entity->name, dev->users);
> +
> +			/* Handle video device users > 1
> +			 * When audio owns the shared link with
> +			 * more than one video users, avoid
> +			 * disabling the source and/or switching
> +			 * the owner until the last disable_source
> +			 * call from video _close(). Use dev->users to
> +			 * determine when to switch/disable.
> +			 */
> +			if (dev->active_link_owner != entity) {
> +				/* video device has users > 1 */
> +				if (owner_is_audio && dev->users > 1)
> +					return;
> +
> +				dev->active_link_user = NULL;
> +				dev->active_link_user_pipe = NULL;
> +				dev->active_link_shared = false;
> +				return;
> +			}
> +
> +			/* video owns the link and has users > 1 */
> +			if (!owner_is_audio && dev->users > 1)
> +				return;
> +
> +			/* stop pipeline */
> +			__media_pipeline_stop(dev->active_link_owner);
> +			pr_debug("Pipeline stop for %s\n",
> +				dev->active_link_owner->name);
> +
> +			ret = __media_pipeline_start(
> +					dev->active_link_user,
> +					dev->active_link_user_pipe);
> +			if (ret) {
> +				pr_err("Start Pipeline: %s->%s %d\n",
> +					dev->active_source->name,
> +					dev->active_link_user->name,
> +					ret);
> +				goto deactivate_link;
> +			}
> +			/* link user is now the owner */
> +			dev->active_link_owner = dev->active_link_user;
> +			dev->active_link_user = NULL;
> +			dev->active_link_user_pipe = NULL;
> +			dev->active_link_shared = false;
> +
> +			pr_debug("Pipeline started for %s\n",
> +				dev->active_link_owner->name);
> +			return;
> +		} else if (!owner_is_audio && dev->users > 1)
> +			/* video/vbi owns the link and has users > 1 */
> +			return;
> +
>  		if (dev->active_link_owner != entity)
>  			return;
> -		__media_pipeline_stop(entity);
> +
> +		/* stop pipeline */
> +		__media_pipeline_stop(dev->active_link_owner);
> +		pr_debug("Pipeline stop for %s\n",
> +			dev->active_link_owner->name);
> +
> +deactivate_link:
>  		ret = __media_entity_setup_link(dev->active_link, 0);
>  		if (ret)
>  			pr_err("Deactivate link Error %d\n", ret);
>  
> -		pr_debug("Disabled Source: %s->%s->%s Ret %d\n",
> +		pr_info("Disabled Source: %s->%s->%s Ret %d\n",
>  			 dev->active_source->name, dev->active_sink->name,
>  			 dev->active_link_owner->name, ret);
>  
> @@ -454,6 +558,8 @@ static void au0828_disable_source(struct media_entity *entity)
>  		dev->active_link_owner = NULL;
>  		dev->active_source = NULL;
>  		dev->active_sink = NULL;
> +		dev->active_link_shared = false;
> +		dev->active_link_user = NULL;
>  	}
>  }
>  #endif
> diff --git a/drivers/media/usb/au0828/au0828.h b/drivers/media/usb/au0828/au0828.h
> index 57b00de8d3f2..b47ecc9affd8 100644
> --- a/drivers/media/usb/au0828/au0828.h
> +++ b/drivers/media/usb/au0828/au0828.h
> @@ -284,9 +284,12 @@ struct au0828_dev {
>  	struct media_entity_notify entity_notify;
>  	struct media_entity *tuner;
>  	struct media_link *active_link;
> -	struct media_entity *active_link_owner;
>  	struct media_entity *active_source;
>  	struct media_entity *active_sink;
> +	struct media_entity *active_link_owner;
> +	struct media_entity *active_link_user;
> +	struct media_pipeline *active_link_user_pipe;
> +	bool active_link_shared;
>  #endif
>  };
>  
> 

