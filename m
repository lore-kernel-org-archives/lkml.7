Return-Path: <SRS0=EIds=SH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 35536C282CE
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Apr 2019 18:27:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0B88E20863
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Apr 2019 18:27:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731640AbfDES1J (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 5 Apr 2019 14:27:09 -0400
Received: from Galois.linutronix.de ([146.0.238.70]:49455 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731087AbfDES1I (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Apr 2019 14:27:08 -0400
Received: from p5492e2fc.dip0.t-ipconnect.de ([84.146.226.252] helo=nanos)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1hCTYO-00021r-9n; Fri, 05 Apr 2019 20:27:04 +0200
Date:   Fri, 5 Apr 2019 20:27:03 +0200 (CEST)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Len Brown <lenb@kernel.org>
cc:     x86@kernel.org, linux-kernel@vger.kernel.org,
        Zhang Rui <rui.zhang@intel.com>,
        Len Brown <len.brown@intel.com>, linux-pm@vger.kernel.org
Subject: Re: [PATCH 08/14] powercap/intel_rapl: Support multi-die/package
In-Reply-To: <680e11fe0dcc65e4cfa5bfeaa0d1cdbe7896e3c0.1551160674.git.len.brown@intel.com>
Message-ID: <alpine.DEB.2.21.1904052022310.1802@nanos.tec.linutronix.de>
References: <e2810a5317d3a109a98204e883fd1461f77b9339.1551160674.git.len.brown@intel.com> <680e11fe0dcc65e4cfa5bfeaa0d1cdbe7896e3c0.1551160674.git.len.brown@intel.com>
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

On Tue, 26 Feb 2019, Len Brown wrote:

> From: Zhang Rui <rui.zhang@intel.com>
> 
> On the new dual-die/package systems, the RAPL MSR becomes die-scope.
> Thus instead of one powercap device per physical package, now there
> should be one powercap device for each unique die on these systems.
> 
> This patch introduces intel_rapl driver support for new
> dual-die/package systems.

This patch .... See Documentation/processs/

and this sentence is not really helpful either.

> On the hardwares that do not have multi-die, topology_logical_die_id()
> equals topology_physical_package_id(), thus there is no functional change.

Something like this:

To support this the RAPL package domain has to be identified by the die id
instead of the package id. On single die CPUs the die id is the same as the
physical package id.

Hmm?

> Signed-off-by: Zhang Rui <rui.zhang@intel.com>
> Signed-off-by: Len Brown <len.brown@intel.com>
> Acked-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> Cc: linux-pm@vger.kernel.org
> ---
>  drivers/powercap/intel_rapl.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/powercap/intel_rapl.c b/drivers/powercap/intel_rapl.c
> index 6057d9695fed..8723e9ae7436 100644
> --- a/drivers/powercap/intel_rapl.c
> +++ b/drivers/powercap/intel_rapl.c
> @@ -266,7 +266,7 @@ static struct rapl_domain *platform_rapl_domain; /* Platform (PSys) domain */
>  /* caller to ensure CPU hotplug lock is held */
>  static struct rapl_package *rapl_find_package(int cpu)
>  {
> -	int id = topology_physical_package_id(cpu);
> +	int id = topology_logical_die_id(cpu);
>  	struct rapl_package *rp;
>  
>  	list_for_each_entry(rp, &rapl_packages, plist) {
> @@ -1457,7 +1457,7 @@ static void rapl_remove_package(struct rapl_package *rp)
>  /* called from CPU hotplug notifier, hotplug lock held */
>  static struct rapl_package *rapl_add_package(int cpu)
>  {
> -	int id = topology_physical_package_id(cpu);
> +	int id = topology_logical_die_id(cpu);
>  	struct rapl_package *rp;
>  	int ret;
>  
> -- 
> 2.18.0-rc0
> 
> 
