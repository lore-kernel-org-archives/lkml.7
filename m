Return-Path: <SRS0=HfRD=XN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 41143C4CEC9
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Sep 2019 16:45:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1C769218AF
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Sep 2019 16:45:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732011AbfIRQpY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 18 Sep 2019 12:45:24 -0400
Received: from verein.lst.de ([213.95.11.211]:34532 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730380AbfIRQpY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Sep 2019 12:45:24 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id 1BC5F68B05; Wed, 18 Sep 2019 18:45:19 +0200 (CEST)
Date:   Wed, 18 Sep 2019 18:45:18 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Larry Finger <Larry.Finger@lwfinger.net>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [PATCH] x86/mm: Remove set_pages_x() and set_pages_nx()
Message-ID: <20190918164518.GA19222@lst.de>
References: <20190918164121.30006-1-Larry.Finger@lwfinger.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190918164121.30006-1-Larry.Finger@lwfinger.net>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 18, 2019 at 11:41:21AM -0500, Larry Finger wrote:
> In commit 185be15143aa ("x86/mm: Remove set_pages_x() and set_pages_nx()"),
> the wrappers were removed as they did not provide a real benefit over
> set_memory_x() and set_memory_nx(). This change causes a problem because
> the wrappers were exported, but the underlying routines were not. As a
> result, external modules that used the wrappers would need to recreate
> a significant part of memory management.

And external modules do not matter for mainline decisions.  In fact
ensuring random modules can't mess with the NX state was one of the
reasons for this patch, as that is a security issue waiting to happen.
