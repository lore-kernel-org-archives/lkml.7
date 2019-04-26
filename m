Return-Path: <SRS0=fl2C=S4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5B3FCC43218
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Apr 2019 16:50:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2BAA520679
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Apr 2019 16:50:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726473AbfDZQub (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Apr 2019 12:50:31 -0400
Received: from Galois.linutronix.de ([146.0.238.70]:35224 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726218AbfDZQua (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Apr 2019 12:50:30 -0400
Received: from bigeasy by Galois.linutronix.de with local (Exim 4.80)
        (envelope-from <bigeasy@linutronix.de>)
        id 1hK43C-0006gq-IW; Fri, 26 Apr 2019 18:50:14 +0200
Date:   Fri, 26 Apr 2019 18:50:14 +0200
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     Dave Hansen <dave.hansen@intel.com>
Cc:     linux-kernel@vger.kernel.org, x86@kernel.org, jannh@google.com,
        riel@surriel.com, mingo@redhat.com, bp@suse.de, Jason@zx2c4.com,
        luto@kernel.org, tglx@linutronix.de, rkrcmar@redhat.com,
        mingo@kernel.org, hpa@zytor.com, kvm@vger.kernel.org,
        pbonzini@redhat.com, kurt.kanzenbach@linutronix.de
Subject: Re: [RFC PATCH] x86/fpu: Don't unconditionally add
 XFEATURE_MASK_FPSSE on sigentry
Message-ID: <20190426165013.mdgd2ocmdgkhja7n@linutronix.de>
References: <20190425173545.sogxyptbaqvoofm6@linutronix.de>
 <cbb4c3de-1e12-c325-fa7f-40bc63c495e7@intel.com>
 <20190426072659.swew4mvfz7dfjyqq@linutronix.de>
 <89ed2d26-a73c-99ad-76d8-e4b46755c783@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <89ed2d26-a73c-99ad-76d8-e4b46755c783@intel.com>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2019-04-26 09:33:28 [-0700], Dave Hansen wrote:
> On 4/26/19 12:26 AM, Sebastian Andrzej Siewior wrote:
> >> That's just a guess, though.
> >>
> >> If we care, I think we should just use XSAVE instead of XSAVEOPT and
> >> trying to reconstruct the init state in software.
> > We can't use XSAVE directly in the slowpath. We need to reconstruct the
> > init state. We have the mxcsr quirk. We would need just to extend it and
> > set the FP area to init state if the FP state is missing like we do in
> > fpstate_sanitize_xstate().
> 
> Can you remind me why we can't use XSAVE directly in the slow path?

Where to?
In the fastpath we XSAVE directly to task's stack. We are in the
slowpath because this failed. Task's FPU-state is using compacted form.
So we use this as source and copy_to_user() to task's stack.
I don't think we can XSAVE to task's FPU-state because the compacted
form may need less memory than the non-compacted form.

Currently I'm leaning towards cleaning the FP area so we behave like
XSAVE does. Independently of that, I would like to revert that commit.
Based on the comment and patch description it does not say that it fixes
a real problem. It *may* fix something.

Sebastian
