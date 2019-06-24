Return-Path: <SRS0=hO5d=UX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0E393C43613
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Jun 2019 13:21:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CDE162146E
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Jun 2019 13:21:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1561382496;
	bh=9ELmp3ckM1SNaxjhHehS21dBJzYbmjQUXzH1W0gDRd4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=h4qUeoAOhCt5SHofkb3ca6JYhYtfRqYQrIp6KEdCIhppCIikG2p2zkVkanNKLb3is
	 sbeH9wgdEyVRzXoWv5B4G0rhJqW/o8AmhIvma0/k2BfcYvu7AlbGnf1C5L3kYu89fC
	 ydrP92ojjpkqTUSVesT7m+z2xMm7Ywa/PjsIaZ9M=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728966AbfFXNVg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Jun 2019 09:21:36 -0400
Received: from mail.kernel.org ([198.145.29.99]:55322 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726773AbfFXNVf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jun 2019 09:21:35 -0400
Received: from willie-the-truck (236.31.169.217.in-addr.arpa [217.169.31.236])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D48C92133F;
        Mon, 24 Jun 2019 13:21:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1561382494;
        bh=9ELmp3ckM1SNaxjhHehS21dBJzYbmjQUXzH1W0gDRd4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=eDt6mjboezKiMPi593uwLjkuZhgMZpY9mcTV9T6q5lXacg1nyN2aPv747AJtlrKFI
         Sgv5uLIFoA0URSp+YDVd2ZzylWbFIxFdUAOBKWS73kO2diXRFrmu9n4PhkmGUayWJE
         AgdIbj45lYu0/YFzxaxVT32ITEnUa35TY5Kcr1KQ=
Date:   Mon, 24 Jun 2019 14:21:29 +0100
From:   Will Deacon <will@kernel.org>
To:     jinho lim <jordan.lim@samsung.com>
Cc:     will.deacon@arm.com, mark.rutland@arm.com,
        anshuman.khandual@arm.com, marc.zyngier@arm.com,
        andreyknvl@google.com, linux-kernel@vger.kernel.org,
        seroto7@gmail.com, ebiederm@xmission.com,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v2] arm64: rename dump_instr as dump_kernel_instr
Message-ID: <20190624132129.4c772nkjbrilxtcy@willie-the-truck>
References: <CGME20190620065254epcas1p48539060e94433cc254a1650cdc359ac4@epcas1p4.samsung.com>
 <20190620065249.24112-1-jordan.lim@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190620065249.24112-1-jordan.lim@samsung.com>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 20, 2019 at 03:52:49PM +0900, jinho lim wrote:
> [v2]

The version information is not usually part of the commit message. Please
drop that...

> dump_kernel_instr does not work for user mode.
> rename dump_instr function and remove __dump_instr.

... and rewrite this so it explains the problem that you're solving.

> Signed-off-by: jinho lim <jordan.lim@samsung.com>
> ---
> 
> Thanks for review, I rename dump_instr function and merge __dump_instr in it.
> 
>  arch/arm64/kernel/traps.c | 29 ++++++++++++++---------------
>  1 file changed, 14 insertions(+), 15 deletions(-)
> 
> diff --git a/arch/arm64/kernel/traps.c b/arch/arm64/kernel/traps.c
> index ccc13b45d9b1..7053165cb31a 100644
> --- a/arch/arm64/kernel/traps.c
> +++ b/arch/arm64/kernel/traps.c
> @@ -66,11 +66,20 @@ static void dump_backtrace_entry(unsigned long where)
>  	printk(" %pS\n", (void *)where);
>  }
>  
> -static void __dump_instr(const char *lvl, struct pt_regs *regs)
> +static void dump_kernel_instr(const char *lvl, struct pt_regs *regs)
>  {
> -	unsigned long addr = instruction_pointer(regs);
> +	unsigned long addr;
>  	char str[sizeof("00000000 ") * 5 + 2 + 1], *p = str;
>  	int i;
> +	mm_segment_t fs;
> +
> +	if (user_mode(regs))
> +		return;
> +
> +	addr = instruction_pointer(regs);
> +
> +	fs = get_fs();
> +	set_fs(KERNEL_DS);

Actually, if we use aarch64_insn_read() instead of get_user() then we can
avoid having to mess directly with the fs and we'll also get endianness
correction for free when running a big-endian kernel.

Will
