Return-Path: <SRS0=XcGb=25=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9663C33C9E
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Jan 2020 11:46:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6C75F2077B
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Jan 2020 11:46:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alien8.de header.i=@alien8.de header.b="j2E/j3/e"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727337AbgAHLq5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 Jan 2020 06:46:57 -0500
Received: from mail.skyhub.de ([5.9.137.197]:57594 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726290AbgAHLq5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Jan 2020 06:46:57 -0500
Received: from zn.tnic (p200300EC2F0BD40029EAD32D10B1B629.dip0.t-ipconnect.de [IPv6:2003:ec:2f0b:d400:29ea:d32d:10b1:b629])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id F0C1E1EC0CC9;
        Wed,  8 Jan 2020 12:46:55 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1578484016;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=2K49B1IvTuR8ugKnVnlZ1/Wn6pxxM4e0MAEkpZoeWEI=;
        b=j2E/j3/etEDUZgeHXudiatxCesvrsc9YPfXpU/we3L4Pylef+UCj+BtIu0utmVmHja5UNJ
        EhkZPMoRj4/nPvWZsbdTdlpme5xaKLDpcZI7J1TRhK3omBY29RApTpxO2cdD0ArAJI/Y7m
        4h1ZUakhzJ49IWemkuSjGzV+Amf2Jpo=
Date:   Wed, 8 Jan 2020 12:46:51 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     Andy Lutomirski <luto@amacapital.net>
Cc:     linux-kernel@vger.kernel.org, linux-tip-commits@vger.kernel.org,
        Yu-cheng Yu <yu-cheng.yu@intel.com>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Borislav Petkov <bp@suse.de>,
        Andy Lutomirski <luto@kernel.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Fenghua Yu <fenghua.yu@intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>, Ingo Molnar <mingo@redhat.com>,
        Jann Horn <jannh@google.com>,
        Peter Zijlstra <peterz@infradead.org>,
        "Ravi V. Shankar" <ravi.v.shankar@intel.com>,
        Rik van Riel <riel@surriel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Tony Luck <tony.luck@intel.com>, x86-ml <x86@kernel.org>
Subject: Re: [tip: x86/fpu] x86/fpu: Deactivate FPU state after failure
 during state load
Message-ID: <20200108114651.GF27363@zn.tnic>
References: <157840155965.30329.313988118654552721.tip-bot2@tip-bot2>
 <FA0D2929-63D0-4473-A492-42227D7A5D98@amacapital.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <FA0D2929-63D0-4473-A492-42227D7A5D98@amacapital.net>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 07, 2020 at 10:41:52AM -1000, Andy Lutomirski wrote:
> Wow, __fpu__restore_sig is a mess.

FWIW, I share your sentiment and I'd very much take patches which
simplify that flow. It is causing me headaches each time I have to look
at it.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
