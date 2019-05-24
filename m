Return-Path: <SRS0=Z4g5=TY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E74AC072B5
	for <linux-kernel@archiver.kernel.org>; Fri, 24 May 2019 16:19:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 67A892070D
	for <linux-kernel@archiver.kernel.org>; Fri, 24 May 2019 16:19:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=ffwll.ch header.i=@ffwll.ch header.b="UylskouG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390411AbfEXQT1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 May 2019 12:19:27 -0400
Received: from mail-ed1-f67.google.com ([209.85.208.67]:35453 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389588AbfEXQT1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 May 2019 12:19:27 -0400
Received: by mail-ed1-f67.google.com with SMTP id p26so15157092edr.2
        for <linux-kernel@vger.kernel.org>; Fri, 24 May 2019 09:19:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=sender:date:from:to:cc:subject:message-id:mail-followup-to
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=CPXRqRXi1dkgpDWgkFmv18S2UXCoASA126/ZLDqpep8=;
        b=UylskouGfFzdz9k+rD+nBUfnMYwu3B0Nrzz9IwSBv0raqC8VeO7Lkj9KRYotH32kPR
         nHWepxV6u3vgwH2ef+aZf2ztNNBaHS3ozEOEmxUDfkARJoFeLSU91+wVtTaehbyEkGlW
         WkJRGJNPShq1SMDUDasYCQlV9bDsrgqX/R4nk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :in-reply-to:user-agent;
        bh=CPXRqRXi1dkgpDWgkFmv18S2UXCoASA126/ZLDqpep8=;
        b=ByVV4EFMYTsTIP87ih91eXzuaKWfeJ4COfu6B4Y9D/wKrNSO7Illu3Eq8kZ+zIq5Kh
         EKkWtZSbeschFZqcafUM1Jxc+mQ0BSYMag2fuRGSdpfTAjoolr09dxYytcyQ3z2/SPvs
         A6Ayp4NDX9W7dJReYt7kGbzsfe2Ptx/X7PNaQsv62onc2ouxNA7SVqw/E35QBDSTo9Jt
         lyJsFNMRWJwvvXpkN2z+PIixQeI4Xp/Ie9Zkhq6D0Ut/FGF/9Gg0j1nujIgHNRSUlWUf
         u4HlnU3Fz8BpjlAu8EIt1jA89fFQpQfFMkq1uSXE0imOMQoy45fO3FaQTzrYAyoi8JXU
         h/kw==
X-Gm-Message-State: APjAAAXrLYmRj+64ffh6y46BhyCgBrCA/iAfk+8cj/e3ZdDurTmv76wM
        JcUowPcTwMPZHOJly76yPWAuuG93Qks=
X-Google-Smtp-Source: APXvYqxgOqPPzrf9EfWwfmeL3Crqrk0YFhsfqKE5TlV0QEK2AcOGsS18h9BWypj8BrokO9/WGm1gEQ==
X-Received: by 2002:a17:906:ecee:: with SMTP id qt14mr79168553ejb.96.1558714765767;
        Fri, 24 May 2019 09:19:25 -0700 (PDT)
Received: from phenom.ffwll.local ([2a02:168:569e:0:3106:d637:d723:e855])
        by smtp.gmail.com with ESMTPSA id g18sm848038edh.13.2019.05.24.09.19.24
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 24 May 2019 09:19:24 -0700 (PDT)
Date:   Fri, 24 May 2019 18:19:22 +0200
From:   Daniel Vetter <daniel@ffwll.ch>
To:     Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     Daniel Vetter <daniel@ffwll.ch>, Dave Airlie <airlied@linux.ie>,
        DRI <dri-devel@lists.freedesktop.org>,
        Alex Deucher <alexander.deucher@amd.com>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>
Subject: Re: linux-next: build failure after merge of the drm-fixes tree
Message-ID: <20190524161922.GB21222@phenom.ffwll.local>
Mail-Followup-To: Stephen Rothwell <sfr@canb.auug.org.au>,
        Dave Airlie <airlied@linux.ie>,
        DRI <dri-devel@lists.freedesktop.org>,
        Alex Deucher <alexander.deucher@amd.com>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>
References: <20190524082926.6e1a7d8f@canb.auug.org.au>
 <CAKMK7uGSfOev71DKF+ygRjU0rMWcrW3rL7-=Xhbwdm9STUWntQ@mail.gmail.com>
 <20190524201548.2e8594a2@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190524201548.2e8594a2@canb.auug.org.au>
X-Operating-System: Linux phenom 4.14.0-3-amd64 
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 24, 2019 at 08:15:48PM +1000, Stephen Rothwell wrote:
> Hi Daniel,
> 
> On Fri, 24 May 2019 10:09:28 +0200 Daniel Vetter <daniel@ffwll.ch> wrote:
> >
> > On Fri, May 24, 2019 at 12:29 AM Stephen Rothwell <sfr@canb.auug.org.au> wrote:
> > >
> > > After merging the drm-fixes tree, today's linux-next build (x86_64
> > > allmodconfig) failed like this:
> > >
> > > drivers/gpu/drm/amd/amdgpu/../display/amdgpu_dm/amdgpu_dm.c: In function 'load_dmcu_fw':
> > > drivers/gpu/drm/amd/amdgpu/../display/amdgpu_dm/amdgpu_dm.c:667:7: error: implicit declaration of function 'ASICREV_IS_PICASSO'; did you mean 'ASICREV_IS_VEGA12_P'? [-Werror=implicit-function-declaration]
> > >    if (ASICREV_IS_PICASSO(adev->external_rev_id))
> > >        ^~~~~~~~~~~~~~~~~~
> > >        ASICREV_IS_VEGA12_P
> > >
> > > Caused by commit
> > >
> > >   55143dc23ca4 ("drm/amd/display: Don't load DMCU for Raven 1")
> > >
> > > I have reverted that commit for today.  
> > 
> > Seems to compile fine here, and Dave just sent out the pull so I guess
> > works for him too. What's your .config?
> 
> See above "x86_64 allmodconfig"
> 
> Looking at it closely now, I can't see how that error comes about.
> 
> Ah, in the drm-fixes tree, the definition of  is protected by
> 
>   #if defined(CONFIG_DRM_AMD_DC_DCN1_01)
> 
> which gets removed in the amdgpu tree (merged later).  So I can only
> presume that CONFIG_DRM_AMD_DC_DCN1_01 was not set for the build I did.
> 
> config DRM_AMD_DC
>         bool "AMD DC - Enable new display engine"
>         default y
>         select DRM_AMD_DC_DCN1_0 if X86 && !(KCOV_INSTRUMENT_ALL && KCOV_ENABLE_
> COMPARISONS)KCOV_INSTRUMENT_ALL && KCOV_ENABLE_COMPARISONS
>         select DRM_AMD_DC_DCN1_01 if X86 && !(KCOV_INSTRUMENT_ALL && KCOV_ENABLE_COMPARISONS)
> 
> So maybe KCOV_INSTRUMENT_ALL && KCOV_ENABLE_COMPARISONS are set for
> allmodconfig.  I no longer have the actual .config file any more, sorry.

Ah yes. Dave figured it out too and added a revert on top and redid the
pull to Linus. Thanks for spotting&reporting this.
-Daniel
-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
