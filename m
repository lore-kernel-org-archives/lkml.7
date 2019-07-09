Return-Path: <SRS0=gj9M=VG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 30F50C48BE7
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Jul 2019 11:39:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 062FC214AF
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Jul 2019 11:39:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="fW+cgoqb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726620AbfGILjs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Jul 2019 07:39:48 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:54684 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726030AbfGILjs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Jul 2019 07:39:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=yvuN7XriVhLzlpcSf3QVaG6soAikaUqnhDyVf0OF2tA=; b=fW+cgoqbOCQZ9QOR2gx285qFI
        6mNy/k+o3AyaHPAribt0An3VQWnxKctGKqeBFtjGaXzpR5va4gyoXE+LPkfint+FybWKF5iyciTZW
        5KDadFzerjay70s7FFFQfw15w4/R/o9Ee0SnORIL06dKDHeGHm5/YRFe+WY031YltCzVo3XfQsg7R
        06ui9ykPLvMsXNtmpT/r6SotqBTaAwWYr6tmoL93tFVG4k7aBB37Qi0ELaEnrXmkIzhgCxdkMNaEN
        y6e6/cBALtujliPuU8YHuOD6iBUhFnxfw0dXXiTjjlX1zh73FTKXN7+AJySovHA4uPN7JtMQHV5nm
        GViR98BoQ==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.92 #3 (Red Hat Linux))
        id 1hkoTI-0006c4-49; Tue, 09 Jul 2019 11:39:44 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 2B6F920120CB1; Tue,  9 Jul 2019 13:39:42 +0200 (CEST)
Date:   Tue, 9 Jul 2019 13:39:42 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Andi Kleen <ak@linux.intel.com>
Cc:     Wei Wang <wei.w.wang@intel.com>, linux-kernel@vger.kernel.org,
        kvm@vger.kernel.org, pbonzini@redhat.com, kan.liang@intel.com,
        mingo@redhat.com, rkrcmar@redhat.com, like.xu@intel.com,
        jannh@google.com, arei.gonglei@huawei.com, jmattson@google.com
Subject: Re: [PATCH v7 10/12] KVM/x86/lbr: lazy save the guest lbr stack
Message-ID: <20190709113942.GV3402@hirez.programming.kicks-ass.net>
References: <1562548999-37095-1-git-send-email-wei.w.wang@intel.com>
 <1562548999-37095-11-git-send-email-wei.w.wang@intel.com>
 <20190708145326.GO3402@hirez.programming.kicks-ass.net>
 <20190708151141.GL31027@tassilo.jf.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190708151141.GL31027@tassilo.jf.intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 08, 2019 at 08:11:41AM -0700, Andi Kleen wrote:
> > I don't understand a word of that.
> > 
> > Who cares if the LBR MSRs are touched; the guest expects up-to-date
> > values when it does reads them.
> 
> This is for only when the LBRs are disabled in the guest.

But your Changelog didn't clearly state that. It was an unreadable mess.
