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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 09BA2ECE587
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Oct 2019 14:15:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D49EE2083B
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Oct 2019 14:15:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cJEZ1P4/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732591AbfJNOPI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 14 Oct 2019 10:15:08 -0400
Received: from mail-qt1-f195.google.com ([209.85.160.195]:41042 "EHLO
        mail-qt1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732330AbfJNOPH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Oct 2019 10:15:07 -0400
Received: by mail-qt1-f195.google.com with SMTP id v52so25606120qtb.8
        for <linux-kernel@vger.kernel.org>; Mon, 14 Oct 2019 07:15:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=RvSIS75IS1YgJC9gP4/dhSk5DagD+UPGjoBY9RJ/+OU=;
        b=cJEZ1P4/AnJKzL4Erz6Xl15Id6yxUwNdBjEHd6frBQdld568mbNfbWa6Ls0md3SNjm
         ABjWM4atLU0rbNp5BbT2z/yeHF/Js6czZi/I4Sxl+XcnYrI3Mk/WRLE9KWOM8r2L2FxX
         6n88vAPmljlm+gpPJjU5GOqcV+kZjtEu2JtYhUn+S3v5OOUE1JeiuxV6fxgc68TZLL0p
         /9kfh/7hta6GwBkGJVpPJgaeGpFKC6Ki5zd0R3S+AdyFrXObLqWaSMlP/Dh6dK2Vs49k
         QVYxU29afV5s58IwFH6D8a3u/XopFPYF/pklBqx6V2C8QDGXB/4UUPtWq9pkALMdxGZh
         AN9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=RvSIS75IS1YgJC9gP4/dhSk5DagD+UPGjoBY9RJ/+OU=;
        b=ezW0KhZIZDXLpEsgMgI+GTcTXvwQShNmXS3TDaunMmgZboAC5EhrEaNlkCHIR88/yQ
         T4j4ewRQPBvLEUH74SXJECZKE7hdf2GFUAYlyXjn3LyI2xZBiOFYXqDHEa7Ee0Y09kGs
         KNpDEbklWPmxuTsRdduZfjssMC38PnQ3Nb1R/e+E4/4+KfsOyKnbjDQHAiZvbbsFePZ6
         1pXPhRHO0PRNMUJQbmzVSaimHeodBX2v9WXgQsKkoeuZ4IlRBZ9mpDv5XfsXRM38R2Eq
         fuY5OuKMiUYXAikNUxf5CTVpVylLx5QxKgyMncuz1+ekutkCN/0+peXiMRMDsdX4/eYL
         zw/A==
X-Gm-Message-State: APjAAAV5I3VPM6wO5QKbZCaRow3xLEJ8W/RKBLJ7mkwau9W+byZpde6R
        6bd+MCAApFsVNMVUF5SsP1A=
X-Google-Smtp-Source: APXvYqzxz4flvkjavG3XNjxGtdZRV2CDHad8uob2HDWtSG/mHegwighhJYVDJlqg2wS9ElAGr6MEtg==
X-Received: by 2002:ac8:2a5d:: with SMTP id l29mr32029160qtl.314.1571062506349;
        Mon, 14 Oct 2019 07:15:06 -0700 (PDT)
Received: from quaco.ghostprotocols.net ([179.97.35.50])
        by smtp.gmail.com with ESMTPSA id z5sm9040492qtb.49.2019.10.14.07.15.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Oct 2019 07:15:05 -0700 (PDT)
From:   Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>
X-Google-Original-From: Arnaldo Carvalho de Melo <acme@kernel.org>
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id B11BE4DD66; Mon, 14 Oct 2019 11:15:03 -0300 (-03)
Date:   Mon, 14 Oct 2019 11:15:03 -0300
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
Subject: Re: [PATCH 1/5] perf annotate: avoid reallocation in objdump parsing
Message-ID: <20191014141503.GF19627@kernel.org>
References: <20191010183649.23768-1-irogers@google.com>
 <20191010183649.23768-2-irogers@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191010183649.23768-2-irogers@google.com>
X-Url:  http://acmel.wordpress.com
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Thu, Oct 10, 2019 at 11:36:45AM -0700, Ian Rogers escreveu:
> Objdump output is parsed using getline which allocates memory for the
> read. Getline will realloc if the memory is too small, but currently the
> line is always freed after the call.
> Simplify parse_objdump_line by performing the reading in symbol__disassemble.

Thanks, applied.

- Arnaldo
 
> Signed-off-by: Ian Rogers <irogers@google.com>
> ---
>  tools/perf/util/annotate.c | 26 ++++++++++++++------------
>  1 file changed, 14 insertions(+), 12 deletions(-)
> 
> diff --git a/tools/perf/util/annotate.c b/tools/perf/util/annotate.c
> index e830eadfca2a..1487849a191a 100644
> --- a/tools/perf/util/annotate.c
> +++ b/tools/perf/util/annotate.c
> @@ -1485,24 +1485,17 @@ annotation_line__print(struct annotation_line *al, struct symbol *sym, u64 start
>   * means that it's not a disassembly line so should be treated differently.
>   * The ops.raw part will be parsed further according to type of the instruction.
>   */
> -static int symbol__parse_objdump_line(struct symbol *sym, FILE *file,
> +static int symbol__parse_objdump_line(struct symbol *sym,
>  				      struct annotate_args *args,
> -				      int *line_nr)
> +				      char *line, int *line_nr)
>  {
>  	struct map *map = args->ms.map;
>  	struct annotation *notes = symbol__annotation(sym);
>  	struct disasm_line *dl;
> -	char *line = NULL, *parsed_line, *tmp, *tmp2;
> -	size_t line_len;
> +	char *parsed_line, *tmp, *tmp2;
>  	s64 line_ip, offset = -1;
>  	regmatch_t match[2];
>  
> -	if (getline(&line, &line_len, file) < 0)
> -		return -1;
> -
> -	if (!line)
> -		return -1;
> -
>  	line_ip = -1;
>  	parsed_line = strim(line);
>  
> @@ -1539,7 +1532,6 @@ static int symbol__parse_objdump_line(struct symbol *sym, FILE *file,
>  	args->ms.sym  = sym;
>  
>  	dl = disasm_line__new(args);
> -	free(line);
>  	(*line_nr)++;
>  
>  	if (dl == NULL)
> @@ -1855,6 +1847,8 @@ static int symbol__disassemble(struct symbol *sym, struct annotate_args *args)
>  	int lineno = 0;
>  	int nline;
>  	pid_t pid;
> +	char *line;
> +	size_t line_len;
>  	int err = dso__disassemble_filename(dso, symfs_filename, sizeof(symfs_filename));
>  
>  	if (err)
> @@ -1943,18 +1937,26 @@ static int symbol__disassemble(struct symbol *sym, struct annotate_args *args)
>  		goto out_free_command;
>  	}
>  
> +	/* Storage for getline. */
> +	line = NULL;
> +	line_len = 0;
> +
>  	nline = 0;
>  	while (!feof(file)) {
> +		if (getline(&line, &line_len, file) < 0 || !line)
> +			break;
> +
>  		/*
>  		 * The source code line number (lineno) needs to be kept in
>  		 * across calls to symbol__parse_objdump_line(), so that it
>  		 * can associate it with the instructions till the next one.
>  		 * See disasm_line__new() and struct disasm_line::line_nr.
>  		 */
> -		if (symbol__parse_objdump_line(sym, file, args, &lineno) < 0)
> +		if (symbol__parse_objdump_line(sym, args, line, &lineno) < 0)
>  			break;
>  		nline++;
>  	}
> +	free(line);
>  
>  	if (nline == 0)
>  		pr_err("No output from %s\n", command);
> -- 
> 2.23.0.581.g78d2f28ef7-goog

-- 

- Arnaldo
