Return-Path: <SRS0=vY9Y=RJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 18CB9C43381
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Mar 2019 08:53:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E3BEA20675
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Mar 2019 08:53:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729161AbfCFIxF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 Mar 2019 03:53:05 -0500
Received: from mx2.suse.de ([195.135.220.15]:37486 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726156AbfCFIxF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Mar 2019 03:53:05 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 0FC33AFDF;
        Wed,  6 Mar 2019 08:53:04 +0000 (UTC)
Date:   Wed, 6 Mar 2019 09:53:03 +0100 (CET)
From:   Richard Biener <rguenther@suse.de>
To:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        dave.hansen@intel.com
cc:     mhocko@suse.com
Subject: Kernel bug with MPX?
Message-ID: <alpine.LSU.2.20.1903060944550.7898@zhemvz.fhfr.qr>
User-Agent: Alpine 2.20 (LSU 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Hi,

I've reported this internally but got directed here, hopefully
the correct forum for bugreporting.

When running the gcc.target/i386/mpx/memmove-1.c testcase
from the GCC 8 branch on MPX capable hardware the testcase
faults and the kernel log reports the following:

[1216548.787494] BUG: Bad rss-counter state mm:0000000017ce560b idx:0 
val:385
[1216548.787498] BUG: Bad rss-counter state mm:0000000017ce560b idx:1 
val:551
[1216548.787500] BUG: non-zero pgtables_bytes on freeing mm: 24576

This is on a 4.20.7 kernel but it was reproduced it with 5.0 as well.
I believe it was fine on earlier kernels though.

I've put a statically linked executable at
http://www.suse.de/~rguenther/memmove-1.exe (needs some time to sync
to the public webserver still).

Thanks,
Richard.

-- 
Richard Biener <rguenther@suse.de>
SUSE LINUX GmbH, GF: Felix Imendoerffer, Jane Smithard, Graham Norton, HRB 21284 (AG Nuernberg)

---------- Forwarded message ----------
Date: Tue, 5 Mar 2019 15:22:22 +0100
From: Michal Hocko <mhocko@suse.com>
To: Richard Biener <rguenther@suse.de>
Cc: suse-labs@suse.de
Subject: Re: [suse-labs] Kernel bug with MPX?

On Mon 04-03-19 14:12:07, Richard Guenther wrote:
> 
> I have a MPX testcase (GCC mpx testsuite) that triggers
> 
> [1216548.787494] BUG: Bad rss-counter state mm:0000000017ce560b idx:0 
> val:385
> [1216548.787498] BUG: Bad rss-counter state mm:0000000017ce560b idx:1 
> val:551
> [1216548.787500] BUG: non-zero pgtables_bytes on freeing mm: 24576
> 
> on Tumbleweed from a few weeks ago

That looks like both file and anonymous mappings do not get torn down
properly and some memory leaks.

> > uname -a
> Linux e23 4.20.7-1-default #1 SMP PREEMPT Thu Feb 7 07:16:45 UTC 2019 
> (730812f) x86_64 x86_64 x86_64 GNU/Linux
> 
> does this ring any bell?

Not really but I haven't been following MPX development closely. I
can reproduce the issue on 5.0 kernel

BUG: Bad rss-counter state mm:00000000406bd30e idx:1 val:25591

so I guess it would be best to report upstream (Cc linux-mm@kvack.org,
linux-kernel@vger.kernel.org and dave.hansen@intel.com). Let me know if
you need any help.

-- 
Michal Hocko
SUSE Labs

