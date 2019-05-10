Return-Path: <SRS0=sufd=TK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 13E1AC04A6B
	for <linux-kernel@archiver.kernel.org>; Fri, 10 May 2019 17:37:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DD35320882
	for <linux-kernel@archiver.kernel.org>; Fri, 10 May 2019 17:37:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727907AbfEJRhX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 10 May 2019 13:37:23 -0400
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:53736 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727144AbfEJRhW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 May 2019 13:37:22 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 27111A78;
        Fri, 10 May 2019 10:37:22 -0700 (PDT)
Received: from donnerap.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.72.51.249])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id BF3253F6C4;
        Fri, 10 May 2019 10:37:19 -0700 (PDT)
Date:   Fri, 10 May 2019 18:37:16 +0100
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
Subject: Re: [PATCH v7 05/13] selftests/resctrl: Add built in benchmark
Message-ID: <20190510183716.762315c7@donnerap.cambridge.arm.com>
In-Reply-To: <1549767042-95827-6-git-send-email-fenghua.yu@intel.com>
References: <1549767042-95827-1-git-send-email-fenghua.yu@intel.com>
        <1549767042-95827-6-git-send-email-fenghua.yu@intel.com>
Organization: ARM
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; aarch64-unknown-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat,  9 Feb 2019 18:50:34 -0800
Fenghua Yu <fenghua.yu@intel.com> wrote:

Hi,

> From: Sai Praneeth Prakhya <sai.praneeth.prakhya@intel.com>
> 
> Built-in benchmark fill_buf generates stressful memory bandwidth
> and cache traffic.
> 
> Later it will be used as a default benchmark by various resctrl tests
> such as MBA (Memory Bandwidth Allocation) and MBM (Memory Bandwidth
> Monitoring) tests.
> 
> Signed-off-by: Sai Praneeth Prakhya <sai.praneeth.prakhya@intel.com>
> Signed-off-by: Arshiya Hayatkhan Pathan <arshiya.hayatkhan.pathan@intel.com>
> Signed-off-by: Fenghua Yu <fenghua.yu@intel.com>
> Signed-off-by: Babu Moger <babu.moger@amd.com>
> ---
>  tools/testing/selftests/resctrl/fill_buf.c | 204 +++++++++++++++++++++++++++++
>  1 file changed, 204 insertions(+)
>  create mode 100644 tools/testing/selftests/resctrl/fill_buf.c
> 
> diff --git a/tools/testing/selftests/resctrl/fill_buf.c b/tools/testing/selftests/resctrl/fill_buf.c
> new file mode 100644
> index 000000000000..792a5c40a32a
> --- /dev/null
> +++ b/tools/testing/selftests/resctrl/fill_buf.c
> @@ -0,0 +1,204 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * fill_buf benchmark
> + *
> + * Copyright (C) 2018 Intel Corporation
> + *
> + * Authors:
> + *    Arshiya Hayatkhan Pathan <arshiya.hayatkhan.pathan@intel.com>
> + *    Sai Praneeth Prakhya <sai.praneeth.prakhya@intel.com>,
> + *    Fenghua Yu <fenghua.yu@intel.com>
> + */
> +#include <stdio.h>
> +#include <unistd.h>
> +#include <stdlib.h>
> +#include <sys/types.h>
> +#include <sys/wait.h>
> +#include <inttypes.h>
> +#include <malloc.h>
> +#include <string.h>
> +
> +#include "resctrl.h"
> +
> +#define CL_SIZE			(64)
> +#define PAGE_SIZE		(4 * 1024)

This is not really true everywhere. I have definitely seen systems with
cache line sizes of 32 and 128 bytes, also arm64 supports 64KB pages.
There should be POSIX/glibc functions to read those values at runtime.

