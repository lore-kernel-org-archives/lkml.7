Return-Path: <SRS0=Pa1K=VP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 860BCC76195
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Jul 2019 15:23:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 560B021849
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Jul 2019 15:23:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=poorly.run header.i=@poorly.run header.b="aNeIpJVd"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390646AbfGRPXx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Jul 2019 11:23:53 -0400
Received: from mail-qk1-f195.google.com ([209.85.222.195]:43386 "EHLO
        mail-qk1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726513AbfGRPXw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Jul 2019 11:23:52 -0400
Received: by mail-qk1-f195.google.com with SMTP id m14so20707037qka.10
        for <linux-kernel@vger.kernel.org>; Thu, 18 Jul 2019 08:23:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=poorly.run; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=WNiVs/zOlaxMgnUWU86FyaftSbm6ryQPjqyll3zSd7Q=;
        b=aNeIpJVdfnDhyIUT2LAXagP7hoA7Rh25uvo/HHVFsCpBrjupsYt4NhQaL0dOF93ewa
         oP+HJmgYhPLpUCdx/O/PMX/j1h1kw4h1IZwvvAiSCnN0mVd6SRT6JzlwXWTKGWoKVKZz
         na0PYmDkNh2V2hGj9NTYQytJvXcrkF2O44nFHXgdxiLRknegEEjcX7lX5C1UNHb11NTe
         9lWPynxuTVev8aJFEVI9VwuYxIz9b3OMKabpt/RXNsdbbfHRxMSIqV4DRVgjKjMGdQ4a
         CsSmwEcoj1j7qyWN2m093ietZTMi7X/hw3uBIgAcC+na0VUCiSiFlACmANmGt+tsklM0
         WDMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=WNiVs/zOlaxMgnUWU86FyaftSbm6ryQPjqyll3zSd7Q=;
        b=mGx9HYuOJ4q3q+w+9SbS9HU1lEDe2aQuns2MEjFnJj8q+s+5Mx63xyOqT8tMS+qXCR
         Gkkkcr2a8f1dRJpFXBWAkNlBsVAvJ0hz5Ci1jRxoKDSdLvLP+ZcTmWlUUEnnTJLEbvfM
         3w9Jfx3iYCJmOLUA3A65vK/Elb2XXAAWXLV+65vQh7P0nioV6VjskSz1DnLvz3zymWWL
         BmYR5JwT8OLkstHOx7FutUyqLudb/EjJOWVV5ppYQlX+00axSA1EJMefctW2Zw+udJgv
         utXGWvXMHNojtX4H2OgjrTFsYmuoPhzhGkrszhi+VdF+c29NvHLiXgN0UH2W+nusHgrI
         0VTg==
X-Gm-Message-State: APjAAAWNReUwNtkD8kw9LGDYpN5dn6eRDWleI/JkjoCSNwegjGBc2zQc
        b83eapPJcfu6usVTPo+/AX1JSw==
X-Google-Smtp-Source: APXvYqw3bbMMThZJQ3Zq+6BKVLoqpi23GsXIPv2dGahb9QdwCD00hd6jKX1mCTp164RNhZSg0IVhCg==
X-Received: by 2002:a37:8d04:: with SMTP id p4mr31358574qkd.113.1563463431641;
        Thu, 18 Jul 2019 08:23:51 -0700 (PDT)
Received: from localhost ([2620:0:1013:11:89c6:2139:5435:371d])
        by smtp.gmail.com with ESMTPSA id r40sm15914278qtk.2.2019.07.18.08.23.51
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Thu, 18 Jul 2019 08:23:51 -0700 (PDT)
Date:   Thu, 18 Jul 2019 11:23:50 -0400
From:   Sean Paul <sean@poorly.run>
To:     Liviu Dudau <Liviu.Dudau@arm.com>
Cc:     "Lowry Li (Arm Technology China)" <Lowry.Li@arm.com>,
        "james qian wang (Arm Technology China)" <james.qian.wang@arm.com>,
        "maarten.lankhorst@linux.intel.com" 
        <maarten.lankhorst@linux.intel.com>,
        "seanpaul@chromium.org" <seanpaul@chromium.org>,
        "airlied@linux.ie" <airlied@linux.ie>,
        Brian Starkey <Brian.Starkey@arm.com>,
        "Julien Yin (Arm Technology China)" <Julien.Yin@arm.com>,
        "Jonathan Chai (Arm Technology China)" <Jonathan.Chai@arm.com>,
        Ayan Halder <Ayan.Halder@arm.com>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        nd <nd@arm.com>
Subject: Re: [PATCH] drm/komeda: Adds error event print functionality
Message-ID: <20190718152350.GC31819@art_vandelay>
References: <1561604994-26925-1-git-send-email-lowry.li@arm.com>
 <20190718131737.GD5942@e110455-lin.cambridge.arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190718131737.GD5942@e110455-lin.cambridge.arm.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 18, 2019 at 02:17:37PM +0100, Liviu Dudau wrote:
> On Thu, Jun 27, 2019 at 04:10:36AM +0100, Lowry Li (Arm Technology China) wrote:

/snip

> > diff --git a/drivers/gpu/drm/arm/display/komeda/komeda_kms.c b/drivers/gpu/drm/arm/display/komeda/komeda_kms.c
> > index 647bce5..1462bac 100644
> > --- a/drivers/gpu/drm/arm/display/komeda/komeda_kms.c
> > +++ b/drivers/gpu/drm/arm/display/komeda/komeda_kms.c
> > @@ -47,6 +47,8 @@ static irqreturn_t komeda_kms_irq_handler(int irq, void *data)
> >  	memset(&evts, 0, sizeof(evts));
> >  	status = mdev->funcs->irq_handler(mdev, &evts);
> >  
> > +	komeda_print_events(&evts);
> 
> Calling this function from the IRQ handler is a bad idea. We should use debugfs
> if you really want to have a trace of the events, but I personally don't see
> value in having this functionality in the kernel at all. You can expose the
> value of the evts->global and evts->pipes[] as integers and decode that in
> userspace or as a debugfs entry.

Alternatively, consider using kernel trace events. They allow you to selectively
turn on/off certain events and also allow you to customize which data is
recorded and how it's formatted. Seems like a good fit from the quick scan I've
done.

Sean

> 
> Best regards,
> Liviu
> 
> > +
> >  	/* Notify the crtc to handle the events */
> >  	for (i = 0; i < kms->n_crtcs; i++)
> >  		komeda_crtc_handle_event(&kms->crtcs[i], &evts);
> > -- 
> > 1.9.1
> > 
> 
> -- 
> ====================
> | I would like to |
> | fix the world,  |
> | but they're not |
> | giving me the   |
>  \ source code!  /
>   ---------------
>     ¯\_(ツ)_/¯

-- 
Sean Paul, Software Engineer, Google / Chromium OS
