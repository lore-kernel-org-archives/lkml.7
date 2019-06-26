Return-Path: <SRS0=hRvo=UZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 19FCAC48BD3
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Jun 2019 14:28:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E5F432133F
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Jun 2019 14:28:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=ffwll.ch header.i=@ffwll.ch header.b="QEOzXwN4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728120AbfFZO2W (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Jun 2019 10:28:22 -0400
Received: from mail-ed1-f66.google.com ([209.85.208.66]:33933 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727481AbfFZO2U (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jun 2019 10:28:20 -0400
Received: by mail-ed1-f66.google.com with SMTP id s49so3693926edb.1
        for <linux-kernel@vger.kernel.org>; Wed, 26 Jun 2019 07:28:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=sender:date:from:to:cc:subject:message-id:mail-followup-to
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=RDzxId5d0cWk+Og3KjWmTmUc93/gQfEJUMFySwZomG0=;
        b=QEOzXwN4cDsvAl3fnj/WI0Yyq8XoY5VQ/1ZZo0YTXcPQaz7t7hzaRKCaRnRHIHiPGt
         zp3wPqP1RRIVvxImSiDl6NhJBgMjgo496X0ZA+o/q+gwPvwhoP6USmJAkOZsWfB7DEqS
         y2jLjM7JyZMFztMCPpCoUhWNkkAoVfNtxTL34=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :in-reply-to:user-agent;
        bh=RDzxId5d0cWk+Og3KjWmTmUc93/gQfEJUMFySwZomG0=;
        b=oyMRs+OP1ZCJPgpoW41hDc2+kVjLUoqroBXusSGsrKlWpuoSg47LvMo5war3ObEPnZ
         Q1w26wbiVSZ+/5HABRiReCr2MLW/WzZ16OogT9uxea65TcqWEjO7Fb2gmXFLV1Sj5sdZ
         GdX+XeeQWVTywIgdsbHj3olQ8NgqjhuDNru3RC2IbPTSr/6fO4W3AAOLLehkQsxvcHDS
         BbE3XDmeHaOJBE3AmCBm7C35ts3fCQMaYddvPJzmLhAd278g6mcUfDTYOubWx1f3/Kyt
         un9jRvdnTPjBeTX5CltBTo/hI9uHPU4Z+pxNFGk4EP1rfJZClVWcT+xcEma0/ld1V67i
         qRxg==
X-Gm-Message-State: APjAAAXY4akgeSXkq9hg3SvOODYbc6uUWYg+y3gKlh/6XcGw8sgX8bKS
        FUYXuF/nn/+gWrFeALE3nvJmyA==
X-Google-Smtp-Source: APXvYqyHvtMQ1Lf+heBq8BjwPrx2FB7C/LXB6Iy0Y7C76qtBhDrUXHnqzdv+4phmpNRAYv0YzOY5Cw==
X-Received: by 2002:aa7:c619:: with SMTP id h25mr5603958edq.295.1561559298723;
        Wed, 26 Jun 2019 07:28:18 -0700 (PDT)
Received: from phenom.ffwll.local ([2a02:168:569e:0:3106:d637:d723:e855])
        by smtp.gmail.com with ESMTPSA id a8sm5564492edt.56.2019.06.26.07.28.17
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Wed, 26 Jun 2019 07:28:17 -0700 (PDT)
Date:   Wed, 26 Jun 2019 16:28:15 +0200
From:   Daniel Vetter <daniel@ffwll.ch>
To:     Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
Cc:     Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        Mauro Carvalho Chehab <mchehab@infradead.org>,
        linux-kernel@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Sean Paul <sean@poorly.run>, dri-devel@lists.freedesktop.org
Subject: Re: [PATCH] docs: gpu: add msm-crash-dump.rst to the index.rst file
Message-ID: <20190626142815.GM12905@phenom.ffwll.local>
Mail-Followup-To: Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        Mauro Carvalho Chehab <mchehab@infradead.org>,
        linux-kernel@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>,
        David Airlie <airlied@linux.ie>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Sean Paul <sean@poorly.run>, dri-devel@lists.freedesktop.org
References: <e22a340cf94240094cfb38f8c62f6916ea99394a.1561556169.git.mchehab+samsung@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e22a340cf94240094cfb38f8c62f6916ea99394a.1561556169.git.mchehab+samsung@kernel.org>
X-Operating-System: Linux phenom 4.19.0-5-amd64 
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 26, 2019 at 10:36:11AM -0300, Mauro Carvalho Chehab wrote:
> This file is currently orphaned.
> 
> Signed-off-by: Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
> ---
>  Documentation/gpu/index.rst | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/Documentation/gpu/index.rst b/Documentation/gpu/index.rst
> index 1fcf8e851e15..55f3f4294686 100644
> --- a/Documentation/gpu/index.rst
> +++ b/Documentation/gpu/index.rst
> @@ -12,6 +12,7 @@ Linux GPU Driver Developer's Guide
>     drm-uapi
>     drm-client
>     drivers
> +   msm-crash-dump

Should be added to drivers.rst I think, since it's driver-specific
documentation.
-Daniel

>     vga-switcheroo
>     vgaarbiter
>     todo
> -- 
> 2.21.0
> 

-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
