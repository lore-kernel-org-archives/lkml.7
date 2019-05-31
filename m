Return-Path: <SRS0=bMiL=T7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DA28FC04AB6
	for <linux-kernel@archiver.kernel.org>; Fri, 31 May 2019 16:55:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A58C726C95
	for <linux-kernel@archiver.kernel.org>; Fri, 31 May 2019 16:55:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="cS9UwfMY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727021AbfEaQzb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 31 May 2019 12:55:31 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:52010 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726518AbfEaQzb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 May 2019 12:55:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=De7Bses8KtQ4UCCGrlZlsMVjWfSmMqmTDqL2Xo4mbUI=; b=cS9UwfMYzYIoWV6P1j1LQXz3b
        MCMYRFGHasjGiyO2sMvplAxpyv1Cx0AOBN9+a+E9Hc33G4PV+vRZB9F2/UeOG1S5vzebYHfcaR3f5
        GCk4OpCMaQxHCIqYJWn7+831dtpCsw/e0SGg9Ucy42YB+tn6FXPFQkZznTxGDqJ82/hBOftG6BslA
        UW0L5ed7oyvE4/w0R7bbrOO84IME9uy7Heim/UfUmwbJbsOFbYPbDsSSdCfpj323dTq8r5GEWSnOX
        lwE0YPZnrupOzdNzMhTgECxLZa532EvDTK9V8UCG/yJjnVfkaib8B9Y3v+9WvLpU53kSe0Mv0Ar9G
        I+MSsvqNQ==;
Received: from hch by bombadil.infradead.org with local (Exim 4.90_1 #2 (Red Hat Linux))
        id 1hWkoU-0005W4-Et; Fri, 31 May 2019 16:55:30 +0000
Date:   Fri, 31 May 2019 09:55:30 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Laurentiu Tudor <laurentiu.tudor@nxp.com>
Cc:     Christoph Hellwig <hch@infradead.org>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        Madalin-cristian Bucur <madalin.bucur@nxp.com>,
        Roy Pledge <roy.pledge@nxp.com>,
        Camelia Alexandra Groza <camelia.groza@nxp.com>,
        Leo Li <leoyang.li@nxp.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "jocke@infinera.com" <joakim.tjernlund@infinera.com>,
        "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
        "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
        "davem@davemloft.net" <davem@davemloft.net>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCH v3 5/6] dpaa_eth: fix iova handling for contiguous frames
Message-ID: <20190531165530.GA16487@infradead.org>
References: <20190530141951.6704-1-laurentiu.tudor@nxp.com>
 <20190530141951.6704-6-laurentiu.tudor@nxp.com>
 <20190531163229.GA8708@infradead.org>
 <VI1PR04MB5134F5E31B993B2DC5275BB3EC190@VI1PR04MB5134.eurprd04.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <VI1PR04MB5134F5E31B993B2DC5275BB3EC190@VI1PR04MB5134.eurprd04.prod.outlook.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 31, 2019 at 04:53:16PM +0000, Laurentiu Tudor wrote:
> Unfortunately due to our hardware particularities we do not have alternatives. This is also the case for our next generation of ethernet drivers [1]. I'll let my colleagues that work on the ethernet drivers to comment more on this.

Then you need to enhance the DMA API to support your use case instead
of using an API only supported for two specific IOMMU implementations.

Remember in Linux you can should improve core code and not hack around
it in crappy ways making lots of assumptions in your drivers.
