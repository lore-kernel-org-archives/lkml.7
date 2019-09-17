Return-Path: <SRS0=bFUY=XM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0BD27C4CEC9
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Sep 2019 13:28:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D237121852
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Sep 2019 13:28:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=ffwll.ch header.i=@ffwll.ch header.b="M4iA4bP6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728303AbfIQN2g (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Sep 2019 09:28:36 -0400
Received: from mail-ed1-f66.google.com ([209.85.208.66]:41743 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727063AbfIQN2f (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Sep 2019 09:28:35 -0400
Received: by mail-ed1-f66.google.com with SMTP id f20so880405edv.8
        for <linux-kernel@vger.kernel.org>; Tue, 17 Sep 2019 06:28:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=sender:date:from:to:cc:subject:message-id:mail-followup-to
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=x6hViGClTEGUi9Ex3nINQANElPUDTXWEwnFA8ofdZpo=;
        b=M4iA4bP6kQzHF9qOiyhOOh05qxeTDc57m5lbx/Rfq6wJvYqAPFtN67Uoqw06xEQ2vt
         tu7PNtr7LKSmXPMaHSeqI3uFzUmNtb2tm85BL7hk/D5wuYSvyP3Jp+ZYIn79y3/POUzZ
         SptNxV7TNxyphW4K+gw5bs20Azj5T24F0r9cI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :in-reply-to:user-agent;
        bh=x6hViGClTEGUi9Ex3nINQANElPUDTXWEwnFA8ofdZpo=;
        b=W9B6gQaLepJgxMQTwlIwaYhRfZYu2Uc5sxtTQuWlSt5QmUBA8t4Di3yLRYMmttK3me
         A7K4R544mX3cOTLLXaTuVvJQIi4WgH33GPLP5Ztc7dEOdDBLRLw8N0iqVgCXSkqK/FJM
         griESNlKpNRo0PIcCz6GuSFAFrmmaWI4BU8JwdIdh62+GJG68XxLp+7QJjydSP/oduuB
         qvWslQsIBCB3h7aYm2EIhsoJ/l5QtBvX0c5N83mQDWdGnyZt+QwDeIYHeeJg/VyCykwG
         ELbFG9ocjK9IIYh8NCc2QHkeMw/Kv/XkGHXyV2AsIekMc0fuSojUQcYH5DIslDUhlY4+
         uaOA==
X-Gm-Message-State: APjAAAUDAE+VUtscAP0vqHOzX2wdwMtCRqIls9NJMVHcQgq6YyqoUqpq
        gfk6wtJtv0lHilTZ0faNAqH7EA==
X-Google-Smtp-Source: APXvYqyrvVIHXDa3hY45ZcpbXd34FoVb3RaZYU57yddrYt7B1TVmPRVFX27kqnE0TAkx8P1s2sT9Jw==
X-Received: by 2002:a50:f00c:: with SMTP id r12mr4688681edl.274.1568726912952;
        Tue, 17 Sep 2019 06:28:32 -0700 (PDT)
Received: from phenom.ffwll.local (212-51-149-96.fiber7.init7.net. [212.51.149.96])
        by smtp.gmail.com with ESMTPSA id j10sm438549ede.59.2019.09.17.06.28.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Sep 2019 06:28:32 -0700 (PDT)
Date:   Tue, 17 Sep 2019 15:28:30 +0200
From:   Daniel Vetter <daniel@ffwll.ch>
To:     Lyude Paul <lyude@redhat.com>
Cc:     dri-devel@lists.freedesktop.org, Daniel Vetter <daniel@ffwll.ch>,
        David Airlie <airlied@linux.ie>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        linux-kernel@vger.kernel.org, Sean Paul <sean@poorly.run>,
        Maxime Ripard <mripard@kernel.org>
Subject: Re: [PATCH 0/3] drm/encoder: Various doc fixes
Message-ID: <20190917132830.GX3958@phenom.ffwll.local>
Mail-Followup-To: Lyude Paul <lyude@redhat.com>,
        dri-devel@lists.freedesktop.org, David Airlie <airlied@linux.ie>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        linux-kernel@vger.kernel.org, Sean Paul <sean@poorly.run>,
        Maxime Ripard <mripard@kernel.org>
References: <20190913222704.8241-1-lyude@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190913222704.8241-1-lyude@redhat.com>
X-Operating-System: Linux phenom 5.2.0-2-amd64 
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 13, 2019 at 06:27:00PM -0400, Lyude Paul wrote:
> Some random issues with documentation that I noticed while working on
> nouveau the other day. There are no functional changes in this series.

Nice! On all three:

Reviewed-by: Daniel Vetter <daniel.vetter@ffwll.ch>

> 

> Lyude Paul (3):
>   drm/encoder: Fix possible_clones documentation
>   drm/encoder: Fix possible_crtcs documentation
>   drm/encoder: Don't raise voice in drm_encoder_mask() documentation
> 
>  include/drm/drm_encoder.h | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> -- 
> 2.21.0
> 

-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
