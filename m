Return-Path: <SRS0=h0iA=UR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25C98C31E5B
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Jun 2019 17:16:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F28132147A
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Jun 2019 17:16:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=poorly.run header.i=@poorly.run header.b="OaDtkN5H"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730167AbfFRRQc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Jun 2019 13:16:32 -0400
Received: from mail-qt1-f193.google.com ([209.85.160.193]:43983 "EHLO
        mail-qt1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729435AbfFRRQc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Jun 2019 13:16:32 -0400
Received: by mail-qt1-f193.google.com with SMTP id w17so9889854qto.10
        for <linux-kernel@vger.kernel.org>; Tue, 18 Jun 2019 10:16:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=poorly.run; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=5HdOkeGTOimtUzxYuQ63HUqEs40RoAuiCtdWAjPZDM0=;
        b=OaDtkN5HFpjGr/oGrGRtE6pafVhMmdq/+VJSFcdz1WobXMuZUUKApbaDiA9vnXK2j3
         M1ZG9xkYjtUHKnUSxIWDICD7d9IOcd3cpxqHPwMwqOnwjKwahWRc8XwbX0PJfKH98415
         37Tsyp4Yhxud4rCL+Rw1GCax0qVqIuAdhttJfj9MfV0epKELmBAAIwOXbAonPiJugOsp
         EhKXuX5lRWnE12UtILOB1cW4SFsisYFxR1LSJ3zLUupulctUeP/CFusTIdpSZD8JLC4E
         dlPL2W1HH03olfJL/RXjzT2piEGtlzgdSpRKJfjApX6sjAnrlenIcMgVNTGyGbpx++rF
         yzsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=5HdOkeGTOimtUzxYuQ63HUqEs40RoAuiCtdWAjPZDM0=;
        b=CasmBIQSJa3VLxZHylyjYpKtegMdDGiCtNPR3930xUo9ypNMOmKDc6hq04it7DlPeX
         9+CdkXCwf5ftM8ZUeNpufk8c0fXL7QN/SHoEC3qOfMMxumsxoli2/mbLurcokjPHXmzT
         whgaTrVA39RNa9Mj/dAV26iLvDuxCQxXTtd818vqFNBqrbH4EkFLMuTgv2NoMFdV3ac1
         boBFT8tv6u48zvmJi7FVX3uy3iN1DfyB/BLSa4u9XyNCN6PZ2bTxaPM2KeI4cY0CdCYJ
         VxwutpWfVLrDTbYGu3W98prLrG0ujxgNDW+hVtSQKmR6YINj1zuJJU9ZZo0s8ZBosDdo
         z1Gg==
X-Gm-Message-State: APjAAAWkwcA/Pot+MGhVMRIz6rMmCq2gyA1xtZ6zv5X7RWXuf4Yk3q27
        muugMr/nRvrv6+CNf9/a4wQoVg==
X-Google-Smtp-Source: APXvYqxHpvdIJ3r1rR8PFVV6pBLc7jwq+5ZT5DwQvMXjzrBn2Est5EPpbCwUxoMEH+iz1jdelPvGnA==
X-Received: by 2002:ac8:2bb3:: with SMTP id m48mr98945689qtm.218.1560878191074;
        Tue, 18 Jun 2019 10:16:31 -0700 (PDT)
Received: from localhost ([2620:0:1013:11:89c6:2139:5435:371d])
        by smtp.gmail.com with ESMTPSA id o71sm8278024qke.18.2019.06.18.10.16.30
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Tue, 18 Jun 2019 10:16:30 -0700 (PDT)
Date:   Tue, 18 Jun 2019 13:16:29 -0400
From:   Sean Paul <sean@poorly.run>
To:     Dan Carpenter <dan.carpenter@oracle.com>
Cc:     Al Viro <viro@zeniv.linux.org.uk>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Sean Paul <sean@poorly.run>, David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        kernel-janitors@vger.kernel.org
Subject: Re: [PATCH v2] drm: return -EFAULT if copy_to_user() fails
Message-ID: <20190618171629.GB25413@art_vandelay>
References: <20190618125623.GA24896@mwanda>
 <20190618131843.GA29463@mwanda>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190618131843.GA29463@mwanda>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 18, 2019 at 04:18:43PM +0300, Dan Carpenter wrote:
> The copy_from_user() function returns the number of bytes remaining
> to be copied but we want to return a negative error code.  Otherwise
> the callers treat it as a successful copy.
> 
> Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>

Thanks Dan, I've applied this to drm-misc-fixes.

Sean

> ---
> v2: The first version was missing a chunk
> 
>  drivers/gpu/drm/drm_bufs.c  | 5 ++++-
>  drivers/gpu/drm/drm_ioc32.c | 5 ++++-
>  2 files changed, 8 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/gpu/drm/drm_bufs.c b/drivers/gpu/drm/drm_bufs.c
> index 68dacf8422c6..8ce9d73fab4f 100644
> --- a/drivers/gpu/drm/drm_bufs.c
> +++ b/drivers/gpu/drm/drm_bufs.c
> @@ -1351,7 +1351,10 @@ static int copy_one_buf(void *data, int count, struct drm_buf_entry *from)
>  				 .size = from->buf_size,
>  				 .low_mark = from->low_mark,
>  				 .high_mark = from->high_mark};
> -	return copy_to_user(to, &v, offsetof(struct drm_buf_desc, flags));
> +
> +	if (copy_to_user(to, &v, offsetof(struct drm_buf_desc, flags)))
> +		return -EFAULT;
> +	return 0;
>  }
>  
>  int drm_legacy_infobufs(struct drm_device *dev, void *data,
> diff --git a/drivers/gpu/drm/drm_ioc32.c b/drivers/gpu/drm/drm_ioc32.c
> index 586aa28024c5..a16b6dc2fa47 100644
> --- a/drivers/gpu/drm/drm_ioc32.c
> +++ b/drivers/gpu/drm/drm_ioc32.c
> @@ -378,7 +378,10 @@ static int copy_one_buf32(void *data, int count, struct drm_buf_entry *from)
>  			      .size = from->buf_size,
>  			      .low_mark = from->low_mark,
>  			      .high_mark = from->high_mark};
> -	return copy_to_user(to + count, &v, offsetof(drm_buf_desc32_t, flags));
> +
> +	if (copy_to_user(to + count, &v, offsetof(drm_buf_desc32_t, flags)))
> +		return -EFAULT;
> +	return 0;
>  }
>  
>  static int drm_legacy_infobufs32(struct drm_device *dev, void *data,
> -- 
> 2.20.1
> 

-- 
Sean Paul, Software Engineer, Google / Chromium OS
