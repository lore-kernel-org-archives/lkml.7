Return-Path: <SRS0=vL1f=RL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BDC96C43381
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Mar 2019 10:35:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 74C0D20854
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Mar 2019 10:35:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=tomli.me header.i=@tomli.me header.b="Kjx6zL4e"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726443AbfCHKfu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 Mar 2019 05:35:50 -0500
Received: from tomli.me ([153.92.126.73]:49410 "EHLO tomli.me"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726261AbfCHKfu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Mar 2019 05:35:50 -0500
Received: from tomli.me (localhost [127.0.0.1])
        by tomli.me (OpenSMTPD) with ESMTP id f1c332d7;
        Fri, 8 Mar 2019 10:35:47 +0000 (UTC)
X-HELO: localhost.localdomain
Authentication-Results: tomli.me; auth=pass (login) smtp.auth=tomli
Received: from Unknown (HELO localhost.localdomain) (2402:f000:1:1501:200:5efe:72f4:b31)
 by tomli.me (qpsmtpd/0.95) with ESMTPSA (DHE-RSA-CHACHA20-POLY1305 encrypted); Fri, 08 Mar 2019 10:35:46 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=tomli.me; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:in-reply-to; s=1490979754; bh=t9wemqcEPJHkmqGG1fVbiGvM/fm7piN+icR+Ynx6f/o=; b=Kjx6zL4e3/ejaNt60TP/meuBpEcb+zXdiZioZ3dX0Ec3yil9NKRu4CNxRQ9OAW0LNMyLFHJomHlCn+LgUvnN6YlTOSyVWJrXVItzoD+XN7LwVk6jTKIkqJ36vykdAt9NOVPHS5oh9i6C5oqLr8MbK3vwJZx6Nf7WtqKBz+5y8AuK+SENE/KDW8Ql76c2c9yloRVR5F6vcUdFqq1i9a1wqnfdbN6Phm1ftey2lKA2gNr31qbNVejZd9g+ZoG6Bk2lEk3FqeTZktMN70EaOjoKNXSnFn+ifc1RKX4t9q3j79VNIcmnv4hcAMC0j70Gg0Ku9Ee+0/w7i5XmCvruplGoRA==
Date:   Fri, 8 Mar 2019 18:35:36 +0800
From:   Tom Li <tomli@tomli.me>
To:     Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     Jani Nikula <jani.nikula@linux.intel.com>,
        Linux Fbdev development list <linux-fbdev@vger.kernel.org>,
        DRI Development <dri-devel@lists.freedesktop.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Sudip Mukherjee <sudipm.mukherjee@gmail.com>,
        Teddy Wang <teddy.wang@siliconmotion.com>
Subject: Re: Is it possible to reset graphics controller on reboot in a
 framebuffer driver?
Message-ID: <20190308103536.GA17258@localhost.localdomain>
References: <20190307051641.GA7012@localhost.localdomain>
 <871s3jm532.fsf@intel.com>
 <CAMuHMdU_+4_T4B67Z-Y-wgHQs6o1yuh9H4m82Lym+_Jno5Mgzg@mail.gmail.com>
 <20190307213759.GA14798@localhost.localdomain>
 <CAMuHMdVnkdrUTL_3UaoaOondGxCB_FpEYOTDmLeh1C0W5j0-Hw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAMuHMdVnkdrUTL_3UaoaOondGxCB_FpEYOTDmLeh1C0W5j0-Hw@mail.gmail.com>
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 08, 2019 at 10:13:58AM +0100, Geert Uytterhoeven wrote:
> Hi Tom,
> 
> If the kernel just crashes, of course all of that doesn't happen.
> Is your graphics card reset when the reset button is pressed, or only on
> cold power on?

It's a laptop, so it doesn't have a reset button. I've tried reboot=cold/warn
but apparently it doesn't make any difference. So I think only a cold boot can
reset the graphics card.

> On Thu, Mar 7, 2019 at 10:38 PM Tom Li <tomli@tomli.me> wrote:
> > Nevertheless, does it mean there's no way to prevent it from happening if the
> > user issues a emergency reboot? Like an automatic reboot after a kernel panic,
> > or a SysRq-B reboot.
> 
> If Linux performs a reboot, it calls the shutdown handlers.
> I think that includes reboot on panic, or SysRq-B, but I'd have to check to
> be 100% sure.

Okay, glad to hear that. If it works for SysRq-B or panic reboot, I think
it would be enough. After all, hard kernel crashes are rare nowadays, and
most crashes are hard lockups. In case it happens, the user just presses
the power button to halt.

NMI watchdog reset is still an issue though, but I don't think people who
are playing with those ~1999-2002 hardware (like this one) is actually using
it. Anyway, In this case, I think putting a special note in the documentation,
and raising a warning in dmesg (WARNING: LCD output may be corrupted on reset,
read ./Documentation/fb/sm712fb.txt!) would be adequate.

Thanks,
Tom Li
