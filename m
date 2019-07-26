Return-Path: <SRS0=vtn1=VX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00EB5C76191
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Jul 2019 11:43:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C4F5622BEF
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Jul 2019 11:43:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1564141410;
	bh=5yhEY4/CW3iFSx6x2N72Exb83PWgWW4WYbcupxxH+EQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=pxwB3isgG5Hvd2PNCuZVdRKLuH/3xNn/hSdLBpxepJrn3judauCMIW8i9jgFjX2i5
	 tG+8a9IJD9FJCXGwBpgqoeIm1Rg0vRDuiB3D3jXZxOQT1UnP+2JB7MLxsAJaCOhdM7
	 knJh9Fs2gWfmoSw60PGmrqfzpCiNmIFTGYlTdxcQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726138AbfGZLna (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Jul 2019 07:43:30 -0400
Received: from mail.kernel.org ([198.145.29.99]:44720 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725903AbfGZLn3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Jul 2019 07:43:29 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 69DED229F3;
        Fri, 26 Jul 2019 11:43:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1564141408;
        bh=5yhEY4/CW3iFSx6x2N72Exb83PWgWW4WYbcupxxH+EQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=2agoaOv3lpVGYhSQxrkRuDOARn2KEXJcqmDa7xybgtHiM6/IJNjdpLnyRHt7Aubtc
         X8i7PeL0fMglVJ+kGD7HlNNxki0h00bW92TbkewMZwyidxTXpksfKgvJIVrarwrs/f
         4bwd5fiplYiGBI4MZPkaodlW/in25rCAMv7VrmOs=
Date:   Fri, 26 Jul 2019 13:43:25 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Thomas Petazzoni <thomas.petazzoni@bootlin.com>
Cc:     Sai Prakash Ranjan <saiprakash.ranjan@codeaurora.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Leo Yan <leo.yan@linaro.org>,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [Regression] Missing device nodes for ETR, ETF and STM after
 CONFIG_UEVENT_HELPER=n
Message-ID: <20190726114325.GA18727@kroah.com>
References: <cfe09a46-462f-633a-37c2-52f8bfc0ffb2@codeaurora.org>
 <20190726070429.GA15714@kroah.com>
 <165028a7-ff12-dd28-cc4c-57a3961dbb40@codeaurora.org>
 <20190726084127.GA28470@kroah.com>
 <097942a1-6914-2542-450f-65a6147dc7aa@codeaurora.org>
 <6d48f996-6297-dc69-250b-790be6d2670c@codeaurora.org>
 <20190726101925.GA22476@kroah.com>
 <20190726133316.688a43d8@windsurf>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190726133316.688a43d8@windsurf>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 26, 2019 at 01:33:16PM +0200, Thomas Petazzoni wrote:
> Hello,
> 
> On Fri, 26 Jul 2019 12:19:25 +0200
> Greg Kroah-Hartman <gregkh@linuxfoundation.org> wrote:
> 
> > > This somehow is not mounting etr, etf, stm devices when uevent-helper is
> > > disabled. Anyways as Suzuki mentioned, using devtmpfs does fix the issue.  
> > 
> > Last I looked (many years ago) mdev requires uevent-helper in order for
> > it to work.  I recommend that if you rely on mdev to keep that option
> > enabled, or to just use devtmpfs and udev :)
> 
> Since Busybox 1.31.0, mdev has gained a daemon mode. In this mode, mdev
> runs in the background, and receives uevent through a netlink socket.
> So there's been some changes in how Busybox mdev works in recent times.

Ideally mdev should switch to what udev did many many years ago and not
do any device node creations and just leave all of that up to devtmpfs.
Then it can just stick to any symlinks and any specific owner:group
permissions that might be wanted separate from the default ones the
kernel provides.

Makes things much simpler and should save a lot of userspace code,
making mdev even smaller.

thanks,

greg k-h
