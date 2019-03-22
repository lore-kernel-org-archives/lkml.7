Return-Path: <SRS0=oArh=RZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DF67AC43381
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 14:55:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B7CD6218FE
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 14:55:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729356AbfCVOzI convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Mar 2019 10:55:08 -0400
Received: from Galois.linutronix.de ([146.0.238.70]:41214 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727719AbfCVOzI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Mar 2019 10:55:08 -0400
Received: from bigeasy by Galois.linutronix.de with local (Exim 4.80)
        (envelope-from <bigeasy@linutronix.de>)
        id 1h7LZW-0003TG-04; Fri, 22 Mar 2019 15:55:02 +0100
Date:   Fri, 22 Mar 2019 15:55:01 +0100
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     linux-kernel@vger.kernel.org
Cc:     x86@kernel.org, Andy Lutomirski <luto@kernel.org>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Radim =?utf-8?B?S3LEjW3DocWZ?= <rkrcmar@redhat.com>,
        kvm@vger.kernel.org, "Jason A. Donenfeld" <Jason@zx2c4.com>,
        Rik van Riel <riel@surriel.com>,
        Dave Hansen <dave.hansen@linux.intel.com>
Subject: Re: [PATCH 21/24] x86/fpu: Let __fpu__restore_sig() restore the
 !32bit+fxsr frame from kernel memory
Message-ID: <20190322145501.ldiaqlemmygnr27x@linutronix.de>
References: <20190321202632.16810-1-bigeasy@linutronix.de>
 <20190321202632.16810-22-bigeasy@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8BIT
In-Reply-To: <20190321202632.16810-22-bigeasy@linutronix.de>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2019-03-21 21:26:29 [+0100], To linux-kernel@vger.kernel.org wrote:
> diff --git a/arch/x86/kernel/fpu/signal.c b/arch/x86/kernel/fpu/signal.c
> index 5a467a381245c..052a16c96218f 100644
> --- a/arch/x86/kernel/fpu/signal.c
> +++ b/arch/x86/kernel/fpu/signal.c
> @@ -297,28 +298,63 @@ static int __fpu__restore_sig(void __user *buf, void __user *buf_fx, int size)
…
> +		} else {
> +			ret = __copy_from_user(&state->fsave, buf_fx, state_size);
> +			if (ret)
> +				goto err_out;
> +			ret = copy_users_to_fregs(buf_fx);

This needs to become 
	ret = copy_users_to_fregs(&fpu->state.fsave);

here and in the follow up patch (fixing locally)

> +		}

Sebastian
