Return-Path: <SRS0=bMiL=T7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,T_DKIMWL_WL_HIGH
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 424D9C28CC0
	for <linux-kernel@archiver.kernel.org>; Fri, 31 May 2019 02:23:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0496C25DDC
	for <linux-kernel@archiver.kernel.org>; Fri, 31 May 2019 02:23:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="RbyceLt5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726589AbfEaCXh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 May 2019 22:23:37 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:38658 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726418AbfEaCXg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 May 2019 22:23:36 -0400
Received: by mail-pf1-f194.google.com with SMTP id a186so4466622pfa.5
        for <linux-kernel@vger.kernel.org>; Thu, 30 May 2019 19:23:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=C6kCdn+CvKS1nx6udU5A4u9LPwYaTnkxAuO1T3SqJb0=;
        b=RbyceLt5l0FuwnDm8jJY+ZlgmLAa1lkUjeAdnioFpi5EHrxP/7AvLtYI9ugBMgxbLa
         6lcSFslkR1yZ6H/ucNwXO7h5H7GPK8jNPGFrbC3y8bAdiL0TWu19nAGzO89I15a0VEdH
         ZHoRRCeo8WYucIwyjDPdjqmDFVf3aVYTXTg6U=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=C6kCdn+CvKS1nx6udU5A4u9LPwYaTnkxAuO1T3SqJb0=;
        b=ml9Y5yCv8VIAPDRppsa9DyDrH33N6CrvVXrzctmnfzsGWlctsmhNixBoPQ1mVM6Adv
         BbRsvUged6YForiRiBK3pvp0t88zLCNzZMmtZ6vPm08E1rZPo83m+JGBjU3ye4nBZH+q
         8ruVh7p2UAPEdlW3ILSvlkJX7WIxycW24GEu7nY1UyUjCW0gTmb57230OSyzsKSxaHut
         srUo2+hRE6WZrlMBvNN0FfJmDf/2d4t2e+QQWU0j3BxTYFbHQn8bMRhVLcuKfE13pWoh
         JmfHFQg2fsCLyL+7FdsmTS6VTlQzYJBGGddYRcTjEAMxF8SwaxByzRsUxXMWEA/nroCt
         FwsQ==
X-Gm-Message-State: APjAAAVm31shiIHJMnKb++AlwpVV46A4K3V87LReLGaZpy/CFbEtuyFN
        mNvsgfCtQ7LYyFfYBWp8DVd9wQ==
X-Google-Smtp-Source: APXvYqx3IdjF23o571rKzjuuUngXx8sryXUJU2cxqnWXPGAGAL9ufdzda0B0QTkjF04dJPmbn28G4A==
X-Received: by 2002:a17:90a:2ec2:: with SMTP id h2mr4402798pjs.119.1559269416094;
        Thu, 30 May 2019 19:23:36 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id x24sm3775458pjq.27.2019.05.30.19.23.34
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 30 May 2019 19:23:35 -0700 (PDT)
Date:   Thu, 30 May 2019 19:23:34 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Ke Wu <mikewu@google.com>
Cc:     James Morris <jmorris@namei.org>, Jonathan Corbet <corbet@lwn.net>,
        "Serge E. Hallyn" <serge@hallyn.com>, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-security-module@vger.kernel.org
Subject: Re: [PATCH v2] Allow to exclude specific file types in LoadPin
Message-ID: <201905301921.AE6D8D1@keescook>
References: <20190529224350.6460-1-mikewu@google.com>
 <20190530192208.99773-1-mikewu@google.com>
 <alpine.LRH.2.21.1905310611190.26428@namei.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <alpine.LRH.2.21.1905310611190.26428@namei.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 31, 2019 at 06:11:44AM +1000, James Morris wrote:
> On Thu, 30 May 2019, Ke Wu wrote:
> 
> > Linux kernel already provide MODULE_SIG and KEXEC_VERIFY_SIG to
> > make sure loaded kernel module and kernel image are trusted. This
> > patch adds a kernel command line option "loadpin.exclude" which
> > allows to exclude specific file types from LoadPin. This is useful
> > when people want to use different mechanisms to verify module and
> > kernel image while still use LoadPin to protect the integrity of
> > other files kernel loads.
> > 
> > Signed-off-by: Ke Wu <mikewu@google.com>
> > ---
> > Changelog since v1:
> > - Mark ignore_read_file_id with __ro_after_init.
> > - Mark parse_exclude() with __init.
> > - Use ARRAY_SIZE(ignore_read_file_id) instead of READING_MAX_ID.
> 
> Looks good!
> 
> Reviewed-by: James Morris <jamorris@linux.microsoft.com>

Thanks! Applied to my for-next/loadpin branch at
git://git.kernel.org/pub/scm/linux/kernel/git/kees/linux.git
and should be visible in linux-next in a few days.

-- 
Kees Cook
