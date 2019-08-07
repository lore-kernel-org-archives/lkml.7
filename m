Return-Path: <SRS0=/Haq=WD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6C56C433FF
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Aug 2019 10:36:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8F98B21922
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Aug 2019 10:36:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727554AbfHGKgw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 7 Aug 2019 06:36:52 -0400
Received: from mx1.redhat.com ([209.132.183.28]:47335 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726837AbfHGKgv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Aug 2019 06:36:51 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 69E694C95D;
        Wed,  7 Aug 2019 10:36:51 +0000 (UTC)
Received: from sirius.home.kraxel.org (ovpn-116-144.ams2.redhat.com [10.36.116.144])
        by smtp.corp.redhat.com (Postfix) with ESMTP id DCBE5600C6;
        Wed,  7 Aug 2019 10:36:50 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
        id 8B82716E32; Wed,  7 Aug 2019 12:36:49 +0200 (CEST)
Date:   Wed, 7 Aug 2019 12:36:49 +0200
From:   Gerd Hoffmann <kraxel@redhat.com>
To:     Daniel Vetter <daniel@ffwll.ch>
Cc:     dri-devel <dri-devel@lists.freedesktop.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Sean Paul <sean@poorly.run>, David Airlie <airlied@linux.ie>,
        open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 1/3] drm: add gem ttm helpers
Message-ID: <20190807103649.aedmac63eop6ktlk@sirius.home.kraxel.org>
References: <20190806133454.8254-1-kraxel@redhat.com>
 <20190806133454.8254-2-kraxel@redhat.com>
 <20190806135426.GA7444@phenom.ffwll.local>
 <20190807072654.arqvx37p4yxhegcu@sirius.home.kraxel.org>
 <CAKMK7uFyKd71w4H8nFk=WPSHL3KMwQ6kLwAMXTd_TAkrkJ++KQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAKMK7uFyKd71w4H8nFk=WPSHL3KMwQ6kLwAMXTd_TAkrkJ++KQ@mail.gmail.com>
User-Agent: NeoMutt/20180716
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.26]); Wed, 07 Aug 2019 10:36:51 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

  Hi,

> > > Same for this, you're just upcasting to ttm_bo and then downcasting to
> > > gem_bo again ... I think just a series to roll out the existing gem
> > > helpers everywhere should work?
> >
> > I don't think so.  drm_gem_dumb_map_offset() calls
> > drm_gem_create_mmap_offset(), which I think is not correct for ttm
> > objects because ttm_bo_init() handles vma_node initialization.
> 
> More code to unify first? This should work exactly the same way for
> all gem based drivers I think ... Only tricky bit is making sure
> vmwgfx keeps working correctly.

Yea.  Unifying on the gem way of doing things isn't going to work very
well.  We would have to keep the current way of doing things in the ttm
code, wrapped into "if (ttm_bo_uses_embedded_gem_object()) { ... }", to
not break vmwgfx.

So adding gem ttm helpers (where gem+ttm drivers can opt-in) looked like
the better way of handling this to me ...

cheers,
  Gerd

