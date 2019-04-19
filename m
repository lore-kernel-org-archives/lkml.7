Return-Path: <SRS0=WRlz=SV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4C646C282DF
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Apr 2019 19:03:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1C07F20643
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Apr 2019 19:03:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729067AbfDSTDf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 19 Apr 2019 15:03:35 -0400
Received: from Galois.linutronix.de ([146.0.238.70]:42077 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728638AbfDSTDb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Apr 2019 15:03:31 -0400
Received: from pd9ef12d2.dip0.t-ipconnect.de ([217.239.18.210] helo=nanos)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1hHOjN-0001Kd-Qc; Fri, 19 Apr 2019 10:18:46 +0200
Date:   Fri, 19 Apr 2019 10:18:43 +0200 (CEST)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Pingfan Liu <kernelfans@gmail.com>
cc:     linux-kernel@vger.kernel.org, Russell King <linux@armlinux.org.uk>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Tony Luck <tony.luck@intel.com>,
        Fenghua Yu <fenghua.yu@intel.com>,
        Ralf Baechle <ralf@linux-mips.org>,
        Paul Burton <paul.burton@mips.com>,
        James Hogan <jhogan@kernel.org>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Martin Schwidefsky <schwidefsky@de.ibm.com>,
        Heiko Carstens <heiko.carstens@de.ibm.com>,
        Yoshinori Sato <ysato@users.sourceforge.jp>,
        Rich Felker <dalias@libc.org>, Ingo Molnar <mingo@redhat.com>,
        Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Julien Thierry <julien.thierry@arm.com>,
        Palmer Dabbelt <palmer@sifive.com>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Logan Gunthorpe <logang@deltatee.com>,
        Robin Murphy <robin.murphy@arm.com>,
        Greg Hackmann <ghackmann@android.com>,
        Stefan Agner <stefan@agner.ch>,
        Johannes Weiner <hannes@cmpxchg.org>,
        David Hildenbrand <david@redhat.com>,
        Jens Axboe <axboe@kernel.dk>,
        Thomas Bogendoerfer <tbogendoerfer@suse.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Hari Bathini <hbathini@linux.ibm.com>,
        Ananth N Mavinakayanahalli <ananth@linux.vnet.ibm.com>,
        Yangtao Li <tiny.windzz@gmail.com>,
        Dave Young <dyoung@redhat.com>, Baoquan He <bhe@redhat.com>,
        x86@kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-ia64@vger.kernel.org, linux-mips@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, linux-s390@vger.kernel.org,
        linux-sh@vger.kernel.org
Subject: Re: [PATCH] kernel/crash: make parse_crashkernel()'s return value
 more indicant
In-Reply-To: <1555660717-18731-1-git-send-email-kernelfans@gmail.com>
Message-ID: <alpine.DEB.2.21.1904191009040.3174@nanos.tec.linutronix.de>
References: <1555660717-18731-1-git-send-email-kernelfans@gmail.com>
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

On Fri, 19 Apr 2019, Pingfan Liu wrote:

> At present, both return and crash_size should be checked to guarantee the
> success of parse_crashkernel().
> Simplify the way by returning negative if fail, positive if success. In
> case of failure, -EINVAL for bad syntax, -1 for the parsing results in
> crash_size=0.

I'm not entirely sure what you are trying to say here, but '-1' is not an
improvement at all. We surely are not short of proper error codes, right?

Also I don't see any positive return value > 0. So what is this about:

> --- a/arch/ia64/kernel/setup.c
> +++ b/arch/ia64/kernel/setup.c
> @@ -277,7 +277,7 @@ static void __init setup_crashkernel(unsigned long total, int *n)
>  
>  	ret = parse_crashkernel(boot_command_line, total,
>  			&size, &base);
> -	if (ret == 0 && size > 0) {
> +	if (ret >= 0) {

  ^^^^^^^^^^^^^^^^^^^^^^^^^^^  ????

>  	if (!memory_region_available(crash_base, crash_size)) {
> diff --git a/arch/powerpc/kernel/fadump.c b/arch/powerpc/kernel/fadump.c
> index 45a8d0b..0b626e2 100644
> --- a/arch/powerpc/kernel/fadump.c
> +++ b/arch/powerpc/kernel/fadump.c
> @@ -376,7 +376,7 @@ static inline unsigned long fadump_calculate_reserve_size(void)
>  	 */
>  	ret = parse_crashkernel(boot_command_line, memblock_phys_mem_size(),
>  				&size, &base);
> -	if (ret == 0 && size > 0) {
> +	if (ret >= 0) {

and this ?

>  		unsigned long max_size;
>  
>  		if (fw_dump.reserve_bootvar)
> diff --git a/arch/powerpc/kernel/machine_kexec.c b/arch/powerpc/kernel/machine_kexec.c
> index 63f5a93..9f3e61a 100644
> --- a/arch/powerpc/kernel/machine_kexec.c
> +++ b/arch/powerpc/kernel/machine_kexec.c
> @@ -122,7 +122,7 @@ void __init reserve_crashkernel(void)
>  	/* use common parsing */
>  	ret = parse_crashkernel(boot_command_line, memblock_phys_mem_size(),
>  			&crash_size, &crash_base);
> -	if (ret == 0 && crash_size > 0) {
> +	if (ret >= 0) {

Again.

>  		crashk_res.start = crash_base;
>  		crashk_res.end = crash_base + crash_size - 1;
>  	}
> --- a/arch/sh/kernel/machine_kexec.c
> +++ b/arch/sh/kernel/machine_kexec.c
> @@ -157,7 +157,7 @@ void __init reserve_crashkernel(void)
>  
>  	ret = parse_crashkernel(boot_command_line, memblock_phys_mem_size(),
>  			&crash_size, &crash_base);
> -	if (ret == 0 && crash_size > 0) {
> +	if (ret >= 0) {

And some more.

>  		crashk_res.start = crash_base;
>  		crashk_res.end = crash_base + crash_size - 1;
>  	}
> diff --git a/arch/x86/kernel/setup.c b/arch/x86/kernel/setup.c
> index 3d872a5..62d07d4 100644
> --- a/arch/x86/kernel/setup.c
> +++ b/arch/x86/kernel/setup.c
> @@ -526,11 +526,11 @@ static void __init reserve_crashkernel(void)
>  
>  	/* crashkernel=XM */
>  	ret = parse_crashkernel(boot_command_line, total_mem, &crash_size, &crash_base);
> -	if (ret != 0 || crash_size <= 0) {
> +	if (ret == -EINVAL) {

Without an explanation why this proceedes on error codes other than EINVAL
this is uncomprehensible. Comments exist for a reason.

>  		/* crashkernel=X,high */
>  		ret = parse_crashkernel_high(boot_command_line, total_mem,
>  					     &crash_size, &crash_base);
> -		if (ret != 0 || crash_size <= 0)
> +		if (ret < 0)
>  			return;
>  		high = true;

> @@ -87,7 +87,7 @@ static int __init parse_crashkernel_mem(char *cmdline,
>  		cur = tmp;
>  		if (size >= system_ram) {
>  			pr_warn("crashkernel: invalid size\n");
> -			return -EINVAL;
> +			return -1;

Well, this is incomprehensible as well. The pr_warn() says invalid and then
you change the error code to something magic.

Thanks,

	tglx


