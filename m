Return-Path: <SRS0=wAGj=US=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 16688C31E49
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Jun 2019 11:27:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DEFD72070B
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Jun 2019 11:27:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731657AbfFSL1W (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Jun 2019 07:27:22 -0400
Received: from mx1.redhat.com ([209.132.183.28]:35518 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727076AbfFSL1W (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Jun 2019 07:27:22 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 7906530860AF;
        Wed, 19 Jun 2019 11:27:22 +0000 (UTC)
Received: from sirius.home.kraxel.org (ovpn-116-212.ams2.redhat.com [10.36.116.212])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 432005D9C6;
        Wed, 19 Jun 2019 11:27:20 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
        id 7E84E11AAB; Wed, 19 Jun 2019 13:27:23 +0200 (CEST)
Date:   Wed, 19 Jun 2019 13:27:23 +0200
From:   Gerd Hoffmann <kraxel@redhat.com>
To:     Emil Velikov <emil.l.velikov@gmail.com>
Cc:     dri-devel@lists.freedesktop.org,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        open list <linux-kernel@vger.kernel.org>,
        David Airlie <airlied@linux.ie>, Sean Paul <sean@poorly.run>
Subject: Re: [PATCH v3 01/12] drm: add gem array helpers
Message-ID: <20190619112723.sktnns3qfdfh3lvi@sirius.home.kraxel.org>
References: <20190619090420.6667-1-kraxel@redhat.com>
 <20190619090420.6667-2-kraxel@redhat.com>
 <20190619103212.GA1896@arch-x1c3>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190619103212.GA1896@arch-x1c3>
User-Agent: NeoMutt/20180716
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.44]); Wed, 19 Jun 2019 11:27:22 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> > +struct drm_gem_object_array*
> > +drm_gem_array_from_handles(struct drm_file *drm_file, u32 *handles, u32 nents)
> > +{
> > +	struct drm_gem_object_array *objs;
> > +	u32 i;
> > +
> > +	objs = drm_gem_array_alloc(nents);
> > +	if (!objs)
> > +		return NULL;
> > +
> > +	for (i = 0; i < nents; i++) {
> > +		objs->objs[i] = drm_gem_object_lookup(drm_file, handles[i]);
> > +		if (!objs->objs[i]) {
> Missing object put for the 0..i-1 handles. Personally I would:

No. drm_gem_array_alloc initializes objs->nents and
drm_gem_array_put_free() loops over the whole array,
skipping NULL pointers.

> > +			drm_gem_array_put_free(objs);
> > +			return NULL;
> > +		}
> > +	}
> > +	return objs;
> > +}
> Missing EXPORT_SYMBOL?

Oops.  I had that fixed.  Possibly squashed into the wrong patch.

> Ditto?

Yes.

cheers,
  Gerd

