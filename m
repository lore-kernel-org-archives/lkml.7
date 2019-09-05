Return-Path: <SRS0=AnJR=XA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_2 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A96ACC43331
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Sep 2019 14:41:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CF50C205ED
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Sep 2019 14:41:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lca.pw header.i=@lca.pw header.b="qW7gVcDz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730469AbfIEOlC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 5 Sep 2019 10:41:02 -0400
Received: from mail-qk1-f193.google.com ([209.85.222.193]:43204 "EHLO
        mail-qk1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726179AbfIEOlC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Sep 2019 10:41:02 -0400
Received: by mail-qk1-f193.google.com with SMTP id m2so2305315qkd.10
        for <linux-kernel@vger.kernel.org>; Thu, 05 Sep 2019 07:41:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lca.pw; s=google;
        h=message-id:subject:from:to:cc:date:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=RwHVDa1GJi8ayjzjkgzkLTLLpxPbUkF92tRTyGxKp8E=;
        b=qW7gVcDzND0lYEahwAo1BqDAlHLaPYyKi+juRuxEk8puYQtfS+Az/JTNxleGT5JOjh
         MUyftEBA8SZN5lFGaF80LXJ8ExVfw3bUWGZgk/0CNI7hquPgcyc0Z433Z+H9EhW+jG1i
         0P1nzrcuzqbqxB9BOy0FUPYjPpOpsjEkaEtC/+DTJg4ooZZTzrgPNtrj+cD2zC/jw2LR
         keQ+N/No0VKSJ7PKB+C6wSR82Ffmo5B7syJJBD6R6GvW1LyOX+IeJTQGBms+0pPwAMAI
         RFyMgaq1iZppL7q7WXfHaQ/CW+w7bQPH8RuVMvrRQuZ4+SKye+twacYsL3BVp73xz7RD
         VQOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=RwHVDa1GJi8ayjzjkgzkLTLLpxPbUkF92tRTyGxKp8E=;
        b=PrGmW1ngnuVx8B3A8VqNSuqLGkFP97QavtLDxYMaxn/xnkcyBZHhUUjIigCG3oezgG
         nou2/b8+TclVjCeesE88/z2vmqFh+NRmBwAQ5pVm1dyubE9f1opdg7qO7/PxMywy99Ms
         kA2JwJH7uL47i1gVaOF4gW0Vo6d7Oadg/toHiLBXeuK1ZIvEgEeNbZjA2FR7uMJ8TfCJ
         jAZLs0e9dfrhYvlg4wuux/N53bkwtofWRljb/j6Ik6F6QAN4Ee0tfqgcDDHK+PMHSqko
         l/qUlmGofckqKzp6fwMvQ4pTxyuOaux6SUkD48Lk8QxvuGluwOxTLVr0AdjgDlAAAXof
         EK5w==
X-Gm-Message-State: APjAAAVCPZ3pad0gzakaW/V1752Zt2ngxTvSwKhAey7NnfZQyJiwB+4/
        hSRaPWs6DEATMRbQE4Vpl2QNng==
X-Google-Smtp-Source: APXvYqxrtgPstnzHgyJSHuCxcpq5WtjXy9rbKx4EcN+tuoaOvYFpINd6tpp3e7sRgqvGI8ZvUhn+VQ==
X-Received: by 2002:a37:a695:: with SMTP id p143mr3314043qke.144.1567694461221;
        Thu, 05 Sep 2019 07:41:01 -0700 (PDT)
Received: from dhcp-41-57.bos.redhat.com (nat-pool-bos-t.redhat.com. [66.187.233.206])
        by smtp.gmail.com with ESMTPSA id x2sm1030038qkf.83.2019.09.05.07.40.59
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 05 Sep 2019 07:41:00 -0700 (PDT)
Message-ID: <1567694459.5576.94.camel@lca.pw>
Subject: Re: [PATCH] gpu/drm: fix a -Wstringop-truncation warning
From:   Qian Cai <cai@lca.pw>
To:     daniel@ffwll.ch
Cc:     maarten.lankhorst@linux.intel.com, maxime.ripard@bootlin.com,
        sean@poorly.run, airlied@linux.ie, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
Date:   Thu, 05 Sep 2019 10:40:59 -0400
In-Reply-To: <1566585426-2952-1-git-send-email-cai@lca.pw>
References: <1566585426-2952-1-git-send-email-cai@lca.pw>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.22.6 (3.22.6-10.el7) 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Ping. Please take a look at this trivial patch.

On Fri, 2019-08-23 at 14:37 -0400, Qian Cai wrote:
> In file included from ./include/linux/bitmap.h:9,
>                  from ./include/linux/cpumask.h:12,
>                  from ./arch/x86/include/asm/cpumask.h:5,
>                  from ./arch/x86/include/asm/msr.h:11,
>                  from ./arch/x86/include/asm/processor.h:21,
>                  from ./arch/x86/include/asm/cpufeature.h:5,
>                  from ./arch/x86/include/asm/thread_info.h:53,
>                  from ./include/linux/thread_info.h:38,
>                  from ./arch/x86/include/asm/preempt.h:7,
>                  from ./include/linux/preempt.h:78,
>                  from ./include/linux/rcupdate.h:27,
>                  from ./include/linux/rculist.h:11,
>                  from ./include/linux/pid.h:5,
>                  from ./include/linux/sched.h:14,
>                  from ./include/linux/uaccess.h:5,
>                  from drivers/gpu/drm/drm_property.c:24:
> In function 'strncpy',
>     inlined from 'drm_property_create' at
> drivers/gpu/drm/drm_property.c:130:2:
> ./include/linux/string.h:305:9: warning: '__builtin_strncpy' specified
> bound 32 equals destination size [-Wstringop-truncation]
>   return __builtin_strncpy(p, q, size);
>          ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> 
> Fix it by using strscpy() which will always return a valid string, and
> doesn't unnecessarily force the tail of the destination buffer to be
> zeroed.
> 
> Signed-off-by: Qian Cai <cai@lca.pw>
> ---
>  drivers/gpu/drm/drm_property.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/drivers/gpu/drm/drm_property.c b/drivers/gpu/drm/drm_property.c
> index 892ce636ef72..66ec2cc7a559 100644
> --- a/drivers/gpu/drm/drm_property.c
> +++ b/drivers/gpu/drm/drm_property.c
> @@ -127,8 +127,7 @@ struct drm_property *drm_property_create(struct drm_device
> *dev,
>  	property->num_values = num_values;
>  	INIT_LIST_HEAD(&property->enum_list);
>  
> -	strncpy(property->name, name, DRM_PROP_NAME_LEN);
> -	property->name[DRM_PROP_NAME_LEN-1] = '\0';
> +	strscpy(property->name, name, DRM_PROP_NAME_LEN);
>  
>  	list_add_tail(&property->head, &dev->mode_config.property_list);
>  
