Return-Path: <SRS0=uyI7=RK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D34FAC43381
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Mar 2019 21:38:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A23A520851
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Mar 2019 21:38:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=tomli.me header.i=@tomli.me header.b="Gy+DBxv4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726715AbfCGViN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 Mar 2019 16:38:13 -0500
Received: from tomli.me ([153.92.126.73]:48562 "EHLO tomli.me"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726307AbfCGViM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Mar 2019 16:38:12 -0500
Received: from tomli.me (localhost [127.0.0.1])
        by tomli.me (OpenSMTPD) with ESMTP id 41d596ab;
        Thu, 7 Mar 2019 21:38:10 +0000 (UTC)
X-HELO: localhost.localdomain
Authentication-Results: tomli.me; auth=pass (login) smtp.auth=tomli
Received: from Unknown (HELO localhost.localdomain) (2402:f000:1:1501:200:5efe:72f4:b31)
 by tomli.me (qpsmtpd/0.95) with ESMTPSA (DHE-RSA-CHACHA20-POLY1305 encrypted); Thu, 07 Mar 2019 21:38:09 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=tomli.me; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:in-reply-to; s=1490979754; bh=cy8GnP8uMbw3SBpS6/wU5liaYVMWHL72tzD+C3m1Buw=; b=Gy+DBxv4kE0F4TNyxVUnrktbrHl7ySfmK8awNUHIzwYh89x7Xch2nh66Ph93Kfza+9+h8HsAwkdM846rVd0FaHYe2pbHORBOxDUY73aV0iwSU1uqCLHWB30PVE+ko3atFihiONdym38N+4vIPb385JmorUM8Cb55osHk8Xqh/IwmRZCI+lAChz4kWOlYGNY9/NEjSeW2cTy9rvLPHrBBCaUNXavKrge6w6wSTrs1apqqjqcLnGJ+qFbiVXDFrYNNQ3g7OY8gmnTZJ+fYdyBtXCjRcZjTmNxQqJSEBKegmH/M+iDk5/159owBIY9MOzFLdZwFs9SIASyDvqycHeL1xA==
Date:   Fri, 8 Mar 2019 05:38:00 +0800
From:   Tom Li <tomli@tomli.me>
To:     Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     Jani Nikula <jani.nikula@linux.intel.com>,
        Linux Fbdev development list <linux-fbdev@vger.kernel.org>,
        DRI Development <dri-devel@lists.freedesktop.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Sudip Mukherjee <sudipm.mukherjee@gmail.com>,
        Yifeng Li <tomli@tomli.me>,
        Teddy Wang <teddy.wang@siliconmotion.com>
Subject: Re: Is it possible to reset graphics controller on reboot in a
 framebuffer driver?
Message-ID: <20190307213759.GA14798@localhost.localdomain>
References: <20190307051641.GA7012@localhost.localdomain>
 <871s3jm532.fsf@intel.com>
 <CAMuHMdU_+4_T4B67Z-Y-wgHQs6o1yuh9H4m82Lym+_Jno5Mgzg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAMuHMdU_+4_T4B67Z-Y-wgHQs6o1yuh9H4m82Lym+_Jno5Mgzg@mail.gmail.com>
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 07, 2019 at 10:39:23AM +0100, Geert Uytterhoeven wrote:
> On Thu, Mar 7, 2019 at 10:00 AM Jani Nikula <jani.nikula@linux.intel.com> wrote:
> > It's possible to do this using a reboot notifier. I am not sure if there
> > are better ways to achieve the same, but there's at least one example of
> > using reboot notifiers to achieve the exact same goal.
> >
> > See drivers/video/fbdev/aty/atyfb_base.c, look for
> > register_reboot_notifier().
> 
> Or a shutdown handler, which is more device-centric?
> (cfr. "[3/4] fbdev: atafb: Fix broken frame buffer after kexec",
>  https://patchwork.kernel.org/patch/10814381/).
> 
> Gr{oetje,eeting}s,

Thanks, I knew reboot_notifier but I thought it feels "hacky" to use it in a
device driver, shutdown() handler looks better.

Nevertheless, does it mean there's no way to prevent it from happening if the
user issues a emergency reboot? Like an automatic reboot after a kernel panic,
or a SysRq-B reboot.

Tom Li
