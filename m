Return-Path: <SRS0=FHjv=VA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0D0D4C0650E
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Jul 2019 17:36:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E4AB8218A4
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Jul 2019 17:36:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727034AbfGCRgH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Jul 2019 13:36:07 -0400
Received: from mx1.redhat.com ([209.132.183.28]:35000 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726574AbfGCRgH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Jul 2019 13:36:07 -0400
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 838887FDCA;
        Wed,  3 Jul 2019 17:35:52 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.43.17.136])
        by smtp.corp.redhat.com (Postfix) with SMTP id 8F1EC1001B35;
        Wed,  3 Jul 2019 17:35:47 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
        oleg@redhat.com; Wed,  3 Jul 2019 19:35:52 +0200 (CEST)
Date:   Wed, 3 Jul 2019 19:35:47 +0200
From:   Oleg Nesterov <oleg@redhat.com>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Jens Axboe <axboe@kernel.dk>, Hugh Dickins <hughd@google.com>,
        Peter Zijlstra <peterz@infradead.org>, Qian Cai <cai@lca.pw>,
        hch@lst.de, gkohli@codeaurora.org, mingo@redhat.com,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] block: fix a crash in do_task_dead()
Message-ID: <20190703173546.GB21672@redhat.com>
References: <1559161526-618-1-git-send-email-cai@lca.pw>
 <20190530080358.GG2623@hirez.programming.kicks-ass.net>
 <82e88482-1b53-9423-baad-484312957e48@kernel.dk>
 <20190603123705.GB3419@hirez.programming.kicks-ass.net>
 <ddf9ee34-cd97-a62b-6e91-6b4511586339@kernel.dk>
 <alpine.LSU.2.11.1906301542410.1105@eggly.anvils>
 <97d2f5cc-fe98-f28e-86ce-6fbdeb8b67bd@kernel.dk>
 <20190702150615.1dfbbc2345c1c8f4d2a235c0@linux-foundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190702150615.1dfbbc2345c1c8f4d2a235c0@linux-foundation.org>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.27]); Wed, 03 Jul 2019 17:36:07 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 07/02, Andrew Morton wrote:

> On Mon, 1 Jul 2019 08:22:32 -0600 Jens Axboe <axboe@kernel.dk> wrote:
> 
> > Andrew, can you queue Oleg's patch for 5.2? You can also add my:
> > 
> > Reviewed-by: Jens Axboe <axboe@kernel.dk>
> 
> Sure.  Although things are a bit of a mess.  Oleg, can we please have a
> clean resend with signoffs and acks, etc?

OK, will do tomorrow. This cleanup can be improved, we can avoid get/put_task_struct
altogether, but need to recheck.

Oleg.

