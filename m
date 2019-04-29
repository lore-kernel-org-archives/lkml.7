Return-Path: <SRS0=c0gK=S7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D3C9C43219
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Apr 2019 14:14:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6ABFF20652
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Apr 2019 14:14:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alien8.de header.i=@alien8.de header.b="cr0oJ2wE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728332AbfD2OO5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Apr 2019 10:14:57 -0400
Received: from mail.skyhub.de ([5.9.137.197]:44036 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725838AbfD2OO5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Apr 2019 10:14:57 -0400
Received: from zn.tnic (p200300EC2F073600329C23FFFEA6A903.dip0.t-ipconnect.de [IPv6:2003:ec:2f07:3600:329c:23ff:fea6:a903])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 9B55C1EC014A;
        Mon, 29 Apr 2019 16:14:55 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1556547295;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=Ux3dNjcP4oIYXywKrNpKFEkeqZLwEjS3goh7xxBcUmw=;
        b=cr0oJ2wEMeuLGB4SpNVM+Chr5qUDoCb4DT4Sl0H/qmj3C4eVe5DI3cXR0WrsmXwbruEK7Q
        6IHvlkiZdoeeqb2SGwoV4nA2YwFXDVxNfJkSun9CRFnPQy37cJkI3Af1iMNq7figxKYMxI
        nkpO1iTAiv1z3T8qTgjrxUDREJK9Oh0=
Date:   Mon, 29 Apr 2019 16:14:50 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Dmitry Vyukov <dvyukov@google.com>
Cc:     Sean Christopherson <sean.j.christopherson@intel.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Andy Lutomirski <luto@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        the arch/x86 maintainers <x86@kernel.org>,
        "H. Peter Anvin" <hpa@zytor.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Rik van Riel <riel@surriel.com>,
        Yu-cheng Yu <yu-cheng.yu@intel.com>,
        Ingo Molnar <mingo@kernel.org>,
        syzkaller <syzkaller@googlegroups.com>
Subject: Re: [PATCH v3 2/2] x86/fault: Decode and print #PF oops in human
 readable form
Message-ID: <20190429141450.GD2324@zn.tnic>
References: <20181221213657.27628-1-sean.j.christopherson@intel.com>
 <20181221213657.27628-3-sean.j.christopherson@intel.com>
 <CACT4Y+Z96anrG1da1-8VXA8BLMd-RA16ysicA=X-CUoSuGAw0Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CACT4Y+Z96anrG1da1-8VXA8BLMd-RA16ysicA=X-CUoSuGAw0Q@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 29, 2019 at 03:58:20PM +0200, Dmitry Vyukov wrote:
> Ideally, such changes are coordinated with kernel testing for gradual
> rollout. Since kernel does not provide an official facility for crash
> parsing, the actual output effectively becomes part of public API.

Well, printk message formats are not an API. I agree, though, that if
this is how kernel testing is going to get told about crashes, then we'd
need some sort of parsing specification which gets changed together with
when the actual messages are changed, so that tools don't break.

Or something slicker and more robust than tools parsing dmesg output...

-- 
Regards/Gruss,
    Boris.

Good mailing practices for 400: avoid top-posting and trim the reply.
