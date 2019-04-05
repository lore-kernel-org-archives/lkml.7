Return-Path: <SRS0=EIds=SH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86413C282DA
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Apr 2019 19:01:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 61D632171F
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Apr 2019 19:01:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731782AbfDETBI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 5 Apr 2019 15:01:08 -0400
Received: from Galois.linutronix.de ([146.0.238.70]:49498 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731696AbfDETBI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Apr 2019 15:01:08 -0400
Received: from p5492e2fc.dip0.t-ipconnect.de ([84.146.226.252] helo=nanos)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1hCU5K-0002fQ-Fx; Fri, 05 Apr 2019 21:01:06 +0200
Date:   Fri, 5 Apr 2019 21:01:06 +0200 (CEST)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Zhao Yakui <yakui.zhao@intel.com>
cc:     linux-kernel@vger.kernel.org, x86@kernel.org,
        Jason Chen CJ <jason.cj.chen@intel.com>
Subject: Re: [RFC PATCH v2 1/3] arch/x86: add the support of ACRN guest
In-Reply-To: <1553576023-6434-2-git-send-email-yakui.zhao@intel.com>
Message-ID: <alpine.DEB.2.21.1904052051330.1802@nanos.tec.linutronix.de>
References: <1553576023-6434-1-git-send-email-yakui.zhao@intel.com> <1553576023-6434-2-git-send-email-yakui.zhao@intel.com>
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

Zhao,

On Tue, 26 Mar 2019, Zhao Yakui wrote:

Vs. the Subject line: arch/x86: add the support of ACRN guest

The proper prefix for x86 is surprisingly 'x86:' not 'arch/x86:'. Also
please start the first word after the colon with an upper case letter.

> ACRN is one open-source hypervisour, which is maintained by Linux

s/one/an/

> foundation.

by the Linuxfoundation.

> This is to add the para-virtualization support so that
> it allows the Linux guest to run on acrn-hypervisor.
> 
> This adds x86_hyper_acrn into supported hypervisors array, which enables
> Linux ACRN guest running on ACRN hypervisor. It is restricted to X86_64.

Please do not use 'This is to add' or 'This adds'. Just say:

Add ....
 
> v1->v2: Change the CONFIG_ACRN to CONFIG_ACRN_GUEST, which makes it easy to
> understand.
>         Remove the export of x86_hyper_acrn.

Thanks for having the version changes documented, but please put them after
the '---' line below and add another '---' before the diffstat. These
changes are not part of the final change log and if they are below then I
don't have to strip them manually.

> Co-developed-by: Jason Chen CJ <jason.cj.chen@intel.com>
> Signed-off-by: Jason Chen CJ <jason.cj.chen@intel.com>
> Signed-off-by: Zhao Yakui <yakui.zhao@intel.com>
> ---
>  arch/x86/Kconfig                  |  8 ++++++++
>  arch/x86/include/asm/hypervisor.h |  1 +
>  arch/x86/kernel/cpu/Makefile      |  1 +
>  arch/x86/kernel/cpu/acrn.c        | 35 +++++++++++++++++++++++++++++++++++
>  arch/x86/kernel/cpu/hypervisor.c  |  4 ++++
>  5 files changed, 49 insertions(+)
>  create mode 100644 arch/x86/kernel/cpu/acrn.c
> 
> diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
> index c1f9b3c..d73225e 100644
> --- a/arch/x86/Kconfig
> +++ b/arch/x86/Kconfig
> @@ -842,6 +842,14 @@ config JAILHOUSE_GUEST
>  	  cell. You can leave this option disabled if you only want to start
>  	  Jailhouse and run Linux afterwards in the root cell.
>  
> +config ACRN_GUEST
> +	bool "ACRN Guest support"
> +	depends on X86_64 && PARAVIRT

Why does this select PARAVIRT? The current patches are not implementing
anything of the paravirt functionality. Which part of paravirtualization
are you going to provide?

Thanks,

	tglx
