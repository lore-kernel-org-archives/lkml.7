Return-Path: <SRS0=L2S5=S2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4CE56C282E1
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 14:07:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 144D121902
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 14:07:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1556114851;
	bh=H/7+poEazD4Qbsh7nf081O8SJfDCMwNxTSOeGErpk48=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=uV2CdSKpF3qauXhHONiYi2Juvjp2wZeTt6Pmp5E624D1sihaZfTo9wSEnwpOG609a
	 37vv/Auh6SPbGviJVUr+8yyZR12LNopGiBmsjPlW/qXUQi89UQR7gm2+jzgPIjfh2r
	 Jm4uF4djrasZF/B9X4LRJtz9hvjPBoC0Xfl6bUQQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727888AbfDXOHa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Apr 2019 10:07:30 -0400
Received: from mail.kernel.org ([198.145.29.99]:54742 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727486AbfDXOH3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Apr 2019 10:07:29 -0400
Received: from localhost (62-193-50-229.as16211.net [62.193.50.229])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id AF9FD218FE;
        Wed, 24 Apr 2019 14:07:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1556114849;
        bh=H/7+poEazD4Qbsh7nf081O8SJfDCMwNxTSOeGErpk48=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=qWeXgo6mRkYTZmeFtg3re8nG6B3lKR80RlgkpONo104XtlSEXDzWPLamQ9i21s09y
         Gy21P6ZF8+eHAFZcg3teYLCvYYfsff+IXvu/IT0/oJcjZZFjQkHGoIH24Hv9KNlMwd
         WjQIwf/R6iZi9Gi5UHt3AMAfwK9KGY4HcNUNCxwM=
Date:   Wed, 24 Apr 2019 16:07:26 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Heiko Stuebner <heiko@sntech.de>
Cc:     Doug Anderson <dianders@chromium.org>, stable@vger.kernel.org,
        Katsuhiro Suzuki <katsuhiro@katsuster.net>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        "open list:ARM/Rockchip SoC..." <linux-rockchip@lists.infradead.org>,
        ALSA Development Mailing List <alsa-devel@alsa-project.org>,
        Mark Brown <broonie@kernel.org>,
        Urja Rannikko <urjaman@gmail.com>
Subject: Re: [alsa-devel] [PATCH] ASoC: rockchip: add missing INTERLEAVED PCM
 attribute
Message-ID: <20190424140726.GA28008@kroah.com>
References: <20180910163932.13722-1-katsuhiro@katsuster.net>
 <CAD=FV=WKV3eLsg3mWpmCWYjvk2JY4_Q-20v1Ohzy=02+LjpPnw@mail.gmail.com>
 <20190424134536.GA20271@kroah.com>
 <2153141.WrWJEDd2yy@phil>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2153141.WrWJEDd2yy@phil>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 24, 2019 at 03:53:54PM +0200, Heiko Stuebner wrote:
> Am Mittwoch, 24. April 2019, 15:45:36 CEST schrieb Greg KH:
> > On Tue, Apr 23, 2019 at 03:26:42PM -0700, Doug Anderson wrote:
> > > Hi,
> > > 
> > > On Sep 10, 2018 at 4:39 PM Katsuhiro Suzuki <katsuhiro@katsuster.net> wrote:
> > > >
> > > > This patch adds SNDRV_PCM_INFO_INTERLEAVED into PCM hardware info.
> > > >
> > > > Signed-off-by: Katsuhiro Suzuki <katsuhiro@katsuster.net>
> > > > ---
> > > >  sound/soc/rockchip/rockchip_pcm.c | 3 ++-
> > > >  1 file changed, 2 insertions(+), 1 deletion(-)
> > > 
> > > I just tracked down that audio was broken on 4.19 and needs this
> > > change to work.  Stable: can you please pick it?  Specifically I
> > > believe you'd want to treat it as if it had:
> > > 
> > > Fixes: 75b31192fe6a ("ASoC: rockchip: add config for rockchip
> > > dmaengine pcm register")
> > 
> > What is the git commit id of this patch in Linus's tree?
> 
> Commit id is 24d6638302b48328a58c13439276d4531af4ca7d [0]
> 
> [0] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=24d6638302b48328a58c13439276d4531af4ca7d

Thanks, now queued up.

greg k-h
