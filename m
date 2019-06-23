Return-Path: <SRS0=VFBv=UW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3EC6CC43613
	for <linux-kernel@archiver.kernel.org>; Sun, 23 Jun 2019 00:09:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 173E020673
	for <linux-kernel@archiver.kernel.org>; Sun, 23 Jun 2019 00:09:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="oXxHB58C"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726540AbfFWAJD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 22 Jun 2019 20:09:03 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:40369 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726410AbfFWAJD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 22 Jun 2019 20:09:03 -0400
Received: by mail-pf1-f194.google.com with SMTP id p184so5431819pfp.7
        for <linux-kernel@vger.kernel.org>; Sat, 22 Jun 2019 17:09:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=vWIjWJgohtlUoEwu3+7zUIlhLSIs1C/QTS8o7CJbmYY=;
        b=oXxHB58CnJuSsv8e6M+Hv435kyh+G5amzn9487tXyJ/z1gwAX1/iqax2cRXrSQui/V
         dpewHIy8N9N9V8GZ4/BIe3R/O/iFF2vJq1IUNXXLMEyj5gmBVudu0i12Wp0itb6zp4nC
         roTiUqbSHiLr5TB50VhMJeLam+l0vAsTaPE1I=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=vWIjWJgohtlUoEwu3+7zUIlhLSIs1C/QTS8o7CJbmYY=;
        b=uFNg63TFs73Rr8CQxsW7RP4S9Nqo3/0jJLU5L3+n5dJJVrpXodDxa08kj8tEYRZR8d
         hJS3DhiToDW8kpyD77w6WXXDgC6663zOGNXWyTrZpFIW4XJDwgvIHZoTRZJtBDCdTR5j
         KylDqyrBF83SZQiLQxDlVYsKBC0vx29T6tlrb5SrIFgjC8nC0bT83Zyd5c4Kg51H9FK+
         RlFaVdpJj/xBjjIpiFcTmLASAVKPSDgxLf2zhrd1oeUWifoPTUHdy9AbMkhf1C39Xn8R
         cZWi7MItI52bYiYnzjz+D7UwaQRuU80wSGX0k2Ibq1sgh/inhBrb/R7SSZvURNrmc5m5
         SAng==
X-Gm-Message-State: APjAAAW1TNH7F82VG6GXYd4L/g0/UjGJqEVJQ3fK9JG8SaVAcnxX89PX
        Fut1o7ZMNxgmUHVw5/+6qlNISw==
X-Google-Smtp-Source: APXvYqw9bsgIEBdp2vXwfunv3HziFxADVp4U6vZw+FfIejnJHpPVurAILG6xEwEHAzf+41/aBF+MGQ==
X-Received: by 2002:a17:90a:b883:: with SMTP id o3mr15506972pjr.50.1561248542488;
        Sat, 22 Jun 2019 17:09:02 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id n7sm7096532pff.59.2019.06.22.17.09.01
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sat, 22 Jun 2019 17:09:01 -0700 (PDT)
Date:   Sat, 22 Jun 2019 17:09:00 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Matthew Garrett <matthewgarrett@google.com>
Cc:     jmorris@namei.org, linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-api@vger.kernel.org,
        David Howells <dhowells@redhat.com>,
        Alexei Starovoitov <alexei.starovoitov@gmail.com>,
        Matthew Garrett <mjg59@google.com>,
        "Naveen N . Rao" <naveen.n.rao@linux.ibm.com>,
        Anil S Keshavamurthy <anil.s.keshavamurthy@intel.com>,
        davem@davemloft.net, Masami Hiramatsu <mhiramat@kernel.org>
Subject: Re: [PATCH V34 22/29] Lock down tracing and perf kprobes when in
 confidentiality mode
Message-ID: <201906221708.4E617CD@keescook>
References: <20190622000358.19895-1-matthewgarrett@google.com>
 <20190622000358.19895-23-matthewgarrett@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190622000358.19895-23-matthewgarrett@google.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 21, 2019 at 05:03:51PM -0700, Matthew Garrett wrote:
> From: David Howells <dhowells@redhat.com>
> 
> Disallow the creation of perf and ftrace kprobes when the kernel is
> locked down in confidentiality mode by preventing their registration.
> This prevents kprobes from being used to access kernel memory to steal
> crypto data, but continues to allow the use of kprobes from signed
> modules.
> 
> Reported-by: Alexei Starovoitov <alexei.starovoitov@gmail.com>
> Signed-off-by: David Howells <dhowells@redhat.com>
> Signed-off-by: Matthew Garrett <mjg59@google.com>
> Cc: Naveen N. Rao <naveen.n.rao@linux.ibm.com>
> Cc: Anil S Keshavamurthy <anil.s.keshavamurthy@intel.com>
> Cc: davem@davemloft.net
> Cc: Masami Hiramatsu <mhiramat@kernel.org>

Reviewed-by: Kees Cook <keescook@chromium.org>

-Kees

> ---
>  include/linux/security.h     | 1 +
>  kernel/trace/trace_kprobe.c  | 5 +++++
>  security/lockdown/lockdown.c | 1 +
>  3 files changed, 7 insertions(+)
> 
> diff --git a/include/linux/security.h b/include/linux/security.h
> index 3875f6df2ecc..e6e3e2403474 100644
> --- a/include/linux/security.h
> +++ b/include/linux/security.h
> @@ -96,6 +96,7 @@ enum lockdown_reason {
>  	LOCKDOWN_MMIOTRACE,
>  	LOCKDOWN_INTEGRITY_MAX,
>  	LOCKDOWN_KCORE,
> +	LOCKDOWN_KPROBES,
>  	LOCKDOWN_CONFIDENTIALITY_MAX,
>  };
>  
> diff --git a/kernel/trace/trace_kprobe.c b/kernel/trace/trace_kprobe.c
> index 5d5129b05df7..5a76a0f79d48 100644
> --- a/kernel/trace/trace_kprobe.c
> +++ b/kernel/trace/trace_kprobe.c
> @@ -11,6 +11,7 @@
>  #include <linux/uaccess.h>
>  #include <linux/rculist.h>
>  #include <linux/error-injection.h>
> +#include <linux/security.h>
>  
>  #include "trace_dynevent.h"
>  #include "trace_kprobe_selftest.h"
> @@ -415,6 +416,10 @@ static int __register_trace_kprobe(struct trace_kprobe *tk)
>  {
>  	int i, ret;
>  
> +	ret = security_locked_down(LOCKDOWN_KPROBES);
> +	if (ret)
> +		return ret;
> +
>  	if (trace_probe_is_registered(&tk->tp))
>  		return -EINVAL;
>  
> diff --git a/security/lockdown/lockdown.c b/security/lockdown/lockdown.c
> index 4c9b324dfc55..5a08c17f224d 100644
> --- a/security/lockdown/lockdown.c
> +++ b/security/lockdown/lockdown.c
> @@ -32,6 +32,7 @@ static char *lockdown_reasons[LOCKDOWN_CONFIDENTIALITY_MAX+1] = {
>  	[LOCKDOWN_MMIOTRACE] = "unsafe mmio",
>  	[LOCKDOWN_INTEGRITY_MAX] = "integrity",
>  	[LOCKDOWN_KCORE] = "/proc/kcore access",
> +	[LOCKDOWN_KPROBES] = "use of kprobes",
>  	[LOCKDOWN_CONFIDENTIALITY_MAX] = "confidentiality",
>  };
>  
> -- 
> 2.22.0.410.gd8fdbe21b5-goog
> 

-- 
Kees Cook
