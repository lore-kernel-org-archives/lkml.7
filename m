Return-Path: <SRS0=E/6H=U3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E3C7EC4321A
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Jun 2019 12:20:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B9DFB208C4
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Jun 2019 12:20:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726674AbfF1MUG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Jun 2019 08:20:06 -0400
Received: from mx2.suse.de ([195.135.220.15]:58616 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726542AbfF1MUG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Jun 2019 08:20:06 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id EF75CAFFA;
        Fri, 28 Jun 2019 12:20:04 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 7F892DAC70; Fri, 28 Jun 2019 14:20:48 +0200 (CEST)
Date:   Fri, 28 Jun 2019 14:20:47 +0200
From:   David Sterba <dsterba@suse.cz>
To:     David Sterba <DSterba@suse.com>
Cc:     peterz@infradead.org, mingo@redhat.com,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] lockdep: introduce lockdep_assert_not_held()
Message-ID: <20190628122047.GG20977@suse.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, David Sterba <DSterba@suse.com>,
        peterz@infradead.org, mingo@redhat.com,
        linux-kernel@vger.kernel.org
References: <20190613133604.9889-1-dsterba@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190613133604.9889-1-dsterba@suse.com>
User-Agent: Mutt/1.5.23.1 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 13, 2019 at 03:36:04PM +0200, David Sterba wrote:
> Add an assertion that a lock is not held, suitable for the following
> (simplified) usecase in filesystems:
> 
> - filesystem write
>   - lock(&big_filesystem_lock)
>   - kmalloc(GFP_KERNEL)
>     - trigger dirty data write to get more memory
>       - find dirty pages
>       - call filesystem write
>         - lock(&big_filesystem_lock)
> 	  deadlock
> 
> The cause here is the use of GFP_KERNEL that does not exclude poking
> filesystems to allow freeing some memory. Such scenario is a bug, so the
> use of GFP_NOFS is the right flag.
> 
> The annotation can help catch such bugs during development because
> the actual deadlock could be hard to hit in practice.
> 
> Signed-off-by: David Sterba <dsterba@suse.com>

Any comments on that? I just found another case with convoluted
callstacks where the lockdep assertion would catch the potential lock up
earlier than under the testing load.
