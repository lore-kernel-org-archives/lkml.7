Return-Path: <SRS0=bmbz=XS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5439DC4CECF
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Sep 2019 16:51:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 323F220882
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Sep 2019 16:51:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2439989AbfIWQvP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 23 Sep 2019 12:51:15 -0400
Received: from foss.arm.com ([217.140.110.172]:45482 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2390796AbfIWQvP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Sep 2019 12:51:15 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 415371000;
        Mon, 23 Sep 2019 09:51:14 -0700 (PDT)
Received: from dawn-kernel.cambridge.arm.com (unknown [10.1.197.116])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id F22DD3F67D;
        Mon, 23 Sep 2019 09:51:06 -0700 (PDT)
Subject: Re: [PATCH v2 1/5] perf cs-etm: Refactor instruction size handling
To:     Leo Yan <leo.yan@linaro.org>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Mike Leach <mike.leach@linaro.org>,
        Coresight ML <coresight@lists.linaro.org>
References: <20190923160759.14866-1-leo.yan@linaro.org>
 <20190923160759.14866-2-leo.yan@linaro.org>
From:   Suzuki K Poulose <suzuki.poulose@arm.com>
Message-ID: <2b675e24-8b06-fbd6-ab73-214a6afb2a07@arm.com>
Date:   Mon, 23 Sep 2019 17:51:04 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.0
MIME-Version: 1.0
In-Reply-To: <20190923160759.14866-2-leo.yan@linaro.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Leo,

On 23/09/2019 17:07, Leo Yan wrote:
> In cs-etm.c there have several functions need to know instruction size
> based on address, e.g. cs_etm__instr_addr() and cs_etm__copy_insn()
> these two functions both calculate the instruction size separately.
> Furthermore, if we consider to add new features later which also might
> require to calculate instruction size.
> 
> For this reason, this patch refactors the code to introduce a new
> function cs_etm__instr_size(), it will be a central place to calculate
> the instruction size based on ISA type and instruction address.
> 
> For a neat implementation, cs_etm__instr_addr() will always execute the
> loop without checking ISA type, this allows cs_etm__instr_size() and
> cs_etm__instr_addr() have no any duplicate code with each other and both
> functions can be changed independently later without breaking anything.
> As a side effect, cs_etm__instr_addr() will do a few more iterations for
> A32/A64 instructions, this would be fine if consider perf tool runs in
> the user space.
> 
> Signed-off-by: Leo Yan <leo.yan@linaro.org>

Your changes look fine to me. However, please see my comment below.

> ---
>   tools/perf/util/cs-etm.c | 48 +++++++++++++++++++++++-----------------
>   1 file changed, 28 insertions(+), 20 deletions(-)
> 
> diff --git a/tools/perf/util/cs-etm.c b/tools/perf/util/cs-etm.c
> index f87b9c1c9f9a..1de3f9361193 100644
> --- a/tools/perf/util/cs-etm.c
> +++ b/tools/perf/util/cs-etm.c
> @@ -917,6 +917,26 @@ static inline int cs_etm__t32_instr_size(struct cs_etm_queue *etmq,
>   	return ((instrBytes[1] & 0xF8) >= 0xE8) ? 4 : 2;
>   }
>   
> +static inline int cs_etm__instr_size(struct cs_etm_queue *etmq,
> +				     u8 trace_chan_id,
> +				     enum cs_etm_isa isa,
> +				     u64 addr)
> +{
> +	int insn_len;
> +
> +	/*
> +	 * T32 instruction size might be 32-bit or 16-bit, decide by calling
> +	 * cs_etm__t32_instr_size().
> +	 */
> +	if (isa == CS_ETM_ISA_T32)
> +		insn_len = cs_etm__t32_instr_size(etmq, trace_chan_id, addr);
> +	/* Otherwise, A64 and A32 instruction size are always 32-bit. */
> +	else
> +		insn_len = 4;
> +
> +	return insn_len;
> +}
> +
>   static inline u64 cs_etm__first_executed_instr(struct cs_etm_packet *packet)
>   {
>   	/* Returns 0 for the CS_ETM_DISCONTINUITY packet */
> @@ -941,19 +961,15 @@ static inline u64 cs_etm__instr_addr(struct cs_etm_queue *etmq,
>   				     const struct cs_etm_packet *packet,
>   				     u64 offset)
>   {
> -	if (packet->isa == CS_ETM_ISA_T32) {
> -		u64 addr = packet->start_addr;
> +	u64 addr = packet->start_addr;
>   
> -		while (offset > 0) {
> -			addr += cs_etm__t32_instr_size(etmq,
> -						       trace_chan_id, addr);
> -			offset--;
> -		}
> -		return addr;
> +	while (offset > 0) {

Given that offset is u64, the check above is not appropriate. You could either
change it to :
	while (offset) // if you are sure (s64)offset always is a postive
integer and we always reduce it by 1.

Otherwise you may switch the offset to a signed type. I understand that this
is not introduced by your changes. But you may fix that up in a separate patch.


Kind regards
Suzuki
