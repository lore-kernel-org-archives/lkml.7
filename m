Return-Path: <SRS0=SZ1Q=SM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92A30C10F11
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Apr 2019 07:02:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5A7582083E
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Apr 2019 07:02:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="HU+EGn9l"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728795AbfDJHCa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Apr 2019 03:02:30 -0400
Received: from merlin.infradead.org ([205.233.59.134]:50546 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727323AbfDJHCa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Apr 2019 03:02:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=1XuNlBSLxIvEfiRYq+DxPWuv5J3N61EmHgJGf58aaiQ=; b=HU+EGn9lau3DLxnN4TGlPhnkE
        qdec7OBUvVDXCyehVfD9o3yg4CLRy12VlzOKUqRkZZEuzNcNy5rn+DkaOozgUKGCnmG+IL0Tep6XV
        oMRcLSKthg+lRlM/Edamweyb/YMIlLd+6QRPkn+EXW1uxxFE0CAkUdICPCqePVt38uFw7RqLlepEf
        nu6hfn43+G5qC3K1QqKcRjYUMZ5eljKADF+r0o+3Y+7KbA6BJNGSs1RwltaD9PV/1seKUCtfSpgqn
        C1nm9aiqj+LnlCTOd1Tf9Hb8xlPPTzUVUJ62hClJUQAqAzpNDhL9HJuxqRypUbSC2PT4UFNmnBovI
        21+fETsmQ==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1hE7F7-0006Dc-V0; Wed, 10 Apr 2019 07:01:58 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 54A41201F29A7; Wed, 10 Apr 2019 09:01:52 +0200 (CEST)
Date:   Wed, 10 Apr 2019 09:01:52 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Ricardo Neri <ricardo.neri-calderon@linux.intel.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@kernel.org>, Borislav Petkov <bp@suse.de>,
        Ashok Raj <ashok.raj@intel.com>,
        Andi Kleen <andi.kleen@intel.com>,
        "Ravi V. Shankar" <ravi.v.shankar@intel.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org,
        Ricardo Neri <ricardo.neri@intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>, Tony Luck <tony.luck@intel.com>,
        Clemens Ladisch <clemens@ladisch.de>,
        Arnd Bergmann <arnd@arndb.de>,
        Philippe Ombredanne <pombredanne@nexb.com>,
        Kate Stewart <kstewart@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Mimi Zohar <zohar@linux.ibm.com>,
        Jan Kiszka <jan.kiszka@siemens.com>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Nayna Jain <nayna@linux.ibm.com>
Subject: Re: [RFC PATCH v2 12/14] x86/watchdog/hardlockup/hpet: Determine if
 HPET timer caused NMI
Message-ID: <20190410070152.GV11158@hirez.programming.kicks-ass.net>
References: <1551283518-18922-1-git-send-email-ricardo.neri-calderon@linux.intel.com>
 <1551283518-18922-13-git-send-email-ricardo.neri-calderon@linux.intel.com>
 <20190409112817.GT4038@hirez.programming.kicks-ass.net>
 <20190410011957.GC10062@ranerica-svr.sc.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190410011957.GC10062@ranerica-svr.sc.intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 09, 2019 at 06:19:57PM -0700, Ricardo Neri wrote:
> On Tue, Apr 09, 2019 at 01:28:17PM +0200, Peter Zijlstra wrote:
> > > @@ -147,6 +161,14 @@ static void set_periodic(struct hpet_hld_data *hdata)
> > >   */
> > >  static bool is_hpet_wdt_interrupt(struct hpet_hld_data *hdata)
> > >  {
> > > +	if (smp_processor_id() == hdata->handling_cpu) {
> > > +		unsigned long tsc_curr;
> > 
> > TSC is u64
> 
> In x86_64, isn't u64 an unsigned long? Do you mean to consider the
> 32-bit case?

Unless none of this code is available for x86_32, you pretty much have
to consider 32bit.

But even then, using u64 for 64bit values is the right thing.
