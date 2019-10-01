Return-Path: <SRS0=YRFP=X2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF805ECE587
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Oct 2019 13:45:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9CF9721783
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Oct 2019 13:45:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="V39IyWmx"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727104AbfJANp5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 1 Oct 2019 09:45:57 -0400
Received: from mail-qt1-f193.google.com ([209.85.160.193]:41113 "EHLO
        mail-qt1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726152AbfJANp5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Oct 2019 09:45:57 -0400
Received: by mail-qt1-f193.google.com with SMTP id d16so1037889qtq.8
        for <linux-kernel@vger.kernel.org>; Tue, 01 Oct 2019 06:45:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=T00f8oMdHVkq3W+YEv58SmUAyov+mXAtsvXMMacWUW0=;
        b=V39IyWmxk0rgxt/doIxYB7cVCye9DyolWnRUFJWdX2uiEJw7ZqTTPwOC1H3mTm/MtK
         uoZhI9uHFApcOHp2lrQGzysxHBQN5o53+a1xxXtTQ08W1tVyh9k+0Mt0lBJeORFCy2GA
         7HIA9QCLKhHlUqQj3SAwMG8+X93km5hvTjGxPjmLWjtn21OkVu8uKXt5ldVnVV79O5cy
         zvJLVp+dlA0WQo1Nl097b9bCI1HitM7j8Br4HOJ2iyZIdtSOBVJRL5hOUPM9sIMLqf8E
         vNlXR4mVpy2cUVYgHf68mTY4gEqW/+tBwqSGnGZn356X6XKR8EqtayopDV8AVpkMcUNm
         PP0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=T00f8oMdHVkq3W+YEv58SmUAyov+mXAtsvXMMacWUW0=;
        b=JcS1AYAKifQeHaKyiWPj4hGhwyEZCT2Ezt0E7H2Maww2vW9jTaDNdC9oVxO8AZp2jE
         pvvfKdivoAMwiqnYBhUfY1xo4J8WEVXlCIxzXFSbP00VDWPnsboI7Yd61cJq3FxN1L6t
         3jZRNvVREQYXCVwnY6j+eTWBACJi0oPfDX0XjKEExrYlNoO4+OBzjuCV43tUf7RoV1WH
         1jop8Wi0pU0B/Kw6xGctLkf0qo8Y6+s+h4luqbujpA8aTp5s/B5kl0wYPkQj4gvHM7O8
         05b7Bm+XM2Jre4+BZbtvrPvH+s579VRl3pWOVbGcCU4rbbdST8nVLvh3wln6kolgTx5o
         SEMg==
X-Gm-Message-State: APjAAAUnPvf9mXksy8h/oHpDtxyPL91IXbngNP/EG4SCTYadrS4WkWD1
        X6PLsFGEGCynqavrWSk3g4x0Yw==
X-Google-Smtp-Source: APXvYqwiG/lt+iFDKSmGAhOXggR1gSAbWoLCXPkRzTmBM7QvGMyE3m+0mokw3wsruQ7dNlyt9RXdvA==
X-Received: by 2002:ac8:5243:: with SMTP id y3mr30415686qtn.51.1569937556568;
        Tue, 01 Oct 2019 06:45:56 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-142-162-113-180.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.162.113.180])
        by smtp.gmail.com with ESMTPSA id g3sm6948383qkb.117.2019.10.01.06.45.55
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 01 Oct 2019 06:45:55 -0700 (PDT)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)
        (envelope-from <jgg@ziepe.ca>)
        id 1iFITT-00058C-Ek; Tue, 01 Oct 2019 10:45:55 -0300
Date:   Tue, 1 Oct 2019 10:45:55 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Noralf =?utf-8?Q?Tr=C3=B8nnes?= <noralf@tronnes.org>
Cc:     dri-devel@lists.freedesktop.org, daniel.vetter@ffwll.ch,
        sam@ravnborg.org, hdegoede@redhat.com, linux-kernel@vger.kernel.org
Subject: Re: [1/3] drm/tinydrm/Kconfig: Remove menuconfig DRM_TINYDRM
Message-ID: <20191001134555.GB22532@ziepe.ca>
References: <20190725105132.22545-2-noralf@tronnes.org>
 <20191001123636.GA8351@ziepe.ca>
 <1fffe7b1-a738-a9e3-ea5f-9d696cb98650@tronnes.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1fffe7b1-a738-a9e3-ea5f-9d696cb98650@tronnes.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 01, 2019 at 03:28:46PM +0200, Noralf Trønnes wrote:
> 
> 
> Den 01.10.2019 14.36, skrev Jason Gunthorpe:
> > On Thu, Jul 25, 2019 at 12:51:30PM +0200, Noralf Trønnes wrote:
> >> This makes the tiny drivers visible by default without having to enable a
> >> knob.
> >>
> >> Signed-off-by: Noralf Trønnes <noralf@tronnes.org>
> >> Reviewed-by: Hans de Goede <hdegoede@redhat.com> to it once
> >>  drivers/gpu/drm/Makefile        |  2 +-
> >>  drivers/gpu/drm/tinydrm/Kconfig | 37 +++++++++++++++++++--------------
> >>  2 files changed, 22 insertions(+), 17 deletions(-)
> > 
> > Bisection says this patch (28c47e16ea2a19adb47fe2c182cbd61cb854237c)
> > breaks kconfig stuff in v5.4-rc by creating circular
> > dependencies. Could someone send a -rc patch to fix this please?
> > 
> > THINKPAD_ACPI (defined at drivers/platform/x86/Kconfig:484), with definition...
> > ...depends on FB_SSD1307 (defined at drivers/video/fbdev/Kconfig:2259), with definition...
> > ...depends on FB (defined at drivers/video/fbdev/Kconfig:12), with definition...
> > ...depends on DRM_KMS_FB_HELPER (defined at drivers/gpu/drm/Kconfig:79), with definition...
> > ...depends on DRM_KMS_HELPER (defined at drivers/gpu/drm/Kconfig:73), with definition...
> > ...depends on TINYDRM_REPAPER (defined at drivers/gpu/drm/tinydrm/Kconfig:51), with definition...
> > ...depends on THERMAL (defined at drivers/thermal/Kconfig:6), with definition...
> > ...depends on SENSORS_NPCM7XX (defined at drivers/hwmon/Kconfig:1285), with definition...
> > ...depends on HWMON (defined at drivers/hwmon/Kconfig:6), with definition...
> > ...depends on THINKPAD_ACPI (defined at drivers/platform/x86/Kconfig:484), with definition...
> > ...depends on ACPI_VIDEO (defined at drivers/acpi/Kconfig:193), with definition...
> > ...depends on ACER_WMI (defined at drivers/platform/x86/Kconfig:19), with definition...
> > ...depends on BACKLIGHT_CLASS_DEVICE (defined at drivers/video/backlight/Kconfig:144), with definition...
> > ...depends again on THINKPAD_ACPI (defined at drivers/platform/x86/Kconfig:484)
> > 
> 
> Would this commit fix this by any chance:
> 
> drm/tiny: Kconfig: Remove always-y THERMAL dep. from TINYDRM_REPAPER
> https://cgit.freedesktop.org/drm/drm-misc/commit/?id=dfef959803c728c616ad29b008cd91b3446a993a

Yes, thank you, can someone send this to -rc to unbreak 5.4?

Jason
