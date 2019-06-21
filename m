Return-Path: <SRS0=s1fu=UU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 976ADC43613
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Jun 2019 03:23:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6BF6820673
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Jun 2019 03:23:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="BQu2ka8j"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726063AbfFUDXF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Jun 2019 23:23:05 -0400
Received: from mail-pl1-f194.google.com ([209.85.214.194]:32899 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726032AbfFUDXE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Jun 2019 23:23:04 -0400
Received: by mail-pl1-f194.google.com with SMTP id c14so2284864plo.0
        for <linux-kernel@vger.kernel.org>; Thu, 20 Jun 2019 20:23:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=beiDe3ElzB8KJzXiRGHdjDcRYndCY0Vsq1yIwl9ZJLg=;
        b=BQu2ka8jLwFrmgfX76tLiJDM8YG/WoCn/Wcm4yIIlPJFbe6uZlMWbTVfdS+4RLSuU8
         f1C1TuerhuYELRL9asEzmja5Pfpvu//WQ2xlbKUJY4aazXQdP6hfZLGxPCllZQ2BU1z/
         phIOKpJTLNQOYmBuyED87l+oBkzXizgfEGmog=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=beiDe3ElzB8KJzXiRGHdjDcRYndCY0Vsq1yIwl9ZJLg=;
        b=XMTA/ZiB0odJIQvVhXxMoJUL0CQdEsOKBQmVDKjbxsXxr14KAXcmqmeiI4axqxrOeA
         un+Fjguv+KXwqUKbqyBHiu4vlmTWmVIorddgFt01sWOdD7rpFavmi4BAYW5/lJQGJuDl
         JCK/zdMIiVX+eal7NZaA2MbaS6FiOMPFngN+yYyhr1rBCRLgPH+GVAiH2ZkRM9b+ocy2
         qwe5fFKhuviI/c0JEWn9mQBDNLGjEHtBnpKP0cAzCnjjGC8Kyx6NbXng5YDHDPpXkqRA
         U50NpdRRlm1FTWpTsTSg7LtXszPiXL4GA1hMCHuBCfLmBuKCNEeKAAHgsI3bL757+qHN
         fk6g==
X-Gm-Message-State: APjAAAUoC7q03O8+oKYN4pdZGymEzPaVTEiPuTmUy/1+R9DHOgfJu4L/
        cDfihJy+LJYWH9beOKv9/4Bvfw==
X-Google-Smtp-Source: APXvYqw3NCKZKUAW+50E6ACZXc95q0SJjKTt2ful0k+80n1lnOPj5GvR+wGrxp7hJtPab4QvFdCAUw==
X-Received: by 2002:a17:902:296a:: with SMTP id g97mr54844620plb.115.1561087383852;
        Thu, 20 Jun 2019 20:23:03 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id j23sm881405pff.90.2019.06.20.20.23.02
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 20 Jun 2019 20:23:03 -0700 (PDT)
Date:   Thu, 20 Jun 2019 20:23:02 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Matthew Garrett <matthewgarrett@google.com>
Cc:     jmorris@namei.org, linux-security@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-api@vger.kernel.org,
        Matthew Garrett <mjg59@google.com>
Subject: Re: [PATCH V33 02/30] security: Add a "locked down" LSM hook
Message-ID: <201906202022.B09ED6E0@keescook>
References: <20190621011941.186255-1-matthewgarrett@google.com>
 <20190621011941.186255-3-matthewgarrett@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190621011941.186255-3-matthewgarrett@google.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 20, 2019 at 06:19:13PM -0700, Matthew Garrett wrote:
> Add a mechanism to allow LSMs to make a policy decision around whether
> kernel functionality that would allow tampering with or examining the
> runtime state of the kernel should be permitted.
> 
> Signed-off-by: Matthew Garrett <mjg59@google.com>
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
> index 1bb6fb2f1523..b75941c811e6 100644
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
> +int security_is_locked_down(enum lockdown_reason what);

bikeshed: can this just be called "security_locked_down" without the
"is"?

-Kees

>  #else /* CONFIG_SECURITY */
>  
>  static inline int call_lsm_notifier(enum lsm_event event, void *data)
> @@ -1189,6 +1196,10 @@ static inline int security_inode_getsecctx(struct inode *inode, void **ctx, u32
>  {
>  	return -EOPNOTSUPP;
>  }
> +static inline int security_is_locked_down(enum lockdown_reason what)
> +{
> +	return 0;
> +}
>  #endif	/* CONFIG_SECURITY */
>  
>  #ifdef CONFIG_SECURITY_NETWORK
> diff --git a/security/security.c b/security/security.c
> index 2a6672c9e72f..17c17d4d8552 100644
> --- a/security/security.c
> +++ b/security/security.c
> @@ -2378,3 +2378,9 @@ void security_bpf_prog_free(struct bpf_prog_aux *aux)
>  	call_void_hook(bpf_prog_free_security, aux);
>  }
>  #endif /* CONFIG_BPF_SYSCALL */
> +
> +int security_is_locked_down(enum lockdown_reason what)
> +{
> +	return call_int_hook(locked_down, 0, what);
> +}
> +EXPORT_SYMBOL(security_is_locked_down);
> -- 
> 2.22.0.410.gd8fdbe21b5-goog
> 

-- 
Kees Cook
