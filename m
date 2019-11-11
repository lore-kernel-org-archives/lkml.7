Return-Path: <SRS0=camR=ZD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C2CD1C43331
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Nov 2019 17:56:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8972D206BA
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Nov 2019 17:56:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="SLvIW861"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726928AbfKKR4V (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Nov 2019 12:56:21 -0500
Received: from mail-pf1-f196.google.com ([209.85.210.196]:33412 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726763AbfKKR4V (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Nov 2019 12:56:21 -0500
Received: by mail-pf1-f196.google.com with SMTP id c184so11201560pfb.0
        for <linux-kernel@vger.kernel.org>; Mon, 11 Nov 2019 09:56:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=44TDHe9RfT98Q3zYHwAvTRATWM0VKLfWTcrUrfztb9c=;
        b=SLvIW861Kz0uVoPbdC/7b4bkEHOzyOSzotLaBiFFZ+kt4HXGfoQEVw53aKyRDwLIFD
         cWwHJDFRK72F8gG20A9wBJUqd3dy4RJbbkTQVqiNkSQTZdZCjX/muu1O4cIDXMfwnEfH
         t1OIlzgMElFtbfh6/Q/pTh6lDbYzJJUIDFSrw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=44TDHe9RfT98Q3zYHwAvTRATWM0VKLfWTcrUrfztb9c=;
        b=dVFttVFU7QK1zOReZZjoLDvP2fAuFteQM8HEgGPzSBPdHjSN8E0pxKtAcx7xyJzpem
         1hO3cXL7ZtdiUkAE9TKb51IrJYZpX5O0Fm5kul+dbn9qDj6ECP3KwgTKIAKYI/UPRIn3
         tEWRjUeO7G4LJ3C5Qlj9QCunQMWISzt+DHiZOapr88ZYsRHtzu+XnCRvKRUZHGShhkY8
         UTFa5gMbOff1xSw5qHzWXgLMWiZKeWsifNkq0M56NFizRX3CN5Dajri4cexbN9ggkj/x
         Q1XCacsLcTO/SOSIHx4QT6zKjWIxg38QZ2spUCFPxW2eWDXBJsXMHb3KLej2njdTA0q6
         o7xg==
X-Gm-Message-State: APjAAAU8ODJLkR50AIZFK8Uol/pQGF/gloqPfT48d9Uy3/9AsU6L1Gtk
        LJlwCRWPB2QVFe4StVl+g7ViQw==
X-Google-Smtp-Source: APXvYqzIaAsWjgLCLNI/fYrORh1uY65wlevPmH1iBPKLHTFaA+duIIXXzKsuYaN0jCXgXEmROHwN0Q==
X-Received: by 2002:a17:90a:2e87:: with SMTP id r7mr296808pjd.21.1573494978432;
        Mon, 11 Nov 2019 09:56:18 -0800 (PST)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id i13sm14721396pfo.39.2019.11.11.09.56.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Nov 2019 09:56:17 -0800 (PST)
Date:   Mon, 11 Nov 2019 09:56:16 -0800
From:   Kees Cook <keescook@chromium.org>
To:     Borislav Petkov <bp@alien8.de>
Cc:     Zhang Xiaoxu <zhangxiaoxu5@huawei.com>, zhangxiaoxu@huawei.com,
        mingo@redhat.com, hpa@zytor.com, x86@kernel.org,
        tyhicks@canonical.com, colin.king@canonical.com,
        tglx@linutronix.de, linux-kernel@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        Matthew Garrett <mjg59@google.com>
Subject: Re: [PATCH] x86/mtrr: only administrator can read the configurations.
Message-ID: <201911110934.AC5BA313@keescook>
References: <20191105071714.27376-1-zhangxiaoxu5@huawei.com>
 <201911081236.57A127A@keescook>
 <20191108205031.GH4503@zn.tnic>
 <201911081320.5D3CD1A4CD@keescook>
 <20191108213307.GI4503@zn.tnic>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191108213307.GI4503@zn.tnic>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[this wasn't being discussed on a list... CCing lkml]

On Fri, Nov 08, 2019 at 10:33:07PM +0100, Borislav Petkov wrote:
> On Fri, Nov 08, 2019 at 01:22:50PM -0800, Kees Cook wrote:
> > The correct pattern for these kinds of things is to do the checks at
> > open time, yes. (Which is why I perked up at this patch when I noticed
> > it.)
> 
> I would move it there but...
> 
> > Well, I'm not entirely sure what the issue here is. I saw the patch also
> > changed the DAC permissions to 0600, so wouldn't that alone fix things?
> > But the capable checks moved around... is there an "unprivileged" use of
> > this file any more? If so, why keep at capable() checks and just use
> > DAC?
> 
> ... yes, that would be even better because it would kill all the checks,
> so less code.
> 
> How's that?

Some recap from being accidentally offlist:

- this patch should check capabilities at open time (or retain the
  checks on the opener's permissions for later checks).

- changing the DAC permissions might break something that expects to
  read mtrr when not uid 0.

- if we leave the DAC permissions alone and just move the capable check
  to the opener, we should get the intent of the original patch. (i.e.
  check against CAP_SYS_ADMIN not just the wider uid 0.)

- *this may still break things* if userspace expects to be able to
  read other parts of the file as non-uid-0 and non-CAP_SYS_ADMIN.
  If *that* is the case, then we need to censor the contents using
  the opener's permissions (as done in other /proc cases).

I think the most cautious way forward is something like
51d7b120418e ("/proc/iomem: only expose physical resource addresses to
privileged users"). Untested (and should likely be expanded to know
about read vs write for lockdown interaction):


diff --git a/arch/x86/kernel/cpu/mtrr/if.c b/arch/x86/kernel/cpu/mtrr/if.c
index 4d36dcc1cf87..7ccc3e290338 100644
--- a/arch/x86/kernel/cpu/mtrr/if.c
+++ b/arch/x86/kernel/cpu/mtrr/if.c
@@ -34,6 +34,11 @@ const char *mtrr_attrib_to_str(int x)
 
 #ifdef CONFIG_PROC_FS
 
+static bool has_mtrr_privs(struct file *file)
+{
+	return file_ns_capable(file, &init_user_ns, CAP_SYS_ADMIN);
+}
+
 static int
 mtrr_file_add(unsigned long base, unsigned long size,
 	      unsigned int type, bool increment, struct file *file, int page)
@@ -101,7 +106,7 @@ mtrr_write(struct file *file, const char __user *buf, size_t len, loff_t * ppos)
 	int length;
 	size_t linelen;
 
-	if (!capable(CAP_SYS_ADMIN))
+	if (!has_mtrr_privs(file))
 		return -EPERM;
 
 	memset(line, 0, LINE_SIZE);
@@ -226,7 +231,7 @@ mtrr_ioctl(struct file *file, unsigned int cmd, unsigned long __arg)
 #ifdef CONFIG_COMPAT
 	case MTRRIOC32_ADD_ENTRY:
 #endif
-		if (!capable(CAP_SYS_ADMIN))
+		if (!has_mtrr_privs(file))
 			return -EPERM;
 		err =
 		    mtrr_file_add(sentry.base, sentry.size, sentry.type, true,
@@ -236,7 +241,7 @@ mtrr_ioctl(struct file *file, unsigned int cmd, unsigned long __arg)
 #ifdef CONFIG_COMPAT
 	case MTRRIOC32_SET_ENTRY:
 #endif
-		if (!capable(CAP_SYS_ADMIN))
+		if (!has_mtrr_privs(file))
 			return -EPERM;
 		err = mtrr_add(sentry.base, sentry.size, sentry.type, false);
 		break;
@@ -244,7 +249,7 @@ mtrr_ioctl(struct file *file, unsigned int cmd, unsigned long __arg)
 #ifdef CONFIG_COMPAT
 	case MTRRIOC32_DEL_ENTRY:
 #endif
-		if (!capable(CAP_SYS_ADMIN))
+		if (!has_mtrr_privs(file))
 			return -EPERM;
 		err = mtrr_file_del(sentry.base, sentry.size, file, 0);
 		break;
@@ -252,7 +257,7 @@ mtrr_ioctl(struct file *file, unsigned int cmd, unsigned long __arg)
 #ifdef CONFIG_COMPAT
 	case MTRRIOC32_KILL_ENTRY:
 #endif
-		if (!capable(CAP_SYS_ADMIN))
+		if (!has_mtrr_privs(file))
 			return -EPERM;
 		err = mtrr_del(-1, sentry.base, sentry.size);
 		break;
@@ -279,7 +284,7 @@ mtrr_ioctl(struct file *file, unsigned int cmd, unsigned long __arg)
 #ifdef CONFIG_COMPAT
 	case MTRRIOC32_ADD_PAGE_ENTRY:
 #endif
-		if (!capable(CAP_SYS_ADMIN))
+		if (!has_mtrr_privs(file))
 			return -EPERM;
 		err =
 		    mtrr_file_add(sentry.base, sentry.size, sentry.type, true,
@@ -289,7 +294,7 @@ mtrr_ioctl(struct file *file, unsigned int cmd, unsigned long __arg)
 #ifdef CONFIG_COMPAT
 	case MTRRIOC32_SET_PAGE_ENTRY:
 #endif
-		if (!capable(CAP_SYS_ADMIN))
+		if (!has_mtrr_privs(file))
 			return -EPERM;
 		err =
 		    mtrr_add_page(sentry.base, sentry.size, sentry.type, false);
@@ -298,7 +303,7 @@ mtrr_ioctl(struct file *file, unsigned int cmd, unsigned long __arg)
 #ifdef CONFIG_COMPAT
 	case MTRRIOC32_DEL_PAGE_ENTRY:
 #endif
-		if (!capable(CAP_SYS_ADMIN))
+		if (!has_mtrr_privs(file))
 			return -EPERM;
 		err = mtrr_file_del(sentry.base, sentry.size, file, 1);
 		break;
@@ -306,7 +311,7 @@ mtrr_ioctl(struct file *file, unsigned int cmd, unsigned long __arg)
 #ifdef CONFIG_COMPAT
 	case MTRRIOC32_KILL_PAGE_ENTRY:
 #endif
-		if (!capable(CAP_SYS_ADMIN))
+		if (!has_mtrr_privs(file))
 			return -EPERM;
 		err = mtrr_del_page(-1, sentry.base, sentry.size);
 		break;
@@ -401,6 +406,7 @@ static int mtrr_seq_show(struct seq_file *seq, void *offset)
 	int i, max;
 	mtrr_type type;
 	unsigned long base, size;
+	int usage;
 
 	max = num_var_ranges;
 	for (i = 0; i < max; i++) {
@@ -409,6 +415,15 @@ static int mtrr_seq_show(struct seq_file *seq, void *offset)
 			mtrr_usage_table[i] = 0;
 			continue;
 		}
+		usage = mtrr_usage_table[i];
+		type_str = mtrr_attrib_to_str(type);
+
+		if (!has_mtrr_privs(seq->file)) {
+			base = 0;
+			size = 0;
+			usage = 0;
+			type_str = "?";
+		}
 		if (size < (0x100000 >> PAGE_SHIFT)) {
 			/* less than 1MB */
 			factor = 'K';
@@ -420,8 +435,7 @@ static int mtrr_seq_show(struct seq_file *seq, void *offset)
 		/* Base can be > 32bit */
 		seq_printf(seq, "reg%02i: base=0x%06lx000 (%5luMB), size=%5lu%cB, count=%d: %s\n",
 			   i, base, base >> (20 - PAGE_SHIFT),
-			   size, factor,
-			   mtrr_usage_table[i], mtrr_attrib_to_str(type));
+			   size, factor, usage, type_str);
 	}
 	return 0;
 }


If we want to risk breaking stuff, here is the "just check capable at open time" patch:

diff --git a/arch/x86/kernel/cpu/mtrr/if.c b/arch/x86/kernel/cpu/mtrr/if.c
index 4d36dcc1cf87..a65e5c6686d0 100644
--- a/arch/x86/kernel/cpu/mtrr/if.c
+++ b/arch/x86/kernel/cpu/mtrr/if.c
@@ -101,9 +101,6 @@ mtrr_write(struct file *file, const char __user *buf, size_t len, loff_t * ppos)
 	int length;
 	size_t linelen;
 
-	if (!capable(CAP_SYS_ADMIN))
-		return -EPERM;
-
 	memset(line, 0, LINE_SIZE);
 
 	len = min_t(size_t, len, LINE_SIZE - 1);
@@ -226,8 +223,6 @@ mtrr_ioctl(struct file *file, unsigned int cmd, unsigned long __arg)
 #ifdef CONFIG_COMPAT
 	case MTRRIOC32_ADD_ENTRY:
 #endif
-		if (!capable(CAP_SYS_ADMIN))
-			return -EPERM;
 		err =
 		    mtrr_file_add(sentry.base, sentry.size, sentry.type, true,
 				  file, 0);
@@ -236,24 +231,18 @@ mtrr_ioctl(struct file *file, unsigned int cmd, unsigned long __arg)
 #ifdef CONFIG_COMPAT
 	case MTRRIOC32_SET_ENTRY:
 #endif
-		if (!capable(CAP_SYS_ADMIN))
-			return -EPERM;
 		err = mtrr_add(sentry.base, sentry.size, sentry.type, false);
 		break;
 	case MTRRIOC_DEL_ENTRY:
 #ifdef CONFIG_COMPAT
 	case MTRRIOC32_DEL_ENTRY:
 #endif
-		if (!capable(CAP_SYS_ADMIN))
-			return -EPERM;
 		err = mtrr_file_del(sentry.base, sentry.size, file, 0);
 		break;
 	case MTRRIOC_KILL_ENTRY:
 #ifdef CONFIG_COMPAT
 	case MTRRIOC32_KILL_ENTRY:
 #endif
-		if (!capable(CAP_SYS_ADMIN))
-			return -EPERM;
 		err = mtrr_del(-1, sentry.base, sentry.size);
 		break;
 	case MTRRIOC_GET_ENTRY:
@@ -279,8 +268,6 @@ mtrr_ioctl(struct file *file, unsigned int cmd, unsigned long __arg)
 #ifdef CONFIG_COMPAT
 	case MTRRIOC32_ADD_PAGE_ENTRY:
 #endif
-		if (!capable(CAP_SYS_ADMIN))
-			return -EPERM;
 		err =
 		    mtrr_file_add(sentry.base, sentry.size, sentry.type, true,
 				  file, 1);
@@ -289,8 +276,6 @@ mtrr_ioctl(struct file *file, unsigned int cmd, unsigned long __arg)
 #ifdef CONFIG_COMPAT
 	case MTRRIOC32_SET_PAGE_ENTRY:
 #endif
-		if (!capable(CAP_SYS_ADMIN))
-			return -EPERM;
 		err =
 		    mtrr_add_page(sentry.base, sentry.size, sentry.type, false);
 		break;
@@ -298,16 +283,12 @@ mtrr_ioctl(struct file *file, unsigned int cmd, unsigned long __arg)
 #ifdef CONFIG_COMPAT
 	case MTRRIOC32_DEL_PAGE_ENTRY:
 #endif
-		if (!capable(CAP_SYS_ADMIN))
-			return -EPERM;
 		err = mtrr_file_del(sentry.base, sentry.size, file, 1);
 		break;
 	case MTRRIOC_KILL_PAGE_ENTRY:
 #ifdef CONFIG_COMPAT
 	case MTRRIOC32_KILL_PAGE_ENTRY:
 #endif
-		if (!capable(CAP_SYS_ADMIN))
-			return -EPERM;
 		err = mtrr_del_page(-1, sentry.base, sentry.size);
 		break;
 	case MTRRIOC_GET_PAGE_ENTRY:
@@ -381,6 +362,9 @@ static int mtrr_open(struct inode *inode, struct file *file)
 		return -EIO;
 	if (!mtrr_if->get)
 		return -ENXIO;
+	if (!capable(CAP_SYS_ADMIN))
+		return -EPERM;
+
 	return single_open(file, mtrr_seq_show, NULL);
 }
 


Thoughts?

-Kees

> 
> ---
> From: Zhang Xiaoxu <zhangxiaoxu5@huawei.com>
> Date: Tue, 5 Nov 2019 15:17:14 +0800
> Subject: [PATCH] x86/mtrr: Restrict MTRR ranges dumping and ioctl()
> 
> /proc/mtrr dumps the physical memory ranges of the variable range MTRRs
> along with their respective sizes and caching attributes. Since that
> file is world-readable, it presents a small information leak about the
> physical address ranges of a system which should be blocked.
> 
> Make that file root-only and get rid of all the capability checks as
> they're not needed anymore.
> 
>  [ bp: rewrite commit message. ]
> 
> Suggested-by: Kees Cook <keescook@chromium.org>
> Signed-off-by: Zhang Xiaoxu <zhangxiaoxu5@huawei.com>
> Signed-off-by: Borislav Petkov <bp@suse.de>
> Cc: "H. Peter Anvin" <hpa@zytor.com>
> Cc: Colin Ian King <colin.king@canonical.com>
> Cc: Ingo Molnar <mingo@redhat.com>
> Cc: Thomas Gleixner <tglx@linutronix.de>
> Cc: Tyler Hicks <tyhicks@canonical.com>
> Cc: x86-ml <x86@kernel.org>
> Cc: zhangxiaoxu@huawei.com
> Link: https://lkml.kernel.org/r/20191105071714.27376-1-zhangxiaoxu5@huawei.com
> ---
>  arch/x86/kernel/cpu/mtrr/if.c | 18 +-----------------
>  1 file changed, 1 insertion(+), 17 deletions(-)
> 
> diff --git a/arch/x86/kernel/cpu/mtrr/if.c b/arch/x86/kernel/cpu/mtrr/if.c
> index 4d36dcc1cf87..7ff865f2b150 100644
> --- a/arch/x86/kernel/cpu/mtrr/if.c
> +++ b/arch/x86/kernel/cpu/mtrr/if.c
> @@ -226,8 +226,6 @@ mtrr_ioctl(struct file *file, unsigned int cmd, unsigned long __arg)
>  #ifdef CONFIG_COMPAT
>  	case MTRRIOC32_ADD_ENTRY:
>  #endif
> -		if (!capable(CAP_SYS_ADMIN))
> -			return -EPERM;
>  		err =
>  		    mtrr_file_add(sentry.base, sentry.size, sentry.type, true,
>  				  file, 0);
> @@ -236,24 +234,18 @@ mtrr_ioctl(struct file *file, unsigned int cmd, unsigned long __arg)
>  #ifdef CONFIG_COMPAT
>  	case MTRRIOC32_SET_ENTRY:
>  #endif
> -		if (!capable(CAP_SYS_ADMIN))
> -			return -EPERM;
>  		err = mtrr_add(sentry.base, sentry.size, sentry.type, false);
>  		break;
>  	case MTRRIOC_DEL_ENTRY:
>  #ifdef CONFIG_COMPAT
>  	case MTRRIOC32_DEL_ENTRY:
>  #endif
> -		if (!capable(CAP_SYS_ADMIN))
> -			return -EPERM;
>  		err = mtrr_file_del(sentry.base, sentry.size, file, 0);
>  		break;
>  	case MTRRIOC_KILL_ENTRY:
>  #ifdef CONFIG_COMPAT
>  	case MTRRIOC32_KILL_ENTRY:
>  #endif
> -		if (!capable(CAP_SYS_ADMIN))
> -			return -EPERM;
>  		err = mtrr_del(-1, sentry.base, sentry.size);
>  		break;
>  	case MTRRIOC_GET_ENTRY:
> @@ -279,8 +271,6 @@ mtrr_ioctl(struct file *file, unsigned int cmd, unsigned long __arg)
>  #ifdef CONFIG_COMPAT
>  	case MTRRIOC32_ADD_PAGE_ENTRY:
>  #endif
> -		if (!capable(CAP_SYS_ADMIN))
> -			return -EPERM;
>  		err =
>  		    mtrr_file_add(sentry.base, sentry.size, sentry.type, true,
>  				  file, 1);
> @@ -289,8 +279,6 @@ mtrr_ioctl(struct file *file, unsigned int cmd, unsigned long __arg)
>  #ifdef CONFIG_COMPAT
>  	case MTRRIOC32_SET_PAGE_ENTRY:
>  #endif
> -		if (!capable(CAP_SYS_ADMIN))
> -			return -EPERM;
>  		err =
>  		    mtrr_add_page(sentry.base, sentry.size, sentry.type, false);
>  		break;
> @@ -298,16 +286,12 @@ mtrr_ioctl(struct file *file, unsigned int cmd, unsigned long __arg)
>  #ifdef CONFIG_COMPAT
>  	case MTRRIOC32_DEL_PAGE_ENTRY:
>  #endif
> -		if (!capable(CAP_SYS_ADMIN))
> -			return -EPERM;
>  		err = mtrr_file_del(sentry.base, sentry.size, file, 1);
>  		break;
>  	case MTRRIOC_KILL_PAGE_ENTRY:
>  #ifdef CONFIG_COMPAT
>  	case MTRRIOC32_KILL_PAGE_ENTRY:
>  #endif
> -		if (!capable(CAP_SYS_ADMIN))
> -			return -EPERM;
>  		err = mtrr_del_page(-1, sentry.base, sentry.size);
>  		break;
>  	case MTRRIOC_GET_PAGE_ENTRY:
> @@ -436,7 +420,7 @@ static int __init mtrr_if_init(void)
>  	    (!cpu_has(c, X86_FEATURE_CENTAUR_MCR)))
>  		return -ENODEV;
>  
> -	proc_create("mtrr", S_IWUSR | S_IRUGO, NULL, &mtrr_fops);
> +	proc_create("mtrr", 0600, NULL, &mtrr_fops);
>  	return 0;
>  }
>  arch_initcall(mtrr_if_init);
> -- 
> 2.21.0
> 
> -- 
> Regards/Gruss,
>     Boris.
> 
> https://people.kernel.org/tglx/notes-about-netiquette

-- 
Kees Cook
