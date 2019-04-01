Return-Path: <SRS0=/BGd=SD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DDB5AC43381
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Apr 2019 11:22:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AAF5C20883
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Apr 2019 11:22:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="uu0LMPEj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726834AbfDALWU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Apr 2019 07:22:20 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:49680 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725882AbfDALWT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Apr 2019 07:22:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=1FMt2d9KtzasNyUyCYU3/NrOTo32EFxupWlp/nhTY1w=; b=uu0LMPEj+cQr8/a6Aaseujkwk
        e8Gejtt4cUqtcK1NbxhRtBrmCIzmvmBmLPBsOTedgDGNBaPu135oHcnqAwixMUqX3Sazcl5vKdXj+
        cMFmW16EY9XzItNk6wF/u5T6vjhFvZr+69VTq47SijTx8GBF67IO1v3BBHaSjesHhSnoxeeg7COjL
        ydFulYFMQU6b4l1DQsbXpqHSS86i+Ragh8heGfgLgWabMcBWypzigS17Jh/Cf+6Z6NplIHvzHV0HT
        rC9adR4cJx3btYLsllgdvQYVYRHKk9g5Ds4X5Xa1VsM5EOzByduKYXvNDmkGXw4Mix23w+x+x3yXH
        kglzKqUEA==;
Received: from willy by bombadil.infradead.org with local (Exim 4.90_1 #2 (Red Hat Linux))
        id 1hAv19-0002Xi-Ew; Mon, 01 Apr 2019 11:22:19 +0000
Date:   Mon, 1 Apr 2019 04:22:19 -0700
From:   Matthew Wilcox <willy@infradead.org>
To:     Johannes Thumshirn <jthumshirn@suse.de>
Cc:     Linux Kernel Mailinglist <linux-kernel@vger.kernel.org>,
        Linux FSDEVEL Mailinglist <linux-fsdevel@vger.kernel.org>
Subject: Re: [PATCH] fs/open: Fix most outstanding security bugs
Message-ID: <20190401112219.GA22763@bombadil.infradead.org>
References: <20190401090113.22946-1-jthumshirn@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190401090113.22946-1-jthumshirn@suse.de>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 01, 2019 at 11:01:13AM +0200, Johannes Thumshirn wrote:
> Over the last 20 years, the Linux kernel has accumulated hundreds if not
> thousands of security vulnerabilities.
> 
> One common pattern in most of these security related reports is processes
> called "syzkaller", "trinity" or "syz-executor" opening files and then
> abuse kernel interfaces causing kernel crashes or even worse threats using
> memory overwrites or by exploiting race conditions.
> 
> Hunting down these bugs has become time consuming and very expensive, so
> I've decided to put an end to it.
> 
> If one of the above mentioned processes tries opening a file, return -EPERM
> indicating this process does not have the permission to open files on Linux
> anymore.
> 
> Signed-off-by: Johannes Thumshirn <jthumshirn@suse.de>

I think you should have credited Cisco for the idea.

https://twitter.com/RedTeamPT/status/1110843396657238016
