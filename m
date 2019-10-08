Return-Path: <SRS0=XKeO=YB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 28BF4C4360C
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Oct 2019 10:39:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 02D9F206C2
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Oct 2019 10:39:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1570531156;
	bh=gdWIcm/fEQmlP/oJYmxNy/wnrsGTgCCRS51f7LuUMRo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=S4QSOePT3zVjH1RdW7/ZSfXcFeUR7a5JCJUHA0DNllcyQiMwZ+yqA3FTEVzutwzc1
	 daL554jDhdsyPROyGcQG6n1JQ++YMjidAiDosCvVzfK2chI4PFnogZ2I4rcgiwG7Z4
	 AcsJJK35AhOUOF5wLiY+BPDvj6jXWJ/Ocv6e5G3k=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729893AbfJHKjP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 8 Oct 2019 06:39:15 -0400
Received: from mx2.suse.de ([195.135.220.15]:41300 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1730256AbfJHKjK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Oct 2019 06:39:10 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id EB0CFAEAF;
        Tue,  8 Oct 2019 10:39:08 +0000 (UTC)
Date:   Tue, 8 Oct 2019 12:39:07 +0200
From:   Michal Hocko <mhocko@kernel.org>
To:     Qian Cai <cai@lca.pw>
Cc:     Petr Mladek <pmladek@suse.com>, akpm@linux-foundation.org,
        sergey.senozhatsky.work@gmail.com, rostedt@goodmis.org,
        peterz@infradead.org, linux-mm@kvack.org,
        john.ogness@linutronix.de, david@redhat.com,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] mm/page_isolation: fix a deadlock with printk()
Message-ID: <20191008103907.GE6681@dhcp22.suse.cz>
References: <20191008084031.GC6681@dhcp22.suse.cz>
 <298970BD-529E-4095-8D87-61470ADBDD32@lca.pw>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <298970BD-529E-4095-8D87-61470ADBDD32@lca.pw>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue 08-10-19 06:04:32, Qian Cai wrote:
> 
> 
> > On Oct 8, 2019, at 4:40 AM, Michal Hocko <mhocko@kernel.org> wrote:
> > 
> > Does this tip point to a real deadlock or merely a class of lockdep
> > false dependencies?
> 
> I lean towards it is a real deadlock given how trivial to generate those lock orders everywhere.

Have you actually triggered any real deadlock? With a zone->lock in
place it would be pretty clear with hard lockups detected.

-- 
Michal Hocko
SUSE Labs
