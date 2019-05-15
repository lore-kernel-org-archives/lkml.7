Return-Path: <SRS0=FrXW=TP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7839C04E84
	for <linux-kernel@archiver.kernel.org>; Wed, 15 May 2019 19:28:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 835032084F
	for <linux-kernel@archiver.kernel.org>; Wed, 15 May 2019 19:28:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="apiHQfMA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728031AbfEOT2f (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 May 2019 15:28:35 -0400
Received: from mail-qt1-f195.google.com ([209.85.160.195]:43279 "EHLO
        mail-qt1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728000AbfEOT2d (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 May 2019 15:28:33 -0400
Received: by mail-qt1-f195.google.com with SMTP id i26so1031142qtr.10
        for <linux-kernel@vger.kernel.org>; Wed, 15 May 2019 12:28:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=STSjYwvZPuyl75wjWMZHV1XwXZxjAw1KyH4vRRF0KX8=;
        b=apiHQfMAlW6NdEEAax9R6re99NyJOcDdZy2jTV4CwwZbr5QQmEx9ZV6HEhtBs1Q03Y
         U5uEDfUOSlz8ay5Rwj8vd5iOQWeRCpNQl/IxxaCJ3KZyM+p4OdzcmbZGN3gWMiqxkRvD
         U0c95D8dcuW7veGpMiyZv+OW7I6AvfEhUFzGyJ7FPZuwZcO1bBmx3l+lGsOMJqW1Y7u6
         XEEkrybeb5tdDMEzc82NwAoue4e/8reaAnLXRHlWrXN5gI02kNx0HE9ZzQZyIwR/OHKg
         na2f6YEic01lBMtZQUBgOyBsoNbMdD8kr+wcQKVpej2PTS1y07g26hPA+S87MhOShJQ2
         KdZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=STSjYwvZPuyl75wjWMZHV1XwXZxjAw1KyH4vRRF0KX8=;
        b=XBG4VHJPO22r5KbqD6bdYkSOwgFfDECZtkQM1wcfy1p0jLvATljBbZGcJgMj5wfPCd
         o//akoqAl3gMdI3Y3eCw6Y8vWdDydtg/EemaQ/87ZP0q7cFOwP4vwfbmH3ImP5/D+BKF
         RjLYiZDEKk5lYdMZRTERaO+GZi51XaSb3m+OyfDwKOl295L4QZTsXDUelXnQcktOJuNT
         RFCjsqs0xoXEm7PouKs8La9bbCT9HCYzMTh3TSk5vg5YA0J+5hTw00T+BPELWgwcMa+W
         8Fo6d9pkr9fKFyod8RSJiQLAxKL1QLjyJS/OXa4Y5fo51XTn/eRhRbgteq08xVqJQtR3
         3hgA==
X-Gm-Message-State: APjAAAWEmHZOzCqiBvIsDxTe3xmC5NqE0590fkQpB/B5dgKpwMka0fzZ
        vFlat8+pwAH5RJ7XuAxEOQw=
X-Google-Smtp-Source: APXvYqwBunKfIfD9LvK+AmQpafx+LF47puQRVgGLx/4jbjVbwI60YZ1g50Gxjt9XL+VPCKE5s9li3A==
X-Received: by 2002:a0c:ff44:: with SMTP id y4mr33761774qvt.238.1557948511961;
        Wed, 15 May 2019 12:28:31 -0700 (PDT)
Received: from quaco.ghostprotocols.net ([179.97.35.11])
        by smtp.gmail.com with ESMTPSA id o37sm2141805qta.86.2019.05.15.12.28.30
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 15 May 2019 12:28:30 -0700 (PDT)
From:   Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>
X-Google-Original-From: Arnaldo Carvalho de Melo <acme@kernel.org>
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 9D795404A1; Wed, 15 May 2019 16:28:26 -0300 (-03)
Date:   Wed, 15 May 2019 16:28:26 -0300
To:     kan.liang@linux.intel.com
Cc:     jolsa@kernel.org, mingo@redhat.com, linux-kernel@vger.kernel.org,
        ak@linux.intel.com
Subject: Re: [PATCH V2 3/3] perf regs x86: Add X86 specific
 arch__intr_reg_mask()
Message-ID: <20190515192826.GE23162@kernel.org>
References: <1557865174-56264-1-git-send-email-kan.liang@linux.intel.com>
 <1557865174-56264-3-git-send-email-kan.liang@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1557865174-56264-3-git-send-email-kan.liang@linux.intel.com>
X-Url:  http://acmel.wordpress.com
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Tue, May 14, 2019 at 01:19:34PM -0700, kan.liang@linux.intel.com escreveu:
> From: Kan Liang <kan.liang@linux.intel.com>
> 
> XMM registers can be collected on Icelake and later platforms.
> 
> Add specific arch__intr_reg_mask(), which creating an event to check if
> the kernel and hardware can collect XMM registers.
> 
> Test on Skylake which doesn't support XMM registers collection. There is
> nothing changed.

Thanks a lot for doing this and tested on both a machine without these
registers as well as on one with it.

Applied, together with Ravi's tested-by for the first two and the change
in the --user-regs doc,

Regards,

- Arnaldo
 
>    #perf record -I?
>    available registers: AX BX CX DX SI DI BP SP IP FLAGS CS SS R8 R9
>    R10 R11 R12 R13 R14 R15
> 
>    Usage: perf record [<options>] [<command>]
>     or: perf record [<options>] -- <command> [<options>]
> 
>     -I, --intr-regs[=<any register>]
>                           sample selected machine registers on
>    interrupt, use '-I?' to list register names
> 
>    #perf record -I
>    [ perf record: Woken up 1 times to write data ]
>    [ perf record: Captured and wrote 0.905 MB perf.data (2520 samples) ]
> 
>    #perf evlist -v
>    cycles: size: 112, { sample_period, sample_freq }: 4000, sample_type:
>    IP|TID|TIME|CPU|PERIOD|REGS_INTR, read_format: ID, disabled: 1,
>    inherit: 1, mmap: 1, comm: 1, freq: 1, task: 1, precise_ip: 3,
>    sample_id_all: 1, exclude_guest: 1, mmap2: 1, comm_exec: 1, ksymbol:
>    1, bpf_event: 1, sample_regs_intr: 0xff0fff
> 
> Test on Icelake which support XMM registers collection.
> 
>    #perf record -I?
>    available registers: AX BX CX DX SI DI BP SP IP FLAGS CS SS R8 R9 R10
>    R11 R12 R13 R14 R15 XMM0 XMM1 XMM2 XMM3 XMM4 XMM5 XMM6 XMM7 XMM8 XMM9
>    XMM10 XMM11 XMM12 XMM13 XMM14 XMM15
> 
>    Usage: perf record [<options>] [<command>]
>     or: perf record [<options>] -- <command> [<options>]
> 
>     -I, --intr-regs[=<any register>]
>                           sample selected machine registers on
>    interrupt, use '-I?' to list register names
> 
>    #perf record -I
>    [ perf record: Woken up 1 times to write data ]
>    [ perf record: Captured and wrote 0.800 MB perf.data (318 samples) ]
> 
>    #perf evlist -v
>    cycles: size: 112, { sample_period, sample_freq }: 4000, sample_type:
>    IP|TID|TIME|CPU|PERIOD|REGS_INTR, read_format: ID, disabled: 1,
>    inherit: 1, mmap: 1, comm: 1, freq: 1, task: 1, precise_ip: 3,
>    sample_id_all: 1, exclude_guest: 1, mmap2: 1, comm_exec: 1, ksymbol:
>    1, bpf_event: 1, sample_regs_intr: 0xffffffff00ff0fff
> 
> Signed-off-by: Kan Liang <kan.liang@linux.intel.com>
> ---
> 
> Changes since V1:
> - Add specific arch__intr_reg_mask() support
>   Drop specific has_non_gprs_support() and non_gprs_mask()
> 
>  tools/perf/arch/x86/include/perf_regs.h |  1 +
>  tools/perf/arch/x86/util/perf_regs.c    | 25 +++++++++++++++++++++++++
>  2 files changed, 26 insertions(+)
> 
> diff --git a/tools/perf/arch/x86/include/perf_regs.h b/tools/perf/arch/x86/include/perf_regs.h
> index b732133..b7cd91a 100644
> --- a/tools/perf/arch/x86/include/perf_regs.h
> +++ b/tools/perf/arch/x86/include/perf_regs.h
> @@ -9,6 +9,7 @@
>  void perf_regs_load(u64 *regs);
>  
>  #define PERF_REGS_MAX PERF_REG_X86_XMM_MAX
> +#define PERF_XMM_REGS_MASK	(~((1ULL << PERF_REG_X86_XMM0) - 1))
>  #ifndef HAVE_ARCH_X86_64_SUPPORT
>  #define PERF_REGS_MASK ((1ULL << PERF_REG_X86_32_MAX) - 1)
>  #define PERF_SAMPLE_REGS_ABI PERF_SAMPLE_REGS_ABI_32
> diff --git a/tools/perf/arch/x86/util/perf_regs.c b/tools/perf/arch/x86/util/perf_regs.c
> index 71d7604..c3d7479 100644
> --- a/tools/perf/arch/x86/util/perf_regs.c
> +++ b/tools/perf/arch/x86/util/perf_regs.c
> @@ -270,3 +270,28 @@ int arch_sdt_arg_parse_op(char *old_op, char **new_op)
>  
>  	return SDT_ARG_VALID;
>  }
> +
> +uint64_t arch__intr_reg_mask(void)
> +{
> +	struct perf_event_attr attr = {
> +		.type			= PERF_TYPE_HARDWARE,
> +		.config			= PERF_COUNT_HW_CPU_CYCLES,
> +		.sample_period		= 1,
> +		.sample_type		= PERF_SAMPLE_REGS_INTR,
> +		.sample_regs_intr	= PERF_XMM_REGS_MASK,
> +		.precise_ip		= 1,
> +		.disabled 		= 1,
> +		.exclude_kernel		= 1,
> +	};
> +	int fd;
> +
> +	event_attr_init(&attr);
> +
> +	fd = sys_perf_event_open(&attr, 0, -1, -1, 0);
> +	if (fd != -1) {
> +		close(fd);
> +		return (PERF_XMM_REGS_MASK | PERF_REGS_MASK);
> +	}
> +
> +	return PERF_REGS_MASK;
> +}
> -- 
> 2.7.4

-- 

- Arnaldo
