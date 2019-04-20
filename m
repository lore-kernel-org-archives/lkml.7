Return-Path: <SRS0=ruH4=SW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2368C282DD
	for <linux-kernel@archiver.kernel.org>; Sat, 20 Apr 2019 13:33:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B47802183F
	for <linux-kernel@archiver.kernel.org>; Sat, 20 Apr 2019 13:33:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1555767236;
	bh=uv9UMcb4koHXzC+O2iZ4IX/kI0rURgmQss4GjE9TCNc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=sQo0QlGYVOXNDTsyvSihSi3lokkC2TX45wEGJbiFLLeRBqkJumDpc9s+zaIF/0TzU
	 w6soCgT/iMo6vALcJaOF/1ogz9U8IBRzi68jqgN4oIIqMPd7PU/DJPErcT/u8iK7mP
	 su/Y5TnGekRSmHfqy5ONxefRYCMfuoyfAIXp/L8c=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726991AbfDTNdz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 20 Apr 2019 09:33:55 -0400
Received: from mail.kernel.org ([198.145.29.99]:53080 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725891AbfDTNdz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 20 Apr 2019 09:33:55 -0400
Received: from dragon (98.142.130.235.16clouds.com [98.142.130.235])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6C66E21479;
        Sat, 20 Apr 2019 13:33:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1555767234;
        bh=uv9UMcb4koHXzC+O2iZ4IX/kI0rURgmQss4GjE9TCNc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=C8kv3jAbL73OANYUFSdPoMHloXvQaaVMOBSy0Qf4ng1XtgdcJnZFYtHcXFSu1SVWI
         0LZXwmugw5ttG17EsCkWvO0FENxph6CKJG4Lwu0aU9BJ4UuKPQmP+NBqmT+iyRY+Sg
         KOLF5Qf8M3SGqtVwpyWtJSibhwBN/sC4oA0wUD48=
Date:   Sat, 20 Apr 2019 21:33:43 +0800
From:   Shawn Guo <shawnguo@kernel.org>
To:     Adam Ford <aford173@gmail.com>
Cc:     Andrey Smirnov <andrew.smirnov@gmail.com>,
        Angus Ainslie <angus@akkea.ca>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Chris Healy <cphealy@gmail.com>,
        Fabio Estevam <fabio.estevam@nxp.com>,
        arm-soc <linux-arm-kernel@lists.infradead.org>,
        Lucas Stach <l.stach@pengutronix.de>
Subject: Re: [PATCH v3 1/9] ARM: dts: imx6qdl: Specify IMX6QDL_CLK_IPG as
 "ipg" clock to SDMA
Message-ID: <20190420133342.GB14187@dragon>
References: <20190329064924.8728-1-andrew.smirnov@gmail.com>
 <20190411023008.GK26817@dragon>
 <CAHCN7xLczbdXx+TEQhsY1L3z09wPubvxX5SDO3Z1OzavPie0=Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHCN7xLczbdXx+TEQhsY1L3z09wPubvxX5SDO3Z1OzavPie0=Q@mail.gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Apr 20, 2019 at 07:14:26AM -0500, Adam Ford wrote:
> On Wed, Apr 10, 2019 at 9:30 PM Shawn Guo <shawnguo@kernel.org> wrote:
> >
> > On Thu, Mar 28, 2019 at 11:49:16PM -0700, Andrey Smirnov wrote:
> > > Since 25aaa75df1e6 SDMA driver uses clock rates of "ipg" and "ahb"
> > > clock to determine if it needs to configure the IP block as operating
> > > at 1:1 or 1:2 clock ratio (ACR bit in SDMAARM_CONFIG). Specifying both
> > > clocks as IMX6QDL_CLK_SDMA results in driver incorrectly thinking that
> > > ratio is 1:1 which results in broken SDMA funtionality(this at least
> > > breaks RAVE SP serdev driver on RDU2). Fix the code to specify
> > > IMX6QDL_CLK_IPG as "ipg" clock for SDMA, to avoid detecting incorrect
> > > clock ratio.
> > >
> > > Fixes: 25aaa75df1e6 ("dmaengine: imx-sdma: add clock ratio 1:1 check")
> >
> > Since we have a fix in the dma driver, I dropped the Fixes tag here.
> >
> > Applied all, thanks.
> 
> Do you know if the SDMA fixes will be back-ported to 5.0.y branch?  To
> get 5.0 working, I need to manually apply the patches.

I'm confused here.  The regression was caused by 25aaa75df1e6
("dmaengine: imx-sdma: add clock ratio 1:1 check"), which only lands on
mainline with v5.1-rc1.  How would 5.0.y branch need fixing?

Shawn
