Return-Path: <SRS0=TvG7=UK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D3092C4321A
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Jun 2019 09:40:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9DD9720657
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Jun 2019 09:40:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=ffwll.ch header.i=@ffwll.ch header.b="bWW0yqPB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404637AbfFKJkQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Jun 2019 05:40:16 -0400
Received: from mail-ed1-f68.google.com ([209.85.208.68]:46287 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2403752AbfFKJkP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jun 2019 05:40:15 -0400
Received: by mail-ed1-f68.google.com with SMTP id h10so18993957edi.13
        for <linux-kernel@vger.kernel.org>; Tue, 11 Jun 2019 02:40:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=sender:date:from:to:cc:subject:message-id:mail-followup-to
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=TV3qoPI3CybT3ZOiICpyVzHhXX/g/RYRK8tbjgl4RHM=;
        b=bWW0yqPBDAcwXw6OB2vqqN5OwZnKDdnjN5PWudyV7Y//pEOBD/U7VnGsyzT/2J4smR
         7duPRZnNFn8cWSFWoxGe73UcLjeEYajEh59HeRCOEYMgnPMwVphP0jmG1q6yxJs+tubc
         GjmEqDMtEtmFNnlQKg5gDVIlwgt2q/W0hrljk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :in-reply-to:user-agent;
        bh=TV3qoPI3CybT3ZOiICpyVzHhXX/g/RYRK8tbjgl4RHM=;
        b=AbddBnBJGIP5Sut4cGylxd1P4DrgDcoC9uHm9FFwgZ+RZJXKWksRu39nyOc5lEFSJ4
         anyJAeG5TSh32V0oBOQ8n/5URHiSvhD7BlpWuks1K84umXod3ob5/DxqtHgma5Eb6Ejq
         zEzvC1UvsBCMbDMX/cT88d1+BgMjRRQWC9QFMAnEZebMuvO0p66nV/GPHU2/bwjB+Gz9
         2T4XudKbmx7l/1L5yFWyjSxOIG2ILQm/s5KMxMpFVrQfMc5yY80Ne8k8icRDStFsgCjB
         0qzXO95p8Kcv/W9OiKj0sxKkgYEzaQjbMwwSmKo+xC6FmfzfSRliSZBkonIk2p7wnE1F
         XzDQ==
X-Gm-Message-State: APjAAAX8hVknzjSDdFw8A20xeVha8G1H95OCR4fjJBazi6eBhJ6V8KpZ
        Quajm/v0vvzdMGZxVH6wc5H0Tg==
X-Google-Smtp-Source: APXvYqwHogsRH9fZfw5U5Fdv1dXg6iOF4lQ+mvx9xPLpYS/mg3rptWV1Xk3ElpWq9cPEH4dBd+KClg==
X-Received: by 2002:a17:906:784c:: with SMTP id p12mr57702204ejm.159.1560246013358;
        Tue, 11 Jun 2019 02:40:13 -0700 (PDT)
Received: from phenom.ffwll.local ([2a02:168:569e:0:3106:d637:d723:e855])
        by smtp.gmail.com with ESMTPSA id x98sm2712021ede.89.2019.06.11.02.40.12
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Tue, 11 Jun 2019 02:40:12 -0700 (PDT)
Date:   Tue, 11 Jun 2019 11:40:10 +0200
From:   Daniel Vetter <daniel@ffwll.ch>
To:     Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
Cc:     Daniel Vetter <daniel@ffwll.ch>,
        Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        Mauro Carvalho Chehab <mchehab@infradead.org>,
        linux-kernel@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Sean Paul <sean@poorly.run>, David Airlie <airlied@linux.ie>,
        dri-devel@lists.freedesktop.org
Subject: Re: [PATCH v3 33/33] docs: EDID/HOWTO.txt: convert it and rename to
 howto.rst
Message-ID: <20190611094010.GZ21222@phenom.ffwll.local>
Mail-Followup-To: Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        Mauro Carvalho Chehab <mchehab@infradead.org>,
        linux-kernel@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Sean Paul <sean@poorly.run>, David Airlie <airlied@linux.ie>,
        dri-devel@lists.freedesktop.org
References: <cover.1560045490.git.mchehab+samsung@kernel.org>
 <74bec0b5b7c32c8d84adbaf9ff208803475198e5.1560045490.git.mchehab+samsung@kernel.org>
 <20190611083731.GS21222@phenom.ffwll.local>
 <20190611060215.232af2bb@coco.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190611060215.232af2bb@coco.lan>
X-Operating-System: Linux phenom 4.14.0-3-amd64 
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 11, 2019 at 06:02:15AM -0300, Mauro Carvalho Chehab wrote:
> Em Tue, 11 Jun 2019 10:37:31 +0200
> Daniel Vetter <daniel@ffwll.ch> escreveu:
> 
> > On Sat, Jun 08, 2019 at 11:27:23PM -0300, Mauro Carvalho Chehab wrote:
> > > Sphinx need to know when a paragraph ends. So, do some adjustments
> > > at the file for it to be properly parsed.
> > > 
> > > At its new index.rst, let's add a :orphan: while this is not linked to
> > > the main index.rst file, in order to avoid build warnings.
> > > 
> > > that's said, I believe that this file should be moved to the
> > > GPU/DRM documentation.  
> > 
> > Yes, but there's a bit a twist: This is definitely end-user documentation,
> > so maybe should be in admin-guide?
> > 
> > Atm all we have in Documentation/gpu/ is internals for drivers + some
> > beginnings of uapi documentation for userspace developers.
> 
> On media, we have several different types of documents:
> 
> - uAPI - consumed by both userspace and kernelspace developers;
> - kAPI - consumed by Kernel hackers;
> - driver-specific information. Those are usually messy, as some contain
>   specific internal details, while others are pure end-user documentation.
> 
> there are several cross-references between uAPI and kAPI parts.
> 
> I've seem similar patterns on several other driver subsystems.
> 
> I agree with Jon's principle that the best is to focus the book per
> audience. Yet, trying to rearrange the documentation means a lot of work,
> specially on those cases where a single file contain different types of
> documentation, like on media driver docs.

Yeah atm we're doing a bad job of keeping the kapi and uapi parts
separate. But the plan at least is to move all the gpu related uapi stuff
into Documentation/gpu/drm-uapi.rst. Not sure there's value in moving that
out of the gpu folder ...

> > Jon, what's your recommendation here for subsystem specific
> > end-user/adming docs?
> 
> Jon, please correct me if I' wrong, bu I guess the plan is to place them 
> somewhere under Documentation/admin-guide/.
> 
> If so, perhaps creating a Documentation/admin-guide/drm dir there and 
> place docs like EDID/HOWTO.txt, svga.txt, etc would work.
> 
> Btw, that's one of the reasons[1] why I opted to keep the files where they
> are: properly organizing the converted documents call for such kind
> of discussions. On my experience, discussing names and directory locations
> can generate warm discussions and take a lot of time to reach consensus.
> 
> [1] The other one is to avoid/simplify merge conflicts.

Oh definitely not asking for moving them at the same time, just wondering
how this should be solved properly.
-Daniel

> 
> > 
> > Thanks, Daniel
> > 
> > > 
> > > Signed-off-by: Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
> > > ---
> > >  Documentation/EDID/{HOWTO.txt => howto.rst}   | 31 ++++++++++++-------
> > >  .../admin-guide/kernel-parameters.txt         |  2 +-
> > >  drivers/gpu/drm/Kconfig                       |  2 +-
> > >  3 files changed, 22 insertions(+), 13 deletions(-)
> > >  rename Documentation/EDID/{HOWTO.txt => howto.rst} (83%)
> > > 
> > > diff --git a/Documentation/EDID/HOWTO.txt b/Documentation/EDID/howto.rst
> > > similarity index 83%
> > > rename from Documentation/EDID/HOWTO.txt
> > > rename to Documentation/EDID/howto.rst
> > > index 539871c3b785..725fd49a88ca 100644
> > > --- a/Documentation/EDID/HOWTO.txt
> > > +++ b/Documentation/EDID/howto.rst
> > > @@ -1,3 +1,9 @@
> > > +:orphan:
> > > +
> > > +====
> > > +EDID
> > > +====
> > > +
> > >  In the good old days when graphics parameters were configured explicitly
> > >  in a file called xorg.conf, even broken hardware could be managed.
> > >  
> > > @@ -34,16 +40,19 @@ Makefile. Please note that the EDID data structure expects the timing
> > >  values in a different way as compared to the standard X11 format.
> > >  
> > >  X11:
> > > -HTimings:  hdisp hsyncstart hsyncend htotal
> > > -VTimings:  vdisp vsyncstart vsyncend vtotal
> > > +  HTimings:
> > > +    hdisp hsyncstart hsyncend htotal
> > > +  VTimings:
> > > +    vdisp vsyncstart vsyncend vtotal
> > >  
> > > -EDID:
> > > -#define XPIX hdisp
> > > -#define XBLANK htotal-hdisp
> > > -#define XOFFSET hsyncstart-hdisp
> > > -#define XPULSE hsyncend-hsyncstart
> > > +EDID::
> > >  
> > > -#define YPIX vdisp
> > > -#define YBLANK vtotal-vdisp
> > > -#define YOFFSET vsyncstart-vdisp
> > > -#define YPULSE vsyncend-vsyncstart
> > > +  #define XPIX hdisp
> > > +  #define XBLANK htotal-hdisp
> > > +  #define XOFFSET hsyncstart-hdisp
> > > +  #define XPULSE hsyncend-hsyncstart
> > > +
> > > +  #define YPIX vdisp
> > > +  #define YBLANK vtotal-vdisp
> > > +  #define YOFFSET vsyncstart-vdisp
> > > +  #define YPULSE vsyncend-vsyncstart
> > > diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
> > > index 3d072ca532bb..3faf37b8b001 100644
> > > --- a/Documentation/admin-guide/kernel-parameters.txt
> > > +++ b/Documentation/admin-guide/kernel-parameters.txt
> > > @@ -930,7 +930,7 @@
> > >  			edid/1680x1050.bin, or edid/1920x1080.bin is given
> > >  			and no file with the same name exists. Details and
> > >  			instructions how to build your own EDID data are
> > > -			available in Documentation/EDID/HOWTO.txt. An EDID
> > > +			available in Documentation/EDID/howto.rst. An EDID
> > >  			data set will only be used for a particular connector,
> > >  			if its name and a colon are prepended to the EDID
> > >  			name. Each connector may use a unique EDID data
> > > diff --git a/drivers/gpu/drm/Kconfig b/drivers/gpu/drm/Kconfig
> > > index 6b34949416b1..c3a6dd284c91 100644
> > > --- a/drivers/gpu/drm/Kconfig
> > > +++ b/drivers/gpu/drm/Kconfig
> > > @@ -141,7 +141,7 @@ config DRM_LOAD_EDID_FIRMWARE
> > >  	  monitor are unable to provide appropriate EDID data. Since this
> > >  	  feature is provided as a workaround for broken hardware, the
> > >  	  default case is N. Details and instructions how to build your own
> > > -	  EDID data are given in Documentation/EDID/HOWTO.txt.
> > > +	  EDID data are given in Documentation/EDID/howto.rst.
> > >  
> > >  config DRM_DP_CEC
> > >  	bool "Enable DisplayPort CEC-Tunneling-over-AUX HDMI support"
> > > -- 
> > > 2.21.0
> > >   
> > 
> 
> 
> 
> Thanks,
> Mauro

-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
