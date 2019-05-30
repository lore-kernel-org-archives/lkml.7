Return-Path: <SRS0=Dgga=T6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8C88C28CC0
	for <linux-kernel@archiver.kernel.org>; Thu, 30 May 2019 22:12:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6D7202627A
	for <linux-kernel@archiver.kernel.org>; Thu, 30 May 2019 22:12:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="AunMj+0U"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726566AbfE3WMA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 May 2019 18:12:00 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:34308 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726045AbfE3WMA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 May 2019 18:12:00 -0400
Received: by mail-pg1-f196.google.com with SMTP id h2so2809961pgg.1
        for <linux-kernel@vger.kernel.org>; Thu, 30 May 2019 15:11:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=c+UaSuDYqH6T/H7JSnk6xx+A7MYvkGNlHvAGGxG2hBM=;
        b=AunMj+0UFjb9yNAFNOgENopIjz5M8mXIDDndVhTQs8T+ffc6nZxDFPLpHVKP4VfVvd
         2DQV4IQyx2jFAhYGqQwEzF8gn8c7fR66Hc+G6hJHzsFYstRbroGpRNy/E2/aAPT+MRYj
         6u6JJQaID8fEG2aWvB7d+6in62d6nobBYyoJY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=c+UaSuDYqH6T/H7JSnk6xx+A7MYvkGNlHvAGGxG2hBM=;
        b=gOUF+gpbfQRvE4TgvJHi+PlXEoBIwyXxkNYJbtALo7II0MVabZoSPqWcvPdCzFJoi3
         gE+ZJuwO2hrfOBnHrGPwuY2XPyUHocevJ3nYZPFMuSWro683b6CPYMjQJGy6CUG7JRkX
         ecFQIqiRzYyfmzn58gmfpMrw6oonLnEBRYHG01R1TYwRe8GZ+34O+RmE4+o4VWhmjgNA
         /Fy7M5W8dU//SQ6Gz5ND4426s9bC5SwIUiW0pJJKT2GkJt9bpN2D12vbtwsyhDbElUaO
         88VrUPXlpwHmp5sy/Rganfe3fCQYv4MFl/++8qkfE4jGzaGzItJ19eXOOVCHrcN1Gtkx
         E2ZQ==
X-Gm-Message-State: APjAAAVcVx+cPMAH3W/3K6IwESvgi44PydnIJVMNirKMEezZ0DL0qyH4
        3neS0HuUSR8ryWuyJnePJyVztg==
X-Google-Smtp-Source: APXvYqzxgYCNZP/4SbY/hP+2VG2t7o7q6ILRQGZSZw8M6GoK19+iITnYp5xMnIE1y0pGdHUnIIMCPw==
X-Received: by 2002:a65:628d:: with SMTP id f13mr5576534pgv.177.1559252541485;
        Thu, 30 May 2019 14:42:21 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id u11sm3671591pfh.130.2019.05.30.14.42.19
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 30 May 2019 14:42:19 -0700 (PDT)
Date:   Thu, 30 May 2019 14:42:18 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Ke Wu <mikewu@google.com>, James Morris <jmorris@namei.org>
Cc:     Jonathan Corbet <corbet@lwn.net>,
        "Serge E. Hallyn" <serge@hallyn.com>, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-security-module@vger.kernel.org
Subject: Re: [PATCH v2] Allow to exclude specific file types in LoadPin
Message-ID: <201905301440.1DC01275@keescook>
References: <20190529224350.6460-1-mikewu@google.com>
 <20190530192208.99773-1-mikewu@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190530192208.99773-1-mikewu@google.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 30, 2019 at 12:22:08PM -0700, Ke Wu wrote:
> Linux kernel already provide MODULE_SIG and KEXEC_VERIFY_SIG to
> make sure loaded kernel module and kernel image are trusted. This
> patch adds a kernel command line option "loadpin.exclude" which
> allows to exclude specific file types from LoadPin. This is useful
> when people want to use different mechanisms to verify module and
> kernel image while still use LoadPin to protect the integrity of
> other files kernel loads.
> 
> Signed-off-by: Ke Wu <mikewu@google.com>

Thanks for the updates!

Acked-by: Kees Cook <keescook@chromium.org>

James, I don't have anything else planned for loadpin this cycle. Do you
want me to push this to Linus in the next cycle, or do you want to take
it into one of your trees?

Thanks!

-Kees

