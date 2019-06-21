Return-Path: <SRS0=s1fu=UU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2FC36C43613
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Jun 2019 16:07:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F08AF206B7
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Jun 2019 16:07:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lca.pw header.i=@lca.pw header.b="Gbh3Safw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726178AbfFUQHq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Jun 2019 12:07:46 -0400
Received: from mail-qt1-f196.google.com ([209.85.160.196]:45910 "EHLO
        mail-qt1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726010AbfFUQHq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Jun 2019 12:07:46 -0400
Received: by mail-qt1-f196.google.com with SMTP id j19so7416084qtr.12
        for <linux-kernel@vger.kernel.org>; Fri, 21 Jun 2019 09:07:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lca.pw; s=google;
        h=message-id:subject:from:to:cc:date:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=eD/BLnKc8aB7UFd7f2A4xEVukUQnrHfUaMjiWMGt5Bg=;
        b=Gbh3SafwOA2wOlQr064vPlr/uvl9hy55TuWzCf2mFi/owd+3k5RBD59Qgv3Iokxoky
         3saHokgDnzuHj0moTX+hbPMJCZJSIc2ePrGLoPbQeknba69GkmLsVBGL+Z95ssUj+0Bv
         ZA6h4d1Sj9sbPBSVOkQi3ZGlAZpWCKNmTXCX4hYXVzOv2EkuL6UOUo7Wnmrt0OnlchmX
         503QU3CfhMDCkCarEYg7h0q/NlbymD32YHS/a8WhD2ntb4Fc5ilgUkJHFfb/9R/6q38o
         dQNJK/WO59rKJ/4HAtNHshurZfPETmDHfC4Y9y6tMkywCxmf8GtOq8V3gYPwlW3xbzAT
         vz/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=eD/BLnKc8aB7UFd7f2A4xEVukUQnrHfUaMjiWMGt5Bg=;
        b=dXKdvI+MKRzrQWfhDWc5fGSkfN4rHhGcSiLnmOgFSd0I2nu8GiZJthxquL5pq9n1Hp
         QGFnLMvnP6YuAwodPwfRkIvlEWbLsul5Hd9/v0xNO6zYhuAFsGI3BxfCGyKgc86wJ6UQ
         eTF9uZefFXxImZt8YQua0F0X9i6pNpyygM+n60/tXe41iy647GC+cNmw9xfdgsuE1LTE
         YjTbeTPX1iFvg4PdbQl0bXzMq4YERnf8Z4qJ1TyDWFutBHB5oiZW3hWaR5/M4tPJwqEC
         oqiK28QOlprDgY3DGbN3CeHmXahV0Zxzx99parM7qZH1B3Ky/F3jpywcpPZCtiNbpoMU
         EwDg==
X-Gm-Message-State: APjAAAWHiS4Jwh+WQ04ayZQglMdsjoc5CEEk70YG+pA3x950Kd2r0K+x
        I25okLA7N8V18O1C5Ft+oBC1ZO24dAoj+g==
X-Google-Smtp-Source: APXvYqyN8obOgngjM1ze5NBpVwYlwPdgcCOGgC8RmHjBdQO3Jon9GXoaxA61odDCrTlCWZj2t2drbA==
X-Received: by 2002:ac8:1b8b:: with SMTP id z11mr16637125qtj.265.1561133265377;
        Fri, 21 Jun 2019 09:07:45 -0700 (PDT)
Received: from dhcp-41-57.bos.redhat.com (nat-pool-bos-t.redhat.com. [66.187.233.206])
        by smtp.gmail.com with ESMTPSA id u126sm1448570qkf.132.2019.06.21.09.07.44
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 21 Jun 2019 09:07:44 -0700 (PDT)
Message-ID: <1561133263.5154.50.camel@lca.pw>
Subject: Re: [RESEND PATCH] gpu/drm_memory: fix a few warnings
From:   Qian Cai <cai@lca.pw>
To:     akpm@linux-foundation.org
Cc:     airlied@linux.ie, daniel@ffwll.ch,
        maarten.lankhorst@linux.intel.com, sean@poorly.run,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        Jonathan Corbet <corbet@lwn.net>
Date:   Fri, 21 Jun 2019 12:07:43 -0400
In-Reply-To: <1559934035-3330-1-git-send-email-cai@lca.pw>
References: <1559934035-3330-1-git-send-email-cai@lca.pw>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.22.6 (3.22.6-10.el7) 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Ping.

On Fri, 2019-06-07 at 15:00 -0400, Qian Cai wrote:
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
> Signed-off-by: Qian Cai <cai@lca.pw>
> ---
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
