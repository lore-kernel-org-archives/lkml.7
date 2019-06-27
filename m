Return-Path: <SRS0=pEez=U2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9524C48BD7
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Jun 2019 19:44:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 87F0520665
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Jun 2019 19:44:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ffwll.ch header.i=@ffwll.ch header.b="ADujp90S"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726571AbfF0ToM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Jun 2019 15:44:12 -0400
Received: from mail-ot1-f66.google.com ([209.85.210.66]:44227 "EHLO
        mail-ot1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726441AbfF0ToM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jun 2019 15:44:12 -0400
Received: by mail-ot1-f66.google.com with SMTP id b7so3494787otl.11
        for <linux-kernel@vger.kernel.org>; Thu, 27 Jun 2019 12:44:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Dg1R5Uo32WYkkl3u1ix25+2ks+vFMVLaKn6JsNIbvzk=;
        b=ADujp90SmUPcFGS9mqRIeJ31riDOHSFmqqsPgEW35NxBXOqkUTJmxkbDTDrxVpuPs+
         foj05KsSjZSsrJlrZ2kJbJiA7SVzaHc453oD5Mn4aGeGDRtcMimDHYpf7gxb+OPcGXQL
         NGkOCQRHra+m8ZFYd/zRammMH0zbVKw0tCNSI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Dg1R5Uo32WYkkl3u1ix25+2ks+vFMVLaKn6JsNIbvzk=;
        b=Zx2BnYfTnaUuYJqkk4AQVRHolJJv6eE7kCAFzl1Q3JOlsV1QvOG6YtxOivXcc898zU
         V0pdmfNOYOUv/J4eUEPCiff4x8FndXGkrcZ1RGJJ2cpG5yV8IRy2WjAWwEHw0bj2CIq/
         l/OwCB8VCF0PnRhADdNSfgHLTStiHQZW3JDyhp0nr5Ittp4YXiSs9bI/wR1CbEtQk+xg
         JpI0+BjiyFHq5JDl7g8UQC1RKRuyxPV9Y+ROBgR3YxFCl/iQ2v8pPlbEOTkl90JgLwAk
         Eho4NLndQ6JgEGLD2cNzalVL6h0eD2SYQzw1dscKdPt9pwpm9GqWjIsg5XrfSCfLnX08
         L7ZA==
X-Gm-Message-State: APjAAAXW8H1xZYVjZDw9U9lLA96Bn71IlcVo9x0SegG13ongW9JUdD4p
        UC94/AhN+n+e33ba5Xkf9AcGvgq+vNVI3IqkIDcybQ==
X-Google-Smtp-Source: APXvYqy8d5D0lTl2v+MH7FMTmjk/5LP/GDPtK/KvswFJia8XMylNu7kDUlfYn7kVgH+/KXfJHiKJKN36WrVTMaVZggo=
X-Received: by 2002:a05:6830:4b:: with SMTP id d11mr4771408otp.106.1561664651379;
 Thu, 27 Jun 2019 12:44:11 -0700 (PDT)
MIME-Version: 1.0
References: <699d7618720e2808f9aa094a13ab2f3545c3c25c.1561565652.git.mchehab+samsung@kernel.org>
 <20190626212735.GY12905@phenom.ffwll.local> <20190627113122.34b46ee2@lwn.net>
In-Reply-To: <20190627113122.34b46ee2@lwn.net>
From:   Daniel Vetter <daniel@ffwll.ch>
Date:   Thu, 27 Jun 2019 21:43:59 +0200
Message-ID: <CAKMK7uGU1X-KvuZGMj3GHNOiqYOuvwq-12o91kBj7JeOf3gjvw@mail.gmail.com>
Subject: Re: [PATCH] drm: fix a reference for a renamed file: fb/modedb.rst
To:     Jonathan Corbet <corbet@lwn.net>
Cc:     Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        Mauro Carvalho Chehab <mchehab@infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Sean Paul <sean@poorly.run>, David Airlie <airlied@linux.ie>,
        dri-devel <dri-devel@lists.freedesktop.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 27, 2019 at 7:31 PM Jonathan Corbet <corbet@lwn.net> wrote:
>
> On Wed, 26 Jun 2019 23:27:35 +0200
> Daniel Vetter <daniel@ffwll.ch> wrote:
>
> > On Wed, Jun 26, 2019 at 01:14:13PM -0300, Mauro Carvalho Chehab wrote:
> > > Due to two patches being applied about the same time, the
> > > reference for modedb.rst file got wrong:
> > >
> > >     Documentation/fb/modedb.txt is now Documentation/fb/modedb.rst.
> > >
> > > Fixes: 1bf4e09227c3 ("drm/modes: Allow to specify rotation and reflection on the commandline")
> > > Fixes: ab42b818954c ("docs: fb: convert docs to ReST and rename to *.rst")
> > > Signed-off-by: Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
> >
> > What's the merge plan here? doc-next? If so:
> >
> > Acked-by: Daniel Vetter <daniel.vetter@ffwll.ch>
>
> It doesn't really apply to docs-next, so that's probably not the best
> path unless I hold it until after the merge window.  Seems like it needs
> to go through the DRM tree to me.

fbdev isn't in drm (yet), so I don't think it applies here eithe. I
guess we need to wait until after -rc1 with this one. Topic
branch/merge seems a bit overkill here.
-Daniel
-- 
Daniel Vetter
Software Engineer, Intel Corporation
+41 (0) 79 365 57 48 - http://blog.ffwll.ch
