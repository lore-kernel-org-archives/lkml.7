Return-Path: <SRS0=TxL2=YH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4763FC4CECE
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Oct 2019 14:24:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 19A672067B
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Oct 2019 14:24:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WXreJVHa"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732713AbfJNOYm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 14 Oct 2019 10:24:42 -0400
Received: from mail-qt1-f194.google.com ([209.85.160.194]:45624 "EHLO
        mail-qt1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732262AbfJNOYm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Oct 2019 10:24:42 -0400
Received: by mail-qt1-f194.google.com with SMTP id c21so25625755qtj.12
        for <linux-kernel@vger.kernel.org>; Mon, 14 Oct 2019 07:24:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=cNNmD1evnUW4Uuwpv89whDpLgyDeTyku2sEfm+LLLhM=;
        b=WXreJVHaK3CPdCTaFvjzn23vpcixyBCy/c1RhmrBq7CrHG8iAO5g6Sb+EKfnwAzuPW
         l3ZgCLVaOxlRkwiMY/4E4Cwva+mAC26tqssGKU5Ld209HzOHduY31bIlC6Awr4sT9WIo
         AoBRZ+k1iihZDJoeB3VoqguN436Qp5hsjlOBRT2sotfwko/xPY/j7FAckQi5eRICj5od
         ZYk40OhTMgW84zKIwDK1w6+t5FyJYa7mGM5mCtI0Qm6bvxD+OrtMsdrRP3VXJa99YQKY
         /xYXXIn+VsGiOGR+uKAnXOxX4kVUId/e9FYgo8zleb9vlEFY5v9x6HFM8g5vQ9bUglUG
         s7zA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=cNNmD1evnUW4Uuwpv89whDpLgyDeTyku2sEfm+LLLhM=;
        b=ccX9sO0FPtTD40a5YPgJBpuebiDmK5+3DlDL7y0lgejUHRlWST1/U9xqFjEWaKNLsk
         lZqrdfZ1aN64CyLu76NoeWzDdddrSD76P7bMtlxO9VlSYAtcjhpInbqVjLmGmiggQHAr
         foW+zUL7Hy/1aLK6kVy2PSY7maTy/XgDV+fZ5zX+q0yt2IsOUPL5GgLRKcYszPZ3s/46
         nXHnGaObOUFEbIS6sI222hxvVua1uEZfOLo1wZHtw56UnVl83gXIs2vhpr6v349c67SL
         H3bTj95UmMluaYSlI1H5hZdkXiEUFrHkgUKoCMKL/tFZ6Z+VcI69EXlNQc31Hmpr+arw
         /TCg==
X-Gm-Message-State: APjAAAXHgWuE1qkmNbwbJ/0E/VtguK88zbxpZtdJbA4et6+dIhtNU+xM
        NJsUTFPbQ6sr8Dlqb7B+neI=
X-Google-Smtp-Source: APXvYqzXiw15A57KyWQEK9TTlYfQt1DEgc8TyAjmiIfkpgijmxdneQrFUOJf08Er8G+cl3DNFYVanA==
X-Received: by 2002:a0c:f787:: with SMTP id s7mr31176806qvn.221.1571063079455;
        Mon, 14 Oct 2019 07:24:39 -0700 (PDT)
Received: from quaco.ghostprotocols.net ([179.97.35.50])
        by smtp.gmail.com with ESMTPSA id d55sm11810467qta.41.2019.10.14.07.24.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Oct 2019 07:24:38 -0700 (PDT)
From:   Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>
X-Google-Original-From: Arnaldo Carvalho de Melo <acme@kernel.org>
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id ADA324DD66; Mon, 14 Oct 2019 11:24:36 -0300 (-03)
Date:   Mon, 14 Oct 2019 11:24:36 -0300
To:     Ian Rogers <irogers@google.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Jin Yao <yao.jin@linux.intel.com>,
        Song Liu <songliubraving@fb.com>, linux-kernel@vger.kernel.org,
        clang-built-linux@googlegroups.com,
        Stephane Eranian <eranian@google.com>
Subject: Re: [PATCH 4/5] perf annotate: don't pipe objdump output through
 expand
Message-ID: <20191014142436.GJ19627@kernel.org>
References: <20191010183649.23768-1-irogers@google.com>
 <20191010183649.23768-5-irogers@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191010183649.23768-5-irogers@google.com>
X-Url:  http://acmel.wordpress.com
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Thu, Oct 10, 2019 at 11:36:48AM -0700, Ian Rogers escreveu:
> Avoiding a pipe allows objdump command failures to surface.
> Move to the caller of symbol__parse_objdump_line the call to strim
> that removes leading and trailing tabs.
> Add a new expand_tabs function that if a tab is present allocate a new
> line in which tabs are expanded.
> In symbol__parse_objdump_line the line had no leading spaces, so
> simplify the line_ip processing.

Thanks, applied.
 
> Signed-off-by: Ian Rogers <irogers@google.com>
> ---
>  tools/perf/util/annotate.c | 95 ++++++++++++++++++++++++++++++--------
>  1 file changed, 76 insertions(+), 19 deletions(-)
> 
> diff --git a/tools/perf/util/annotate.c b/tools/perf/util/annotate.c
> index 0a7a6f3c55f4..3d5b9236576a 100644
> --- a/tools/perf/util/annotate.c
> +++ b/tools/perf/util/annotate.c
> @@ -1488,35 +1488,24 @@ annotation_line__print(struct annotation_line *al, struct symbol *sym, u64 start
>   */
>  static int symbol__parse_objdump_line(struct symbol *sym,
>  				      struct annotate_args *args,
> -				      char *line, int *line_nr)
> +				      char *parsed_line, int *line_nr)
>  {
>  	struct map *map = args->ms.map;
>  	struct annotation *notes = symbol__annotation(sym);
>  	struct disasm_line *dl;
> -	char *parsed_line, *tmp, *tmp2;
> +	char *tmp;
>  	s64 line_ip, offset = -1;
>  	regmatch_t match[2];
>  
> -	line_ip = -1;
> -	parsed_line = strim(line);
> -
>  	/* /filename:linenr ? Save line number and ignore. */
>  	if (regexec(&file_lineno, parsed_line, 2, match, 0) == 0) {
>  		*line_nr = atoi(parsed_line + match[1].rm_so);
>  		return 0;
>  	}
>  
> -	tmp = skip_spaces(parsed_line);
> -	if (*tmp) {
> -		/*
> -		 * Parse hexa addresses followed by ':'
> -		 */
> -		line_ip = strtoull(tmp, &tmp2, 16);
> -		if (*tmp2 != ':' || tmp == tmp2 || tmp2[1] == '\0')
> -			line_ip = -1;
> -	}
> -
> -	if (line_ip != -1) {
> +	/* Process hex address followed by ':'. */
> +	line_ip = strtoull(parsed_line, &tmp, 16);
> +	if (parsed_line != tmp && tmp[0] == ':' && tmp[1] != '\0') {
>  		u64 start = map__rip_2objdump(map, sym->start),
>  		    end = map__rip_2objdump(map, sym->end);
>  
> @@ -1524,7 +1513,7 @@ static int symbol__parse_objdump_line(struct symbol *sym,
>  		if ((u64)line_ip < start || (u64)line_ip >= end)
>  			offset = -1;
>  		else
> -			parsed_line = tmp2 + 1;
> +			parsed_line = tmp + 1;
>  	}
>  
>  	args->offset  = offset;
> @@ -1833,6 +1822,67 @@ static int symbol__disassemble_bpf(struct symbol *sym __maybe_unused,
>  }
>  #endif // defined(HAVE_LIBBFD_SUPPORT) && defined(HAVE_LIBBPF_SUPPORT)
>  
> +/*
> + * Possibly create a new version of line with tabs expanded. Returns the
> + * existing or new line, storage is updated if a new line is allocated. If
> + * allocation fails then NULL is returned.
> + */
> +static char *expand_tabs(char *line, char **storage, size_t *storage_len)
> +{
> +	size_t i, src, dst, len, new_storage_len, num_tabs;
> +	char *new_line;
> +	size_t line_len = strlen(line);
> +
> +	for (num_tabs = 0, i = 0; i < line_len; i++)
> +		if (line[i] == '\t')
> +			num_tabs++;
> +
> +	if (num_tabs == 0)
> +		return line;
> +
> +	/*
> +	 * Space for the line and '\0', less the leading and trailing
> +	 * spaces. Each tab may introduce 7 additional spaces.
> +	 */
> +	new_storage_len = line_len + 1 + (num_tabs * 7);
> +
> +	new_line = malloc(new_storage_len);
> +	if (new_line == NULL) {
> +		pr_err("Failure allocating memory for tab expansion\n");
> +		return NULL;
> +	}
> +
> +	/*
> +	 * Copy regions starting at src and expand tabs. If there are two
> +	 * adjacent tabs then 'src == i', the memcpy is of size 0 and the spaces
> +	 * are inserted.
> +	 */
> +	for (i = 0, src = 0, dst = 0; i < line_len && num_tabs; i++) {
> +		if (line[i] == '\t') {
> +			len = i - src;
> +			memcpy(&new_line[dst], &line[src], len);
> +			dst += len;
> +			new_line[dst++] = ' ';
> +			while (dst % 8 != 0)
> +				new_line[dst++] = ' ';
> +			src = i + 1;
> +			num_tabs--;
> +		}
> +	}
> +
> +	/* Expand the last region. */
> +	len = line_len + 1 - src;
> +	memcpy(&new_line[dst], &line[src], len);
> +	dst += len;
> +	new_line[dst] = '\0';
> +
> +	free(*storage);
> +	*storage = new_line;
> +	*storage_len = new_storage_len;
> +	return new_line;
> +
> +}
> +
>  static int symbol__disassemble(struct symbol *sym, struct annotate_args *args)
>  {
>  	struct annotation_options *opts = args->options;
> @@ -1894,7 +1944,7 @@ static int symbol__disassemble(struct symbol *sym, struct annotate_args *args)
>  	err = asprintf(&command,
>  		 "%s %s%s --start-address=0x%016" PRIx64
>  		 " --stop-address=0x%016" PRIx64
> -		 " -l -d %s %s -C \"$1\" 2>/dev/null|expand",
> +		 " -l -d %s %s -C \"$1\" 2>/dev/null",
>  		 opts->objdump_path ?: "objdump",
>  		 opts->disassembler_style ? "-M " : "",
>  		 opts->disassembler_style ?: "",
> @@ -1941,6 +1991,7 @@ static int symbol__disassemble(struct symbol *sym, struct annotate_args *args)
>  	nline = 0;
>  	while (!feof(file)) {
>  		const char *match;
> +		char *expanded_line;
>  
>  		if (getline(&line, &line_len, file) < 0 || !line)
>  			break;
> @@ -1950,13 +2001,19 @@ static int symbol__disassemble(struct symbol *sym, struct annotate_args *args)
>  		if (match && match[strlen(symfs_filename)] == ':')
>  			continue;
>  
> +		expanded_line = strim(line);
> +		expanded_line = expand_tabs(expanded_line, &line, &line_len);
> +		if (!expanded_line)
> +			break;
> +
>  		/*
>  		 * The source code line number (lineno) needs to be kept in
>  		 * across calls to symbol__parse_objdump_line(), so that it
>  		 * can associate it with the instructions till the next one.
>  		 * See disasm_line__new() and struct disasm_line::line_nr.
>  		 */
> -		if (symbol__parse_objdump_line(sym, args, line, &lineno) < 0)
> +		if (symbol__parse_objdump_line(sym, args, expanded_line,
> +					       &lineno) < 0)
>  			break;
>  		nline++;
>  	}
> -- 
> 2.23.0.581.g78d2f28ef7-goog

-- 

- Arnaldo
