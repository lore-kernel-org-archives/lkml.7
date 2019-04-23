Return-Path: <SRS0=LehB=SZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 97FECC10F14
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Apr 2019 09:33:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6308B20811
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Apr 2019 09:33:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727212AbfDWJdl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Apr 2019 05:33:41 -0400
Received: from mga14.intel.com ([192.55.52.115]:30189 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725888AbfDWJdk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Apr 2019 05:33:40 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga103.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 23 Apr 2019 02:33:35 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.60,385,1549958400"; 
   d="scan'208";a="318191254"
Received: from ahunter-desktop.fi.intel.com (HELO [10.237.72.198]) ([10.237.72.198])
  by orsmga005.jf.intel.com with ESMTP; 23 Apr 2019 02:33:32 -0700
Subject: Re: [PATCH 06/12] perf tools: Do not erase uncovered maps by kcore
To:     Jiri Olsa <jolsa@kernel.org>,
        Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     lkml <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Andi Kleen <ak@linux.intel.com>,
        Song Liu <songliubraving@fb.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>
References: <20190416160127.30203-1-jolsa@kernel.org>
 <20190416160127.30203-7-jolsa@kernel.org>
From:   Adrian Hunter <adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki,
 Business Identity Code: 0357606 - 4, Domiciled in Helsinki
Message-ID: <5cd0aadb-8bfc-2e97-4260-459b076aba2d@intel.com>
Date:   Tue, 23 Apr 2019 12:32:12 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190416160127.30203-7-jolsa@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 16/04/19 7:01 PM, Jiri Olsa wrote:
> Maps in kcore do not cover bpf maps, so we can't just
> remove everything. Keeping all kernel maps, which are
> not covered by kcore maps.

Memory for jited-bpf is allocated from the same area that is used for
modules.  In the case of /proc/kcore, that entire area is mapped, so there
won't be any bpf-maps that are not covered.  For copies of kcore made by
'perf buildid-cache' the same would be true for any bpf that got allocated
in between modules.

But shouldn't the bpf map supersede the kcore map for the address range that
it maps?  I guess that would mean splitting the kcore map, truncating the
first piece and inserting the bpf map in between.

> 
> Link: http://lkml.kernel.org/n/tip-9eytka8wofp0a047ul6lmejk@git.kernel.org
> Signed-off-by: Jiri Olsa <jolsa@kernel.org>
> ---
>  tools/perf/util/symbol.c | 14 +++++++++++++-
>  1 file changed, 13 insertions(+), 1 deletion(-)
> 
> diff --git a/tools/perf/util/symbol.c b/tools/perf/util/symbol.c
> index 5cbad55cd99d..96738a7a8c14 100644
> --- a/tools/perf/util/symbol.c
> +++ b/tools/perf/util/symbol.c
> @@ -1166,6 +1166,18 @@ static int kcore_mapfn(u64 start, u64 len, u64 pgoff, void *data)
>  	return 0;
>  }
>  
> +static bool in_kcore(struct kcore_mapfn_data *md, struct map *map)
> +{
> +	struct map *iter;
> +
> +	list_for_each_entry(iter, &md->maps, node) {
> +		if ((map->start >= iter->start) && (map->start < iter->end))
> +			return true;
> +	}
> +
> +	return false;
> +}
> +
>  static int dso__load_kcore(struct dso *dso, struct map *map,
>  			   const char *kallsyms_filename)
>  {
> @@ -1222,7 +1234,7 @@ static int dso__load_kcore(struct dso *dso, struct map *map,
>  	while (old_map) {
>  		struct map *next = map_groups__next(old_map);
>  
> -		if (old_map != map)
> +		if (old_map != map && !in_kcore(&md, old_map))
>  			map_groups__remove(kmaps, old_map);
>  		old_map = next;
>  	}
> 

