Return-Path: <SRS0=L2S5=S2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66C51C282CE
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 13:45:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 30C1B218DA
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 13:45:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1556113541;
	bh=UWPQQzZDOw35nAjsIVmIl4SovbpSgdZkxtsUF4eH6WA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=sPk63UUp9qy+cvrJKvksYCeKH5Y/7xfA9z6K+vBT962KgRR7JvVmCiJtdOig8+AQy
	 OYZ3Fddxv0MVQ1tZAdN6+V83FP4EqkjldZ9mGA6dgN1gIpAX8BQ+2rRsSCN+wpNV8q
	 i3EJ0T/Qx6edxTGhc/eKn7TxctLm74gCHh/U0yGM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730617AbfDXNpj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Apr 2019 09:45:39 -0400
Received: from mail.kernel.org ([198.145.29.99]:45148 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727112AbfDXNpj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Apr 2019 09:45:39 -0400
Received: from localhost (62-193-50-229.as16211.net [62.193.50.229])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 48FB52089F;
        Wed, 24 Apr 2019 13:45:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1556113538;
        bh=UWPQQzZDOw35nAjsIVmIl4SovbpSgdZkxtsUF4eH6WA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=WEYcofGKIaf/jOOzyE+uBx/CDp2K80RJ+vE9I82sLFrKv4AY6/liSJ3VnwrdYNwk9
         g3eqjgNCoTJPeFLJsBE9ygHGm47ldmwC1IQeS7E7IpCFueO3kaGPkGbV9yIG/6G6sA
         F+24LBlC9OO8mHpWkfyFUHgxOw51BEYf7uOtj9qU=
Date:   Wed, 24 Apr 2019 15:45:36 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Doug Anderson <dianders@chromium.org>
Cc:     stable@vger.kernel.org, Katsuhiro Suzuki <katsuhiro@katsuster.net>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        "open list:ARM/Rockchip SoC..." <linux-rockchip@lists.infradead.org>,
        ALSA Development Mailing List <alsa-devel@alsa-project.org>,
        Heiko Stuebner <heiko@sntech.de>,
        Mark Brown <broonie@kernel.org>,
        Urja Rannikko <urjaman@gmail.com>
Subject: Re: [alsa-devel] [PATCH] ASoC: rockchip: add missing INTERLEAVED PCM
 attribute
Message-ID: <20190424134536.GA20271@kroah.com>
References: <20180910163932.13722-1-katsuhiro@katsuster.net>
 <CAD=FV=WKV3eLsg3mWpmCWYjvk2JY4_Q-20v1Ohzy=02+LjpPnw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAD=FV=WKV3eLsg3mWpmCWYjvk2JY4_Q-20v1Ohzy=02+LjpPnw@mail.gmail.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 23, 2019 at 03:26:42PM -0700, Doug Anderson wrote:
> Hi,
> 
> On Sep 10, 2018 at 4:39 PM Katsuhiro Suzuki <katsuhiro@katsuster.net> wrote:
> >
> > This patch adds SNDRV_PCM_INFO_INTERLEAVED into PCM hardware info.
> >
> > Signed-off-by: Katsuhiro Suzuki <katsuhiro@katsuster.net>
> > ---
> >  sound/soc/rockchip/rockchip_pcm.c | 3 ++-
> >  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> I just tracked down that audio was broken on 4.19 and needs this
> change to work.  Stable: can you please pick it?  Specifically I
> believe you'd want to treat it as if it had:
> 
> Fixes: 75b31192fe6a ("ASoC: rockchip: add config for rockchip
> dmaengine pcm register")

What is the git commit id of this patch in Linus's tree?

thanks,

greg k-h
