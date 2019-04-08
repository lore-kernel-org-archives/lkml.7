Return-Path: <SRS0=N68d=SK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F711C10F13
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Apr 2019 17:08:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DC2F220880
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Apr 2019 17:08:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729158AbfDHRIz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Apr 2019 13:08:55 -0400
Received: from Galois.linutronix.de ([146.0.238.70]:53483 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728654AbfDHRIz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Apr 2019 13:08:55 -0400
Received: from p5492ee6e.dip0.t-ipconnect.de ([84.146.238.110] helo=nanos)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1hDXlK-0003hs-S6; Mon, 08 Apr 2019 19:08:51 +0200
Date:   Mon, 8 Apr 2019 19:08:49 +0200 (CEST)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>
cc:     linux-kernel@vger.kernel.org, x86@kernel.org,
        Andy Lutomirski <luto@kernel.org>,
        Paolo Bonzini <pbonzini@redhat.com>,
        =?ISO-8859-2?Q?Radim_Kr=E8m=E1=F8?= <rkrcmar@redhat.com>,
        kvm@vger.kernel.org, "Jason A. Donenfeld" <Jason@zx2c4.com>,
        Rik van Riel <riel@surriel.com>,
        Dave Hansen <dave.hansen@linux.intel.com>
Subject: Re: [PATCH v9 00/27] x86: load FPU registers on return to userland
In-Reply-To: <20190403164156.19645-1-bigeasy@linutronix.de>
Message-ID: <alpine.DEB.2.21.1904081907280.2352@nanos.tec.linutronix.de>
References: <20190403164156.19645-1-bigeasy@linutronix.de>
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

On Wed, 3 Apr 2019, Sebastian Andrzej Siewior wrote:

> This is a refurbished series originally started by by Rik van Riel. The
> goal is load the FPU registers on return to userland and not on every
> context switch. By this optimisation we can:
> - avoid loading the registers if the task stays in kernel and does
>   not return to userland
> - make kernel_fpu_begin() cheaper: it only saves the registers on the
>   first invocation. The second invocation does not need save them again.
> 
> To access the FPU registers in kernel we need:
> - disable preemption to avoid that the scheduler switches tasks. By
>   doing so it would set TIF_NEED_FPU_LOAD and the FPU registers would be
>   not valid.
> - disable BH because the softirq might use kernel_fpu_begin() and then
>   set TIF_NEED_FPU_LOAD instead loading the FPU registers on completion.

So aside of that one hunk in 24/27 which is either wrong or needs some
information in the changelog I couldn't find anything disturbing.

With that addressed:

     Reviewed-by: Thomas Gleixner <tglx@linutronix.de>

