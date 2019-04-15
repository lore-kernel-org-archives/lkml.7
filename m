Return-Path: <SRS0=rNeM=SR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 12E22C10F0E
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Apr 2019 16:09:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D2ABC20818
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Apr 2019 16:09:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=ffwll.ch header.i=@ffwll.ch header.b="V55y//jl"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728123AbfDOQJW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Apr 2019 12:09:22 -0400
Received: from mail-ed1-f68.google.com ([209.85.208.68]:40477 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727593AbfDOQJV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Apr 2019 12:09:21 -0400
Received: by mail-ed1-f68.google.com with SMTP id d46so10387270eda.7
        for <linux-kernel@vger.kernel.org>; Mon, 15 Apr 2019 09:09:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=sender:date:from:to:cc:subject:message-id:mail-followup-to
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=qQt3QLJap/yxjR8fSdHZX8NI5jqwtbyya4Msr35QE0M=;
        b=V55y//jlIRGxy1DgzHSdjGp7tZmPthvDkNKXUn9VS5Hs1sf6xA7sAgvgEQgSioqbda
         4d+5dNNwNTeRiAxBHg1Nf6TfypSIDeOWuxx/M6FLBxn9ecQyCg0PnjN5dT6re7hReb5m
         jcZ9Eip/IpDyRaTUbfpnTOt5tsx5Fj9dGG67c=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :in-reply-to:user-agent;
        bh=qQt3QLJap/yxjR8fSdHZX8NI5jqwtbyya4Msr35QE0M=;
        b=LHVy1uHOZwqqpr91Am2wt2MY0kQ6CEmFuNXwaufxCTycPN+McWcvGG9LJ0z0XzMS7M
         dHZRyR85+4izCWflh6RcI3H0/09eERRFvqNaoEhmpR+G3v4L0keC6cROBegNP6LFt0ND
         9JFGBmnY/m3kJp3Er9O2oasifDtQhd0Y5B+sVjBR/Oj69NZxeL29Bd5/BxEaswMMFb+E
         Vhypt5GryLGBLLXNQkiG9b0QfyFGfc0Sh7DFcz8g3bnuCnSSK+l9xkZBgAeG9e8y61/0
         O9QoATGu95KXXY0azqSeqAdAyqkq+zsMYJxVdXVMtDZO/d9wfflCByByKJg1X9JrYF2J
         JIcg==
X-Gm-Message-State: APjAAAU1Cz8QRxwiIZwrgG2fdf9JICcdP/XyjAIpVpU1KQs+vWmovrNJ
        +Feg3zWxTL7mr73VwcGGRPo5eg==
X-Google-Smtp-Source: APXvYqx+KrJEnS00GoDDz742y2NIBhd6OA/H+NwTEDd/vJRF9GgyZD+5TmIKEJs3Pu7XFpgUn1K6nw==
X-Received: by 2002:a50:acc6:: with SMTP id x64mr19376343edc.141.1555344560109;
        Mon, 15 Apr 2019 09:09:20 -0700 (PDT)
Received: from phenom.ffwll.local ([2a02:168:569e:0:3106:d637:d723:e855])
        by smtp.gmail.com with ESMTPSA id y41sm458910edd.96.2019.04.15.09.09.18
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 15 Apr 2019 09:09:19 -0700 (PDT)
Date:   Mon, 15 Apr 2019 18:09:17 +0200
From:   Daniel Vetter <daniel@ffwll.ch>
To:     Sam Ravnborg <sam@ravnborg.org>
Cc:     Paul Cercueil <paul@crapouillou.net>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Sean Paul <sean@poorly.run>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org
Subject: Re: [PATCH v2 3/3] DRM: Add KMS driver for the Ingenic JZ47xx SoCs
Message-ID: <20190415160917.GF2665@phenom.ffwll.local>
Mail-Followup-To: Sam Ravnborg <sam@ravnborg.org>,
        Paul Cercueil <paul@crapouillou.net>,
        David Airlie <airlied@linux.ie>, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Sean Paul <sean@poorly.run>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org
References: <20190315170701.29670-1-paul@crapouillou.net>
 <20190315170701.29670-3-paul@crapouillou.net>
 <20190316215944.GB11309@ravnborg.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190316215944.GB11309@ravnborg.org>
X-Operating-System: Linux phenom 4.19.0-1-amd64 
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Mar 16, 2019 at 10:59:44PM +0100, Sam Ravnborg wrote:
> > +	ret = drm_fbdev_generic_setup(drm, 16);
> > +	if (ret) {
> > +		dev_err(dev, "Failed to init fbdev\n");
> > +		goto err_devclk_disable;
> > +	}
> fbdev is usually considered an optionl feature that do not prevent
> the display driver from loading.
> Consider what to do in the error case.

Drive-through comment: Totally ok to require this, failing here usually
means you have a driver bug somewhere. fbdev is optional as in Kconfig
optional, but people who enable it generally need it.
-Daniel
-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
