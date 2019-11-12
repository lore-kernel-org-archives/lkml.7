Return-Path: <SRS0=WT+Y=ZE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2D5F4C43331
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Nov 2019 09:23:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0688320818
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Nov 2019 09:23:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="0EN90sfG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727202AbfKLJXY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Nov 2019 04:23:24 -0500
Received: from merlin.infradead.org ([205.233.59.134]:50320 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725944AbfKLJXX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Nov 2019 04:23:23 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=uLDCiGjFhshkCUgBk2CbnkCh1QAYDS9WMt7qrIQMXl0=; b=0EN90sfGIR7vTqdZAgpFff+te
        8ObbiL0FcYUbXTNDN/Ix/xdCgrlcrGQ56GLLQC8In3M3iqaT/fFy83wyRssXcgt4T90RwAZoJaZfO
        ds6gCn/t6B8Nwc3C6/kXG/ywIENkbeupFRYK9TIj1cEmYK1bOlWlomGDMU1TZ99eyPENsd9zAhuVC
        lplIrYrTOCIKbmvDIXA0cKelksqlEqK/F2bTmZEsFGL87WC4E98uY2WXLM0pYF2M2Ry0NmjkPPY+7
        I/QZDttycwK/VioFBxD1XAobWgPY6PAo+ECAjsnpZXyfqUgnD2YUbonocofxmbVAndRQmZ5raXtba
        K4ajxbijw==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1iUSNt-0005WS-Vn; Tue, 12 Nov 2019 09:22:50 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 7D0E230018B;
        Tue, 12 Nov 2019 10:21:39 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 17BA229BC818E; Tue, 12 Nov 2019 10:22:46 +0100 (CET)
Date:   Tue, 12 Nov 2019 10:22:46 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     LKML <linux-kernel@vger.kernel.org>, x86@kernel.org,
        Linus Torvalds <torvalds@linuxfoundation.org>,
        Andy Lutomirski <luto@kernel.org>,
        Stephen Hemminger <stephen@networkplumber.org>,
        Willy Tarreau <w@1wt.eu>, Juergen Gross <jgross@suse.com>,
        Sean Christopherson <sean.j.christopherson@intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [patch V2 08/16] x86/ioperm: Add bitmap sequence number
Message-ID: <20191112092246.GY4131@hirez.programming.kicks-ass.net>
References: <20191111220314.519933535@linutronix.de>
 <20191111223052.292300453@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191111223052.292300453@linutronix.de>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 11, 2019 at 11:03:22PM +0100, Thomas Gleixner wrote:
> Add a globally unique sequence number which is incremented when ioperm() is
> changing the I/O bitmap of a task. Store the new sequence number in the
> io_bitmap structure and compare it along with the actual struct pointer
> with the one which was last loaded on a CPU. Only update the bitmap if
> either of the two changes. That should further reduce the overhead of I/O
> bitmap scheduling when there are only a few I/O bitmap users on the system.

> +	/* Update the sequence number to force an update in switch_to() */
> +	iobm->sequence = atomic64_add_return(1, &io_bitmap_sequence);

> +		if (tss->last_bitmap != iobm ||
> +		    tss->last_sequence != iobm->sequence)
> +			switch_to_update_io_bitmap(tss, iobm);

Initially I wondered why we need a globally unique sequence number if we
already check the struct iobitmap pointer. That ought to make the
sequence number per-object.

However, that breaks for memory re-use. So yes, we need that thing to be
global.
