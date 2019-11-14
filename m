Return-Path: <SRS0=RWM+=ZG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5D9B5C43141
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Nov 2019 20:19:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4097E20709
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Nov 2019 20:19:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726953AbfKNUTt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Nov 2019 15:19:49 -0500
Received: from mga03.intel.com ([134.134.136.65]:45174 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726557AbfKNUTr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Nov 2019 15:19:47 -0500
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga103.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 14 Nov 2019 12:19:47 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.68,305,1569308400"; 
   d="scan'208";a="216879546"
Received: from guptapadev.jf.intel.com (HELO guptapadev.amr) ([10.7.198.56])
  by orsmga002.jf.intel.com with ESMTP; 14 Nov 2019 12:19:47 -0800
Date:   Thu, 14 Nov 2019 12:12:58 -0800
From:   Pawan Gupta <pawan.kumar.gupta@linux.intel.com>
To:     Waiman Long <longman@redhat.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org, Josh Poimboeuf <jpoimboe@redhat.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Mark Gross <mgross@linux.intel.com>,
        Tony Luck <tony.luck@intel.com>
Subject: Re: [PATCH] x86/speculation: Fix incorrect MDS/TAA mitigation status
Message-ID: <20191114201258.GA18745@guptapadev.amr>
References: <20191113193350.24511-1-longman@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191113193350.24511-1-longman@redhat.com>
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 13, 2019 at 02:33:50PM -0500, Waiman Long wrote:
> For MDS vulnerable processors with TSX support, enabling either MDS
> or TAA mitigations will enable the use of VERW to flush internal
> processor buffers at the right code path. IOW, they are either both
> mitigated or both not mitigated. However, if the command line options
> are inconsistent, the vulnerabilites sysfs files may not report the
> mitigation status correctly.
> 
> For example, with only the "mds=off" option:
> 
>   vulnerabilities/mds:Vulnerable; SMT vulnerable
>   vulnerabilities/tsx_async_abort:Mitigation: Clear CPU buffers; SMT vulnerable
> 
> The mds vulnerabilities file has wrong status in this case.
> 
> Change taa_select_mitigation() to sync up the two mitigation status
> and have them turned off if both "mds=off" and "tsx_async_abort=off"
> are present.
> 
> Signed-off-by: Waiman Long <longman@redhat.com>
> ---
>  arch/x86/kernel/cpu/bugs.c | 17 +++++++++++++++--
>  1 file changed, 15 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/x86/kernel/cpu/bugs.c b/arch/x86/kernel/cpu/bugs.c
> index 4c7b0fa15a19..418d41c1fd0d 100644
> --- a/arch/x86/kernel/cpu/bugs.c
> +++ b/arch/x86/kernel/cpu/bugs.c
> @@ -304,8 +304,12 @@ static void __init taa_select_mitigation(void)
>  		return;
>  	}
>  
> -	/* TAA mitigation is turned off on the cmdline (tsx_async_abort=off) */
> -	if (taa_mitigation == TAA_MITIGATION_OFF)
> +	/*
> +	 * TAA mitigation via VERW is turned off if both
> +	 * tsx_async_abort=off and mds=off are specified.
> +	 */
> +	if (taa_mitigation == TAA_MITIGATION_OFF &&
> +	    mds_mitigation == MDS_MITIGATION_OFF)
>  		goto out;
>  
>  	if (boot_cpu_has(X86_FEATURE_MD_CLEAR))
> @@ -339,6 +343,15 @@ static void __init taa_select_mitigation(void)
>  	if (taa_nosmt || cpu_mitigations_auto_nosmt())
>  		cpu_smt_disable(false);
>  
> +	/*
> +	 * Update MDS mitigation, if necessary, as the mds_user_clear is
> +	 * now enabled for TAA mitigation.
> +	 */
> +	if (mds_mitigation == MDS_MITIGATION_OFF &&
> +	    boot_cpu_has_bug(X86_BUG_MDS)) {
> +		mds_mitigation = MDS_MITIGATION_FULL;
> +		mds_select_mitigation();

This will cause a confusing print in dmesg from previous and this call
to mds_select_mitigation().

	"MDS: Vulnerable"
	"MDS: Mitigation: Clear CPU buffers"

Maybe delay MDS mitigation print till TAA is evaluated.

Thanks,
Pawan
