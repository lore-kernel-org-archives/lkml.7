Return-Path: <SRS0=FxTY=RO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D6425C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Mar 2019 23:39:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 996F52087C
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Mar 2019 23:39:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OqFwFM0i"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726360AbfCKXjg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Mar 2019 19:39:36 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:40834 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725850AbfCKXjf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Mar 2019 19:39:35 -0400
Received: by mail-wr1-f68.google.com with SMTP id t6so693985wrw.7
        for <linux-kernel@vger.kernel.org>; Mon, 11 Mar 2019 16:39:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=TW04/fQHZTjaAhL2CaKBAxytZtoYVfe+d98Uqr/dbPo=;
        b=OqFwFM0icukXeytHyOvfHc4zC9M1Hr1tdsdOJm9u6YqQunsV8gV/MSNvFieKvU3SW1
         PwT/fDZnG29sGDjPPbjjZ2/ZpSKayploQa8KRl9TnFqAUskZMGLKkpkCIMXG+nbmrHQf
         yyDyahGWSY+UqwCsnOX/d6zgpAjF2n6uX9Enbe/Eb5WtK9PRXCLvogmOjDvhTbUHdq8f
         Fm0+SCotL9c9RHc6WceZi3cGcsl4KQf/+BazrrNnOp98uCLjeLcBoUfZo6a/4ZyS6x3q
         zjcoW436ABRyhbyblPrhfNbpl/4O09LMhBcote/PTRSVuz21gnS6sVlhklhFpHUZD99F
         semQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=TW04/fQHZTjaAhL2CaKBAxytZtoYVfe+d98Uqr/dbPo=;
        b=XmJnzKsoKLr+PNFttFGfh542tGR4D+2UeDpt1ZQDflYoJJUimu9JenT/L0YrpSWZGF
         hF9DaTGQBZFVw5FqL/MS3VLLbmoes4/QLI8JeVd25gNtUsQthAXUiEbkMuXMHCsa1kdz
         PTsx/aiE0aa05U7TgIIWqG6I8iFoNu04abrjsiprUOKFsW01uG1+hnJkeV2sncowrGge
         8JNzHpIUyax1XdIpubS/9Ws0uc0mzxhaCNxB/6d9mhyq4HoivQUYw1Y6AervrDXWR2hV
         BY626YSolYnBvU8tSkEK43qcxNe1Ewc3zg2JwXF44maazE+w5ldWme8xssSgCkHjeooq
         hy9g==
X-Gm-Message-State: APjAAAVy5CvLyyTqW/2kyRW/ExoFK00aoOzxnWDVrTM7/U5hDYD/bPme
        zMVso1Ixz7kh+XgD9az4ezY=
X-Google-Smtp-Source: APXvYqx9g4taHX/XqQYNih4eSIwHosNtxTvdbxl3mqWsgfMCQdLc5lSu1Uq320KCSvY2qMMqpZfk9g==
X-Received: by 2002:adf:fa51:: with SMTP id y17mr22864966wrr.233.1552347573874;
        Mon, 11 Mar 2019 16:39:33 -0700 (PDT)
Received: from darwi-home-pc (ip-109-42-1-116.web.vodafone.de. [109.42.1.116])
        by smtp.gmail.com with ESMTPSA id o30sm10407545wro.57.2019.03.11.16.39.31
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Mon, 11 Mar 2019 16:39:33 -0700 (PDT)
Date:   Tue, 12 Mar 2019 00:39:24 +0100
From:   "Ahmed S. Darwish" <darwish.07@gmail.com>
To:     Daniel Vetter <daniel@ffwll.ch>
Cc:     Jani Nikula <jani.nikula@linux.intel.com>,
        David Airlie <airlied@linux.ie>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>,
        David Zhou <David1.Zhou@amd.com>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Matt Fleming <matt@codeblueprint.co.uk>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        John Ogness <john.ogness@linutronix.de>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: Re: DRM-based Oops viewer
Message-ID: <20190311233924.GA4433@darwi-home-pc>
References: <20190310013142.GA3376@darwi-home-pc>
 <87mum1lr3g.fsf@intel.com>
 <20190311134941.GH2665@phenom.ffwll.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190311134941.GH2665@phenom.ffwll.local>
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 11, 2019 at 02:49:41PM +0100, Daniel Vetter wrote:
> On Mon, Mar 11, 2019 at 11:04:19AM +0200, Jani Nikula wrote:
> > On Sun, 10 Mar 2019, "Ahmed S. Darwish" <darwish.07@gmail.com> wrote:
> > > Hello DRM/UEFI maintainers,
> > >
> > > Several years ago, I wrote a set of patches to dump the kernel
> > > log to disk upon panic -- through BIOS INT 0x13 services. [1]
> > >
> > > The overwhelming response was that it's unsafe to do this in a
> > > generic manner. Linus proposed a video-based viewer instead: [2]
> > >
> > >     If you want to do the BIOS services thing, do it for video: copy the
> > >     oops to low RAM, return to real mode, re-run the graphics card POST
> > >     routines to initialize text-mode, and use the BIOS to print out the
> > >     oops.  That is WAY less scary than writing to disk.
> > >
> > > Of course it's 2019 now though, and it's quite known that
> > > Intel is officially obsoleting the PC/AT BIOS by 2020.. [3]
> > >
> > > Researching whether this can be done from UEFI, it was also clear
> > > that UEFI "Runtime Services" do not provide any re-initialization
> > > routines. [4]
> > >
> > > The maximum possible that UEFI can provide is a GOP-provided
> > > framebuffer that's ready to use by the OS -- even after the UEFI
> > > boot phase is marked as done through ExitBootServices(). [5]
> > >
> > > Of course, once native drivers like i915 or radeon take over,
> > > such a framebuffer is toast... [6]
> > >
> > > Thus a possible remaining option, is to display the oops through
> > > "minimal" DRM drivers provided for each HW variant... Since
> > > these special drivers will run only and fully under a panic()
> > > context though, several constraints exist:
> > >
> > >   - The code should be fully synchronous (irqs are disabled)
> > >   - It should not allocate any dynamic memory
> > >   - It should make minimal assumptions about HW state
> > >   - It should not chain into any other kernel subsystem
> > >   - It has ample freedom to use delay-based loops and the
> > >     like, the kernel is already dead.
> > >
> > > How feasible is it to have such a special "DRM viewoops"
> > > framework + its minimal drivers in the kernel?
> >
> > Please first better define what you want to achieve.
> >
> > Do you want to store the dmesg or oops (like your original series
> > suggests) or do you want to display the oops? Do you want the facility
> > to be functioning at all times, or only when specifically requested in
> > advance by the user? If you want to display the oops, do you want it to
> > also work when the display is disabled at the time of the oops? What if
> > the display is at attached to a port on a dock?
> >
> > There's at least kdump, ramoops, and netconsole that can be used to
> > achieve some of what you want. How do they fall short for you?
>
> Assuming the use-case is to get an oops to display on a kms driver, we do
> have a fairly comprehensive plan of what that's should look like:
>
> https://dri.freedesktop.org/docs/drm/gpu/todo.html#make-panic-handling-work
>
> This takes into account all the failed previous attempts at trying to get
> an oops to display. It's conceptually a match with your viewoops framework
> I think.

Thanks a lot Daniel for the reference! Yup, this is a conceptual
match indeed!

It's great to know that at the maintainer level there is some
agreement on, awareness of, and plans for, the general topic...

I'll jump to Noralf Trønnes's just-posted patches then and see how
to move from there :)

all the best,

--darwi
http://darwish.chasingpointers.com
