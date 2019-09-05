Return-Path: <SRS0=AnJR=XA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 59DD8C43331
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Sep 2019 21:30:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7D595206BB
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Sep 2019 21:30:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="Qoq088+5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390478AbfIEVao (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 5 Sep 2019 17:30:44 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:38067 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731418AbfIEVao (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Sep 2019 17:30:44 -0400
Received: by mail-pf1-f194.google.com with SMTP id h195so2761015pfe.5
        for <linux-kernel@vger.kernel.org>; Thu, 05 Sep 2019 14:30:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=piu+D/2qQtLmbzegs3qm7+KJNB6aHivMYVh+Msw4kn0=;
        b=Qoq088+5JntNP5WlrgIKFUtXqwge70BbPMPfFmaB0hFnqpvyfAM+9SCMf48rgrI4a2
         ib2m6H+QmykMdqkJyn59Lk5Q2i6owi+6LtY6HnkWMGA/VN5TxvbAniTRY6aKUfZMFkHw
         +T1xnk/Oq8OAtTAuQRLHVJz0zy6e5TsEuACWs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=piu+D/2qQtLmbzegs3qm7+KJNB6aHivMYVh+Msw4kn0=;
        b=aT4zWuuSmLjKWPo4IJRpISGxNvi3L00Qz1epKTOIUNeDWMXp4jKmeBGZHtWbJYb/pU
         KYQAP458pAjpjNK5qR/QViPpDcpL3LV8A/5BR+WWI9GpteYSlrJpZDrfYtk6qQDPprze
         GBcSqeokb4lkIoS2BNLI7oANMyss8wubCFezN2Laci5OYXtzsern6b47zUTIgvV+6Oj8
         58BboN2hLRoJ0p+D0W11bjZghvveO1aH8SfOvxIuKTkujjSFr2B/BRyupy2B5ZZfRksy
         VjEihDtTACPbgtTUaGLHcPh/GAicXma01lV7JULDalEBv/TDIUIsvRvQFAde+ckDiGnO
         QiKQ==
X-Gm-Message-State: APjAAAXtraYk2i4IEPRVrsQG6I631kk2qbKuW82k7JktBWI45QhHMLsU
        MXDQXSkicQaFOHNZyZ7fRdz8MREhMm4=
X-Google-Smtp-Source: APXvYqyepODQraXsFQuxDqQ3OZueFsdhT3J5TNRaY6X4WvJVccE+OFtyTLwFfBce3sUaSk3+HnB++w==
X-Received: by 2002:a63:484a:: with SMTP id x10mr5057278pgk.430.1567719043247;
        Thu, 05 Sep 2019 14:30:43 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id g11sm3110799pgu.11.2019.09.05.14.30.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Sep 2019 14:30:42 -0700 (PDT)
Date:   Thu, 5 Sep 2019 14:30:41 -0700
From:   Kees Cook <keescook@chromium.org>
To:     "J. Bruce Fields" <bfields@redhat.com>
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/9] staging: wlan-ng: use "%*pE" for serial number
Message-ID: <201909051419.F008E755@keescook>
References: <20190905193604.GC31247@fieldses.org>
 <1567712673-1629-1-git-send-email-bfields@redhat.com>
 <1567712673-1629-3-git-send-email-bfields@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1567712673-1629-3-git-send-email-bfields@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 05, 2019 at 03:44:27PM -0400, J. Bruce Fields wrote:
> From: "J. Bruce Fields" <bfields@redhat.com>
> 
> Almost every user of "%*pE" in the kernel uses just bare "%*pE".  This
> is the only user of "%pEhp".  I can't see why it's needed.

Agreed, though to be clear, before, I think every byte in the string
is hex-escaped. After this patch, the space and specials will get
character-based escapes and everything else will switch to octal escapes.

i.e. a string of newline, capital-a, NUL will change from "\x0a\x41" to
"\n\101".

Given that this is only reported to dmesg, it is probably fine. Also,
it's staging and prism2 ... is anyone actually using this?

Reviewed-by: Kees Cook <keescook@chromium.org>

-Kees

> 
> Signed-off-by: J. Bruce Fields <bfields@redhat.com>
> ---
>  drivers/staging/wlan-ng/prism2sta.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/staging/wlan-ng/prism2sta.c b/drivers/staging/wlan-ng/prism2sta.c
> index fb5441399131..8f25496188aa 100644
> --- a/drivers/staging/wlan-ng/prism2sta.c
> +++ b/drivers/staging/wlan-ng/prism2sta.c
> @@ -846,7 +846,7 @@ static int prism2sta_getcardinfo(struct wlandevice *wlandev)
>  	result = hfa384x_drvr_getconfig(hw, HFA384x_RID_NICSERIALNUMBER,
>  					snum, HFA384x_RID_NICSERIALNUMBER_LEN);
>  	if (!result) {
> -		netdev_info(wlandev->netdev, "Prism2 card SN: %*pEhp\n",
> +		netdev_info(wlandev->netdev, "Prism2 card SN: %*pE\n",
>  			    HFA384x_RID_NICSERIALNUMBER_LEN, snum);
>  	} else {
>  		netdev_err(wlandev->netdev, "Failed to retrieve Prism2 Card SN\n");
> -- 
> 2.21.0
> 

-- 
Kees Cook
