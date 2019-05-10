Return-Path: <SRS0=sufd=TK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D5549C04A6B
	for <linux-kernel@archiver.kernel.org>; Fri, 10 May 2019 17:40:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B3B4F217D6
	for <linux-kernel@archiver.kernel.org>; Fri, 10 May 2019 17:40:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727817AbfEJRkH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 10 May 2019 13:40:07 -0400
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:53914 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727144AbfEJRkH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 May 2019 13:40:07 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 8300CA78;
        Fri, 10 May 2019 10:40:06 -0700 (PDT)
Received: from donnerap.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.72.51.249])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 275943F6C4;
        Fri, 10 May 2019 10:40:04 -0700 (PDT)
Date:   Fri, 10 May 2019 18:40:01 +0100
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
Subject: Re: [PATCH v7 10/13] selftests/resctrl: Add vendor detection
 mechanism
Message-ID: <20190510183909.65732a67@donnerap.cambridge.arm.com>
In-Reply-To: <1549767042-95827-11-git-send-email-fenghua.yu@intel.com>
References: <1549767042-95827-1-git-send-email-fenghua.yu@intel.com>
        <1549767042-95827-11-git-send-email-fenghua.yu@intel.com>
Organization: ARM
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; aarch64-unknown-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Message-ID: <20190510174001.INihKPyzUlBV5wl3vi6VTUNhf8NhzmH3J-We1VUt7cw@z>

On Sat,  9 Feb 2019 18:50:39 -0800
Fenghua Yu <fenghua.yu@intel.com> wrote:

Hi,

> From: Babu Moger <babu.moger@amd.com>
> 
> RESCTRL feature is supported both on Intel and AMD now. Some features
> are implemented differently. Add vendor detection mechanism. Use the vendor
> check where there are differences.

I don't think vendor detection is the right approach. The Linux userland
interface should be even architecture agnostic, not to speak of different
vendors.

But even if we need this for some reason ...

> 
> Signed-off-by: Babu Moger <babu.moger@amd.com>
> Signed-off-by: Fenghua Yu <fenghua.yu@intel.com>
> ---
>  tools/testing/selftests/resctrl/resctrl.h       | 13 +++++
>  tools/testing/selftests/resctrl/resctrl_tests.c | 63 +++++++++++++++++++++++++
>  2 files changed, 76 insertions(+)
> 
> diff --git a/tools/testing/selftests/resctrl/resctrl.h b/tools/testing/selftests/resctrl/resctrl.h
> index dadbb3d0cad8..974ec2de5fee 100644
> --- a/tools/testing/selftests/resctrl/resctrl.h
> +++ b/tools/testing/selftests/resctrl/resctrl.h
> @@ -63,10 +63,23 @@ struct resctrl_val_param {
>  
>  };
>  
> +/**
> + * Results of CPUID operation are stored in this structure.
> + * It consists of 4x32bits IA registers: EAX, EBX, ECX and EDX.
> + */
> +struct cpuid_out {
> +	uint32_t eax;
> +	uint32_t ebx;
> +	uint32_t ecx;
> +	uint32_t edx;
> +};
> +
>  pid_t bm_pid, ppid;
>  extern char cbm_mask[256];
>  extern unsigned long long_mask;
>  extern char llc_occup_path[1024];
> +extern int genuine_intel;
> +extern int authentic_amd;

There are more CPU vendors than that ;-)
And to not encourage this kind of vendor specific tests, I'd keep this exposure to a minimum.

In my version I have a simple is_amd() function, to cover the L3 vs. physical pacakges differences.

>  
>  int remount_resctrlfs(bool mum_resctrlfs);
>  int get_resource_id(int cpu_no, int *resource_id);
> diff --git a/tools/testing/selftests/resctrl/resctrl_tests.c b/tools/testing/selftests/resctrl/resctrl_tests.c
> index 3959b2b0671a..1d9adcfbdb4c 100644
> --- a/tools/testing/selftests/resctrl/resctrl_tests.c
> +++ b/tools/testing/selftests/resctrl/resctrl_tests.c
> @@ -14,6 +14,66 @@
>  #define BENCHMARK_ARGS		64
>  #define BENCHMARK_ARG_SIZE	64
>  
> +/**
> + * This variables provides information about the vendor
> + */
> +int genuine_intel;
> +int authentic_amd;
> +
> +void lcpuid(const unsigned int leaf, const unsigned int subleaf,
> +	    struct cpuid_out *out)

There is a much easier way to detect the vendor, without resorting to
(unchecked) inline assembly in userland:
I changed this to scan /proc/cpuinfo for a line starting with vendor_id,
then use the information there. This should work everywhere.
http://linux-arm.org/git?p=linux-ap.git;a=commitdiff;h=ce9c9f3a40e52

Cheers,
Andre

> +{
> +	if (!out)
> +		return;
> +
> +#ifdef __x86_64__
> +	asm volatile("mov %4, %%eax\n\t"
> +		     "mov %5, %%ecx\n\t"
> +		     "cpuid\n\t"
> +		     "mov %%eax, %0\n\t"
> +		     "mov %%ebx, %1\n\t"
> +		     "mov %%ecx, %2\n\t"
> +		     "mov %%edx, %3\n\t"
> +		     : "=g" (out->eax), "=g" (out->ebx), "=g" (out->ecx),
> +		     "=g" (out->edx)
> +		     : "g" (leaf), "g" (subleaf)
> +		     : "%eax", "%ebx", "%ecx", "%edx");
> +#else
> +	asm volatile("push %%ebx\n\t"
> +		     "mov %4, %%eax\n\t"
> +		     "mov %5, %%ecx\n\t"
> +		     "cpuid\n\t"
> +		     "mov %%eax, %0\n\t"
> +		     "mov %%ebx, %1\n\t"
> +		     "mov %%ecx, %2\n\t"
> +		     "mov %%edx, %3\n\t"
> +		     "pop %%ebx\n\t"
> +		     : "=g" (out->eax), "=g" (out->ebx), "=g" (out->ecx),
> +		     "=g" (out->edx)
> +		     : "g" (leaf), "g" (subleaf)
> +		     : "%eax", "%ecx", "%edx");
> +#endif
> +}
> +
> +int detect_vendor(void)
> +{
> +	struct cpuid_out vendor;
> +	int ret = 0;
> +
> +	lcpuid(0x0, 0x0, &vendor);
> +	if (vendor.ebx == 0x756e6547 && vendor.edx == 0x49656e69 &&
> +	    vendor.ecx == 0x6c65746e) {
> +		genuine_intel = 1;
> +	} else if (vendor.ebx == 0x68747541 && vendor.edx == 0x69746E65 &&
> +		   vendor.ecx ==   0x444D4163) {
> +		authentic_amd = 1;
> +	} else {
> +		ret = -EFAULT;
> +	}
> +
> +	return ret;
> +}
> +
>  static void cmd_help(void)
>  {
>  	printf("usage: resctrl_tests [-h] [-b \"benchmark_cmd [options]\"] [-t test list] [-n no_of_bits]\n");
> @@ -110,6 +170,9 @@ int main(int argc, char **argv)
>  		return errno;
>  	}
>  
> +	/* Detect vendor */
> +	detect_vendor();
> +
>  	if (has_ben) {
>  		/* Extract benchmark command from command line. */
>  		for (i = ben_ind; i < argc; i++) {

