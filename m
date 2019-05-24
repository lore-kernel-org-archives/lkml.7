Return-Path: <SRS0=Z4g5=TY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	T_DKIMWL_WL_HIGH,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5E2B6C072B5
	for <linux-kernel@archiver.kernel.org>; Fri, 24 May 2019 14:17:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 305BB206A3
	for <linux-kernel@archiver.kernel.org>; Fri, 24 May 2019 14:17:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1558707457;
	bh=Ly/qXNblcj6nTmgNO9vZijpkqkJFY1NjX2g/yRrwRXU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=jJAdcdhpFFyMTaNl5DGlhDL04kcY3VWyscjUckkF7NLhEuXAEjsXav9nTBVZhtjp1
	 lOZXpOlvpv2BjhIi/4wbOrTxQ5CUGFxV2qKGPDL+5sMNZ1bzl/kdM4WXg7/mNO63CW
	 s649gWeTNEAhwoxvriziajuJ4ZosfRRUSPG2h6DA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404116AbfEXORg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 May 2019 10:17:36 -0400
Received: from mail.kernel.org ([198.145.29.99]:52714 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2403917AbfEXORf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 May 2019 10:17:35 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 420D020673;
        Fri, 24 May 2019 14:17:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1558707454;
        bh=Ly/qXNblcj6nTmgNO9vZijpkqkJFY1NjX2g/yRrwRXU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=GIl4k66ws5pUeVrvkGpDk+3pIsbuq17/KAV6o4+bT8OzTqKiUq0m/9vscvMRI4O2H
         mm9CvKcNChu2czCmqM4eV1rc640R2qZ/+DDl0I8m+nN0I5nqpVX6f0K91x2tn/onOX
         SbtiqAcmUr64ICWNRlYZo/XrHXsA0HnR5iq4wdfw=
Date:   Fri, 24 May 2019 16:17:32 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Jinpu Wang <jinpu.wang@cloud.ionos.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>, tony.luck@intel.com,
        Arjan van de Ven <arjan@linux.intel.com>,
        linux-kernel@vger.kernel.org,
        Elmar Gerdes <elmar.gerdes@cloud.ionos.com>
Subject: Re: Is 2nd Generation Intel(R) Xeon(R) Processors (Formerly Cascade
 Lake) affected by MDS
Message-ID: <20190524141732.GA4412@kroah.com>
References: <CAMGffEkQmdrrH3+UChZx_Af6WcFFQFw6fz3Ti4CRUau-wq7jow@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAMGffEkQmdrrH3+UChZx_Af6WcFFQFw6fz3Ti4CRUau-wq7jow@mail.gmail.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 24, 2019 at 03:19:34PM +0200, Jinpu Wang wrote:
> Resend with plain text, and remove confidential unnecessary signature.
> sorry for spam.
> 
> Hi Thomas, hi Greg, hi Tony, hi Arjan, hi other expert on the list
> 
> I noticed on our Cascade lake with 4.14.120,  the kernel is reporting
> vulnerable:
> jwang@ps401a-912:~$ head /sys/devices/system/cpu/vulnerabilities/mds
> Vulnerable: Clear CPU buffers attempted, no microcode; SMT vulnerable
> 
> But according to INTEL,  they have built the mitigation in hardware
> for Cascade Lake:
> https://www.intel.com/content/www/us/en/architecture-and-technology/engineering-new-protections-into-hardware.html
> 
> We are using latest microcode from debian:
> https://metadata.ftp-master.debian.org/changelogs//non-free/i/intel-microcode/intel-microcode_3.20190514.1~deb9u1_changelog
> lscpu:
> jwang@ps401a-912:~$ lscpu
> Architecture:          x86_64
> CPU op-mode(s):        32-bit, 64-bit
> Byte Order:            Little Endian
> CPU(s):                96
> On-line CPU(s) list:   0-95
> Thread(s) per core:    2
> Core(s) per socket:    24
> Socket(s):             2
> NUMA node(s):          2
> Vendor ID:             GenuineIntel
> CPU family:            6
> Model:                 85
> Model name:            Intel(R) Xeon(R) Platinum 8268 CPU @ 2.90GHz
> Stepping:              5
> CPU MHz:               3228.226
> CPU max MHz:           3900.0000
> CPU min MHz:           1000.0000
> BogoMIPS:              5800.00
> Virtualization:        VT-x
> L1d cache:             32K
> L1i cache:             32K
> L2 cache:              1024K
> L3 cache:              33792K
> NUMA node0 CPU(s):     0-23,48-71
> NUMA node1 CPU(s):     24-47,72-95
> Flags:                 fpu vme de pse tsc msr pae mce cx8 apic sep
> mtrr pge mca cmov pat pse36 clflush dts acpi mmx fxsr sse sse2 ss ht
> tm pbe syscall nx pdpe1gb rdtscp lm constant_tsc art arch_perfmon pebs
> bts rep_good nopl xtopology nonstop_tsc cpuid aperfmperf pni pclmulqdq
> dtes64 monitor ds_cpl vmx smx est tm2 ssse3 sdbg fma cx16 xtpr pdcm
> pcid dca sse4_1 sse4_2 x2apic movbe popcnt tsc_deadline_timer aes
> xsave avx f16c rdrand lahf_lm abm 3dnowprefetch cpuid_fault epb cat_l3
> cdp_l3 invpcid_single intel_ppin ssbd mba ibrs ibpb stibp tpr_shadow
> vnmi flexpriority ept vpid fsgsbase tsc_adjust bmi1 hle avx2 smep bmi2
> erms invpcid rtm cqm mpx rdt_a avx512f avx512dq rdseed adx smap
> clflushopt clwb intel_pt avx512cd avx512bw avx512vl xsaveopt xsavec
> xgetbv1 xsaves cqm_llc cqm_occup_llc cqm_mbm_total cqm_mbm_local
> dtherm ida arat pln pts pku ospke flush_l1d arch_capabilities
> 
> Clearly we want to buy Cascade Lake if the hardware mitigations are in
> place, but the information on the internet is quite limited and
> misleading.
> 
> Could anyone of you could clarify it for us?
> Does it mean 4.14.120 is missing patches for detecting Cascade Lake
> mitigation, Or maybe only small set of cascade lake has mitigation?
> Or the community/intel are not sure about it yet?

Did you try 4.19 or 5.1?  Try those and see if anything changes.

If not, odds are you need a microcode update from Intel, please contact
them, nothing we can do about that.

If 4.14 works different from 4.19 or 5.1, please let us know.

thanks,

greg k-h
