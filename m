Return-Path: <SRS0=/uHP=YM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C175ACA9EAC
	for <linux-kernel@archiver.kernel.org>; Sat, 19 Oct 2019 21:38:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8CAB821925
	for <linux-kernel@archiver.kernel.org>; Sat, 19 Oct 2019 21:38:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="iRk/D3dE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726175AbfJSVf6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 19 Oct 2019 17:35:58 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:43572 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726136AbfJSVf6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 19 Oct 2019 17:35:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=gjMV5AwPDVYcHUUO3sw6vsjP2HHaDOfcFlf0JjRbYiw=; b=iRk/D3dE3yFtdYVu6TH9/DPjH
        M69yxlV4MF0kkMHMm1AHQjQTle4YKS/GbHsUKEzbGdbMxtpIsr1chQtw6BmXF8KE6gB2eXlzYfb/2
        M3fndCB824a9dNv2mQKh/J+sBbjXHYk/HSdWtMkg9849AUOdWGr5St8zkRAcJ1HJ14IjGkI5XfzVb
        jlKtknZiiO5feC2QJ6kDFldmGdJp8kOBofXYWndfdgMsOdSbUZO1et4iN8ikG+EBQLRcQFlK64yQK
        Xp0f/IF670PtZP2AitjCwCToyyb0khzLPBf1YiP088VeUhyJ+qwewbt/3aVWoVRy4NGO1oZ1igJiH
        YKwD06qTA==;
Received: from willy by bombadil.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1iLwOC-0002N3-8t; Sat, 19 Oct 2019 21:35:56 +0000
Date:   Sat, 19 Oct 2019 14:35:56 -0700
From:   Matthew Wilcox <willy@infradead.org>
To:     Dan Williams <dan.j.williams@intel.com>
Cc:     Jan Kara <jack@suse.cz>, kernel test robot <rong.a.chen@intel.com>,
        Robert Barror <robert.barror@intel.com>,
        Seema Pandit <seema.pandit@intel.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        lkp@lists.01.org
Subject: Re: [dax] 23c84eb783: fio.write_bw_MBps -61.6% regression
Message-ID: <20191019213556.GO32665@bombadil.infradead.org>
References: <20191018082354.GA9296@shao2-debian>
 <20191018094810.GB18593@quack2.suse.cz>
 <CAPcyv4jjfT4xOQTrckEmX0Z_o6MbsmHz-qvCLAGSOPEe3-X0QA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAPcyv4jjfT4xOQTrckEmX0Z_o6MbsmHz-qvCLAGSOPEe3-X0QA@mail.gmail.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 18, 2019 at 04:12:03PM -0700, Dan Williams wrote:
> I've got several reports of v5.3 performance regressions tracking back
> to this change. I instrumented the ndctl "dax.sh" unit test to
> validate that it is getting huge page faults and it always falls back
> to 4K starting with these commits. It looks like the xa_is_internal()
> returns true for any DAX_LOCKED entry.

That's not true today, but I do intend to make it true at some point.
I think we can reclaim three bits from the encoding of a DAX entry,
allowing us to support three more physical bits on a 32-bit system.
Clearly that hasn't been a focus so far.

The plan is ...

DAX_LOCKED -> XA_LOCK_ENTRY (xa_mk_internal(something))

DAX_ZERO_PAGE -> XA_ZERO_ENTRY

DAX_EMPTY goes away.  It's only used in combination with DAX_LOCKED, and
it won't be necessary once DAX_LOCKED has become XA_LOCK_ENTRY.

DAX_PMD essentially stays, but we can encode arbitrary orders using a single
bit rather than just PTE vs PMD.

We may need to encode a size in DAX_LOCKED, or we may be able to get that
information from the XArray.  Anyway, this transformation is about tenth
on my todo list right now, so if someone else wants to take this on ...
