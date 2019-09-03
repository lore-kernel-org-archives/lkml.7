Return-Path: <SRS0=TDKO=W6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_2 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DBD88C3A5A2
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Sep 2019 22:18:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B570621883
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Sep 2019 22:18:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727138AbfICWSp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Sep 2019 18:18:45 -0400
Received: from mga14.intel.com ([192.55.52.115]:59833 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726090AbfICWSo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Sep 2019 18:18:44 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga103.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 03 Sep 2019 15:18:43 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,464,1559545200"; 
   d="scan'208";a="189964151"
Received: from spandruv-desk.jf.intel.com ([10.54.75.31])
  by FMSMGA003.fm.intel.com with ESMTP; 03 Sep 2019 15:18:43 -0700
Message-ID: <1da2a58548277dfd8086be02b8467cc903ed7932.camel@linux.intel.com>
Subject: Re: [PATCH 8/8] tools/power/x86/intel-speed-select: Output
 success/failed for command output
From:   Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
To:     Prarit Bhargava <prarit@redhat.com>,
        platform-driver-x86@vger.kernel.org
Cc:     David Arcari <darcari@redhat.com>, linux-kernel@vger.kernel.org
Date:   Tue, 03 Sep 2019 15:18:43 -0700
In-Reply-To: <20190903153734.11904-9-prarit@redhat.com>
References: <20190903153734.11904-1-prarit@redhat.com>
         <20190903153734.11904-9-prarit@redhat.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5 (3.28.5-3.fc28) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2019-09-03 at 11:37 -0400, Prarit Bhargava wrote:
> Command output has confusing data, returning "0" on success.  For
> example
> 
> > # ./intel-speed-select -c 14 turbo-freq enable
> 
> Intel(R) Speed Select Technology
> Executing on CPU model:106[0x6a]
>  package-1
>    die-0
>      cpu-14
>        turbo-freq
>          enable:0
> 
> To avoid confusion change the command output to 'success' or
> 'failed'.
We need to fix also help in the function usage() to match new
implementation

"        printf("\t\t\tFor Set commands, status is 0 for success and
rest for failures\n");
"

Thanks,
Srinivas

> Signed-off-by: Prarit Bhargava <prarit@redhat.com>
> Cc: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
> Cc: David Arcari <darcari@redhat.com>
> Cc: linux-kernel@vger.kernel.org
> ---
>  tools/power/x86/intel-speed-select/isst-display.c | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
> 
> diff --git a/tools/power/x86/intel-speed-select/isst-display.c
> b/tools/power/x86/intel-speed-select/isst-display.c
> index 890a01bfee4b..8500cf2997a6 100644
> --- a/tools/power/x86/intel-speed-select/isst-display.c
> +++ b/tools/power/x86/intel-speed-select/isst-display.c
> @@ -519,7 +519,10 @@ void isst_display_result(int cpu, FILE *outf,
> char *feature, char *cmd,
>  	snprintf(header, sizeof(header), "%s", feature);
>  	format_and_print(outf, 4, header, NULL);
>  	snprintf(header, sizeof(header), "%s", cmd);
> -	snprintf(value, sizeof(value), "%d", result);
> +	if (!result)
> +		snprintf(value, sizeof(value), "success");
> +	else
> +		snprintf(value, sizeof(value), "failed(error %d)",
> result);
>  	format_and_print(outf, 5, header, value);
>  
>  	format_and_print(outf, 1, NULL, NULL);

