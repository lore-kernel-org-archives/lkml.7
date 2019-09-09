Return-Path: <SRS0=hqT0=XE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_2 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22C3BC4740A
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Sep 2019 13:10:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DF25220863
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Sep 2019 13:10:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lca.pw header.i=@lca.pw header.b="P5hAXo++"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404794AbfIINKt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Sep 2019 09:10:49 -0400
Received: from mail-qt1-f194.google.com ([209.85.160.194]:39551 "EHLO
        mail-qt1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729797AbfIINKs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Sep 2019 09:10:48 -0400
Received: by mail-qt1-f194.google.com with SMTP id n7so16043863qtb.6
        for <linux-kernel@vger.kernel.org>; Mon, 09 Sep 2019 06:10:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lca.pw; s=google;
        h=message-id:subject:from:to:cc:date:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=yb8yHMlIFzUkKzSOPMN5jEAOXNsGpVU598NQKlQa4ts=;
        b=P5hAXo++ypAfAtew5+1QXfKaaCuEfWtlcqjklyahBjKtJYDA9BHSkopx2fQKs7jjQm
         jJhojpO4Bel6OQyrtzYn6gRfJpuzk/ut/s/rA6aPVIOqjrRffvFWwRc63qeDOtmRGL86
         mVJvWpxVLhCwVhJIPdghYlFxjUtNV3KSMeZR5ZybBYMRyierASAEKsOMy1dKFKOznXRl
         tX9U6GgVuzkKa+p26HN/GTgJqC87p6qPJjNImTALbubQx2SMCy0h/thm1GTgSkmd3kxb
         7flWSXq0k3xY7geeU82pAdhIjCx/q5qWxjx9ADE0M5yv9tzpag42jxntnsPtMshztbrW
         W3Lw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=yb8yHMlIFzUkKzSOPMN5jEAOXNsGpVU598NQKlQa4ts=;
        b=EZ71XLXOcWuhIskqTFPWtZJ8mKoowK7tse8a593SKJ3Cv7xFM7MU1T15gU8ZylcOW8
         JJAmIYWgHOr5srnIalpr3xyzD7xMYSpt+BCsEwGK1URCfr9VEqKondAj2RUbBZ5KKYaT
         AtACu5/PiTieIVdNbJLLWltWhnXdUMs5n1W998G+992WXdIJbgF3uFq6OFY/fFv+JFhZ
         ULyd495jnQXxtgdc0DRsIq1qQ0HXTNUH1bCgsZlb6tFoCRj65GbLxuKSdbsHNgdRRbN9
         v/94l5zKBP/dCABJhKajP7C29OMnAAhBmDLdn/Y3BJpmUNCFrUMCjvG+hk7KD9hAqazi
         lheA==
X-Gm-Message-State: APjAAAVkTON3w7GP28e1eTxBzwmEjz3SMOkQK14e+N0W4jjSp3t5PZ79
        YpcSaj/eeaP5CBT7FszL7r5Bkg==
X-Google-Smtp-Source: APXvYqwTTE3hZvWnnnr+k3gCNcwlLvkUkshYg2WStKBEtFgMNikRNuBCNT/p6a2XZniIiz+lmVBFHQ==
X-Received: by 2002:ac8:4884:: with SMTP id i4mr21622436qtq.33.1568034647373;
        Mon, 09 Sep 2019 06:10:47 -0700 (PDT)
Received: from dhcp-41-57.bos.redhat.com (nat-pool-bos-t.redhat.com. [66.187.233.206])
        by smtp.gmail.com with ESMTPSA id x68sm6545372qkc.16.2019.09.09.06.10.45
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 09 Sep 2019 06:10:46 -0700 (PDT)
Message-ID: <1568034644.5576.116.camel@lca.pw>
Subject: Re: [PATCH] gpu/drm: fix a -Wstringop-truncation warning
From:   Qian Cai <cai@lca.pw>
To:     Emil Velikov <emil.l.velikov@gmail.com>, daniel@ffwll.ch
Cc:     maarten.lankhorst@linux.intel.com, maxime.ripard@bootlin.com,
        sean@poorly.run, airlied@linux.ie, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
Date:   Mon, 09 Sep 2019 09:10:44 -0400
In-Reply-To: <1566585426-2952-1-git-send-email-cai@lca.pw>
References: <1566585426-2952-1-git-send-email-cai@lca.pw>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.22.6 (3.22.6-10.el7) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Emil, this seems has been stalled again from DRM maintainers. Just to see if you
have some "magic" to unsilence it like the last time...

On Fri, 2019-08-23 at 14:37 -0400, Qian Cai wrote:
> In file included from ./include/linux/bitmap.h:9,
>                  from ./include/linux/cpumask.h:12,
>                  from ./arch/x86/include/asm/cpumask.h:5,
>                  from ./arch/x86/include/asm/msr.h:11,
>                  from ./arch/x86/include/asm/processor.h:21,
>                  from ./arch/x86/include/asm/cpufeature.h:5,
>                  from ./arch/x86/include/asm/thread_info.h:53,
>                  from ./include/linux/thread_info.h:38,
>                  from ./arch/x86/include/asm/preempt.h:7,
>                  from ./include/linux/preempt.h:78,
>                  from ./include/linux/rcupdate.h:27,
>                  from ./include/linux/rculist.h:11,
>                  from ./include/linux/pid.h:5,
>                  from ./include/linux/sched.h:14,
>                  from ./include/linux/uaccess.h:5,
>                  from drivers/gpu/drm/drm_property.c:24:
> In function 'strncpy',
>     inlined from 'drm_property_create' at
> drivers/gpu/drm/drm_property.c:130:2:
> ./include/linux/string.h:305:9: warning: '__builtin_strncpy' specified
> bound 32 equals destination size [-Wstringop-truncation]
>   return __builtin_strncpy(p, q, size);
>          ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> 
> Fix it by using strscpy() which will always return a valid string, and
> doesn't unnecessarily force the tail of the destination buffer to be
> zeroed.
> 
> Signed-off-by: Qian Cai <cai@lca.pw>
> ---
>  drivers/gpu/drm/drm_property.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/drivers/gpu/drm/drm_property.c b/drivers/gpu/drm/drm_property.c
> index 892ce636ef72..66ec2cc7a559 100644
> --- a/drivers/gpu/drm/drm_property.c
> +++ b/drivers/gpu/drm/drm_property.c
> @@ -127,8 +127,7 @@ struct drm_property *drm_property_create(struct drm_device *dev,
>  	property->num_values = num_values;
>  	INIT_LIST_HEAD(&property->enum_list);
>  
> -	strncpy(property->name, name, DRM_PROP_NAME_LEN);
> -	property->name[DRM_PROP_NAME_LEN-1] = '\0';
> +	strscpy(property->name, name, DRM_PROP_NAME_LEN);
>  
>  	list_add_tail(&property->head, &dev->mode_config.property_list);
>  