> ---
> Changelog since v1:
> - Mark ignore_read_file_id with __ro_after_init.
> - Mark parse_exclude() with __init.
> - Use ARRAY_SIZE(ignore_read_file_id) instead of READING_MAX_ID.
> 
> 
>  Documentation/admin-guide/LSM/LoadPin.rst | 10 ++++++
>  security/loadpin/loadpin.c                | 38 +++++++++++++++++++++++
>  2 files changed, 48 insertions(+)
> 
> diff --git a/Documentation/admin-guide/LSM/LoadPin.rst b/Documentation/admin-guide/LSM/LoadPin.rst
> index 32070762d24c..716ad9b23c9a 100644
> --- a/Documentation/admin-guide/LSM/LoadPin.rst
> +++ b/Documentation/admin-guide/LSM/LoadPin.rst
> @@ -19,3 +19,13 @@ block device backing the filesystem is not read-only, a sysctl is
>  created to toggle pinning: ``/proc/sys/kernel/loadpin/enabled``. (Having
>  a mutable filesystem means pinning is mutable too, but having the
>  sysctl allows for easy testing on systems with a mutable filesystem.)
> +
> +It's also possible to exclude specific file types from LoadPin using kernel
> +command line option "``loadpin.exclude``". By default, all files are
> +included, but they can be excluded using kernel command line option such
> +as "``loadpin.exclude=kernel-module,kexec-image``". This allows to use
> +different mechanisms such as ``CONFIG_MODULE_SIG`` and
> +``CONFIG_KEXEC_VERIFY_SIG`` to verify kernel module and kernel image while
> +still use LoadPin to protect the integrity of other files kernel loads. The
> +full list of valid file types can be found in ``kernel_read_file_str``
> +defined in ``include/linux/fs.h``.
> diff --git a/security/loadpin/loadpin.c b/security/loadpin/loadpin.c
> index 055fb0a64169..d5f064644c54 100644
> --- a/security/loadpin/loadpin.c
> +++ b/security/loadpin/loadpin.c
> @@ -45,6 +45,8 @@ static void report_load(const char *origin, struct file *file, char *operation)
>  }
>  
>  static int enforce = IS_ENABLED(CONFIG_SECURITY_LOADPIN_ENFORCE);
> +static char *exclude_read_files[READING_MAX_ID];
> +static int ignore_read_file_id[READING_MAX_ID] __ro_after_init;
>  static struct super_block *pinned_root;
>  static DEFINE_SPINLOCK(pinned_root_spinlock);
>  
> @@ -129,6 +131,13 @@ static int loadpin_read_file(struct file *file, enum kernel_read_file_id id)
>  	struct super_block *load_root;
>  	const char *origin = kernel_read_file_id_str(id);
>  
> +	/* If the file id is excluded, ignore the pinning. */
> +	if ((unsigned int)id < ARRAY_SIZE(ignore_read_file_id) &&
> +	    ignore_read_file_id[id]) {
> +		report_load(origin, file, "pinning-excluded");
> +		return 0;
> +	}
> +
>  	/* This handles the older init_module API that has a NULL file. */
>  	if (!file) {
>  		if (!enforce) {
> @@ -187,10 +196,37 @@ static struct security_hook_list loadpin_hooks[] __lsm_ro_after_init = {
>  	LSM_HOOK_INIT(kernel_load_data, loadpin_load_data),
>  };
>  
> +static void __init parse_exclude(void)
> +{
> +	int i, j;
> +	char *cur;
> +
> +	for (i = 0; i < ARRAY_SIZE(exclude_read_files); i++) {
> +		cur = exclude_read_files[i];
> +		if (!cur)
> +			break;
> +		if (*cur == '\0')
> +			continue;
> +
> +		for (j = 0; j < ARRAY_SIZE(kernel_read_file_str); j++) {
> +			if (strcmp(cur, kernel_read_file_str[j]) == 0) {
> +				pr_info("excluding: %s\n",
> +					kernel_read_file_str[j]);
> +				ignore_read_file_id[j] = 1;
> +				/*
> +				 * Can not break, because one read_file_str
> +				 * may map to more than on read_file_id.
> +				 */
> +			}
> +		}
> +	}
> +}
> +
>  static int __init loadpin_init(void)
>  {
>  	pr_info("ready to pin (currently %senforcing)\n",
>  		enforce ? "" : "not ");
> +	parse_exclude();
>  	security_add_hooks(loadpin_hooks, ARRAY_SIZE(loadpin_hooks), "loadpin");
>  	return 0;
>  }
> @@ -203,3 +239,5 @@ DEFINE_LSM(loadpin) = {
>  /* Should not be mutable after boot, so not listed in sysfs (perm == 0). */
>  module_param(enforce, int, 0);
>  MODULE_PARM_DESC(enforce, "Enforce module/firmware pinning");
> +module_param_array_named(exclude, exclude_read_files, charp, NULL, 0);
> +MODULE_PARM_DESC(exclude, "Exclude pinning specific read file types");
> -- 
> 2.22.0.rc1.257.g3120a18244-goog
> 

-- 
Kees Cook
