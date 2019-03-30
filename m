Return-Path: <SRS0=yJb2=SB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8648EC43381
	for <linux-kernel@archiver.kernel.org>; Sat, 30 Mar 2019 11:58:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 485EB217F5
	for <linux-kernel@archiver.kernel.org>; Sat, 30 Mar 2019 11:58:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dY/TQsyi"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730685AbfC3L63 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 30 Mar 2019 07:58:29 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:38101 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730428AbfC3L63 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 30 Mar 2019 07:58:29 -0400
Received: by mail-pf1-f195.google.com with SMTP id 10so2288340pfo.5
        for <linux-kernel@vger.kernel.org>; Sat, 30 Mar 2019 04:58:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=rvX19jlOvhnnrX+8bA2bSIAkT2ceNY566+h1Am2E6Z0=;
        b=dY/TQsyicJncSWi6heGTUo+AQSNwnfLdDK6xzBmq8I8JOJCv06OwFcEAuV9327ttpU
         AuwenG9jdRsdUwmeR/BzLysH1FzlZcD5yb+3E3zYkCE+sEnmZ/LTxzlNkjUtSSBnmIM0
         iJkkK1QDwQntZNEESA5eglCXdKl/RVUX33Kdkdi7MTF7m+P/RasZC6s6aehxfktTtouQ
         FdfMheKi88JJl4UvD+AboxjfUPsHzWbQVzDnM9eK4yDe7fetMRuJawP1478lfoFdbVPh
         XxuMhAXxGo+fRrsmkYGyYKNXMXRqJu3748os740cX2K6GdvYdmoB1I+A47sr4VR0ZMLC
         RpZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=rvX19jlOvhnnrX+8bA2bSIAkT2ceNY566+h1Am2E6Z0=;
        b=bJ58esv2CRJILDd5MtehlhFAYB5TNU2H9hEnelDZJFBrQJCuAfpvuKYeAf9qoc/B0p
         8Pgu1R9nw5Bb+rpR5HgmeIQkBYGc8atDV/xi2Mj6i1qeRrsRg0d8o1e0EvosoCA4v4FG
         fZEPPKvGS2UIUTWBInE7kUVWcKmt04HRkUyV64q6DD0JPJil7SFg0AAHYk7ckoVaHuHv
         XmrCqS04iO8aGnDkAeyMptxHGMLmxrFJpsFGynvKu/aRZI9vtzXC5J+7w5KwakP+KJt2
         nlDaHTHwLwiwEIVrnNlGefER20Qc0Kt3mMlyXWSjreTQ2jjx10OQ1HmxFdMfzDoGfyLT
         svsQ==
X-Gm-Message-State: APjAAAWzyAw1Ag7TUlB2DbG2wVDJT9hepjDWAdVB/bjqQFUiQ3BHABYT
        Tn1Qgg+wvm0SS7mbRorln48qBoTA0dk=
X-Google-Smtp-Source: APXvYqxOXlJylfn0ZD+G5Qk7sAitCbivoOXvCSAco5v/kfuDmUKay66ZTskyCjm97WaWHai9R7Mp2A==
X-Received: by 2002:a63:5a1d:: with SMTP id o29mr46469688pgb.320.1553947107801;
        Sat, 30 Mar 2019 04:58:27 -0700 (PDT)
Received: from auvm ([122.162.90.9])
        by smtp.gmail.com with ESMTPSA id m3sm5620297pgp.85.2019.03.30.04.58.26
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sat, 30 Mar 2019 04:58:27 -0700 (PDT)
Date:   Sat, 30 Mar 2019 17:28:21 +0530
From:   Anirudh Rayabharam <anirudh.rayabharam@gmail.com>
To:     gregkh@linuxfoundation.org, hadess@hadess.net, hdegoede@redhat.com,
        Larry.Finger@lwfinger.net, dan.carpenter@oracle.com,
        joe@perches.com, mojha@codeaurora.org
Cc:     devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] staging: rtl8723bs: core: fix line over 80 characters
 warning
Message-ID: <20190330115817.GA66550@auvm>
References: <20190326182309.GA33380@auvm>
 <20190327181836.GA37876@auvm>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190327181836.GA37876@auvm>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 27, 2019 at 11:49:07PM +0530, Anirudh Rayabharam wrote:
> Checkpatch.pl complains that these lines are over 80 characters. Use the
> "psecuritypriv" pointer for consistency, remove unnecessary parantheses
> and fix the alignment.
> 
> This patch just cleans up a condition, it doesn't affect runtime.
> 
> Signed-off-by: Anirudh Rayabharam <anirudh.rayabharam@gmail.com>
> ---
> v2: Made the commit message clearer, removed unnecessary parantheses and fixed
>     the alignment as suggested by Dan Carpenter <dan.carpenter@oracle.com>
> 
>  drivers/staging/rtl8723bs/core/rtw_ap.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/staging/rtl8723bs/core/rtw_ap.c b/drivers/staging/rtl8723bs/core/rtw_ap.c
> index 18fabf5ff44b..8062b7f36de2 100644
> --- a/drivers/staging/rtl8723bs/core/rtw_ap.c
> +++ b/drivers/staging/rtl8723bs/core/rtw_ap.c
> @@ -2336,8 +2336,8 @@ void rtw_ap_restore_network(struct adapter *padapter)
>  			Update_RA_Entry(padapter, psta);
>  			/* pairwise key */
>  			/* per sta pairwise key and settings */
> -			if ((padapter->securitypriv.dot11PrivacyAlgrthm == _TKIP_) ||
> -				(padapter->securitypriv.dot11PrivacyAlgrthm == _AES_)) {
> +			if (psecuritypriv->dot11PrivacyAlgrthm == _TKIP_ ||
> +			    psecuritypriv->dot11PrivacyAlgrthm == _AES_) {
>  				rtw_setstakey_cmd(padapter, psta, true, false);
>  			}
>  		}
> -- 
> 2.17.1
> 

Unfortunately, the v2 of this patch was missed and v1 was applied to Greg's
staging tree. So, I am abandoning v2 of this patch. I will fix the alignment
and braces issue in a new patch.
