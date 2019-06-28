Return-Path: <SRS0=E/6H=U3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE97BC4321A
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Jun 2019 16:02:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A035220828
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Jun 2019 16:02:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="sJFGMpBO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726865AbfF1QCc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Jun 2019 12:02:32 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:37522 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726863AbfF1QCc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Jun 2019 12:02:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=GyhiC5rh5R/SA3JdFPBdp/fqKIvCDnAaiwOHr5+37xI=; b=sJFGMpBOwecab1Pbl4HEXHNu2
        /wBUXjIy6p22D3vgPvvlNhozFXM+KVKACnPL2NbJPVrAZFuKp+3HDfOYnL1Mc7LHP8DLAzdTCKL/M
        jtQ4Y3JO+eMQlOMEbamh/I0lbFBEmJ/iyZ9EL953YZEt+lcnut1AuQAOJt6eyq3Y4XJvw/K/hS0f2
        6B7ffZYBcXBu2DeKaHMcFjnO0S5AVIUHx5MiNwuUgl2xWqOhrvhifabag26uh6oHjTBDee+1w7g9a
        70GpxMVxu0L9Q8NCfgXV5BtLdzrFawxxAHWGZdac3NONSLG0sPJ4Y1oZWTuR2A96BAs07erkqYY/P
        oibYd4g9w==;
Received: from hch by bombadil.infradead.org with local (Exim 4.92 #3 (Red Hat Linux))
        id 1hgtKY-0006oo-Om; Fri, 28 Jun 2019 16:02:30 +0000
Date:   Fri, 28 Jun 2019 09:02:30 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
Cc:     Christoph Hellwig <hch@infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH] fat: Add nobarrier to workaround the strange behavior of
 device
Message-ID: <20190628160230.GA24232@infradead.org>
References: <871rzdrdxw.fsf@mail.parknet.co.jp>
 <20190628143216.GA538@infradead.org>
 <87pnmxpx9p.fsf@mail.parknet.co.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87pnmxpx9p.fsf@mail.parknet.co.jp>
User-Agent: Mutt/1.11.4 (2019-03-13)
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jun 29, 2019 at 12:03:46AM +0900, OGAWA Hirofumi wrote:
> I see, sounds like good though. Does it work for all stable versions?
> Can it disable only flush command without other effect? And it would be
> better to be normal user controllable easily.

The option was added in 2.6.17, so it's been around forever.  But
no, it obviously is not user exposed as using it on a normal drive
can lead to data loss.
