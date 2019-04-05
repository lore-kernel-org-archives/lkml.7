Return-Path: <SRS0=EIds=SH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 638DFC282CE
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Apr 2019 20:38:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 31EAA2146F
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Apr 2019 20:38:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726397AbfDEUiw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 5 Apr 2019 16:38:52 -0400
Received: from Galois.linutronix.de ([146.0.238.70]:49795 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725946AbfDEUiw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Apr 2019 16:38:52 -0400
Received: from p5492e2fc.dip0.t-ipconnect.de ([84.146.226.252] helo=nanos)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1hCVbs-0004Ju-N2; Fri, 05 Apr 2019 22:38:48 +0200
Date:   Fri, 5 Apr 2019 22:38:48 +0200 (CEST)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Baoquan He <bhe@redhat.com>
cc:     linux-kernel@vger.kernel.org, kirill.shutemov@linux.intel.com,
        mingo@kernel.org, bp@alien8.de, hpa@zytor.com, dyoung@redhat.com,
        x86@kernel.org
Subject: Re: [PATCH v3 2/3] x86/kexec/64: Error out if try to jump to old
 4-level kernel from 5-level kernel
In-Reply-To: <20190312103051.18086-3-bhe@redhat.com>
Message-ID: <alpine.DEB.2.21.1904052223120.1802@nanos.tec.linutronix.de>
References: <20190312103051.18086-1-bhe@redhat.com> <20190312103051.18086-3-bhe@redhat.com>
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

On Tue, 12 Mar 2019, Baoquan He wrote:

> In relocate_kernel() CR4.LA57 flag is set before kexec jumping if
> the kernel has 5-level paging enabled. Then in boot/compressed/head_64.S,
> it will check if the booting kernel is in 4-level or 5-level paging
> mode, and handle accordingly. However, the old kernel which doesn't
> contain the 5-level codes doesn't know how to cope with it, then #GP
> triggered.

The above is more than confusing. I assume you want to say:

  If the running kernel has 5-level paging activated, the 5-level paging
  mode is preserved across kexec. If the kexec'ed kernel does not contain
  support for handling active 5-level paging mode in the decompressor, the
  decompressor will crash with #GP.

> Instead of triggering #GP during kexec kernel boot, error out during
> kexec loading if find out we are trying to jump to old 4-level kernel
> from 5-level kernel.

Prevent this situation at load time. If 5-level paging is active, check the
xloadflags whether the kexec kernel can handle 5-level paging at least in
the decompressor. If not, reject the load attempt.
 
> Signed-off-by: Baoquan He <bhe@redhat.com>
> Acked-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
> ---
>  arch/x86/kernel/kexec-bzimage64.c | 5 +++++
>  1 file changed, 5 insertions(+)
> 
> diff --git a/arch/x86/kernel/kexec-bzimage64.c b/arch/x86/kernel/kexec-bzimage64.c
> index 1f3b77367948..4c9c079b5673 100644
> --- a/arch/x86/kernel/kexec-bzimage64.c
> +++ b/arch/x86/kernel/kexec-bzimage64.c
> @@ -321,6 +321,11 @@ static int bzImage64_probe(const char *buf, unsigned long len)
>  		return ret;
>  	}
>  
> +	if (!(header->xloadflags & XLF_5LEVEL) && pgtable_l5_enabled()) {
> +		pr_err("Can not jump to old 4-level kernel from 5-level kernel.\n");

This is confusing at best.

     	"bzImage cannot handle 5-level paging mode\n"

or something like this.

> +		return ret;

Thanks,

	tglx
