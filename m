Return-Path: <SRS0=SA5R=SA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 58F8EC43381
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Mar 2019 10:48:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 27D3220811
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Mar 2019 10:48:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729309AbfC2Ksw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 29 Mar 2019 06:48:52 -0400
Received: from emh07.mail.saunalahti.fi ([62.142.5.117]:53434 "EHLO
        emh07.mail.saunalahti.fi" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728711AbfC2Ksv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Mar 2019 06:48:51 -0400
Received: from darkstar.musicnaut.iki.fi (85-76-9-223-nat.elisa-mobile.fi [85.76.9.223])
        by emh07.mail.saunalahti.fi (Postfix) with ESMTP id 37AC3B0059;
        Fri, 29 Mar 2019 12:48:48 +0200 (EET)
Date:   Fri, 29 Mar 2019 12:48:47 +0200
From:   Aaro Koskinen <aaro.koskinen@iki.fi>
To:     Jose Abreu <jose.abreu@synopsys.com>
Cc:     "David S. Miller" <davem@davemloft.net>,
        Alexandre Torgue <alexandre.torgue@st.com>,
        Giuseppe Cavallaro <peppe.cavallaro@st.com>,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        Aaro Koskinen <aaro.koskinen@nokia.com>
Subject: Re: [PATCH 1/6] net: stmmac: use correct DMA buffer size in the RX
 descriptor
Message-ID: <20190329104847.GF16484@darkstar.musicnaut.iki.fi>
References: <20190327203540.1884-1-aaro.koskinen@iki.fi>
 <20190327203540.1884-2-aaro.koskinen@iki.fi>
 <5c480a83-dfcf-c20c-f277-4449a7b41403@synopsys.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5c480a83-dfcf-c20c-f277-4449a7b41403@synopsys.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Fri, Mar 29, 2019 at 10:02:20AM +0000, Jose Abreu wrote:
> On 3/27/2019 8:35 PM, Aaro Koskinen wrote:
> > From: Aaro Koskinen <aaro.koskinen@nokia.com>
> > 
> > We always program the maximum DMA buffer size into the receive descriptor,
> > although the allocated size may be less. E.g. with the default MTU size
> > we allocate only 1536 bytes. If somebody sends us a bigger frame, then
> > memory may get corrupted.
> > 
> > Fix by using exact buffer sizes.
> > 
> > Signed-off-by: Aaro Koskinen <aaro.koskinen@nokia.com>
> 
> So, I'm seeing that the maximum allowed buffer size that can be
> put in the descriptor changes between enhanced descriptors to
> normal descriptors (8KB vs. 2KB right ?).

There are two size fields, so it's 16KB vs 4 KB.

> Shouldn't stmmac_main know about this limit before trying to init
> descriptors ?

Yes, and that is not a problem.

> We do limit the MTU according to HW version but I would rather
> prefer not having to need to calculate min() values in the
> descriptor code and just use the value as is ...

I don't think the calculation can be avoided, as the passed value can
be bigger than a single field can hold, or less than the maximum.

A.
