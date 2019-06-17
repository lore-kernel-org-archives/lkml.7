Return-Path: <SRS0=xALZ=UQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22941C31E44
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Jun 2019 07:05:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EF000218DA
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Jun 2019 07:05:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (4096-bit key) header.d=d-silva.org header.i=@d-silva.org header.b="NGiJvBHc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726027AbfFQHFx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Jun 2019 03:05:53 -0400
Received: from ushosting.nmnhosting.com ([66.55.73.32]:39872 "EHLO
        ushosting.nmnhosting.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725778AbfFQHFx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jun 2019 03:05:53 -0400
Received: from mail2.nmnhosting.com (unknown [202.169.106.97])
        by ushosting.nmnhosting.com (Postfix) with ESMTPS id 31E9E2DC00DD;
        Mon, 17 Jun 2019 03:05:50 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=d-silva.org;
        s=201810a; t=1560755150;
        bh=TotXHfC7mkapkJQ2eQkYpljIPSR0AGxVy5++z04zxGQ=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=NGiJvBHcjG+CIJgh2IA052h5ANspPN8jd6fbOzhRCeYoBkvDtYW+xqsOtyM2owh+k
         4I9pLIhjyYJt5cgWRd28JYXp0bTSacf9BS/6eJz79G4zkKDIgkw9/n0k8lHtFL3LYp
         v6tzGJy8rz0AsiUeHmLRARxW04mbdQIaGytijoRJI+CsPgvLrNSlEWtF8+pQvi/FLC
         q0pXW1PJbIhDE4w+Es0IRXymmb6XQY8I2CCHKSA0okkQJOroNpGsWvNPvzkkluzmSe
         nI7bFZ3e2yV6m+5WsqT9A3jJepIOzW9z8JppoC0qktOWqNlBfmgSlBIWhb/PoN81MJ
         JKgebF9nGgSxXHZsWCTsEeDnYxPk/FCZlReafmBAy4zMLzfAKV/09mSMxtjxVl3hbi
         Iv4+6f6qw0YG+ODfXXtHDaPBQyac3wi6mHDBVabHjDUGlUpxQ/9oBxTIGVnSXjkcOr
         TMZ2EN5AYJY6QToHs1sZLafhiOVj3hh66/5+qwuTIpzwKMGQgiJ5lWeiZBLgrWz4P5
         EKcMctBcYaUoVyx6Fo4znLsXbgY2xD8wLUao2qjobGSSPvVBSrmKc0p6YuWv5cNS9X
         JmmB1UF1DlY3K1Sj4QirQKVF2VopERlT4pcRhBeBhtPSbH2KloRI6VOS0aoo0bLBWT
         qX8Q1bXR5rLneh8uTOVhd0rI=
Received: from adsilva.ozlabs.ibm.com (static-82-10.transact.net.au [122.99.82.10] (may be forged))
        (authenticated bits=0)
        by mail2.nmnhosting.com (8.15.2/8.15.2) with ESMTPSA id x5H75Utj056973
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NO);
        Mon, 17 Jun 2019 17:05:46 +1000 (AEST)
        (envelope-from alastair@d-silva.org)
Message-ID: <f1bad6f784efdd26508b858db46f0192a349c7a1.camel@d-silva.org>
Subject: Re: [PATCH 5/5] mm/hotplug: export try_online_node
From:   "Alastair D'Silva" <alastair@d-silva.org>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        David Hildenbrand <david@redhat.com>,
        Oscar Salvador <osalvador@suse.com>,
        Michal Hocko <mhocko@suse.com>,
        Pavel Tatashin <pasha.tatashin@soleen.com>,
        Wei Yang <richard.weiyang@gmail.com>,
        Arun KS <arunks@codeaurora.org>, Qian Cai <cai@lca.pw>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@kernel.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Jiri Kosina <jkosina@suse.cz>,
        Mukesh Ojha <mojha@codeaurora.org>,
        Mike Rapoport <rppt@linux.vnet.ibm.com>,
        Baoquan He <bhe@redhat.com>,
        Logan Gunthorpe <logang@deltatee.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Date:   Mon, 17 Jun 2019 17:05:30 +1000
In-Reply-To: <20190617065921.GV3436@hirez.programming.kicks-ass.net>
References: <20190617043635.13201-1-alastair@au1.ibm.com>
         <20190617043635.13201-6-alastair@au1.ibm.com>
         <20190617065921.GV3436@hirez.programming.kicks-ass.net>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.32.2 (3.32.2-1.fc30) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.6.2 (mail2.nmnhosting.com [10.0.1.20]); Mon, 17 Jun 2019 17:05:46 +1000 (AEST)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2019-06-17 at 08:59 +0200, Peter Zijlstra wrote:
> On Mon, Jun 17, 2019 at 02:36:31PM +1000, Alastair D'Silva wrote:
> > From: Alastair D'Silva <alastair@d-silva.org>
> > 
> > If an external driver module supplies physical memory and needs to
> > expose
> 
> Why would you ever want to allow a module to do such a thing?
> 

I'm working on a driver for Storage Class Memory, connected via an
OpenCAPI link.

The memory is only usable once the card says it's OK to access it.

-- 
Alastair D'Silva           mob: 0423 762 819
skype: alastair_dsilva    
Twitter: @EvilDeece
blog: http://alastair.d-silva.org


