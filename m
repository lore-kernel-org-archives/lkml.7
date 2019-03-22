Return-Path: <SRS0=oArh=RZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B86EDC43381
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 15:20:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 854AA218D4
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 15:20:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726839AbfCVPUM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Mar 2019 11:20:12 -0400
Received: from Galois.linutronix.de ([146.0.238.70]:41284 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725981AbfCVPUM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Mar 2019 11:20:12 -0400
Received: from [5.158.153.52] (helo=nanos.tec.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1h7Lxq-00047d-2t; Fri, 22 Mar 2019 16:20:10 +0100
Date:   Fri, 22 Mar 2019 16:20:09 +0100 (CET)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Zhao Yakui <yakui.zhao@intel.com>
cc:     linux-kernel@vger.kernel.org, x86@kernel.org,
        Jason Chen CJ <jason.cj.chen@intel.com>
Subject: Re: [RFC PATCH 1/3] arch/x86: add ACRN hypervisor guest
In-Reply-To: <1551924251-19466-2-git-send-email-yakui.zhao@intel.com>
Message-ID: <alpine.DEB.2.21.1903221615500.1729@nanos.tec.linutronix.de>
References: <1551924251-19466-1-git-send-email-yakui.zhao@intel.com> <1551924251-19466-2-git-send-email-yakui.zhao@intel.com>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Zhao,

On Thu, 7 Mar 2019, Zhao Yakui wrote:

> ACRN is one open-source hypervisour, which is maintained by Linux
> foundation. This is to add the para-virtualization support so that
> it allows to enable the Linux guest on acrn-hypervisor.
> 
> This adds x86_hyper_acrn into supported hypervisors array, which
> enables ACRN services guest running on ACRN hypervisor. It is

What is a ACRN services guest? 

> restricted to X86_64.
> 
> Signed-off-by: Jason Chen CJ <jason.cj.chen@intel.com>
> Signed-off-by: Zhao Yakui <yakui.zhao@intel.com>

This SOB chain is wrong. If Jason wrote the patch, then there should be a
'From: Jason ..' line at the top of the change log. If you both wrote it
then Jason's SOB wants to be preceeded by a 'Co-developed-by: Jason....'
line. See Documentation/process/

> +config ACRN
> +	bool "Enable services on ACRN hypervisor"
> +	depends on X86_64 && PARAVIRT
> +	help
> +	  This option allows to run Linux as guest in ACRN hypervisor.
> +	  It is needed if you want to run ACRN services linux on top of
> +	  ACRN hypervisor.

This help text does not make any sense to me.

> +const struct hypervisor_x86 x86_hyper_acrn = {
> +	.name                   = "ACRN",
> +	.detect                 = acrn_detect,
> +	.type			= X86_HYPER_ACRN,
> +	.init.init_platform     = acrn_init_platform,
> +	.init.x2apic_available  = acrn_x2apic_available,
> +};
> +EXPORT_SYMBOL(x86_hyper_acrn);

Whay is this exported? The only user of this is hypervisor.c and that is
built in. Please remove.

Thanks,

	tglx
