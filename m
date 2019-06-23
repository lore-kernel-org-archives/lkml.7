Return-Path: <SRS0=VFBv=UW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3BE68C43613
	for <linux-kernel@archiver.kernel.org>; Sun, 23 Jun 2019 00:12:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0ED2B20673
	for <linux-kernel@archiver.kernel.org>; Sun, 23 Jun 2019 00:12:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="MIF83eSv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726529AbfFWAMj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 22 Jun 2019 20:12:39 -0400
Received: from mail-pl1-f195.google.com ([209.85.214.195]:45886 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726410AbfFWAMi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 22 Jun 2019 20:12:38 -0400
Received: by mail-pl1-f195.google.com with SMTP id bi6so4799941plb.12
        for <linux-kernel@vger.kernel.org>; Sat, 22 Jun 2019 17:12:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=Prscc723sZ8+qgLRikcBsfIq/Y6O5wzMfYQ/rmLcVTo=;
        b=MIF83eSvmE+KzBBQDt5kUh18cBLWZQ8cuOBZn3drW7IbtW/IuMxvJPVZyjB+GOCtXh
         ocmDzaMX05V/gXlwn3oalZ0AqGf37Q8D/oWMVTTULJaBstqxXme69M3xjNGZOo3TvUOv
         dPM9n6PjrE0p37Aqr5G5DHJXWUdzG+qDHtqco=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Prscc723sZ8+qgLRikcBsfIq/Y6O5wzMfYQ/rmLcVTo=;
        b=BSY3xqGGIyOj29Dnwo3TpWvpb+lS3nf5qENDriGgooeBEQs+mZQGt+DnkrpgDY4bgc
         yVjs9uwFcEh/pB7/bQNwz30x5r/1dpV+KJFZIGnEU56eopGioSMJMwIYMJx3vOA5c8uq
         x8COydOgdZgibwp4iSfYIyQluxML7iXrMDslU4FB+/RFkvkLlIHx/RJkEftfmxvxy2yZ
         wmoHfCKwavffBbx6v4X8dzSuFhyvLALdjCnQ90LalHWUyhZv2omDSrjzWf8WsO2qBe1S
         q9Jn6CAaPcdztGVBhS9VNBSheduDhGNREX7nFBiESJwB65gidQvj36tMDfxH8ImJg4l9
         9vZA==
X-Gm-Message-State: APjAAAV4orD7MFwSUXtS6F3M76B1m2q91v9vzzgkBRNhLcmt/iVguoZC
        s2FwqV3veoD9GYlPsR6RRt2J4Q==
X-Google-Smtp-Source: APXvYqxynlEEoCNBU0g47FTrctp/uDLj/obZe/1CCXNGszBCqYKsw3srBoOfwhdjiKMKikhoKYqgwA==
X-Received: by 2002:a17:902:7b84:: with SMTP id w4mr30044455pll.22.1561248758334;
        Sat, 22 Jun 2019 17:12:38 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id n89sm30709882pjc.0.2019.06.22.17.12.37
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sat, 22 Jun 2019 17:12:37 -0700 (PDT)
Date:   Sat, 22 Jun 2019 17:12:36 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Matthew Garrett <matthewgarrett@google.com>
Cc:     jmorris@namei.org, linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-api@vger.kernel.org,
        David Howells <dhowells@redhat.com>,
        Matthew Garrett <mjg59@google.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: Re: [PATCH V34 24/29] Lock down perf when in confidentiality mode
Message-ID: <201906221710.EB0540F@keescook>
References: <20190622000358.19895-1-matthewgarrett@google.com>
 <20190622000358.19895-25-matthewgarrett@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190622000358.19895-25-matthewgarrett@google.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 21, 2019 at 05:03:53PM -0700, Matthew Garrett wrote:
> From: David Howells <dhowells@redhat.com>
> 
> Disallow the use of certain perf facilities that might allow userspace to
> access kernel data.
> 
> Signed-off-by: David Howells <dhowells@redhat.com>
> Signed-off-by: Matthew Garrett <mjg59@google.com>
> Cc: Peter Zijlstra <peterz@infradead.org>
> Cc: Ingo Molnar <mingo@redhat.com>
> Cc: Arnaldo Carvalho de Melo <acme@kernel.org>
> ---
>  include/linux/security.h     | 1 +
>  kernel/events/core.c         | 7 +++++++
>  security/lockdown/lockdown.c | 1 +
>  3 files changed, 9 insertions(+)
> 
> diff --git a/include/linux/security.h b/include/linux/security.h
> index de0d37b1fe79..53ea85889a48 100644
> --- a/include/linux/security.h
> +++ b/include/linux/security.h
> @@ -98,6 +98,7 @@ enum lockdown_reason {
>  	LOCKDOWN_KCORE,
>  	LOCKDOWN_KPROBES,
>  	LOCKDOWN_BPF_READ,
> +	LOCKDOWN_PERF,
>  	LOCKDOWN_CONFIDENTIALITY_MAX,
>  };
>  
> diff --git a/kernel/events/core.c b/kernel/events/core.c
> index 72d06e302e99..77f36551756e 100644
> --- a/kernel/events/core.c
> +++ b/kernel/events/core.c
> @@ -10731,6 +10731,13 @@ SYSCALL_DEFINE5(perf_event_open,
>  			return -EINVAL;
>  	}
>  
> +	err = security_locked_down(LOCKDOWN_PERF);
> +	if (err && (attr.sample_type & PERF_SAMPLE_REGS_INTR))
> +		/* REGS_INTR can leak data, lockdown must prevent this */
> +		return err;
> +	else
> +		err = 0;
> +
>  	/* Only privileged users can get physical addresses */
>  	if ((attr.sample_type & PERF_SAMPLE_PHYS_ADDR) &&
>  	    perf_paranoid_kernel() && !capable(CAP_SYS_ADMIN))

With moar capable() ordering fixed...

Reviewed-by: Kees Cook <keescook@chromium.org>

-Kees

> diff --git a/security/lockdown/lockdown.c b/security/lockdown/lockdown.c
> index 2eea2cc13117..a7e75c614416 100644
> --- a/security/lockdown/lockdown.c
> +++ b/security/lockdown/lockdown.c
> @@ -34,6 +34,7 @@ static char *lockdown_reasons[LOCKDOWN_CONFIDENTIALITY_MAX+1] = {
>  	[LOCKDOWN_KCORE] = "/proc/kcore access",
>  	[LOCKDOWN_KPROBES] = "use of kprobes",
>  	[LOCKDOWN_BPF_READ] = "use of bpf to read kernel RAM",
> +	[LOCKDOWN_PERF] = "unsafe use of perf",
>  	[LOCKDOWN_CONFIDENTIALITY_MAX] = "confidentiality",
>  };
>  
> -- 
> 2.22.0.410.gd8fdbe21b5-goog
> 

-- 
Kees Cook
