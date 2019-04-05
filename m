Return-Path: <SRS0=EIds=SH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 83BB4C282CE
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Apr 2019 21:55:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5D1D921871
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Apr 2019 21:55:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726534AbfDEVz3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 5 Apr 2019 17:55:29 -0400
Received: from Galois.linutronix.de ([146.0.238.70]:49984 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726124AbfDEVz3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Apr 2019 17:55:29 -0400
Received: from p5492e2fc.dip0.t-ipconnect.de ([84.146.226.252] helo=nanos)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1hCWo3-0005bL-Ax; Fri, 05 Apr 2019 23:55:27 +0200
Date:   Fri, 5 Apr 2019 23:55:26 +0200 (CEST)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Borislav Petkov <bp@alien8.de>
cc:     LKML <linux-kernel@vger.kernel.org>, Jann Horn <jannh@google.com>,
        X86 ML <x86@kernel.org>
Subject: Re: [PATCH 2/3] x86/microcode: Fix the ancient deprecated microcode
 loading method
In-Reply-To: <20190405133010.24249-3-bp@alien8.de>
Message-ID: <alpine.DEB.2.21.1904052353470.1802@nanos.tec.linutronix.de>
References: <20190405133010.24249-1-bp@alien8.de> <20190405133010.24249-3-bp@alien8.de>
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

On Fri, 5 Apr 2019, Borislav Petkov wrote:

> From: Borislav Petkov <bp@suse.de>
> 
> The commit in Fixes: added the new define UCODE_NEW to denote that an

That reads odd. What's wrong with:

Commit 2613f36ed965 added ....

or

A recent commit added

mm?

> update should happen only when newer microcode (than installed on the
> system) has been found.
> 
> But it missed adjusting that for the old /dev/cpu/microcode loading
> interface. Fix it.
> 
> Fixes: 2613f36ed965 ("x86/microcode: Attempt late loading only when new microcode is present")
> Signed-off-by: Borislav Petkov <bp@suse.de>
> Cc: Jann Horn <jannh@google.com>

Other than that:

Reviewed-by: Thomas Gleixner <tglx@linutronix.de>

> ---
>  arch/x86/kernel/cpu/microcode/core.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/x86/kernel/cpu/microcode/core.c b/arch/x86/kernel/cpu/microcode/core.c
> index 5260185cbf7b..8a4a7823451a 100644
> --- a/arch/x86/kernel/cpu/microcode/core.c
> +++ b/arch/x86/kernel/cpu/microcode/core.c
> @@ -418,8 +418,9 @@ static int do_microcode_update(const void __user *buf, size_t size)
>  		if (ustate == UCODE_ERROR) {
>  			error = -1;
>  			break;
> -		} else if (ustate == UCODE_OK)
> +		} else if (ustate == UCODE_NEW) {
>  			apply_microcode_on_target(cpu);
> +		}
>  	}
>  
>  	return error;
> -- 
> 2.21.0
> 
> 
