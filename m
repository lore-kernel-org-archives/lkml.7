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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 44089C4CECE
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Oct 2019 14:18:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0D98C2089C
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Oct 2019 14:18:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GRSSKcz3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732697AbfJNOSf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 14 Oct 2019 10:18:35 -0400
Received: from mail-qt1-f195.google.com ([209.85.160.195]:36415 "EHLO
        mail-qt1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732437AbfJNOSc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Oct 2019 10:18:32 -0400
Received: by mail-qt1-f195.google.com with SMTP id o12so25670655qtf.3
        for <linux-kernel@vger.kernel.org>; Mon, 14 Oct 2019 07:18:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=TezNCNHLb5mO/wOLqXzMYidxnO5a6AUY/u+ZC7V9hRA=;
        b=GRSSKcz3V5vEEy5JLAH7+Vd5NLQ3yGxovWB3gVVe+SpPVmiYQdGysEoOjHLqSIspuC
         jCIi3EQ8YjdUNlrGoy2TSxpCdkBRBOB7ku7gDsrzxc8A5aFC1TBDTePBqgjiQw1mvfZU
         6WXdlyd/Vbkv4t9pMEFt7FerScJiI7BiXpWsTnvKp3oEXlmOBD+p64wrJCwaoOao//0Y
         Afiosb9XtKNUuLP5Xq7H2Nq2l+ZDqNY94/kMRXy+wJSWIxmEMcuQcNX6Rpktcr3+uCE4
         8Ant+qpixSiYdNSV0ySGqqlp5onM1gURRQyGIO5TZVoQYXMm7I5a5hfYrBcleLmikSSJ
         N+LQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=TezNCNHLb5mO/wOLqXzMYidxnO5a6AUY/u+ZC7V9hRA=;
        b=Skt9so0NCFoHCI1T+fDc2zZmc4efbUVSpADfMSlc8JQWXEjmVwkwuRQkYBKwT+O9T9
         V5eDPdmxDmMzvOUfyo+7AlQpN+c3fFsoDxfTrGTdoY3V1TFdov8FV0Oy4BqZi2cA6JA6
         m0EUqkPuupLpuP5haRs/4mDPjVpH96GPVUGuv8XUScvsvZOPHoeBLNBHgxyg4vxNblR2
         AOBvgeift5J3ZiIG2fJwfmeRwbbgY25DJ4M4Uu7kE3vvNm+dkRyOdKMPCiXtrq8rt14z
         tS6A5YlrJ/WMf5g3aFHuY5Od3xG0f+Rxs/4iCyCzunHbXK+s+cnerf2/AjDeAyBjg89G
         H5hQ==
X-Gm-Message-State: APjAAAWd7nDHrIp312mctlrkJBdcuEUnD7lVmtqkLXf387oL4KgjP7dC
        L1p2bC8AwwzeDGr2AI4TtKI=
X-Google-Smtp-Source: APXvYqxbcSDTZGFmULFRYnXbUwCcGF7MUyalamktMX8R8E7AlSaFIi1McvhgTPrvENAa90cKqAU+Mg==
X-Received: by 2002:a05:6214:304:: with SMTP id i4mr13746796qvu.147.1571062711594;
        Mon, 14 Oct 2019 07:18:31 -0700 (PDT)
Received: from quaco.ghostprotocols.net ([179.97.35.50])
        by smtp.gmail.com with ESMTPSA id f27sm8138384qtv.85.2019.10.14.07.18.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Oct 2019 07:18:30 -0700 (PDT)
From:   Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>
X-Google-Original-From: Arnaldo Carvalho de Melo <acme@kernel.org>
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 6C9584DD66; Mon, 14 Oct 2019 11:18:28 -0300 (-03)
Date:   Mon, 14 Oct 2019 11:18:28 -0300
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
Subject: Re: [PATCH 2/5] perf annotate: use run-command.h to fork objdump
Message-ID: <20191014141828.GG19627@kernel.org>
References: <20191010183649.23768-1-irogers@google.com>
 <20191010183649.23768-3-irogers@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191010183649.23768-3-irogers@google.com>
X-Url:  http://acmel.wordpress.com
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Thu, Oct 10, 2019 at 11:36:46AM -0700, Ian Rogers escreveu:
> Reduce duplicated logic by using the subcmd library. Ensure when errors
> occur they are reported to the caller. Before this patch, if no lines are
> read the error status is 0.

Thanks, applied and tested.

- Arnaldo
 
> Signed-off-by: Ian Rogers <irogers@google.com>
> ---
>  tools/perf/util/annotate.c | 71 +++++++++++++++++++-------------------
>  1 file changed, 36 insertions(+), 35 deletions(-)
> 
> diff --git a/tools/perf/util/annotate.c b/tools/perf/util/annotate.c
> index 1487849a191a..fc12c5cfe112 100644
> --- a/tools/perf/util/annotate.c
> +++ b/tools/perf/util/annotate.c
> @@ -43,6 +43,7 @@
>  #include <linux/string.h>
>  #include <bpf/libbpf.h>
>  #include <subcmd/parse-options.h>
> +#include <subcmd/run-command.h>
>  
>  /* FIXME: For the HE_COLORSET */
>  #include "ui/browser.h"
> @@ -1843,12 +1844,18 @@ static int symbol__disassemble(struct symbol *sym, struct annotate_args *args)
>  	struct kcore_extract kce;
>  	bool delete_extract = false;
>  	bool decomp = false;
> -	int stdout_fd[2];
>  	int lineno = 0;
>  	int nline;
> -	pid_t pid;
>  	char *line;
>  	size_t line_len;
> +	const char *objdump_argv[] = {
> +		"/bin/sh",
> +		"-c",
> +		NULL, /* Will be the objdump command to run. */
> +		"--",
> +		NULL, /* Will be the symfs path. */
> +	};
> +	struct child_process objdump_process;
>  	int err = dso__disassemble_filename(dso, symfs_filename, sizeof(symfs_filename));
>  
>  	if (err)
> @@ -1878,7 +1885,7 @@ static int symbol__disassemble(struct symbol *sym, struct annotate_args *args)
>  
>  		if (dso__decompress_kmodule_path(dso, symfs_filename,
>  						 tmp, sizeof(tmp)) < 0)
> -			goto out;
> +			return -1;
>  
>  		decomp = true;
>  		strcpy(symfs_filename, tmp);
> @@ -1903,38 +1910,28 @@ static int symbol__disassemble(struct symbol *sym, struct annotate_args *args)
>  
>  	pr_debug("Executing: %s\n", command);
>  
> -	err = -1;
> -	if (pipe(stdout_fd) < 0) {
> -		pr_err("Failure creating the pipe to run %s\n", command);
> -		goto out_free_command;
> -	}
> -
> -	pid = fork();
> -	if (pid < 0) {
> -		pr_err("Failure forking to run %s\n", command);
> -		goto out_close_stdout;
> -	}
> +	objdump_argv[2] = command;
> +	objdump_argv[4] = symfs_filename;
>  
> -	if (pid == 0) {
> -		close(stdout_fd[0]);
> -		dup2(stdout_fd[1], 1);
> -		close(stdout_fd[1]);
> -		execl("/bin/sh", "sh", "-c", command, "--", symfs_filename,
> -		      NULL);
> -		perror(command);
> -		exit(-1);
> +	/* Create a pipe to read from for stdout */
> +	memset(&objdump_process, 0, sizeof(objdump_process));
> +	objdump_process.argv = objdump_argv;
> +	objdump_process.out = -1;
> +	if (start_command(&objdump_process)) {
> +		pr_err("Failure starting to run %s\n", command);
> +		err = -1;
> +		goto out_free_command;
>  	}
>  
> -	close(stdout_fd[1]);
> -
> -	file = fdopen(stdout_fd[0], "r");
> +	file = fdopen(objdump_process.out, "r");
>  	if (!file) {
>  		pr_err("Failure creating FILE stream for %s\n", command);
>  		/*
>  		 * If we were using debug info should retry with
>  		 * original binary.
>  		 */
> -		goto out_free_command;
> +		err = -1;
> +		goto out_close_stdout;
>  	}
>  
>  	/* Storage for getline. */
> @@ -1958,8 +1955,14 @@ static int symbol__disassemble(struct symbol *sym, struct annotate_args *args)
>  	}
>  	free(line);
>  
> -	if (nline == 0)
> +	err = finish_command(&objdump_process);
> +	if (err)
> +		pr_err("Error running %s\n", command);
> +
> +	if (nline == 0) {
> +		err = -1;
>  		pr_err("No output from %s\n", command);
> +	}
>  
>  	/*
>  	 * kallsyms does not have symbol sizes so there may a nop at the end.
> @@ -1969,23 +1972,21 @@ static int symbol__disassemble(struct symbol *sym, struct annotate_args *args)
>  		delete_last_nop(sym);
>  
>  	fclose(file);
> -	err = 0;
> +
> +out_close_stdout:
> +	close(objdump_process.out);
> +
>  out_free_command:
>  	free(command);
> -out_remove_tmp:
> -	close(stdout_fd[0]);
>  
> +out_remove_tmp:
>  	if (decomp)
>  		unlink(symfs_filename);
>  
>  	if (delete_extract)
>  		kcore_extract__delete(&kce);
> -out:
> -	return err;
>  
> -out_close_stdout:
> -	close(stdout_fd[1]);
> -	goto out_free_command;
> +	return err;
>  }
>  
>  static void calc_percent(struct sym_hist *sym_hist,
> -- 
> 2.23.0.581.g78d2f28ef7-goog

-- 

- Arnaldo
