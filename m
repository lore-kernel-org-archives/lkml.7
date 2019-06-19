Return-Path: <SRS0=wAGj=US=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7A7D2C31E49
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Jun 2019 10:42:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4D2E42064A
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Jun 2019 10:42:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NyIsIIb+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731065AbfFSKmV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Jun 2019 06:42:21 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:33396 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726751AbfFSKmV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Jun 2019 06:42:21 -0400
Received: by mail-wm1-f65.google.com with SMTP id h19so4325256wme.0
        for <linux-kernel@vger.kernel.org>; Wed, 19 Jun 2019 03:42:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=TT2nK9A47FLcAVPWjohBdM0YSA12JZIvgdjlygMunHY=;
        b=NyIsIIb+uVSx90RcZzFhDtYTjpvPlbj+hShSLfVTuJIpwMvZ/ktBguPb0h4gANFzoi
         hvLO9eK3+HcdDVGQqD4g6tfj30LVmL361dA7To7DiQGi0nM1Zm1pvX7plq+6FOH7NmAr
         /O+kiyQUl0JxHCQQcIUjmJvlZIDtqcyTcqHWD7j+mEn55FSdIUa+BgKm50iEvucQFs6s
         enAOJmxl4UVjU7zLox6+cqbLZeNCNPM24D74OHDh2chnsVpkFDOlc4Nn8zllc0AlalEC
         VdJcgCpHGQZ2WOKypxHA5wiou0C8wvRHblDGY4Y9c8KsQ+vcp7r5s5pobRcx7rLVlV03
         1hZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=TT2nK9A47FLcAVPWjohBdM0YSA12JZIvgdjlygMunHY=;
        b=ECLTpIp7foOMvHfwKvmNAQUVVXtcDdSndLAnAa6E46POrsy7/pKP1CyI2uKwjZHEMc
         hhGYNabINHVi2AP+agp5B05ip+Er4hLhmIKitlYu58ASvWtkl/DM+dhfvaPbKvixGVba
         J2i+3UTLClLHp5bbjLMejqff8brH17USqRQyD6RTf7YcRrv75oy9ha1Xht7FMQ3gc1Tc
         On5xMwsAfV6nhhxbPdunMtItQKGX+Fvq0G+PmDe5p6yT2aEcj0NVs4IKHtAXjGM+4QVi
         B1bCLffgDU2uxNMlDRDBFq8mDtTH6piXXYU2EyZ5iqWwC5iH/pDfbiP1+FJpSfJKtuIb
         qxFQ==
X-Gm-Message-State: APjAAAUgGdB0t4ajtUIWoMqyvBbSbLwG8p3X4iBqKF+qgSLeZWZqpPak
        ynQYNPmD5bFgtylioJ1h6rfeBHrE
X-Google-Smtp-Source: APXvYqwZTMniWreXGV97t4naAESnNM/rCdLIobReK3BHsdELYGgUuiUhiov95Ols8kq0IrJru4hIaQ==
X-Received: by 2002:a1c:6c08:: with SMTP id h8mr8069991wmc.62.1560940939330;
        Wed, 19 Jun 2019 03:42:19 -0700 (PDT)
Received: from arch-x1c3 ([2a00:5f00:102:0:9665:9cff:feee:aa4d])
        by smtp.gmail.com with ESMTPSA id w2sm16821493wrr.31.2019.06.19.03.42.18
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Wed, 19 Jun 2019 03:42:18 -0700 (PDT)
Date:   Wed, 19 Jun 2019 11:40:14 +0100
From:   Emil Velikov <emil.l.velikov@gmail.com>
To:     Gerd Hoffmann <kraxel@redhat.com>
Cc:     dri-devel@lists.freedesktop.org, David Airlie <airlied@linux.ie>,
        "open list:VIRTIO GPU DRIVER" 
        <virtualization@lists.linux-foundation.org>,
        open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v3 11/12] drm/virtio: switch from ttm to gem shmem helpers
Message-ID: <20190619104014.GB1896@arch-x1c3>
References: <20190619090420.6667-1-kraxel@redhat.com>
 <20190619090420.6667-12-kraxel@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190619090420.6667-12-kraxel@redhat.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Gerd,

On 2019/06/19, Gerd Hoffmann wrote:

> -static void virtio_gpu_init_ttm_placement(struct virtio_gpu_object *vgbo)
> +static const struct drm_gem_object_funcs v3d_gem_funcs = {
s/v3d/virtio/g

Doubt I'll have the time for a proper review - just this and the 1/12 nits :-\

HTH
Emil
