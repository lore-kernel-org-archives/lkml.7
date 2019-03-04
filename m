Return-Path: <SRS0=91bA=RH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21541C43381
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Mar 2019 13:30:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E405020835
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Mar 2019 13:30:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="0JuiA1vV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726819AbfCDNa3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 Mar 2019 08:30:29 -0500
Received: from merlin.infradead.org ([205.233.59.134]:44370 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726186AbfCDNa3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Mar 2019 08:30:29 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=4Kexjl1k6PZPYNe5SHNgTgQ2hSlzXFF2EFdO4Ud1AhI=; b=0JuiA1vVot91FzsO+UtGPEDJw
        v6YDZa2pjESkgKpjp8RLxMFzBSdSm4j0AiLWNE3oXWfCikvUpL3evjQ3MREAL6o096IdHSQWyJn1s
        7+rXvDppD1xHX7H7Lt4+x5aZcEkZ9US06blut+Kth9pYyKESERL5lr/2tGLqgE1Q0Fufyd1WjJEw9
        y8If6CSdprZ2MXhpk35lmKqaRo/hcEc+ni/7TGdndVlqkONVCDJZjWosKz5L+vxqWQm92H2M7D1pA
        KHTk+aJgfo29/5oVAEUgmjbh4Hi7FeinrOmwS8gm7nMabkqwwHha2oK35BeVyvDy0ksVNrAhgapjy
        +TjVwR3AA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1h0nff-0004ip-45; Mon, 04 Mar 2019 13:30:19 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 5B8892029D8D6; Mon,  4 Mar 2019 14:30:17 +0100 (CET)
Date:   Mon, 4 Mar 2019 14:30:17 +0100
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
Subject: Re: [PATCH v4 03/17] wlcore: Align reg_ch_conf_pending and
 tmp_ch_bitmap to unsigned long for better performance
Message-ID: <20190304133017.GL32494@hirez.programming.kicks-ass.net>
References: <1551494711-213533-1-git-send-email-fenghua.yu@intel.com>
 <1551494711-213533-4-git-send-email-fenghua.yu@intel.com>
 <20190304101141.GB32477@hirez.programming.kicks-ass.net>
 <44bb6771-7aea-c44d-6605-45e7a1499d1b@redhat.com>
 <20190304124144.GD32477@hirez.programming.kicks-ass.net>
 <9f334d1e-491f-565e-02fc-1a769e4f1b79@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9f334d1e-491f-565e-02fc-1a769e4f1b79@redhat.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 04, 2019 at 02:09:30PM +0100, Paolo Bonzini wrote:
> >> @@ -1700,14 +1700,14 @@ void wlcore_set_pending_regdomain_ch(struct wl1271 *wl, u16 channel,
> >>  	ch_bit_idx = wlcore_get_reg_conf_ch_idx(band, channel);
> >>  
> >>  	if (ch_bit_idx >= 0 && ch_bit_idx <= WL1271_MAX_CHANNELS)
> >> -		set_bit(ch_bit_idx, (long *)wl->reg_ch_conf_pending);
> >> +		__set_bit_le(ch_bit_idx, (long *)wl->reg_ch_conf_pending);
> >>  }
> >>  

> I've used __set_bit_le when setting reg_ch_conf_pending so no need to
> swizzle here; 

Argh, reading hard. Yes, then it all works.
