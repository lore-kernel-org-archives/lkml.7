Return-Path: <SRS0=nnGO=2J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8EABC43603
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Dec 2019 17:16:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C0E862467E
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Dec 2019 17:16:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727322AbfLSRQm convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 19 Dec 2019 12:16:42 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:60394 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726801AbfLSRQm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Dec 2019 12:16:42 -0500
Received: from bigeasy by Galois.linutronix.de with local (Exim 4.80)
        (envelope-from <bigeasy@linutronix.de>)
        id 1ihzPf-0007dO-6H; Thu, 19 Dec 2019 18:16:35 +0100
Date:   Thu, 19 Dec 2019 18:16:35 +0100
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     Yu-cheng Yu <yu-cheng.yu@intel.com>
Cc:     linux-kernel@vger.kernel.org, x86@kernel.org,
        "H. Peter Anvin" <hpa@zytor.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Tony Luck <tony.luck@intel.com>,
        Andy Lutomirski <luto@kernel.org>,
        Borislav Petkov <bp@alien8.de>,
        Rik van Riel <riel@surriel.com>,
        "Ravi V. Shankar" <ravi.v.shankar@intel.com>,
        Fenghua Yu <fenghua.yu@intel.com>,
        Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH v2 3/3] x86/fpu/xstate: Invalidate fpregs when
 __fpu_restore_sig() fails
Message-ID: <20191219171635.phdsfkvsyazwaq7s@linutronix.de>
References: <20191212210855.19260-1-yu-cheng.yu@intel.com>
 <20191212210855.19260-4-yu-cheng.yu@intel.com>
 <20191218155449.sk4gjabtynh67jqb@linutronix.de>
 <587463c4e5fa82dff8748e5f753890ac390e993e.camel@intel.com>
 <20191219142217.axgpqlb7zzluoxnf@linutronix.de>
 <19a94f88f1bc66bb81dbf5dd72083d03ca5090e9.camel@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8BIT
In-Reply-To: <19a94f88f1bc66bb81dbf5dd72083d03ca5090e9.camel@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2019-12-19 08:44:08 [-0800], Yu-cheng Yu wrote:
> Yes, this works.  But then everywhere that calls copy_*_to_xregs_*() etc. needs to be checked.
> Are there other alternatives?

I don't like the big hammer approach of your very much. It might make
all it "correct" but then it might lead to more "invalids" then needed.
It also required to export the symbol which I would like to avoid.

So if this patch works for you and you don't find anything else where it
falls apart then I will audit tomorrow all callers which got the
"invalidator" added and check for that angle.

Unless someone here complains big tyme and wants this instead…

> Yu-cheng

Sebastian
