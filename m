Return-Path: <SRS0=TvG7=UK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76B2CC06508
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Jun 2019 19:39:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4D6F52173E
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Jun 2019 19:39:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ffwll.ch header.i=@ffwll.ch header.b="BN7CXuFG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2407479AbfFKTjR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Jun 2019 15:39:17 -0400
Received: from mail-oi1-f194.google.com ([209.85.167.194]:40140 "EHLO
        mail-oi1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2404788AbfFKTjR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jun 2019 15:39:17 -0400
Received: by mail-oi1-f194.google.com with SMTP id w196so9880727oie.7
        for <linux-kernel@vger.kernel.org>; Tue, 11 Jun 2019 12:39:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=St/sap2qBv8Hsq63+0Q5syfF0d0aWy8Ds6OuEFtVAXU=;
        b=BN7CXuFGuD00uiYGfneiP10UMR/4kb+NYdIMor783WtxbNUDdhf56ynR61aFXzwEBr
         P2VSfjHgsSok7ATwjpTgeT7GB7SFC98yaLc1hrQrArVYg8JqIF1q0vPbCpgAFHoTsFMP
         LJGIM0jkX7Dfqs0o3t8YUP1nQnCZHqGncNP4Y=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=St/sap2qBv8Hsq63+0Q5syfF0d0aWy8Ds6OuEFtVAXU=;
        b=pmxGHmuuvApSQlTWlg00sL4iXiAZB5n34Kun9gepkBm4F3GGeFoPyyPzsKIqMu1iUf
         69OTVb+A2q7hAe8UMuI2EzeIrY7TYbxGJX0tVMoo/vFXiGwd8oPbRNZWbuvMgl9vFJGu
         Ogv9nH2w5bqG1kyEfDNZa4hiayH/zD45KK40i+twZhg7D+1CQ17JRpJNGGB9nWiVQqYk
         JEgKy4BkKxnfw5MGGQ1u8TQb6hAIzXdHGOEJ2/aheYKtUHIqGe3EXDYcuNxMGZD6ETy/
         cmHWUVnbi5WAWsapSNBix0dVcqAdZqa1UhNaQrfr2hxeUEFY8HzzJjZGUtJP8tJGLgab
         5RDQ==
X-Gm-Message-State: APjAAAWh5cuxO3ANUk3/LP0tK2vN5ZMfjcudOq4S+qDzUUTLXdnSGNjL
        t7bQ7xeA8EMMD8xolL2gwsGzR0YPzzsPS2WqCcTYNQ==
X-Google-Smtp-Source: APXvYqzFyhua/G0TG83q68hxIDjw3pEsY0N6defylPtbJFObhBAHHNNUILV9io7UDphgfrJUvIMjcZGuXtEd/sdRVoc=
X-Received: by 2002:aca:62c2:: with SMTP id w185mr17508454oib.110.1560281956544;
 Tue, 11 Jun 2019 12:39:16 -0700 (PDT)
MIME-Version: 1.0
References: <87k1dsjkdo.fsf@turtle.gmx.de> <20190611153656.GA5084@kroah.com>
 <CAKMK7uH_3P3pYkJ9Ua4hOFno5UiQ4p-rdWu9tPO75MxGCbyXSA@mail.gmail.com> <20190611174006.GB31662@kroah.com>
In-Reply-To: <20190611174006.GB31662@kroah.com>
From:   Daniel Vetter <daniel.vetter@ffwll.ch>
Date:   Tue, 11 Jun 2019 21:39:05 +0200
Message-ID: <CAKMK7uGzBD4LzoOTrDoBNaqpPbaWkQ=_h0Q+uqJAsoeDbTnuWA@mail.gmail.com>
Subject: Re: Linux 5.1.9 build failure with CONFIG_NOUVEAU_LEGACY_CTX_SUPPORT=n
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Sven Joachim <svenjoac@gmx.de>, stable <stable@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Dave Airlie <airlied@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 11, 2019 at 7:40 PM Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> On Tue, Jun 11, 2019 at 07:33:16PM +0200, Daniel Vetter wrote:
> > On Tue, Jun 11, 2019 at 5:37 PM Greg Kroah-Hartman
> > <gregkh@linuxfoundation.org> wrote:
> > > On Tue, Jun 11, 2019 at 03:56:35PM +0200, Sven Joachim wrote:
> > > > Commit 1e07d63749 ("drm/nouveau: add kconfig option to turn off nouveau
> > > > legacy contexts. (v3)") has caused a build failure for me when I
> > > > actually tried that option (CONFIG_NOUVEAU_LEGACY_CTX_SUPPORT=n):
> > > >
> > > > ,----
> > > > | Kernel: arch/x86/boot/bzImage is ready  (#1)
> > > > |   Building modules, stage 2.
> > > > |   MODPOST 290 modules
> > > > | ERROR: "drm_legacy_mmap" [drivers/gpu/drm/nouveau/nouveau.ko] undefined!
> > > > | scripts/Makefile.modpost:91: recipe for target '__modpost' failed
> > > > `----
> >
> > Calling drm_legacy_mmap is definitely not a great idea. I think either
> > we need a custom patch to remove that out on older kernels, or maybe
> > even #ifdef if you want to be super paranoid about breaking stuff ...
> >
> > > > Upstream does not have that problem, as commit bed2dd8421 ("drm/ttm:
> > > > Quick-test mmap offset in ttm_bo_mmap()") has removed the use of
> > > > drm_legacy_mmap from nouveau_ttm.c.  Unfortunately that commit does not
> > > > apply in 5.1.9.
> > > >
> > > > Most likely 4.19.50 and 4.14.125 are also affected, I haven't tested
> > > > them yet.
> > >
> > > They probably are.
> > >
> > > Should I just revert this patch in the stable tree, or add some other
> > > patch (like the one pointed out here, which seems an odd patch for
> > > stable...)
> >
> > ... or backport the above patch, that should be save to do too. Not
> > sure what stable folks prefer?
>
> The above patch does not apply to all of the stable branches, so how
> about I just revert this?  People can live with this option not able to
> turn off for now, and if they really want it, they can use a newer
> kernel, right?

Lots of people can live with root holes in their kernels, it's still
not a great idea :-) Plan B would be to fix all the legacy ioctls and
close all the exploits in there, which absolutely no one wants to
spend time on. This way the only people who'll suffer are the ones
with horribly outdated userspace (and at that point who cares about a
few more exploits).

We should maybe update the help text to tell people they really
shouldn't enable this, the default y is really just to avoid
regression reports :-)
-Daniel
-- 
Daniel Vetter
Software Engineer, Intel Corporation
+41 (0) 79 365 57 48 - http://blog.ffwll.ch
