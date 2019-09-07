Return-Path: <SRS0=QEJJ=XC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96BC7C43331
	for <linux-kernel@archiver.kernel.org>; Sat,  7 Sep 2019 21:26:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7084F2173B
	for <linux-kernel@archiver.kernel.org>; Sat,  7 Sep 2019 21:26:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406810AbfIGV00 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 7 Sep 2019 17:26:26 -0400
Received: from mga12.intel.com ([192.55.52.136]:60603 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727420AbfIGV00 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 7 Sep 2019 17:26:26 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga106.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 07 Sep 2019 14:26:25 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,478,1559545200"; 
   d="scan'208";a="195779482"
Received: from ranerica-svr.sc.intel.com ([172.25.110.23])
  by orsmga002.jf.intel.com with ESMTP; 07 Sep 2019 14:26:24 -0700
Date:   Sat, 7 Sep 2019 14:26:10 -0700
From:   Ricardo Neri <ricardo.neri-calderon@linux.intel.com>
To:     Brendan Shanks <bshanks@codeweavers.com>
Cc:     linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
        "Eric W. Biederman" <ebiederm@xmission.com>
Subject: Re: [PATCH] x86/umip: Add emulation for 64-bit processes
Message-ID: <20190907212610.GA30930@ranerica-svr.sc.intel.com>
References: <20190905232222.14900-1-bshanks@codeweavers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190905232222.14900-1-bshanks@codeweavers.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 05, 2019 at 04:22:21PM -0700, Brendan Shanks wrote:
> Add emulation of the sgdt, sidt, and smsw instructions for 64-bit
> processes.
> 
> Wine users have encountered a number of 64-bit Windows games that use
> these instructions (particularly sgdt), and were crashing when run on
> UMIP-enabled systems.

Emulation support for 64-bit processes was not initially included
because no use cases had been identified. Brendan has found one.

Here is the relevant e-mail thread: https://lkml.org/lkml/2017/1/26/12

FWIW,

Reviewed-by: Ricardo Neri <ricardo.neri-calderon@linux.intel.com>

Only one minor comment below...

> 
> Originally-by: Ricardo Neri <ricardo.neri-calderon@linux.intel.com>
> Signed-off-by: Brendan Shanks <bshanks@codeweavers.com>
> ---
>  arch/x86/kernel/umip.c | 55 +++++++++++++++++++++++++-----------------
>  1 file changed, 33 insertions(+), 22 deletions(-)
> 
> diff --git a/arch/x86/kernel/umip.c b/arch/x86/kernel/umip.c
> index 5b345add550f..1812e95d2f55 100644
> --- a/arch/x86/kernel/umip.c
> +++ b/arch/x86/kernel/umip.c
> @@ -51,9 +51,7 @@
>   * The instruction smsw is emulated to return the value that the register CR0
>   * has at boot time as set in the head_32.
>   *
> - * Also, emulation is provided only for 32-bit processes; 64-bit processes
> - * that attempt to use the instructions that UMIP protects will receive the
> - * SIGSEGV signal issued as a consequence of the general protection fault.
> + * Emulation is provided for both 32-bit and 64-bit processes.
>   *
>   * Care is taken to appropriately emulate the results when segmentation is
>   * used. That is, rather than relying on USER_DS and USER_CS, the function
> @@ -63,17 +61,18 @@
>   * application uses a local descriptor table.
>   */
>  
> -#define UMIP_DUMMY_GDT_BASE 0xfffe0000
> -#define UMIP_DUMMY_IDT_BASE 0xffff0000
> +#define UMIP_DUMMY_GDT_BASE 0xfffffffffffe0000ULL
> +#define UMIP_DUMMY_IDT_BASE 0xffffffffffff0000ULL
>  
>  /*
>   * The SGDT and SIDT instructions store the contents of the global descriptor
>   * table and interrupt table registers, respectively. The destination is a
>   * memory operand of X+2 bytes. X bytes are used to store the base address of
> - * the table and 2 bytes are used to store the limit. In 32-bit processes, the
> - * only processes for which emulation is provided, X has a value of 4.
> + * the table and 2 bytes are used to store the limit. In 32-bit processes X
> + * has a value of 4, in 64-bit processes X has a value of 8.
>   */
> -#define UMIP_GDT_IDT_BASE_SIZE 4
> +#define UMIP_GDT_IDT_BASE_SIZE_64BIT 8
> +#define UMIP_GDT_IDT_BASE_SIZE_32BIT 4
>  #define UMIP_GDT_IDT_LIMIT_SIZE 2
>  
>  #define	UMIP_INST_SGDT	0	/* 0F 01 /0 */
> @@ -189,6 +188,7 @@ static int identify_insn(struct insn *insn)
>   * @umip_inst:	A constant indicating the instruction to emulate
>   * @data:	Buffer into which the dummy result is stored
>   * @data_size:	Size of the emulated result
> + * @x86_64:     true if process is 64-bit, false otherwise
>   *
>   * Emulate an instruction protected by UMIP and provide a dummy result. The
>   * result of the emulation is saved in @data. The size of the results depends
> @@ -202,11 +202,8 @@ static int identify_insn(struct insn *insn)
>   * 0 on success, -EINVAL on error while emulating.
>   */
>  static int emulate_umip_insn(struct insn *insn, int umip_inst,
> -			     unsigned char *data, int *data_size)
> +			     unsigned char *data, int *data_size, bool x86_64)
>  {
> -	unsigned long dummy_base_addr, dummy_value;
> -	unsigned short dummy_limit = 0;
> -
>  	if (!data || !data_size || !insn)
>  		return -EINVAL;
>  	/*
> @@ -219,6 +216,9 @@ static int emulate_umip_insn(struct insn *insn, int umip_inst,
>  	 * is always returned irrespective of the operand size.
>  	 */
>  	if (umip_inst == UMIP_INST_SGDT || umip_inst == UMIP_INST_SIDT) {
> +		u64 dummy_base_addr;
> +		u16 dummy_limit = 0;
> +
>  		/* SGDT and SIDT do not use registers operands. */
>  		if (X86_MODRM_MOD(insn->modrm.value) == 3)
>  			return -EINVAL;
> @@ -228,13 +228,24 @@ static int emulate_umip_insn(struct insn *insn, int umip_inst,
>  		else
>  			dummy_base_addr = UMIP_DUMMY_IDT_BASE;
>  
> -		*data_size = UMIP_GDT_IDT_LIMIT_SIZE + UMIP_GDT_IDT_BASE_SIZE;

Maybe a blank line here?

Thanks and BR,
Ricardo
