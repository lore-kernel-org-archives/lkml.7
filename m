Return-Path: <SRS0=LehB=SZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6A870C282DD
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Apr 2019 17:53:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 33DAE214AE
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Apr 2019 17:53:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="V+AOhodA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728752AbfDWRxe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Apr 2019 13:53:34 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:34374 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726655AbfDWRxd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Apr 2019 13:53:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=Hu2+IHvU0rbjKTuDhKIV7ajzUzxsMVFATjP9eUoiQdA=; b=V+AOhodAI+KAMRnXGD2WAOGJQ
        xPQ5d4bCeODBL2OqoCj8evwLcikkJhxk2qk5dh2E9kn+CSgyJqTsvvCYZuxJN219WNLsMnIdgCQaT
        Ly79tNmWBMwlhG/27ffMqzsvCfZfASKYN20e9Xz3d7iJ+NnXgIXBn1kHe2YN8jGrUSp1zwKQx54Nz
        Z01b+yw3jDza/c4oO9DOUwFLRUVtnwKSZtXnK6H/urYIjYe7sMGC31dg0UvgwmZbnOjI3exfVz7yS
        vYqqufXzb4cR/PfHUEpOSMEF8OBUWV30jwMwH3U99FNG0Ub6dRVQbaMAv5593KRL76F9wBL7C5SlE
        Mc/SjbtAg==;
Received: from willy by bombadil.infradead.org with local (Exim 4.90_1 #2 (Red Hat Linux))
        id 1hIzbi-0001CA-UI; Tue, 23 Apr 2019 17:53:26 +0000
Date:   Tue, 23 Apr 2019 10:53:26 -0700
From:   Matthew Wilcox <willy@infradead.org>
To:     syzbot <syzbot+35a50f1f6dfd5a0d7378@syzkaller.appspotmail.com>
Cc:     akpm@linux-foundation.org, aneesh.kumar@linux.ibm.com,
        dave.jiang@intel.com, hughd@google.com, jglisse@redhat.com,
        jrdr.linux@gmail.com, kirill.shutemov@linux.intel.com,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org, mhocko@suse.com,
        rientjes@google.com, syzkaller-bugs@googlegroups.com,
        vbabka@suse.cz
Subject: Re: WARNING: locking bug in split_huge_page_to_list
Message-ID: <20190423175326.GC19031@bombadil.infradead.org>
References: <0000000000003c9bea058734dc28@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0000000000003c9bea058734dc28@google.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 23, 2019 at 09:13:06AM -0700, syzbot wrote:
> DEBUG_LOCKS_WARN_ON(class_idx > MAX_LOCKDEP_KEYS)
> WARNING: CPU: 0 PID: 1553 at kernel/locking/lockdep.c:3673
> __lock_acquire+0x1887/0x3fb0 kernel/locking/lockdep.c:3673
>  down_write+0x38/0x90 kernel/locking/rwsem.c:70
>  anon_vma_lock_write include/linux/rmap.h:120 [inline]

All anon_vmas share the same lockdep map, so I think this is just a
victim of someone else who's taken all the lockdep classes.
