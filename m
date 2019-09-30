Return-Path: <SRS0=rUXN=XZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A18DFC32792
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Sep 2019 15:18:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6BA112168B
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Sep 2019 15:18:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731964AbfI3PSG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 30 Sep 2019 11:18:06 -0400
Received: from mx1.redhat.com ([209.132.183.28]:47380 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731870AbfI3PSG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Sep 2019 11:18:06 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 21F828980E8;
        Mon, 30 Sep 2019 15:18:06 +0000 (UTC)
Received: from prarit.bos.redhat.com (prarit-guest.khw1.lab.eng.bos.redhat.com [10.16.200.63])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 8E53560624;
        Mon, 30 Sep 2019 15:18:05 +0000 (UTC)
Subject: Re: [PATCH 1/7] intel-speed-select: Add int argument to command
 functions
To:     Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        platform-driver-x86@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org
References: <20190926125501.1616-1-prarit@redhat.com>
 <20190926125501.1616-2-prarit@redhat.com>
 <ee1649041f5c2072638c46198c6c7a6c63a051fc.camel@linux.intel.com>
From:   Prarit Bhargava <prarit@redhat.com>
Message-ID: <3eeea22e-9164-f8a9-a937-f7796a400b98@redhat.com>
Date:   Mon, 30 Sep 2019 11:18:05 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <ee1649041f5c2072638c46198c6c7a6c63a051fc.camel@linux.intel.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.6.2 (mx1.redhat.com [10.5.110.67]); Mon, 30 Sep 2019 15:18:06 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 9/26/19 4:21 PM, Srinivas Pandruvada wrote:
> On Thu, 2019-09-26 at 08:54 -0400, Prarit Bhargava wrote:
>> The current code structure has similar but separate command functions
>> for
>> the enable and disable operations.  This can be improved by adding an
>> int
>> argument to the command function structure, and interpreting 1 as
>> enable
>> and 0 as disable.  This change results in the removal of the disable
>> command functions.
>>
>> Add int argument to the command function structure.
> Does this brings in any significant reduction in data or code size?

It reduces code size.  Right now you have separate functions for enable &
disable.  These are unified into single functions.

P.

> My focus is to add features first which helps users.
> 
> Thanks,
> Srinivas
> 
> 
>>
>> Signed-off-by: Prarit Bhargava <prarit@redhat.com>
>> Cc: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
>> ---
>>  .../x86/intel-speed-select/isst-config.c      | 184 +++++++---------
>> --
>>  1 file changed, 69 insertions(+), 115 deletions(-)
>>
>> diff --git a/tools/power/x86/intel-speed-select/isst-config.c
>> b/tools/power/x86/intel-speed-select/isst-config.c
>> index 2a9890c8395a..9f2798caead9 100644
>> --- a/tools/power/x86/intel-speed-select/isst-config.c
>> +++ b/tools/power/x86/intel-speed-select/isst-config.c
>> @@ -11,7 +11,8 @@
>>  struct process_cmd_struct {
>>  	char *feature;
>>  	char *command;
>> -	void (*process_fn)(void);
>> +	void (*process_fn)(int arg);
>> +	int arg;
>>  };
>>  
>>  static const char *version_str = "v1.0";
>> @@ -678,7 +679,7 @@ static void exec_on_get_ctdp_cpu(int cpu, void
>> *arg1, void *arg2, void *arg3,
>>  }
>>  
>>  #define _get_tdp_level(desc, suffix, object,
>> help)                                \
>> -	static void
>> get_tdp_##object(void)                                        \
>> +	static void get_tdp_##object(int
>> arg)                                    \
>>  	{                                                              
>>            \
>>  		struct isst_pkg_ctdp
>> ctdp;                                        \
>>  \
>> @@ -724,7 +725,7 @@ static void dump_isst_config_for_cpu(int cpu,
>> void *arg1, void *arg2,
>>  	}
>>  }
>>  
>> -static void dump_isst_config(void)
>> +static void dump_isst_config(int arg)
>>  {
>>  	if (cmd_help) {
>>  		fprintf(stderr,
>> @@ -787,7 +788,7 @@ static void set_tdp_level_for_cpu(int cpu, void
>> *arg1, void *arg2, void *arg3,
>>  	}
>>  }
>>  
>> -static void set_tdp_level(void)
>> +static void set_tdp_level(int arg)
>>  {
>>  	if (cmd_help) {
>>  		fprintf(stderr, "Set Config TDP level\n");
>> @@ -827,7 +828,7 @@ static void dump_pbf_config_for_cpu(int cpu, void
>> *arg1, void *arg2, void *arg3,
>>  	}
>>  }
>>  
>> -static void dump_pbf_config(void)
>> +static void dump_pbf_config(int arg)
>>  {
>>  	if (cmd_help) {
>>  		fprintf(stderr,
>> @@ -871,43 +872,27 @@ static void set_pbf_for_cpu(int cpu, void
>> *arg1, void *arg2, void *arg3,
>>  	}
>>  }
>>  
>> -static void set_pbf_enable(void)
>> -{
>> -	int status = 1;
>> -
>> -	if (cmd_help) {
>> -		fprintf(stderr,
>> -			"Enable Intel Speed Select Technology base
>> frequency feature [No command arguments are required]\n");
>> -		exit(0);
>> -	}
>> -
>> -	isst_ctdp_display_information_start(outf);
>> -	if (max_target_cpus)
>> -		for_each_online_target_cpu_in_set(set_pbf_for_cpu,
>> NULL, NULL,
>> -						  NULL, &status);
>> -	else
>> -		for_each_online_package_in_set(set_pbf_for_cpu, NULL,
>> NULL,
>> -					       NULL, &status);
>> -	isst_ctdp_display_information_end(outf);
>> -}
>> -
>> -static void set_pbf_disable(void)
>> +static void set_pbf_enable(int arg)
>>  {
>> -	int status = 0;
>> +	int enable = arg;
>>  
>>  	if (cmd_help) {
>> -		fprintf(stderr,
>> -			"Disable Intel Speed Select Technology base
>> frequency feature [No command arguments are required]\n");
>> +		if (enable)
>> +			fprintf(stderr,
>> +				"Enable Intel Speed Select Technology
>> base frequency feature [No command arguments are required]\n");
>> +		else
>> +			fprintf(stderr,
>> +				"Disable Intel Speed Select Technology
>> base frequency feature [No command arguments are required]\n");
>>  		exit(0);
>>  	}
>>  
>>  	isst_ctdp_display_information_start(outf);
>>  	if (max_target_cpus)
>>  		for_each_online_target_cpu_in_set(set_pbf_for_cpu,
>> NULL, NULL,
>> -						  NULL, &status);
>> +						  NULL, &enable);
>>  	else
>>  		for_each_online_package_in_set(set_pbf_for_cpu, NULL,
>> NULL,
>> -					       NULL, &status);
>> +					       NULL, &enable);
>>  	isst_ctdp_display_information_end(outf);
>>  }
>>  
>> @@ -925,7 +910,7 @@ static void dump_fact_config_for_cpu(int cpu,
>> void *arg1, void *arg2,
>>  					      fact_avx, &fact_info);
>>  }
>>  
>> -static void dump_fact_config(void)
>> +static void dump_fact_config(int arg)
>>  {
>>  	if (cmd_help) {
>>  		fprintf(stderr,
>> @@ -985,35 +970,17 @@ static void set_fact_for_cpu(int cpu, void
>> *arg1, void *arg2, void *arg3,
>>  	}
>>  }
>>  
>> -static void set_fact_enable(void)
>> +static void set_fact_enable(int arg)
>>  {
>> -	int status = 1;
>> +	int enable = arg;
>>  
>>  	if (cmd_help) {
>> -		fprintf(stderr,
>> -			"Enable Intel Speed Select Technology Turbo
>> frequency feature\n");
>> -		fprintf(stderr,
>> -			"Optional: -t|--trl : Specify turbo ratio
>> limit\n");
>> -		exit(0);
>> -	}
>> -
>> -	isst_ctdp_display_information_start(outf);
>> -	if (max_target_cpus)
>> -		for_each_online_target_cpu_in_set(set_fact_for_cpu,
>> NULL, NULL,
>> -						  NULL, &status);
>> -	else
>> -		for_each_online_package_in_set(set_fact_for_cpu, NULL,
>> NULL,
>> -					       NULL, &status);
>> -	isst_ctdp_display_information_end(outf);
>> -}
>> -
>> -static void set_fact_disable(void)
>> -{
>> -	int status = 0;
>> -
>> -	if (cmd_help) {
>> -		fprintf(stderr,
>> -			"Disable Intel Speed Select Technology turbo
>> frequency feature\n");
>> +		if (enable)
>> +			fprintf(stderr,
>> +				"Enable Intel Speed Select Technology
>> Turbo frequency feature\n");
>> +		else
>> +			fprintf(stderr,
>> +				"Disable Intel Speed Select Technology
>> turbo frequency feature\n");
>>  		fprintf(stderr,
>>  			"Optional: -t|--trl : Specify turbo ratio
>> limit\n");
>>  		exit(0);
>> @@ -1022,10 +989,10 @@ static void set_fact_disable(void)
>>  	isst_ctdp_display_information_start(outf);
>>  	if (max_target_cpus)
>>  		for_each_online_target_cpu_in_set(set_fact_for_cpu,
>> NULL, NULL,
>> -						  NULL, &status);
>> +						  NULL, &enable);
>>  	else
>>  		for_each_online_package_in_set(set_fact_for_cpu, NULL,
>> NULL,
>> -					       NULL, &status);
>> +					       NULL, &enable);
>>  	isst_ctdp_display_information_end(outf);
>>  }
>>  
>> @@ -1048,19 +1015,25 @@ static void enable_clos_qos_config(int cpu,
>> void *arg1, void *arg2, void *arg3,
>>  	}
>>  }
>>  
>> -static void set_clos_enable(void)
>> +static void set_clos_enable(int arg)
>>  {
>> -	int status = 1;
>> +	int enable = arg;
>>  
>>  	if (cmd_help) {
>> -		fprintf(stderr, "Enable core-power for a
>> package/die\n");
>> -		fprintf(stderr,
>> -			"\tClos Enable: Specify priority type with [
>> --priority|-p]\n");
>> -		fprintf(stderr, "\t\t 0: Proportional, 1: Ordered\n");
>> +		if (enable) {
>> +			fprintf(stderr,
>> +				"Enable core-power for a
>> package/die\n");
>> +			fprintf(stderr,
>> +				"\tClos Enable: Specify priority type
>> with [--priority|-p]\n");
>> +			fprintf(stderr, "\t\t 0: Proportional, 1:
>> Ordered\n");
>> +		} else {
>> +			fprintf(stderr,
>> +				"Disable core-power: [No command
>> arguments are required]\n");
>> +		}
>>  		exit(0);
>>  	}
>>  
>> -	if (cpufreq_sysfs_present()) {
>> +	if (enable && cpufreq_sysfs_present()) {
>>  		fprintf(stderr,
>>  			"cpufreq subsystem and core-power enable will
>> interfere with each other!\n");
>>  	}
>> @@ -1068,30 +1041,10 @@ static void set_clos_enable(void)
>>  	isst_ctdp_display_information_start(outf);
>>  	if (max_target_cpus)
>>  		for_each_online_target_cpu_in_set(enable_clos_qos_confi
>> g, NULL,
>> -						  NULL, NULL, &status);
>> -	else
>> -		for_each_online_package_in_set(enable_clos_qos_config,
>> NULL,
>> -					       NULL, NULL, &status);
>> -	isst_ctdp_display_information_end(outf);
>> -}
>> -
>> -static void set_clos_disable(void)
>> -{
>> -	int status = 0;
>> -
>> -	if (cmd_help) {
>> -		fprintf(stderr,
>> -			"Disable core-power: [No command arguments are
>> required]\n");
>> -		exit(0);
>> -	}
>> -
>> -	isst_ctdp_display_information_start(outf);
>> -	if (max_target_cpus)
>> -		for_each_online_target_cpu_in_set(enable_clos_qos_confi
>> g, NULL,
>> -						  NULL, NULL, &status);
>> +						  NULL, NULL, &enable);
>>  	else
>>  		for_each_online_package_in_set(enable_clos_qos_config,
>> NULL,
>> -					       NULL, NULL, &status);
>> +					       NULL, NULL, &enable);
>>  	isst_ctdp_display_information_end(outf);
>>  }
>>  
>> @@ -1109,7 +1062,7 @@ static void dump_clos_config_for_cpu(int cpu,
>> void *arg1, void *arg2,
>>  					      &clos_config);
>>  }
>>  
>> -static void dump_clos_config(void)
>> +static void dump_clos_config(int arg)
>>  {
>>  	if (cmd_help) {
>>  		fprintf(stderr,
>> @@ -1145,7 +1098,7 @@ static void get_clos_info_for_cpu(int cpu, void
>> *arg1, void *arg2, void *arg3,
>>  		isst_clos_display_clos_information(cpu, outf, enable,
>> prio_type);
>>  }
>>  
>> -static void dump_clos_info(void)
>> +static void dump_clos_info(int arg)
>>  {
>>  	if (cmd_help) {
>>  		fprintf(stderr,
>> @@ -1188,7 +1141,7 @@ static void set_clos_config_for_cpu(int cpu,
>> void *arg1, void *arg2, void *arg3,
>>  		isst_display_result(cpu, outf, "core-power", "config",
>> ret);
>>  }
>>  
>> -static void set_clos_config(void)
>> +static void set_clos_config(int arg)
>>  {
>>  	if (cmd_help) {
>>  		fprintf(stderr,
>> @@ -1252,7 +1205,7 @@ static void set_clos_assoc_for_cpu(int cpu,
>> void *arg1, void *arg2, void *arg3,
>>  		isst_display_result(cpu, outf, "core-power", "assoc",
>> ret);
>>  }
>>  
>> -static void set_clos_assoc(void)
>> +static void set_clos_assoc(int arg)
>>  {
>>  	if (cmd_help) {
>>  		fprintf(stderr, "Associate a clos id to a CPU\n");
>> @@ -1286,7 +1239,7 @@ static void get_clos_assoc_for_cpu(int cpu,
>> void *arg1, void *arg2, void *arg3,
>>  		isst_clos_display_assoc_information(cpu, outf, clos);
>>  }
>>  
>> -static void get_clos_assoc(void)
>> +static void get_clos_assoc(int arg)
>>  {
>>  	if (cmd_help) {
>>  		fprintf(stderr, "Get associate clos id to a CPU\n");
>> @@ -1307,26 +1260,27 @@ static void get_clos_assoc(void)
>>  }
>>  
>>  static struct process_cmd_struct isst_cmds[] = {
>> -	{ "perf-profile", "get-lock-status", get_tdp_locked },
>> -	{ "perf-profile", "get-config-levels", get_tdp_levels },
>> -	{ "perf-profile", "get-config-version", get_tdp_version },
>> -	{ "perf-profile", "get-config-enabled", get_tdp_enabled },
>> -	{ "perf-profile", "get-config-current-level",
>> get_tdp_current_level },
>> -	{ "perf-profile", "set-config-level", set_tdp_level },
>> -	{ "perf-profile", "info", dump_isst_config },
>> -	{ "base-freq", "info", dump_pbf_config },
>> -	{ "base-freq", "enable", set_pbf_enable },
>> -	{ "base-freq", "disable", set_pbf_disable },
>> -	{ "turbo-freq", "info", dump_fact_config },
>> -	{ "turbo-freq", "enable", set_fact_enable },
>> -	{ "turbo-freq", "disable", set_fact_disable },
>> -	{ "core-power", "info", dump_clos_info },
>> -	{ "core-power", "enable", set_clos_enable },
>> -	{ "core-power", "disable", set_clos_disable },
>> -	{ "core-power", "config", set_clos_config },
>> -	{ "core-power", "get-config", dump_clos_config },
>> -	{ "core-power", "assoc", set_clos_assoc },
>> -	{ "core-power", "get-assoc", get_clos_assoc },
>> +	{ "perf-profile", "get-lock-status", get_tdp_locked, 0 },
>> +	{ "perf-profile", "get-config-levels", get_tdp_levels, 0 },
>> +	{ "perf-profile", "get-config-version", get_tdp_version, 0 },
>> +	{ "perf-profile", "get-config-enabled", get_tdp_enabled, 0 },
>> +	{ "perf-profile", "get-config-current-level",
>> get_tdp_current_level,
>> +	 0 },
>> +	{ "perf-profile", "set-config-level", set_tdp_level, 0 },
>> +	{ "perf-profile", "info", dump_isst_config, 0 },
>> +	{ "base-freq", "info", dump_pbf_config, 0 },
>> +	{ "base-freq", "enable", set_pbf_enable, 1 },
>> +	{ "base-freq", "disable", set_pbf_enable, 0 },
>> +	{ "turbo-freq", "info", dump_fact_config, 0 },
>> +	{ "turbo-freq", "enable", set_fact_enable, 1 },
>> +	{ "turbo-freq", "disable", set_fact_enable, 0 },
>> +	{ "core-power", "info", dump_clos_info, 0 },
>> +	{ "core-power", "enable", set_clos_enable, 1 },
>> +	{ "core-power", "disable", set_clos_enable, 0 },
>> +	{ "core-power", "config", set_clos_config, 0 },
>> +	{ "core-power", "get-config", dump_clos_config, 0 },
>> +	{ "core-power", "assoc", set_clos_assoc, 0 },
>> +	{ "core-power", "get-assoc", get_clos_assoc, 0 },
>>  	{ NULL, NULL, NULL }
>>  };
>>  
>> @@ -1571,7 +1525,7 @@ void process_command(int argc, char **argv)
>>  		if (!strcmp(isst_cmds[i].feature, feature) &&
>>  		    !strcmp(isst_cmds[i].command, cmd)) {
>>  			parse_cmd_args(argc, optind + 1, argv);
>> -			isst_cmds[i].process_fn();
>> +			isst_cmds[i].process_fn(isst_cmds[i].arg);
>>  			matched = 1;
>>  			break;
>>  		}
> 
