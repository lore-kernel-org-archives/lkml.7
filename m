Return-Path: <SRS0=n7Fw=UL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6935C31E46
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Jun 2019 19:45:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 696B321721
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Jun 2019 19:45:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ffwll.ch header.i=@ffwll.ch header.b="a4hg/gVG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728563AbfFLTp3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Jun 2019 15:45:29 -0400
Received: from mail-ot1-f68.google.com ([209.85.210.68]:46894 "EHLO
        mail-ot1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728362AbfFLTp3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jun 2019 15:45:29 -0400
Received: by mail-ot1-f68.google.com with SMTP id z23so16605436ote.13
        for <linux-kernel@vger.kernel.org>; Wed, 12 Jun 2019 12:45:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=rj0s/EnHCttAHmB4nljz2hfrd5qtQGBo4NYtuSwcw5A=;
        b=a4hg/gVG/xxaXGY9ZBgWhrY96dlM4oWC9BUFBqIEBpVfG+bXS/j7ywvfVN/fyCLeGG
         n7JfWsNT9YTK3Whb+uNl8wgiDTTfieLPrazLiumTRNsMSb7vVwSNpsrmJ1WaDcAN9Oo7
         zVNqOZnpTJtO1GAZmbhC6S9TDPgdmyNGpLKv4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=rj0s/EnHCttAHmB4nljz2hfrd5qtQGBo4NYtuSwcw5A=;
        b=tgL551Ck/g97ts/fv4hqR78IQFBqTy/g8T2iq99WQIKeETWV1ZwPcUQQfu6s0im04T
         Xy+A1fr01wM6C/27WDI4vFE9ib294J96PLI5kRdmPgcu3+97x2Adg9Y69eOY9yxk1zdM
         aFg8oBHwz2x7YOMJVgHDN6dqVRlOvQQ51qBVSII/orqL5kQJx0VTOq26jKNqZ8+o3O/w
         OMt0BrUayDgHW+l38qu3qxjz52I7B0xKxMPGdeNOzqD+n8LpaXjh6pfoJJEujgU4qge7
         RtNCIMtJZA2OAvgYRMLdOexAVQEHNGmHAISeIF12pNZoBLAI0Lf3MKQyrrAhMtRDZnvT
         crAw==
X-Gm-Message-State: APjAAAUKME0dWnQdbHhb4rHcGRWtnPTroVKlBQL6Cj8IohZMireGnHAB
        xCW+ZtzCt7huQ91G3nze1uUgbqHjL6+pBdD6I9hejQ==
X-Google-Smtp-Source: APXvYqyQyAKmu73QFcy5o66I6HzVh0Qi5BTY0gz/EM37hRMxnkSU0DiySLBn1Lt5c6phm65GHhJg7bCOYJcr0PJ+uzk=
X-Received: by 2002:a05:6830:ce:: with SMTP id x14mr22478851oto.188.1560368727932;
 Wed, 12 Jun 2019 12:45:27 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1560045490.git.mchehab+samsung@kernel.org>
 <74bec0b5b7c32c8d84adbaf9ff208803475198e5.1560045490.git.mchehab+samsung@kernel.org>
 <20190611083731.GS21222@phenom.ffwll.local> <20190611060215.232af2bb@coco.lan>
 <20190611093701.44344d00@lwn.net> <20190612144015.033247db@coco.lan>
In-Reply-To: <20190612144015.033247db@coco.lan>
From:   Daniel Vetter <daniel@ffwll.ch>
Date:   Wed, 12 Jun 2019 21:45:15 +0200
Message-ID: <CAKMK7uFhPKbpQj1Y2+C1zW0SdRcezHYDA4h=Ri_eV2xB7HtVig@mail.gmail.com>
Subject: Re: [PATCH v3 33/33] docs: EDID/HOWTO.txt: convert it and rename to howto.rst
To:     Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
Cc:     Jonathan Corbet <corbet@lwn.net>,
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

On Wed, Jun 12, 2019 at 7:40 PM Mauro Carvalho Chehab
<mchehab+samsung@kernel.org> wrote:
>
> Em Tue, 11 Jun 2019 09:37:01 -0600
> Jonathan Corbet <corbet@lwn.net> escreveu:
>
> > On Tue, 11 Jun 2019 06:02:15 -0300
> > Mauro Carvalho Chehab <mchehab+samsung@kernel.org> wrote:
> >
> > > Jon, please correct me if I' wrong, bu I guess the plan is to place them
> > > somewhere under Documentation/admin-guide/.
> >
> > That makes sense to me.
> >
> > > If so, perhaps creating a Documentation/admin-guide/drm dir there and
> > > place docs like EDID/HOWTO.txt, svga.txt, etc would work.
> >
> > Maybe "graphics" or "display" rather than "drm", which may not entirely
> > applicable to all of those docs or as familiar to all admins?
>
> It is up to Daniel/David to decide. Personally, I agree with you that
> either "graphics" or "display" would be better at the admin guide.

We use Documentation/gpu already for the developer guide, I think
going with "gpu" on the admin guide for consistency would be good. I
do personally think that splitting out the admin guide makes sense, we
could also put some recommendations about access rights for drm device
nodes and stuff like that in there.

> > > Btw, that's one of the reasons[1] why I opted to keep the files where they
> > > are: properly organizing the converted documents call for such kind
> > > of discussions. On my experience, discussing names and directory locations
> > > can generate warm discussions and take a lot of time to reach consensus.
> >
> > Moving docs is a pain; my life would certainly be easier if I were happy
> > to just let everything lie where it fell :)  But it's far from the hardest
> > problem we solve in kernel development, I assume we can figure it out.
>
> Yeah, it is doable. I'm happy to write the rename patches and even try
> to split some documents at the places I'm more familiar with, but, IMHO,
> we should do some discussions before some of such renames.
>
> For example, Daniel said that:
>
> > > > Yeah atm we're doing a bad job of keeping the kapi and uapi parts
> > > > separate. But the plan at least is to move all the gpu related uapi stuff
> > > > into Documentation/gpu/drm-uapi.rst. Not sure there's value in moving that
> > > > out of the gpu folder ...
>
> From the conversions I've made so far, almost all driver subsystems
> put everything under Documentation/<subsystem: kAPI, uAPI, admin info,
> driver-specific technical info.
>
> It should be doable to place kAPI and uAPI on different books, but there
> will be lots of cross-reference links between them, on properly-written
> docs.

