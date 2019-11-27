Return-Path: <SRS0=G/Om=ZT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E464C432C0
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Nov 2019 16:19:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 602F120684
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Nov 2019 16:19:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727040AbfK0QTN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Nov 2019 11:19:13 -0500
Received: from asavdk4.altibox.net ([109.247.116.15]:53972 "EHLO
        asavdk4.altibox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726514AbfK0QTN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Nov 2019 11:19:13 -0500
Received: from ravnborg.org (unknown [158.248.194.18])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by asavdk4.altibox.net (Postfix) with ESMTPS id 562EA80503;
        Wed, 27 Nov 2019 17:19:09 +0100 (CET)
Date:   Wed, 27 Nov 2019 17:19:07 +0100
From:   Sam Ravnborg <sam@ravnborg.org>
To:     Mihail Atanassov <Mihail.Atanassov@arm.com>
Cc:     nd <nd@arm.com>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        David Airlie <airlied@linux.ie>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Vincent Abriou <vincent.abriou@st.com>
Subject: Re: [PATCH 28/30] drm/sti: sti_vdo: Use drm_bridge_init()
Message-ID: <20191127161907.GA17176@ravnborg.org>
References: <20191126131541.47393-1-mihail.atanassov@arm.com>
 <20191126131541.47393-29-mihail.atanassov@arm.com>
 <20191126193740.GC2044@ravnborg.org>
 <2161383.jsAorMfJJG@e123338-lin>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2161383.jsAorMfJJG@e123338-lin>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-CMAE-Score: 0
X-CMAE-Analysis: v=2.3 cv=VcLZwmh9 c=1 sm=1 tr=0
        a=UWs3HLbX/2nnQ3s7vZ42gw==:117 a=UWs3HLbX/2nnQ3s7vZ42gw==:17
        a=jpOVt7BSZ2e4Z31A5e1TngXxSK0=:19 a=kj9zAlcOel0A:10
        a=anWFpgVYN7cw7xR4DrkA:9 a=CjuIK1q_8ugA:10 a=pHzHmUro8NiASowvMSCR:22
        a=Ew2E2A-JSTLzCXPT_086:22
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Mihail.

> > 
> > I can see from grepping that bridge.driver_private is used
> > in a couple of other files in sti/
> > 
> > Like sti_hdmi.c:
> >         bridge->driver_private = hdmi;
> >         bridge->funcs = &sti_hdmi_bridge_funcs;
> >         drm_bridge_attach(encoder, bridge, NULL);
> > 
> > 
> > I wonder if a drm_bridge_init() should be added there.
> > I did not look closely - but it looked suspisiously.
> 
> My goal with drm_bridge_init() was to get devlinks sorted out for
> cross-module uses of a drm_bridge (via of_drm_find_bridge()), so I only
> considered locations where drm_bridge_add/remove() were used.
> 
> Would you be okay with a promise to push a cleanup of this one and the
> one in sti_hda.c after patch 1/30 lands in some form? I'd rather not
> make this series much longer, it's already pushing it at 30 :).

Absolutely - my drive-by comment was more out of concern if this
was missing. A clean-up later souns good.

	Sam
