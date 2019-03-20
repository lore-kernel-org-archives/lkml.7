Return-Path: <SRS0=4Jrr=RX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8472FC43381
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Mar 2019 08:26:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 49F56206BA
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Mar 2019 08:26:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727414AbfCTI0X (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Mar 2019 04:26:23 -0400
Received: from mx1.redhat.com ([209.132.183.28]:32028 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726086AbfCTI0X (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Mar 2019 04:26:23 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 3EBD2368B3;
        Wed, 20 Mar 2019 08:26:23 +0000 (UTC)
Received: from sirius.home.kraxel.org (ovpn-116-62.ams2.redhat.com [10.36.116.62])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 96B582E02C;
        Wed, 20 Mar 2019 08:26:22 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
        id CD60511A86; Wed, 20 Mar 2019 09:26:16 +0100 (CET)
Date:   Wed, 20 Mar 2019 09:26:16 +0100
From:   Gerd Hoffmann <kraxel@redhat.com>
To:     Alan Cox <gnomes@lxorguk.ukuu.org.uk>
Cc:     Alexander Pateenok <pateenoc@gmail.com>,
        linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        dri-devel@lists.freedesktop.org,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Subject: Re: Indirect call in vesafb driver
Message-ID: <20190320082616.twns6kjvgapdg4lq@sirius.home.kraxel.org>
References: <20190313145418.bwta37cogo7a4qtt@K55DR>
 <20190319164651.4ec9e3d1@alans-desktop>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190319164651.4ec9e3d1@alans-desktop>
User-Agent: NeoMutt/20180716
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.30]); Wed, 20 Mar 2019 08:26:23 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 19, 2019 at 04:46:51PM +0000, Alan Cox wrote:
> On Wed, 13 Mar 2019 17:54:18 +0300
> Alexander Pateenok <pateenoc@gmail.com> wrote:
> 
> > Hi,
> > 
> > There're several indirect calls in inline assembly in vesafb driver
> > (drivers/video/fbdev/vesafb.c), and these calls cannot be automatically
> > changed to retpolines. It's in vesafb_pan_display():
> > 
> >    73        __asm__ __volatile__(
> >    74                "call *(%%edi)"
> > 
> > and in vesa_setpalette():
> > 
> >   113        __asm__ __volatile__(
> >   114         "call *(%%esi)"
> > 
> > Is there need to use CALL_NOSPEC ?
> 
> Vesafb is from the time on the dinosaurs but yes any vesa bios code will
> not be speculatively hardened. I'd also doubt anyone is actually using
> vesafb in the first place but it should use nospec

Note that even when using vesafb the display panning is disabled by
default, and vesa_setpalette() is only used with 8bit depth (256 color
mode).

Also note that only 32bit builds will try to call vesa bios code ...

cheers,
  Gerd

