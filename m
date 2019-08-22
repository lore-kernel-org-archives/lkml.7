Return-Path: <SRS0=/WLL=WS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8CB5C3A5A1
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Aug 2019 18:55:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C7129205ED
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Aug 2019 18:55:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391204AbfHVSz0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 22 Aug 2019 14:55:26 -0400
Received: from mga01.intel.com ([192.55.52.88]:9171 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726142AbfHVSzX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Aug 2019 14:55:23 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga101.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 22 Aug 2019 11:55:22 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,417,1559545200"; 
   d="scan'208";a="208278528"
Received: from tassilo.jf.intel.com (HELO tassilo.localdomain) ([10.7.201.137])
  by fmsmga002.fm.intel.com with ESMTP; 22 Aug 2019 11:55:22 -0700
Received: by tassilo.localdomain (Postfix, from userid 1000)
        id 80D85300FFA; Thu, 22 Aug 2019 11:55:22 -0700 (PDT)
Date:   Thu, 22 Aug 2019 11:55:22 -0700
From:   Andi Kleen <ak@linux.intel.com>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     kan.liang@linux.intel.com, peterz@infradead.org, mingo@redhat.com,
        acme@kernel.org, linux-kernel@vger.kernel.org, eranian@google.com
Subject: Re: [PATCH V2] perf/x86: Consider pinned events for group validation
Message-ID: <20190822185522.GE5447@tassilo.jf.intel.com>
References: <1566488866-5975-1-git-send-email-kan.liang@linux.intel.com>
 <20190822182227.GD5447@tassilo.jf.intel.com>
 <alpine.DEB.2.21.1908222029210.1983@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.21.1908222029210.1983@nanos.tec.linutronix.de>
User-Agent: Mutt/1.12.0 (2019-05-25)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 22, 2019 at 08:29:46PM +0200, Thomas Gleixner wrote:
> On Thu, 22 Aug 2019, Andi Kleen wrote:
> 
> > > +	/*
> > > +	 * Disable interrupts to prevent the events in this CPU's cpuc
> > > +	 * going away and getting freed.
> > > +	 */
> > > +	local_irq_save(flags);
> > 
> > I believe it's also needed to disable preemption. Probably should
> > add a comment, or better an explicit preempt_disable() too.
> 
> Preemption is implicit disabled by disabling interrupts.

Yes it is, this is more for documentation.

-Andi
