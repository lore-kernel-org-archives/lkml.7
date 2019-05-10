Return-Path: <SRS0=sufd=TK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C2FDC04AB2
	for <linux-kernel@archiver.kernel.org>; Fri, 10 May 2019 17:40:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4AB3E217D6
	for <linux-kernel@archiver.kernel.org>; Fri, 10 May 2019 17:40:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727915AbfEJRkS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 10 May 2019 13:40:18 -0400
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:53936 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727825AbfEJRkR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 May 2019 13:40:17 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 40116A78;
        Fri, 10 May 2019 10:40:17 -0700 (PDT)
Received: from donnerap.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.72.51.249])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id CC17A3F6C4;
        Fri, 10 May 2019 10:40:14 -0700 (PDT)
Date:   Fri, 10 May 2019 18:40:11 +0100
From:   Andre Przywara <andre.przywara@arm.com>
To:     Fenghua Yu <fenghua.yu@intel.com>
Cc:     "Thomas Gleixner" <tglx@linutronix.de>,
        "Ingo Molnar" <mingo@redhat.com>, "Borislav Petkov" <bp@alien8.de>,
        "H Peter Anvin" <hpa@zytor.com>, "Tony Luck" <tony.luck@intel.com>,
        "Reinette Chatre" <reinette.chatre@intel.com>,
        "Ravi V Shankar" <ravi.v.shankar@intel.com>,
        "Xiaochen Shen" <xiaochen.shen@intel.com>,
        "Arshiya Hayatkhan Pathan" <arshiya.hayatkhan.pathan@intel.com>,
        "Sai Praneeth Prakhya" <sai.praneeth.prakhya@intel.com>,
        "Babu Moger" <babu.moger@amd.com>,
        "linux-kernel" <linux-kernel@vger.kernel.org>,
        James Morse <James.Morse@arm.com>
Subject: Re: [PATCH v7 12/13] selftests/resctrl: Disable MBA and MBM tests
 for AMD
Message-ID: <20190510184011.210794fc@donnerap.cambridge.arm.com>
In-Reply-To: <1549767042-95827-13-git-send-email-fenghua.yu@intel.com>
References: <1549767042-95827-1-git-send-email-fenghua.yu@intel.com>
        <1549767042-95827-13-git-send-email-fenghua.yu@intel.com>
Organization: ARM
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; aarch64-unknown-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat,  9 Feb 2019 18:50:41 -0800
Fenghua Yu <fenghua.yu@intel.com> wrote:

Hi,

> From: Babu Moger <babu.moger@amd.com>
> 
> For now, disable MBA and MBM tests for AMD. Deciding test pass/fail
> is not clear right now. We can enable when we have some clarity.

I don't think this is the right way. The availability of features should
be queryable, for instance by looking into /sys/fs/resctrl/info. Checking
for a certain vendor to skip tests just sounds wrong to me, and is
definitely not scalable or future proof.

We should really check the availability of a feature, then skip the whole
subsystem test in resctrl_tests.c.

Cheers,
Andre.

> 
> Signed-off-by: Babu Moger <babu.moger@amd.com>
> Signed-off-by: Fenghua Yu <fenghua.yu@intel.com>
> ---
>  tools/testing/selftests/resctrl/cat_test.c      | 2 +-
>  tools/testing/selftests/resctrl/resctrl_tests.c | 4 ++--
>  2 files changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/tools/testing/selftests/resctrl/cat_test.c b/tools/testing/selftests/resctrl/cat_test.c
> index 1a0f77e4f7bf..264bf2325f9e 100644
> --- a/tools/testing/selftests/resctrl/cat_test.c
> +++ b/tools/testing/selftests/resctrl/cat_test.c
> @@ -69,7 +69,7 @@ static void show_cache_info(unsigned long sum_llc_perf_miss, int no_of_bits,
>  	printf("Allocated cache lines: %lu \t", allocated_cache_lines);
>  	printf("Percent diff=%d \t", abs((int)diff_percent));
>  
> -	if (abs((int)diff_percent) > MAX_DIFF_PERCENT)
> +	if (genuine_intel && (abs((int)diff_percent) > MAX_DIFF_PERCENT))
>  		printf("Failed\n");
>  	else
>  		printf("Passed\n");
> diff --git a/tools/testing/selftests/resctrl/resctrl_tests.c b/tools/testing/selftests/resctrl/resctrl_tests.c
> index 1d9adcfbdb4c..620be40b8c01 100644
> --- a/tools/testing/selftests/resctrl/resctrl_tests.c
> +++ b/tools/testing/selftests/resctrl/resctrl_tests.c
> @@ -197,7 +197,7 @@ int main(int argc, char **argv)
>  	sprintf(bw_report, "reads");
>  	sprintf(bm_type, "fill_buf");
>  
> -	if (mbm_test) {
> +	if (genuine_intel && mbm_test) {
>  		printf("\nMBM BW Change Starting..\n");
>  		if (!has_ben)
>  			sprintf(benchmark_cmd[5], "%s", "mbm");
> @@ -207,7 +207,7 @@ int main(int argc, char **argv)
>  		mbm_test_cleanup();
>  	}
>  
> -	if (mba_test) {
> +	if (genuine_intel && mba_test) {
>  		printf("\nMBA Schemata Change Starting..\n");
>  		if (!has_ben)
>  			sprintf(benchmark_cmd[5], "%s", "mba");

