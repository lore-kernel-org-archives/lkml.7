Return-Path: <SRS0=bMiL=T7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,T_DKIMWL_WL_HIGH autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5AF40C28CC3
	for <linux-kernel@archiver.kernel.org>; Fri, 31 May 2019 21:01:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2836226EEF
	for <linux-kernel@archiver.kernel.org>; Fri, 31 May 2019 21:01:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="g0KB+6Y2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727589AbfEaVB2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 31 May 2019 17:01:28 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:34951 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727233AbfEaVB2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 May 2019 17:01:28 -0400
Received: by mail-pg1-f195.google.com with SMTP id t1so1158902pgc.2
        for <linux-kernel@vger.kernel.org>; Fri, 31 May 2019 14:01:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=DP3CVXmE/gQtGlfYoS276lusULFV6LiuuJ2eL+PXPcY=;
        b=g0KB+6Y259/gkduT0X6uIFUG9lC7gD3Q1U+W533KEOeKWeobAR50VIM3TvOHj9GiHM
         Nl6hPUSHweKNSJzMYfX8x6nGtcpSiLmfFOnrIN72DAukb/OTHqlOabjAh14XD6YEupKQ
         G7YvLGB2N1PdwpzkldAcCZPtF2lhuO20XAVq4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=DP3CVXmE/gQtGlfYoS276lusULFV6LiuuJ2eL+PXPcY=;
        b=V2rGknhEO+yKIhu33yY/HMogTNNB57qQo0ICWO69P+aFq6yU58fMM9FgTTu9/uNVa4
         1YVUcu/9Eckq2sb85jk5cV4AIhrSxTmsrPM0SHn8MWi1dEYbBKbmAQVYCQE6/3auJjbi
         g6Bs9lYaMG0jXPkTHHCVvMtqWsIyzw/SGYNGkbWHrmLs8Dx1L6Bc5LcW/rxxwnF9zvEy
         R8vK0Gxv8h33iJrbivwiupUD6QjVf57p8cdz7xKFEoRGg3mdp/dnQHUyZNISBLUYTml3
         drtaWxQ7hwMd1wsVtWWF51WrGFE0xVhIx9dg+s9tyvXfonLIb/qz06l4kFi7Tu5i91zx
         wiwg==
X-Gm-Message-State: APjAAAVXExZOHsFaGrznjB2t7LC1ObIXyMIkJAuPcGaYde3SJAP+y5Hf
        QoSwrGKPbfZDJEEogVOQQLeAIg==
X-Google-Smtp-Source: APXvYqwHmXlU73kVEk1sQ3xJWtgs11NZZc6SvuB9jjhv/3EVfBjo6WZriCxvHE7y9nFkYaV+gWmPIA==
X-Received: by 2002:a63:5d45:: with SMTP id o5mr11709981pgm.40.1559336486946;
        Fri, 31 May 2019 14:01:26 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id u123sm7509820pfu.67.2019.05.31.14.01.25
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 31 May 2019 14:01:26 -0700 (PDT)
Date:   Fri, 31 May 2019 14:01:24 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Ke Wu <mikewu@google.com>
Cc:     Jonathan Corbet <corbet@lwn.net>, James Morris <jmorris@namei.org>,
        "Serge E. Hallyn" <serge@hallyn.com>, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-security-module@vger.kernel.org
Subject: Re: [PATCH v3] Allow to exclude specific file types in LoadPin
Message-ID: <201905311401.6CB27923@keescook>
References: <20190529224350.6460-1-mikewu@google.com>
 <20190531182553.51721-1-mikewu@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190531182553.51721-1-mikewu@google.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 31, 2019 at 11:25:53AM -0700, Ke Wu wrote:
> Linux kernel already provide MODULE_SIG and KEXEC_VERIFY_SIG to
> make sure loaded kernel module and kernel image are trusted. This
> patch adds a kernel command line option "loadpin.exclude" which
> allows to exclude specific file types from LoadPin. This is useful
> when people want to use different mechanisms to verify module and
> kernel image while still use LoadPin to protect the integrity of
> other files kernel loads.
> 
> Signed-off-by: Ke Wu <mikewu@google.com>
> ---
> Changelog since v2:
> - Make size of exclude_read_files and ignore_read_file_id to be
>   equal to the size of kernel_read_file_str.

Thanks! I've fixed this differently and it should be visible shortly.

-Kees

> 
> Changelog since v1:
> - Mark ignore_read_file_id with __ro_after_init.
> - Mark parse_exclude() with __init.
> - Use ARRAY_SIZE(ignore_read_file_id) instead of READING_MAX_ID.
> 
> 
>  Documentation/admin-guide/LSM/LoadPin.rst | 10 ++++++
>  security/loadpin/loadpin.c                | 42 +++++++++++++++++++++++
>  2 files changed, 52 insertions(+)
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
> index 055fb0a64169..baa8a5b08c53 100644
> --- a/security/loadpin/loadpin.c
> +++ b/security/loadpin/loadpin.c
> @@ -45,6 +45,12 @@ static void report_load(const char *origin, struct file *file, char *operation)
>  }
>  
>  static int enforce = IS_ENABLED(CONFIG_SECURITY_LOADPIN_ENFORCE);
> +/*
> + * The size should be READING_MAX_ID + 1 to be equal to the size of
> + * kernel_read_file_str.
> + */
> +static char *exclude_read_files[READING_MAX_ID + 1];
> +static int ignore_read_file_id[READING_MAX_ID + 1] __ro_after_init;
>  static struct super_block *pinned_root;
>  static DEFINE_SPINLOCK(pinned_root_spinlock);
>  
> @@ -129,6 +135,13 @@ static int loadpin_read_file(struct file *file, enum kernel_read_file_id id)
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
> @@ -187,10 +200,37 @@ static struct security_hook_list loadpin_hooks[] __lsm_ro_after_init = {
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
> @@ -203,3 +243,5 @@ DEFINE_LSM(loadpin) = {
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
