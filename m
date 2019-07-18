Return-Path: <SRS0=Pa1K=VP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C9481C76196
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Jul 2019 21:06:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A23622173B
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Jul 2019 21:06:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="k0b4SHcy"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2403848AbfGRVGm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Jul 2019 17:06:42 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:45517 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727950AbfGRVGm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Jul 2019 17:06:42 -0400
Received: by mail-pg1-f194.google.com with SMTP id o13so13423162pgp.12
        for <linux-kernel@vger.kernel.org>; Thu, 18 Jul 2019 14:06:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=WHBYUvj9JGt1SYE4KDr6Cz0xmk9pn3DzGdEMJem8w6M=;
        b=k0b4SHcyBjdAtwD9RJNFolaMMkMhrDoStFrJRvQsgwkWh2XpUphj4gS5DKLq/llGF/
         39sE3TzdtW8s123SyMA+Oe3DwQpfkszvS0mpa26giIimqBA+5dr0q/qgm1cEOeI0OK0l
         OdUaHLgvStngj7WwSLrwbiDOYE07o0VsJCs04=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=WHBYUvj9JGt1SYE4KDr6Cz0xmk9pn3DzGdEMJem8w6M=;
        b=AVnSQlfBhWmWcBiJGPdNN1HN4UTgB2NHofaR7qtteFpsZNd6KEMr68RXb/0AsQeo6r
         liiCfgNTHVtIHdq7GlAplvnMw6jUHMec7uHuqPgdJutiY1s7Q95YoztUjwTJ4qusQ5q1
         l2+vqQqxEdtOOwcogJS36NFmcnBC+wI8rwjoIWUvP4YT9GwQosfGb4D0+E+fyYxKZyei
         YEmhOYXJ8GG7Z/ERA0eZDdHMLhLtjNO4Kbo2jjWls0pxpNQb9692k+FFWsiHlu4Q+WDZ
         nW7wl73j5w1mrPRNLDGgMhlFbq7OGGvNEaf6nGJzpj72HP0La1Auob+qITmw8efAXrNC
         YQSA==
X-Gm-Message-State: APjAAAXzMT/Hnn7addDpMtGdcs695AmLgwCjfj/jkWDwJdYGudwa7+Oc
        qwwkmtZzE8AijkFo9s5RtKJwq26of0A=
X-Google-Smtp-Source: APXvYqyw88KMjZmP2UlNUKCxHokf10xRn72SPzK4naVkut7nVWidBL7H7RX/dBpZIWSSAw8y7+lrjw==
X-Received: by 2002:a63:eb51:: with SMTP id b17mr48524550pgk.384.1563484001438;
        Thu, 18 Jul 2019 14:06:41 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id v8sm23845337pgs.82.2019.07.18.14.06.40
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 18 Jul 2019 14:06:40 -0700 (PDT)
Date:   Thu, 18 Jul 2019 14:06:39 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Matthew Garrett <matthewgarrett@google.com>
Cc:     jmorris@namei.org, linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-api@vger.kernel.org,
        David Howells <dhowells@redhat.com>,
        Alexei Starovoitov <alexei.starovoitov@gmail.com>,
        Matthew Garrett <mjg59@google.com>, netdev@vger.kernel.org,
        Chun-Yi Lee <jlee@suse.com>,
        Daniel Borkmann <daniel@iogearbox.net>
Subject: Re: [PATCH V36 23/29] bpf: Restrict bpf when kernel lockdown is in
 confidentiality mode
Message-ID: <201907181406.001618FB6@keescook>
References: <20190718194415.108476-1-matthewgarrett@google.com>
 <20190718194415.108476-24-matthewgarrett@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190718194415.108476-24-matthewgarrett@google.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 18, 2019 at 12:44:09PM -0700, Matthew Garrett wrote:
