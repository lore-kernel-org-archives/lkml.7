Return-Path: <SRS0=N68d=SK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 07912C282DD
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Apr 2019 01:35:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C9E0A20880
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Apr 2019 01:35:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726513AbfDHBfv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 7 Apr 2019 21:35:51 -0400
Received: from mga03.intel.com ([134.134.136.65]:46163 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726456AbfDHBfv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 7 Apr 2019 21:35:51 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga103.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 07 Apr 2019 18:35:50 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.60,323,1549958400"; 
   d="scan'208";a="335810638"
Received: from lyang61-mobl3.ccr.corp.intel.com ([10.255.30.213])
  by fmsmga005.fm.intel.com with ESMTP; 07 Apr 2019 18:35:48 -0700
Message-ID: <1554687347.2178.1.camel@intel.com>
Subject: Re: [PATCH 08/14] powercap/intel_rapl: Support multi-die/package
From:   Zhang Rui <rui.zhang@intel.com>
To:     Thomas Gleixner <tglx@linutronix.de>, Len Brown <lenb@kernel.org>
Cc:     x86@kernel.org, linux-kernel@vger.kernel.org,
        Len Brown <len.brown@intel.com>, linux-pm@vger.kernel.org
Date:   Mon, 08 Apr 2019 09:35:47 +0800
In-Reply-To: <alpine.DEB.2.21.1904052022310.1802@nanos.tec.linutronix.de>
References: <e2810a5317d3a109a98204e883fd1461f77b9339.1551160674.git.len.brown@intel.com>
         <680e11fe0dcc65e4cfa5bfeaa0d1cdbe7896e3c0.1551160674.git.len.brown@intel.com>
         <alpine.DEB.2.21.1904052022310.1802@nanos.tec.linutronix.de>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.18.5.2-0ubuntu3.2 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 五, 2019-04-05 at 20:27 +0200, Thomas Gleixner wrote:
> On Tue, 26 Feb 2019, Len Brown wrote:
> 
> > 
> > From: Zhang Rui <rui.zhang@intel.com>
> > 
> > On the new dual-die/package systems, the RAPL MSR becomes die-
> > scope.
> > Thus instead of one powercap device per physical package, now there
> > should be one powercap device for each unique die on these systems.
> > 
> > This patch introduces intel_rapl driver support for new
> > dual-die/package systems.
> This patch .... See Documentation/processs/
> 
> and this sentence is not really helpful either.
> 
> > 
> > On the hardwares that do not have multi-die,
> > topology_logical_die_id()
> > equals topology_physical_package_id(), thus there is no functional
> > change.
> Something like this:
> 
> To support this the RAPL package domain has to be identified by the
> die id
> instead of the package id. On single die CPUs the die id is the same
> as the
> physical package id.
> 
> Hmm?

Yeah, sounds much better.
Len, will you help me update the changelog or do you want me to send an
updated version to you?

thanks,
rui

> 
> > 
> > Signed-off-by: Zhang Rui <rui.zhang@intel.com>
> > Signed-off-by: Len Brown <len.brown@intel.com>
> > Acked-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> > Cc: linux-pm@vger.kernel.org
> > ---
> >  drivers/powercap/intel_rapl.c | 4 ++--
> >  1 file changed, 2 insertions(+), 2 deletions(-)
> > 
> > diff --git a/drivers/powercap/intel_rapl.c
> > b/drivers/powercap/intel_rapl.c
> > index 6057d9695fed..8723e9ae7436 100644
> > --- a/drivers/powercap/intel_rapl.c
> > +++ b/drivers/powercap/intel_rapl.c
> > @@ -266,7 +266,7 @@ static struct rapl_domain
> > *platform_rapl_domain; /* Platform (PSys) domain */
> >  /* caller to ensure CPU hotplug lock is held */
> >  static struct rapl_package *rapl_find_package(int cpu)
> >  {
> > -	int id = topology_physical_package_id(cpu);
> > +	int id = topology_logical_die_id(cpu);
> >  	struct rapl_package *rp;
> >  
> >  	list_for_each_entry(rp, &rapl_packages, plist) {
> > @@ -1457,7 +1457,7 @@ static void rapl_remove_package(struct
> > rapl_package *rp)
> >  /* called from CPU hotplug notifier, hotplug lock held */
> >  static struct rapl_package *rapl_add_package(int cpu)
> >  {
> > -	int id = topology_physical_package_id(cpu);
> > +	int id = topology_logical_die_id(cpu);
> >  	struct rapl_package *rp;
> >  	int ret;
> >  