I'm not sure it makes sense to split out the kapi and uapi sides of
the docs complete. For the admin guide I think one overall book
covering all subsystems is good. But someone creating a drm/kms
compositor is not going to be interested much into some special
options for networking protocol I think. For those I think focusing
more on the specific subsystem makes more sense (and easier to share
common concepts/diagrams between uapi and kapi of a given subsystem).

I do think for a given subsystem the uapi side should be clearly split
out (otherwise it's impossible to find for non-kernel people). And
currently drm falls short really badly on this. So maybe a good
argument for a uapi kernel directory would be to force that, but not
sure that's good enough of a reason.
-Daniel

> However, other admin-guide stuff under drivers are usually in the middle
> of the documents. For example, on media, we have some at the uAPI guide,
> like the Device Naming item:
>
>         https://linuxtv.org/downloads/v4l-dvb-apis-new/uapi/v4l/open.html#device-naming
>
> But splitting it from uAPI guide is not an easy task.
>
> At the driver's specific documentation is even messier.
>
> Ok, splitting is doable, but require lots of dedication, and I'm not
> convinced if it would make much difference in practice.
>
> Thanks,
> Mauro



-- 
Daniel Vetter
Software Engineer, Intel Corporation
+41 (0) 79 365 57 48 - http://blog.ffwll.ch
