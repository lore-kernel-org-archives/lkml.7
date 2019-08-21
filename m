Return-Path: <SRS0=xaRW=WR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_2 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9868C3A59E
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Aug 2019 16:20:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8CEAC22CE3
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Aug 2019 16:20:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729093AbfHUQUZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 21 Aug 2019 12:20:25 -0400
Received: from mga07.intel.com ([134.134.136.100]:48365 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728194AbfHUQUZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Aug 2019 12:20:25 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga105.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 21 Aug 2019 09:20:24 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,412,1559545200"; 
   d="scan'208";a="330069428"
Received: from spandruv-desk.jf.intel.com ([10.54.75.31])
  by orsmga004.jf.intel.com with ESMTP; 21 Aug 2019 09:20:24 -0700
Message-ID: <1b68045227e852fb2f250d0ec858ae006490123f.camel@linux.intel.com>
Subject: Re: [PATCH] tools/power: intel-speed-select:  Fix a read overflow
 in isst_set_tdp_level_msr()
From:   Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
To:     Dan Carpenter <dan.carpenter@oracle.com>
Cc:     platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-janitors@vger.kernel.org,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Date:   Wed, 21 Aug 2019 09:20:24 -0700
In-Reply-To: <20190821071403.GG26957@mwanda>
References: <20190821071403.GG26957@mwanda>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5 (3.28.5-3.fc28) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2019-08-21 at 10:14 +0300, Dan Carpenter wrote:
> The isst_send_msr_command() function will read 8 bytes but we are
> passing an address to an int (4 bytes) so it results in a read
> overflow.
> 
> Fixes: 3fb4f7cd472c ("tools/power/x86: A tool to validate Intel Speed
> Select commands")
> Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
Acked-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>

> ---
>  tools/power/x86/intel-speed-select/isst-core.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/tools/power/x86/intel-speed-select/isst-core.c
> b/tools/power/x86/intel-speed-select/isst-core.c
> index 8de4ac39a008..f724322856ed 100644
> --- a/tools/power/x86/intel-speed-select/isst-core.c
> +++ b/tools/power/x86/intel-speed-select/isst-core.c
> @@ -190,6 +190,7 @@ int isst_get_get_trl(int cpu, int level, int
> avx_level, int *trl)
>  
>  int isst_set_tdp_level_msr(int cpu, int tdp_level)
>  {
> +	unsigned long long level = tdp_level;
>  	int ret;
>  
>  	debug_printf("cpu: tdp_level via MSR %d\n", cpu, tdp_level);
> @@ -202,8 +203,7 @@ int isst_set_tdp_level_msr(int cpu, int
> tdp_level)
>  	if (tdp_level > 2)
>  		return -1; /* invalid value */
>  
> -	ret = isst_send_msr_command(cpu, 0x64b, 1,
> -				    (unsigned long long *)&tdp_level);
> +	ret = isst_send_msr_command(cpu, 0x64b, 1, &level);
>  	if (ret)
>  		return ret;
>  

