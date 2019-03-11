Return-Path: <SRS0=FxTY=RO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D477CC43381
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Mar 2019 12:36:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A3C532084F
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Mar 2019 12:36:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=ffwll.ch header.i=@ffwll.ch header.b="Finc7pBX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727405AbfCKMgw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Mar 2019 08:36:52 -0400
Received: from mail-ed1-f67.google.com ([209.85.208.67]:44697 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726812AbfCKMgv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Mar 2019 08:36:51 -0400
Received: by mail-ed1-f67.google.com with SMTP id b20so3846431edw.11
        for <linux-kernel@vger.kernel.org>; Mon, 11 Mar 2019 05:36:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=sender:date:from:to:cc:subject:message-id:mail-followup-to
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=in/rIyzdhRxiTPk7K+rKqH5+S31LjabQQNB+MVuIfdo=;
        b=Finc7pBXNe9M6FrrZVjU9so0phFzM6No3/Ma0zPedMYUtLfDekk9dZST1n0+PjqjHA
         zwkCRP9WynyLgXttv88LDxBdRJeYpkMonX6gxPDz+7r77kF6ugFKh9mQQTzqKtejeoqK
         gdtxa/vSu+Lsnxywm6YxiCMqRfXVNc2e2Ip9c=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :in-reply-to:user-agent;
        bh=in/rIyzdhRxiTPk7K+rKqH5+S31LjabQQNB+MVuIfdo=;
        b=EkSjsguFr0jiVOmklLNE2EoDKcXXC9YN/umt1j7YJAAMpQkKiya+8UpT5cZ8YQIqGH
         o03LfkhDheE6Mz1j4ac8/3S784tpn0wJr9fbKnEk8eOe5p9bbF3y7+yeDeVBJeodrusZ
         q4Vk795JgXP5J2PqSZXfih8etPXNFouHJ35LCG/vLou7pyqK51ICZHfevygCfov1Q1lj
         jM597s7yzDzqD6dxDTumc1MeudG0cUpGeZWhOlQhmVuXrhCOvqf2a2GL1kmfLjTS703c
         fVTODOSW0KTu/vu+5glx7VoK6fUlDrtt5q5BOcLqfnL5kgCzX8whEuCDRWV/Gb+Q96CI
         s52A==
X-Gm-Message-State: APjAAAVU5slLqpPQrttbdntXfAqHIm18bljBPsDTP7R0kgb8/TtJvLmf
        kCUh5oovKv9fnc33OVlb55zwQxt4POTs1g==
X-Google-Smtp-Source: APXvYqxxmeegpJ0hQK6Hmol8blyCd2CDAN0wcog77ty8X7G6wTpUG5a/Gcc2BRRqXvl4UwbDXogE1w==
X-Received: by 2002:a17:906:7cd0:: with SMTP id h16mr22165648ejp.126.1552307809263;
        Mon, 11 Mar 2019 05:36:49 -0700 (PDT)
Received: from phenom.ffwll.local ([2a02:168:569e:0:3106:d637:d723:e855])
        by smtp.gmail.com with ESMTPSA id o42sm4677138edc.49.2019.03.11.05.36.47
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 11 Mar 2019 05:36:47 -0700 (PDT)
Date:   Mon, 11 Mar 2019 13:36:46 +0100
From:   Daniel Vetter <daniel@ffwll.ch>
To:     Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     Dave Airlie <airlied@linux.ie>,
        David Francis <David.Francis@amd.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        DRI <dri-devel@lists.freedesktop.org>,
        Alex Deucher <alexander.deucher@amd.com>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: Re: linux-next: manual merge of the drm tree with the drm-fixes tree
Message-ID: <20190311123646.GA2665@phenom.ffwll.local>
Mail-Followup-To: Stephen Rothwell <sfr@canb.auug.org.au>,
        Dave Airlie <airlied@linux.ie>,
        David Francis <David.Francis@amd.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        DRI <dri-devel@lists.freedesktop.org>,
        Alex Deucher <alexander.deucher@amd.com>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
References: <20190301132351.6f4e815f@canb.auug.org.au>
 <CADnq5_PXqjcQeH1vh9ftpPfoCzD5SfdcXQSqAh2BPgrs1V28LQ@mail.gmail.com>
 <20190304115402.223de52e@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190304115402.223de52e@canb.auug.org.au>
X-Operating-System: Linux phenom 4.19.0-1-amd64 
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 04, 2019 at 11:54:02AM +1100, Stephen Rothwell wrote:
> Hi Dave,
> 
> On Fri, 1 Mar 2019 18:29:58 -0500 Alex Deucher <alexdeucher@gmail.com> wrote:
> >
> > On Thu, Feb 28, 2019 at 9:24 PM Stephen Rothwell <sfr@canb.auug.org.au> wrote:
> > >
> > > Today's linux-next merge of the drm tree got a conflict in:
> > >
> > >   drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> > >
> > > between commit:
> > >
> > >   d63716658ac1 ("drm/amd/display: Use vrr friendly pageflip throttling in DC.")
> > >
> > > from the drm-fixes tree and commits:
> > >
> > >   8a48b44cd00f ("drm/amd/display: Call into DC once per multiplane flip")
> > >   bc7f670ee04c ("drm/amd/display: Perform plane updates only when needed")
> > >
> > > from the drm tree.
> > >
> > > I had no idea how to resolve this, so I just effectively reverted the
> > > drm-fixes commit.
> > >
> > > I fixed it up (see above) and can carry the fix as necessary. This
> > > is now fixed as far as linux-next is concerned, but any non trivial
> > > conflicts should be mentioned to your upstream maintainer when your tree
> > > is submitted for merging.  You may also want to consider cooperating
> > > with the maintainer of the conflicting tree to minimise any particularly
> > > complex conflicts.  
> > 
> > d63716658ac1 ("drm/amd/display: Use vrr friendly pageflip throttling
> > in DC.") should be reverted and this should be applied instead for
> > drm-next:
> > https://cgit.freedesktop.org/~agd5f/linux/commit/?h=drm-next-5.2-wip&id=5d5f43c235d02e4d8e9d50d012f3b21f380486eb
> 
> Maybe you should merge the drm-fixes tree into the drm tree and apply
> the above ... 

Alex, can you pls get the amdgpu trees added to linux-next? From a quick
look those still seem to be missing.

Thanks, Daniel
-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
