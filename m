Return-Path: <SRS0=6SCO=RE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 999F3C4360F
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Mar 2019 14:22:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5B52220851
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Mar 2019 14:22:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="X5XycFZb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388453AbfCAOWX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 1 Mar 2019 09:22:23 -0500
Received: from mail-io1-f68.google.com ([209.85.166.68]:45117 "EHLO
        mail-io1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387704AbfCAOWW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Mar 2019 09:22:22 -0500
Received: by mail-io1-f68.google.com with SMTP id x9so19627710iog.12
        for <linux-kernel@vger.kernel.org>; Fri, 01 Mar 2019 06:22:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:message-id:subject:to:cc:date:in-reply-to:references
         :user-agent:mime-version:content-transfer-encoding;
        bh=hmRSS6AvPyS9Pv9m9t7V3lwTU9sgIgzy1G9yhAg4sRU=;
        b=X5XycFZbTUF4MWc194RbcoHDCb3llsKYUCxr7FPfcC33G1O9fw2nvbxu1arXnlHrW3
         jPwpL6myb+DOFCHJUB/hH3oHaY0nNKyWTWncL6Xgkf6yFmTVTkxMVYPaijhgXyQibo3U
         ww6sNwrQzZx4lRes37+lJNqNLAke6nHehW1l76uoRtlyf+1mNpp9Uo8aYDA8SQrwlwR+
         gTRM3UMnpSwl2YlhiX96aODtdO/gdAYo6FSfmTz6kPtjLUHRBY7iIQSmz4PuIqixuHwP
         VzfxTUWOBlZ9IMzWAmFaGRYVYKRSu1h+Ny36RaUMmjJO18ApcMXmmT4bzSBALPDXhzvK
         8pTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:message-id:subject:to:cc:date:in-reply-to
         :references:user-agent:mime-version:content-transfer-encoding;
        bh=hmRSS6AvPyS9Pv9m9t7V3lwTU9sgIgzy1G9yhAg4sRU=;
        b=ObeWL1EgdF89BHE24k9o4kUiNM1EbRtKlrEYgEVogWRpEa6sc1ZMEaFqHVVEd940ap
         Ds04qKIcLjrb+5uavfn0f0EXtyke/6M88WG8R3yV+QguhInHLKFUJECctp3ZtiPgPRhN
         TGmsl/feN2XlyTPRYXcvGX/021I4+hzDApK0DKFV6KtzAmlqtC67Y1eOX66wvb4PvVxy
         5JOEsnb/vrzJxPL0I4WosgatUQtc0eoOBqRZFHT+hXbLRkvjmiGDouxDBns5axaM7nlM
         pFwJz9ZSrjGuVq2y77Rv4hhlKxAgu6vHwdvozH1G+WzFa99219+byrTc6XA5sAIsfKhC
         eOjw==
X-Gm-Message-State: APjAAAX23ZS24efVRPnkZzrmyTdB6n/fjgkTqFNcSPgwvzodFWneVXcQ
        ntQnTbMlefHUGbA+G8LoDaY=
X-Google-Smtp-Source: APXvYqxYiKqWaZRBKGzf8L69G223Bk+xYa9v4rpLJKyiYO+O/hmYilZwBA1sIaeY2b9RiViO38ssQQ==
X-Received: by 2002:a5e:c70b:: with SMTP id f11mr2697621iop.39.1551450141214;
        Fri, 01 Mar 2019 06:22:21 -0800 (PST)
Received: from ola-842mrw1.ad.garmin.com ([204.77.163.55])
        by smtp.googlemail.com with ESMTPSA id a18sm8425928iol.68.2019.03.01.06.22.20
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 01 Mar 2019 06:22:20 -0800 (PST)
From:   Joshua Watt <jpewhacker@gmail.com>
X-Google-Original-From: Joshua Watt <JPEWhacker@gmail.com>
Message-ID: <3cc19ef13bdc605a4c2222dcdb262b8e06b38e77.camel@gmail.com>
Subject: Re: [PATCH] drm/virtio: Allow userspace to mmap() framebuffer
To:     Gerd Hoffmann <kraxel@redhat.com>
Cc:     dri-devel@lists.freedesktop.org, David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org
Date:   Fri, 01 Mar 2019 08:22:19 -0600
In-Reply-To: <20190301055135.qqph6ggypjvhuoan@sirius.home.kraxel.org>
References: <20190228164741.15590-1-JPEWhacker@gmail.com>
         <20190301055135.qqph6ggypjvhuoan@sirius.home.kraxel.org>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.30.5 (3.30.5-1.fc29) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2019-03-01 at 06:51 +0100, Gerd Hoffmann wrote:
> On Thu, Feb 28, 2019 at 10:47:41AM -0600, Joshua Watt wrote:
> > Reports the size of the virtgpu framebuffer to userspace and
> > installs
> > the deferred I/O handlers so that userspace can mmap() and write to
> > it.
> 
> Fixed already, as side effect of switching virtio to the generic
> fbdev
> emulation.  Patches are in the drm-misc-next branch and should land
> upstream in the 5.1 merge window.

Excellent. I gave it a try and that did what I needed. Thanks!

> 
> cheers,
>   Gerd
> 
-- 
Joshua Watt <JPEWhacker@gmail.com>

