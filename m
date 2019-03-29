Return-Path: <SRS0=SA5R=SA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E297C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Mar 2019 21:32:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3816F218A5
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Mar 2019 21:32:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="bNrsUIW7";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="ltnsERQX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730355AbfC2Vcy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 29 Mar 2019 17:32:54 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:58882 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729484AbfC2Vcy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Mar 2019 17:32:54 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id B7274608A5; Fri, 29 Mar 2019 21:32:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1553895173;
        bh=PhCsFxgy8R7wWDJYbbMTYI3h8RZG3q2OUku+6RYM+wU=;
        h=Subject:To:References:From:Date:In-Reply-To:From;
        b=bNrsUIW7TcVWGAaZGTVVhg0wnHFPvhP7GYtRfG0AiUc5sId4qZEFbU/8vimNIfif5
         ZSzhddHy+thiuGku0OPwWe+H0uWiLy1UjnS2c6QJ5kL0Z9r0RwUcI/CC2jyBXnmmWm
         w0j+fcJip2d631j7u6od7f+3NaMJWIvYRTAbxPyc=
Received: from [10.79.168.116] (blr-bdr-fw-01_globalnat_allzones-outside.qualcomm.com [103.229.18.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: mojha@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 2675F60F38;
        Fri, 29 Mar 2019 21:32:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1553895172;
        bh=PhCsFxgy8R7wWDJYbbMTYI3h8RZG3q2OUku+6RYM+wU=;
        h=Subject:To:References:From:Date:In-Reply-To:From;
        b=ltnsERQXEOtVqP+X7qLZGgd0fY67A7vYSiuCv69307CxRYqJT2GfWNYcQvE2Ct8FW
         aeBCLtM9sKIdxe6kAZij6y1sc7kpHr12lP75nF5V2LaxiLWPy2TPpAPPrUlWOMK0QV
         Ue7AlMIJ0h8CmiMBZWmun8xiri1tBX8aL5F2XVBw=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 2675F60F38
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=mojha@codeaurora.org
Subject: Re: [PATCH] drm/stm: ltdc: fix data enable polarity
To:     =?UTF-8?Q?Yannick_Fertr=c3=a9?= <yannick.fertre@st.com>,
        Philippe Cornu <philippe.cornu@st.com>,
        Vincent Abriou <vincent.abriou@st.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@st.com>,
        dri-devel@lists.freedesktop.org,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <1553874620-31468-1-git-send-email-yannick.fertre@st.com>
From:   Mukesh Ojha <mojha@codeaurora.org>
Message-ID: <98a9609b-138b-fc5b-c2b2-46f465c88bab@codeaurora.org>
Date:   Sat, 30 Mar 2019 03:02:41 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <1553874620-31468-1-git-send-email-yannick.fertre@st.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 3/29/2019 9:20 PM, Yannick Fertré wrote:
> Wrong DISPLAY_FLAGS used to set the data enable polarity.
Used or checked?
Can you also explain how it is wrong to check against this FLAG in commit?
>
> Signed-off-by: Yannick Fertré <yannick.fertre@st.com>
> ---
>   drivers/gpu/drm/stm/ltdc.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/stm/ltdc.c b/drivers/gpu/drm/stm/ltdc.c
> index b1741a9..6ba326a 100644
> --- a/drivers/gpu/drm/stm/ltdc.c
> +++ b/drivers/gpu/drm/stm/ltdc.c
> @@ -555,7 +555,7 @@ static void ltdc_crtc_mode_set_nofb(struct drm_crtc *crtc)
>   	if (vm.flags & DISPLAY_FLAGS_VSYNC_HIGH)
>   		val |= GCR_VSPOL;
>   
> -	if (vm.flags & DISPLAY_FLAGS_DE_HIGH)
> +	if (vm.flags & DISPLAY_FLAGS_DE_LOW)
>   		val |= GCR_DEPOL;
>   
>   	if (vm.flags & DISPLAY_FLAGS_PIXDATA_NEGEDGE)
