Return-Path: <SRS0=G/Om=ZT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 631BCC432C3
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Nov 2019 11:31:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3572D20684
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Nov 2019 11:31:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ffwll.ch header.i=@ffwll.ch header.b="Si/wqXv4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726545AbfK0Lbv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Nov 2019 06:31:51 -0500
Received: from mail-wm1-f66.google.com ([209.85.128.66]:37967 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726204AbfK0Lbv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Nov 2019 06:31:51 -0500
Received: by mail-wm1-f66.google.com with SMTP id z19so7062193wmk.3
        for <linux-kernel@vger.kernel.org>; Wed, 27 Nov 2019 03:31:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=date:from:to:cc:subject:message-id:mail-followup-to:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=x90tXPKX7SXXKqBD4RPtG2IIq5qjnnSo5Z0/fEo6WeM=;
        b=Si/wqXv43/+mCQD2Ob59KWepPVhzTOFtpYdFBsZ+xxYWlVuDHZJAgsVBNclLRoCIGz
         lHd5apR/IOGkAJR44eeiAtC+oQ0yHMXQ4m9NIeqnURvfM7tBGobb1UuVJgolXqCEF1sp
         bwS9M3wq81CKMuS1h4MRfHlJ7HOeqcUAlMDvU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :in-reply-to:user-agent;
        bh=x90tXPKX7SXXKqBD4RPtG2IIq5qjnnSo5Z0/fEo6WeM=;
        b=iMdm9Qb/wBSlBs5vapR9ZAdTqTfoxgfeBredkF4Bw2L230NwGTWGmkxiD7S9njcS8w
         RCDQckhtLQ0zjbDeh3Jv2H/bIXRDFdjNOz5vUDLS8C47XTfWRFayqcXCegH84++iPhLB
         4tFck7rCWEbrRwEXzzRZG6U6u5yeO6H7heGhYWhw3QGnw9cJ72qcN63COeP9ZzC8siWl
         Epf3elogxH+u3Ung4BfLEymI6MzrAxNcr3ZZoNWEqviauQyoo7J8PCt1pLErm+zkOCHK
         Qfdb8C/kbi4F9kJ4x3VJufajWTLTDdvE7coVXD92iVyI9Y2FQ3Q+ZcMrxfErOybrlXkv
         7BNQ==
X-Gm-Message-State: APjAAAU7DIFDEcQkkevUCOTsq/CDX+VwOKbwsZlXWaZdV8sKTi/mmyxg
        MjuZMSEtP8XkHjKJiAe+Imlbqw==
X-Google-Smtp-Source: APXvYqxyxbbkKMh7d55C6ytzARLcPhLeP1snQ1/wcdRHhfg+jyfNB1sXnfk0WrYvAds5Kp0J5NPfnA==
X-Received: by 2002:a7b:ca57:: with SMTP id m23mr3820456wml.65.1574854307107;
        Wed, 27 Nov 2019 03:31:47 -0800 (PST)
Received: from phenom.ffwll.local (212-51-149-96.fiber7.init7.net. [212.51.149.96])
        by smtp.gmail.com with ESMTPSA id y8sm19160341wru.59.2019.11.27.03.31.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Nov 2019 03:31:46 -0800 (PST)
Date:   Wed, 27 Nov 2019 12:31:41 +0100
From:   Daniel Vetter <daniel@ffwll.ch>
To:     Mihail Atanassov <Mihail.Atanassov@arm.com>
Cc:     Sam Ravnborg <sam@ravnborg.org>, nd <nd@arm.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        David Airlie <airlied@linux.ie>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 01/30] drm: Introduce drm_bridge_init()
Message-ID: <20191127113141.GA406127@phenom.ffwll.local>
Mail-Followup-To: Mihail Atanassov <Mihail.Atanassov@arm.com>,
        Sam Ravnborg <sam@ravnborg.org>, nd <nd@arm.com>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        David Airlie <airlied@linux.ie>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <20191126131541.47393-1-mihail.atanassov@arm.com>
 <11447519.fzG14qnjOE@e123338-lin>
 <20191126192445.GA2044@ravnborg.org>
 <2196368.mua8KTRpvS@e123338-lin>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2196368.mua8KTRpvS@e123338-lin>
X-Operating-System: Linux phenom 5.3.0-2-amd64 
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 27, 2019 at 11:05:56AM +0000, Mihail Atanassov wrote:
> On Tuesday, 26 November 2019 19:24:45 GMT Sam Ravnborg wrote:
> > Hi Mihail.
> 
> Hi Sam,
> 
> > 
> > > Ack, but with one caveat: bridge->dev is the struct drm_device that is
> > > the bridge client, we need to add a bridge->device (patch 29 in this
> > > series) which is the struct device that will manage the bridge lifetime.
> > Other places uses the variable name "drm" for a drm_device.
> > This is less confusion than the "dev" name.
> > 
> > It seems a recent trend to use the variable name "drm" so you can find a
> > lot of places using "dev".
> > 
> > bike-shedding - but also about readability.
> > 
> > 	Sam
> > 
> 
> I'm okay with the idea, I can do a follow-up patch or series for the
> rename; I expect it would be a bit hefty to do it prior to this.
> 
> @Daniel, thoughts on s/bridge.dev/bridge.drm/ and
> s/bridge.device/bridge.dev/ after this series?

I'm firmly in the "no opionon" on this.
-Daniel
-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
