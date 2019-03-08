Return-Path: <SRS0=vL1f=RL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A902CC43381
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Mar 2019 13:48:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6D50A20661
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Mar 2019 13:48:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cpkW0r4w"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726818AbfCHNsD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 Mar 2019 08:48:03 -0500
Received: from mail-qt1-f194.google.com ([209.85.160.194]:34945 "EHLO
        mail-qt1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726706AbfCHNsB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Mar 2019 08:48:01 -0500
Received: by mail-qt1-f194.google.com with SMTP id p48so21203896qtk.2;
        Fri, 08 Mar 2019 05:48:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=4cqH/vMiilAoLU7o74OI1+XL863DVUO81m6It+kmtJ0=;
        b=cpkW0r4w7ZrbigzgUOemjrF8lThiQOthUWv5+EsC8ImFo/gfpaOOycEA4a3VDGMXyr
         a01+CuZzP2tush1mq0KmRZnIMfbpIg9/DUpV4MBLSVPRtcmofW5ROMJ3M2p32eTN+glB
         PcmXo/ZOqnv1I9zvSYW5XznV0fUzTGT/Ti9S0Vi8//wgcFxiZUnf0bieJmZTyTuTjJh4
         Z9jfzD89bIuSvU9fPGe4IjA8KX28eSxKJ3XbNKfIkK8rafc0L6R7KUCaW/vq342pw7nl
         cviZQYdcilrWlwuEvgcI3prLlMVkGP+qmH8EEQ/H5PX1gcIvicd2RZ1bBlpxlgcpVfTK
         k7Uw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=4cqH/vMiilAoLU7o74OI1+XL863DVUO81m6It+kmtJ0=;
        b=No7kwRjMoMZlJEySs8j8sw4rjPDhpnbp11gO/uTqlme/Y+0xwgAbJzdDAs7k10f/Cg
         i7MfGrb4pk1U0cs+uxPakExKZC5iPSOvbLn66gYP3U1pIj3PA5wWsIUo8vh2PBOVzEKw
         XgK9lapuDTOD94sz2yGZvv+oZZhhGk13d2WKxxODzGSR1xf5Rkk9AvT/xgNQcTk7U7Tw
         N3hVAktPf1wGTujaftltiN6htG3LHExMEXm1sZQkXZmW9gJt1rS2PzNCeXwnd5A73QHU
         M2/Cap/1ud4JoAo30xWNXAOfxTw9it61k89XlnTolPgRJLiEGJ5S+Xi2wGxP4gTtHOEs
         pydg==
X-Gm-Message-State: APjAAAU8D7TxHbEGhrzNNDu8n5O/lhUC/mdNp1KR4k58HC1MgDmFC1yQ
        47981IxJ5Yn0OaJF3cX8GaI=
X-Google-Smtp-Source: APXvYqxwe00CFXcHmxbYDHoZA/06wV4qpze5gsJoCiyBGkntahYCCR/ztjmEHppJynhhvlE0i/yb4A==
X-Received: by 2002:a0c:b7a1:: with SMTP id l33mr15200174qve.160.1552052879746;
        Fri, 08 Mar 2019 05:47:59 -0800 (PST)
Received: from quaco.ghostprotocols.net (177-59-154-188.3g.claro.net.br. [177.59.154.188])
        by smtp.gmail.com with ESMTPSA id z140sm3859308qka.81.2019.03.08.05.47.58
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 08 Mar 2019 05:47:59 -0800 (PST)
From:   Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>
X-Google-Original-From: Arnaldo Carvalho de Melo <acme@kernel.org>
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id D87B14039C; Fri,  8 Mar 2019 10:47:54 -0300 (-03)
Date:   Fri, 8 Mar 2019 10:47:54 -0300
To:     Andi Kleen <andi@firstfloor.org>
Cc:     Feng Tang <feng.tang@intel.com>, jolsa@kernel.org,
        namhyung@kernel.org, linux-kernel@vger.kernel.org,
        linux-perf-users@vger.kernel.org, Andi Kleen <ak@linux.intel.com>
Subject: Re: [PATCH v4 07/15] perf tools report: Use less for scripts output
Message-ID: <20190308134754.GD26260@kernel.org>
References: <20190305144758.12397-1-andi@firstfloor.org>
 <20190305144758.12397-8-andi@firstfloor.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190305144758.12397-8-andi@firstfloor.org>
X-Url:  http://acmel.wordpress.com
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Tue, Mar 05, 2019 at 06:47:50AM -0800, Andi Kleen escreveu:
> From: Andi Kleen <ak@linux.intel.com>
> 
> The UI viewer for scripts output has a lot of limitations: limited size,
> no search or save function, slow, and various other issues.
> 
> Just use 'less' to display directly on the terminal instead.

I'm ok with this, CCing Feng tho since he contributed this browser, to
let him know.

- Arnaldo
 
> This won't work in gtk mode, but gtk doesn't support these
> context menus anyways. If that is ever done could use an terminal
> for the output.
> 
> Signed-off-by: Andi Kleen <ak@linux.intel.com>
> 
> ---
> 
> v2:
> Remove some unneeded headers
> ---
>  tools/perf/ui/browsers/scripts.c | 130 ++++---------------------------
>  1 file changed, 17 insertions(+), 113 deletions(-)
> 
> diff --git a/tools/perf/ui/browsers/scripts.c b/tools/perf/ui/browsers/scripts.c
> index 90a32ac69e76..7f36630694bf 100644
> --- a/tools/perf/ui/browsers/scripts.c
> +++ b/tools/perf/ui/browsers/scripts.c
> @@ -1,35 +1,12 @@
>  // SPDX-License-Identifier: GPL-2.0
> -#include <elf.h>
> -#include <inttypes.h>
> -#include <sys/ttydefaults.h>
> -#include <string.h>
>  #include "../../util/sort.h"
>  #include "../../util/util.h"
>  #include "../../util/hist.h"
>  #include "../../util/debug.h"
>  #include "../../util/symbol.h"
>  #include "../browser.h"
> -#include "../helpline.h"
>  #include "../libslang.h"
>  
> -/* 2048 lines should be enough for a script output */
> -#define MAX_LINES		2048
> -
> -/* 160 bytes for one output line */
> -#define AVERAGE_LINE_LEN	160
> -
> -struct script_line {
> -	struct list_head node;
> -	char line[AVERAGE_LINE_LEN];
> -};
> -
> -struct perf_script_browser {
> -	struct ui_browser b;
> -	struct list_head entries;
> -	const char *script_name;
> -	int nr_lines;
> -};
> -
>  #define SCRIPT_NAMELEN	128
>  #define SCRIPT_MAX_NO	64
>  /*
> @@ -73,69 +50,29 @@ static int list_scripts(char *script_name)
>  	return ret;
>  }
>  
> -static void script_browser__write(struct ui_browser *browser,
> -				   void *entry, int row)
> +static void run_script(char *cmd)
>  {
> -	struct script_line *sline = list_entry(entry, struct script_line, node);
> -	bool current_entry = ui_browser__is_current_entry(browser, row);
> -
> -	ui_browser__set_color(browser, current_entry ? HE_COLORSET_SELECTED :
> -						       HE_COLORSET_NORMAL);
> -
> -	ui_browser__write_nstring(browser, sline->line, browser->width);
> +	pr_debug("Running %s\n", cmd);
> +	SLang_reset_tty();
> +	if (system(cmd) < 0)
> +		pr_warning("Cannot run %s\n", cmd);
> +	/*
> +	 * SLang doesn't seem to reset the whole terminal, so be more
> +	 * forceful to get back to the original state.
> +	 */
> +	printf("\033[c\033[H\033[J");
> +	fflush(stdout);
> +	SLang_init_tty(0, 0, 0);
> +	SLsmg_refresh();
>  }
>  
> -static int script_browser__run(struct perf_script_browser *browser)
> -{
> -	int key;
> -
> -	if (ui_browser__show(&browser->b, browser->script_name,
> -			     "Press ESC to exit") < 0)
> -		return -1;
> -
> -	while (1) {
> -		key = ui_browser__run(&browser->b, 0);
> -
> -		/* We can add some special key handling here if needed */
> -		break;
> -	}
> -
> -	ui_browser__hide(&browser->b);
> -	return key;
> -}
> -
> -
>  int script_browse(const char *script_opt)
>  {
>  	char cmd[SCRIPT_FULLPATH_LEN*2], script_name[SCRIPT_FULLPATH_LEN];
> -	char *line = NULL;
> -	size_t len = 0;
> -	ssize_t retlen;
> -	int ret = -1, nr_entries = 0;
> -	FILE *fp;
> -	void *buf;
> -	struct script_line *sline;
> -
> -	struct perf_script_browser script = {
> -		.b = {
> -			.refresh    = ui_browser__list_head_refresh,
> -			.seek	    = ui_browser__list_head_seek,
> -			.write	    = script_browser__write,
> -		},
> -		.script_name = script_name,
> -	};
> -
> -	INIT_LIST_HEAD(&script.entries);
> -
> -	/* Save each line of the output in one struct script_line object. */
> -	buf = zalloc((sizeof(*sline)) * MAX_LINES);
> -	if (!buf)
> -		return -1;
> -	sline = buf;
>  
>  	memset(script_name, 0, SCRIPT_FULLPATH_LEN);
>  	if (list_scripts(script_name))
> -		goto exit;
> +		return -1;
>  
>  	sprintf(cmd, "perf script -s %s ", script_name);
>  
> @@ -147,42 +84,9 @@ int script_browse(const char *script_opt)
>  		strcat(cmd, input_name);
>  	}
>  
> -	strcat(cmd, " 2>&1");
> -
> -	fp = popen(cmd, "r");
> -	if (!fp)
> -		goto exit;
> -
> -	while ((retlen = getline(&line, &len, fp)) != -1) {
> -		strncpy(sline->line, line, AVERAGE_LINE_LEN);
> -
> -		/* If one output line is very large, just cut it short */
> -		if (retlen >= AVERAGE_LINE_LEN) {
> -			sline->line[AVERAGE_LINE_LEN - 1] = '\0';
> -			sline->line[AVERAGE_LINE_LEN - 2] = '\n';
> -		}
> -		list_add_tail(&sline->node, &script.entries);
> -
> -		if (script.b.width < retlen)
> -			script.b.width = retlen;
> -
> -		if (nr_entries++ >= MAX_LINES - 1)
> -			break;
> -		sline++;
> -	}
> -
> -	if (script.b.width > AVERAGE_LINE_LEN)
> -		script.b.width = AVERAGE_LINE_LEN;
> -
> -	free(line);
> -	pclose(fp);
> +	strcat(cmd, " 2>&1 | less");
>  
> -	script.nr_lines = nr_entries;
> -	script.b.nr_entries = nr_entries;
> -	script.b.entries = &script.entries;
> +	run_script(cmd);
>  
> -	ret = script_browser__run(&script);
> -exit:
> -	free(buf);
> -	return ret;
> +	return 0;
>  }
> -- 
> 2.20.1

-- 

- Arnaldo
