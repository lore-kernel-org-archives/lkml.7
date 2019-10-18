Return-Path: <SRS0=6OEZ=YL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9209CA9EA1
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Oct 2019 07:12:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7A1DD21D80
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Oct 2019 07:12:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="MZmqGthJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2504547AbfJRHM3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 18 Oct 2019 03:12:29 -0400
Received: from merlin.infradead.org ([205.233.59.134]:33942 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728008AbfJRHM3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Oct 2019 03:12:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=70RBmu/1BKwG1muO4mtJ8TJ8hCo34siAp8SqvZX3CFM=; b=MZmqGthJx7fbQD70+n0/DOoYl
        XZy310QUlkaYt0C572lLZ2EWBUV2zOOC4uODDZ+vSBp7x23sbJeZvNscfu1/8W+MqiqY1jn9WEjB2
        vjJ09Q78/z7dpvr8htRb1FH3RndJn1EL6oJC6jLRrPtzuMO9USUfEnvn7Np282u2bXezEsfqF3K6s
        VN8hllpfC9hUDOKROgcDN6ZXAvRqi49o6O3wcu3bTf03IZNUtHQM8OwugR+idpkdei6mQLvHr3H+F
        BsCMLZlf4xYnTj+gsoUlSqVREG/PKKn2jsDZWVaIsZQgbVRQMrfCxyRpVCIdUWQ1ccCzSxdQc/OsI
        7O/nMHFGQ==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1iLMQj-0007Bj-L3; Fri, 18 Oct 2019 07:12:09 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 19AFE305803;
        Fri, 18 Oct 2019 09:11:10 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id A753B2B17E62E; Fri, 18 Oct 2019 09:12:06 +0200 (CEST)
Date:   Fri, 18 Oct 2019 09:12:06 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Zhenzhong Duan <zhenzhong.duan@oracle.com>
Cc:     linux-kernel@vger.kernel.org, x86@kernel.org,
        tim.c.chen@linux.intel.com, Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@alien8.de>, Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>
Subject: Re: [PATCH] x86: Don't use MWAIT if explicitly requested
Message-ID: <20191018071206.GZ2328@hirez.programming.kicks-ass.net>
References: <1571370354-17736-1-git-send-email-zhenzhong.duan@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1571370354-17736-1-git-send-email-zhenzhong.duan@oracle.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 18, 2019 at 11:45:54AM +0800, Zhenzhong Duan wrote:
> If 'idle=nomwait' is specified or process matching what's in
> processor_idle_dmi_table, we should't use MWAIT at bootup stage before
> cpuidle driver loaded, even if it's preferred by default on Intel.
> 
> Add a check so that HALT instruction is used in those cases.

The comment in idle_setup():

	/*
	 * If the boot option of "idle=nomwait" is added,
	 * it means that mwait will be disabled for CPU C2/C3
	 * states. In such case it won't touch the variable
	 * of boot_option_idle_override.
	 */
	boot_option_idle_override = IDLE_NOMWAIT;

explicitly states this option is for C2+

> Signed-off-by: Zhenzhong Duan <zhenzhong.duan@oracle.com>
> Cc: Thomas Gleixner <tglx@linutronix.de>
> Cc: Borislav Petkov <bp@alien8.de>
> Cc: Ingo Molnar <mingo@redhat.com>
> Cc: "H. Peter Anvin" <hpa@zytor.com>
> Cc: Boris Ostrovsky <boris.ostrovsky@oracle.com>
> ---
>  arch/x86/kernel/process.c | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/arch/x86/kernel/process.c b/arch/x86/kernel/process.c
> index 5e94c43..37fc577 100644
> --- a/arch/x86/kernel/process.c
> +++ b/arch/x86/kernel/process.c
> @@ -667,6 +667,10 @@ static void amd_e400_idle(void)
>   */
>  static int prefer_mwait_c1_over_halt(const struct cpuinfo_x86 *c)
>  {
> +	/* Don't use MWAIT-C1 if explicitly requested */
> +	if (boot_option_idle_override == IDLE_NOMWAIT)
> +		return 0;

And this is very much about C1...

OTOH, "idle=halt" should be forcing HLT over MWAIT, so did you want to
write:

	if (boot_option_idle_override == IDLE_HALT)
		return 0;

instead?
