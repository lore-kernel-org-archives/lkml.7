Return-Path: <SRS0=TDKO=W6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D333BC3A5A5
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Sep 2019 06:15:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A700020828
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Sep 2019 06:15:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726864AbfICGP2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Sep 2019 02:15:28 -0400
Received: from mx1.redhat.com ([209.132.183.28]:56116 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725919AbfICGP1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Sep 2019 02:15:27 -0400
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id AD2173082E4E;
        Tue,  3 Sep 2019 06:15:27 +0000 (UTC)
Received: from sirius.home.kraxel.org (ovpn-117-67.ams2.redhat.com [10.36.117.67])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 03A7E19D70;
        Tue,  3 Sep 2019 06:15:25 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
        id A2AD346D3; Tue,  3 Sep 2019 08:15:24 +0200 (CEST)
Date:   Tue, 3 Sep 2019 08:15:24 +0200
From:   Gerd Hoffmann <kraxel@redhat.com>
To:     Thomas Zimmermann <tzimmermann@suse.de>
Cc:     dri-devel@lists.freedesktop.org, Jonathan Corbet <corbet@lwn.net>,
        David Airlie <airlied@linux.ie>,
        "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Sean Paul <sean@poorly.run>
Subject: Re: [PATCH 1/5] drm/ttm: add drm_gem_ttm_print_info()
Message-ID: <20190903061524.v75akt6rmx5vow2n@sirius.home.kraxel.org>
References: <20190902124126.7700-1-kraxel@redhat.com>
 <20190902124126.7700-2-kraxel@redhat.com>
 <199bbf8d-68bc-ea99-723e-3b88045970c4@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <199bbf8d-68bc-ea99-723e-3b88045970c4@suse.de>
User-Agent: NeoMutt/20180716
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.46]); Tue, 03 Sep 2019 06:15:27 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

  Hi,

> > +		[ TTM_PL_SYSTEM ] = "system",
> > +		[ TTM_PL_TT     ] = "tt",
> > +		[ TTM_PL_VRAM   ] = "vram",
> > +		[ TTM_PL_PRIV   ] = "priv",
> > +
> 
> This 'gap' in the array seems to be a problem for drivers that use these
> bits. Could the print logic be moved into s separate function that also
> takes the array as an argument?

Are there any drivers which actually use these bits and which therefore
might want to use a different array?

Also note they should not cause any problems (other than not being
printed).  There is an explicit check here ...

> > +		if (!plname[i])
> > +			continue;

.. to skip unknown bits.

cheers,
  Gerd

