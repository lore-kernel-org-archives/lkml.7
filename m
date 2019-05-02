Return-Path: <SRS0=c+yg=TC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E50FCC43219
	for <linux-kernel@archiver.kernel.org>; Thu,  2 May 2019 18:34:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BB30A20C01
	for <linux-kernel@archiver.kernel.org>; Thu,  2 May 2019 18:34:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="L9VDpZd7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726120AbfEBSeI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 May 2019 14:34:08 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:43613 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726114AbfEBSeH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 May 2019 14:34:07 -0400
Received: by mail-pg1-f196.google.com with SMTP id t22so1433467pgi.10
        for <linux-kernel@vger.kernel.org>; Thu, 02 May 2019 11:34:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=9pb3Jn+Vd+nDYRO/WKHx1a5dMNfMG+2SwDRrQcgz14A=;
        b=L9VDpZd7yhW7D4dES1p8F41DXoL4cI3oVP+xeAgaVLAPRICbbOmA8zCIYc8C7R10Ze
         aCmnVONmStqlxASn958ixGMTiMe42NqhfrNP+IeyeHPz2U1dvNMIducxvXB5BrKhRFNT
         zFlkpyzKVJRe9BvjM2tdiX78/f+qY+6yrjlCPuDfuiIRnEKQddP5LNl+3KwMh7QhYB0p
         Qy/FnzYhkVHiPrnt9wPbeHn0ZbMyZtpwYNuRyfwfzQ4kCnnS6/XX1bWAsy8psDCMq6b9
         BdAZe1Ovpcb4kKWCP4t8G8K/7CJlXKC2fhUlMn2PklQX4oPYNEiPuLfsvnp1XZAEL0sD
         0aGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=9pb3Jn+Vd+nDYRO/WKHx1a5dMNfMG+2SwDRrQcgz14A=;
        b=smmSXsdEeQzfiG3UOC0nuuRebTmruxVU+rxljGcWNFEFzDeEu4HldMyczIGCnnMZN/
         3/BCBOu5toJL5K/10Ftu47zP/ZdPefxjF12jHJ6rxZXkrsCeujhu66TEY/VVDTDizW1g
         QOj2sdx21l6YTdaii4pq50Aq7Ofu3WUqAkoT2uce7ad+zPZlRuQISwOcBcEvTFpyvOpD
         ljWnkCkzfwAOItj65SqdoN6Lu2HQkZb7BkTrzWk3iiDZPIMEw9uIhsbNSrX2OAW1iF1G
         4IuS/wjGIX01XFu0aOG5A9mjrsLeicobrnpz8a/YQc7Oq7LAgF1RfCcNHwrNub7qPxNf
         y7dw==
X-Gm-Message-State: APjAAAXPTfi6/4pXBNeytKxJ6sqHVw51I7D6EsOfFyNW0sh7r2VOGyBG
        jDNl9zmX+8+/CF+UnNFfV71h8ciR27c=
X-Google-Smtp-Source: APXvYqwJitXju3fizMVEW7pWswOKDMbqed3Yj6lTTZT5fp0epxAX+wzjtiPHMb8hQMZDeFkYoswyMQ==
X-Received: by 2002:a62:e501:: with SMTP id n1mr5757562pff.17.1556822046126;
        Thu, 02 May 2019 11:34:06 -0700 (PDT)
Received: from Asurada-Nvidia.nvidia.com (thunderhill.nvidia.com. [216.228.112.22])
        by smtp.gmail.com with ESMTPSA id n15sm34696825pfb.111.2019.05.02.11.34.05
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 02 May 2019 11:34:05 -0700 (PDT)
Date:   Thu, 2 May 2019 11:32:31 -0700
From:   Nicolin Chen <nicoleotsuka@gmail.com>
To:     "S.j. Wang" <shengjiu.wang@nxp.com>
Cc:     Mark Brown <broonie@kernel.org>,
        "timur@kernel.org" <timur@kernel.org>,
        "Xiubo.Lee@gmail.com" <Xiubo.Lee@gmail.com>,
        "festevam@gmail.com" <festevam@gmail.com>,
        "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>,
        "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [EXT] Re: [PATCH V4] ASoC: fsl_esai: Add pm runtime function
Message-ID: <20190502183230.GA25229@Asurada-Nvidia.nvidia.com>
References: <c4cf809a66b8c98de11e43f7e9fa2823cf3c5ba6.1556417687.git.shengjiu.wang@nxp.com>
 <20190502023945.GA19532@sirena.org.uk>
 <VE1PR04MB6479F3EED50613DF8F041713E3340@VE1PR04MB6479.eurprd04.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <VE1PR04MB6479F3EED50613DF8F041713E3340@VE1PR04MB6479.eurprd04.prod.outlook.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 02, 2019 at 09:13:58AM +0000, S.j. Wang wrote:
> > On Sun, Apr 28, 2019 at 02:24:54AM +0000, S.j. Wang wrote:
> > > Add pm runtime support and move clock handling there.
> > > Close the clocks at suspend to reduce the power consumption.
> > >
> > > fsl_esai_suspend is replaced by pm_runtime_force_suspend.
> > > fsl_esai_resume is replaced by pm_runtime_force_resume.
> > 
> > This doesn't apply against for-5.2 again.  Sorry about this, I think this one is
> > due to some messups with my scripts which caused some patches to be
> > dropped for a while (and it's likely to be what happened the last time as
> > well).  Can you check and resend again please?  Like I say sorry about this, I
> > think it's my mistake.
> 
> I am checking, but I don't know why this patch failed in your side. I 
> Tried to apply this patch on for-5.1, for 5.2,  for-linus  and for-next, all are

I just tried to apply it against top of trees of for-next and for-5.2
and both were fine on my side too.

> Successful.  The git is git://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git.

Btw, this git link no longer works for me, not sure why:
# git remote add broonie git://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git
# git fetch broonie
fatal: remote error: access denied or repository not exported: /m/korg/pub/scm/linux/kernel/git/broonie/sound.git

It started to work after I changed "git://" to "https://" though...
