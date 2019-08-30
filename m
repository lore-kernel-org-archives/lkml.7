Return-Path: <SRS0=2mSC=W2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8CFE5C3A5A3
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Aug 2019 05:37:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 57FB221721
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Aug 2019 05:37:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="f068KEHK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728053AbfH3Fhs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 30 Aug 2019 01:37:48 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:43530 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725901AbfH3Fhs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Aug 2019 01:37:48 -0400
Received: by mail-pg1-f195.google.com with SMTP id k3so2923294pgb.10
        for <linux-kernel@vger.kernel.org>; Thu, 29 Aug 2019 22:37:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=sp7WZRh5Zo5Fej4/VNU3JhRkFGxR83nxyxhtJZ+moKU=;
        b=f068KEHKykPF8mVxNPe0fEWuAaNHnMTwQTB/AztpcEOdjTmwkrLbXhyNi5rJEkKAxQ
         25VybaBq+z8GNuWIzQPljaldjXE28jWaaak5xGuyCXrt5CdgVs2AOZ8NzLgXPcQ7RI4q
         SAFoeY0dTJf67QWvQzTub6/7m2xlgoR6KYh/E=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=sp7WZRh5Zo5Fej4/VNU3JhRkFGxR83nxyxhtJZ+moKU=;
        b=dwaPWfcjAwEEjousWXlFXKmsq0V/V8j2zOXIFpeGtFfsWDmnzJR+F8VsRjPQGx6RaQ
         dDpBYFQUTeWXYVUHmPAev+uU4hjPBexRqiJIVbSCEXjvrEU4pmSQ91mbAg1AOpRyeDTr
         y0i2HBILDTBe0fM5t7kN2bkp6cZHYCRchkABv5YMXcWrgYQKVGss63aMOCIUuGJyLb3G
         4PvmlNIO37oDRnkv1gd54YyRIsep2qZ1DsafINrHQWCHfsRuvh8ra5YsKT1KCKRMn5yy
         XtLmE6nTQD6M7ZLwVWV4UfRt2a8hRNLr943VGrRDxUr3jjOQ9AhZX/5S8z7L+pDS2c1p
         AXgQ==
X-Gm-Message-State: APjAAAXumzVTKd1f3OmTImwEYbqBJep/KwAxrvRTJ5VT0Z0VxpuskcMP
        9neOb+eeCd690Yyyuexy4b7vWg==
X-Google-Smtp-Source: APXvYqzlY8l9gKksKuKQdeHPWVnn0IRNqRXiSh8zwQZpJPWR0lu9m9JimGhYo1Qs8IS6xpRATF5soA==
X-Received: by 2002:a17:90a:fe0c:: with SMTP id ck12mr14150494pjb.74.1567143467395;
        Thu, 29 Aug 2019 22:37:47 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id z68sm3868522pgz.88.2019.08.29.22.37.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Aug 2019 22:37:46 -0700 (PDT)
Date:   Thu, 29 Aug 2019 22:37:45 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Dave Martin <Dave.Martin@arm.com>
Cc:     linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
        Thomas Gleixner <tglx@linutronix.de>,
        Jann Horn <jannh@google.com>, "H.J. Lu" <hjl.tools@gmail.com>,
        Eugene Syromiatnikov <esyr@redhat.com>,
        Florian Weimer <fweimer@redhat.com>,
        Yu-cheng Yu <yu-cheng.yu@intel.com>,
        Peter Zijlstra <peterz@infradead.org>
Subject: Re: [RFC PATCH v2 2/2] ELF: Add ELF program property parsing support
Message-ID: <201908292224.007EB4D5@keescook>
References: <1566581020-9953-1-git-send-email-Dave.Martin@arm.com>
 <1566581020-9953-3-git-send-email-Dave.Martin@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1566581020-9953-3-git-send-email-Dave.Martin@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 23, 2019 at 06:23:40PM +0100, Dave Martin wrote:
> ELF program properties will needed for detecting whether to enable
> optional architecture or ABI features for a new ELF process.
> 
> For now, there are no generic properties that we care about, so do
> nothing unless CONFIG_ARCH_USE_GNU_PROPERTY=y.
> 
> Otherwise, the presence of properties using the PT_PROGRAM_PROPERTY
> phdrs entry (if any), and notify each property to the arch code.
> 
> For now, the added code is not used.
> 
> Signed-off-by: Dave Martin <Dave.Martin@arm.com>

Reviewed-by: Kees Cook <keescook@chromium.org>

Note below...

> [...]
> +static int parse_elf_property(const char *data, size_t *off, size_t datasz,
> +			      struct arch_elf_state *arch,
> +			      bool have_prev_type, u32 *prev_type)
> +{
> +	size_t size, step;
> +	const struct gnu_property *pr;
> +	int ret;
> +
> +	if (*off == datasz)
> +		return -ENOENT;
> +
> +	if (WARN_ON(*off > datasz || *off % elf_gnu_property_align))
> +		return -EIO;
> +
> +	size = datasz - *off;
> +	if (size < sizeof(*pr))
> +		return -EIO;
> +
> +	pr = (const struct gnu_property *)(data + *off);
> +	if (pr->pr_datasz > size - sizeof(*pr))
> +		return -EIO;
> +
> +	step = round_up(sizeof(*pr) + pr->pr_datasz, elf_gnu_property_align);
> +	if (step > size)
> +		return -EIO;
> +
> +	/* Properties are supposed to be unique and sorted on pr_type: */
> +	if (have_prev_type && pr->pr_type <= *prev_type)
> +		return -EIO;
> +	*prev_type = pr->pr_type;
> +
> +	ret = arch_parse_elf_property(pr->pr_type,
> +				      data + *off + sizeof(*pr),
> +				      pr->pr_datasz, ELF_COMPAT, arch);

I find it slightly hard to read the "cursor" motion in this parse. It
feels strange, for example, to refer twice to "data + *off" with the
second including consumed *pr size. Everything is fine AFAICT in the math,
though, and I haven't been able to construct a convincingly "cleaner"
version. Maybe:

	data += *off;
	pr = (const struct gnu_property *)data;
	data += sizeof(*pr);
	...
	ret = arch_parse_elf_property(pr->pr_type, data,
				      pr->pr_datasz, ELF_COMPAT, arch);

But that feels disjoint from the "step" calculation, so... I think what
you have is fine. :)

-- 
Kees Cook
