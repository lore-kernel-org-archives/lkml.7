Return-Path: <SRS0=yQuH=Z3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 62C77C2D0BF
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Dec 2019 22:15:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3697B20659
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Dec 2019 22:15:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ffwll.ch header.i=@ffwll.ch header.b="i3jTCa8y"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729951AbfLEWP2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 5 Dec 2019 17:15:28 -0500
Received: from mail-wr1-f65.google.com ([209.85.221.65]:37148 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729240AbfLEWP2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Dec 2019 17:15:28 -0500
Received: by mail-wr1-f65.google.com with SMTP id w15so5594928wru.4
        for <linux-kernel@vger.kernel.org>; Thu, 05 Dec 2019 14:15:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=date:from:to:cc:subject:message-id:mail-followup-to:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=T74LspN/Sim+aWkc3QHBB9fwPjBZNd60Uk/Nv28Du/s=;
        b=i3jTCa8yIkbx58G3q/lJhtF3uXRMcCBgX05lrNWCZ17Wzwy1NodjGtRuyLoT4LMqKj
         k/GElPm4yaYnYMETcCdJLQArY2ISn53cMG2CyfS5HiU4a1vxFkeL8yg6b8juEIuv+rPG
         r8HQyM2HJvKduKGqrFcHTYWdMDIVchw7pgoNE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :in-reply-to:user-agent;
        bh=T74LspN/Sim+aWkc3QHBB9fwPjBZNd60Uk/Nv28Du/s=;
        b=N48mcIJgTYEa2ztTSA4B8BBRhr2EcZ2PH8VDtCwyF4+c2RuOfKLyQmQv+HTQ3tXIkm
         EwdDAx0NzAjco+W3F9grNEqqVPtMsEE4tRSiVGfgNGwwmsBn2KrDnZFDogshO/m3DVzw
         1/vJTTfZ5NWf/Bmyu/MBeMoU/TDqvJg/Ap9kGIqvcSmak8cl3yuuOEIJiJ6QWEsyWZj4
         nYmCtIrAamoorHi3s4cLQD+5Or1qifHw3dTnY1TrxdCPKKrjsJEeiJq5+0CK9hx12IxQ
         SAyZfIInEbvxPbW+cvV9LhV9YM41cZPedMJRkLBxwqODnpzmJsDNYROkp5FYok1HSb2i
         eYnA==
X-Gm-Message-State: APjAAAUJHtAUm2mLTOKR/jC4nfLscoyhZJn4i1zSLO7vbAIhq94/06Nm
        3HI3qc4V1PkAk8S0CrZmoL3KyA==
X-Google-Smtp-Source: APXvYqz2KJmQcVZo2r5BWhzFvwZPfcySceP+bjA7xkG8teU2GR/4Qey+iWFI3/WNGKhPpgOSz0qn9A==
X-Received: by 2002:a5d:6703:: with SMTP id o3mr12955371wru.235.1575584126055;
        Thu, 05 Dec 2019 14:15:26 -0800 (PST)
Received: from phenom.ffwll.local (212-51-149-96.fiber7.init7.net. [212.51.149.96])
        by smtp.gmail.com with ESMTPSA id t8sm13854615wrp.69.2019.12.05.14.15.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Dec 2019 14:15:25 -0800 (PST)
Date:   Thu, 5 Dec 2019 23:15:23 +0100
From:   Daniel Vetter <daniel@ffwll.ch>
To:     Gerd Hoffmann <kraxel@redhat.com>
Cc:     dri-devel@lists.freedesktop.org, robh@kernel.org,
        intel-gfx@lists.freedesktop.org,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Christian Koenig <christian.koenig@amd.com>,
        Huang Rui <ray.huang@amd.com>,
        open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v3 1/2] drm: call drm_gem_object_funcs.mmap with fake
 offset
Message-ID: <20191205221523.GN624164@phenom.ffwll.local>
Mail-Followup-To: Gerd Hoffmann <kraxel@redhat.com>,
        dri-devel@lists.freedesktop.org, robh@kernel.org,
        intel-gfx@lists.freedesktop.org,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>, David Airlie <airlied@linux.ie>,
        Christian Koenig <christian.koenig@amd.com>,
        Huang Rui <ray.huang@amd.com>,
        open list <linux-kernel@vger.kernel.org>
References: <20191127092523.5620-1-kraxel@redhat.com>
 <20191127092523.5620-2-kraxel@redhat.com>
 <20191128113930.yhckvneecpvfhlls@sirius.home.kraxel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191128113930.yhckvneecpvfhlls@sirius.home.kraxel.org>
X-Operating-System: Linux phenom 5.3.0-2-amd64 
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 28, 2019 at 12:39:30PM +0100, Gerd Hoffmann wrote:
> On Wed, Nov 27, 2019 at 10:25:22AM +0100, Gerd Hoffmann wrote:
> > The fake offset is going to stay, so change the calling convention for
> > drm_gem_object_funcs.mmap to include the fake offset.  Update all users
> > accordingly.
> > 
> > Note that this reverts 83b8a6f242ea ("drm/gem: Fix mmap fake offset
> > handling for drm_gem_object_funcs.mmap") and on top then adds the fake
> > offset to  drm_gem_prime_mmap to make sure all paths leading to
> > obj->funcs->mmap are consistent.
> > 
> > v3: move fake-offset tweak in drm_gem_prime_mmap() so we have this code
> >     only once in the function (Rob Herring).
> 
> Now this series fails in Intel CI.  Can't see why though.  The
> difference between v2 and v3 is just the place where vma->vm_pgoff gets
> updated, and no code between the v2 and v3 location touches vma ...

Looks like unrelated flukes, this happens occasionally. If you're paranoid
hit the retest button on patchwork to double-check.
-Daniel
-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