> +#define MB			(1024 * 1024)
> +
> +static unsigned char *startptr;
> +
> +static void sb(void)
> +{
> +	asm volatile("sfence\n\t"
> +		     : : : "memory");

Please don't have inline x86 assembly without protecting this code on other architectures.
#if defined(__i386) || defined(__x86_64)
does the trick for me.
But aren't there already defined function for those barriers somewhere?

> +}
> +
> +static void ctrl_handler(int signo)
> +{
> +	free(startptr);
> +	printf("\nEnding\n");
> +	sb();
> +	exit(EXIT_SUCCESS);
> +}
> +
> +static void cl_flush(void *p)
> +{
> +	asm volatile("clflush (%0)\n\t"
> +		     : : "r"(p) : "memory");

Same comment about the usage of inline assembly here. This breaks compilation on arm/arm64.
In general I am a bit suspicious about using this instruction in a benchmark here, since we have no guarantee that it has an effect on the performance. The CPU could speculatively fetch in data right after this instruction. Shouldn't we iterate multiple times over the benchmark and let the average remove the effect of a hot or cold caches?

Cheers,
Andre.

> +}
> +
> +static void mem_flush(void *p, size_t s)
> +{
> +	char *cp = (char *)p;
> +	size_t i = 0;
> +
> +	s = s / CL_SIZE; /* mem size in cache llines */
> +
> +	for (i = 0; i < s; i++)
> +		cl_flush(&cp[i * CL_SIZE]);
> +
> +	sb();
> +}
> +
> +static void *malloc_and_init_memory(size_t s)
> +{
> +	uint64_t *p64;
> +	size_t s64;
> +
> +	void *p = memalign(PAGE_SIZE, s);
> +
> +	p64 = (uint64_t *)p;
> +	s64 = s / sizeof(uint64_t);
> +
> +	while (s64 > 0) {
> +		*p64 = (uint64_t)rand();
> +		p64 += (CL_SIZE / sizeof(uint64_t));
> +		s64 -= (CL_SIZE / sizeof(uint64_t));
> +	}
> +
> +	return p;
> +}
> +
> +static int fill_one_span_read(unsigned char *start_ptr, unsigned char *end_ptr)
> +{
> +	unsigned char sum, *p;
> +
> +	sum = 0;
> +	p = start_ptr;
> +	while (p < end_ptr) {
> +		sum += *p;
> +		p += (CL_SIZE / 2);
> +	}
> +
> +	return sum;
> +}
> +
> +static
> +void fill_one_span_write(unsigned char *start_ptr, unsigned char *end_ptr)
> +{
> +	unsigned char *p;
> +
> +	p = start_ptr;
> +	while (p < end_ptr) {
> +		*p = '1';
> +		p += (CL_SIZE / 2);
> +	}
> +}
> +
> +static int fill_cache_read(unsigned char *start_ptr, unsigned char *end_ptr,
> +			   char *resctrl_val)
> +{
> +	int ret = 0;
> +	FILE *fp;
> +
> +	while (1)
> +		ret = fill_one_span_read(start_ptr, end_ptr);
> +
> +	/* Consume read result so that reading memory is not optimized out. */
> +	fp = fopen("/dev/null", "w");
> +	if (!fp)
> +		perror("Unable to write to /dev/null");
> +	fprintf(fp, "Sum: %d ", ret);
> +	fclose(fp);
> +
> +	return 0;
> +}
> +
> +static int fill_cache_write(unsigned char *start_ptr, unsigned char *end_ptr,
> +			    char *resctrl_val)
> +{
> +	while (1)
> +		fill_one_span_write(start_ptr, end_ptr);
> +
> +	return 0;
> +}
> +
> +static int
> +fill_cache(unsigned long long buf_size, int malloc_and_init, int memflush,
> +	   int op, char *resctrl_val)
> +{
> +	unsigned char *start_ptr, *end_ptr;
> +	unsigned long long i;
> +	int ret;
> +
> +	if (malloc_and_init)
> +		start_ptr = malloc_and_init_memory(buf_size);
> +	else
> +		start_ptr = malloc(buf_size);
> +
> +	if (!start_ptr)
> +		return -1;
> +
> +	startptr = start_ptr;
> +	end_ptr = start_ptr + buf_size;
> +
> +	/*
> +	 * It's better to touch the memory once to avoid any compiler
> +	 * optimizations
> +	 */
> +	if (!malloc_and_init) {
> +		for (i = 0; i < buf_size; i++)
> +			*start_ptr++ = (unsigned char)rand();
> +	}
> +
> +	start_ptr = startptr;
> +
> +	/* Flush the memory before using to avoid "cache hot pages" effect */
> +	if (memflush)
> +		mem_flush(start_ptr, buf_size);
> +
> +	if (op == 0)
> +		ret = fill_cache_read(start_ptr, end_ptr, resctrl_val);
> +	else
> +		ret = fill_cache_write(start_ptr, end_ptr, resctrl_val);
> +
> +	if (ret) {
> +		printf("\n Errror in fill cache read/write...\n");
> +		return -1;
> +	}
> +
> +	free(startptr);
> +
> +	return 0;
> +}
> +
> +int run_fill_buf(unsigned long span, int malloc_and_init_memory,
> +		 int memflush, int op, char *resctrl_val)
> +{
> +	unsigned long long cache_size = span;
> +	int ret;
> +
> +	/* set up ctrl-c handler */
> +	if (signal(SIGINT, ctrl_handler) == SIG_ERR)
> +		printf("Failed to catch SIGINT!\n");
> +	if (signal(SIGHUP, ctrl_handler) == SIG_ERR)
> +		printf("Failed to catch SIGHUP!\n");
> +
> +	ret = fill_cache(cache_size, malloc_and_init_memory, memflush, op,
> +			 resctrl_val);
> +	if (ret) {
> +		printf("\n Errror in fill cache\n");
> +		return -1;
> +	}
> +
> +	return 0;
> +}

