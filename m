Return-Path: <SRS0=AnJR=XA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_2 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3DE24C43331
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Sep 2019 19:42:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A599B214E0
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Sep 2019 19:42:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390049AbfIETmG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 5 Sep 2019 15:42:06 -0400
Received: from mga06.intel.com ([134.134.136.31]:40846 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727171AbfIETmG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Sep 2019 15:42:06 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga104.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 05 Sep 2019 12:42:05 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,471,1559545200"; 
   d="scan'208";a="182924968"
Received: from mlamm-mobl1.amr.corp.intel.com (HELO spandruv-mobl3.jf.intel.com) ([10.251.22.142])
  by fmsmga008.fm.intel.com with ESMTP; 05 Sep 2019 12:42:05 -0700
Message-ID: <f12560e59427ce7e038334a3b59bf084a748d998.camel@linux.intel.com>
Subject: Re: [PATCH v2 9/9] tools/power/x86/intel-speed-select: Fix memory
 leak
From:   Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
To:     Prarit Bhargava <prarit@redhat.com>,
        platform-driver-x86@vger.kernel.org
Cc:     andriy.shevchenko@intel.com, David Arcari <darcari@redhat.com>,
        linux-kernel@vger.kernel.org
Date:   Thu, 05 Sep 2019 12:42:05 -0700
In-Reply-To: <20190905120311.15286-10-prarit@redhat.com>
References: <20190905120311.15286-1-prarit@redhat.com>
         <20190905120311.15286-10-prarit@redhat.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5 (3.28.5-3.fc28) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2019-09-05 at 08:03 -0400, Prarit Bhargava wrote:
> cpumasks are allocated by calling the alloc_cpu_mask() function and
> are
> never free'd.  They should be free'd after the commands have run.
> 
> Fix the memory leaks by calling free_cpu_set().
Good to fix this. But after one command execution the process will
exit.

Thanks,
Srinivas

> 
> Signed-off-by: Prarit Bhargava <prarit@redhat.com>
> Cc: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
> Cc: David Arcari <darcari@redhat.com>
> Cc: linux-kernel@vger.kernel.org
> ---
>  tools/power/x86/intel-speed-select/isst-config.c | 16 +++++++++++---
> --
>  1 file changed, 11 insertions(+), 5 deletions(-)
> 
> diff --git a/tools/power/x86/intel-speed-select/isst-config.c
> b/tools/power/x86/intel-speed-select/isst-config.c
> index 78f0cebda1da..59753b3917bb 100644
> --- a/tools/power/x86/intel-speed-select/isst-config.c
> +++ b/tools/power/x86/intel-speed-select/isst-config.c
> @@ -603,6 +603,10 @@ static int isst_fill_platform_info(void)
>  
>  	close(fd);
>  
> +	if (isst_platform_info.api_version > supported_api_ver) {
> +		printf("Incompatible API versions; Upgrade of tool is
> required\n");
> +		return -1;
> +	}
>  	return 0;
>  }
>  
> @@ -1528,6 +1532,7 @@ static void cmdline(int argc, char **argv)
>  {
>  	int opt;
>  	int option_index = 0;
> +	int ret;
>  
>  	static struct option long_options[] = {
>  		{ "cpu", required_argument, 0, 'c' },
> @@ -1589,13 +1594,14 @@ static void cmdline(int argc, char **argv)
>  	set_max_cpu_num();
>  	set_cpu_present_cpu_mask();
>  	set_cpu_target_cpu_mask();
> -	isst_fill_platform_info();
> -	if (isst_platform_info.api_version > supported_api_ver) {
> -		printf("Incompatible API versions; Upgrade of tool is
> required\n");
> -		exit(0);
> -	}
> +	ret = isst_fill_platform_info();
> +	if (ret)
> +		goto out;
>  
>  	process_command(argc, argv);
> +out:
> +	free_cpu_set(present_cpumask);
> +	free_cpu_set(target_cpumask);
>  }
>  
>  int main(int argc, char **argv)

