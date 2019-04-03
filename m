Return-Path: <SRS0=7x1k=SF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76DA0C4360F
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Apr 2019 07:25:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 411DE2147C
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Apr 2019 07:25:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ffwll.ch header.i=@ffwll.ch header.b="Ntt6PqCi"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728479AbfDCHZr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Apr 2019 03:25:47 -0400
Received: from mail-io1-f67.google.com ([209.85.166.67]:41523 "EHLO
        mail-io1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725936AbfDCHZr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Apr 2019 03:25:47 -0400
Received: by mail-io1-f67.google.com with SMTP id v10so13204420iom.8
        for <linux-kernel@vger.kernel.org>; Wed, 03 Apr 2019 00:25:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=zj97QIezZq1a3rNuxhvxcNyp2HhbWzu18kzcL3vIAWk=;
        b=Ntt6PqCi2qMeVuvMm1s4qW2NsFYtx6Xz8c4Ubm/VfGgX9wVKG2qqugqqL2XQK5wzTj
         dEtjeXS6cuYAR1xz5Lb05eCipGWp/7yIDSEwTuBpDPdhLEBH/33Xe1Qv1mlaXhDfhIDE
         x41cqptbvTk02s1S1xb4CzqLjsuO1LsyejRGs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=zj97QIezZq1a3rNuxhvxcNyp2HhbWzu18kzcL3vIAWk=;
        b=Ysf1GsQfqCOlqhare8pfsfZD+w2YmozlWN6tSw3JoHZRoqUc0iVYFSKpa7WxD+b8do
         o/ddGPcasr77EDs+i6+rswLVxPzl2iQA1XMmQ+cMqYeA5c141FNhe4lgTdYCUiGt4Bv5
         ySFZWTB1CAoObLpxE6cEEQ78zTiiIQtgF4UbP+wWifw2CwRvJCAsYXN4dO3woSuD5uNb
         9IGuzT9e2yyDYpnFbIoqkFqvOrdxEQ2xaLiWqPxcBZKKmIo7cgAdK8RH5Hr7l0YUYyau
         1Fz5YhSU6HfV4YwVy7KXMpT6FH9BJ7Ajlx1WhG6lHqbsUrRLiuJ/0VXI6f+0RE9+zOTX
         TPYQ==
X-Gm-Message-State: APjAAAXi6DmtNiPBOZATqvrF7snsqS32R5Kj1SML09lsdfsJNdTBeH7G
        9MihdhYWRSrGl7Al84isnuztKz0K8JpKouatekoCxg==
X-Google-Smtp-Source: APXvYqxOkMF6XMv8sXqsv4qTMYyuT7HXSFLlyVjVe+uiLubiS0MHDGiyiz2zQHTGT9LusiogPi2GP9BUMKGXpZaRmx0=
X-Received: by 2002:a6b:7519:: with SMTP id l25mr39357802ioh.51.1554276346499;
 Wed, 03 Apr 2019 00:25:46 -0700 (PDT)
MIME-Version: 1.0
References: <CGME20190314114511epcas2p2a9669714177b00989bd3195300f7d3a6@epcas2p2.samsung.com>
 <20190314114500.8336-1-kraxel@redhat.com> <33cf37dc-8456-0316-0b48-fca7c92caa28@samsung.com>
 <CAKMK7uEs+OaoiEmd9Dp6K_v5Pz4pf197DP8KFkvhNMYXv9tYxA@mail.gmail.com>
 <20190402204325.cqu7fobzekd3ccls@sirius.home.kraxel.org> <CAKMK7uHLY1RKUGbqDeHTNnx98y-FLhGWKGcG-o9KDH54=BObAg@mail.gmail.com>
 <20190403072238.76gwp6rfumgqiely@sirius.home.kraxel.org>
In-Reply-To: <20190403072238.76gwp6rfumgqiely@sirius.home.kraxel.org>
From:   Daniel Vetter <daniel.vetter@ffwll.ch>
Date:   Wed, 3 Apr 2019 09:25:35 +0200
Message-ID: <CAKMK7uFGv_oFWHqnWLNz56BkTGk8mXwsEmAXy52Yo9tbMQu+qg@mail.gmail.com>
Subject: Re: [PATCH] fbdev: list all pci memory bars as conflicting apertures
To:     Gerd Hoffmann <kraxel@redhat.com>
Cc:     Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        "open list:FRAMEBUFFER LAYER" <linux-fbdev@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 3, 2019 at 9:22 AM Gerd Hoffmann <kraxel@redhat.com> wrote:
>
> On Wed, Apr 03, 2019 at 08:48:16AM +0200, Daniel Vetter wrote:
> > On Tue, Apr 2, 2019 at 10:43 PM Gerd Hoffmann <kraxel@redhat.com> wrote:
> > >
> > > On Tue, Apr 02, 2019 at 02:09:45PM +0200, Daniel Vetter wrote:
> > > > On Mon, Apr 1, 2019 at 4:00 PM Bartlomiej Zolnierkiewicz
> > > > <b.zolnierkie@samsung.com> wrote:
> > > > >
> > > > >
> > > > > On 03/14/2019 12:45 PM, Gerd Hoffmann wrote:
> > > > > > Simply add all pci memory bars to struct apertures_struct in
> > > > > > remove_conflicting_pci_framebuffers(), without depending on the
> > > > > > res_id parameter.
> > > > > >
> > > > > > The plan is to drop the res_id parameter later on.  For now keep the
> > > > > > parameter, use it for sanity-checking and warn on inconsistencies.
> > > > > >
> > > > > > Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
> > > > > > Reviewed-by: Daniel Vetter <daniel.vetter@ffwll.ch>
> > > > >
> > > > > Patch queued for v5.2, thanks.
> > > >
> > > > Might be good to also stuff this into drm (double merge or topic
> > > > branch, whatever you prefer), since that's where all the users are.
> > > > Gerd also has some follow-up patches to apply on top of this one iirc.
> > >
> > > No follow-up patches yet.  Plan is to wait a bit, see if the
> > > sanity-checks trigger, and if all goes well go drop the res_id
> > > parameter in 5.3 ...
> >
> > Hm I thought you had a patch to convert i915 over. Or did that land already?
>
> Ah, *that* one.  Yep, that is still sitting in a branch here.  Didn't
> rebase it yet.  But I suspect it will be easier to first drop res_id
> and then rebase the i915 patch on top of *that*, so I don't have to
> figure which i915 revision needs which res_id ...

Ok, sounds like a plan for 5.3 somewhen.
-Daniel
-- 
Daniel Vetter
Software Engineer, Intel Corporation
+41 (0) 79 365 57 48 - http://blog.ffwll.ch
