Return-Path: <SRS0=IWld=WE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B27DCC433FF
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Aug 2019 21:00:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7781E2173C
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Aug 2019 21:00:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390421AbfHHVAS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 8 Aug 2019 17:00:18 -0400
Received: from foss.arm.com ([217.140.110.172]:38606 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725535AbfHHVAR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Aug 2019 17:00:17 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 557341596;
        Thu,  8 Aug 2019 14:00:14 -0700 (PDT)
Received: from [192.168.122.164] (U201426.austin.arm.com [10.118.28.59])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id AD9613F694;
        Thu,  8 Aug 2019 14:00:13 -0700 (PDT)
Subject: Re: [RFC PATCH 2/3] perf tools: Add support for "report" for some spe
 events
To:     Tan Xiaojun <tanxiaojun@huawei.com>, peterz@infradead.org,
        mingo@redhat.com, acme@kernel.org,
        alexander.shishkin@linux.intel.com, jolsa@redhat.com,
        namhyung@kernel.org, ak@linux.intel.com, adrian.hunter@intel.com,
        yao.jin@linux.intel.com, tmricht@linux.ibm.com,
        brueckner@linux.ibm.com, songliubraving@fb.com,
        gregkh@linuxfoundation.org, Kim Phillips <Kim.Phillips@amd.com>
Cc:     gengdongjiu@huawei.com, wxf.wang@hisilicon.com,
        liwei391@huawei.com, huawei.libin@huawei.com,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org
References: <1564738813-10944-1-git-send-email-tanxiaojun@huawei.com>
 <1564738813-10944-3-git-send-email-tanxiaojun@huawei.com>
From:   Jeremy Linton <jeremy.linton@arm.com>
Message-ID: <0ac06995-273c-034d-52a3-921ea0337be2@arm.com>
Date:   Thu, 8 Aug 2019 16:00:12 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <1564738813-10944-3-git-send-email-tanxiaojun@huawei.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

First thanks for posting this!

I ran this on our DAWN platform and it does what it says. Its a pretty 
reasonable start, but I get -1's in the command row rather than "dd" (or 
similar) and this also results in [unknown] for the shared object and 
most userspace addresses. This is quite possibly something I'm not doing 
right, but I didn't spend a lot of time testing/debugging it.

I did a quick glance at the code to, and had a couple comments, although 
I'm not a perf tool expert.


