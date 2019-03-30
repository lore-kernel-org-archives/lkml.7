Return-Path: <SRS0=yJb2=SB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 909ACC43381
	for <linux-kernel@archiver.kernel.org>; Sat, 30 Mar 2019 09:40:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5DF38218D0
	for <linux-kernel@archiver.kernel.org>; Sat, 30 Mar 2019 09:40:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1553938845;
	bh=UUUsc2YEK6jUrQB1mE7DirtN25/9BTwMtnB1WDaIO88=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=GPmBbkBBmnfQDeirzqj2O/2K6zd8bNvxCBHYGJYDwJPWf2lGXLIuYiHi4qmc16IVS
	 WFXGrSLtSUKfuJRfgu0eiOIjN+M5U3ILyZx1uZFHEdrmHM5UwwGHx7U3ARq4Zi9bAw
	 C5jFz7mB+TPxHeQFTmj0XaPsGj2vy9ganZqPhUVw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730579AbfC3Jko (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 30 Mar 2019 05:40:44 -0400
Received: from mail.kernel.org ([198.145.29.99]:36860 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730352AbfC3Jkn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 30 Mar 2019 05:40:43 -0400
Received: from localhost (unknown [62.119.166.9])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 10E25218A6;
        Sat, 30 Mar 2019 09:40:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1553938842;
        bh=UUUsc2YEK6jUrQB1mE7DirtN25/9BTwMtnB1WDaIO88=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=b9wY18usn8EbvWTIueyf8KLg67mSElrt3kzu1dHQvRzuvYqLhF/bDIGAl6b/2ehbd
         RPSLJqO5DYL+ClrX0ENpZKUfzzZpGO0/7ftYcLp/mP8yei95GUVdvZlsryiWNzINBf
         jHa/eLFIAdE7s4iuEQi7UO/b0BEULlsv5UNhoSkQ=
Date:   Sat, 30 Mar 2019 10:40:39 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     "# 3.4.x" <stable@vger.kernel.org>, Vinod Koul <vkoul@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Ravindra Lokhande <rlokhande@nvidia.com>,
        Vinod Koul <vinod.koul@intel.com>,
        Takashi Iwai <tiwai@suse.de>, Mark Brown <broonie@kernel.org>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Joe Perches <joe@perches.com>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        ALSA Development Mailing List <alsa-devel@alsa-project.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [BACKPORT 4.4.y 02/25] ALSA: compress: add support for 32bit
 calls in a 64bit kernel
Message-ID: <20190330094039.GA17316@kroah.com>
References: <20190322154425.3852517-1-arnd@arndb.de>
 <20190322154425.3852517-3-arnd@arndb.de>
 <20190326010911.GB29420@kroah.com>
 <CAK8P3a22Mp9yR49CEe2bq240SuSpbvy1XBDa2sSvWYMt=AZM3Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAK8P3a22Mp9yR49CEe2bq240SuSpbvy1XBDa2sSvWYMt=AZM3Q@mail.gmail.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 26, 2019 at 08:55:14AM +0100, Arnd Bergmann wrote:
> On Tue, Mar 26, 2019 at 2:23 AM Greg KH <gregkh@linuxfoundation.org> wrote:
> >
> > On Fri, Mar 22, 2019 at 04:43:53PM +0100, Arnd Bergmann wrote:
> > > From: Ravindra Lokhande <rlokhande@nvidia.com>
> > >
> > > Compress offload does not support ioctl calls from a 32bit userspace
> > > in a 64 bit kernel. This patch adds support for ioctls from a 32bit
> > > userspace in a 64bit kernel
> > >
> > > Signed-off-by: Ravindra Lokhande <rlokhande@nvidia.com>
> > > Acked-by: Vinod Koul <vinod.koul@intel.com>
> > > Signed-off-by: Takashi Iwai <tiwai@suse.de>
> > > (cherry picked from commit c10368897e104c008c610915a218f0fe5fa4ec96)
> > > Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> > > ---
> > >  sound/core/compress_offload.c | 13 +++++++++++++
> > >  1 file changed, 13 insertions(+)
> >
> > How is this not a "new feature"?  What bug does this fix?  Has this ever
> > worked in the past?
> 
> It has never worked in the past, but I consider it a bug for the compat layer
> to behave differently from native code. In this case, any 32-bit application
> using the SNDRV_COMPRESS_* ioctls will just fail to do anything on
> a 64-bit kernel at all without the trivial fix that should have been there when
> the driver was originally merged.

Ok, fair enough, now queued up.

greg k-h
