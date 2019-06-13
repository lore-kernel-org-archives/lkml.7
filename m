Return-Path: <SRS0=5wok=UM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 87B2AC31E45
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Jun 2019 16:35:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 59F7821721
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Jun 2019 16:35:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1560443736;
	bh=voKIfi0wvZgyalG6qW+Qe9OYNlUk2m+vLvb+SlTnM8k=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=1xmivZvYc27k9Ios7zPepUyAROPX1feo03THZzwK4BQA0qi9pDl/W1SlfYHTB1K/1
	 nXyjkWn7N4G/b0WO8V+9r0o3l/e9d6czG2HMjfP373BTccKs5tILxJW0Tyx23/gu66
	 NMKis3A3I2DtacjY8ABS7b2QZ4car5duJ2WZY1b4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392312AbfFMQfe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Jun 2019 12:35:34 -0400
Received: from mail.kernel.org ([198.145.29.99]:59262 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730723AbfFMHmN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Jun 2019 03:42:13 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id BFD5C20851;
        Thu, 13 Jun 2019 07:42:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1560411733;
        bh=voKIfi0wvZgyalG6qW+Qe9OYNlUk2m+vLvb+SlTnM8k=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=FDiVMNFLhufffuPt64Zul1Fxzlb1v8WMn+X0ZQHx1zISGP/cNxT9Rc2ugzAgwJZu6
         BUoyWyLfpHCzDqhSh0/4oemHLL7pCwpr03cQjSdqWmYOR9lIGTUOfFvtAZ670hriG6
         INxwJw/FpQZ0lJXZEfwv2T5NCqiggvZyYIVI5FA8=
Date:   Thu, 13 Jun 2019 09:42:10 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Daniel Vetter <daniel.vetter@ffwll.ch>
Cc:     Sven Joachim <svenjoac@gmx.de>, stable <stable@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Dave Airlie <airlied@redhat.com>
Subject: Re: Linux 5.1.9 build failure with
 CONFIG_NOUVEAU_LEGACY_CTX_SUPPORT=n
Message-ID: <20190613074210.GA16875@kroah.com>
References: <87k1dsjkdo.fsf@turtle.gmx.de>
 <20190611153656.GA5084@kroah.com>
 <CAKMK7uH_3P3pYkJ9Ua4hOFno5UiQ4p-rdWu9tPO75MxGCbyXSA@mail.gmail.com>
 <20190611174006.GB31662@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190611174006.GB31662@kroah.com>
User-Agent: Mutt/1.12.0 (2019-05-25)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 11, 2019 at 07:40:06PM +0200, Greg Kroah-Hartman wrote:
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

I've just reverted it now.

If someone can send me a patch series of all of what needs to be
applied, in a format that I can actually apply them in, I will be glad
to do so.  But for now, I'd like to get people's systems building again.

thanks,

greg k-h
