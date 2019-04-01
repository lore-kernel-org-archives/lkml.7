Return-Path: <SRS0=/BGd=SD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 587B1C43381
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Apr 2019 10:28:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2497520883
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Apr 2019 10:28:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726580AbfDAK2R (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Apr 2019 06:28:17 -0400
Received: from mga11.intel.com ([192.55.52.93]:57598 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725889AbfDAK2Q (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Apr 2019 06:28:16 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga102.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 01 Apr 2019 03:28:16 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.60,296,1549958400"; 
   d="scan'208";a="333890611"
Received: from smile.fi.intel.com (HELO smile) ([10.237.72.86])
  by fmsmga005.fm.intel.com with ESMTP; 01 Apr 2019 03:28:09 -0700
Received: from andy by smile with local (Exim 4.92)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1hAuAg-0003zN-6d; Mon, 01 Apr 2019 13:28:06 +0300
Date:   Mon, 1 Apr 2019 13:28:06 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     George Spelvin <lkml@sdf.org>
Cc:     st5pub@yandex.ru, adrian.hunter@intel.com,
        ard.biesheuvel@linaro.org, benh@kernel.crashing.org, bp@alien8.de,
        darrick.wong@oracle.com, dchinner@redhat.com, dedekind1@gmail.com,
        gregkh@linuxfoundation.org, hpa@zytor.com, jannh@google.com,
        jlbec@evilplan.org, jpoimboe@redhat.com, jslaby@suse.cz,
        linux-kernel@vger.kernel.org, linux-mtd@lists.infradead.org,
        linux-snps-arc@lists.infradead.org, linuxppc-dev@lists.ozlabs.org,
        mark@fasheh.com, mingo@redhat.com, mpe@ellerman.id.au,
        naveen.n.rao@linux.vnet.ibm.com, ocfs2-devel@oss.oracle.com,
        paulus@samba.org, peterz@infradead.org, richard@nod.at,
        sfr@canb.auug.org.au, tglx@linutronix.de, vgupta@synopsys.com,
        x86@kernel.org
Subject: Re: [PATCH v2 5/5] Lib: sort.h: replace int size with size_t size in
 the swap function
Message-ID: <20190401102806.GE9224@smile.fi.intel.com>
References: <19606671554056883@myt3-1179f584969c.qloud-c.yandex.net>
 <23051461554058370@iva6-3ac3de5fcc31.qloud-c.yandex.net>
 <20190401093555.GD9224@smile.fi.intel.com>
 <201904010956.x319u70q021113@sdf.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <201904010956.x319u70q021113@sdf.org>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 01, 2019 at 09:56:07AM +0000, George Spelvin wrote:
> On Mon, 1 Apr 2019 at 12:35:55 +0300, Andy Shevchenko wrote:
> > Hmm... If (*swap)() is called recursively it means the change might increase
> > stack usage on 64-bit platforms.
> > 
> > Am I missing something?
> 
> Under what conceivable circumstance would someone write a recursive
> (*swap)() function?
> 
> You're technically right, but the precondition is more fantastical
> than "if the U.K.'s parliament get their shit together before the
> 12th", so I have a hard time worrying about it.
> 
> But you did make me think of something: the whole reason swap()
> takes a size argument is for the benefit of the (no longer existing)
> generic swap functions.  All of the custom swap functions ignore
> it.
> 
> So how about *deleting* the parameter instead?  That simplifies
> everything.

I like this idea!

-- 
With Best Regards,
Andy Shevchenko


