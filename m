Return-Path: <SRS0=6OEZ=YL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2BBD4CA9EA0
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Oct 2019 16:08:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0068421D7C
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Oct 2019 16:08:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="F91zrAla"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2502412AbfJRQIz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 18 Oct 2019 12:08:55 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:47186 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727834AbfJRQIz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Oct 2019 12:08:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=uZO4T3laCAFkLJNde78e3mOnKmGc7aiAK62njk4E0oo=; b=F91zrAlaRm0sYDs/QHsnqkU5j
        v6/E8OUC//BtIJmcEi/UGDnRtFTkYxAK14XNaAgtVRt36Fx6jGH9c7Dp4L9Um8VEecka5gypZouuB
        PZOGw/jCQmCIsXlEWN4sqFdDM1LLNlKJx+hDZUWssZEtRqZA3UngJ5/ngBZ+VczG4IbMWic2IGmoZ
        ndBdPYIgLJLen1TBM4xTbhL4gBf69bvMIHOJqC1YLiGdnMEhHlRAOdmFtQUwgsH/9zW+qCDw0C1K5
        KIGsPw4DgoOz1z+Rc1dgFP/HXJUr8IHrdbSWiSIhdynEKIdwqR5ZXZb7pZhu31LNItJqUMOy1gs7D
        6h0/FC/1A==;
Received: from hch by bombadil.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1iLUo8-0007Tv-Ic; Fri, 18 Oct 2019 16:08:52 +0000
Date:   Fri, 18 Oct 2019 09:08:52 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Rasmus Villemoes <linux@rasmusvillemoes.dk>
Cc:     Qiang Zhao <qiang.zhao@nxp.com>, Li Yang <leoyang.li@nxp.com>,
        linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH 4/7] soc: fsl: qe: replace spin_event_timeout by
 readx_poll_timeout_atomic
Message-ID: <20191018160852.GA13036@infradead.org>
References: <20191018125234.21825-1-linux@rasmusvillemoes.dk>
 <20191018125234.21825-5-linux@rasmusvillemoes.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191018125234.21825-5-linux@rasmusvillemoes.dk>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 18, 2019 at 02:52:31PM +0200, Rasmus Villemoes wrote:
>  	/* wait for the QE_CR_FLG to clear */
> -	ret = spin_event_timeout((ioread32be(&qe_immr->cp.cecr) & QE_CR_FLG) == 0,
> -				 100, 0);
> -	/* On timeout (e.g. failure), the expression will be false (ret == 0),
> -	   otherwise it will be true (ret == 1). */
> +	ret = readx_poll_timeout_atomic(ioread32be, &qe_immr->cp.cecr, val, (val & QE_CR_FLG) == 0,

This creates an overly long line.

Btw, given how few users of spin_event_timeout we have it might be good
idea to just kill it entirely.
