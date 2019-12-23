Return-Path: <SRS0=RKSG=2N=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9AD21C2D0C0
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Dec 2019 07:18:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6A792206B7
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Dec 2019 07:18:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="NznDysF8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726096AbfLWHSM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 23 Dec 2019 02:18:12 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:23564 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725810AbfLWHSL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Dec 2019 02:18:11 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1577085489;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=XrZFkYYJptZsmxyAq9UkEXBJmk/eEjdSUd1aUCGeQuQ=;
        b=NznDysF8lg6ySf+hroxoS/r8n5IEpLTaTjZc2OUcmkB3F4HkoGUeje3rjhAXKVnTmghgyJ
        k5qETkO2zq/m+J81sIpUIGmlhyhaWK9zsqfSiBJAaI/Mf23Lh2DAIkC7X2VDOiYjXZsfB4
        VTJVZkSbvFmj0qFbIt2wvXBFT1dUHiA=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-147-rUqu22B6OWmAb62Zm5x5DA-1; Mon, 23 Dec 2019 02:18:06 -0500
X-MC-Unique: rUqu22B6OWmAb62Zm5x5DA-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 2B034800C7F;
        Mon, 23 Dec 2019 07:18:05 +0000 (UTC)
Received: from localhost.localdomain (ovpn-12-202.pek2.redhat.com [10.72.12.202])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 7452775754;
        Mon, 23 Dec 2019 07:17:56 +0000 (UTC)
Subject: Re: [v2] drm/i915: Assume 100% brightness when not in DPCD control
 mode
To:     Lyude Paul <lyude@redhat.com>, intel-gfx@lists.freedesktop.org
Cc:     David Airlie <airlied@linux.ie>, linux-kernel@vger.kernel.org,
        dri-devel@lists.freedesktop.org
References: <20191203224236.230930-1-lyude@redhat.com>
From:   Perr Yuan <pyuan@redhat.com>
Message-ID: <690de0cf-362b-c826-e607-e12fc403aca9@redhat.com>
Date:   Mon, 23 Dec 2019 02:17:54 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.3.0
MIME-Version: 1.0
In-Reply-To: <20191203224236.230930-1-lyude@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/3/19 5:42 PM, Lyude Paul wrote:
> Currently we always determine the initial panel brightness level by
> simply reading the value from DP_EDP_BACKLIGHT_BRIGHTNESS_MSB/LSB. This
> seems wrong though, because if the panel is not currently in DPCD
> control mode there's not really any reason why there would be any
> brightness value programmed in the first place.
> 
> This appears to be the case on the Lenovo ThinkPad X1 Extreme 2nd
> Generation, where the default value in these registers is always 0 on
> boot despite the fact the panel runs at max brightness by default.
> Getting the initial brightness value correct here is important as well,
> since the panel on this laptop doesn't behave well if it's ever put into
> DPCD control mode while the brightness level is programmed to 0.
> 
> So, let's fix this by checking what the current backlight control mode
> is before reading the brightness level. If it's in DPCD control mode, we
> return the programmed brightness level. Otherwise we assume 100%
> brightness and return the highest possible brightness level. This also
> prevents us from accidentally programming a brightness level of 0.
> 
> This is one of the many fixes that gets backlight controls working on
> the ThinkPad X1 Extreme 2nd Generation with optional 4K AMOLED screen.
> 
> Changes since v1:
> * s/DP_EDP_DISPLAY_CONTROL_REGISTER/DP_EDP_BACKLIGHT_MODE_SET_REGISTER/
>    - Jani
> 
> Signed-off-by: Lyude Paul <lyude@redhat.com>
> ---
>   .../drm/i915/display/intel_dp_aux_backlight.c   | 17 +++++++++++++++++
>   1 file changed, 17 insertions(+)
> 
> diff --git a/drivers/gpu/drm/i915/display/intel_dp_aux_backlight.c b/drivers/gpu/drm/i915/display/intel_dp_aux_backlight.c
> index fad470553cf9..4d467e7d29eb 100644
> --- a/drivers/gpu/drm/i915/display/intel_dp_aux_backlight.c
> +++ b/drivers/gpu/drm/i915/display/intel_dp_aux_backlight.c
> @@ -59,8 +59,25 @@ static u32 intel_dp_aux_get_backlight(struct intel_connector *connector)
>   {
>   	struct intel_dp *intel_dp = enc_to_intel_dp(&connector->encoder->base);
>   	u8 read_val[2] = { 0x0 };
> +	u8 mode_reg;
>   	u16 level = 0;
>   
> +	if (drm_dp_dpcd_readb(&intel_dp->aux,
> +			      DP_EDP_BACKLIGHT_MODE_SET_REGISTER,
> +			      &mode_reg) != 1) {
> +		DRM_DEBUG_KMS("Failed to read the DPCD register 0x%x\n",
> +			      DP_EDP_BACKLIGHT_MODE_SET_REGISTER);
> +		return 0;
> +	}
> +
> +	/*
> +	 * If we're not in DPCD control mode yet, the programmed brightness
> +	 * value is meaningless and we should assume max brightness
> +	 */
> +	if ((mode_reg & DP_EDP_BACKLIGHT_CONTROL_MODE_MASK) !=
> +	    DP_EDP_BACKLIGHT_CONTROL_MODE_DPCD)
> +		return connector->panel.backlight.max;
> +
>   	if (drm_dp_dpcd_read(&intel_dp->aux, DP_EDP_BACKLIGHT_BRIGHTNESS_MSB,
>   			     &read_val, sizeof(read_val)) < 0) {
>   		DRM_DEBUG_KMS("Failed to read DPCD register 0x%x\n",
> 

Tested-by:Perry Yuan <pyuan@redhat.com>

