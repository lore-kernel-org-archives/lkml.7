Return-Path: <SRS0=h0iA=UR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 545B7C31E51
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Jun 2019 11:09:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 28A9C2085A
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Jun 2019 11:09:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=ffwll.ch header.i=@ffwll.ch header.b="jpinsjW0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729625AbfFRLJZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Jun 2019 07:09:25 -0400
Received: from mail-ed1-f67.google.com ([209.85.208.67]:34729 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729458AbfFRLJZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Jun 2019 07:09:25 -0400
Received: by mail-ed1-f67.google.com with SMTP id s49so21185070edb.1
        for <linux-kernel@vger.kernel.org>; Tue, 18 Jun 2019 04:09:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=sender:date:from:to:cc:subject:message-id:mail-followup-to
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=Uk40UhexmdEkWRPW8aWJEctkTMOanHrquMubXf3T9Dw=;
        b=jpinsjW0qcygBTIUeWTLASX3k+7oqGLP4M9Q+dpKl8sjJMw6G0cFj4V6ZjdHwPYk/P
         xWsD5MxoYxor/OVbE21kjxVSQGCBA539AxgenHOoaKCnxKKaDBqomzJXTlhQlJLtXz8Y
         tJmEA9ANcXu+8KVckS5IWixebtK/KxxX3oxmE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :in-reply-to:user-agent;
        bh=Uk40UhexmdEkWRPW8aWJEctkTMOanHrquMubXf3T9Dw=;
        b=Drx+wJ4mz7lB0NuWfVO540DEpZqOLVz/dCMQIjSfLhDxfOh6uLeK5MHkBzKyzOP0C8
         RaifmxunqrPG4rpn+zS5/VsO2GDElQ4Gmjt/1+IcpkSj0VfFoUqDv3sqeT/gL2w+uZ30
         EDYD5RoIoRC2V1343ciP6oJ67x9SJhEl6Vde+I7nLrvdzDUsaib0VQLe+mnNvVr1dCnC
         2raQfKP0rI/a16aT/WXpAkMBl0x2LzTNR3MM6osIydz6tiQk0zs+ECQs+soiSYudiyOm
         8HlparPCH2/BwLG+4xzqE1NPpr0ExffkpdZjNT1sypL5AlqdGEVC6NXxj8V22Dh6kVoc
         4PHg==
X-Gm-Message-State: APjAAAXlkv2LgeP0mdsgxzcGkRulwURgrPJ0Oc8JJEIm22/NhpamP/Ky
        K3S46X5yGHaukqL/ltloIGyPSaQWvgM=
X-Google-Smtp-Source: APXvYqxDAdIWhEhz4so6nZF5fEOV/XaepK/UWiijVodzL7WD5Tp5cQOXhr6kUBRkeMz38o7msif/xQ==
X-Received: by 2002:a50:8825:: with SMTP id b34mr46675030edb.22.1560856163828;
        Tue, 18 Jun 2019 04:09:23 -0700 (PDT)
Received: from phenom.ffwll.local ([2a02:168:569e:0:3106:d637:d723:e855])
        by smtp.gmail.com with ESMTPSA id t15sm2157524ejj.25.2019.06.18.04.09.22
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Tue, 18 Jun 2019 04:09:23 -0700 (PDT)
Date:   Tue, 18 Jun 2019 13:09:20 +0200
From:   Daniel Vetter <daniel@ffwll.ch>
To:     Simon Ser <contact@emersion.fr>
Cc:     Rodrigo Siqueira <rodrigosiqueiramelo@gmail.com>,
        Brian Starkey <brian.starkey@arm.com>,
        Liviu Dudau <liviu.dudau@arm.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Haneen Mohammed <hamohammed.sa@gmail.com>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH V2 4/5] drm/vkms: Use index instead of 0 in possible crtc
Message-ID: <20190618110920.GT12905@phenom.ffwll.local>
Mail-Followup-To: Simon Ser <contact@emersion.fr>,
        Rodrigo Siqueira <rodrigosiqueiramelo@gmail.com>,
        Brian Starkey <brian.starkey@arm.com>,
        Liviu Dudau <liviu.dudau@arm.com>,
        Haneen Mohammed <hamohammed.sa@gmail.com>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <cover.1560820888.git.rodrigosiqueiramelo@gmail.com>
 <971da2ede86d11357e6822409bef23cb03869f83.1560820888.git.rodrigosiqueiramelo@gmail.com>
 <innWfwO1f7V6XAA8IXBBqGMw-4_upKRtjsPG8kg19Pl9b2Hf3Bd4V20Ow7GWhfzNUmij1uVwMuHbOp3zGderuXZGhunI0y_-khuFTOStOkI=@emersion.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <innWfwO1f7V6XAA8IXBBqGMw-4_upKRtjsPG8kg19Pl9b2Hf3Bd4V20Ow7GWhfzNUmij1uVwMuHbOp3zGderuXZGhunI0y_-khuFTOStOkI=@emersion.fr>
X-Operating-System: Linux phenom 4.19.0-5-amd64 
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 18, 2019 at 07:56:23AM +0000, Simon Ser wrote:
> Interestingly, even with the previous code, possible_crtcs=1 was
> exposed to userspace [1]. I think this is because of a safeguard in
> drm_crtc_init_with_planes (drm_crtc.c:284) which sets the primary and
> cursor plane's possible_crtcs to the first CRTC if zero.
> 
> If we want to warn on possible_crtcs=0, we should probably remove this
> safeguard. Checking first whether this safeguard is used by any driver
> is probably a good idea.
> 
> [1]: https://drmdb.emersion.fr/devices/f218d1242714

Yeaht it's a bit a mess, that's why I've suggested we should bite this
bullet and fix it for real. There's a bunch others such bitmasks that many
drivers seem to not set correctly.
-Daniel
-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
