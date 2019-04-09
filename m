Return-Path: <SRS0=D3m8=SL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8A03DC10F0E
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Apr 2019 11:28:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 545872084C
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Apr 2019 11:28:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="fWaUpiWR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727229AbfDIL2q (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Apr 2019 07:28:46 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:60714 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726129AbfDIL2p (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Apr 2019 07:28:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=G6ULmSG0BNru+4dAKKU1SN0CstQxw7Ak6N5cxM5IRcE=; b=fWaUpiWRWuZHSwZ4uZovrsYFt
        rRxOVTHI4gv7Fnp4nTCSyAzZMvvxbjC9pkGPupAsZ5a3rekdXImiSv2brbh29JNZlAfzwg4+j1Qg2
        m3RtwHoqcEYe5iaWZvFM2I4DIJXN2CjfzB1dZ1gPBmEcSE9oHdMeimmpJ+1tu2gAB2rFjuwzw1WBd
        Eelil2j8EnNJ9p4BXcaTAd/1OrEpdZG55SLShyRKz+wcp/cadnJxOE//kcuTfKTMdxK/qxK3GwOFl
        Vuypo3/GctcVnCY/kCj5/wtEogrIEueWOjsIU0+5QmxrdDVMmWn7sD9Qhqs6Odgxd6xim1WXdGrVn
        DBXCAvoiw==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1hDovL-00045Y-8c; Tue, 09 Apr 2019 11:28:19 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id B7409201F29BA; Tue,  9 Apr 2019 13:28:17 +0200 (CEST)
Date:   Tue, 9 Apr 2019 13:28:17 +0200
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
Message-ID: <20190409112817.GT4038@hirez.programming.kicks-ass.net>
References: <1551283518-18922-1-git-send-email-ricardo.neri-calderon@linux.intel.com>
 <1551283518-18922-13-git-send-email-ricardo.neri-calderon@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1551283518-18922-13-git-send-email-ricardo.neri-calderon@linux.intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 27, 2019 at 08:05:16AM -0800, Ricardo Neri wrote:
> @@ -62,7 +67,18 @@ static inline void set_comparator(struct hpet_hld_data *hdata,
>  static void kick_timer(struct hpet_hld_data *hdata, bool force)
>  {
>  	bool kick_needed = force || !(hdata->flags & HPET_DEV_PERI_CAP);
> -	unsigned long new_compare, count;
> +	unsigned long tsc_curr, tsc_delta, new_compare, count;
> +
> +	/* Start obtaining the current TSC and HPET counts. */
> +	tsc_curr = rdtsc();
> +
> +	if (kick_needed)
> +		count = get_count();
> +
> +	tsc_delta = (unsigned long)watchdog_thresh * (unsigned long)tsc_khz
> +		    * 1000L;
> +	hdata->tsc_next = tsc_curr + tsc_delta;
> +	hdata->tsc_next_error = tsc_delta >> 6;

What do we need a per hld_data tsc_next_error for? It is basically a
global 'constant'.

>  	/*
>  	 * Update the comparator in increments of watch_thresh seconds relative
> @@ -74,8 +90,6 @@ static void kick_timer(struct hpet_hld_data *hdata, bool force)
>  	 */
>  
>  	if (kick_needed) {
> -		count = get_count();
> -
>  		new_compare = count + watchdog_thresh * hdata->ticks_per_second;
>  
>  		set_comparator(hdata, new_compare);
> @@ -147,6 +161,14 @@ static void set_periodic(struct hpet_hld_data *hdata)
>   */
>  static bool is_hpet_wdt_interrupt(struct hpet_hld_data *hdata)
>  {
> +	if (smp_processor_id() == hdata->handling_cpu) {
> +		unsigned long tsc_curr;

TSC is u64

> +
> +		tsc_curr = rdtsc();
> +		if (abs(tsc_curr - hdata->tsc_next) < hdata->tsc_next_error)
> +			return true;

You can write that as:

		(tsc_curr - hdata->tsc_next) + tsc_error < 2*tsc_error

which doesn't contain any branches what so ever.

> +	}
> +
>  	return false;
>  }
