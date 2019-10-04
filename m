Return-Path: <SRS0=OvUS=X5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_2 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 65AA2C47404
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Oct 2019 17:15:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4639B2084D
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Oct 2019 17:15:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387790AbfJDRPW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 4 Oct 2019 13:15:22 -0400
Received: from mga03.intel.com ([134.134.136.65]:37198 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387534AbfJDRPW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Oct 2019 13:15:22 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga103.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 04 Oct 2019 10:15:21 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.67,257,1566889200"; 
   d="scan'208";a="195621580"
Received: from spandruv-desk.jf.intel.com ([10.54.75.31])
  by orsmga003.jf.intel.com with ESMTP; 04 Oct 2019 10:15:21 -0700
Message-ID: <b1895913e2adaff4daf7be6b919e50714b418fe8.camel@linux.intel.com>
Subject: Re: [PATCH v2 3/7] intel-speed-select: Add check for CascadeLake-N
 models
From:   Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
To:     Prarit Bhargava <prarit@redhat.com>,
        platform-driver-x86@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org,
        Andy Shevchenko <andriy.shevchenko@intel.com>
Date:   Fri, 04 Oct 2019 10:15:21 -0700
In-Reply-To: <20191003121112.25870-4-prarit@redhat.com>
References: <20191003121112.25870-1-prarit@redhat.com>
         <20191003121112.25870-4-prarit@redhat.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5 (3.28.5-3.fc28) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2019-10-03 at 08:11 -0400, Prarit Bhargava wrote:
> Three CascadeLake-N models (6252N, 6230N, and 5218N) have SST-PBF
> support.
> 
> Return an error if the CascadeLake processor is not one of these
> specific
> models.
> 
This patch sigfaults immediately on CLX.

> v2: Add is_clx_n_platform()
> 
> Signed-off-by: Prarit Bhargava <prarit@redhat.com>
> ---
>  .../x86/intel-speed-select/isst-config.c      | 44
> ++++++++++++++++++-
>  1 file changed, 42 insertions(+), 2 deletions(-)
> 
> diff --git a/tools/power/x86/intel-speed-select/isst-config.c
> b/tools/power/x86/intel-speed-select/isst-config.c
> index f4a23678416e..734a7960458c 100644
> --- a/tools/power/x86/intel-speed-select/isst-config.c
> +++ b/tools/power/x86/intel-speed-select/isst-config.c
> @@ -23,6 +23,7 @@ static int debug_flag;
>  static FILE *outf;
>  
>  static int cpu_model;
> +static int cpu_stepping;
>  
>  #define MAX_CPUS_IN_ONE_REQ 64
>  static short max_target_cpus;
> @@ -72,7 +73,16 @@ void debug_printf(const char *format, ...)
>  	va_end(args);
>  }
>  
> -static void update_cpu_model(void)
> +
> +int is_clx_n_platform(void)
> +{
> +	if (cpu_model == 0x55)
> +		if (cpu_stepping == 0x6 || cpu_stepping == 0x7)
> +			return 1;
> +	return 0;
> +}
> +
> +static int update_cpu_model(void)
>  {
>  	unsigned int ebx, ecx, edx;
>  	unsigned int fms, family;
> @@ -82,6 +92,34 @@ static void update_cpu_model(void)
>  	cpu_model = (fms >> 4) & 0xf;
>  	if (family == 6 || family == 0xf)
>  		cpu_model += ((fms >> 16) & 0xf) << 4;
> +
> +	cpu_stepping = fms & 0xf;
> +
> +	/* only three CascadeLake-N models are supported */
> +	if (is_clx_n_platform()) {
> +		FILE *fp;
> +		size_t n;
> +		char *line;
Need n = 0 and *line = NULL here as getline() will require if it has to
allocate.

Anyway I will update the patchset and post after test.

Thanks,
Srinivas
> +		int ret = 1;
> +
> +		fp = fopen("/proc/cpuinfo", "r");
> +		if (!fp)
> +			err(-1, "cannot open /proc/cpuinfo\n");
> +
> +		while (getline(&line, &n, fp) > 0) {
> +			if (strstr(line, "model name")) {
> +				if (strstr(line, "6252N") ||
> +				    strstr(line, "6230N") ||
> +				    strstr(line, "5218N"))
> +					ret = 0;
> +				break;
> +			}
> +		}
> +		free(line);
> +		fclose(fp);
> +		return ret;
> +	}
> +	return 0;
>  }
>  
>  /* Open a file, and exit on failure */
> @@ -1889,7 +1927,9 @@ static void cmdline(int argc, char **argv)
>  		fprintf(stderr, "Feature name and|or command not
> specified\n");
>  		exit(0);
>  	}
> -	update_cpu_model();
> +	ret = update_cpu_model();
> +	if (ret)
> +		err(-1, "Invalid CPU model (%d)\n", cpu_model);
>  	printf("Intel(R) Speed Select Technology\n");
>  	printf("Executing on CPU model:%d[0x%x]\n", cpu_model,
> cpu_model);
>  	set_max_cpu_num();

