Return-Path: <SRS0=5O2B=VH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 64B7BC73C7C
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Jul 2019 11:33:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 38C1D2064A
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Jul 2019 11:33:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727296AbfGJLd4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Jul 2019 07:33:56 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:47452 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725956AbfGJLd4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Jul 2019 07:33:56 -0400
Received: from pd9ef1cb8.dip0.t-ipconnect.de ([217.239.28.184] helo=nanos)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1hlAr8-0001Cm-7T; Wed, 10 Jul 2019 13:33:50 +0200
Date:   Wed, 10 Jul 2019 13:33:48 +0200 (CEST)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Paolo Bonzini <pbonzini@redhat.com>
cc:     "Lendacky, Thomas" <Thomas.Lendacky@amd.com>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        "x86@kernel.org" <x86@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Andrew Cooper <andrew.cooper3@citrix.com>,
        Pu Wen <puwen@hygon.cn>, Borislav Petkov <bp@alien8.de>
Subject: Re: [RFC PATCH] x86: Remove X86_FEATURE_MFENCE_RDTSC
In-Reply-To: <4a13c6a3-a13e-d3e5-0008-41a6d47a6eff@redhat.com>
Message-ID: <alpine.DEB.2.21.1907101333250.1758@nanos.tec.linutronix.de>
References: <d990aa51e40063acb9888e8c1b688e41355a9588.1562255067.git.jpoimboe@redhat.com> <45f247d2-80f5-6c8c-d11e-965a3da8a88f@amd.com> <4a13c6a3-a13e-d3e5-0008-41a6d47a6eff@redhat.com>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 10 Jul 2019, Paolo Bonzini wrote:
> On 08/07/19 21:32, Lendacky, Thomas wrote:
> >> AMD and Intel both have serializing lfence (X86_FEATURE_LFENCE_RDTSC).
> >> They've both had it for a long time, and AMD has had it enabled in Linux
> >> since Spectre v1 was announced.
> >>
> >> Back then, there was a proposal to remove the serializing mfence feature
> >> bit (X86_FEATURE_MFENCE_RDTSC), since both AMD and Intel have
> >> serializing lfence.  At the time, it was (ahem) speculated that some
> >> hypervisors might not yet support its removal, so it remained for the
> >> time being.
> >>
> >> Now a year-and-a-half later, it should be safe to remove.
> >
> > I vaguely remember a concern from a migration point of view, maybe? Adding
> > Paolo to see if he has any concerns.
> 
> It would be a problem to remove the conditional "if
> (boot_cpu_has(X86_FEATURE_LFENCE_RDTSC))" from svm_get_msr_feature.  But
> removing support for X86_FEATURE_MFENCE_RDTSC essentially amounts to
> removing support for hypervisors that haven't been updated pre-Spectre.
>  That's fair enough, I think.

Yes, they have other more interesting problems :)