> From: David Howells <dhowells@redhat.com>
> 
> bpf_read() and bpf_read_str() could potentially be abused to (eg) allow
> private keys in kernel memory to be leaked. Disable them if the kernel
> has been locked down in confidentiality mode.
> 
> Suggested-by: Alexei Starovoitov <alexei.starovoitov@gmail.com>
> Signed-off-by: Matthew Garrett <mjg59@google.com>

Reviewed-by: Kees Cook <keescook@chromium.org>

-Kees

> cc: netdev@vger.kernel.org
> cc: Chun-Yi Lee <jlee@suse.com>
> cc: Alexei Starovoitov <alexei.starovoitov@gmail.com>
> Cc: Daniel Borkmann <daniel@iogearbox.net>
> ---
>  include/linux/security.h     |  1 +
>  kernel/trace/bpf_trace.c     | 10 ++++++++++
>  security/lockdown/lockdown.c |  1 +
>  3 files changed, 12 insertions(+)
> 
> diff --git a/include/linux/security.h b/include/linux/security.h
> index 987d8427f091..8dd1741a52cd 100644
> --- a/include/linux/security.h
> +++ b/include/linux/security.h
> @@ -118,6 +118,7 @@ enum lockdown_reason {
>  	LOCKDOWN_INTEGRITY_MAX,
>  	LOCKDOWN_KCORE,
>  	LOCKDOWN_KPROBES,
> +	LOCKDOWN_BPF_READ,
>  	LOCKDOWN_CONFIDENTIALITY_MAX,
>  };
>  
> diff --git a/kernel/trace/bpf_trace.c b/kernel/trace/bpf_trace.c
> index ca1255d14576..492a8bfaae98 100644
> --- a/kernel/trace/bpf_trace.c
> +++ b/kernel/trace/bpf_trace.c
> @@ -142,8 +142,13 @@ BPF_CALL_3(bpf_probe_read, void *, dst, u32, size, const void *, unsafe_ptr)
>  {
>  	int ret;
>  
> +	ret = security_locked_down(LOCKDOWN_BPF_READ);
> +	if (ret < 0)
> +		goto out;
> +
>  	ret = probe_kernel_read(dst, unsafe_ptr, size);
>  	if (unlikely(ret < 0))
> +out:
>  		memset(dst, 0, size);
>  
>  	return ret;
> @@ -569,6 +574,10 @@ BPF_CALL_3(bpf_probe_read_str, void *, dst, u32, size,
>  {
>  	int ret;
>  
> +	ret = security_locked_down(LOCKDOWN_BPF_READ);
> +	if (ret < 0)
> +		goto out;
> +
>  	/*
>  	 * The strncpy_from_unsafe() call will likely not fill the entire
>  	 * buffer, but that's okay in this circumstance as we're probing
> @@ -580,6 +589,7 @@ BPF_CALL_3(bpf_probe_read_str, void *, dst, u32, size,
>  	 */
>  	ret = strncpy_from_unsafe(dst, unsafe_ptr, size);
>  	if (unlikely(ret < 0))
> +out:
>  		memset(dst, 0, size);
>  
>  	return ret;
> diff --git a/security/lockdown/lockdown.c b/security/lockdown/lockdown.c
> index 6b123cbf3748..1b89d3e8e54d 100644
> --- a/security/lockdown/lockdown.c
> +++ b/security/lockdown/lockdown.c
> @@ -33,6 +33,7 @@ static char *lockdown_reasons[LOCKDOWN_CONFIDENTIALITY_MAX+1] = {
>  	[LOCKDOWN_INTEGRITY_MAX] = "integrity",
>  	[LOCKDOWN_KCORE] = "/proc/kcore access",
>  	[LOCKDOWN_KPROBES] = "use of kprobes",
> +	[LOCKDOWN_BPF_READ] = "use of bpf to read kernel RAM",
>  	[LOCKDOWN_CONFIDENTIALITY_MAX] = "confidentiality",
>  };
>  
> -- 
> 2.22.0.510.g264f2c817a-goog
> 

-- 
Kees Cook
