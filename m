Return-Path: <SRS0=sufd=TK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7FF2FC04A6B
	for <linux-kernel@archiver.kernel.org>; Fri, 10 May 2019 19:02:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 43632217D7
	for <linux-kernel@archiver.kernel.org>; Fri, 10 May 2019 19:02:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728073AbfEJTCR convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 10 May 2019 15:02:17 -0400
Received: from mga03.intel.com ([134.134.136.65]:51552 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727535AbfEJTCQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 May 2019 15:02:16 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga103.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 10 May 2019 12:00:54 -0700
X-ExtLoop1: 1
Received: from orsmsx107.amr.corp.intel.com ([10.22.240.5])
  by orsmga005.jf.intel.com with ESMTP; 10 May 2019 12:00:54 -0700
Received: from orsmsx106.amr.corp.intel.com ([169.254.1.121]) by
 ORSMSX107.amr.corp.intel.com ([169.254.1.17]) with mapi id 14.03.0415.000;
 Fri, 10 May 2019 12:00:54 -0700
From:   "Yu, Fenghua" <fenghua.yu@intel.com>
To:     Andre Przywara <andre.przywara@arm.com>
CC:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        H Peter Anvin <hpa@zytor.com>,
        "Luck, Tony" <tony.luck@intel.com>,
        "Chatre, Reinette" <reinette.chatre@intel.com>,
        "Shankar, Ravi V" <ravi.v.shankar@intel.com>,
        "Shen, Xiaochen" <xiaochen.shen@intel.com>,
        "Pathan, Arshiya Hayatkhan" <arshiya.hayatkhan.pathan@intel.com>,
        "Prakhya, Sai Praneeth" <sai.praneeth.prakhya@intel.com>,
        Babu Moger <babu.moger@amd.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        James Morse <James.Morse@arm.com>
Subject: RE: [PATCH v7 02/13] selftests/resctrl: Add basic resctrl file
 system operations and data
Thread-Topic: [PATCH v7 02/13] selftests/resctrl: Add basic resctrl file
 system operations and data
Thread-Index: AQHVB1br+BTg+H4QbEWo5NXCJsuddqZktLLA
Date:   Fri, 10 May 2019 19:00:54 +0000
Message-ID: <3E5A0FA7E9CA944F9D5414FEC6C712209D8A3BD7@ORSMSX106.amr.corp.intel.com>
References: <1549767042-95827-1-git-send-email-fenghua.yu@intel.com>
        <1549767042-95827-3-git-send-email-fenghua.yu@intel.com>
 <20190510183624.2c268548@donnerap.cambridge.arm.com>
In-Reply-To: <20190510183624.2c268548@donnerap.cambridge.arm.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
dlp-product: dlpe-windows
dlp-version: 11.0.600.7
dlp-reaction: no-action
x-originating-ip: [10.22.254.140]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> From: Andre Przywara [mailto:andre.przywara@arm.com]
> On Sat,  9 Feb 2019 18:50:31 -0800
> Fenghua Yu <fenghua.yu@intel.com> wrote:
> 
> Hi,
> 
> some comments inline.
> 
> > From: Sai Praneeth Prakhya <sai.praneeth.prakhya@intel.com>
> >
> > The basic resctrl file system operations and data are added for future
> > usage by resctrl selftest tool.
> >
> > Signed-off-by: Sai Praneeth Prakhya <sai.praneeth.prakhya@intel.com>
> > Signed-off-by: Arshiya Hayatkhan Pathan
> > <arshiya.hayatkhan.pathan@intel.com>
> > Signed-off-by: Fenghua Yu <fenghua.yu@intel.com>
> > Signed-off-by: Babu Moger <babu.moger@amd.com>
> > ---
> >  tools/testing/selftests/resctrl/Makefile    |  10 +
> >  tools/testing/selftests/resctrl/resctrl.h   |  48 +++
> >  tools/testing/selftests/resctrl/resctrlfs.c | 464
> > ++++++++++++++++++++++++++++
> >  3 files changed, 522 insertions(+)
> >  create mode 100644 tools/testing/selftests/resctrl/Makefile
> >  create mode 100644 tools/testing/selftests/resctrl/resctrl.h
> >  create mode 100644 tools/testing/selftests/resctrl/resctrlfs.c
> >
> > diff --git a/tools/testing/selftests/resctrl/Makefile
> > b/tools/testing/selftests/resctrl/Makefile
> > new file mode 100644
> > index 000000000000..bd5c5418961e
> > --- /dev/null
> > +++ b/tools/testing/selftests/resctrl/Makefile
> > @@ -0,0 +1,10 @@
> > +CC = gcc
> 
> Changing this to
> CC = $(CROSS_COMPILE)gcc
> make this cross compileable.
> 
> > +CFLAGS = -g -Wall
> 
> Can we add -O here? For once -O0 generates horrible code, but also -O
> tends to catch more bugs.
Sure.

> 
> > +
> > +*.o: *.c
> > +	$(CC) $(CFLAGS) -c *.c
> 
> This is a built-in rule in make, so you can remove it here:
> https://www.gnu.org/software/make/manual/html_node/Catalogue-of-
> Rules.html#Catalogue-of-Rules
Will do.

> 
> > +
> > +.PHONY: clean
> > +
> > +clean:
> > +	$(RM) *.o *~
> > diff --git a/tools/testing/selftests/resctrl/resctrl.h
> > b/tools/testing/selftests/resctrl/resctrl.h
> > new file mode 100644
> > index 000000000000..2e112934d48a
> > --- /dev/null
> > +++ b/tools/testing/selftests/resctrl/resctrl.h
> > @@ -0,0 +1,48 @@
> > +/* SPDX-License-Identifier: GPL-2.0 */ #define _GNU_SOURCE #ifndef
> > +RESCTRL_H #define RESCTRL_H #include <stdio.h> #include <errno.h>
> > +#include <sched.h> #include <stdlib.h> #include <unistd.h> #include
> > +<string.h> #include <signal.h> #include <dirent.h> #include
> > +<stdbool.h> #include <sys/stat.h> #include <sys/ioctl.h> #include
> > +<sys/mount.h> #include <sys/types.h> #include <asm/unistd.h> #include
> > +<linux/perf_event.h>
> > +
> > +#define RESCTRL_PATH		"/sys/fs/resctrl"
> > +#define PHYS_ID_PATH		"/sys/devices/system/cpu/cpu"
> > +
> > +#define PARENT_EXIT(err_msg)			\
> > +	do {					\
> > +		perror(err_msg);		\
> > +		kill(ppid, SIGKILL);		\
> > +		exit(EXIT_FAILURE);		\
> > +	} while (0)
> > +
> > +pid_t bm_pid, ppid;
> > +
> > +int remount_resctrlfs(bool mum_resctrlfs); int get_resource_id(int
> > +cpu_no, int *resource_id); int validate_bw_report_request(char
> > +*bw_report); int validate_resctrl_feature_request(char *resctrl_val);
> > +int taskset_benchmark(pid_t bm_pid, int cpu_no); void
> > +run_benchmark(int signum, siginfo_t *info, void *ucontext); int
> > +write_schemata(char *ctrlgrp, char *schemata, int cpu_no,
> > +		   char *resctrl_val);
> > +int write_bm_pid_to_resctrl(pid_t bm_pid, char *ctrlgrp, char *mongrp,
> > +			    char *resctrl_val);
> > +int perf_event_open(struct perf_event_attr *hw_event, pid_t pid, int
> cpu,
> > +		    int group_fd, unsigned long flags); int
> run_fill_buf(unsigned
> > +long span, int malloc_and_init_memory, int memflush,
> > +		 int op, char *resctrl_va);
> > +
> > +#endif /* RESCTRL_H */
> > diff --git a/tools/testing/selftests/resctrl/resctrlfs.c
> > b/tools/testing/selftests/resctrl/resctrlfs.c
> > new file mode 100644
> > index 000000000000..5afcaa89f418
> > --- /dev/null
> > +++ b/tools/testing/selftests/resctrl/resctrlfs.c
> > @@ -0,0 +1,464 @@
> > +// SPDX-License-Identifier: GPL-2.0
> > +/*
> > + * Basic resctrl file system operations
> > + *
> > + * Copyright (C) 2018 Intel Corporation
> > + *
> > + * Authors:
> > + *    Arshiya Hayatkhan Pathan <arshiya.hayatkhan.pathan@intel.com>
> > + *    Sai Praneeth Prakhya <sai.praneeth.prakhya@intel.com>,
> > + *    Fenghua Yu <fenghua.yu@intel.com>
> > + */
> > +#include "resctrl.h"
> > +
> > +#define RESCTRL_MBM		"L3 monitoring detected"
> > +#define RESCTRL_MBA		"MB allocation detected"
> > +enum {
> > +	RESCTRL_FEATURE_MBM,
> > +	RESCTRL_FEATURE_MBA,
> > +	MAX_RESCTRL_FEATURES
> > +};
> > +
> > +/*
> > + * remount_resctrlfs - Remount resctrl FS at /sys/fs/resctrl
> > + * @mum_resctrlfs:	Should the resctrl FS be remounted?
> > + *
> > + * If not mounted, mount it.
> > + * If mounted and mum_resctrlfs then remount resctrl FS.
> > + * If mounted and !mum_resctrlfs then noop
> > + *
> > + * Return: 0 on success, non-zero on failure  */ int
> > +remount_resctrlfs(bool mum_resctrlfs) {
> > +	DIR *dp;
> > +	struct dirent *ep;
> > +	unsigned int count = 0;
> > +
> > +	/*
> > +	 * If kernel is built with CONFIG_RESCTRL, then /sys/fs/resctrl should
> > +	 * be present by default
> > +	 */
> > +	dp = opendir(RESCTRL_PATH);
> > +	if (dp) {
> > +		while ((ep = readdir(dp)) != NULL)
> > +			count++;
> > +		closedir(dp);
> > +	} else {
> > +		perror("Unable to read /sys/fs/resctrl");
> > +
> > +		return -1;
> > +	}
> > +
> > +	/*
> > +	 * If resctrl FS has more than two entries, it means that resctrl FS
> has
> > +	 * already been mounted. The two default entries are "." and "..",
> these
> > +	 * are present even when resctrl FS is not mounted
> > +	 */
> > +	if (count > 2) {
> > +		if (mum_resctrlfs) {
> > +			if (umount(RESCTRL_PATH) != 0) {
> > +				perror("Unable to umount resctrl");
> > +
> > +				return errno;
> > +			}
> > +			printf("Remount: done!\n");
> > +		} else {
> > +			printf("Mounted already. Not remounting!\n");
> > +
> > +			return 0;
> > +		}
> > +	}
> > +
> > +	if (mount("resctrl", RESCTRL_PATH, "resctrl", 0, NULL) != 0) {
> 
> Don't we need to consider mount options at some point? According to
> Documentation/x86/resctrl_ui.txt there is cdp, cdpl2 and mba_MBps, which
> we need to set to get certain features.

As said in the cover patch, there more tests in the future to cover cdp, mba, etc.
We will use mount options in those future tests.

It's good to mount without any parameter for the tests in the current patch set.

> 
> > +		perror("Unable to mount resctrl FS at /sys/fs/resctrl");
> > +
> > +		return errno;
> > +	}
> > +
> > +	return 0;
> > +}
> > +
> > +int umount_resctrlfs(void)
> > +{
> > +	if (umount(RESCTRL_PATH)) {
> > +		perror("Unable to umount resctrl");
> > +
> > +		return errno;
> > +	}
> > +
> > +	return 0;
> > +}
> > +
> > +/*
> > + * get_resource_id - Get socket number/l3 id for a specified CPU
> > + * @cpu_no:	CPU number
> > + * @resource_id: Socket number or l3_id
> > + *
> > + * Return: >= 0 on success, < 0 on failure.
> > + */
> > +int get_resource_id(int cpu_no, int *resource_id) {
> > +	char phys_pkg_path[1024];
> > +	FILE *fp;
> > +
> > +	sprintf(phys_pkg_path, "%s%d/topology/physical_package_id",
> > +		PHYS_ID_PATH, cpu_no);
> > +	fp = fopen(phys_pkg_path, "r");
> > +	if (!fp) {
> > +		perror("Failed to open physical_package_id");
> > +
> > +		return -1;
> > +	}
> > +	if (fscanf(fp, "%d", resource_id) <= 0) {
> > +		perror("Could not get socket number or l3 id");
> > +		fclose(fp);
> > +
> > +		return -1;
> > +	}
> > +	fclose(fp);
> > +
> > +	return 0;
> > +}
> > +
> > +/*
> > + * taskset_benchmark - Taskset PID (i.e. benchmark) to a specified cpu
> > + * @bm_pid:	PID that should be binded
> > + * @cpu_no:	CPU number at which the PID would be binded
> > + *
> > + * Return: 0 on success, non-zero on failure  */ int
> > +taskset_benchmark(pid_t bm_pid, int cpu_no) {
> > +	cpu_set_t my_set;
> > +
> > +	CPU_ZERO(&my_set);
> > +	CPU_SET(cpu_no, &my_set);
> > +
> > +	if (sched_setaffinity(bm_pid, sizeof(cpu_set_t), &my_set)) {
> > +		perror("Unable to taskset benchmark");
> > +
> > +		return -1;
> > +	}
> > +
> > +	printf("Taskset benchmark: done!\n");
> > +
> > +	return 0;
> > +}
> > +
> > +/*
> > + * run_benchmark - Run a specified benchmark or fill_buf (default
> benchmark)
> > + *		   in specified signal. Direct benchmark stdio to /dev/null.
> > + * @signum:	signal number
> > + * @info:	signal info
> > + * @ucontext:	user context in signal handling
> > + *
> > + * Return: void
> > + */
> > +void run_benchmark(int signum, siginfo_t *info, void *ucontext) {
> > +	unsigned long long span;
> > +	int operation, ret;
> > +	char **benchmark_cmd;
> > +	FILE *fp;
> > +
> > +	benchmark_cmd = info->si_ptr;
> > +
> > +	/*
> > +	 * Direct stdio of child to /dev/null, so that only parent writes to
> > +	 * stdio (console)
> > +	 */
> > +	fp = freopen("/dev/null", "w", stdout);
> > +	if (!fp)
> > +		PARENT_EXIT("Unable to direct benchmark status to
> /dev/null");
> > +
> > +	if (strcmp(benchmark_cmd[0], "fill_buf") == 0) {
> > +		/* Execute default fill_buf benchmark */
> > +		span = strtoul(benchmark_cmd[1], NULL, 10);
> > +		operation = atoi(benchmark_cmd[4]);
> > +		if (run_fill_buf(span, 1, 1, operation, NULL))
> > +			fprintf(stderr, "Error in running fill buffer\n");
> > +	} else {
> > +		/* Execute specified benchmark */
> > +		ret = execvp(benchmark_cmd[0], benchmark_cmd);
> > +		if (ret)
> > +			perror("wrong\n");
> > +	}
> > +
> > +	fclose(stdout);
> > +	PARENT_EXIT("Unable to run specified benchmark"); }
> > +
> > +/*
> > + * create_grp - Create a group only if one doesn't exist
> > + * @grp_name:	Name of the group
> > + * @grp:	Full path and name of the group
> > + * @parent_grp:	Full path and name of the parent group
> > + *
> > + * Return: 0 on success, non-zero on failure  */ static int
> > +create_grp(const char *grp_name, char *grp, const char *parent_grp) {
> > +	int found_grp = 0;
> > +	struct dirent *ep;
> > +	DIR *dp;
> > +
> > +	/* Check if requested grp exists or not */
> > +	dp = opendir(parent_grp);
> > +	if (dp) {
> > +		while ((ep = readdir(dp)) != NULL) {
> > +			if (strcmp(ep->d_name, grp_name) == 0)
> > +				found_grp = 1;
> > +		}
> > +		closedir(dp);
> > +	} else {
> > +		perror("Unable to open resctrl for group");
> > +
> > +		return -1;
> > +	}
> > +
> > +	/* Requested grp doesn't exist, hence create it */
> > +	if (found_grp == 0) {
> > +		if (mkdir(grp, 0) == -1) {
> > +			perror("Unable to create group");
> > +
> > +			return -1;
> > +		}
> > +	}
> > +
> > +	return 0;
> > +}
> > +
> > +static int write_pid_to_tasks(char *tasks, pid_t pid) {
> > +	FILE *fp;
> > +
> > +	fp = fopen(tasks, "w");
> > +	if (!fp) {
> > +		perror("Failed to open tasks file");
> > +
> > +		return -1;
> > +	}
> > +	if (fprintf(fp, "%d\n", pid) < 0) {
> > +		perror("Failed to wr pid to tasks file");
> > +		fclose(fp);
> > +
> > +		return -1;
> > +	}
> > +	fclose(fp);
> > +
> > +	return 0;
> > +}
> > +
> > +/*
> > + * write_bm_pid_to_resctrl - Write a PID (i.e. benchmark) to resctrl FS
> > + * @bm_pid:		PID that should be written
> > + * @ctrlgrp:		Name of the control monitor group (con_mon grp)
> > + * @mongrp:		Name of the monitor group (mon grp)
> > + * @resctrl_val:	Resctrl feature (Eg: mbm, mba.. etc)
> > + *
> > + * If a con_mon grp is requested, create it and write pid to it,
> > +otherwise
> > + * write pid to root con_mon grp.
> > + * If a mon grp is requested, create it and write pid to it,
> > +otherwise
> > + * pid is not written, this means that pid is in con_mon grp and
> > +hence
> > + * should consult con_mon grp's mon_data directory for results.
> > + *
> > + * Return: 0 on success, non-zero on failure  */ int
> > +write_bm_pid_to_resctrl(pid_t bm_pid, char *ctrlgrp, char *mongrp,
> > +			    char *resctrl_val)
> > +{
> > +	char controlgroup[256], monitorgroup[256], monitorgroup_p[256];
> > +	char tasks[256];
> > +	int ret;
> > +
> > +	if (ctrlgrp)
> > +		sprintf(controlgroup, "%s/%s", RESCTRL_PATH, ctrlgrp);
> > +	else
> > +		sprintf(controlgroup, "%s", RESCTRL_PATH);
> > +
> > +	/* Create control and monitoring group and write pid into it */
> > +	ret = create_grp(ctrlgrp, controlgroup, RESCTRL_PATH);
> > +	if (ret)
> > +		return ret;
> > +	sprintf(tasks, "%s/tasks", controlgroup);
> > +	ret = write_pid_to_tasks(tasks, bm_pid);
> > +	if (ret)
> > +		return ret;
> > +
> > +	/* Create mon grp and write pid into it for "mbm" test */
> > +	if ((strcmp(resctrl_val, "mbm") == 0)) {
> > +		if (mongrp) {
> > +			sprintf(monitorgroup_p, "%s/mon_groups",
> controlgroup);
> > +			sprintf(monitorgroup, "%s/%s", monitorgroup_p,
> mongrp);
> > +			ret = create_grp(mongrp, monitorgroup,
> monitorgroup_p);
> > +			if (ret)
> > +				return ret;
> > +
> > +			sprintf(tasks, "%s/mon_groups/%s/tasks",
> > +				controlgroup, mongrp);
> > +			ret = write_pid_to_tasks(tasks, bm_pid);
> > +			if (ret)
> > +				return ret;
> > +		}
> > +	}
> > +
> > +	printf("Write benchmark to resctrl FS: done!\n");
> > +
> > +	return 0;
> > +}
> > +
> > +/*
> > + * write_schemata - Update schemata of a con_mon grp
> > + * @ctrlgrp:		Name of the con_mon grp
> > + * @schemata:		Schemata that should be updated to
> > + * @cpu_no:		CPU number that the benchmark PID is
> binded to
> > + * @resctrl_val:	Resctrl feature (Eg: mbm, mba.. etc)
> > + *
> > + * Update schemata of a con_mon grp *only* if requested resctrl
> > +feature is
> > + * allocation type
> > + *
> > + * Return: 0 on success, non-zero on failure  */ int
> > +write_schemata(char *ctrlgrp, char *schemata, int cpu_no, char
> > +*resctrl_val) {
> > +	char controlgroup[1024], schema[1024];
> > +	int resource_id;
> > +	FILE *fp;
> > +
> > +	if (strcmp(resctrl_val, "mba") == 0) {
> > +		if (!schemata) {
> > +			printf("Schemata empty, so not updating\n");
> > +
> > +			return 0;
> > +		}
> > +		if (get_resource_id(cpu_no, &resource_id) < 0) {
> > +			perror("Failed to get resource id");
> > +			return -1;
> > +		}
> > +
> > +		if (ctrlgrp)
> > +			sprintf(controlgroup, "%s/%s/schemata",
> RESCTRL_PATH,
> > +				ctrlgrp);
> > +		else
> > +			sprintf(controlgroup, "%s/schemata",
> RESCTRL_PATH);
> > +		sprintf(schema, "%s%d%c%s", "MB:", resource_id, '=',
> schemata);
> > +
> > +		fp = fopen(controlgroup, "w");
> > +		if (!fp) {
> > +			perror("Failed to open control group");
> > +
> > +			return -1;
> > +		}
> > +
> > +		if (fprintf(fp, "%s\n", schema) < 0) {
> > +			perror("Failed to write schemata in control group");
> > +			fclose(fp);
> > +
> > +			return -1;
> > +		}
> > +		fclose(fp);
> > +
> > +		printf("Write schemata to resctrl FS: done!\n");
> > +	}
> > +
> > +	return 0;
> > +}
> > +
> > +/*
> > + * validate_resctrl_feature_request - Check if requested feature is valid.
> > + * @resctrl_val:	Requested feature
> > + *
> > + * Return: 0 on success, non-zero on failure  */ int
> > +validate_resctrl_feature_request(char *resctrl_val) {
> > +	int resctrl_features_supported[MAX_RESCTRL_FEATURES];
> > +	const char *resctrl_features_list[MAX_RESCTRL_FEATURES] = {
> > +			"mbm", "mba"};
> > +	int i, valid_resctrl_feature = -1;
> > +	char line[1024];
> > +	FILE *fp;
> > +
> > +	if (!resctrl_val) {
> > +		fprintf(stderr, "resctrl feature cannot be NULL\n");
> > +
> > +		return -1;
> > +	}
> > +
> > +	for (i = 0; i < MAX_RESCTRL_FEATURES; i++)
> > +		resctrl_features_supported[i] = 0;
> > +
> > +	/* Is the resctrl feature request valid? */
> > +	for (i = 0; i < MAX_RESCTRL_FEATURES; i++) {
> > +		if (strcmp(resctrl_features_list[i], resctrl_val) == 0)
> > +			valid_resctrl_feature = i;
> > +	}
> > +	if (valid_resctrl_feature == -1) {
> > +		fprintf(stderr, "Not a valid resctrl feature request\n");
> > +
> > +		return -1;
> > +	}
> > +
> > +	/* Enumerate resctrl features supported by this platform */
> > +	if (system("dmesg > dmesg") != 0) {
> > +		perror("Could not create custom dmesg file");
> 
> This fails horribly if the local directory is not writable. Creating a pipe
> (similar to how we communicate between the benchmark processes) and
> reading from there avoid this.
> 
> > +
> > +		return -1;
> > +	}
> > +
> > +	fp = fopen("dmesg", "r");
> > +	if (!fp) {
> > +		perror("Could not read custom created dmesg");
> > +
> > +		return -1;
> > +	}
> > +
> > +	while (fgets(line, 1024, fp)) {
> > +		if ((strstr(line, RESCTRL_MBM)) != NULL)
> > +
> 	resctrl_features_supported[RESCTRL_FEATURE_MBM] = 1;
> 
> In general this approach is not very reliable, as the beginning of the kernel
> log could have been overwritten already in the dmesg buffer.
> Also this is not the way we should detect features: I think the content of
> /sys/fs/resctrl/info should be used for that purpose.

Agree with you. We will use /sys/fs/resctrl/info directory to enumerate features
instead of dmesg.

Thanks.

-Fenghua

