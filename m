Return-Path: <SRS0=SA5R=SA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D607C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Mar 2019 21:32:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 64C64218A2
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Mar 2019 21:32:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="RL/qVJmU";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="oe6a5eDQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730340AbfC2Vcf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 29 Mar 2019 17:32:35 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:57616 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729484AbfC2Vce (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Mar 2019 17:32:34 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 633A7609F3; Fri, 29 Mar 2019 21:32:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1553895154;
        bh=W1dfBQbJ2rGkzNjIYaC6yrTHgfmS19PFXm/qOdNQq1s=;
        h=Subject:To:References:From:Date:In-Reply-To:From;
        b=RL/qVJmUGkLlvcH9MmUOIjDA9PLWDxp4WVLD4oO30GvEj7CqshIhlCmM+Q9gYMKrN
         lHH/g9W3QHlEZyUU4au0MqGvwn3F9/qR/Wc8q5u0ydaDlT74bW995/7kweH8Vphw7h
         rhAIKqGnBJJ5LvZsfLTNEK+NZQL4tV+tK2n4SLPQ=
Received: from [10.79.168.116] (blr-bdr-fw-01_globalnat_allzones-outside.qualcomm.com [103.229.18.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: mojha@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id CD7D46053B;
        Fri, 29 Mar 2019 21:32:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1553895153;
        bh=W1dfBQbJ2rGkzNjIYaC6yrTHgfmS19PFXm/qOdNQq1s=;
        h=Subject:To:References:From:Date:In-Reply-To:From;
        b=oe6a5eDQSi9/P0hkBBThlvdaCjGwsJVssdf9EYzH8K2DbFoQxKIUnMtmg3g001upl
         OX7b1XqCyyjKe70YzDV7xyNixjGNZb4i92ak14v2uTqPUEa4gkUbvA9e3DAsKzoOR1
         f+8EKBOPnHheyDqvgK29aTDaV8RdZt786yQ7HqhA=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org CD7D46053B
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
Message-ID: <d8f5e6ff-8240-632d-a711-070937f13342@codeaurora.org>
Date:   Sat, 30 Mar 2019 03:02:23 +0530
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
Used or checked.
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
