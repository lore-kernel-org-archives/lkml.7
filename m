Return-Path: <SRS0=XKeO=YB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6454EC10F14
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Oct 2019 13:08:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 43CDA206BB
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Oct 2019 13:08:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730988AbfJHNIG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 8 Oct 2019 09:08:06 -0400
Received: from mx2.suse.de ([195.135.220.15]:52568 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1730583AbfJHNIG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Oct 2019 09:08:06 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 909EDB147;
        Tue,  8 Oct 2019 13:08:04 +0000 (UTC)
Date:   Tue, 8 Oct 2019 15:08:03 +0200
From:   Petr Mladek <pmladek@suse.com>
To:     Qian Cai <cai@lca.pw>
Cc:     sergey.senozhatsky.work@gmail.com, rostedt@goodmis.org,
        peterz@infradead.org, mhocko@kernel.org, linux-mm@kvack.org,
        john.ogness@linutronix.de, akpm@linux-foundation.org,
        david@redhat.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] mm/page_isolation: fix a deadlock with printk()
Message-ID: <20191008130803.jf3xdtyt3qpfotn5@pathway.suse.cz>
References: <1570228005-24979-1-git-send-email-cai@lca.pw>
 <20191007143002.l37bt2lzqtnqjqxu@pathway.suse.cz>
 <1570460350.5576.290.camel@lca.pw>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1570460350.5576.290.camel@lca.pw>
User-Agent: NeoMutt/20170912 (1.9.0)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon 2019-10-07 10:59:10, Qian Cai wrote:
> It is almost impossible to eliminate all the indirect call chains from
> console_sem/console_owner_lock to zone->lock because it is too normal that
> something later needs to allocate some memory dynamically, so as long as it
> directly call printk() with zone->lock held, it will be in trouble.

It is not normal the something needs to allocate memory under
console_sem. Console drivers are supposed to get the message
out even when the system is in really bad state and it is not
possible to allocate memory. I consider this a bug in the console
driver.

> I really hope the new printk() will solve this class of the problem, but it is
> essentially up to the air until a patchset was posted. There are just too many
> questions out there to be answered.

The new printk should prevent all deadlocks simply because it will
be fully lockless. The console drivers will be called from dedicated
kthreads and therefore from a well defined context.

Best Regards,
Petr
