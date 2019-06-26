Return-Path: <SRS0=hRvo=UZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EAC7EC48BD6
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Jun 2019 10:22:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BF76A20663
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Jun 2019 10:22:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726882AbfFZKWw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Jun 2019 06:22:52 -0400
Received: from foss.arm.com ([217.140.110.172]:58072 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726242AbfFZKWw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jun 2019 06:22:52 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 61DE4360;
        Wed, 26 Jun 2019 03:22:51 -0700 (PDT)
Received: from e110455-lin.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 42AB43F718;
        Wed, 26 Jun 2019 03:22:51 -0700 (PDT)
Received: by e110455-lin.cambridge.arm.com (Postfix, from userid 1000)
        id 083BF682573; Wed, 26 Jun 2019 11:22:50 +0100 (BST)
Date:   Wed, 26 Jun 2019 11:22:49 +0100
From:   Liviu Dudau <liviu.dudau@arm.com>
To:     Pavel Machek <pavel@ucw.cz>
Cc:     linux-kernel@vger.kernel.org, Wen He <wen.he_1@nxp.com>,
        Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH 4.19 55/90] drm/arm/mali-dp: Add a loop around the second
 set CVAL and try 5 times
Message-ID: <20190626102249.GQ17204@e110455-lin.cambridge.arm.com>
References: <20190624092313.788773607@linuxfoundation.org>
 <20190624092317.745033085@linuxfoundation.org>
 <20190626075619.GB32248@amd>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190626075619.GB32248@amd>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 26, 2019 at 09:56:19AM +0200, Pavel Machek wrote:
> 
> On Mon 2019-06-24 17:56:45, Greg Kroah-Hartman wrote:
> > [ Upstream commit 6a88e0c14813d00f8520d0e16cd4136c6cf8b4d4 ]
> > 
> > This patch trying to fix monitor freeze issue caused by drm error
> > 'flip_done timed out' on LS1028A platform. this set try is make a loop
> > around the second setting CVAL and try like 5 times before giveing up.
> 
> 
> > @@ -204,8 +205,18 @@ static void malidp_atomic_commit_hw_done(struct drm_atomic_state *state)
> >  			drm_crtc_vblank_get(&malidp->crtc);
> >  
> >  		/* only set config_valid if the CRTC is enabled */
> > -		if (malidp_set_and_wait_config_valid(drm) < 0)
> > +		if (malidp_set_and_wait_config_valid(drm) < 0) {
> > +			/*
> > +			 * make a loop around the second CVAL setting and
> > +			 * try 5 times before giving up.
> > +			 */
> > +			while (loop--) {
> > +				if (!malidp_set_and_wait_config_valid(drm))
> > +					break;
> > +			}
> >  			DRM_DEBUG_DRIVER("timed out waiting for updated configuration\n");
> > +		}
> > +
> 
> We'll still get the debug message even if
> malidp_set_and_wait_config_valid() suceeded. That does not sound
> right.
> 									Pavel

It does, because the first malidp_set_and_wait_config_valid() has timed out, which
is not the expected behaviour at all. LS1028A has some quirks that require this
loop in order to get it out of some stalled state, but any other implementation
of the IP should not have this issue.

Hope this clarifies things.

Best regards,
Liviu

> -- 
> (english) http://www.livejournal.com/~pavelmachek
> (cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html



-- 
====================
| I would like to |
| fix the world,  |
| but they're not |
| giving me the   |
 \ source code!  /
  ---------------
    ¯\_(ツ)_/¯
