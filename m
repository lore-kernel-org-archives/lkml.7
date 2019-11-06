Return-Path: <SRS0=fWiu=Y6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9479C5DF63
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Nov 2019 19:54:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 789EA217F4
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Nov 2019 19:54:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dhqmFKL6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732482AbfKFTyj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 Nov 2019 14:54:39 -0500
Received: from mail-qv1-f67.google.com ([209.85.219.67]:42326 "EHLO
        mail-qv1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726713AbfKFTyj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Nov 2019 14:54:39 -0500
Received: by mail-qv1-f67.google.com with SMTP id c9so1961712qvz.9
        for <linux-kernel@vger.kernel.org>; Wed, 06 Nov 2019 11:54:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=GSZh3sqy9pU/vbbetAGWoOCvH3XVCaoW7AIACle/Tm4=;
        b=dhqmFKL6biYVH+aybdDF7HLGLTK+vvt/YK+KRRQ3v/ePAjzeT6PdMIrqR8XVD/4Sx2
         opQrGamMkXXBBmez8OrZibcwlEqmoxHAlDWmrxc2UhMT4McDI0zqDk9ZGVRxPLDOnUFb
         9lEPkuC2pO0/9Z/P8VQxL9GMP0lgXStrlXQqQykA+rivaUDm3tNw7LXNvYYA2wLdBzYP
         E4R9tez3/F/5qrqo/IXc8KG1le7qWyhHqv7Bgycy21YjKdfM9wSqBQr5czD8hNQS3O6k
         pQqS5vC05flUPDzq0qMSRa+Vbw9T2KDU2JHT7RN45zG+g6YIrFSQ15X06bPi/0E5tgi3
         KRhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=GSZh3sqy9pU/vbbetAGWoOCvH3XVCaoW7AIACle/Tm4=;
        b=NTO4oxMxCyzOVvcraTAR5x/tpuQSj0/c/yVAyGOpTChuJcCZfNlAXsMUlZHqWZSsi3
         1cmd1o13khf57q7tPPG2YeEHlsy1mytUwGbfFdZvFe0EUvYU6aBUM6psyGTeggOX9dph
         3szh6UT34bZpbgap02X0Pzg84jY4Ck1PKYa8IXn1MllI3KtaH/COlqWIPzcuYlIab30A
         6dlhvV/hzE09JDhznQSSMe2lNzZySwY6dbPsMvEYtt6ADsqc7JXrLMT27bnohf/GuteZ
         90ccjr5KTq0Ei9kfz6aV13hlJTLBS0PUjUIAkPyCAwYQt1Vo1KToRinzgUvOSJ66RCwT
         wFHA==
X-Gm-Message-State: APjAAAU0MHhoErBD271Cz+z5bj8oYtkOQ8hFxlEo9L+OBytIbNDlgQmd
        n2wq7tKlJhDA0ZMYJS3SSX4=
X-Google-Smtp-Source: APXvYqxfu7HTGanqmD88SSNlRZluMWq8AccwhomN8Rz7/N0BwnZb17LQFiHXLShl2xcRjttpbOC6RQ==
X-Received: by 2002:a0c:fe8c:: with SMTP id d12mr4141600qvs.146.1573070077995;
        Wed, 06 Nov 2019 11:54:37 -0800 (PST)
Received: from quaco.ghostprotocols.net (187-26-100-98.3g.claro.net.br. [187.26.100.98])
        by smtp.gmail.com with ESMTPSA id j10sm12694000qtb.34.2019.11.06.11.54.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Nov 2019 11:54:37 -0800 (PST)
From:   Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>
X-Google-Original-From: Arnaldo Carvalho de Melo <acme@kernel.org>
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 285F740B1D; Wed,  6 Nov 2019 16:54:32 -0300 (-03)
Date:   Wed, 6 Nov 2019 16:54:32 -0300
To:     Masami Hiramatsu <mhiramat@kernel.org>
Cc:     Ingo Molnar <mingo@redhat.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        linux-kernel@vger.kernel.org,
        Tom Zanussi <tom.zanussi@linux.intel.com>,
        Ravi Bangoria <ravi.bangoria@linux.ibm.com>,
        Namhyung Kim <namhyung@kernel.org>
Subject: Re: [PATCH 2/5] perf probe: Generate event name with line number
Message-ID: <20191106195432.GB11935@kernel.org>
References: <157291299825.19771.5190465639558208592.stgit@devnote2>
 <157291301924.19771.11830065569894242974.stgit@devnote2>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <157291301924.19771.11830065569894242974.stgit@devnote2>
X-Url:  http://acmel.wordpress.com
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Tue, Nov 05, 2019 at 09:16:59AM +0900, Masami Hiramatsu escreveu:
> Generate event name from function name with line number
> as <function>_L<line_number>. Note that this is only for
> the new event which is defined by function and lines.
> 
> If there is another event on same line, you have to use
> "-f" option. In that case, the new event has "_1" suffix.

So I don't like this, the existing practice of, if given a function
name, just create the probe:name looks more natural, if one states
kernel:1, then, sure, appending L1 to them is natural, better than the
previous naming convention,

Thanks,

- Arnaldo
 
>  e.g.
>   # perf probe -a kernel_read
>   Added new event:
>     probe:kernel_read_L0 (on kernel_read)
> 
>   You can now use it in all perf tools, such as:
> 
>   	perf record -e probe:kernel_read_L0 -aR sleep 1
> 
>   # perf probe -a kernel_read:1
>   Added new events:
>     probe:kernel_read_L1 (on kernel_read:1)
> 
>   You can now use it in all perf tools, such as:
> 
>   	perf record -e probe:kernel_read_L1_1 -aR sleep 1
> 
>   # perf probe -l
>     probe:kernel_read_L0 (on kernel_read@linux/linux/fs/read_write.c)
>     probe:kernel_read_L1 (on kernel_read@linux/linux/fs/read_write.c)
> 
> Signed-off-by: Masami Hiramatsu <mhiramat@kernel.org>
> ---
>  tools/perf/util/probe-event.c |    8 ++++++++
>  1 file changed, 8 insertions(+)
> 
> diff --git a/tools/perf/util/probe-event.c b/tools/perf/util/probe-event.c
> index 91cab5f669d2..d14b970a6461 100644
> --- a/tools/perf/util/probe-event.c
> +++ b/tools/perf/util/probe-event.c
> @@ -1679,6 +1679,14 @@ int parse_perf_probe_command(const char *cmd, struct perf_probe_event *pev)
>  	if (ret < 0)
>  		goto out;
>  
> +	/* Generate event name if needed */
> +	if (!pev->event && pev->point.function
> +			&& !pev->point.lazy_line && !pev->point.offset) {
> +		if (asprintf(&pev->event, "%s_L%d", pev->point.function,
> +			pev->point.line) < 0)
> +			return -ENOMEM;
> +	}
> +
>  	/* Copy arguments and ensure return probe has no C argument */
>  	pev->nargs = argc - 1;
>  	pev->args = zalloc(sizeof(struct perf_probe_arg) * pev->nargs);

-- 

- Arnaldo
