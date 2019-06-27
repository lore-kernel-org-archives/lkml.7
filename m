Return-Path: <SRS0=pEez=U2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32459C48BD6
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Jun 2019 15:16:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 045B120663
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Jun 2019 15:16:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726599AbfF0PQk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Jun 2019 11:16:40 -0400
Received: from mx1.redhat.com ([209.132.183.28]:43780 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726404AbfF0PQk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jun 2019 11:16:40 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 37FBF30842B0;
        Thu, 27 Jun 2019 15:16:35 +0000 (UTC)
Received: from sirius.home.kraxel.org (ovpn-116-96.ams2.redhat.com [10.36.116.96])
        by smtp.corp.redhat.com (Postfix) with ESMTP id C67135D9D2;
        Thu, 27 Jun 2019 15:16:34 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
        id 4EE0A11AAF; Thu, 27 Jun 2019 17:16:33 +0200 (CEST)
Date:   Thu, 27 Jun 2019 17:16:33 +0200
From:   Gerd Hoffmann <kraxel@redhat.com>
To:     Thomas Zimmermann <tzimmermann@suse.de>
Cc:     dri-devel@lists.freedesktop.org,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        open list <linux-kernel@vger.kernel.org>,
        David Airlie <airlied@linux.ie>, Sean Paul <sean@poorly.run>
Subject: Re: [PATCH v3 1/5] gem/vram: pin to vram in vmap
Message-ID: <20190627151633.j3xf3lkihklb2wzh@sirius.home.kraxel.org>
References: <20190627122348.5833-1-kraxel@redhat.com>
 <20190627122348.5833-2-kraxel@redhat.com>
 <8a52b578-b255-3e11-3a0c-0b68f0cb649e@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8a52b578-b255-3e11-3a0c-0b68f0cb649e@suse.de>
User-Agent: NeoMutt/20180716
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.40]); Thu, 27 Jun 2019 15:16:40 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

  Hi,

>  1) Introduce a default_placement field in struct drm_gem_vram_helper
> where this flag can be configured. I'd favor this option.

>  2) Introduce a separate callback function for pinning to vram. The
> driver would have to set the correct function pointers.

>  3) Pin the fb console buffer manually from within the bochs driver.

Hmm.  Before calling drm_fbdev_generic_setup() the bo doesn't exist yet
and when the function returns it is already vmapped and pinned I think.

So (3) isn't easily doable.  (1) looks best to me.

cheers,
  Gerd

