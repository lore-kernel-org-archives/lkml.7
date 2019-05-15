Return-Path: <SRS0=FrXW=TP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7068CC04E53
	for <linux-kernel@archiver.kernel.org>; Wed, 15 May 2019 11:50:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 31B3C2053B
	for <linux-kernel@archiver.kernel.org>; Wed, 15 May 2019 11:50:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="NJTP+oeO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731898AbfEOLuA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 May 2019 07:50:00 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:56240 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730379AbfEOLt7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 May 2019 07:49:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Transfer-Encoding
        :Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
        Sender:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=mc63LhWg2+r8G6LyepIMoQgzu86nCTP3tUKDYnTysXo=; b=NJTP+oeOJ2KTSYKFCNvyNdWTdl
        pkNAYs4PuM9AmwDSp+SRpJ2s5RQMLUOl+KvQeTbeCBBsWXMw//5EKv/S1ECv3NJFKztodOWSY+uLL
        x6LYCjisteMmKVkA80CIMjyz4BJLmCPomB9t/OOkhdsAJ/bWKo979xjvYWMODNwDryd1NyB1llGar
        THnvqn8pLDBzW6vZ4tX+ssfHbXZ49/xxkOo0JV+TI5LpknghfuJv6cbIJh7CPO5Lot3bObhMxV3Yt
        Fxo2c5686rUezL0nFqDfxSaVnWqnD555AqmYQNfVM1IDIDTE/CQfBBHzPVUdAf/CZJirFW1pVKzht
        Sl5ZZM5w==;
Received: from willy by bombadil.infradead.org with local (Exim 4.90_1 #2 (Red Hat Linux))
        id 1hQsPy-0000MW-Qa; Wed, 15 May 2019 11:49:54 +0000
Date:   Wed, 15 May 2019 04:49:54 -0700
From:   Matthew Wilcox <willy@infradead.org>
To:     Michal =?iso-8859-1?Q?Koutn=FD?= <mkoutny@suse.com>
Cc:     khlebnikov@yandex-team.ru, akpm@linux-foundation.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org, oleg@redhat.com
Subject: Re: mm: use down_read_killable for locking mmap_sem in
 access_remote_vm
Message-ID: <20190515114954.GB31704@bombadil.infradead.org>
References: <155790847881.2798.7160461383704600177.stgit@buzz>
 <20190515083825.GJ13687@blackbody.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190515083825.GJ13687@blackbody.suse.cz>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 15, 2019 at 10:38:26AM +0200, Michal Koutný wrote:
> Hi,
> making this holder of mmap_sem killable was for the reasons of /proc/...
> diagnostics was an idea I was pondeering too. However, I think the
> approach of pretending we read 0 bytes is not correct. The API would IMO
> need to be extended to allow pass a result such as EINTR to the end
> caller.
> Why do you think it's safe to return just 0?

_killable_, not _interruptible_.

The return value will never be seen by userspace because it's dead.