On 8/2/19 4:40 AM, Tan Xiaojun wrote:
> After the commit ffd3d18c20b8 ("perf tools: Add ARM Statistical
> Profiling Extensions (SPE) support") is merged, "perf record" and
> "perf report --dump-raw-trace" have been supported. However, the
> raw data that is dumped cannot be used without parsing.
> 
> This patch is to improve the "perf report" support for spe, and
> further process the data. Currently, support for the three events
> of llc-miss, tlb-miss, and branch-miss is added.
> 
> Example usage:
> 
> --------------------------------------------------------------------
> ...
>      37.84%    37.84%  dd       [kernel.kallsyms]  [k] perf_iterate_ctx.constprop.64
>      16.22%    16.22%  dd       [kernel.kallsyms]  [k] copy_page
>       5.41%     5.41%  dd       [kernel.kallsyms]  [k] find_vma
>       5.41%     5.41%  dd       [kernel.kallsyms]  [k] perf_event_mmap
>       5.41%     5.41%  dd       [kernel.kallsyms]  [k] zap_pte_range
>       5.41%     5.41%  dd       ld-2.28.so         [.] _dl_lookup_symbol_x
>       5.41%     5.41%  dd       libc-2.28.so       [.] _nl_intern_locale_data
>       2.70%     2.70%  dd       [kernel.kallsyms]  [k] __remove_shared_vm_struct.isra.1
>       2.70%     2.70%  dd       [kernel.kallsyms]  [k] kmem_cache_free
>       2.70%     2.70%  dd       [kernel.kallsyms]  [k] ttwu_do_wakeup.isra.19
>       2.70%     2.70%  dd       dd                 [.] 0x000000000000d9d8
>       2.70%     2.70%  dd       ld-2.28.so         [.] _dl_relocate_object
>       2.70%     2.70%  dd       libc-2.28.so       [.] __unregister_atfork
>       2.70%     2.70%  dd       libc-2.28.so       [.] _dl_addr
> 
>      12.50%    12.50%  dd       [kernel.kallsyms]  [k] __audit_syscall_entry
>      12.50%    12.50%  dd       [kernel.kallsyms]  [k] kmem_cache_free
>      12.50%    12.50%  dd       [kernel.kallsyms]  [k] perf_iterate_ctx.constprop.64
>      12.50%    12.50%  dd       [kernel.kallsyms]  [k] ttwu_do_wakeup.isra.19
>      12.50%    12.50%  dd       dd                 [.] 0x000000000000d9d8
>      12.50%    12.50%  dd       libc-2.28.so       [.] __unregister_atfork
>      12.50%    12.50%  dd       libc-2.28.so       [.] _nl_intern_locale_data
>      12.50%    12.50%  dd       libc-2.28.so       [.] vfprintf
> 
>      16.67%    16.67%  dd       libc-2.28.so       [.] read_alias_file
>       8.33%     8.33%  dd       [kernel.kallsyms]  [k] __arch_copy_from_user
>       8.33%     8.33%  dd       [kernel.kallsyms]  [k] __arch_copy_to_user
>       8.33%     8.33%  dd       [kernel.kallsyms]  [k] lookup_fast
>       8.33%     8.33%  dd       [kernel.kallsyms]  [k] strncpy_from_user
>       8.33%     8.33%  dd       ld-2.28.so         [.] _dl_lookup_symbol_x
>       8.33%     8.33%  dd       ld-2.28.so         [.] check_match
>       8.33%     8.33%  dd       libc-2.28.so       [.] __GI___printf_fp_l
>       8.33%     8.33%  dd       libc-2.28.so       [.] _dl_addr
>       8.33%     8.33%  dd       libc-2.28.so       [.] _int_malloc
>       8.33%     8.33%  dd       libc-2.28.so       [.] _nl_intern_locale_data
> 
> --------------------------------------------------------------------
> 
> After that, more analysis and processing of the raw data of spe
> will be done.
> 
> Signed-off-by: Tan Xiaojun <tanxiaojun@huawei.com>
> ---
>   tools/perf/builtin-report.c                        |   5 +
>   tools/perf/util/arm-spe-decoder/Build              |   2 +-
>   tools/perf/util/arm-spe-decoder/arm-spe-decoder.c  | 214 ++++++
>   tools/perf/util/arm-spe-decoder/arm-spe-decoder.h  |  51 ++
>   .../util/arm-spe-decoder/arm-spe-pkt-decoder.h     |   2 +
>   tools/perf/util/arm-spe.c                          | 715 ++++++++++++++++++++-
>   tools/perf/util/auxtrace.c                         |  45 ++
>   tools/perf/util/auxtrace.h                         |  27 +
>   tools/perf/util/session.h                          |   2 +
>   9 files changed, 1028 insertions(+), 35 deletions(-)
>   create mode 100644 tools/perf/util/arm-spe-decoder/arm-spe-decoder.c
>   create mode 100644 tools/perf/util/arm-spe-decoder/arm-spe-decoder.h
> 
> diff --git a/tools/perf/builtin-report.c b/tools/perf/builtin-report.c
> index abf0b9b..fadc8eb 100644
> --- a/tools/perf/builtin-report.c
> +++ b/tools/perf/builtin-report.c
> @@ -1007,6 +1007,7 @@ int cmd_report(int argc, const char **argv)
>   {
>   	struct perf_session *session;
>   	struct itrace_synth_opts itrace_synth_opts = { .set = 0, };
> +	struct arm_spe_synth_opts arm_spe_synth_opts;
>   	struct stat st;
>   	bool has_br_stack = false;
>   	int branch_mode = -1;
> @@ -1165,6 +1166,9 @@ int cmd_report(int argc, const char **argv)
>   	OPT_CALLBACK_OPTARG(0, "itrace", &itrace_synth_opts, NULL, "opts",
>   			    "Instruction Tracing options\n" ITRACE_HELP,
>   			    itrace_parse_synth_opts),
> +	OPT_CALLBACK_OPTARG(0, "spe", &arm_spe_synth_opts, NULL, "spe opts",
> +			    "ARM SPE Tracing options",
> +			    arm_spe_parse_synth_opts),
>   	OPT_BOOLEAN(0, "full-source-path", &srcline_full_filename,
>   			"Show full source file name path for source lines"),
>   	OPT_BOOLEAN(0, "show-ref-call-graph", &symbol_conf.show_ref_callgraph,
> @@ -1266,6 +1270,7 @@ int cmd_report(int argc, const char **argv)
>   	}
>   
>   	session->itrace_synth_opts = &itrace_synth_opts;
> +	session->arm_spe_synth_opts = &arm_spe_synth_opts;
>   
>   	report.session = session;
>   
> diff --git a/tools/perf/util/arm-spe-decoder/Build b/tools/perf/util/arm-spe-decoder/Build
> index 16efbc2..f8dae13 100644
> --- a/tools/perf/util/arm-spe-decoder/Build
> +++ b/tools/perf/util/arm-spe-decoder/Build
> @@ -1 +1 @@
> -perf-$(CONFIG_AUXTRACE) += arm-spe-pkt-decoder.o
> +perf-$(CONFIG_AUXTRACE) += arm-spe-pkt-decoder.o arm-spe-decoder.o
> diff --git a/tools/perf/util/arm-spe-decoder/arm-spe-decoder.c b/tools/perf/util/arm-spe-decoder/arm-spe-decoder.c
> new file mode 100644
> index 0000000..8008375
> --- /dev/null
> +++ b/tools/perf/util/arm-spe-decoder/arm-spe-decoder.c
> @@ -0,0 +1,214 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * arm_spe_decoder.c: ARM SPE support
> + */
> +
> +#ifndef _GNU_SOURCE
> +#define _GNU_SOURCE
> +#endif
> +#include <stdlib.h>
> +#include <stdbool.h>
> +#include <string.h>
> +#include <errno.h>
> +#include <stdint.h>
> +#include <inttypes.h>
> +#include <linux/compiler.h>
> +#include <linux/zalloc.h>
> +
> +#include "../util.h"
> +#include "../auxtrace.h"
> +
> +#include "arm-spe-pkt-decoder.h"
> +#include "arm-spe-decoder.h"
> +
> +struct arm_spe_decoder {
> +	int (*get_trace)(struct arm_spe_buffer *buffer, void *data);
> +	void *data;
> +	struct arm_spe_state state;
> +	const unsigned char *buf;
> +	size_t len;
> +	uint64_t pos;
> +	struct arm_spe_pkt packet;
> +	int pkt_step;
> +	int pkt_len;
> +	int last_packet_type;
> +
> +	uint64_t last_ip;
> +	uint64_t ip;
> +	uint64_t timestamp;
> +	uint64_t sample_timestamp;
> +	const unsigned char *next_buf;
> +	size_t next_len;
> +	unsigned char temp_buf[ARM_SPE_PKT_MAX_SZ];
> +};
> +
> +static uint64_t arm_spe_calc_ip(uint64_t payload)
> +{
> +	uint64_t ip = (payload & ~(0xffULL << 56));
> +
> +	/* fill high 8 bits for kernel virtual address */
> +	if (ip & 0x1000000000000ULL)

It might be better to use VA_START here if possible.

> +		ip |= (uint64_t)0xff00000000000000ULL;
> +
> +	return ip;
> +}
> +
> +struct arm_spe_decoder *arm_spe_decoder_new(struct arm_spe_params *params)
> +{
> +	struct arm_spe_decoder *decoder;
> +
> +	if (!params->get_trace)
> +		return NULL;
> +
> +	decoder = zalloc(sizeof(struct arm_spe_decoder));
> +	if (!decoder)
> +		return NULL;
> +
> +	decoder->get_trace          = params->get_trace;
> +	decoder->data               = params->data;
> +
> +	return decoder;
> +}
> +
> +void arm_spe_decoder_free(struct arm_spe_decoder *decoder)
> +{
> +	free(decoder);
> +}
> +
> +static int arm_spe_bad_packet(struct arm_spe_decoder *decoder)
> +{
> +	decoder->pkt_len = 1;
> +	decoder->pkt_step = 1;
> +	pr_debug("ERROR: Bad packet\n");
> +
> +	return -EBADMSG;
> +}
> +
> +
> +static int arm_spe_get_data(struct arm_spe_decoder *decoder)
> +{
> +	struct arm_spe_buffer buffer = { .buf = 0, };
> +	int ret;
> +
> +	decoder->pkt_step = 0;
> +
> +	pr_debug("Getting more data\n");
> +	ret = decoder->get_trace(&buffer, decoder->data);
> +	if (ret)
> +		return ret;
> +
> +	decoder->buf = buffer.buf;
> +	decoder->len = buffer.len;
> +	if (!decoder->len) {
> +		pr_debug("No more data\n");
> +		return -ENODATA;
> +	}
> +
> +	return 0;
> +}
> +
> +static int arm_spe_get_next_data(struct arm_spe_decoder *decoder)
> +{
> +	return arm_spe_get_data(decoder);
> +}
> +
> +static int arm_spe_get_next_packet(struct arm_spe_decoder *decoder)
> +{
> +	int ret;
> +
> +	decoder->last_packet_type = decoder->packet.type;
> +
> +	do {
> +		decoder->pos += decoder->pkt_step;
> +		decoder->buf += decoder->pkt_step;
> +		decoder->len -= decoder->pkt_step;
> +
> +
> +		if (!decoder->len) {
> +			ret = arm_spe_get_next_data(decoder);
> +			if (ret)
> +				return ret;
> +		}
> +
> +		ret = arm_spe_get_packet(decoder->buf, decoder->len,
> +				&decoder->packet);
> +		if (ret <= 0)
> +			return arm_spe_bad_packet(decoder);
> +
> +		decoder->pkt_len = ret;
> +		decoder->pkt_step = ret;
> +	} while (decoder->packet.type == ARM_SPE_PAD);
> +
> +	return 0;
> +}
> +
> +static int arm_spe_walk_trace(struct arm_spe_decoder *decoder)
> +{
> +	int err;
> +	int idx;
> +	uint64_t payload;
> +
> +	while (1) {
> +		err = arm_spe_get_next_packet(decoder);
> +		if (err)
> +			return err;
> +
> +		idx = decoder->packet.index;
> +		payload = decoder->packet.payload;
> +
> +		switch (decoder->packet.type) {
> +		case ARM_SPE_TIMESTAMP:
> +			decoder->sample_timestamp = payload;
> +			return 0;
> +		case ARM_SPE_END:
> +			decoder->sample_timestamp = 0;
> +			return 0;
> +		case ARM_SPE_ADDRESS:
> +			decoder->ip = arm_spe_calc_ip(payload);
> +			if (idx == 0)
> +				decoder->state.from_ip = decoder->ip;
> +			else if (idx == 1)
> +				decoder->state.to_ip = decoder->ip;
> +			break;
> +		case ARM_SPE_COUNTER:
> +			break;
> +		case ARM_SPE_CONTEXT:
> +			break;
> +		case ARM_SPE_OP_TYPE:
> +			break;
> +		case ARM_SPE_EVENTS:
> +			if (payload & 0x20)
> +				decoder->state.type |= ARM_SPE_TLB_MISS;
> +			if (payload & 0x80)
> +				decoder->state.type |= ARM_SPE_BRANCH_MISS;
> +			if (idx > 1 && (payload & 0x200))
> +				decoder->state.type |= ARM_SPE_LLC_MISS;
> +
> +			break;
> +		case ARM_SPE_DATA_SOURCE:
> +			break;
> +		case ARM_SPE_BAD:
> +			break;
> +		case ARM_SPE_PAD:
> +			break;
> +		default:
> +			pr_err("Get Packet Error!\n");
> +			return -ENOSYS;
> +		}
> +	}
> +}

This code looks very similar to  arm_spe_pkt_desc(), I can't help but 
think they should be consolidated in some way. If nothing else the magic 
0x20, 0x80, etc ARM_SPE_EVENTS should be defined somewhere and shared.


> +
> +const struct arm_spe_state *arm_spe_decode(struct arm_spe_decoder *decoder)
> +{
> +	int err;
> +
> +	decoder->state.type = 0;
> +
> +	err = arm_spe_walk_trace(decoder);
> +	if (err)
> +		decoder->state.err = err;
> +
> +	decoder->state.timestamp = decoder->sample_timestamp;
> +
> +	return &decoder->state;

(trimming remainder)

