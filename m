Return-Path: <SRS0=sufd=TK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EFFA9C04A6B
	for <linux-kernel@archiver.kernel.org>; Fri, 10 May 2019 17:37:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B6210217D6
	for <linux-kernel@archiver.kernel.org>; Fri, 10 May 2019 17:37:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728011AbfEJRhg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 10 May 2019 13:37:36 -0400
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:53768 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727144AbfEJRhf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 May 2019 13:37:35 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id E1BA6A78;
        Fri, 10 May 2019 10:37:34 -0700 (PDT)
Received: from donnerap.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.72.51.249])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 8555B3F6C4;
        Fri, 10 May 2019 10:37:32 -0700 (PDT)
Date:   Fri, 10 May 2019 18:37:29 +0100
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
Subject: Re: [PATCH v7 06/13] selftests/resctrl: Add MBM test
Message-ID: <20190510183729.70936033@donnerap.cambridge.arm.com>
In-Reply-To: <1549767042-95827-7-git-send-email-fenghua.yu@intel.com>
References: <1549767042-95827-1-git-send-email-fenghua.yu@intel.com>
        <1549767042-95827-7-git-send-email-fenghua.yu@intel.com>
Organization: ARM
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; aarch64-unknown-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat,  9 Feb 2019 18:50:35 -0800
Fenghua Yu <fenghua.yu@intel.com> wrote:

Hi,

> From: Arshiya Hayatkhan Pathan <arshiya.hayatkhan.pathan@intel.com>
> 
> MBM (Memory Bandwidth Monitoring) test is the first implemented selftest.
> It starts a stressful memory bandwidth benchmark and assigns the
> bandwidth pid in a resctrl monitoring group. Read and compare perf IMC
> counter and MBM total bytes for the benchmark. The numbers should be
> close enough to pass the test.
> 
> Default benchmark is built-in fill_buf. But users can specify their
> own benchmark by option "-b".
> 
> We can add memory bandwidth monitoring for multiple processes in the
> future.
> 
> Signed-off-by: Arshiya Hayatkhan Pathan <arshiya.hayatkhan.pathan@intel.com>
> Signed-off-by: Sai Praneeth Prakhya <sai.praneeth.prakhya@intel.com>,
> Signed-off-by: Fenghua Yu <fenghua.yu@intel.com>
> Signed-off-by: Babu Moger <babu.moger@amd.com>
> ---
>  tools/testing/selftests/resctrl/Makefile        |   8 +-
>  tools/testing/selftests/resctrl/mbm_test.c      | 149 ++++++++++++++++++++++++
>  tools/testing/selftests/resctrl/resctrl.h       |   3 +
>  tools/testing/selftests/resctrl/resctrl_tests.c | 114 ++++++++++++++++++
>  tools/testing/selftests/resctrl/resctrl_val.c   |   2 +
>  5 files changed, 275 insertions(+), 1 deletion(-)
>  create mode 100644 tools/testing/selftests/resctrl/mbm_test.c
>  create mode 100644 tools/testing/selftests/resctrl/resctrl_tests.c
> 
> diff --git a/tools/testing/selftests/resctrl/Makefile b/tools/testing/selftests/resctrl/Makefile
> index bd5c5418961e..eaa8b45de10d 100644
> --- a/tools/testing/selftests/resctrl/Makefile
> +++ b/tools/testing/selftests/resctrl/Makefile
> @@ -1,10 +1,16 @@
>  CC = gcc
>  CFLAGS = -g -Wall
>  
> +all: resctrl_tests
> +
>  *.o: *.c
>  	$(CC) $(CFLAGS) -c *.c
>  
> +resctrl_tests: *.o
> +	$(CC) $(CFLAGS) -o resctrl_tests resctrl_tests.o resctrlfs.o \
> +		 resctrl_val.o fill_buf.o mbm_test.o

This is a somewhat non-standard way of specifying things in a Makefile.
What about:

