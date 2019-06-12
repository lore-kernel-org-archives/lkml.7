Return-Path: <SRS0=n7Fw=UL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96EEDC31E46
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Jun 2019 06:09:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6966E206E0
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Jun 2019 06:09:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="m8hJ2c0e"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730954AbfFLGJf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Jun 2019 02:09:35 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:39297 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730860AbfFLGJe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jun 2019 02:09:34 -0400
Received: by mail-wr1-f67.google.com with SMTP id x4so12813250wrt.6
        for <linux-kernel@vger.kernel.org>; Tue, 11 Jun 2019 23:09:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=jNHpo9jnwtLQwuoRcj9Ch+fhiSgA7li7+xLd+t9vX0c=;
        b=m8hJ2c0e3XNePvN0CW1AiuPtb6Tsm06LSMqOrEr8m/J+EAR2QK9ql0ebHsCP92aYtm
         6mqLiXGOBxsAgcaVMen9cmq1ZpkUojqFwNGKIwtxFMW7WyZKtUN5lpGdRMe0Gas16jpj
         LAT07r46pjG8q0yGqgzQizG+DFkTulNQjXqCIVy7uFbfJvOqkXl0LUGpPnKAlJyZ69qZ
         ukRc/AgAIoYDjFv5PLPBWCkh0YO8NkXsGen4B1A4NvEPVvnuVFSFyNnX14GS+Aa3aiBB
         tkgCuX8/fXozn76HmTNJ00VbrHdXvIAdJJGEGk3lkGLF5stuCF/piv6JjYoIPvT2lIhL
         Mw2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=jNHpo9jnwtLQwuoRcj9Ch+fhiSgA7li7+xLd+t9vX0c=;
        b=HJYnDWX/rC3qZ6Ca4S0QP+pX543pV6HnpzsoglBiB5iab776OOQGfh5bgS+N8PhFEw
         fd9szJYU/DJQlVKlBeiD1i0xEue5Y6XIZcvdxPau0dT+1eErhmMAtuqP8ULzOQcpLyOG
         lfQhmLJ1b0HqlrWWA4yvSUJHuVsLimqL52DqvV4fr/WW589XQa5c4a5zRvCV6Tw9sLZ4
         ttFGgsJFgKLWkHDiAMswRQtfHofg+81qHRJfTnLra5K7kJO6mIsNz5qWt9pf+FXiolSs
         EY0QytWWgusQuxVlljYEyy8z57PVKeMo7xqLRd00yhaiS59Sv4J8UfepBU+rhE3RhO9z
         sPUw==
X-Gm-Message-State: APjAAAUMl32KBo8YGE1BE9itg7Kbv2rAwibENdT4tD76SEBZqolgwGf4
        0qwnuPxYdJd5xkqSfZvxsWswIg==
X-Google-Smtp-Source: APXvYqyfYkZe1DnheBkxB3YZco+J1bRcMmIGxS+HOyR0Pfaq+SvAfBz+F8jQnAiX9kHfVifedeh39g==
X-Received: by 2002:adf:db02:: with SMTP id s2mr17167183wri.326.1560319771955;
        Tue, 11 Jun 2019 23:09:31 -0700 (PDT)
Received: from dell ([2.27.35.243])
        by smtp.gmail.com with ESMTPSA id x16sm4926192wmj.4.2019.06.11.23.09.30
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 11 Jun 2019 23:09:31 -0700 (PDT)
Date:   Wed, 12 Jun 2019 07:09:29 +0100
From:   Lee Jones <lee.jones@linaro.org>
To:     Daniel Thompson <daniel.thompson@linaro.org>
Cc:     Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        LKML <linux-kernel@vger.kernel.org>,
        DRI Development <dri-devel@lists.freedesktop.org>,
        Intel Graphics Development <intel-gfx@lists.freedesktop.org>,
        Linux Fbdev development list <linux-fbdev@vger.kernel.org>,
        Daniel Vetter <daniel.vetter@ffwll.ch>
Subject: Re: [PATCH 00/33] fbcon notifier begone v3!
Message-ID: <20190612060929.GR4797@dell>
References: <20190528090304.9388-1-daniel.vetter@ffwll.ch>
 <CGME20190606073852epcas2p27b586b93869a30e4658581c290960fee@epcas2p2.samsung.com>
 <CAKMK7uHneUFYPiRr10X9xfWTkGtaoQBB=niDMGkAgJ-fgo5=mA@mail.gmail.com>
 <f848b4de-abab-116f-ad68-23348f1a4b76@samsung.com>
 <20190611141635.rowolr37vhalophr@holly.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190611141635.rowolr37vhalophr@holly.lan>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 11 Jun 2019, Daniel Thompson wrote:
> On Fri, Jun 07, 2019 at 12:07:55PM +0200, Bartlomiej Zolnierkiewicz wrote:
> > On 6/6/19 9:38 AM, Daniel Vetter wrote:
> > 
> > >> - Hash out actual merge plan.
> > > 
> > > I'd like to stuff this into drm.git somehow, I guess topic branch works
> > > too.
> > 
> > I would like to have topic branch for this patchset.
> 
> From a backlight perspective its Lee Jones who hoovers up the patches
> and worries about hiding merge conflicts from Linus.
> 
> I'll let him follow up if needed but I suspect he'd like an immutable
> branch to work from also.

Yes please.  Happy to either create one, or receive one.

-- 
Lee Jones [李琼斯]
Linaro Services Technical Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
