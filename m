Return-Path: <SRS0=8QAT=T3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4FBBFC07542
	for <linux-kernel@archiver.kernel.org>; Mon, 27 May 2019 06:52:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2D09F20717
	for <linux-kernel@archiver.kernel.org>; Mon, 27 May 2019 06:52:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726311AbfE0Gwu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 May 2019 02:52:50 -0400
Received: from asavdk4.altibox.net ([109.247.116.15]:47784 "EHLO
        asavdk4.altibox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725940AbfE0Gwt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 May 2019 02:52:49 -0400
Received: from ravnborg.org (unknown [158.248.194.18])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by asavdk4.altibox.net (Postfix) with ESMTPS id A76FB8046D;
        Mon, 27 May 2019 08:52:47 +0200 (CEST)
Date:   Mon, 27 May 2019 08:52:46 +0200
From:   Sam Ravnborg <sam@ravnborg.org>
To:     LKML <linux-kernel@vger.kernel.org>,
        Intel Graphics Development <intel-gfx@lists.freedesktop.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        DRI Development <dri-devel@lists.freedesktop.org>
Subject: Re: [PATCH 11/33] fbdev/sh_mobile: remove
 sh_mobile_lcdc_display_notify
Message-ID: <20190527065246.GB8648@ravnborg.org>
References: <20190524085354.27411-1-daniel.vetter@ffwll.ch>
 <20190524085354.27411-12-daniel.vetter@ffwll.ch>
 <20190525150159.GA27341@ravnborg.org>
 <20190527061306.GG21222@phenom.ffwll.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190527061306.GG21222@phenom.ffwll.local>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-CMAE-Score: 0
X-CMAE-Analysis: v=2.3 cv=VcLZwmh9 c=1 sm=1 tr=0
        a=UWs3HLbX/2nnQ3s7vZ42gw==:117 a=UWs3HLbX/2nnQ3s7vZ42gw==:17
        a=jpOVt7BSZ2e4Z31A5e1TngXxSK0=:19 a=IkcTkHD0fZMA:10 a=7gkXJVJtAAAA:8
        a=cnA9valBEamFauFJ_BIA:9 a=QEXdDO2ut3YA:10 a=E9Po1WZjFZOl8hwRPBS3:22
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 27, 2019 at 08:13:06AM +0200, Daniel Vetter wrote:
> On Sat, May 25, 2019 at 05:01:59PM +0200, Sam Ravnborg wrote:
> > Hi Daniel
> > 
> > > It's dead code, and removing it avoids me having to understand
> > > what it's doing with lock_fb_info.
> > 
> > I pushed the series through my build tests which include the sh
> > architecture.
> > 
> > One error and one warning was triggered from sh_mobile_lcdcfb.c.
> > The rest was fine.
> > 
> > The patch below removed the sole user of
> > sh_mobile_lcdc_must_reconfigure() so this triggers a warning.
> > 
> > And I also get the following error:
> > drivers/video/fbdev/sh_mobile_lcdcfb.c: In function ‘sh_mobile_fb_reconfig’:
> > drivers/video/fbdev/sh_mobile_lcdcfb.c:1800:2: error: implicit declaration of function ‘fbcon_update_vcs’; did you mean ‘file_update_time’? [-Werror=implicit-function-declaration]
> >   fbcon_update_vcs(info, true);
> >   ^~~~~~~~~~~~~~~~
> >   file_update_time
> > 
> > I did not check but assume the error was triggered in patch 28 where
> > fbcon_update_vcs() in introduced.
> 
> Oops. Can I have your sob so I can squash this in?
Yes, here we go. (It was trivial so I thought not needed, sorry)
Signed-off-by: Sam Ravnborg <sam@ravnborg.org>
