Return-Path: <SRS0=RyeP=TH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB7DDC004C9
	for <linux-kernel@archiver.kernel.org>; Tue,  7 May 2019 12:21:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ADD83205ED
	for <linux-kernel@archiver.kernel.org>; Tue,  7 May 2019 12:21:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="mTd1DFCI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726642AbfEGMVs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 May 2019 08:21:48 -0400
Received: from merlin.infradead.org ([205.233.59.134]:38728 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726329AbfEGMVs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 May 2019 08:21:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=XBpHrK3x4JFxd3spf5zG50ETJ0+QB7RkIoJz/qx+uqg=; b=mTd1DFCIEzuPrvgXakuyjb47w
        p310AoKWHdWycrX+sLSHTp9MoUxhRGHDSVq7JUwZ0f2l08HqLoR38HovwbN1tApd+JeoND8dVA/4g
        yOXAYyy0GsOorIq/OdC2VDPyt2Ucvu0L3OP80D1r7hs6G9zLC1f7Zw8fK5U7Dw8rYwJ7IxPdv1XfY
        G4Auzr1T8r7mstosshXsYk7AvtkXfroxEFhCnTuITY6ssAjyxiFOaydf3xd0UtmovloPlHJ0hRJpb
        RAsBDTni5oxHv4DBDeomvAzWkhQr+PpC7LchkVuN928sGjzm/jUF3jFUujD/2zkb5NOL7T6KGQq8q
        Yl6zk1aCw==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1hNz6M-000708-VD; Tue, 07 May 2019 12:21:43 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 9593E2023ADB5; Tue,  7 May 2019 14:21:41 +0200 (CEST)
Date:   Tue, 7 May 2019 14:21:41 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Len Brown <lenb@kernel.org>
Cc:     x86@kernel.org, linux-kernel@vger.kernel.org,
        Kan Liang <kan.liang@linux.intel.com>,
        Len Brown <len.brown@intel.com>
Subject: Re: [PATCH 16/22] perf/x86/intel/uncore: Support multi-die/package
Message-ID: <20190507122141.GM2623@hirez.programming.kicks-ass.net>
References: <6f53f0e494d743c79e18f6e3a98085711e6ddd0c.1557177585.git.len.brown@intel.com>
 <1d7c4d47cfca91c11b0e078d86a8f7f7da6d862a.1557177585.git.len.brown@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1d7c4d47cfca91c11b0e078d86a8f7f7da6d862a.1557177585.git.len.brown@intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 06, 2019 at 05:26:11PM -0400, Len Brown wrote:
> @@ -1411,7 +1413,7 @@ static int __init intel_uncore_init(void)
>  	if (boot_cpu_has(X86_FEATURE_HYPERVISOR))
>  		return -ENODEV;
>  
> -	max_packages = topology_max_packages();
> +	max_packages = topology_max_packages() * topology_max_die_per_package();

That's max_dies..

>  	uncore_init = (struct intel_uncore_init_fun *)id->driver_data;
>  	if (uncore_init->pci_init) {
> -- 
> 2.18.0-rc0
> 
