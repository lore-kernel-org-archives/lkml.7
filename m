Return-Path: <SRS0=fBTF=VC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 12216C4649B
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Jul 2019 13:14:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DEE5B218CA
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Jul 2019 13:14:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1562332441;
	bh=4Ax4YHT9pSOfjjpXXhaL2jL94bL31h816GZtxYru400=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=AbjS74zZv9szRf/nPtBBbSMin8KOb/yXXJKdbbU7M54tSMDVu8dM1niMPfe4kcdLx
	 Holm9c1/YfPosdzUSgd4yCJxmQ9C5E0cvEBnixDIPBarRm1JMFshs7/7DQQDZs/duW
	 oBQsjHWHoPvQiE/Go9yEof8cLUEjSNP+yVnvRuE8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728988AbfGENOA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 5 Jul 2019 09:14:00 -0400
Received: from mail.kernel.org ([198.145.29.99]:46554 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728434AbfGENN7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Jul 2019 09:13:59 -0400
Received: from localhost (unknown [49.207.59.31])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7589B21850;
        Fri,  5 Jul 2019 13:13:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1562332439;
        bh=4Ax4YHT9pSOfjjpXXhaL2jL94bL31h816GZtxYru400=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=btwexLJg3kxAdxu2/nhXrlxBb1eB9ovzxeZoIukphlXXmuThG6+a7UmKKXTXXZKV5
         Rj/5A+nuFNluNKXQEx67FC7VlUTYscurOjjF05FdRi40H++FOcDj66rXJvMhbuFlKZ
         A6jGbKGgBlCxBwWRds42zRK38fBBWe8MEmqynafI=
Date:   Fri, 5 Jul 2019 18:40:49 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Sven Van Asbroeck <thesven73@gmail.com>
Cc:     Robin Gong <yibin.gong@nxp.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        dmaengine@vger.kernel.org,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] dmaengine: imx-sdma: fix use-after-free on probe error
 path
Message-ID: <20190705131049.GF2911@vkoul-mobl>
References: <CAGngYiVsUZwCUEsqRk-YtZPGYxsqzHzD7U5GeeHyAa2Yw9Z6WA@mail.gmail.com>
 <20190624140731.24080-1-TheSven73@gmail.com>
 <20190705124646.GD2911@vkoul-mobl>
 <CAGngYiW2+sBv1WqB8+csb=mZm2owziJ5wWcWLNPy7=m72ppypw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAGngYiW2+sBv1WqB8+csb=mZm2owziJ5wWcWLNPy7=m72ppypw@mail.gmail.com>
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 05-07-19, 09:08, Sven Van Asbroeck wrote:
> Hi Vinod,
> 
> On Fri, Jul 5, 2019 at 8:50 AM Vinod Koul <vkoul@kernel.org> wrote:
> >
> > there is an else here too!
> >
> 
> You are of course right, I was looking at the wrong if.

NO issues :)
> 
> Apologies for the confusion, I did try to look at what you
> changed, but your git repo listed in MAINTAINERS appears
> unresponsive for me?

To quote David you need to move to 21st century (like me). IPv4 switch
for infradead is down so...

meanwhile this would work too:
git.kernel.org/pub/scm/linux/kernel/git/vkoul/slave-dma.git

-- 
~Vinod