OBJS = resctrl_tests.o resctrlfs.o resctrl_val.o fill_buf.o mbm_test.o
resctrl_tests: $(OBJS)
	$(CC) $(LDFLAGS) -o $@ $^

> +
>  .PHONY: clean
>  
>  clean:
> -	$(RM) *.o *~
> +	$(RM) *.o *~ resctrl_tests
> diff --git a/tools/testing/selftests/resctrl/mbm_test.c b/tools/testing/selftests/resctrl/mbm_test.c
> new file mode 100644
> index 000000000000..dba981c562ff
> --- /dev/null
> +++ b/tools/testing/selftests/resctrl/mbm_test.c
> @@ -0,0 +1,149 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Memory Bandwidth Monitoring (MBM) test
> + *
> + * Copyright (C) 2018 Intel Corporation
> + *
> + * Authors:
> + *    Arshiya Hayatkhan Pathan <arshiya.hayatkhan.pathan@intel.com>
> + *    Sai Praneeth Prakhya <sai.praneeth.prakhya@intel.com>,
> + *    Fenghua Yu <fenghua.yu@intel.com>
> + */
> +#include "resctrl.h"
> +
> +#define RESULT_FILE_NAME	"result_mbm"
> +#define MAX_DIFF		300

What is that value? 300 MB/s? Is that some heuristic? Shouldn't that be
relative, like in the other benchmarks?

