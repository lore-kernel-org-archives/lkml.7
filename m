Return-Path: <SRS0=vI2Y=WC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0D549C433FF
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Aug 2019 21:25:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D6F06216F4
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Aug 2019 21:25:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726698AbfHFVZE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 6 Aug 2019 17:25:04 -0400
Received: from mga17.intel.com ([192.55.52.151]:3493 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726044AbfHFVZE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Aug 2019 17:25:04 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga107.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 06 Aug 2019 14:25:04 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,353,1559545200"; 
   d="scan'208";a="165111737"
Received: from sai-dev-mach.sc.intel.com ([143.183.140.153])
  by orsmga007.jf.intel.com with ESMTP; 06 Aug 2019 14:25:03 -0700
Message-ID: <25c28a6e5137aa396bc13a2f581566e13e98f45e.camel@intel.com>
Subject: Re: [PATCH V2] fork: Improve error message for corrupted page tables
From:   Sai Praneeth Prakhya <sai.praneeth.prakhya@intel.com>
To:     Michal Hocko <mhocko@kernel.org>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        dave.hansen@intel.com, Ingo Molnar <mingo@kernel.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        Peter Zijlstra <peterz@infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Anshuman Khandual <anshuman.khandual@arm.com>
Date:   Tue, 06 Aug 2019 14:21:54 -0700
In-Reply-To: <20190806083605.GA19060@dhcp22.suse.cz>
References: <3ef8a340deb1c87b725d44edb163073e2b6eca5a.1565059496.git.sai.praneeth.prakhya@intel.com>
         <20190806083605.GA19060@dhcp22.suse.cz>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.30.5-0ubuntu0.18.10.1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2019-08-06 at 10:36 +0200, Michal Hocko wrote:
> On Mon 05-08-19 20:05:27, Sai Praneeth Prakhya wrote:
> > When a user process exits, the kernel cleans up the mm_struct of the user
> > process and during cleanup, check_mm() checks the page tables of the user
> > process for corruption (E.g: unexpected page flags set/cleared). For
> > corrupted page tables, the error message printed by check_mm() isn't very
> > clear as it prints the loop index instead of page table type (E.g:
> > Resident
> > file mapping pages vs Resident shared memory pages). The loop index in
> > check_mm() is used to index rss_stat[] which represents individual memory
> > type stats. Hence, instead of printing index, print memory type, thereby
> > improving error message.
> > 
> > Without patch:
> > --------------
> > [  204.836425] mm/pgtable-generic.c:29: bad p4d
> > 0000000089eb4e92(800000025f941467)
> > [  204.836544] BUG: Bad rss-counter state mm:00000000f75895ea idx:0 val:2
> > [  204.836615] BUG: Bad rss-counter state mm:00000000f75895ea idx:1 val:5
> > [  204.836685] BUG: non-zero pgtables_bytes on freeing mm: 20480
> > 
> > With patch:
> > -----------
> > [   69.815453] mm/pgtable-generic.c:29: bad p4d
> > 0000000084653642(800000025ca37467)
> > [   69.815872] BUG: Bad rss-counter state mm:00000000014a6c03
> > type:MM_FILEPAGES val:2
> > [   69.815962] BUG: Bad rss-counter state mm:00000000014a6c03
> > type:MM_ANONPAGES val:5
> > [   69.816050] BUG: non-zero pgtables_bytes on freeing mm: 20480
> 
> I like this. On any occasion I am investigating an issue with an rss
> inbalance I have to go back to kernel sources to see which pte type that
> is.
> 

Hopefully, this patch will be useful to you the next time you run into any rss
imbalance issues.

> > Also, change print function (from printk(KERN_ALERT, ..) to pr_alert()) so
> > that it matches the other print statement.
> 
> good change as well. Maybe we should also lower the loglevel (in a
> separate patch) as well. While this is not nice because we are
> apparently leaking memory behind it shouldn't be really critical enough
> to jump on normal consoles.

Ya.. I think, probably could be lowered to pr_err() or pr_warn().

Regards,
Sai

