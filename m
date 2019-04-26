Return-Path: <SRS0=fl2C=S4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 572D5C43219
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Apr 2019 07:27:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2F35A206E0
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Apr 2019 07:27:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726069AbfDZH1P (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Apr 2019 03:27:15 -0400
Received: from Galois.linutronix.de ([146.0.238.70]:33501 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725854AbfDZH1O (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Apr 2019 03:27:14 -0400
Received: from bigeasy by Galois.linutronix.de with local (Exim 4.80)
        (envelope-from <bigeasy@linutronix.de>)
        id 1hJvG8-0003l0-3a; Fri, 26 Apr 2019 09:27:00 +0200
Date:   Fri, 26 Apr 2019 09:26:59 +0200
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     Dave Hansen <dave.hansen@intel.com>
Cc:     linux-kernel@vger.kernel.org, x86@kernel.org, jannh@google.com,
        riel@surriel.com, mingo@redhat.com, bp@suse.de, Jason@zx2c4.com,
        luto@kernel.org, tglx@linutronix.de, rkrcmar@redhat.com,
        mingo@kernel.org, hpa@zytor.com, kvm@vger.kernel.org,
        pbonzini@redhat.com, kurt.kanzenbach@linutronix.de
Subject: Re: [RFC PATCH] x86/fpu: Don't unconditionally add
 XFEATURE_MASK_FPSSE on sigentry
Message-ID: <20190426072659.swew4mvfz7dfjyqq@linutronix.de>
References: <20190425173545.sogxyptbaqvoofm6@linutronix.de>
 <cbb4c3de-1e12-c325-fa7f-40bc63c495e7@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cbb4c3de-1e12-c325-fa7f-40bc63c495e7@intel.com>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2019-04-25 14:13:05 [-0700], Dave Hansen wrote:
> On 4/25/19 10:35 AM, Sebastian Andrzej Siewior wrote:
> > This commit reverts commit 04944b793e18e ("x86: xsave: set FP, SSE bits
> > in the xsave header in the user sigcontext"). The commit claims that it
> > is required for legacy applications but fails to explain why this is
> > needed and it is not obvious to me why the application would require the
> > FP/SSE state in the signal handler.
> 
> Any software that understands XSAVE is OK.  I think the legacy software
> would be that which groks 'fxregs_state, and FXSAVE/FXRSTOR but does not
> comprehend XSAVE/XRSTOR.  *That* software might change fxregs_state in
> the signal frame, but the lack of XFEATURE_MASK_FPSSE in xfeatures would
> prevent XRSTOR from restoring it.

but it would edit its FP state before it has been used.

> That's just a guess, though.
> 
> If we care, I think we should just use XSAVE instead of XSAVEOPT and
> trying to reconstruct the init state in software.

We can't use XSAVE directly in the slowpath. We need to reconstruct the
init state. We have the mxcsr quirk. We would need just to extend it and
set the FP area to init state if the FP state is missing like we do in
fpstate_sanitize_xstate().

Sebastian
