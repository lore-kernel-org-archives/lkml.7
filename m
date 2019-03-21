Return-Path: <SRS0=/BZh=RY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BF8AAC43381
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Mar 2019 17:10:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9837621902
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Mar 2019 17:10:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728566AbfCURKP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Mar 2019 13:10:15 -0400
Received: from Galois.linutronix.de ([146.0.238.70]:38858 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727829AbfCURKP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Mar 2019 13:10:15 -0400
Received: from bigeasy by Galois.linutronix.de with local (Exim 4.80)
        (envelope-from <bigeasy@linutronix.de>)
        id 1h71Cf-0001xD-Lc; Thu, 21 Mar 2019 18:10:05 +0100
Date:   Thu, 21 Mar 2019 18:10:05 +0100
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     Dave Hansen <dave.hansen@intel.com>
Cc:     linux-kernel@vger.kernel.org, x86@kernel.org,
        Andy Lutomirski <luto@kernel.org>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Radim =?utf-8?B?S3LEjW3DocWZ?= <rkrcmar@redhat.com>,
        kvm@vger.kernel.org, "Jason A. Donenfeld" <Jason@zx2c4.com>,
        Rik van Riel <riel@surriel.com>,
        Dave Hansen <dave.hansen@linux.intel.com>
Subject: Re: [PATCH 14/22] x86/fpu: Eager switch PKRU state
Message-ID: <20190321171005.l3sywcudjvxmi27n@linutronix.de>
References: <20190221115020.12385-1-bigeasy@linutronix.de>
 <20190221115020.12385-15-bigeasy@linutronix.de>
 <eedfbbbe-02d0-f977-2a64-e683b98d3904@intel.com>
 <20190308180849.hy22jejhffp4n6uh@linutronix.de>
 <b0f3ffa8-faec-73b2-f6f2-ea37ece3a3b1@intel.com>
 <20190311110605.2xxjx2ym3n63lpr2@linutronix.de>
 <20190311143049.hclnlciq4rzqrtp6@linutronix.de>
 <cd1a34e6-f122-33e3-864f-e23c1833a6c0@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cd1a34e6-f122-33e3-864f-e23c1833a6c0@intel.com>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2019-03-12 17:06:18 [-0700], Dave Hansen wrote:
> Thanks for doing this.  I'll see if I can dig into the test case and
> figure out why it's not doing what I expected.  It might be that the CPU
> _could_ go back to the init state but chooses not to, or that something
> else is taking us out of the init state before we reach the kernel code
> in question.

I'm going to drop that WARN_ON() check. The reason is that we are fully
preemptible during fpstate_init() and a context switch during memset()
and fpstate_init_xstate() triggers this warning.

Sebastian
