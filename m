Return-Path: <SRS0=V+Ds=VJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_2
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0DCCCC742D7
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Jul 2019 19:45:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D8929205C9
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Jul 2019 19:45:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lca.pw header.i=@lca.pw header.b="fhr+GTL3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727947AbfGLTpj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 12 Jul 2019 15:45:39 -0400
Received: from mail-qt1-f193.google.com ([209.85.160.193]:46766 "EHLO
        mail-qt1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727398AbfGLTpj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Jul 2019 15:45:39 -0400
Received: by mail-qt1-f193.google.com with SMTP id h21so9303884qtn.13
        for <linux-kernel@vger.kernel.org>; Fri, 12 Jul 2019 12:45:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lca.pw; s=google;
        h=message-id:subject:from:to:cc:date:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=uf/ZSZSXNd4QAZJyCg9locUkKYy9cCURVXWZqnNb+h4=;
        b=fhr+GTL3qGOQfXrQWWqFVWvBS4bwFKmPchUELi37X6j/u6YTtA0VkzzeqDoZZszWqa
         VXWINnyqoH0rOyQ4OceOnDmfciKFiu3M/kVpu97MapdVfPuEwD6QrMBo1eGSif45N2p5
         nTPRsJfraqQEZY4MRADP/nBCm8ck1ggciFJ7baFsm1mMUullBwllZt4EV8UMWrGmO3sZ
         dgQZsLBHFW0Se34Ur4qvoqig5bJ+ZfgTzNdzIBRScOwCYs/2KKW/QwHyutFKIRepSCDQ
         Lg6if/6uZOKfEHqCJcAGz5VJRWBTkUfu5NgT6+eEk50GvkdYlbzdZY6ZMKy/DzYS08LV
         zIEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=uf/ZSZSXNd4QAZJyCg9locUkKYy9cCURVXWZqnNb+h4=;
        b=ZTjHtm7l7S0ZpzUoFeI8bS3BYByi/qsMoKn+wvbvY32g/TbrC7IBJznaWrHJdHJZvT
         1CGu4Yrs5WHLLsRD8zeW/hEK6z98PG4ksh6k7QM/OvhC5tAo1boRT2xe6pBGC3YObtCw
         oYxASHEzNkeQNNDVxJuphtwz/U5NXsbmJWyAuGTLfdRBoadYBhLMFVG49vdd/B2XPQMP
         6siDh9PMaetIOQmfxL8C+hAIIgkB9tMf529gUNsWaQY8xCyrv7iTHT8XtMN/h0cdZ4Wf
         eQsQWGV40vK3MMv/ijQWxw2q3v0pA5GI0YnGRLmISia+CX4FRixcNU/3L4fy/ktSHg4w
         LIwQ==
X-Gm-Message-State: APjAAAW30Bpi3XlyhMDq0+c+DNJs+nXNu84NS1/Ed0DvH+/RP0MGdmXL
        eEo9IgWXcW7JBDlatvTuo48xtw==
X-Google-Smtp-Source: APXvYqzMEaiAFj63ZnaAYInlBZ2BCAScvRQzSk+eXQOGYKkHSBlgvbtnyLl0nyVIBFU9VX92RFcaWQ==
X-Received: by 2002:a0c:e588:: with SMTP id t8mr8269608qvm.179.1562960738336;
        Fri, 12 Jul 2019 12:45:38 -0700 (PDT)
Received: from dhcp-41-57.bos.redhat.com (nat-pool-bos-t.redhat.com. [66.187.233.206])
        by smtp.gmail.com with ESMTPSA id r14sm4632949qke.47.2019.07.12.12.45.36
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 12 Jul 2019 12:45:37 -0700 (PDT)
Message-ID: <1562960735.8510.30.camel@lca.pw>
Subject: Re: [PATCH v3] gpu/drm_memory: fix a few warnings
From:   Qian Cai <cai@lca.pw>
To:     akpm@linux-foundation.org
Cc:     imirkin@alum.mit.edu, airlied@linux.ie, daniel@ffwll.ch,
        maarten.lankhorst@linux.intel.com, sean@poorly.run,
        joe@perches.com, rfontana@redhat.com, tglx@linutronix.de,
        torvalds@linux-foundation.org, corbet@lwn.net,
        gregkh@linuxfoundation.org, linux-spdx@archiver.kernel.org,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Date:   Fri, 12 Jul 2019 15:45:35 -0400
In-Reply-To: <1562685190-1353-1-git-send-email-cai@lca.pw>
References: <1562685190-1353-1-git-send-email-cai@lca.pw>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.22.6 (3.22.6-10.el7) 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Maybe one of the non-DRM maintainers (Andrew, Thomas or Greg) who cares a bit
about SPDX can pick this up. It occurs to me none of DRM maintainers cares about
this as there is no feedback from any of them for months since v1.

On Tue, 2019-07-09 at 11:13 -0400, Qian Cai wrote:
> The opening comment mark "/**" is reserved for kernel-doc comments, so
> it will generate a warning with "make W=1".
> 
> drivers/gpu/drm/drm_memory.c:2: warning: Cannot understand  * \file
> drm_memory.c
> 
> Also, silence a checkpatch warning by adding a license identfiter where
> it indicates the MIT license further down in the source file.
> 
> WARNING: Missing or malformed SPDX-License-Identifier tag in line 1
> 
> Fix it by adding the MIT SPDX identifier without touching the boilerplate
> language.
> 
> Suggested-by: Thomas Gleixner <tglx@linutronix.de>
> Signed-off-by: Qian Cai <cai@lca.pw>
> ---
> 
> v3: Keep the boilerplate language.
> v2: Remove the redundant description of the license.
> 
>  drivers/gpu/drm/drm_memory.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/drm_memory.c b/drivers/gpu/drm/drm_memory.c
> index 132fef8ff1b6..683042c8ee2c 100644
> --- a/drivers/gpu/drm/drm_memory.c
> +++ b/drivers/gpu/drm/drm_memory.c
> @@ -1,4 +1,5 @@
> -/**
> +// SPDX-License-Identifier: MIT
> +/*
>   * \file drm_memory.c
>   * Memory management wrappers for DRM
>   *
