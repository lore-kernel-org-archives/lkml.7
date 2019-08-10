Return-Path: <SRS0=4CSQ=WG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2D8FCC433FF
	for <linux-kernel@archiver.kernel.org>; Sat, 10 Aug 2019 05:25:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EA186217D7
	for <linux-kernel@archiver.kernel.org>; Sat, 10 Aug 2019 05:25:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726055AbfHJFZY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 10 Aug 2019 01:25:24 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:57966 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725730AbfHJFZY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 10 Aug 2019 01:25:24 -0400
Received: from p200300ddd71876457e7a91fffec98e25.dip0.t-ipconnect.de ([2003:dd:d718:7645:7e7a:91ff:fec9:8e25])
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1hwJsK-0001gl-Ea; Sat, 10 Aug 2019 07:25:08 +0200
Date:   Sat, 10 Aug 2019 07:25:02 +0200 (CEST)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Fenghua Yu <fenghua.yu@intel.com>
cc:     Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Valdis Kletnieks <valdis.kletnieks@vt.edu>,
        x86 <x86@kernel.org>, linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] x86/umwait: Fix error handling in umwait_init()
In-Reply-To: <1565401237-60936-1-git-send-email-fenghua.yu@intel.com>
Message-ID: <alpine.DEB.2.21.1908100718580.21433@nanos.tec.linutronix.de>
References: <1565401237-60936-1-git-send-email-fenghua.yu@intel.com>
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

On Fri, 9 Aug 2019, Fenghua Yu wrote:
> +/*
> + * The CPU hotplug callback sets the control MSR to the original control
> + * value.
> + */
> +static int umwait_cpu_offline(unsigned int cpu)
> +{
> +	/*
> +	 * This code is protected by the CPU hotplug already and
> +	 * orig_umwait_control_cached is never changed after it caches
> +	 * the original control MSR value in umwait_init(). So there
> +	 * is no race condition here.
> +	 */
> +	wrmsr(MSR_IA32_UMWAIT_CONTROL, orig_umwait_control_cached, 0);

Even my brain compiler emits an error here.

Thanks,

	tglx
