Return-Path: <SRS0=91bA=RH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 973EEC43381
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Mar 2019 10:17:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 66E5A208E4
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Mar 2019 10:17:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="JT+E3cfp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726472AbfCDKRs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 Mar 2019 05:17:48 -0500
Received: from merlin.infradead.org ([205.233.59.134]:42526 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726170AbfCDKRp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Mar 2019 05:17:45 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=C8+VILLWBTE+6LAkFGKf2oOrqII6N5gAPK1khW9Eh5g=; b=JT+E3cfpo/1ZS79RB2d/ur+em
        kozZsSicUrusNy3pAyhpsvbUwFEzZUVb1dK2/uDwBrrvTeJxBx0OeQ7wsSbtFyV4pR2nEsFAfJtPR
        +k9ls9PEpgavbvRAcPnOXZLaV/IodEdDpddWi6Tx5QfRxvFNILjtosNsNhSkVu2yM7QWrhgE09sqL
        r+By0P9HuC8WHE3ck8qaVmqA6vawS+MQedhxQTgnJy4upu86du10yfDu8w5DdN4nNRaMx7w8DBK/i
        VqdLdHoQ7dqeom+64toWjDTA6pbpTy4dvOZlLY4Pwaq61wTWKjHHfLGTIIXuEAmGGNKlONjFm6srl
        WycbOpCpQ==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1h0kfB-0003e8-Sl; Mon, 04 Mar 2019 10:17:38 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id A509620295AAE; Mon,  4 Mar 2019 11:17:36 +0100 (CET)
Date:   Mon, 4 Mar 2019 11:17:36 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Paolo Bonzini <pbonzini@redhat.com>
Cc:     Fenghua Yu <fenghua.yu@intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        H Peter Anvin <hpa@zytor.com>,
        Dave Hansen <dave.hansen@intel.com>,
        Ashok Raj <ashok.raj@intel.com>,
        Ravi V Shankar <ravi.v.shankar@intel.com>,
        Xiaoyao Li <xiaoyao.li@intel.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        x86 <x86@kernel.org>, kvm@vger.kernel.org
Subject: Re: [PATCH v4 01/17] x86/common: Align cpu_caps_cleared and
 cpu_caps_set to unsigned long
Message-ID: <20190304101736.GC32477@hirez.programming.kicks-ass.net>
References: <1551494711-213533-1-git-send-email-fenghua.yu@intel.com>
 <1551494711-213533-2-git-send-email-fenghua.yu@intel.com>
 <461f162c-694f-2bb7-f9cb-55fa915434bc@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <461f162c-694f-2bb7-f9cb-55fa915434bc@redhat.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 04, 2019 at 09:33:16AM +0100, Paolo Bonzini wrote:
> Why not instead change set_bit/clear_bit to use btsl/btrl instead of
> btsq/btrq?

At least one of the faulty users (wireless) is in generic code and needs
fixing regardless.

For better or worse; the bitmap stuff is defined to work on unsigned
long. Using it on smaller types already relies on small endian; but
further enabling just makes it worse I feel. Better have the rules be
uniform.
