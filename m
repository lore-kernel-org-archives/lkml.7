Return-Path: <SRS0=uyI7=RK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1BCC5C43381
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Mar 2019 15:34:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D0C302064A
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Mar 2019 15:34:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="m62O4zbY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726592AbfCGPe1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 Mar 2019 10:34:27 -0500
Received: from mail-ed1-f68.google.com ([209.85.208.68]:43815 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726207AbfCGPe0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Mar 2019 10:34:26 -0500
Received: by mail-ed1-f68.google.com with SMTP id m35so13802758ede.10
        for <linux-kernel@vger.kernel.org>; Thu, 07 Mar 2019 07:34:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=t2MGgvxLUTFnVnM7xv3E6lyhv+MbDe/9QXewZIH0oMU=;
        b=m62O4zbY8eLXy0QO/wjxponHiRkc/fFjo8dfl+3dcfaZTVgOWhj9WDMf7NeYDuLBwP
         uMd5edPIv7C4KbKgFkwb+ljJKcdI3znyNxSzzutNxUYXLXd9eptrL37TgJse3NgzjXdF
         7mDmScki482+FyCRc/8rHaAoDMI+Rpg6jVbGgE/7A93fIbiojussAVA0ix5gGewNhrSV
         zMK+Tj1lMXSzi0jGdoKlkQGrKh2MEJ582/3d84g817RhlnUvA5dlYW6XJncM4X7OHDBX
         DdWhCtN7CJcH6TTfJ4AZAAs/jdhWCiTtBuNIMvYATYLP9fjoWWua6zHV+1sw9XLujPWs
         LWAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=t2MGgvxLUTFnVnM7xv3E6lyhv+MbDe/9QXewZIH0oMU=;
        b=M0SZKfabjQbFgC4yUnGuk+leLgDVRCLotFnsyCDrp/mESGFSu1cQn0P+d9tplvqttD
         Gkgfr8yqK2SFWGsYFSqMvSBcVOoth1oWy73v1hwzBw4WIqFXOfek3DwWoDyc9VuMEFWf
         idNkoB4Goku4RyMnGAN89iXCrUT11i3QX8pxSYiZkX+LeIc477nB/MI9U/KQje0utJSc
         XOGLkmKTxHuaw4Tua5v/8SHTYuDw14T+uuz3Wf/sUmnBv7IfZeBfNFMte5nztISGkQwx
         cbdTkuLCZHlQQQ6/6KzeYtTdxA6Tr6tUA6avuKSMQ8Tc92uzb+xBDjARjRSfBPAiILrD
         LncA==
X-Gm-Message-State: APjAAAU83UyucbNyQdGixsgQdoBBQFJ4rsg1OqMFuhW3iWwscsixAuGY
        E10LnrGlElIU05IbYss5PY8=
X-Google-Smtp-Source: APXvYqwxyGRUwnAcpYG8cDvjf8I0wCI+zDrIBoZuVrQnzVFqvKxNwwpBGZq3RITukZHfA+3J8jawJw==
X-Received: by 2002:a50:be42:: with SMTP id b2mr28540236edi.78.1551972863583;
        Thu, 07 Mar 2019 07:34:23 -0800 (PST)
Received: from archlinux-ryzen ([2a01:4f9:2a:1fae::2])
        by smtp.gmail.com with ESMTPSA id b10sm1396997edy.80.2019.03.07.07.34.21
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Thu, 07 Mar 2019 07:34:22 -0800 (PST)
Date:   Thu, 7 Mar 2019 08:34:20 -0700
From:   Nathan Chancellor <natechancellor@gmail.com>
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Harry Wentland <harry.wentland@amd.com>,
        Leo Li <sunpeng.li@amd.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>,
        "David (ChunMing) Zhou" <David1.Zhou@amd.com>,
        Nick Desaulniers <ndesaulniers@google.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Anthony Koo <Anthony.Koo@amd.com>, Aric Cyr <Aric.Cyr@amd.com>,
        Harmanprit Tatla <Harmanprit.Tatla@amd.com>,
        Ken Chalmers <ken.chalmers@amd.com>,
        SivapiriyanKumarasamy <sivapiriyan.kumarasamy@amd.com>,
        Kees Cook <keescook@chromium.org>,
        Bayan Zabihiyan <Bayan.Zabihiyan@amd.com>,
        Tony Cheng <Tony.Cheng@amd.com>, amd-gfx@lists.freedesktop.org,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] drm/amd/display: avoid passing enum as NULL pointer
