Return-Path: <SRS0=kpxk=YC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5D991ECE58C
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Oct 2019 17:28:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2B2A520B7C
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Oct 2019 17:28:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alien8.de header.i=@alien8.de header.b="E6QYgTGF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732597AbfJIR2P (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 9 Oct 2019 13:28:15 -0400
Received: from mail.skyhub.de ([5.9.137.197]:39824 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732299AbfJIR2M (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Oct 2019 13:28:12 -0400
Received: from zn.tnic (p200300EC2F0C2000CC8F9AE7D5DA1569.dip0.t-ipconnect.de [IPv6:2003:ec:2f0c:2000:cc8f:9ae7:d5da:1569])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 3BD051EC0B4D;
        Wed,  9 Oct 2019 19:28:11 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1570642091;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=3GMrZwDHEYtej/9FUdzLWkbxFhzs+cosdr5wtkTK2+E=;
        b=E6QYgTGFTDef3U6aXpA9fmkmQmyM9lG7Roj8wXN2jUhffjMajRfOq6FHdeBrbhz2t5rvGb
        6g6ah5RTLcdhsEZwezYgWCsv3h1sVTCzOTc/jO3jLEBTEgj/pySij7yoWDoQvMipNTYeQ3
        B5pR1Dpl+HhagD3b50BEDhr6BV9lc+E=
Date:   Wed, 9 Oct 2019 19:28:04 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Yu-cheng Yu <yu-cheng.yu@intel.com>
Cc:     linux-kernel@vger.kernel.org, x86@kernel.org,
        "H. Peter Anvin" <hpa@zytor.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Tony Luck <tony.luck@intel.com>,
        Andy Lutomirski <luto@kernel.org>,
        Rik van Riel <riel@surriel.com>,
        "Ravi V. Shankar" <ravi.v.shankar@intel.com>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Fenghua Yu <fenghua.yu@intel.com>,
        Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH 5/6] x86/fpu/xstate: Define new functions for clearing
 fpregs and xstates
Message-ID: <20191009172804.GI10395@zn.tnic>
References: <20190925151022.21688-1-yu-cheng.yu@intel.com>
 <20190925151022.21688-6-yu-cheng.yu@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190925151022.21688-6-yu-cheng.yu@intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 25, 2019 at 08:10:21AM -0700, Yu-cheng Yu wrote:
> From: Fenghua Yu <fenghua.yu@intel.com>
> 
> Currently, fpu__clear() clears all fpregs and xstates.  Once XSAVES
> supervisor states are introduced, supervisor settings must remain active
> for signals;

I could very well use an example here: for signal handling supervisor
states, I'm guessing this would be something CET-related so some text
about a usage scenario would be very helpful here.

> it is necessary to have separate functions:
> 
>  - Create fpu__clear_user_states(): clear only user settings for signals;
>  - Create fpu__clear_all(): clear both user and supervisor settings in
>    flush_thread().
> 
> Also modify copy_init_fpstate_to_fpregs() to take a mask from above two
> functions.
> 
> Co-developed-by: Yu-cheng Yu <yu-cheng.yu@intel.com>
> Signed-off-by: Yu-cheng Yu <yu-cheng.yu@intel.com>
> Signed-off-by: Fenghua Yu <fenghua.yu@intel.com>

As before...

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
