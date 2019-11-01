Return-Path: <SRS0=OzJr=YZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 163F8CA9ECB
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Nov 2019 02:48:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E4BD62086D
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Nov 2019 02:48:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728937AbfKACsR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 31 Oct 2019 22:48:17 -0400
Received: from mail5.windriver.com ([192.103.53.11]:52222 "EHLO mail5.wrs.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726614AbfKACsR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Oct 2019 22:48:17 -0400
Received: from ALA-HCA.corp.ad.wrs.com (ala-hca.corp.ad.wrs.com [147.11.189.40])
        by mail5.wrs.com (8.15.2/8.15.2) with ESMTPS id xA12lsRT030889
        (version=TLSv1 cipher=AES128-SHA bits=128 verify=FAIL);
        Thu, 31 Oct 2019 19:47:54 -0700
Received: from [128.224.155.112] (128.224.155.112) by ALA-HCA.corp.ad.wrs.com
 (147.11.189.50) with Microsoft SMTP Server (TLS) id 14.3.468.0; Thu, 31 Oct
 2019 19:47:53 -0700
Subject: Re: [PATCH v5] perf record: Add support for limit perf output file
 size
To:     <acme@redhat.com>, <jolsa@redhat.com>, <arnaldo.melo@gmail.com>,
        <linux-kernel@vger.kernel.org>
References: <20191022080901.3841-1-jiwei.sun@windriver.com>
CC:     <alexander.shishkin@linux.intel.com>, <mpetlan@redhat.com>,
        <namhyung@kernel.org>, <a.p.zijlstra@chello.nl>,
        <adrian.hunter@intel.com>, <Richard.Danter@windriver.com>,
        <jiwei.sun.bj@qq.com>
From:   Jiwei Sun <Jiwei.Sun@windriver.com>
Message-ID: <3d1767cd-61b0-19d6-a21e-2803f7973b2e@windriver.com>
Date:   Fri, 1 Nov 2019 10:47:49 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101
 Thunderbird/45.8.0
MIME-Version: 1.0
In-Reply-To: <20191022080901.3841-1-jiwei.sun@windriver.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [128.224.155.112]
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jirka & Arnaldo,

I'm sorry to bother you, could you please help me to review the v5 patch again?
Thank you very much for your suggestions for the v4 patch.

Best regards,
Jiwei

On 2019e9410f22f% 16:09, jsun4 wrote:
> The patch adds a new option to limit the output file size, then based
> on it, we can create a wrapper of the perf command that uses the option
> to avoid exhausting the disk space by the unconscious user.
> 
> In order to make the perf.data parsable, we just limit the sample data
> size, since the perf.data consists of many headers and sample data and
> other data, the actual size of the recorded file will bigger than the
> setting value.
> 
> Testing it:
> 
>  # ./perf record -a -g --max-size=10M
>  Couldn't synthesize bpf events.
>  [ perf record: perf size limit reached (10249 KB), stopping session ]
>  [ perf record: Woken up 32 times to write data ]
>  [ perf record: Captured and wrote 10.133 MB perf.data (71964 samples) ]
> 
>  # ls -lh perf.data
>  -rw------- 1 root root 11M Oct 22 14:32 perf.data
> 
>  # ./perf record -a -g --max-size=10K
>  [ perf record: perf size limit reached (10 KB), stopping session ]
>  Couldn't synthesize bpf events.
>  [ perf record: Woken up 0 times to write data ]
>  [ perf record: Captured and wrote 1.546 MB perf.data (69 samples) ]
> 
>  # ls -l perf.data
>  -rw------- 1 root root 1626952 Oct 22 14:36 perf.data
> 
> Signed-off-by: Jiwei Sun <jiwei.sun@windriver.com>
> ---
> v5 changes:
>   - Change the output format like [ perf record: perf size limit XX ]
>   - change the killing perf way from "raise(SIGTERM)" to set "done == 1"
> 
> v4 changes:
>   - Just show one WARNING message after reached the limit.
> 
> v3 changes:
>   - add a test result
>   - add the new option to tools/perf/Documentation/perf-record.txt
> 
> v2 changes:
>   - make patch based on latest Arnaldo's perf/core,
>   - display warning message when reached the limit.
> ---
>  tools/perf/Documentation/perf-record.txt |  4 +++
>  tools/perf/builtin-record.c              | 46 +++++++++++++++++++++++-
>  2 files changed, 49 insertions(+), 1 deletion(-)
> 
> diff --git a/tools/perf/Documentation/perf-record.txt b/tools/perf/Documentation/perf-record.txt
> index 8a4506113d9f..ebcba1f95513 100644
> --- a/tools/perf/Documentation/perf-record.txt
> +++ b/tools/perf/Documentation/perf-record.txt
> @@ -574,6 +574,10 @@ Implies --tail-synthesize.
>  --kcore::
>  Make a copy of /proc/kcore and place it into a directory with the perf data file.
>  
> +--max-size=<size>::
> +Limit the sample data max size, <size> is expected to be a number with
> +appended unit character - B/K/M/G
> +
>  SEE ALSO
>  --------
>  linkperf:perf-stat[1], linkperf:perf-list[1]
> diff --git a/tools/perf/builtin-record.c b/tools/perf/builtin-record.c
> index f6664bb08b26..b9ddfcda9611 100644
> --- a/tools/perf/builtin-record.c
> +++ b/tools/perf/builtin-record.c
> @@ -94,8 +94,11 @@ struct record {
>  	struct switch_output	switch_output;
>  	unsigned long long	samples;
>  	cpu_set_t		affinity_mask;
> +	unsigned long		output_max_size;	/* = 0: unlimited */
>  };
>  
> +static volatile int done;
> +
>  static volatile int auxtrace_record__snapshot_started;
>  static DEFINE_TRIGGER(auxtrace_snapshot_trigger);
>  static DEFINE_TRIGGER(switch_output_trigger);
> @@ -123,6 +126,12 @@ static bool switch_output_time(struct record *rec)
>  	       trigger_is_ready(&switch_output_trigger);
>  }
>  
> +static bool record__output_max_size_exceeded(struct record *rec)
> +{
> +	return rec->output_max_size &&
> +	       (rec->bytes_written >= rec->output_max_size);
> +}
> +
>  static int record__write(struct record *rec, struct mmap *map __maybe_unused,
>  			 void *bf, size_t size)
>  {
> @@ -135,6 +144,13 @@ static int record__write(struct record *rec, struct mmap *map __maybe_unused,
>  
>  	rec->bytes_written += size;
>  
> +	if (record__output_max_size_exceeded(rec) && !done) {
> +		fprintf(stderr, "[ perf record: perf size limit reached (%lu KB),"
> +				" stopping session ]\n",
> +				rec->bytes_written >> 10);
> +		done = 1;
> +	}
> +
>  	if (switch_output_size(rec))
>  		trigger_hit(&switch_output_trigger);
>  
> @@ -499,7 +515,6 @@ static int record__pushfn(struct mmap *map, void *to, void *bf, size_t size)
>  	return record__write(rec, map, bf, size);
>  }
>  
> -static volatile int done;
>  static volatile int signr = -1;
>  static volatile int child_finished;
>  
> @@ -1984,6 +1999,33 @@ static int record__parse_affinity(const struct option *opt, const char *str, int
>  	return 0;
>  }
>  
> +static int parse_output_max_size(const struct option *opt,
> +				 const char *str, int unset)
> +{
> +	unsigned long *s = (unsigned long *)opt->value;
> +	static struct parse_tag tags_size[] = {
> +		{ .tag  = 'B', .mult = 1       },
> +		{ .tag  = 'K', .mult = 1 << 10 },
> +		{ .tag  = 'M', .mult = 1 << 20 },
> +		{ .tag  = 'G', .mult = 1 << 30 },
> +		{ .tag  = 0 },
> +	};
> +	unsigned long val;
> +
> +	if (unset) {
> +		*s = 0;
> +		return 0;
> +	}
> +
> +	val = parse_tag_value(str, tags_size);
> +	if (val != (unsigned long) -1) {
> +		*s = val;
> +		return 0;
> +	}
> +
> +	return -1;
> +}
> +
>  static int record__parse_mmap_pages(const struct option *opt,
>  				    const char *str,
>  				    int unset __maybe_unused)
> @@ -2311,6 +2353,8 @@ static struct option __record_options[] = {
>  			    "n", "Compressed records using specified level (default: 1 - fastest compression, 22 - greatest compression)",
>  			    record__parse_comp_level),
>  #endif
> +	OPT_CALLBACK(0, "max-size", &record.output_max_size,
> +		     "size", "Limit the maximum size of the output file", parse_output_max_size),
>  	OPT_END()
>  };
>  
> 
