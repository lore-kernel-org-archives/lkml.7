Return-Path: <SRS0=i7el=ZO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1BA9FC432C0
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Nov 2019 21:55:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DF1C820726
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Nov 2019 21:55:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alien8.de header.i=@alien8.de header.b="KFOzCgDu"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726976AbfKVVzP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Nov 2019 16:55:15 -0500
Received: from mail.skyhub.de ([5.9.137.197]:43388 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726546AbfKVVzP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Nov 2019 16:55:15 -0500
Received: from zn.tnic (p200300EC2F0E970088E58EB60414A2FA.dip0.t-ipconnect.de [IPv6:2003:ec:2f0e:9700:88e5:8eb6:414:a2fa])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 3DC1D1EC0D02;
        Fri, 22 Nov 2019 22:55:14 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1574459714;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=NJD7hK0V08Fiv81ewyxttDMTtuYk35R4KS06J38w9Fg=;
        b=KFOzCgDube0CAI4WGo9Bh9klX7+ly+K8y5OzDCb0jAqcpwR0kq5lhw+qf4QWcEdfZSizOa
        ElJJQAPFv+JjnFTsHAbAFCgbv7pVWM6yyONROSESsMzS1wNbkViBIhmUbwZu9ryX+VNTZc
        qZtWBNwyKGhisTTBZ2QoEzA2ZyQJyQ8=
Date:   Fri, 22 Nov 2019 22:54:59 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     Yu-cheng Yu <yu-cheng.yu@intel.com>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "x86@kernel.org" <x86@kernel.org>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "Luck, Tony" <tony.luck@intel.com>,
        Andy Lutomirski <luto@kernel.org>,
        Rik van Riel <riel@surriel.com>,
        "Shankar, Ravi V" <ravi.v.shankar@intel.com>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        "Yu, Fenghua" <fenghua.yu@intel.com>,
        Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH 1/6] x86/fpu/xstate: Fix small issues before adding
 supervisor xstates
Message-ID: <20191122215459.GM6289@zn.tnic>
References: <20190925151022.21688-1-yu-cheng.yu@intel.com>
 <20190925151022.21688-2-yu-cheng.yu@intel.com>
 <20191009155847.GE10395@zn.tnic>
 <b33151bdfb5611de7db8493cb8fcca4b8f372267.camel@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <b33151bdfb5611de7db8493cb8fcca4b8f372267.camel@intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 22, 2019 at 01:22:37PM -0800, Yu-cheng Yu wrote:
> This implicitly converts a u32 to a bool. By looking at it, I think it
> should be OK, but wonder if anything overlooked? I would be happy to
> make this a separate patch.

I don't understand your question: are you asking whether you should
convert the functions to "static bool" or what is your question?

If it is that, then yes pls. Also, change xfeature_is_user() to return
bool too, while at it.

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
