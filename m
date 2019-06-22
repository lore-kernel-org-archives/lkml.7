Return-Path: <SRS0=kYop=UV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0C63C43613
	for <linux-kernel@archiver.kernel.org>; Sat, 22 Jun 2019 23:37:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B4F002073F
	for <linux-kernel@archiver.kernel.org>; Sat, 22 Jun 2019 23:37:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="dQVF0BNt"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726417AbfFVXhT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 22 Jun 2019 19:37:19 -0400
Received: from mail-pl1-f193.google.com ([209.85.214.193]:44860 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726342AbfFVXhS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 22 Jun 2019 19:37:18 -0400
Received: by mail-pl1-f193.google.com with SMTP id t7so4776298plr.11
        for <linux-kernel@vger.kernel.org>; Sat, 22 Jun 2019 16:37:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=Ga+65wOE2v+5vkEnchUJiNgdze0ocJDvwZHNFQdh7wE=;
        b=dQVF0BNtnW9kQjstMvhfMpNuTtoavNH6PNuEeUU9ApBqzXlhuDaKzI3Cw/0oZ6oMks
         0sQAp2VUwExiSUq8TrzDk5tRg0Zpdxl1OxAWkVwLf2jQkM5xI+jq/s+6dt8B7z7wcHd6
         HosjfGZewbg85sitHoEVP3JMMtcOMhyuS1tNU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Ga+65wOE2v+5vkEnchUJiNgdze0ocJDvwZHNFQdh7wE=;
        b=ofba7KVER3IWqwYu3OYKzAxwIjJzWmNpf4/d/3wOBDudp/f1GMd+VQhOoVt8hd921+
         HFwTGGMWXxfGzc+FUldXWGEjPnynj7/wAJkbDwLbyBdLZNI29OsblQW01XXYmuDZO/V4
         6+YvbITRda/MmVteazHlunaKg/wNjc1bQspW7qEOxZ8ST/ZBLU/DpjqPaHbYF1zWBMMY
         2gJBdtkUPB43V5viCSYIE5Yw+e/pkm1KDLQmI/S2r16BN1/VPNYQaeeBND+61iWKyPN4
         XfQ9bto57yJU6YkgTNi0RBlGwddJP8xQ/5XYCAtccZowO7A7C62q071pn96c/bTjup+u
         c6+w==
X-Gm-Message-State: APjAAAUFTzNfTey8OmgLkPScTjEiIIVePKET7j4UWcbvb6z59cMBi0c3
        TDFG7BMHCvaKFhGGgc9tBFAIwA==
X-Google-Smtp-Source: APXvYqye5UrHKukzhvbQo0m7tFTJ8g+nLNFBfu3/lBN4df46gVqc7yoXwew7Jf563Wc9tvPb7OBI5Q==
X-Received: by 2002:a17:902:42a5:: with SMTP id h34mr103840994pld.16.1561246637986;
        Sat, 22 Jun 2019 16:37:17 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id w4sm6921685pfw.97.2019.06.22.16.37.17
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sat, 22 Jun 2019 16:37:17 -0700 (PDT)
Date:   Sat, 22 Jun 2019 16:37:16 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Matthew Garrett <matthewgarrett@google.com>
Cc:     jmorris@namei.org, linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-api@vger.kernel.org,
        Matthew Garrett <mjg59@google.com>
Subject: Re: [PATCH V34 02/29] security: Add a "locked down" LSM hook
Message-ID: <201906221637.6BEE8F7@keescook>
References: <20190622000358.19895-1-matthewgarrett@google.com>
 <20190622000358.19895-3-matthewgarrett@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190622000358.19895-3-matthewgarrett@google.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 21, 2019 at 05:03:31PM -0700, Matthew Garrett wrote:
> Add a mechanism to allow LSMs to make a policy decision around whether
> kernel functionality that would allow tampering with or examining the
> runtime state of the kernel should be permitted.
> 
> Signed-off-by: Matthew Garrett <mjg59@google.com>

Acked-by: Kees Cook <keescook@chromium.org>

-Kees

> ---
>  include/linux/lsm_hooks.h |  2 ++
>  include/linux/security.h  | 11 +++++++++++
>  security/security.c       |  6 ++++++
>  3 files changed, 19 insertions(+)
> 
> diff --git a/include/linux/lsm_hooks.h b/include/linux/lsm_hooks.h
> index 66fd1eac7a32..df2aebc99838 100644
> --- a/include/linux/lsm_hooks.h
> +++ b/include/linux/lsm_hooks.h
> @@ -1790,6 +1790,7 @@ union security_list_options {
>  	int (*bpf_prog_alloc_security)(struct bpf_prog_aux *aux);
>  	void (*bpf_prog_free_security)(struct bpf_prog_aux *aux);
>  #endif /* CONFIG_BPF_SYSCALL */
> +	int (*locked_down)(enum lockdown_reason what);
>  };
>  
>  struct security_hook_heads {
> @@ -2027,6 +2028,7 @@ struct security_hook_heads {
>  	struct hlist_head bpf_prog_alloc_security;
>  	struct hlist_head bpf_prog_free_security;
>  #endif /* CONFIG_BPF_SYSCALL */
> +	struct hlist_head locked_down;
>  } __randomize_layout;
>  
>  /*
> diff --git a/include/linux/security.h b/include/linux/security.h
> index 1bb6fb2f1523..9eaf02e70707 100644
> --- a/include/linux/security.h
> +++ b/include/linux/security.h
> @@ -76,6 +76,12 @@ enum lsm_event {
>  	LSM_POLICY_CHANGE,
>  };
>  
> +enum lockdown_reason {
> +	LOCKDOWN_NONE,
> +	LOCKDOWN_INTEGRITY_MAX,
> +	LOCKDOWN_CONFIDENTIALITY_MAX,
> +};
> +
>  /* These functions are in security/commoncap.c */
>  extern int cap_capable(const struct cred *cred, struct user_namespace *ns,
>  		       int cap, unsigned int opts);
> @@ -389,6 +395,7 @@ void security_inode_invalidate_secctx(struct inode *inode);
>  int security_inode_notifysecctx(struct inode *inode, void *ctx, u32 ctxlen);
>  int security_inode_setsecctx(struct dentry *dentry, void *ctx, u32 ctxlen);
>  int security_inode_getsecctx(struct inode *inode, void **ctx, u32 *ctxlen);
> +int security_locked_down(enum lockdown_reason what);
>  #else /* CONFIG_SECURITY */
>  
>  static inline int call_lsm_notifier(enum lsm_event event, void *data)
> @@ -1189,6 +1196,10 @@ static inline int security_inode_getsecctx(struct inode *inode, void **ctx, u32
>  {
>  	return -EOPNOTSUPP;
>  }
> +static inline int security_locked_down(enum lockdown_reason what)
> +{
> +	return 0;
> +}
>  #endif	/* CONFIG_SECURITY */
>  
>  #ifdef CONFIG_SECURITY_NETWORK
> diff --git a/security/security.c b/security/security.c
> index 487e1f3eb2df..553f50e9a106 100644
> --- a/security/security.c
> +++ b/security/security.c
> @@ -2382,3 +2382,9 @@ void security_bpf_prog_free(struct bpf_prog_aux *aux)
>  	call_void_hook(bpf_prog_free_security, aux);
>  }
>  #endif /* CONFIG_BPF_SYSCALL */
> +
> +int security_locked_down(enum lockdown_reason what)
> +{
> +	return call_int_hook(locked_down, 0, what);
> +}
> +EXPORT_SYMBOL(security_locked_down);
> -- 
> 2.22.0.410.gd8fdbe21b5-goog
> 

-- 
Kees Cook
