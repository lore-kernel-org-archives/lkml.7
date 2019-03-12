Return-Path: <SRS0=J4ZE=RP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4A0D9C43381
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Mar 2019 09:19:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 138EC214AF
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Mar 2019 09:19:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=tomli.me header.i=@tomli.me header.b="Jqbkbneh"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726385AbfCLJTq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Mar 2019 05:19:46 -0400
Received: from tomli.me ([153.92.126.73]:53228 "EHLO tomli.me"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725767AbfCLJTp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Mar 2019 05:19:45 -0400
Received: from tomli.me (localhost [127.0.0.1])
        by tomli.me (OpenSMTPD) with ESMTP id d07dabd9;
        Tue, 12 Mar 2019 09:19:42 +0000 (UTC)
X-HELO: localhost.localdomain
Authentication-Results: tomli.me; auth=pass (login) smtp.auth=tomli
Received: from Unknown (HELO localhost.localdomain) (2402:f000:1:1501:200:5efe:3d33:ceae)
 by tomli.me (qpsmtpd/0.95) with ESMTPSA (DHE-RSA-CHACHA20-POLY1305 encrypted); Tue, 12 Mar 2019 09:19:41 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=tomli.me; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:in-reply-to; s=1490979754; bh=3+8mC/5CURHzM97+bVX0v3NzwZuZY+wkRKDQCW362qs=; b=Jqbkbnehg9WWi1ATvoduHo+bACPzl33AlVoiyD9QhKM8ubXvwRP4Ct9Z2ZGaghV5J9uPwRRGWcs86JS9WymTIkNCTYGLfEFw2kcsbd4sAZUskNqH6pE7W1eO4Ptayj0vXcIPKAJ04h0s0EBoGnvX0jGAXmnfB+tyUM6RBsoAQOC0AR1m3jDi2O6O0XxGQldo7cuxxrvhDdMB/tStzVbdwTbSdZqIHuj+suPfEAf7d6yCi/UKtz+DURCkv1zrR0lzP6fa7lpW2TEEkXQDcHIQMJjwqvBLtY3Lww8CxSoRW5UFZid/VgLZUSqybQrDMeIug5kCfQSGsnS7pGOcBL9EYQ==
Date:   Tue, 12 Mar 2019 17:19:32 +0800
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
Message-ID: <20190312091932.GA17859@localhost.localdomain>
References: <20190307051641.GA7012@localhost.localdomain>
 <871s3jm532.fsf@intel.com>
 <CAMuHMdU_+4_T4B67Z-Y-wgHQs6o1yuh9H4m82Lym+_Jno5Mgzg@mail.gmail.com>
 <20190307213759.GA14798@localhost.localdomain>
 <CAMuHMdVnkdrUTL_3UaoaOondGxCB_FpEYOTDmLeh1C0W5j0-Hw@mail.gmail.com>
 <20190308103536.GA17258@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190308103536.GA17258@localhost.localdomain>
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 08, 2019 at 06:35:36PM +0800, Tom Li wrote:
> On Fri, Mar 08, 2019 at 10:13:58AM +0100, Geert Uytterhoeven wrote:
> > On Thu, Mar 7, 2019 at 10:38 PM Tom Li <tomli@tomli.me> wrote:
> > > Nevertheless, does it mean there's no way to prevent it from happening if the
> > > user issues a emergency reboot? Like an automatic reboot after a kernel panic,
> > > or a SysRq-B reboot.
> > 
> > If Linux performs a reboot, it calls the shutdown handlers.
> > I think that includes reboot on panic, or SysRq-B, but I'd have to check to
> > be 100% sure.
> 
> Okay, glad to hear that. If it works for SysRq-B or panic reboot, I think
> it would be enough. After all, hard kernel crashes are rare nowadays, and
> most crashes are hard lockups. In case it happens, the user just presses
> the power button to halt.

As I suspected, emergency reboot via SysRq-B is a hard reboot and none of the
reboot handler will be called. I've put a for (;;) {} loop in .shutdown(), the
kernel would hang during a normal reboot, but a SysRq-B reboot will reset the
machine immediately.

Fortunately, I've found a way to stop trigger the bug in the driver, so no
shutdown handler is needed anymore.

Cheers,
Tom Li
