Return-Path: <SRS0=TxL2=YH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D9FD2ECE587
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Oct 2019 13:45:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B728120663
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Oct 2019 13:45:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732099AbfJNNpJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 14 Oct 2019 09:45:09 -0400
Received: from outgoing-auth-1.mit.edu ([18.9.28.11]:36699 "EHLO
        outgoing.mit.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727789AbfJNNpJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Oct 2019 09:45:09 -0400
Received: from callcc.thunk.org (guestnat-104-133-0-98.corp.google.com [104.133.0.98] (may be forged))
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id x9EDj2Ot008767
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 14 Oct 2019 09:45:03 -0400
Received: by callcc.thunk.org (Postfix, from userid 15806)
        id C9823420287; Mon, 14 Oct 2019 09:45:01 -0400 (EDT)
Date:   Mon, 14 Oct 2019 09:45:01 -0400
From:   "Theodore Y. Ts'o" <tytso@mit.edu>
To:     Catalin Marinas <catalin.marinas@arm.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [REGRESSION] kmemleak: commit c566586818 causes failure to boot
Message-ID: <20191014134501.GE5564@mit.edu>
References: <20191014022633.GA6430@mit.edu>
 <20191014070312.GA3327@iMac-3.local>
 <20191014115021.GA5564@mit.edu>
 <20191014125115.GA19200@arrakis.emea.arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191014125115.GA19200@arrakis.emea.arm.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 14, 2019 at 01:51:15PM +0100, Catalin Marinas wrote:
> In your case, CONFIG_DEBUG_KMEMLEAK_DEFAULT_OFF=y, so it disables itself
> irrespective of the pool size and trips over the bug. Even with default
> off, it still involves the clean-up since kmemleak needs to track early
> allocations in case it is turned on by the kmemleak=on cmdline option.
> 
> So I think 16000 is sufficient in your case, the default-off triggered
> the bug (well, unless you find in the logs "kmemleak: Memory pool empty,
> consider increasing CONFIG_DEBUG_KMEMLEAK_MEM_POOL_SIZE").

Ah, got it, thanks for the clarification!

					- Ted
