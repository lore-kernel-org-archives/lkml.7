Return-Path: <SRS0=s1fu=UU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0580FC43613
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Jun 2019 09:04:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CC71320673
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Jun 2019 09:04:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=ffwll.ch header.i=@ffwll.ch header.b="hXCUBy0v"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726452AbfFUJEW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Jun 2019 05:04:22 -0400
Received: from mail-ed1-f67.google.com ([209.85.208.67]:41475 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726270AbfFUJEV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Jun 2019 05:04:21 -0400
Received: by mail-ed1-f67.google.com with SMTP id p15so9004325eds.8
        for <linux-kernel@vger.kernel.org>; Fri, 21 Jun 2019 02:04:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=sender:date:from:to:cc:subject:message-id:mail-followup-to
         :references:mime-version:content-disposition
         :content-transfer-encoding:in-reply-to:user-agent;
        bh=U2b/yBDUn2uxWh84cUIQKg+GqhT7DNRX+9D0eV4BYx0=;
        b=hXCUBy0vJZx/iaLqA18XGnONO5xU0CBUctQ9kVsR+JlFuzMPmjyatmNwL7y3Je4J3B
         NZd7KNNLq0qD0brieEut21alVmiz2awz3K38YaDoe6x/nbnhz/mkhTOAn9nogfGlixvA
         DAvioi8fkMHMxT1Eh9fLjg3ytJibj/3a/mwK4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :content-transfer-encoding:in-reply-to:user-agent;
        bh=U2b/yBDUn2uxWh84cUIQKg+GqhT7DNRX+9D0eV4BYx0=;
        b=eKVMZVb5A5KzjLgMk0n/83rra6oN/2ZHcPuurdw0lqNchD5sI+FvFXnUzliwnUHXCI
         XFb6TUgTFbSpvoLr/u2Rfj3rB09JvAFtZCYLlp1hTuyvOsYOdhXtnf5mRCITDkrD0N2O
         KwsyX7FRAlSsM8p0XXzkgYoQnAGPKLTLgVvjFENh01qcwyTysmdvidqtbOpB314HheCc
         PUU3uZ0pFlXLWv9+8anJLoGbyOdnh6TBYEtPImAO5f4U8JH8afpvOlWq298PW8jJH6hh
         6uoxUOCs+r2qg2bbYx4UkEVaUHVlLVZqGY5uDGZj4RDo3XR7yL9eZUs+7/fc2RWAssGr
         T29Q==
X-Gm-Message-State: APjAAAXDhIoFcSRVvkN6yPSpveWzpOWuuU/iE+Bsrge4KioeX3kC9V6R
        Ylno3iIVxcT63bI3UXjaxApbnQ==
X-Google-Smtp-Source: APXvYqzqBoWvjvXM4lrIaSCxZfX9YLrVK1oWpzeuauWLMJPPlPE+IUOZ9YVWpg82mA+3sRhl0+KeQA==
X-Received: by 2002:a17:906:6c19:: with SMTP id j25mr45383796ejr.21.1561107859109;
        Fri, 21 Jun 2019 02:04:19 -0700 (PDT)
Received: from phenom.ffwll.local ([2a02:168:569e:0:3106:d637:d723:e855])
        by smtp.gmail.com with ESMTPSA id j30sm654087edb.8.2019.06.21.02.04.17
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Fri, 21 Jun 2019 02:04:18 -0700 (PDT)
Date:   Fri, 21 Jun 2019 11:04:11 +0200
From:   Daniel Vetter <daniel@ffwll.ch>
To:     Paul Cercueil <paul@crapouillou.net>
Cc:     Sam Ravnborg <sam@ravnborg.org>, David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Sean Paul <sean@poorly.run>, od@zcrc.me,
        dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Artur Rojek <contact@artur-rojek.eu>
Subject: Re: [PATCH v5 2/2] DRM: Add KMS driver for the Ingenic JZ47xx SoCs
Message-ID: <20190621090411.GY12905@phenom.ffwll.local>
Mail-Followup-To: Paul Cercueil <paul@crapouillou.net>,
        Sam Ravnborg <sam@ravnborg.org>, David Airlie <airlied@linux.ie>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Sean Paul <sean@poorly.run>, od@zcrc.me,
        dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Artur Rojek <contact@artur-rojek.eu>
References: <20190603152331.23160-1-paul@crapouillou.net>
 <20190603152331.23160-2-paul@crapouillou.net>
 <20190619122622.GB29084@ravnborg.org>
 <1561040159.1978.0@crapouillou.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1561040159.1978.0@crapouillou.net>
X-Operating-System: Linux phenom 4.19.0-5-amd64 
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 20, 2019 at 04:15:59PM +0200, Paul Cercueil wrote:
> 
> 
> Le mer. 19 juin 2019 à 14:26, Sam Ravnborg <sam@ravnborg.org> a écrit :
> > Hi Paul.
> > 
> > On Mon, Jun 03, 2019 at 05:23:31PM +0200, Paul Cercueil wrote:
> > >  Add a KMS driver for the Ingenic JZ47xx family of SoCs.
> > >  This driver is meant to replace the aging jz4740-fb driver.
> > > 
> > >  This driver does not make use of the simple pipe helper, for the
> > > reason
> > >  that it will soon be updated to support more advanced features like
> > >  multiple planes, IPU integration for colorspace conversion and
> > > up/down
> > >  scaling, support for DSI displays, and TV-out and HDMI outputs.
> > > 
> > >  Signed-off-by: Paul Cercueil <paul@crapouillou.net>
> > >  Tested-by: Artur Rojek <contact@artur-rojek.eu>
> > >  ---
> > > 
> > >  Notes:
> > >      v2: - Remove custom handling of panel. The panel is now
> > > discovered using
> > >      	  the standard API.
> > >      	- Lots of small tweaks suggested by upstream
> > > 
> > >      v3: - Use devm_drm_dev_init()
> > >      	- Update compatible strings to -lcd instead of -drm
> > >      	- Add destroy() callbacks to plane and crtc
> > >      	- The ingenic,lcd-mode is now read from the bridge's DT node
> > > 
> > >      v4: Remove ingenic,lcd-mode property completely. The various
> > > modes are now
> > >      	deduced from the connector type, the pixel format or the bus
> > > flags.
> > > 
> > >      v5: - Fix framebuffer size incorrectly calculated for 24bpp
> > > framebuffers
> > >      	- Use 32bpp framebuffer instead of 16bpp, as it'll work with
> > > both
> > >      	  16-bit and 24-bit panel
> > >      	- Get rid of drm_format_plane_cpp() which has been dropped
> > > upstream
> > >      	- Avoid using drm_format_info->depth, which is deprecated.
> > In the drm world we include the revision notes in the changelog.
> > So I did this when I applied it to drm-misc-next.
> > 
> > Fixed a few trivial checkpatch warnings about indent too.
> > There was a few too-long-lines warnings that I ignored. Fixing them
> > would have hurt readability.
> 
> Thanks.
> 
> > I assume you will maintain this driver onwards from now.
> > Please request drm-misc commit rights (see
> > https://www.freedesktop.org/wiki/AccountRequests/)
> > You will need a legacy SSH account.
> 
> I requested an account here:
> https://gitlab.freedesktop.org/freedesktop/freedesktop/issues/162

This 404s for me. Did you set the issue to private by any chance? Or
deleted already again?
-Daniel

> 
> > And you should familiarize yourself with the maintainer-tools:
> > https://drm.pages.freedesktop.org/maintainer-tools/index.html
> > 
> > For my use I use "dim update-branches; dim apply; dim push
> > So only a small subset i needed for simple use.
> > 
> > 	Sam
> 
> 

-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
