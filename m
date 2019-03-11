Return-Path: <SRS0=FxTY=RO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D3B9AC43381
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Mar 2019 18:16:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A8CEA20657
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Mar 2019 18:16:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="Yyue3B5v"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727984AbfCKSQL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Mar 2019 14:16:11 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:37502 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727508AbfCKSQL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Mar 2019 14:16:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=UeX23wdG33xRF1sa4kEMkq960vyWbO/IuFRzW8gVL7E=; b=Yyue3B5vy5FXN8QZxEy3JR+RS
        bWZQf5dlAF0N+A6z1hweIjVzdr1ul8gGLGEX/yrnFn7KLGSBhiFknbhcC1sk8RKBfrstWT2uOj/wN
        WJsuiT3lZQgiwGJlQmgNbUgRCI8AyarISsGdDI/Co3tOt8Xb6j7WsAK3WWd7Z8hCBl85eeqSs4B/4
        P8l8cCTGlCKCG7P4dneINadwZOlnntnm3UeOSt8rOwmBItLgAqNPZtXkqxHaFBQJxAu5mHL4uMnaY
        4fhd1PQwAo9991XXGJ5/Z+fXs0VnaqT3OE+ewZi748/iAWEFLuCJE8Yu7C1/Dq/iy/1wyhwp5NYsD
        WVxbKKIGw==;
Received: from hch by bombadil.infradead.org with local (Exim 4.90_1 #2 (Red Hat Linux))
        id 1h3PT6-0004pP-6r; Mon, 11 Mar 2019 18:16:08 +0000
Date:   Mon, 11 Mar 2019 11:16:08 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Mike Snitzer <snitzer@redhat.com>
Cc:     "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>, hch@infradead.org,
        Nikos Tsironis <ntsironis@arrikto.com>, agk@redhat.com,
        dm-devel@redhat.com, mpatocka@redhat.com, iliastsi@arrikto.com,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/3] list_bl: Add hlist_bl_add_before/behind helpers
Message-ID: <20190311181607.GA9388@infradead.org>
References: <20181220180651.4879-1-ntsironis@arrikto.com>
 <20181220180651.4879-2-ntsironis@arrikto.com>
 <20190228213201.GB23527@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190228213201.GB23527@redhat.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 28, 2019 at 04:32:02PM -0500, Mike Snitzer wrote:
> Hi Paul and Christoph,
> 
> You've added your Signed-off-by to include/linux/list_bl.h commits in
> the past.  I'm not sure how this proposed patch should be handled.
> 
> These new hlist_bl_add_{before,behind} changes are a prereq for
> dm-snapshot changes that Nikos has proposed, please see:
> https://patchwork.kernel.org/patch/10739265/
> 
> Any assistance/review you, or others on LKML, might be able to provide
> would be appreciated.

I just killed two helpers.  That being said assuming that we only
rely on the next pointer for the lockless traversals the changes look
fine to me, but the code might be beyond my paygrade..
