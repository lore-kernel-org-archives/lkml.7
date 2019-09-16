Return-Path: <SRS0=w+Kb=XL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9369C49ED7
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Sep 2019 22:43:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7F5ED21670
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Sep 2019 22:43:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IMUR9inG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387432AbfIPWnH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 16 Sep 2019 18:43:07 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:43538 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727803AbfIPWnH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Sep 2019 18:43:07 -0400
Received: by mail-pg1-f193.google.com with SMTP id u72so797790pgb.10
        for <linux-kernel@vger.kernel.org>; Mon, 16 Sep 2019 15:43:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=cBZmVkDcKZz5zZDlHp5T39g0CCRjx154L73p3yLa6i4=;
        b=IMUR9inG/mwmcrmffeDDt03n3boFWWZwMhpmFtIhuW8MN3yX8L6SCfAknaT4kLGDek
         EmwPLX+yhIByGkpmzhWfqSRoaR7D+GP1+JsN6zESyBBEhY4/5gI8nMNniKe7bqG3Gz4Y
         J+7jHPs6G4CvZ6ISiAoqmiuxErUqWwN20jkVflyBHSJyyC5P5eC4nsbKU/6k5b5mIrcD
         +2aEeJBo3jI8jejEICUuxrdguC4UfvQk5UhGhGPwP16lX2YJIT3LZHAY3tDo1icmdAHF
         QO0IhVJ8HWw/wgmmG56RiGW3i52MvGam0j52TJU61KU9TOhCMhdPXu44fqDnPiBjpuGZ
         7+7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=cBZmVkDcKZz5zZDlHp5T39g0CCRjx154L73p3yLa6i4=;
        b=gSe+cOKtTYesdHF1LkpDa7aApG33TI/MZmKvDGW+YutsHG7MuuOKHy4KcGPnQEuOMC
         L1p6Ie3JxQZoans4qXphzIbtwrDfG+a8ylsYkvKcPV5XlzNRpaVjLuALo3MerrlJgKCA
         /txzd5p498J7WMfgHNGhcVNrIuYP3NbK9ksBlUDzNfx5SQGalI84RWgHOHZTDjZso/Hr
         yThk95yC2T2CmFjihmjlf/cB2ZLL/VtUuaooCfY0Nu+40rJBlDH6j4/iiCgztmRcPwh+
         bxjYItp10DvN2QM37xk+cjcPIgJFKlMrpr/jPtLw6ik23jK2x0Qc/zfFdSylLiThFxJZ
         Eqqg==
X-Gm-Message-State: APjAAAUgxY8PITb3hRE1rQn24Kcg4mCjRO5GtmX9h8BVAU+T/LXgK6fu
        M+ssSIj62REpeFZlKvtyMSQ=
X-Google-Smtp-Source: APXvYqwB6gvQcdks+jrYjCow1jWYalLI0aO/HIFRY6W9E6qaFAat/V97b6+aesqJTosfdItuAgcG0Q==
X-Received: by 2002:a17:90a:9201:: with SMTP id m1mr1736979pjo.58.1568673786005;
        Mon, 16 Sep 2019 15:43:06 -0700 (PDT)
Received: from Asurada-Nvidia.nvidia.com (thunderhill.nvidia.com. [216.228.112.22])
        by smtp.gmail.com with ESMTPSA id u4sm124058pfu.177.2019.09.16.15.43.05
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 16 Sep 2019 15:43:05 -0700 (PDT)
Date:   Mon, 16 Sep 2019 15:42:45 -0700
From:   Nicolin Chen <nicoleotsuka@gmail.com>
To:     "S.j. Wang" <shengjiu.wang@nxp.com>
Cc:     "timur@kernel.org" <timur@kernel.org>,
        "Xiubo.Lee@gmail.com" <Xiubo.Lee@gmail.com>,
        "festevam@gmail.com" <festevam@gmail.com>,
        "lgirdwood@gmail.com" <lgirdwood@gmail.com>,
        "broonie@kernel.org" <broonie@kernel.org>,
        "perex@perex.cz" <perex@perex.cz>,
        "tiwai@suse.com" <tiwai@suse.com>,
        "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>,
        "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [EXT] Re: [PATCH 2/3] ASoC: fsl_asrc: update supported sample
 format
Message-ID: <20190916224244.GA12789@Asurada-Nvidia.nvidia.com>
References: <VE1PR04MB64791308D87F91C51412DF53E3B60@VE1PR04MB6479.eurprd04.prod.outlook.com>
 <20190912235103.GD24937@Asurada-Nvidia.nvidia.com>
 <VE1PR04MB6479A4161F9C71FD394A3DA9E3B30@VE1PR04MB6479.eurprd04.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <VE1PR04MB6479A4161F9C71FD394A3DA9E3B30@VE1PR04MB6479.eurprd04.prod.outlook.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 13, 2019 at 05:48:40AM +0000, S.j. Wang wrote:
> Hi
> 
> > 
> > On Tue, Sep 10, 2019 at 02:07:25AM +0000, S.j. Wang wrote:
> > > > On Mon, Sep 09, 2019 at 06:33:20PM -0400, Shengjiu Wang wrote:
> > > > > The ASRC support 24bit/16bit/8bit input width, so S20_3LE format
> > > > > should not be supported, it is word width is 20bit.
> > > >
> > > > I thought 3LE used 24-bit physical width. And the driver assigns
> > > > ASRC_WIDTH_24_BIT to "width" for all non-16bit cases, so 20-bit
> > > > would go for that 24-bit slot also. I don't clearly recall if I had
> > > > explicitly tested S20_3LE, but I feel it should work since I put there...
> > >
> > > For S20_3LE, the width is 20bit,  but the ASRC only support 24bit, if
> > > set the ASRMCR1n.IWD= 24bit, because the actual width is 20 bit, the
> > > volume is Lower than expected,  it likes 24bit data right shift 4 bit.
> > > So it is not supported.
> > 
> > Hmm..S20_3LE right-aligns 20 bits in a 24-bit slot? I thought they're left
> > aligned...
> > 
> > If this is the case...shouldn't we have the same lower-volume problem for
> > all hardwares that support S20_3LE now?
> 
> Actually some hardware/module when they do transmission from FIFO
> to shift register, they can select the start bit, for example from the 20th
> bit. but not all module have this capability.
> 
> For ASRC, it haven't.  IWD can only cover the data width,  there is no
> Other bit for slot width.

Okay..let's drop the S20_3LE then. But would it be possible
for you to elaborate the reasoning into the commit message
also? Just for case when people ask why we remove it simply.

Thanks
