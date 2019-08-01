Return-Path: <SRS0=wo+8=V5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5E3E1C19759
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Aug 2019 19:55:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 28A1C206B8
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Aug 2019 19:55:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=brauner.io header.i=@brauner.io header.b="WvS7e7Jf"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388846AbfHATzK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 1 Aug 2019 15:55:10 -0400
Received: from mail-io1-f68.google.com ([209.85.166.68]:37537 "EHLO
        mail-io1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388765AbfHATzK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Aug 2019 15:55:10 -0400
Received: by mail-io1-f68.google.com with SMTP id q22so27269478iog.4
        for <linux-kernel@vger.kernel.org>; Thu, 01 Aug 2019 12:55:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brauner.io; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=C/Wg0Up1QmGPSRe0vxOWr7pGFC5FOuMlSyJtkWNsNbY=;
        b=WvS7e7JfM3t3rCJKBIH/aXGGblrufs/+ZRrRbUU8RG9ZZ6ZNT5eSNI8HdUPVCveWvN
         WT698zZXqrS93lE/S6NR/mH51nJYTX2+1vOZxVX5Lg8ZbBSt8azPbOlTBEX1wu/kf512
         vXKmgOIHRT5mump4RCDgPwCDiHaW9wcAs8D1nKTMXrsq3QRRB+DDUteTOXISzHEdfvgQ
         lbdlti/EaQbblcknZBc71zmsdccdDgDieNvfBY2WwkxRpsCbaYmQEkb1DYDGJjAwXXp8
         NksAFXFuFZDKTpZUYTqD5AsI46aeqU9szqJN6M7TGE8NGzwq6jwXuYHpnZu3yelivm1n
         gd/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=C/Wg0Up1QmGPSRe0vxOWr7pGFC5FOuMlSyJtkWNsNbY=;
        b=IrgsAun+bTZUDTqFssgaxe6GqS99cacPTFXFH6luoAn2foJGakkqq+G1FwyjGdwAHY
         Cn9gNw4pBTBeBsCvHnlTv/J645SZWZUYHZ1bSoQgenfmfGooe1jOQvFCfH77sxemH9Li
         PgKOpyLAez7nEXenEsdW57Z3cPz1Oq8OCeBS6OkS/td1Eil1E88mZ2tt/J5DAL7Ma3hz
         /xearkinNNgzI+whbRmE+yGMmgdNfsUw5g3W03hOR6hc2jrcKzmR4WdPqaUMTOC2qnRc
         tHbStgtzwg7bZnh85urc0ERhSa9+F771GMeCqYHIl/Om/LuOgd/O3Fjx8Pc8UBICHbGQ
         PnfQ==
X-Gm-Message-State: APjAAAWLsckBijrBOW4b7WBLTTHwX4dCiQk+8LY4yMnipiGBHPytGJ9F
        8TXgFasrMMX5NBaIusfD+x8=
X-Google-Smtp-Source: APXvYqyDnBPSbOsnf8JIP2AjQhiLAmDw6oheisFlbxtv2m8I2YEdWcIpta5HyYouQznFIS77YWLUMg==
X-Received: by 2002:a6b:6a01:: with SMTP id x1mr82889100iog.77.1564689309510;
        Thu, 01 Aug 2019 12:55:09 -0700 (PDT)
Received: from brauner.io ([162.223.5.78])
        by smtp.gmail.com with ESMTPSA id q15sm54037950ioi.15.2019.08.01.12.55.07
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Thu, 01 Aug 2019 12:55:08 -0700 (PDT)
Date:   Thu, 1 Aug 2019 21:55:06 +0200
From:   Christian Brauner <christian@brauner.io>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Clark Williams <williams@redhat.com>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Luis =?utf-8?Q?Cl=C3=A1udio_Gon=C3=A7alves?= 
        <lclaudio@redhat.com>, Patrick Bellasi <patrick.bellasi@arm.com>
Subject: Re: [PATCH 07/12] tools headers UAPI: Sync sched.h with the kernel
Message-ID: <20190801195505.jigukba5qmedxoqq@brauner.io>
References: <20190729211456.6380-1-acme@kernel.org>
 <20190729211456.6380-8-acme@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190729211456.6380-8-acme@kernel.org>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 29, 2019 at 06:14:54PM -0300, Arnaldo Carvalho de Melo wrote:
> From: Arnaldo Carvalho de Melo <acme@redhat.com>
> 
> To get the changes in:
> 
>   a509a7cd7974 ("sched/uclamp: Extend sched_setattr() to support utilization clamping")
>   1d6362fa0cfc ("sched/core: Allow sched_setattr() to use the current policy")
>   7f192e3cd316 ("fork: add clone3")
> 
> And silence this perf build warning:
> 
>   Warning: Kernel ABI header at 'tools/include/uapi/linux/sched.h' differs from latest version at 'include/uapi/linux/sched.h'
>   diff -u tools/include/uapi/linux/sched.h include/uapi/linux/sched.h
> 
> No changes in tools/ due to the above.
> 
> Cc: Adrian Hunter <adrian.hunter@intel.com>
> Cc: Christian Brauner <christian@brauner.io>
> Cc: Jiri Olsa <jolsa@kernel.org>
> Cc: Luis Cláudio Gonçalves <lclaudio@redhat.com>
> Cc: Namhyung Kim <namhyung@kernel.org>
> Cc: Patrick Bellasi <patrick.bellasi@arm.com>
> Link: https://lkml.kernel.org/n/tip-mtrpsjrux5hgyr5uf8l1aa46@git.kernel.org
> Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>

Thanks!
For the struct clone_args addition:
Acked-by: Christian Brauner <christian.brauner@ubuntu.com>

> ---
>  tools/include/uapi/linux/sched.h | 30 +++++++++++++++++++++++++++++-
>  1 file changed, 29 insertions(+), 1 deletion(-)
> 
> diff --git a/tools/include/uapi/linux/sched.h b/tools/include/uapi/linux/sched.h
> index ed4ee170bee2..b3105ac1381a 100644
> --- a/tools/include/uapi/linux/sched.h
> +++ b/tools/include/uapi/linux/sched.h
> @@ -2,6 +2,8 @@
>  #ifndef _UAPI_LINUX_SCHED_H
>  #define _UAPI_LINUX_SCHED_H
>  
> +#include <linux/types.h>
> +
>  /*
>   * cloning flags:
>   */
> @@ -31,6 +33,20 @@
>  #define CLONE_NEWNET		0x40000000	/* New network namespace */
>  #define CLONE_IO		0x80000000	/* Clone io context */
>  
> +/*
> + * Arguments for the clone3 syscall
> + */
> +struct clone_args {
> +	__aligned_u64 flags;
> +	__aligned_u64 pidfd;
> +	__aligned_u64 child_tid;
> +	__aligned_u64 parent_tid;
> +	__aligned_u64 exit_signal;
> +	__aligned_u64 stack;
> +	__aligned_u64 stack_size;
> +	__aligned_u64 tls;
> +};
> +
>  /*
>   * Scheduling policies
>   */
> @@ -51,9 +67,21 @@
>  #define SCHED_FLAG_RESET_ON_FORK	0x01
>  #define SCHED_FLAG_RECLAIM		0x02
>  #define SCHED_FLAG_DL_OVERRUN		0x04
> +#define SCHED_FLAG_KEEP_POLICY		0x08
> +#define SCHED_FLAG_KEEP_PARAMS		0x10
> +#define SCHED_FLAG_UTIL_CLAMP_MIN	0x20
> +#define SCHED_FLAG_UTIL_CLAMP_MAX	0x40
> +
> +#define SCHED_FLAG_KEEP_ALL	(SCHED_FLAG_KEEP_POLICY | \
> +				 SCHED_FLAG_KEEP_PARAMS)
> +
> +#define SCHED_FLAG_UTIL_CLAMP	(SCHED_FLAG_UTIL_CLAMP_MIN | \
> +				 SCHED_FLAG_UTIL_CLAMP_MAX)
>  
>  #define SCHED_FLAG_ALL	(SCHED_FLAG_RESET_ON_FORK	| \
>  			 SCHED_FLAG_RECLAIM		| \
> -			 SCHED_FLAG_DL_OVERRUN)
> +			 SCHED_FLAG_DL_OVERRUN		| \
> +			 SCHED_FLAG_KEEP_ALL		| \
> +			 SCHED_FLAG_UTIL_CLAMP)
>  
>  #endif /* _UAPI_LINUX_SCHED_H */
> -- 
> 2.21.0
> 