Message-ID: <20190307153420.GJ20201@archlinux-ryzen>
References: <20190307103454.1637485-1-arnd@arndb.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190307103454.1637485-1-arnd@arndb.de>
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 07, 2019 at 11:34:29AM +0100, Arnd Bergmann wrote:
> The mod_freesync_build_vrr_infopacket() function uses rather obscure
> calling conventions, where an enum is passed in through a pointer,
> and a NULL pointer is expected to behave the same way as the zero-value
> (TRANSFER_FUNC_UNKNOWN).
> 
> Trying to build this with clang results in a warning:
> 
> drivers/gpu/drm/amd/amdgpu/../display/amdgpu_dm/amdgpu_dm.c:4601:3: error: expression which evaluates to zero treated
>       as a null pointer constant of type 'const enum color_transfer_func *' [-Werror,-Wnon-literal-null-conversion]
> 
> Passing it by value instead of by reference makes the code simpler
> and more conventional but should not change the behavior at all.
> 
> Fixes: c2791297013e ("drm/amd/display: Add color bit info to freesync infoframe")
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---
>  drivers/gpu/drm/amd/display/modules/freesync/freesync.c | 7 +++----
>  drivers/gpu/drm/amd/display/modules/inc/mod_freesync.h  | 2 +-
>  2 files changed, 4 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/display/modules/freesync/freesync.c b/drivers/gpu/drm/amd/display/modules/freesync/freesync.c
> index 94a84bc57c7a..6f32fe129880 100644
> --- a/drivers/gpu/drm/amd/display/modules/freesync/freesync.c
> +++ b/drivers/gpu/drm/amd/display/modules/freesync/freesync.c
> @@ -724,7 +724,7 @@ static void build_vrr_infopacket_v1(enum signal_type signal,
>  
>  static void build_vrr_infopacket_v2(enum signal_type signal,
>  		const struct mod_vrr_params *vrr,
> -		const enum color_transfer_func *app_tf,
> +		const enum color_transfer_func app_tf,
>  		struct dc_info_packet *infopacket)
>  {
>  	unsigned int payload_size = 0;
> @@ -732,8 +732,7 @@ static void build_vrr_infopacket_v2(enum signal_type signal,
>  	build_vrr_infopacket_header_v2(signal, infopacket, &payload_size);
>  	build_vrr_infopacket_data(vrr, infopacket);
>  
> -	if (app_tf != NULL)
> -		build_vrr_infopacket_fs2_data(*app_tf, infopacket);
> +	build_vrr_infopacket_fs2_data(app_tf, infopacket);
>  
>  	build_vrr_infopacket_checksum(&payload_size, infopacket);
>  
> @@ -757,7 +756,7 @@ void mod_freesync_build_vrr_infopacket(struct mod_freesync *mod_freesync,
>  		const struct dc_stream_state *stream,
>  		const struct mod_vrr_params *vrr,
>  		enum vrr_packet_type packet_type,
> -		const enum color_transfer_func *app_tf,
> +		const enum color_transfer_func app_tf,
>  		struct dc_info_packet *infopacket)
>  {
>  	/* SPD info packet for FreeSync
> diff --git a/drivers/gpu/drm/amd/display/modules/inc/mod_freesync.h b/drivers/gpu/drm/amd/display/modules/inc/mod_freesync.h
> index 4222e403b151..645793b924cf 100644
> --- a/drivers/gpu/drm/amd/display/modules/inc/mod_freesync.h
> +++ b/drivers/gpu/drm/amd/display/modules/inc/mod_freesync.h
> @@ -145,7 +145,7 @@ void mod_freesync_build_vrr_infopacket(struct mod_freesync *mod_freesync,
>  		const struct dc_stream_state *stream,
>  		const struct mod_vrr_params *vrr,
>  		enum vrr_packet_type packet_type,
> -		const enum color_transfer_func *app_tf,
> +		const enum color_transfer_func app_tf,
>  		struct dc_info_packet *infopacket);
>  
>  void mod_freesync_build_vrr_params(struct mod_freesync *mod_freesync,
> -- 
> 2.20.0
> 

Just as an FYI, I sent the same fix when the warning first hit which was
recently accepted:

https://cgit.freedesktop.org/~agd5f/linux/commit/?id=672e78cab819ebe31e3b9b8abac367be8a110472

Just waiting for it to hit mainline.

Cheers,
Nathan
