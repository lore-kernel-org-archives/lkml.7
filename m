Return-Path: <SRS0=WRlz=SV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BA32BC282DA
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Apr 2019 18:18:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 96DA5222E9
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Apr 2019 18:18:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727548AbfDSSSc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 19 Apr 2019 14:18:32 -0400
Received: from outbound-smtp19.blacknight.com ([46.22.139.246]:51026 "EHLO
        outbound-smtp19.blacknight.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727507AbfDSSSW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Apr 2019 14:18:22 -0400
Received: from mail.blacknight.com (pemlinmail03.blacknight.ie [81.17.254.16])
        by outbound-smtp19.blacknight.com (Postfix) with ESMTPS id 8B73E1C3194
        for <linux-kernel@vger.kernel.org>; Fri, 19 Apr 2019 14:30:01 +0100 (IST)
Received: (qmail 29446 invoked from network); 19 Apr 2019 13:30:01 -0000
Received: from unknown (HELO techsingularity.net) (mgorman@techsingularity.net@[37.228.225.79])
  by 81.17.254.9 with ESMTPSA (AES256-SHA encrypted, authenticated); 19 Apr 2019 13:30:01 -0000
Date:   Fri, 19 Apr 2019 14:30:00 +0100
From:   Mel Gorman <mgorman@techsingularity.net>
To:     Vlastimil Babka <vbabka@suse.cz>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Li Wang <liwang@redhat.com>, linux-mm <linux-mm@kvack.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mm, page_alloc: Always use a captured page regardless of
 compaction result
Message-ID: <20190419133000.GL18914@techsingularity.net>
References: <20190419085133.GH18914@techsingularity.net>
 <e99a54aa-bc21-d3f3-54a5-5da0039216a9@suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
In-Reply-To: <e99a54aa-bc21-d3f3-54a5-5da0039216a9@suse.cz>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 19, 2019 at 02:54:54PM +0200, Vlastimil Babka wrote:
> On 4/19/19 10:51 AM, Mel Gorman wrote:
> > During the development of commit 5e1f0f098b46 ("mm, compaction: capture
> > a page under direct compaction"), a paranoid check was added to ensure
> > that if a captured page was available after compaction that it was
> > consistent with the final state of compaction. The intent was to catch
> > serious programming bugs such as using a stale page pointer and causing
> > corruption problems.
> > 
> > However, it is possible to get a captured page even if compaction was
> > unsuccessful if an interrupt triggered and happened to free pages in
> > interrupt context that got merged into a suitable high-order page. It's
> > highly unlikely but Li Wang did report the following warning on s390
> > occuring when testing OOM handling. Note that the warning is slightly
> > edited for clarity.
> > 
> > [ 1422.124060] WARNING: CPU: 0 PID: 9783 at mm/page_alloc.c:3777 __alloc_pages_direct_compact+0x182/0x190
> > [ 1422.124065] Modules linked in: rpcsec_gss_krb5 auth_rpcgss nfsv4 dns_resolver
> >  nfs lockd grace fscache sunrpc pkey ghash_s390 prng xts aes_s390 des_s390
> >  des_generic sha512_s390 zcrypt_cex4 zcrypt vmur binfmt_misc ip_tables xfs
> >  libcrc32c dasd_fba_mod qeth_l2 dasd_eckd_mod dasd_mod qeth qdio lcs ctcm
> >  ccwgroup fsm dm_mirror dm_region_hash dm_log dm_mod
> > [ 1422.124086] CPU: 0 PID: 9783 Comm: copy.sh Kdump: loaded Not tainted 5.1.0-rc 5 #1
> > 
> > This patch simply removes the check entirely instead of trying to be
> > clever about pages freed from interrupt context. If a serious programming
> > error was introduced, it is highly likely to be caught by prep_new_page()
> > instead.
> > 
> > Fixes: 5e1f0f098b46 ("mm, compaction: capture a page under direct compaction")
> > Reported-by: Li Wang <liwang@redhat.com>
> > Signed-off-by: Mel Gorman <mgorman@techsingularity.net>
> 
> Ah, noticed the new formal resend only after replying to the first one,
> so here goes again:
> 
> Yup, no need for a Cc: stable on a very rare WARN_ON_ONCE. So the AI
> will pick it anyway...
> 
> Acked-by: Vlastimil Babka <vbabka@suse.cz>
> 

With luck, this will be picked up and sent to Linus before 5.1 releases
and then the stable bot will not need to touch the commit at all.

-- 
Mel Gorman
SUSE Labs
