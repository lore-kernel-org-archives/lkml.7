Return-Path: <SRS0=/s9R=UY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 42550C48BD4
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Jun 2019 14:20:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1214C208E3
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Jun 2019 14:20:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=ffwll.ch header.i=@ffwll.ch header.b="PiKb0pq4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729965AbfFYOUg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Jun 2019 10:20:36 -0400
Received: from mail-ed1-f65.google.com ([209.85.208.65]:34210 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727738AbfFYOUg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jun 2019 10:20:36 -0400
Received: by mail-ed1-f65.google.com with SMTP id s49so27463570edb.1
        for <linux-kernel@vger.kernel.org>; Tue, 25 Jun 2019 07:20:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=sender:date:from:to:cc:subject:message-id:mail-followup-to
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=G6JtZL8+U2ZkwL0/tzXXiHIEAOss9zM+ZL3Pgbc8Mpk=;
        b=PiKb0pq4SASNR7D3rZRPPn6hYPGCPxODqKLMDAnrrKgPg9InzXFNxhgfcjJ0osnNob
         vyTtVKNuYim6MRswZ9WjaRBlsW8RMJPiwWKoyq3uAyYbDouZ9ZJClJkEADyVHPrEnO5E
         2dv49ZPpK3sQqXzRaWmoTu0NM4VYZANoTUsRE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :in-reply-to:user-agent;
        bh=G6JtZL8+U2ZkwL0/tzXXiHIEAOss9zM+ZL3Pgbc8Mpk=;
        b=sOtLslIlVcnKC5o/DCC+axGvFhBBh6nZwyIE3DG8KmHMqOB87RqQf0jhrcVaTZFWsx
         1arOirM/GpSS/4quWEAo62LIlpQLV3gFmKLimXq5q+dRzMhK1glQKOcpx8fHY2GbSQEZ
         P5SBRknKzBqpg3GeMbtRkNYsCssZU4f2IZzIuZ+T1FXDIE5e6SvbZVEhugToi5evLXwA
         rKr3cezdy8MkGCDIPNNJJDFvEfRM1/Pwh52p5HmBjWC+MPr4XC7ckFb2bOuxecSbOLnb
         D9jQh1dpXk0Ca7ujqc6Hun43eU3muADv9iFymnQG5XnI29E/xjtEPR45ETtHy6yQ407z
         5F1A==
X-Gm-Message-State: APjAAAVNY9451vlunRErhQco2V+ewg8LFZB1O+ipdtz3aa5XJVTe7sz8
        geVUCsJNNRJ9RlssEaUzwfrfkw==
X-Google-Smtp-Source: APXvYqzf+qJgnUeqQvG0q196yIL7BFlfF2ImhuXnDKq2Nc9RZ6ZHCnGm/JBXEdesWWdkz8OViVV3qw==
X-Received: by 2002:a05:6402:78c:: with SMTP id d12mr111470360edy.160.1561472434802;
        Tue, 25 Jun 2019 07:20:34 -0700 (PDT)
Received: from phenom.ffwll.local ([2a02:168:569e:0:3106:d637:d723:e855])
        by smtp.gmail.com with ESMTPSA id n15sm4863868edd.49.2019.06.25.07.20.33
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Tue, 25 Jun 2019 07:20:33 -0700 (PDT)
Date:   Tue, 25 Jun 2019 16:20:31 +0200
From:   Daniel Vetter <daniel@ffwll.ch>
To:     Russell King - ARM Linux admin <linux@armlinux.org.uk>
Cc:     Daniel Vetter <daniel@ffwll.ch>,
        Emil Velikov <emil.velikov@collabora.com>,
        linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org,
        Joonyoung Shim <jy0922.shim@samsung.com>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Seung-Woo Kim <sw0312.kim@samsung.com>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Andrzej Pietrasiewicz <andrzej.p@collabora.com>,
        Inki Dae <inki.dae@samsung.com>,
        David Airlie <airlied@linux.ie>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        Kukjin Kim <kgene@kernel.org>, dri-devel@lists.freedesktop.org,
        kernel@collabora.com, Sean Paul <sean@poorly.run>,
        linux-kernel@vger.kernel.org, m.szyprowski@samsung.com
Subject: Re: [PATCH 0/2] Associate ddc adapters with connectors
Message-ID: <20190625142031.GV12905@phenom.ffwll.local>
Mail-Followup-To: Russell King - ARM Linux admin <linux@armlinux.org.uk>,
        Emil Velikov <emil.velikov@collabora.com>,
        linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org,
        Joonyoung Shim <jy0922.shim@samsung.com>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Seung-Woo Kim <sw0312.kim@samsung.com>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Andrzej Pietrasiewicz <andrzej.p@collabora.com>,
        Inki Dae <inki.dae@samsung.com>, David Airlie <airlied@linux.ie>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        Kukjin Kim <kgene@kernel.org>, dri-devel@lists.freedesktop.org,
        kernel@collabora.com, Sean Paul <sean@poorly.run>,
        linux-kernel@vger.kernel.org, m.szyprowski@samsung.com
References: <cover.1561452052.git.andrzej.p@collabora.com>
 <20190625100351.52ddptvb2gizaepi@shell.armlinux.org.uk>
 <817ccfba-754c-6a28-8d75-63f70605fd43@collabora.com>
 <20190625133639.GA16031@arch-x1c3>
 <20190625140755.GT12905@phenom.ffwll.local>
 <20190625141032.5jiy2oekb3olaejd@shell.armlinux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190625141032.5jiy2oekb3olaejd@shell.armlinux.org.uk>
X-Operating-System: Linux phenom 4.19.0-5-amd64 
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 25, 2019 at 03:10:32PM +0100, Russell King - ARM Linux admin wrote:
> On Tue, Jun 25, 2019 at 04:07:55PM +0200, Daniel Vetter wrote:
> > Otherwise I like this. Biggest problem I'm seeing here is rolling this out
> > everywhere, this is a lot of work. And without widespread adoptions it's
> > not terribly useful for userspace.
> 
> There will be cases where it's not possible, because the I2C bus is
> hidden behind a chip that doesn't give you direct access to the DDC
> bus.

Oh sure, plus lots of connectors where there's just not ddc bus at all.
But if we only roll this out for a handful of drivers it's also not great,
that's what I meant. Looking at

$ git grep drm_do_get_edid

there's only very few drivers where the ddc bus is hidden. There's a lot
more where it's not, and I think a big series to tackle those would serve
extremely well to make a case for this sysfs link.
-Daniel
-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
