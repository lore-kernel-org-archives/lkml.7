Return-Path: <SRS0=WT+Y=ZE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A4125C43331
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Nov 2019 06:28:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 753352067B
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Nov 2019 06:28:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="HR9AGHyY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726376AbfKLG2X (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Nov 2019 01:28:23 -0500
Received: from mail-pf1-f193.google.com ([209.85.210.193]:43686 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725795AbfKLG2X (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Nov 2019 01:28:23 -0500
Received: by mail-pf1-f193.google.com with SMTP id 3so12591028pfb.10
        for <linux-kernel@vger.kernel.org>; Mon, 11 Nov 2019 22:28:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=iAL+4Mb+bihLwcbbUJQManyIi0HMq8FS6irH7b5rRco=;
        b=HR9AGHyYy2UyvvEwb96MgtYOJsg0vdjPcRAqywN8KNqqP4V6g+ZSCV/WD941rThPYl
         MAiDAn47ObgTr175cJScgIpsBf9LZ8Bx5Jw4p5vr6HYg+i6En/TlpBsCZ05TjZTF3uQZ
         xK5JAmH3TUZV7KekreIkJWeTAj+xuor82PCZc7LGvb3RT4fKF9OkaRA4wONEvhuPMnNS
         Pi1qLSjmrTYGeu88D+mLRpoj3tmI8Bl+pai6mh2j8x32NyV2lfrb2b/NFo4a1+0ky8Bj
         BfRHNloJSBoe2UUSJwEigmR8hfUfgqNIY2feikVGqCvlUUI3osAyerOOkNPGXm2KFIMv
         ygkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=iAL+4Mb+bihLwcbbUJQManyIi0HMq8FS6irH7b5rRco=;
        b=NZTQJjR/BNHy4lUBYtjEW8zdZTMrWN8dtWvm414DZnDQJLdtDjslhB1tYNU04vfvCB
         vOBhcu4m+o0JEMR5zjM1OblPnDOUEIHYD5jd18Nq+IHNyvLWrBqMpqHk0su67sl+IVuN
         gwcxHnOokOdUJZGPL66zfHxB09tCTkMq2f0QIb/IzDY2GRgD6+nAxbokWQgc6G1AqmTd
         AKEiyj2WVXguM3SxTBUnAVbvuo0dZf7L5PeREdYT4QqW9MUKtpGtfJEJL2uK/+TpmRJD
         IiTZtLutupjVh3GAJjiPe2+J6zDLWvDI82uEldBbbF3yXiM+kX0qa9pUKVT1qbwnW9Xy
         0l7g==
X-Gm-Message-State: APjAAAWBJ7OLXj1AmgTAGO3XRhRcC1mYqG9rDU1zWQkuZobpbV9gL8V1
        619b0465b14s/9IAws/6RFr+iA==
X-Google-Smtp-Source: APXvYqwTFvsGpfht34NVHjjcAtJ51bzZyaVTKPPTGApX4yc+88RyqobogAUQBkRncC4z2VMigW6V2w==
X-Received: by 2002:a63:cf45:: with SMTP id b5mr32848687pgj.36.1573540102283;
        Mon, 11 Nov 2019 22:28:22 -0800 (PST)
Received: from builder (104-188-17-28.lightspeed.sndgca.sbcglobal.net. [104.188.17.28])
        by smtp.gmail.com with ESMTPSA id j14sm15828464pfi.168.2019.11.11.22.28.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Nov 2019 22:28:21 -0800 (PST)
Date:   Mon, 11 Nov 2019 22:28:19 -0800
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Tero Kristo <t-kristo@ti.com>
Cc:     ohad@wizery.com, linux-remoteproc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org,
        s-anna@ti.com
Subject: Re: [PATCH 17/17] remoteproc/omap: fix auto-suspend failure warning
 during crashed state
Message-ID: <20191112062819.GQ3108315@builder>
References: <20191028124238.19224-1-t-kristo@ti.com>
 <20191028124238.19224-18-t-kristo@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191028124238.19224-18-t-kristo@ti.com>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon 28 Oct 05:42 PDT 2019, Tero Kristo wrote:

> From: Suman Anna <s-anna@ti.com>
> 
> The runtime autosuspend on a OMAP remoteproc device is attempted when
> the suspend timer expires (autosuspend delay elapsed since the last
> time the device is busy). This is the normal autosuspend scenario
> for a device functioning normally. This timer can also expire during
> the debugging of a remoteproc crash when the remoteproc recovery is
> disabled. This is an invalid pre-condition though, so check for the
> RPROC_CRASHED state and bail out before the actual check for the
> RPROC_RUNNING state. The auto-suspend is also not re-attempted until
> the remoteproc is recovered and restored to normal functional state.
> 
> Signed-off-by: Suman Anna <s-anna@ti.com>
> Signed-off-by: Tero Kristo <t-kristo@ti.com>

This should be folded back into the previous patch (which I have yet to
review).

Regards,
Bjorn

> ---
>  drivers/remoteproc/omap_remoteproc.c | 5 +++++
>  1 file changed, 5 insertions(+)
> 
> diff --git a/drivers/remoteproc/omap_remoteproc.c b/drivers/remoteproc/omap_remoteproc.c
> index 2eb05d7a4dec..1dfac82224f7 100644
> --- a/drivers/remoteproc/omap_remoteproc.c
> +++ b/drivers/remoteproc/omap_remoteproc.c
> @@ -945,6 +945,11 @@ static int omap_rproc_runtime_suspend(struct device *dev)
>  	struct omap_rproc *oproc = rproc->priv;
>  	int ret;
>  
> +	if (rproc->state == RPROC_CRASHED) {
> +		dev_dbg(dev, "rproc cannot be runtime suspended when crashed!\n");
> +		return -EBUSY;
> +	}
> +
>  	if (WARN_ON(rproc->state != RPROC_RUNNING)) {
>  		dev_err(dev, "rproc cannot be runtime suspended when not running!\n");
>  		return -EBUSY;
> -- 
> 2.17.1
> 
> --
> Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki. Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki
