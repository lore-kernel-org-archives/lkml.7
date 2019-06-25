Return-Path: <SRS0=/s9R=UY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 520C1C48BD5
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Jun 2019 14:08:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 24CD7208E3
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Jun 2019 14:08:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=ffwll.ch header.i=@ffwll.ch header.b="DlsNVgfR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728738AbfFYOIB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Jun 2019 10:08:01 -0400
Received: from mail-ed1-f66.google.com ([209.85.208.66]:34017 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727807AbfFYOIA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jun 2019 10:08:00 -0400
Received: by mail-ed1-f66.google.com with SMTP id s49so27399313edb.1
        for <linux-kernel@vger.kernel.org>; Tue, 25 Jun 2019 07:07:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=sender:date:from:to:cc:subject:message-id:mail-followup-to
         :references:mime-version:content-disposition
         :content-transfer-encoding:in-reply-to:user-agent;
        bh=CAtg3PLJ+XKSV8dAF2QLAFWrkpUis1quRM8X3SddO/c=;
        b=DlsNVgfRWTP8NpGGrX9t3Nbz1zo7ltZhwtKOk/Es+ZdbHwht+lr3TCIe70hcYOlrBR
         ABPEEparLAqoeRRvZ5Pzq1cEVMTiKJ3tiqSO4M7ZzKp6aqKBOmxw686MYovwaEFXhy8l
         NK+f1Jf6pSuG3cXFg7wdY+FYcdimxOYB8sVXQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :content-transfer-encoding:in-reply-to:user-agent;
        bh=CAtg3PLJ+XKSV8dAF2QLAFWrkpUis1quRM8X3SddO/c=;
        b=lkPpjKtioO7WS6HhRJnMr6zwQ6fUIct6hASneSRMbWWhMsGe93sK0mWpY2vqzqR6eX
         WDtu3MrKGwZtpu1Z/HBWqNyWP0etqt3hpFN6L0fSoORC8cROGE8iQXsqOQRR1AKlLQzd
         PTfNcpXUu6LzMJMy+YqDG69Y2xkMFCsp8+XvaY9osM2uG+UAte723tivk0Neo1If8pbD
         Way7aS7SWzWs1s8eTQzzgzicjvZLwBSxlAlfegFR6KCDtDxSDkHvuOJL6wkI+xhRUNvH
         aao4KaaDvhXa8N/KBOj/1MrJP2Ke1g/i33ihxB9orvZj6dGMTMAdf/y7EF5aISkeDGzy
         kS/A==
X-Gm-Message-State: APjAAAV4lmPxxoKg2ZsaBlxbwQXX0uBNGdkJWyxbl0Hb2/n5GqLG6oMW
        a8veBIqci7VMmYjXQzxJYu6ntA==
X-Google-Smtp-Source: APXvYqwnUNvO8RCgD+CoeE0AtlUeuwzv5wVl2MiDkEcmAY2cVmivLFNLtUKUMk2lZa5wxlyqXHk8gw==
X-Received: by 2002:a50:92e1:: with SMTP id l30mr77999218eda.141.1561471678547;
        Tue, 25 Jun 2019 07:07:58 -0700 (PDT)
Received: from phenom.ffwll.local ([2a02:168:569e:0:3106:d637:d723:e855])
        by smtp.gmail.com with ESMTPSA id w17sm4594091edi.15.2019.06.25.07.07.56
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Tue, 25 Jun 2019 07:07:57 -0700 (PDT)
Date:   Tue, 25 Jun 2019 16:07:55 +0200
From:   Daniel Vetter <daniel@ffwll.ch>
To:     Emil Velikov <emil.velikov@collabora.com>
Cc:     Andrzej Pietrasiewicz <andrzej.p@collabora.com>,
        Russell King - ARM Linux admin <linux@armlinux.org.uk>,
        linux-samsung-soc@vger.kernel.org,
        Joonyoung Shim <jy0922.shim@samsung.com>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Seung-Woo Kim <sw0312.kim@samsung.com>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        linux-kernel@vger.kernel.org,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Inki Dae <inki.dae@samsung.com>,
        David Airlie <airlied@linux.ie>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        Kukjin Kim <kgene@kernel.org>, dri-devel@lists.freedesktop.org,
        Daniel Vetter <daniel@ffwll.ch>, kernel@collabora.com,
        Sean Paul <sean@poorly.run>,
        linux-arm-kernel@lists.infradead.org, m.szyprowski@samsung.com
Subject: Re: [PATCH 0/2] Associate ddc adapters with connectors
Message-ID: <20190625140755.GT12905@phenom.ffwll.local>
Mail-Followup-To: Emil Velikov <emil.velikov@collabora.com>,
        Andrzej Pietrasiewicz <andrzej.p@collabora.com>,
        Russell King - ARM Linux admin <linux@armlinux.org.uk>,
        linux-samsung-soc@vger.kernel.org,
        Joonyoung Shim <jy0922.shim@samsung.com>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Seung-Woo Kim <sw0312.kim@samsung.com>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        linux-kernel@vger.kernel.org, Krzysztof Kozlowski <krzk@kernel.org>,
        Inki Dae <inki.dae@samsung.com>, David Airlie <airlied@linux.ie>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        Kukjin Kim <kgene@kernel.org>, dri-devel@lists.freedesktop.org,
        kernel@collabora.com, Sean Paul <sean@poorly.run>,
        linux-arm-kernel@lists.infradead.org, m.szyprowski@samsung.com
References: <cover.1561452052.git.andrzej.p@collabora.com>
 <20190625100351.52ddptvb2gizaepi@shell.armlinux.org.uk>
 <817ccfba-754c-6a28-8d75-63f70605fd43@collabora.com>
 <20190625133639.GA16031@arch-x1c3>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190625133639.GA16031@arch-x1c3>
X-Operating-System: Linux phenom 4.19.0-5-amd64 
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 25, 2019 at 02:36:39PM +0100, Emil Velikov wrote:
> On 2019/06/25, Andrzej Pietrasiewicz wrote:
> > Hi Russell,
> > 
> > W dniu 25.06.2019 o 12:03, Russell King - ARM Linux admin pisze:
> > > On Tue, Jun 25, 2019 at 11:46:34AM +0200, Andrzej Pietrasiewicz wrote:
> > > > It is difficult for a user to know which of the i2c adapters is for which
> > > > drm connector. This series addresses this problem.
> > > > 
> > > > The idea is to have a symbolic link in connector's sysfs directory, e.g.:
> > > > 
> > > > ls -l /sys/class/drm/card0-HDMI-A-1/i2c-2
> > > > lrwxrwxrwx 1 root root 0 Jun 24 10:42 /sys/class/drm/card0-HDMI-A-1/i2c-2 \
> > > > 	-> ../../../../soc/13880000.i2c/i2c-2
> > > 
> > > Don't you want the symlink name to be "i2c" or something fixed, rather
> > > than the name of the i2c adapter?  Otherwise, you seem to be encumbering
> > > userspace with searching the directory to try and find the symlink.
> > > 
> > 
> > Thank you for your comment. So you imagine something on the lines of:
> > 
> > lrwxrwxrwx 1 root root 0 Jun 24 10:42 /sys/class/drm/card0-HDMI-A-1/ddc \
> >  	-> ../../../../soc/13880000.i2c/i2c-2
> > 
> > ?
> > 
> Fwiw my Intel machine lists a number of i2c devices:
> /sys/class/drm/card0-DP-1/i2c-6
> /sys/class/drm/card0-DP-2/i2c-7
> /sys/class/drm/card0-eDP-1/i2c-5
> 
> Note: I haven't looked _if_ they relate to ones you're proposing here.
> 
> One thing worth mentioning is, the ones I've seen are not symlinks to
> another sysfs entries. And there aren't any i2c nodes in /dev ...
> 
> Just a random food for thought :-)

Those are the i2c-over-dp-aux controllers. I think we want to list these
too.

Btw to make this more useful maybe some default implementations for
get_modes which automatically dtrt, as a helper? Probably could use that
to squash quite a bit of boilerplate.

Otherwise I like this. Biggest problem I'm seeing here is rolling this out
everywhere, this is a lot of work. And without widespread adoptions it's
not terribly useful for userspace.
-Daniel
-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
