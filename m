Return-Path: <SRS0=g5d9=RD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5C996C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Feb 2019 15:44:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3324E218AE
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Feb 2019 15:44:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733111AbfB1Pof (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Feb 2019 10:44:35 -0500
Received: from mga03.intel.com ([134.134.136.65]:2666 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732736AbfB1Poe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Feb 2019 10:44:34 -0500
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga103.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 28 Feb 2019 07:44:33 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.58,423,1544515200"; 
   d="scan'208";a="142411180"
Received: from sjchrist-coffee.jf.intel.com (HELO linux.intel.com) ([10.54.74.181])
  by orsmga001.jf.intel.com with ESMTP; 28 Feb 2019 07:44:33 -0800
Date:   Thu, 28 Feb 2019 07:44:33 -0800
From:   Sean Christopherson <sean.j.christopherson@intel.com>
To:     Dave Hansen <dave.hansen@linux.intel.com>,
        Andy Lutomirski <luto@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "x86@kernel.org" <x86@kernel.org>
Cc:     "H. Peter Anvin" <hpa@zytor.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Rik van Riel <riel@surriel.com>,
        "Yu, Yu-cheng" <yu-cheng.yu@intel.com>,
        Ingo Molnar <mingo@kernel.org>
Subject: Re: [PATCH v3 0/2] x86/fault: Further improve #PF oops messages
Message-ID: <20190228154433.GB6166@linux.intel.com>
References: <20181221213657.27628-1-sean.j.christopherson@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181221213657.27628-1-sean.j.christopherson@intel.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

High latency ping.  These still apply as-is.

On Fri, Dec 21, 2018 at 01:36:55PM -0800, Sean Christopherson wrote:
> Rework the messages printed for #PF oopses to display more detailed
> information about the fault in human readable form and to avoid
> conflicting messages and/or statements that may not always be accurate.
> 
> v3:
>   - Prepend a patch to reword the initial BUG message
>   - Add sample output in the changelogs
>   - Swap the order of the #PF lines.  For most cases the three main lines
>     show up in reverse fir-tree ordering and the cause of the fault is
>     easy to pick out since it's the last thing highlighted by pr_alert
>     (excepting when dumping the IDT, GDT, etc...).
> 
> v2:
>   - Explicitly call out protection keys violations
>   - "Slightly" reword the changelog
> 
> v1: https://lkml.kernel.org/r/20181207195223.23968-1-sean.j.christopherson@intel.com
> v2: https://lkml.kernel.org/r/20181207184423.1962-1-sean.j.christopherson@intel.com
> 
> Sean Christopherson (2):
>   x86/fault: Reword initial BUG message for unhandled page faults
>   x86/fault: Decode and print #PF oops in human readable form
> 
>  arch/x86/mm/fault.c | 51 +++++++++++++++------------------------------
>  1 file changed, 17 insertions(+), 34 deletions(-)
> 
> -- 
> 2.19.2
> 