> +#define NUM_OF_RUNS		5
> +
> +static void
> +show_bw_info(unsigned long *bw_imc, unsigned long *bw_resc, int span)
> +{
> +	unsigned long avg_bw_imc = 0, avg_bw_resc = 0;

Why do you initialise those if they are overwritten below?

> +	unsigned long sum_bw_imc = 0, sum_bw_resc = 0;
> +	long avg_diff = 0;

Same here.

> +	int runs;
> +
> +	/*
> +	 * Discard the first value which is inaccurate due to monitoring setup
> +	 * transition phase.
> +	 */
> +	for (runs = 1; runs < NUM_OF_RUNS ; runs++) {
> +		sum_bw_imc += bw_imc[runs];
> +		sum_bw_resc += bw_resc[runs];
> +	}
> +
> +	avg_bw_imc = sum_bw_imc / 4;
> +	avg_bw_resc = sum_bw_resc / 4;
> +	avg_diff = avg_bw_resc - avg_bw_imc;

You could make avg_diff unsigned and use the labs() call already here.

Cheers,
Andre.

> +
> +	printf("\nSpan (MB): %d \t", span);
> +	printf("avg_bw_imc: %lu\t", avg_bw_imc);
> +	printf("avg_bw_resc: %lu\t", avg_bw_resc);
> +	printf("avg_diff: %lu\t", labs(avg_diff));
> +
> +	if (labs(avg_diff) > MAX_DIFF)
> +		printf(" failed\n");
> +	else
> +		printf(" passed\n");
> +}
> +
> +static int check_results(int span)
> +{
> +	unsigned long bw_imc[NUM_OF_RUNS], bw_resc[NUM_OF_RUNS];
> +	char temp[1024], *token_array[8];
> +	char output[] = RESULT_FILE_NAME;
> +	int runs;
> +	FILE *fp;
> +
> +	printf("\nChecking for pass/fail\n");
> +
> +	fp = fopen(output, "r");
> +	if (!fp) {
> +		perror("Error in opening file\n");
> +
> +		return errno;
> +	}
> +
> +	runs = 0;
> +	while (fgets(temp, 1024, fp)) {
> +		char *token = strtok(temp, ":\t");
> +		int i = 0;
> +
> +		while (token) {
> +			token_array[i++] = token;
> +			token = strtok(NULL, ":\t");
> +		}
> +
> +		bw_resc[runs] = strtoul(token_array[5], NULL, 0);
> +		bw_imc[runs] = strtoul(token_array[3], NULL, 0);
> +		runs++;
> +	}
> +
> +	show_bw_info(bw_imc, bw_resc, span);
> +
> +	fclose(fp);
> +
> +	return 0;
> +}
> +
> +static int mbm_setup(int num, ...)
> +{
> +	struct resctrl_val_param *p;
> +	static int num_of_runs;
> +	va_list param;
> +	int ret = 0;
> +
> +	/* Run NUM_OF_RUNS times */
> +	if (num_of_runs++ >= NUM_OF_RUNS)
> +		return -1;
> +
> +	va_start(param, num);
> +	p = va_arg(param, struct resctrl_val_param *);
> +	va_end(param);
> +
> +	/* Set up shemata with 100% allocation on the first run. */
> +	if (num_of_runs == 0)
> +		ret = write_schemata(p->ctrlgrp, "100", p->cpu_no,
> +				     p->resctrl_val);
> +
> +	return ret;
> +}
> +
> +void mbm_test_cleanup(void)
> +{
> +	remove(RESULT_FILE_NAME);
> +}
> +
> +int mbm_bw_change(int span, int cpu_no, char *bw_report, char **benchmark_cmd)
> +{
> +	struct resctrl_val_param param = {
> +		.resctrl_val	= "mbm",
> +		.ctrlgrp	= "c1",
> +		.mongrp		= "m1",
> +		.span		= span,
> +		.cpu_no		= cpu_no,
> +		.mum_resctrlfs	= 1,
> +		.filename	= RESULT_FILE_NAME,
> +		.bw_report	=  bw_report,
> +		.setup		= mbm_setup
> +	};
> +	int ret;
> +
> +	remove(RESULT_FILE_NAME);
> +
> +	ret = validate_resctrl_feature_request("mbm");
> +	if (ret)
> +		return ret;
> +
> +	ret = resctrl_val(benchmark_cmd, &param);
> +	if (ret)
> +		return ret;
> +
> +	ret = check_results(span);
> +	if (ret)
> +		return ret;
> +
> +	mbm_test_cleanup();
> +
> +	return 0;
> +}
> diff --git a/tools/testing/selftests/resctrl/resctrl.h b/tools/testing/selftests/resctrl/resctrl.h
> index c286790ba24d..7f7ea180478c 100644
> --- a/tools/testing/selftests/resctrl/resctrl.h
> +++ b/tools/testing/selftests/resctrl/resctrl.h
> @@ -71,5 +71,8 @@ int perf_event_open(struct perf_event_attr *hw_event, pid_t pid, int cpu,
>  int run_fill_buf(unsigned long span, int malloc_and_init_memory, int memflush,
>  		 int op, char *resctrl_va);
>  int resctrl_val(char **benchmark_cmd, struct resctrl_val_param *param);
> +int mbm_bw_change(int span, int cpu_no, char *bw_report, char **benchmark_cmd);
> +void tests_cleanup(void);
> +void mbm_test_cleanup(void);
>  
>  #endif /* RESCTRL_H */
> diff --git a/tools/testing/selftests/resctrl/resctrl_tests.c b/tools/testing/selftests/resctrl/resctrl_tests.c
> new file mode 100644
> index 000000000000..a51780d28ff1
> --- /dev/null
> +++ b/tools/testing/selftests/resctrl/resctrl_tests.c
> @@ -0,0 +1,114 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Resctrl tests
> + *
> + * Copyright (C) 2018 Intel Corporation
> + *
> + * Authors:
> + *    Arshiya Hayatkhan Pathan <arshiya.hayatkhan.pathan@intel.com>
> + *    Sai Praneeth Prakhya <sai.praneeth.prakhya@intel.com>,
> + *    Fenghua Yu <fenghua.yu@intel.com>
> + */
> +#include "resctrl.h"
> +
> +#define BENCHMARK_ARGS		64
> +#define BENCHMARK_ARG_SIZE	64
> +
> +static void cmd_help(void)
> +{
> +	printf("usage: resctrl_tests [-h] [-b \"benchmark_cmd [options]\"] [-t test list]\n");
> +	printf("\t-b benchmark_cmd [options]: run specified benchmark\n");
> +	printf("\t default benchmark is builtin fill_buf\n");
> +	printf("\t-t test list: run tests specified in the test list, ");
> +	printf("e.g. -t mbm,mba\n");
> +	printf("\t-h: help\n");
> +}
> +
> +void tests_cleanup(void)
> +{
> +	mbm_test_cleanup();
> +}
> +
> +int main(int argc, char **argv)
> +{
> +	char benchmark_cmd_area[BENCHMARK_ARGS][BENCHMARK_ARG_SIZE];
> +	int res, c, cpu_no = 1, span = 250, argc_new = argc, i;
> +	int ben_ind;
> +	bool has_ben = false, mbm_test = true;
> +	char *benchmark_cmd[BENCHMARK_ARGS];
> +	char bw_report[64], bm_type[64];
> +
> +	for (i = 0; i < argc; i++) {
> +		if (strcmp(argv[i], "-b") == 0) {
> +			ben_ind = i + 1;
> +			argc_new = ben_ind - 1;
> +			has_ben = 1;
> +			break;
> +		}
> +	}
> +
> +	while ((c = getopt(argc_new, argv, "ht:b:")) != -1) {
> +		char *token;
> +
> +		switch (c) {
> +		case 't':
> +			token = strtok(optarg, ",");
> +
> +			mbm_test = false;
> +			while (token) {
> +				if (!strcmp(token, "mbm")) {
> +					mbm_test = true;
> +				} else {
> +					printf("invalid argument\n");
> +
> +					return -1;
> +				}
> +				token = strtok(NULL, ":\t");
> +			}
> +			break;
> +		case 'h':
> +			cmd_help();
> +
> +			return 0;
> +		default:
> +			printf("invalid argument\n");
> +
> +			return -1;
> +		}
> +	}
> +
> +	/*
> +	 * We need root privileges to run because
> +	 * 1. We write to resctrl FS
> +	 * 2. We execute perf commands
> +	 */
> +	if (geteuid() != 0) {
> +		perror("Please run this program as root\n");
> +
> +		return errno;
> +	}
> +
> +	if (!has_ben) {
> +		/* If no benchmark is given by "-b" argument, use fill_buf. */
> +		for (i = 0; i < 5; i++)
> +			benchmark_cmd[i] = benchmark_cmd_area[i];
> +		strcpy(benchmark_cmd[0], "fill_buf");
> +		sprintf(benchmark_cmd[1], "%d", span);
> +		strcpy(benchmark_cmd[2], "1");
> +		strcpy(benchmark_cmd[3], "1");
> +		strcpy(benchmark_cmd[4], "0");
> +		benchmark_cmd[5] = NULL;
> +	}
> +
> +	sprintf(bw_report, "reads");
> +	sprintf(bm_type, "fill_buf");
> +
> +	if (mbm_test) {
> +		printf("\nMBM BW Change Starting..\n");
> +		res = mbm_bw_change(span, cpu_no, bw_report, benchmark_cmd);
> +		if (res)
> +			printf("Error in running tests for mbm bw change!\n");
> +	}
> +
> +	return 0;
> +}
> diff --git a/tools/testing/selftests/resctrl/resctrl_val.c b/tools/testing/selftests/resctrl/resctrl_val.c
> index 43c15e382892..200a5b6756da 100644
> --- a/tools/testing/selftests/resctrl/resctrl_val.c
> +++ b/tools/testing/selftests/resctrl/resctrl_val.c
> @@ -437,6 +437,8 @@ pid_t bm_pid, ppid;
>  static void ctrlc_handler(int signum, siginfo_t *info, void *ptr)
>  {
>  	kill(bm_pid, SIGKILL);
> +	umount_resctrlfs();
> +	tests_cleanup();
>  	printf("Ending\n\n");
>  
>  	exit(EXIT_SUCCESS);

