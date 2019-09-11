Return-Path: <SRS0=Kqgt=XG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9E86ECDE20
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Sep 2019 06:34:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 73FA921D79
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Sep 2019 06:34:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1568183643;
	bh=nILqRGanKyWCsHzEVK8odXbwKzmEyjYx6QNVTLEWPxI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=okLADWmlCI8QgO39OktiKoMml0KIzAujtD3zVO4S3L8TzXH+XxrZKQNYb1I3fN27z
	 1NSB2545nIR0JeEXz2T3YG50Q899YglOoi3B5pItxdyFUQNLlyd3LjxDiHz54IgcO9
	 9Tj6QnfpJINHn7zYXZu7hPxMxI8v+0LUTTbaVnfM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726959AbfIKGeC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Sep 2019 02:34:02 -0400
Received: from mail.kernel.org ([198.145.29.99]:37966 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726390AbfIKGeC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Sep 2019 02:34:02 -0400
Received: from dragon (98.142.130.235.16clouds.com [98.142.130.235])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A1F7B21D79;
        Wed, 11 Sep 2019 06:33:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1568183641;
        bh=nILqRGanKyWCsHzEVK8odXbwKzmEyjYx6QNVTLEWPxI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=hdiGnsYABZmVcA3qsJpOxGkwJMtLvaWrreihk580l8Bdua269dMT9TuUPCKFcKfHp
         +WhR12Ze+NzXy0ixqQA0GNZVk17CK3kfBB3iwU9+hkHQStxz+N0YKHGiymxkG8aSpn
         NjoHWrIMmv05+LjhyeVwUE8PVyePFUEFqRn7W2hQ=
Date:   Wed, 11 Sep 2019 14:33:51 +0800
From:   Shawn Guo <shawnguo@kernel.org>
To:     Vladimir Oltean <olteanv@gmail.com>
Cc:     Mark Brown <broonie@kernel.org>, linux-spi@vger.kernel.org,
        lkml <linux-kernel@vger.kernel.org>, devicetree@vger.kernel.org,
        netdev <netdev@vger.kernel.org>, Rob Herring <robh@kernel.org>
Subject: Re: [PATCH v2 5/5] ARM: dts: ls1021a-tsn: Use the DSPI controller in
 poll mode
Message-ID: <20190911063350.GB17142@dragon>
References: <20190822211514.19288-1-olteanv@gmail.com>
 <20190822211514.19288-6-olteanv@gmail.com>
 <CA+h21hqWGDCfTg813W1WaXFnRsMdE30WnaXw5TJvpkSp0-w5JA@mail.gmail.com>
 <20190827180502.GF23391@sirena.co.uk>
 <CA+h21hr3qmTG1LyWsEp+hZZW2NJFtg9Dh1k6SXVDd+A_YSQjjw@mail.gmail.com>
 <20190827181318.GG23391@sirena.co.uk>
 <CA+h21hqMVdsUjBdtiHKtKGpyvuaOf25tc4h-GdDEBQqa3EB7tw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CA+h21hqMVdsUjBdtiHKtKGpyvuaOf25tc4h-GdDEBQqa3EB7tw@mail.gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 27, 2019 at 09:16:39PM +0300, Vladimir Oltean wrote:
> On Tue, 27 Aug 2019 at 21:13, Mark Brown <broonie@kernel.org> wrote:
> >
> > On Tue, Aug 27, 2019 at 09:06:14PM +0300, Vladimir Oltean wrote:
> > > On Tue, 27 Aug 2019 at 21:05, Mark Brown <broonie@kernel.org> wrote:
> > > > On Mon, Aug 26, 2019 at 04:10:51PM +0300, Vladimir Oltean wrote:
> >
> > > > > I noticed you skipped applying this patch, and I'm not sure that Shawn
> > > > > will review it/take it.
> > > > > Do you have a better suggestion how I can achieve putting the DSPI
> > > > > driver in poll mode for this board? A Kconfig option maybe?
> >
> > > > DT changes go through the relevant platform trees, not the
> > > > subsystem trees, so it's not something I'd expect to apply.
> >
> > > But at least is it something that you expect to see done through a
> > > device tree change?
> >
> > Well, it's not ideal - if it performs better all the time the
> > driver should probably just do it unconditionally.  If there's
> > some threashold where it tends to perform better then the driver
> > should check for that but IIRC it sounds like the interrupt just
> > isn't at all helpful here.
> 
> I can't seem to find any situation where it performs worse. Hence my
> question on whether it's a better idea to condition this behavior on a
> Kconfig option rather than a DT blob which may or may not be in sync.

DT is a description of hardware not condition for software behavior,
where module parameter is usually used for.

Shawn
