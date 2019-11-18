Return-Path: <SRS0=CA45=ZK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2503BC432C0
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Nov 2019 15:45:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E0A2120857
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Nov 2019 15:45:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727500AbfKRPpx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Nov 2019 10:45:53 -0500
Received: from mx2.suse.de ([195.135.220.15]:53646 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727336AbfKRPpv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Nov 2019 10:45:51 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 9C99DAD33;
        Mon, 18 Nov 2019 15:45:49 +0000 (UTC)
Date:   Mon, 18 Nov 2019 07:41:31 -0800
From:   Davidlohr Bueso <dave@stgolabs.net>
To:     mingo@kernel.org
Cc:     tglx@linutronix.de, peterz@infradead.org, bp@alien8.de,
        x86@kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH -tip v2 0/4] x86,mm/pat: Move towards using generic
 interval tree
Message-ID: <20191118154131.4vvqa3azfneakxrm@linux-p48b>
References: <20191021231924.25373-1-dave@stgolabs.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20191021231924.25373-1-dave@stgolabs.net>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

ping?

With another week of rc, can this still make it for v5.5?

Thanks,
Davidlohr

On Mon, 21 Oct 2019, Davidlohr Bueso wrote:

>Changes from v1[0]:
> - Got rid of more code in patch 1 by using the end - 1 for closed
>   intervals, instead of keeping the overlap-check.
>
> - added an additional cleanup patch.
>
>Hi,
>
>I'm sending this series again in this format as the interval tree
>node conversion will, at a minimum, take longer than hoped for
>(ie: Jason still removing interval tree users for the mmu_notifier
>rework[1]). There is also a chance this will never see be done.
>
>As such, I'm resending this series (where patch 1 is the only
>interesting one and which Ingo acked previously, with the exception
>that the nodes remain fully closed). In the future, it would be
>trivial to port pat tree to semi open nodes, but for now think that
>it makes sense to just get the pat changes in.
>
>Please consider for v5.5. Thanks!
>
>[0] https://lore.kernel.org/lkml/20190813224620.31005-1-dave@stgolabs.net/
>[1] https://marc.info/?l=linux-mm&m=157116340411211
>
>Davidlohr Bueso (4):
>  x86/mm, pat: Convert pat tree to generic interval tree
>  x86,mm/pat: Cleanup some of the local memtype_rb_* calls
>  x86,mm/pat: Drop rbt suffix from external memtype calls
>  x86/mm, pat:  Rename pat_rbtree.c to pat_interval.c
>
> arch/x86/mm/pat.c          |   8 +-
> arch/x86/mm/pat_internal.h |  20 ++--
> arch/x86/mm/pat_interval.c | 186 +++++++++++++++++++++++++++++++
> arch/x86/mm/pat_rbtree.c   | 268 ---------------------------------------------
> 4 files changed, 200 insertions(+), 282 deletions(-)
> create mode 100644 arch/x86/mm/pat_interval.c
> delete mode 100644 arch/x86/mm/pat_rbtree.c
>
>--
>2.16.4
>
