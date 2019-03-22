Return-Path: <SRS0=oArh=RZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40A13C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 15:54:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 009A421900
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 15:54:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alien8.de header.i=@alien8.de header.b="lZcoodbq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727922AbfCVPyu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Mar 2019 11:54:50 -0400
Received: from mail.skyhub.de ([5.9.137.197]:51046 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727169AbfCVPyu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Mar 2019 11:54:50 -0400
Received: from zn.tnic (p200300EC2F098000329C23FFFEA6A903.dip0.t-ipconnect.de [IPv6:2003:ec:2f09:8000:329c:23ff:fea6:a903])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 49BDE1EC09F1;
        Fri, 22 Mar 2019 16:54:48 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1553270088;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=Jc4qPRnlCCGWrGsd4y+Fy2J+F4FBc7sfwpQFtcwEG6o=;
        b=lZcoodbqoQwnFlJsuZR8gzk9t4X90tpI2cBR+G1dpJvVlnzrH0opozUX6TpS0f7tMTvlRl
        b1QC19Ki0f7Sg93ObGz2ScJp30MpL/DefDVoiQMUSQgZ8SleATjLZRmSVYH8nBKY9zHqh2
        vgCFDvN5FhFKodbhEFku0yos+EJAYY8=
Date:   Fri, 22 Mar 2019 16:54:50 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     Pu Wen <puwen@hygon.cn>
Cc:     tglx@linutronix.de, mingo@redhat.com, hpa@zytor.com,
        x86@kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH] x86/cpu/hygon: Fix phys_proc_id calculation logic
 for multi-die processor
Message-ID: <20190322155449.GE12472@zn.tnic>
References: <1553251380-7015-1-git-send-email-puwen@hygon.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1553251380-7015-1-git-send-email-puwen@hygon.cn>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 22, 2019 at 06:43:00PM +0800, Pu Wen wrote:
> For Hygon family 18h multi-die processor platform, which support 1-Die/
> 2-Die/4-Die per socket, the system view is shown in the following system
> topology.
> 
> System View (with 1-Die 2-Socket):
>            |------------|
>          ------       -----
>  SOCKET0 | D0 |       | D1 |  SOCKET1
>          ------       -----
> 
> System View (with 2-Die 2-socket):
>            --------------------
>            |     -------------|------
>            |     |            |     |
>          ------------       ------------
>  SOCKET0 | D1 -- D0 |       | D3 -- D2 | SOCKET1
>          ------------       ------------
> 
> System View (with 4-Die 2-Socket) :
>            --------------------
>            |     -------------|------
>            |     |            |     |
>          ------------       ------------
>          | D1 -- D0 |       | D7 -- D6 |
>          | |  \/ |  |       | |  \/ |  |
>  SOCKET0 | |  /\ |  |       | |  /\ |  | SOCKET1
>          | D2 -- D3 |       | D4 -- D5 |
>          ------------       ------------
>            |     |            |     |
>            ------|------------|     |
>                  --------------------
> 
> Current codes direct use "phys_proc_id = initial_apicid >> bits", which

Use proper english please - there's no "codes"

> calc phys_proc_id from initial_apicid by shifting *bits*, will get

... or "calc"

> wrong phys_proc_id for Hygon family 18h 1-Die/2-Die 2-socket system.
> 
> According to document [1] section 2.1.11.1, the *bits* is the value of
> CPUID_Fn80000008_ECX[12:15]. The value may be 4, 5 or 6. The definitions
> are: 4 - 1 die, 5 - 2 die, 6 - 3/4 die.
> 
> ApicId definition is as below (see section 2.1.10.2.1.3 of [1]):
>              -------------------------------------------------
>          Bit |     6     |   5  4  |    3   |    2   1   0   |
>              |-----------|---------|--------|----------------|
>          IDs | Socket ID | Node ID | CCX ID | Core/Thread ID |
>              -------------------------------------------------
> 
> So for 3/4-Die CPU the *bits* is 6, which is same to ApicID definition
> field, which still can get correct socket ID for 2-socket system. But
> for 1-Die or 2-Die CPU the *bits* is 4 or 5, which will cause the right
> shifted result is not exactly the value of socket ID.
> 
> For Hygon family 18h CPU the socket ID should be obtained from ApicId[6].
> To fix the problem and match ApicID field definition, adjust the shift
> bits to 6 for all Hygon family 18h multi-die CPUs.

Sounds to me like you're programming the initial APIC ID not
the same way as AMD do...

> Reference:
> [1] https://www.amd.com/system/files/TechDocs/54945_PPR_Family_17h_Models_00h-0Fh.pdf
> 
> Signed-off-by: Pu Wen <puwen@hygon.cn>
> ---
>  arch/x86/kernel/cpu/hygon.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/arch/x86/kernel/cpu/hygon.c b/arch/x86/kernel/cpu/hygon.c
> index cf25405..2df6dd9 100644
> --- a/arch/x86/kernel/cpu/hygon.c
> +++ b/arch/x86/kernel/cpu/hygon.c
> @@ -87,6 +87,9 @@ static void hygon_get_topology(struct cpuinfo_x86 *c)
>  		if (!err)
>  			c->x86_coreid_bits = get_count_order(c->x86_max_cores);
>  
> +		/* Socket ID is ApicId[6] for these processors. */
> +		c->phys_proc_id = c->apicid >> 6;

That 6 is a magic number, I assume?

-- 
Regards/Gruss,
    Boris.

Good mailing practices for 400: avoid top-posting and trim the reply.
