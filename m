Return-Path: <SRS0=21RF=YY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FAKE_REPLY_C,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1847DCA9ECB
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Oct 2019 17:59:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E1BB02080F
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Oct 2019 17:59:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OD0iyUkN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729164AbfJaR7J (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 31 Oct 2019 13:59:09 -0400
Received: from mail-qt1-f193.google.com ([209.85.160.193]:43649 "EHLO
        mail-qt1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729130AbfJaR7J (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Oct 2019 13:59:09 -0400
Received: by mail-qt1-f193.google.com with SMTP id c26so9705608qtj.10
        for <linux-kernel@vger.kernel.org>; Thu, 31 Oct 2019 10:59:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:date:to:cc:subject:message-id:mime-version:content-disposition
         :in-reply-to:user-agent;
        bh=sWokwVhyBdp2QZIlCKCrU1UgOSXDRZkXLq1Z+cZh/9o=;
        b=OD0iyUkND88c/Dsb6v7RwGZC1Ei0pIviY3aMxTUV1K+Qh0lhujW7/36dHm+tbtuF6z
         51O7laPdBI3EmCMkusK1hnt8sw/JKoR791C+ApIYrx6g7MOiquQqXJO1fmKm9q6u7xM6
         MB2yLh3VF4VwGOyrFGvNyG7Du3SWZ/j2FRe6KnLBc7t1ynu46mrhFASXLespidNuCctW
         FyBb94uHst+VdRM9DrAfurrK5gaeArvQWY2mQckj9YAQ0rMwBDtwUx8PWxlBSwC0SYQC
         xnv3/p34A9IZdgDXrqvLw8mFvw9kGWYpHoAEM2JkFWKsEC9h3bG/C6ACsRBTxp3RzRnT
         g13A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=sWokwVhyBdp2QZIlCKCrU1UgOSXDRZkXLq1Z+cZh/9o=;
        b=Au3+qoA9dKt53gWeA2Y5ejdApCjj9xgit5aRYcTwClJNQGmr+43CjpAHB6Tszv1Vze
         9pbxpdZ3/Ym7KesgKoVXddM3jocPJIyTdxkcAONlgELBH1h6Yce6Ap48Yr9yArW17VCu
         tJI6v9aY2DsGUY02ro1Kh8o+04xqD3ls9/4CyHCV7kLKakfbxfspevssUJ2Y0xB7RJyL
         VythK7aOozhZ8kTuWwhEv76Qpt5zHluge43iEXoG9VbTwRJYlV8tLnKe15qIU5NQce6l
         H1pHb66WJQ/LnTWhQdyEFdLEQxhtD5yiZ2n2Q3VxvlsjwgO4+Ww9FJhRxFz0+NT6UTr/
         Xkig==
X-Gm-Message-State: APjAAAVHIbfxD5icvq90d430y5BZQZz8YmXGtm9v2uV1DxNg/mvzJ5BZ
        e8vYD6oJbAmhnEmMVY5w6No=
X-Google-Smtp-Source: APXvYqznoG4YwmAIGmhv498e/E4D8vA7nCaoN/VjgCzPRJ7v3oAMmLEA7juJO5XjzPmvuiuUtdt9uw==
X-Received: by 2002:ac8:141a:: with SMTP id k26mr6819012qtj.372.1572544748142;
        Thu, 31 Oct 2019 10:59:08 -0700 (PDT)
Received: from quaco.ghostprotocols.net (187-26-106-94.3g.claro.net.br. [187.26.106.94])
        by smtp.gmail.com with ESMTPSA id a66sm2164371qkd.34.2019.10.31.10.59.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 31 Oct 2019 10:59:06 -0700 (PDT)
From:   Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>
X-Google-Original-From: Arnaldo Carvalho de Melo <acme@kernel.org>
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id EBF38408F8; Thu, 31 Oct 2019 14:59:02 -0300 (-03)
Date:   Thu, 31 Oct 2019 14:59:02 -0300
To:     Steve MacLean <steve.maclean@linux.microsoft.com>
Cc:     Steve MacLean <Steve.MacLean@microsoft.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Stephane Eranian <eranian@google.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] perf inject --jit: Remove //anon mmap events
Message-ID: <20191031175902.GB15593@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1572483912-111747-1-git-send-email-steve.maclean@linux.microsoft.com>
X-Url:  http://acmel.wordpress.com
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Wed, Oct 30, 2019 at 06:05:12PM -0700, Steve MacLean escreveu:
> From: Steve MacLean <Steve.MacLean@Microsoft.com>
> @@ -749,6 +750,34 @@ static int jit_repipe_debug_info(struct jit_buf_desc *jd, union jr_entry *jr)
>  	return 0;
>  }
>  
> +static void jit_add_pid(struct machine *machine, pid_t pid)
> +{
> +	struct thread *thread = machine__findnew_thread(machine, pid, pid);
> +
> +	if (!thread)
> +	{
> +		pr_err("jit_add_pid() thread not found\n");
> +
> +		return;
> +	}


Can you please follow the coding style used in tools/? Its mostly the
same as for the kernel sources.

I.e. above you need to have it as:

	if (!thread) {
		pr_err("jit_add_pid() thread not found\n");
		return;
	}

There also consider using __funct__ and showing the pid that wasn't
found.

> +
> +	thread->priv = (void *) 1;

No space after the cast.

> +}
> +
> +static bool jit_has_pid(struct machine *machine, pid_t pid)
> +{
> +	struct thread *thread = machine__findnew_thread(machine, pid, pid);
> +
> +	if (!thread)
> +	{
> +		pr_err("jit_has_pid() thread not found\n");
> +
> +		return 0;
> +	}
> +
> +	return (bool) thread->priv;

Same style problems and the only way for machine__findnew_thread() to
fail is if the system is under severe memory exhaustion, what you
probably want to use here is machine__find_thread(), that will fail if
the pid isn't found, the findnew methods, in the machine class or
elsewhere will return an existing thread _or_ create and insert it, then
return the newly added/inserted object.

> +}
> +
>  int
>  jit_process(struct perf_session *session,
>  	    struct perf_data *output,
> @@ -765,7 +794,15 @@ static int jit_repipe_debug_info(struct jit_buf_desc *jd, union jr_entry *jr)
>  	 * first, detect marker mmap (i.e., the jitdump mmap)
>  	 */
>  	if (jit_detect(filename, pid))
> +	{

if () {

> +		/*
> +		 * Strip //anon* mmaps if we processed a jitdump for this pid
> +		 */

// can be used, not strictly required tho, the way you used is
acceptable.

> +		if (jit_has_pid(machine, pid) && (strncmp(filename, "//anon", 6) == 0))
> +			return 1;
> +
>  		return 0;
> +	}
>  
>  	memset(&jd, 0, sizeof(jd));
>  
> @@ -784,6 +821,7 @@ static int jit_repipe_debug_info(struct jit_buf_desc *jd, union jr_entry *jr)
>  
>  	ret = jit_inject(&jd, filename);
>  	if (!ret) {
> +		jit_add_pid(machine, pid);
>  		*nbytes = jd.bytes_written;
>  		ret = 1;
>  	}
