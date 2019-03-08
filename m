Return-Path: <SRS0=vL1f=RL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74A03C4360F
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Mar 2019 12:37:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3821D2085A
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Mar 2019 12:37:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1552048620;
	bh=xtINjtJeXvYjuXSDQF0X5NvPusS42IczfXsHIL2Iu+I=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=n1MTlDgKy1CXfPx5VPvPcE6ZYmF5nBX/JhLcXrpIf0n7PEvuEaJl5DQv6fTLYtpql
	 /PMABjSqYg7YPsXWJ3u/mlSjXt8NMz8Ms/XIM0RRm4/yXDVlVqmeB0WeduUwq6q6iX
	 88QfRESSZMqv7aztpTtizadAHba476vv6mZchwZI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726571AbfCHMg6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 Mar 2019 07:36:58 -0500
Received: from mail.kernel.org ([198.145.29.99]:45454 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726298AbfCHMg6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Mar 2019 07:36:58 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2BEAF20851;
        Fri,  8 Mar 2019 12:36:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1552048617;
        bh=xtINjtJeXvYjuXSDQF0X5NvPusS42IczfXsHIL2Iu+I=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=UYdjsJIvkXC25LadhSYipmE5l8d1yH9pSOK5TwKGfBFsnOW0N/ZcIvlWwbvBi2aik
         DeltV62ZzpqSjsoTw+ik2uHSWrpBPB/vEafBSGiLv+rwLbw4eoMDlDoGnAoSdvhtqy
         yHzJiFggSWmFFIiJU3BHlVWPrgc8b4Zf702fMVF0=
Date:   Fri, 8 Mar 2019 13:36:55 +0100
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
Message-ID: <20190308123655.GA13818@kroah.com>
References: <20190305103014.25847-1-kieran.bingham@ideasonboard.com>
 <CAKwvOdnOuXhkwizSnp6qOwJkisHKEBs=2xSvHaus3Yhdx2xE-w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAKwvOdnOuXhkwizSnp6qOwJkisHKEBs=2xSvHaus3Yhdx2xE-w@mail.gmail.com>
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 05, 2019 at 01:47:58PM -0800, Nick Desaulniers wrote:
> On Tue, Mar 5, 2019 at 2:30 AM Kieran Bingham
> <kieran.bingham@ideasonboard.com> wrote:
> >
> > From: Jackie Liu <liuyun01@kylinos.cn>
> >
> > Since commit 1751e8a6cb93 ("Rename superblock flags (MS_xyz -> SB_xyz)"),
> > scripts/gdb should be updated to replace MS_xyz with SB_xyz.
> >
> > This change didn't directly affect the running operation of scripts/gdb until
> > commit e262e32d6bde "vfs: Suppress MS_* flag defs within the kernel unless
> 
> Note to stable, e262e32d6bde landed in v5.0-rc1 (which was just
> released), so we'll want this picked back to 5.0 stable once this
> patch hits mainline (akpm just picked it up).
> 
> Just following up to say that without this, debugging a kernel a
> kernel via GDB+QEMU is broken in the 5.0 release.

I do not understand, sorry.  Specifically, what git commits do you want
applied to which stable releases for what reason?

thanks,

greg k-h
