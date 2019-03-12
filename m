Return-Path: <SRS0=J4ZE=RP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7898C10F00
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Mar 2019 12:50:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8CF5C2075C
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Mar 2019 12:50:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1552395034;
	bh=sbgUd944nB9q8oRkPn6ojv8UZt89CGoCa4EbBFFT2Wk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=eloXfZFrNN2LZXRvsHS5VlWgzW35h9+S7fED5r1qZrf6jFEcji24XaI0VPKXGlfij
	 /pN2CG609ZANT++0rI8bFsjcBcf6qEH1ltOXS2tbCiSsZdhp5Rcz7diqnczm7ns5P/
	 hEFRUiIpPtpo7WU1ou734cjaQU8VCZkklE7lGEhc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726539AbfCLMud (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Mar 2019 08:50:33 -0400
Received: from mail.kernel.org ([198.145.29.99]:39362 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725844AbfCLMud (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Mar 2019 08:50:33 -0400
Received: from localhost (unknown [12.27.65.221])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4360E206BA;
        Tue, 12 Mar 2019 12:50:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1552395032;
        bh=sbgUd944nB9q8oRkPn6ojv8UZt89CGoCa4EbBFFT2Wk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=DEvsVR7BncZzJXEDKJ6V68wl1D8WDbHVbNrjgKgD4CeimjcRyVagjrAReUNssUoCw
         KQ0O4dxIGL/w0RzDD+TAgymWN8AeFh3461JSapZhKAg9DPs0yoaZDrxUy8BVCjwVgz
         4YaHmN85Rwvl71aLUl3RxX0KgpxeuqXhuR7+DO8k=
Date:   Tue, 12 Mar 2019 05:50:31 -0700
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Nick Desaulniers <ndesaulniers@google.com>
Cc:     stable@vger.kernel.org, Sasha Levin <sashal@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Jan Kiszka <jan.kiszka@siemens.com>,
        Jackie Liu <liuyun01@kylinos.cn>,
        Kieran Bingham <kbingham@kernel.org>,
        Felipe Balbi <felipe.balbi@linux.intel.com>,
        Dan Robertson <danlrobertson89@gmail.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Kieran Bingham <kieran.bingham@ideasonboard.com>
Subject: Re: [PATCH v3] scripts/gdb: replace flags (MS_xyz -> SB_xyz)
Message-ID: <20190312125031.GB23540@kroah.com>
References: <20190305103014.25847-1-kieran.bingham@ideasonboard.com>
 <CAKwvOdnOuXhkwizSnp6qOwJkisHKEBs=2xSvHaus3Yhdx2xE-w@mail.gmail.com>
 <20190308123655.GA13818@kroah.com>
 <CAKwvOdm8nbXvjgOk4eqYQYG3uXLGJhgHe7DspB0nF18+POx8Eg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAKwvOdm8nbXvjgOk4eqYQYG3uXLGJhgHe7DspB0nF18+POx8Eg@mail.gmail.com>
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 08, 2019 at 12:56:28PM -0800, Nick Desaulniers wrote:
> On Fri, Mar 8, 2019 at 4:37 AM Greg KH <gregkh@linuxfoundation.org> wrote:
> >
> > On Tue, Mar 05, 2019 at 01:47:58PM -0800, Nick Desaulniers wrote:
> > > On Tue, Mar 5, 2019 at 2:30 AM Kieran Bingham
> > > <kieran.bingham@ideasonboard.com> wrote:
> > > >
> > > > From: Jackie Liu <liuyun01@kylinos.cn>
> > > >
> > > > Since commit 1751e8a6cb93 ("Rename superblock flags (MS_xyz -> SB_xyz)"),
> > > > scripts/gdb should be updated to replace MS_xyz with SB_xyz.
> > > >
> > > > This change didn't directly affect the running operation of scripts/gdb until
> > > > commit e262e32d6bde "vfs: Suppress MS_* flag defs within the kernel unless
> > >
> > > Note to stable, e262e32d6bde landed in v5.0-rc1 (which was just
> > > released), so we'll want this picked back to 5.0 stable once this
> > > patch hits mainline (akpm just picked it up).
> > >
> > > Just following up to say that without this, debugging a kernel a
> > > kernel via GDB+QEMU is broken in the 5.0 release.
> >
> > I do not understand, sorry.  Specifically, what git commits do you want
> > applied to which stable releases for what reason?
> 
> commits: 663cb6340c6e
> release: 5.0
> reason: kernel debugging scripts in gdb are broken since v5.0-rc1 via
> e262e32d6bde

Ok, now queued up, thanks.

greg k-h
