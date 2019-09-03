Return-Path: <SRS0=TDKO=W6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DC17DC3A5A2
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Sep 2019 13:53:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BB5B92343A
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Sep 2019 13:53:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729353AbfICNx5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Sep 2019 09:53:57 -0400
Received: from zeniv.linux.org.uk ([195.92.253.2]:57886 "EHLO
        ZenIV.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729015AbfICNx4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Sep 2019 09:53:56 -0400
Received: from viro by ZenIV.linux.org.uk with local (Exim 4.92.1 #3 (Red Hat Linux))
        id 1i59Fq-000445-7m; Tue, 03 Sep 2019 13:53:54 +0000
Date:   Tue, 3 Sep 2019 14:53:54 +0100
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     Christoph Hellwig <hch@infradead.org>
Cc:     Qian Cai <cai@lca.pw>, linux-fsdevel@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: "fs/namei.c: keep track of nd->root refcount status" causes boot
 panic
Message-ID: <20190903135354.GI1131@ZenIV.linux.org.uk>
References: <7C6CCE98-1E22-433C-BF70-A3CBCDED4635@lca.pw>
 <20190903123719.GF1131@ZenIV.linux.org.uk>
 <20190903130456.GA9567@infradead.org>
 <20190903134832.GH1131@ZenIV.linux.org.uk>
 <20190903135024.GA8274@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190903135024.GA8274@infradead.org>
User-Agent: Mutt/1.12.0 (2019-05-25)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 03, 2019 at 06:50:24AM -0700, Christoph Hellwig wrote:
> On Tue, Sep 03, 2019 at 02:48:32PM +0100, Al Viro wrote:
> > Not sure what would be the best way to do it...  I don't mind breaking
> > the out-of-tree modules, whatever their license is; what I would rather
> > avoid is _quiet_ breaking of such.
> 
> Any out of tree module running against an upstream kernel will need
> a recompile for a new version anyway.  So I would not worry about it
> at all.

There's much nastier situation than "new upstream kernel released,
need to rebuild" - it's bisect in mainline trying to locate something...
