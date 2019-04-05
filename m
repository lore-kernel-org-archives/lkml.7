Return-Path: <SRS0=EIds=SH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 78868C4360F
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Apr 2019 14:44:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 415AB21726
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Apr 2019 14:44:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731354AbfDEOoW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 5 Apr 2019 10:44:22 -0400
Received: from foss.arm.com ([217.140.101.70]:50792 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726291AbfDEOoV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Apr 2019 10:44:21 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 544B816A3;
        Fri,  5 Apr 2019 07:44:21 -0700 (PDT)
Received: from fuggles.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.72.51.249])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 363853F68F;
        Fri,  5 Apr 2019 07:44:17 -0700 (PDT)
Date:   Fri, 5 Apr 2019 15:44:14 +0100
From:   Will Deacon <will.deacon@arm.com>
To:     Josh Poimboeuf <jpoimboe@redhat.com>
Cc:     linux-kernel@vger.kernel.org, x86@kernel.org,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@kernel.org>, Borislav Petkov <bp@alien8.de>,
        "H . Peter Anvin" <hpa@zytor.com>,
        Andy Lutomirski <luto@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Jiri Kosina <jikos@kernel.org>,
        Waiman Long <longman@redhat.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Jon Masters <jcm@redhat.com>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        linuxppc-dev@lists.ozlabs.org,
        Martin Schwidefsky <schwidefsky@de.ibm.com>,
        Heiko Carstens <heiko.carstens@de.ibm.com>,
        linux-s390@vger.kernel.org,
        Catalin Marinas <catalin.marinas@arm.com>,
        linux-arm-kernel@lists.infradead.org, linux-arch@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Tyler Hicks <tyhicks@canonical.com>,
        Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [PATCH RFC 5/5] arm64/speculation: Add support for
 'cpu_spec_mitigations=' cmdline options
Message-ID: <20190405144414.GB7662@fuggles.cambridge.arm.com>
References: <cover.1554396090.git.jpoimboe@redhat.com>
 <5f70df57b19bbccc4a0d5d76134b4681c9a50b0b.1554396090.git.jpoimboe@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5f70df57b19bbccc4a0d5d76134b4681c9a50b0b.1554396090.git.jpoimboe@redhat.com>
User-Agent: Mutt/1.11.1+86 (6f28e57d73f2) ()
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Josh,

On Thu, Apr 04, 2019 at 11:44:15AM -0500, Josh Poimboeuf wrote:
> Configure arm64 runtime CPU speculation bug mitigations in accordance
> with the 'cpu_spec_mitigations=' cmdline options.  This affects
> Meltdown and Speculative Store Bypass.
> 
> The default behavior is unchanged.
> 
> Signed-off-by: Josh Poimboeuf <jpoimboe@redhat.com>
> ---
>  Documentation/admin-guide/kernel-parameters.txt | 2 ++
>  arch/arm64/kernel/cpu_errata.c                  | 4 ++++
>  arch/arm64/kernel/cpufeature.c                  | 6 ++++++
>  3 files changed, 12 insertions(+)

Just wanted to make you aware that this is probably going to conflict badly
with some patches we have pending to hook up the sysfs entries:

http://lists.infradead.org/pipermail/linux-arm-kernel/2019-March/640326.html

That patch series isn't quite there yet, so I'm expecting a v7, but I think
it will change the shape of this patch quite a lot.

Will
