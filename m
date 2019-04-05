Return-Path: <SRS0=EIds=SH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 71B6EC282CE
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Apr 2019 18:29:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4BECB21773
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Apr 2019 18:29:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731722AbfDES3f (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 5 Apr 2019 14:29:35 -0400
Received: from Galois.linutronix.de ([146.0.238.70]:49460 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731362AbfDES3e (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Apr 2019 14:29:34 -0400
Received: from p5492e2fc.dip0.t-ipconnect.de ([84.146.226.252] helo=nanos)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1hCTam-00025B-NV; Fri, 05 Apr 2019 20:29:32 +0200
Date:   Fri, 5 Apr 2019 20:29:32 +0200 (CEST)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Len Brown <lenb@kernel.org>
cc:     x86@kernel.org, linux-kernel@vger.kernel.org,
        Zhang Rui <rui.zhang@intel.com>,
        Len Brown <len.brown@intel.com>
Subject: Re: [PATCH 09/14] thermal/x86_pkg_temp_thermal: Support
 multi-die/package
In-Reply-To: <863054888eb8f1a595369c49ec24740501e9c175.1551160674.git.len.brown@intel.com>
Message-ID: <alpine.DEB.2.21.1904052027280.1802@nanos.tec.linutronix.de>
References: <e2810a5317d3a109a98204e883fd1461f77b9339.1551160674.git.len.brown@intel.com> <863054888eb8f1a595369c49ec24740501e9c175.1551160674.git.len.brown@intel.com>
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
>  static int __init pkg_temp_thermal_init(void)
>  {
>  	int ret;
> +	struct cpuinfo_x86 *c = &cpu_data(0);
>  
>  	if (!x86_match_cpu(pkg_temp_thermal_ids))
>  		return -ENODEV;
>  
> -	max_packages = topology_max_packages();
> +	max_packages = topology_max_packages() * c->x86_max_dies;

This is really a sloppy hack. Just because cpuinfo is accessible it's not a
good idea to fiddle with it in a driver. We went great length to abstract
that stuff. So please add a new helper function topology_max_dies() and
retrieve it from that.

Thanks,

	tglx
