Return-Path: <SRS0=/Haq=WD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CDAD3C433FF
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Aug 2019 21:08:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9D0E8217D7
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Aug 2019 21:08:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=ffwll.ch header.i=@ffwll.ch header.b="jhH9sYqX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388777AbfHGVI6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 7 Aug 2019 17:08:58 -0400
Received: from mail-ed1-f67.google.com ([209.85.208.67]:46620 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729938AbfHGVI6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Aug 2019 17:08:58 -0400
Received: by mail-ed1-f67.google.com with SMTP id z51so417654edz.13
        for <linux-kernel@vger.kernel.org>; Wed, 07 Aug 2019 14:08:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=sender:date:from:to:cc:subject:message-id:mail-followup-to
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=WpTDnBLeqBpcYNuMO5Xr6VDSfxDLcJKI+RhmNC+qR/Y=;
        b=jhH9sYqXSIeaEgzW9lYzfUAsV3IrDrnPPFjc71xyUEl4quoeszK4MgSZc9aBaWgQDf
         8ghApR686Up9F3+XSDUzxuVAJEdDHE9NGNsNn+Tgx4sP02ojcRfTBLA2jsKD19FSaZCB
         wQRB+UgitG9AcZUeXsclkykHoGQhX2PDe0cIw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :in-reply-to:user-agent;
        bh=WpTDnBLeqBpcYNuMO5Xr6VDSfxDLcJKI+RhmNC+qR/Y=;
        b=KEwqpbpsHRiH1WFfd0/8ao5b/3i/zPeXxhnfloz7KuBZYg7THx33prj5jM+MwAmH6F
         EWiACdP6aCR8uY6rEljLeF3ZKSuRtQwEZkikQM/1NpgXRd7HWmOXaZFT4G0lIcjY7dTu
         iwOyT7KBf2Hp7PLHJ0UsrYeJStrYXHB3rT3/znfDhUjH2RK2bABCXsS/7+SW5Y2g7FPJ
         oplqQVBCT2K2RmM9RyCI2I5ZndSw9QDsR8To0b7Hh6eKtZ8N95s6MDdQs0NQosLd/TiK
         kocnyvMe42xApNsLmbffp7vOvePm9Z0Tt4JExTBuy1+ltU5GbSf1dt208T9rOLDvY9Hp
         2jew==
X-Gm-Message-State: APjAAAXsz7W4pxJsk2ov3XdZhcl62QvbyZ4D7PZmmzXmfsaZF7769l0u
        nnrkM94LnLF6nD71ieiMGvciMw==
X-Google-Smtp-Source: APXvYqwYhHrKa/ZKokZeoyh60e4i9idWNZLhHZkuYpLqSrcSTTyodDnby+NikOVHFnxDt+H4l3KAlA==
X-Received: by 2002:a50:c94b:: with SMTP id p11mr12117139edh.301.1565212136312;
        Wed, 07 Aug 2019 14:08:56 -0700 (PDT)
Received: from phenom.ffwll.local ([2a02:168:569e:0:3106:d637:d723:e855])
        by smtp.gmail.com with ESMTPSA id z24sm29268edc.65.2019.08.07.14.08.54
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Wed, 07 Aug 2019 14:08:55 -0700 (PDT)
Date:   Wed, 7 Aug 2019 23:08:53 +0200
From:   Daniel Vetter <daniel@ffwll.ch>
To:     Gerd Hoffmann <kraxel@redhat.com>
Cc:     Daniel Vetter <daniel@ffwll.ch>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Sean Paul <sean@poorly.run>, David Airlie <airlied@linux.ie>,
        open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 1/3] drm: add gem ttm helpers
Message-ID: <20190807210853.GH7444@phenom.ffwll.local>
Mail-Followup-To: Gerd Hoffmann <kraxel@redhat.com>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Sean Paul <sean@poorly.run>, David Airlie <airlied@linux.ie>,
        open list <linux-kernel@vger.kernel.org>
References: <20190806133454.8254-1-kraxel@redhat.com>
 <20190806133454.8254-2-kraxel@redhat.com>
 <20190806135426.GA7444@phenom.ffwll.local>
 <20190807072654.arqvx37p4yxhegcu@sirius.home.kraxel.org>
 <CAKMK7uFyKd71w4H8nFk=WPSHL3KMwQ6kLwAMXTd_TAkrkJ++KQ@mail.gmail.com>
 <20190807103649.aedmac63eop6ktlk@sirius.home.kraxel.org>
 <CAKMK7uHNXjSsuUTkxzVbeDNP4ESFBObHZe6xxJYEHE1-QyKqhQ@mail.gmail.com>
 <20190807115133.gkr2svqlvq366mub@sirius.home.kraxel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190807115133.gkr2svqlvq366mub@sirius.home.kraxel.org>
X-Operating-System: Linux phenom 4.19.0-5-amd64 
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 07, 2019 at 01:51:33PM +0200, Gerd Hoffmann wrote:
>   Hi,
> 
> > > > > I don't think so.  drm_gem_dumb_map_offset() calls
> > > > > drm_gem_create_mmap_offset(), which I think is not correct for ttm
> > > > > objects because ttm_bo_init() handles vma_node initialization.
> 
> > Ok I looked again, and your ttm version seems to exactly match
> > drm_gem_dumb_map_offset(),
> 
> No.  The difference outlined above is still there.  See also v2 which
> adds an comment saying so.

Creating an mmap offset is idempotent. Otherwise the gem version would
already blow up real bad, since it's getting called multiple times by
userspace already.

So I still think ttm isn't special here, how did this blow up when you
tried?
-Daniel
-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
