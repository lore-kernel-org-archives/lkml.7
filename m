Return-Path: <SRS0=xBSd=Z4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D46A8C43603
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Dec 2019 12:28:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AA5FC2464E
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Dec 2019 12:28:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="D/WIwT6l"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726256AbfLFM17 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 6 Dec 2019 07:27:59 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:27221 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726124AbfLFM17 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Dec 2019 07:27:59 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1575635278;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=kaTUxMNRx4BXZwiqLRw+yIBYBhpqo3EKVWL659PamfU=;
        b=D/WIwT6lvtlrfqqk+sBGr9RLNIQkQvA+AkinIGVbgivCVRKbvwqc4WtSqYc9MzqBmPwGCb
        rDu/icX+ZsNqPi6JpLy05fW6S0MEPmz3uzlS/ZovOGpniE1a07guN3Ivye5UWZxhWZzH2O
        xKu/YDjSX/0/m5qEffTj566xoyNSoBo=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-193-GtTdKNtdNYCIbOxvufQVyQ-1; Fri, 06 Dec 2019 07:27:54 -0500
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 662FB107ACC4;
        Fri,  6 Dec 2019 12:27:52 +0000 (UTC)
Received: from sirius.home.kraxel.org (ovpn-116-67.ams2.redhat.com [10.36.116.67])
        by smtp.corp.redhat.com (Postfix) with ESMTP id CC9A319C7F;
        Fri,  6 Dec 2019 12:27:51 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
        id D0B1116E05; Fri,  6 Dec 2019 13:27:50 +0100 (CET)
Date:   Fri, 6 Dec 2019 13:27:50 +0100
From:   Gerd Hoffmann <kraxel@redhat.com>
To:     Daniel Vetter <daniel@ffwll.ch>
Cc:     dri-devel <dri-devel@lists.freedesktop.org>,
        Rob Herring <robh@kernel.org>,
        intel-gfx <intel-gfx@lists.freedesktop.org>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        David Airlie <airlied@linux.ie>,
        Christian Koenig <christian.koenig@amd.com>,
        Huang Rui <ray.huang@amd.com>,
        open list <linux-kernel@vger.kernel.org>
Subject: Re: [Intel-gfx] [PATCH v3 1/2] drm: call drm_gem_object_funcs.mmap
 with fake offset
Message-ID: <20191206122750.4z7vlr52wthxtucf@sirius.home.kraxel.org>
References: <20191127092523.5620-1-kraxel@redhat.com>
 <20191127092523.5620-2-kraxel@redhat.com>
 <20191128113930.yhckvneecpvfhlls@sirius.home.kraxel.org>
 <20191205221523.GN624164@phenom.ffwll.local>
 <20191206100724.ukzdyaym3ltcyfaa@sirius.home.kraxel.org>
 <20191206102200.6osisct57n424ujn@sirius.home.kraxel.org>
 <CAKMK7uF=wZ8snurJwftyjVD2ExutfzNUGGhy8=UVFYf3=sz7qQ@mail.gmail.com>
MIME-Version: 1.0
In-Reply-To: <CAKMK7uF=wZ8snurJwftyjVD2ExutfzNUGGhy8=UVFYf3=sz7qQ@mail.gmail.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-MC-Unique: GtTdKNtdNYCIbOxvufQVyQ-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 06, 2019 at 12:10:15PM +0100, Daniel Vetter wrote:
> On Fri, Dec 6, 2019 at 11:22 AM Gerd Hoffmann <kraxel@redhat.com> wrote:
> >
> > > Guess you kicked CI?  Just got CI mails, now reporting success, witho=
ut
> > > doing anything.  So I'll go push v3 to misc-next.
> >
> > Oops, spoke too soon.  Next mail arrived.  Fi.CI.BAT works, but
> > Fi.CI.IGT still fails.
> >
> > Where is the "test again" button?  Can I re-run the tests on v2?  Right
> > now I tend to commit v2 to have a fix committed, then go figure why v3
> > fails ...
>=20
> Top of the mail you get from CI is the link to the patchwork series.
> That contains all the same info like in the mail, plus the coveted
> button. If failures look similar then yes I guess v3 is somehow
> broken. But I've looked, looks like just 2x unrelated noise and you
> being unlucky, so imo totally fine to push v3. I'll give CI folks a
> heads-up (best done over irc usually).

Ok.  Pushed now.

cheers,
  Gerd

