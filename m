Return-Path: <SRS0=9PYC=TV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 01FE0C04AAF
	for <linux-kernel@archiver.kernel.org>; Tue, 21 May 2019 08:27:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C970E2173E
	for <linux-kernel@archiver.kernel.org>; Tue, 21 May 2019 08:26:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=ffwll.ch header.i=@ffwll.ch header.b="PO/+Dkkq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726917AbfEUI06 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 May 2019 04:26:58 -0400
Received: from mail-ed1-f67.google.com ([209.85.208.67]:35719 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726344AbfEUI06 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 May 2019 04:26:58 -0400
Received: by mail-ed1-f67.google.com with SMTP id p26so28136133edr.2
        for <linux-kernel@vger.kernel.org>; Tue, 21 May 2019 01:26:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=sender:date:from:to:cc:subject:message-id:mail-followup-to
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=sflGufuJmBGrWVV7kp0a21Ak4l+RlvLDFK6F90TjUIk=;
        b=PO/+DkkqU2QMkKp1T2YLYKA9bqN7zoE0orBMP1ZgOfRn1ykb8Rhc2OAb4f/CU2LToz
         f+jqxUBiuPwEGvvw2rEqeXFB3bIkuNt7ATmh9dscN4EhugZWbZGLxTJjP0r+j2I6kP5S
         qU9Gy87QX7JdjaLotxtlAsPUGE7EsUdqsMwwU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :in-reply-to:user-agent;
        bh=sflGufuJmBGrWVV7kp0a21Ak4l+RlvLDFK6F90TjUIk=;
        b=cwoc6YubZ+9CQXZRNgUSVOCWP+zPlepzF/0X0YW6+uSExeV1GyfZP5NV1r73nJQ62j
         0WiYNJITOzRt3Igj4H8u2WuhhslwMISceMveYfobf4ZVVIqyWeaqXhtGMedFRFYeKU+V
         h3Kbx4Y3hwTBih4ajVC1IrSdjvByaergPFQFkfWNL7Tsb2P2SyuJ98VmQtJM/xslupWf
         qi6XfKUH+IcI/88KvXUlKj07itvjDabeudRh7MQBnEaXwpOVj91QQXq8+ErXnvQuZrvL
         V869j8J49q0W303ea2iAbeoGu4vsOcnld3++1KDFIrvEKvGNmQneFAyNQNRoV9460o9L
         o2xQ==
X-Gm-Message-State: APjAAAWv5S8rHU03IIjCdDFMNiYsAqMiAMpkQT5qe4LuebgJe+m4NFtj
        Jqk4nP0XvrED+oqYuj/BxIhwZg==
X-Google-Smtp-Source: APXvYqwA6mKKB38IoocAh7xCa1f9JR4yiOByi2IoSmFpDSnNdZHvj/wmfZQp19/9E2v9ZWOHBhQsHA==
X-Received: by 2002:a50:addc:: with SMTP id b28mr82524241edd.7.1558427216045;
        Tue, 21 May 2019 01:26:56 -0700 (PDT)
Received: from phenom.ffwll.local ([2a02:168:569e:0:3106:d637:d723:e855])
        by smtp.gmail.com with ESMTPSA id d24sm6190111edb.5.2019.05.21.01.26.55
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 21 May 2019 01:26:55 -0700 (PDT)
Date:   Tue, 21 May 2019 10:26:53 +0200
From:   Daniel Vetter <daniel@ffwll.ch>
To:     Pekka Paalanen <ppaalanen@gmail.com>
Cc:     Daniel Vetter <daniel@ffwll.ch>, Eric Anholt <eric@anholt.net>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org
Subject: Re: [PATCH 2/2] drm/doc: Document expectation that userspace review
 looks at kernel uAPI.
Message-ID: <20190521082653.GJ21222@phenom.ffwll.local>
Mail-Followup-To: Pekka Paalanen <ppaalanen@gmail.com>,
        Eric Anholt <eric@anholt.net>, linux-kernel@vger.kernel.org,
        dri-devel@lists.freedesktop.org
References: <20190424185617.16865-1-eric@anholt.net>
 <20190424185617.16865-2-eric@anholt.net>
 <20190424193636.GU9857@phenom.ffwll.local>
 <20190521104734.2d8853ac@eldfell.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190521104734.2d8853ac@eldfell.localdomain>
X-Operating-System: Linux phenom 4.14.0-3-amd64 
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 21, 2019 at 10:47:34AM +0300, Pekka Paalanen wrote:
> On Wed, 24 Apr 2019 21:36:36 +0200
> Daniel Vetter <daniel@ffwll.ch> wrote:
> 
> > On Wed, Apr 24, 2019 at 11:56:17AM -0700, Eric Anholt wrote:
> > > The point of this review process is that userspace using the new uAPI
> > > can actually live with the uAPI being provided, and it's hard to know
> > > that without having actually looked into a kernel patch yourself.
> > > 
> > > Signed-off-by: Eric Anholt <eric@anholt.net>
> > > Suggested-by: Daniel Vetter <daniel.vetter@ffwll.ch>
> > > ---
> > >  Documentation/gpu/drm-uapi.rst | 4 +++-
> > >  1 file changed, 3 insertions(+), 1 deletion(-)
> > > 
> > > diff --git a/Documentation/gpu/drm-uapi.rst b/Documentation/gpu/drm-uapi.rst
> > > index 8e5545dfbf82..298424b98d99 100644
> > > --- a/Documentation/gpu/drm-uapi.rst
> > > +++ b/Documentation/gpu/drm-uapi.rst
> > > @@ -85,7 +85,9 @@ leads to a few additional requirements:
> > >  - The userspace side must be fully reviewed and tested to the standards of that
> > >    userspace project. For e.g. mesa this means piglit testcases and review on the
> > >    mailing list. This is again to ensure that the new interface actually gets the
> > > -  job done.
> > > +  job done.  The userspace-side reviewer should also provide at least an
> > > +  Acked-by on the kernel uAPI patch indicating that they've looked at how the
> > > +  kernel side is implementing the new feature being used.  
> > 
> > Answers a question that just recently came up on merging new kms
> > properties.
> > 
> > Reviewed-by: Daniel Vetter <daniel.vetter@ffwll.ch>
> 
> Hi,
> 
> for the record, I personally will not be able to provide such Acked-by
> tag according to kernel review rules, because I am completely unfamiliar
> with kernel DRM internals and cannot review kernel code at all. This
> might make people expecting Weston to prove their uAPI disappointed,
> since there are very few Weston reviewers available.
> 
> If you meant something else, please word it to that you actually meant.

Hm right, that wording is putting a bit too high a bar. We want the
userspace view point here, not force userspace people to review kernel
code. I'll try to clarify this a bit better.
-Daniel
-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
