Return-Path: <SRS0=kpxk=YC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0D309C47404
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Oct 2019 10:45:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C78DD2133F
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Oct 2019 10:45:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=ffwll.ch header.i=@ffwll.ch header.b="gOh0Ame+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730339AbfJIKpi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 9 Oct 2019 06:45:38 -0400
Received: from mail-ed1-f67.google.com ([209.85.208.67]:33580 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726734AbfJIKpi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Oct 2019 06:45:38 -0400
Received: by mail-ed1-f67.google.com with SMTP id c4so1599807edl.0
        for <linux-kernel@vger.kernel.org>; Wed, 09 Oct 2019 03:45:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=sender:date:from:to:cc:subject:message-id:mail-followup-to
         :references:mime-version:content-disposition
         :content-transfer-encoding:in-reply-to:user-agent;
        bh=6+XvDcKE2RU3GarFMY6VFWF5e0vqSLtQ1WSp/MxdvAE=;
        b=gOh0Ame+9n5xA+JyzEumEbwhcF1sWB3ZNPV4KTv2mW1kph+Ebri0o4bV02T8jtXDRR
         J+f+5LbjnmqKFqIz1sDF96Cj0BrmfyhOLrosPja6sx/hqLaZOUI020WNSzpiBSBy2PbL
         2SB/swB2haCopFqm+jdn5U/g9HgbyD0os75Bs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :content-transfer-encoding:in-reply-to:user-agent;
        bh=6+XvDcKE2RU3GarFMY6VFWF5e0vqSLtQ1WSp/MxdvAE=;
        b=qwSJrQ5IGK21ADHeCGFOUcrJkJcjyWYxr8yus6ZQ+gZunEqeN1UpjYRycVX7/CCmNA
         FiC0o9w+jZfek1LzZcqnqLReZ+OB4YaLTSwCKDLw/XtLVGEe7tlgpqHwvIMGSaqfTUmo
         gPPWYmjmAmXCLYUWYJTf45Nz9kJJcGdUnkXYX3IxKxfRw2ggWl/TMSi9Q03yMz7kqzfd
         GUrnIUx9eq+iaUlyFzBrjGHgEdv9iJ/c0zv0lSaG8G5NWaQRPnhhGtoT3wwetYoE/zae
         imj07mn/cyJNMOth337ePm6Yx4axQZFiHvvvNiCRVfSytM4mMUc2WgSP0JUPgodsMLh6
         X9nA==
X-Gm-Message-State: APjAAAUpQ4jB4NCJ/N3TUteKfiKIbuJHuJltM5u/2F7FyRvwzIivCqJN
        SLb2fy7y9WRBqf1jDr2L9ICtWw==
X-Google-Smtp-Source: APXvYqypf8TUWCjOC1hqek7KsLpkZOQhKyoafQfZ3yoK7AHqD4tOQfjVJl8fSNIoCuMXhrJPXSLG4g==
X-Received: by 2002:a17:906:218a:: with SMTP id 10mr2138984eju.38.1570617934430;
        Wed, 09 Oct 2019 03:45:34 -0700 (PDT)
Received: from phenom.ffwll.local (212-51-149-96.fiber7.init7.net. [212.51.149.96])
        by smtp.gmail.com with ESMTPSA id u30sm292574edd.18.2019.10.09.03.45.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Oct 2019 03:45:33 -0700 (PDT)
Date:   Wed, 9 Oct 2019 12:45:31 +0200
From:   Daniel Vetter <daniel@ffwll.ch>
To:     Noralf =?iso-8859-1?Q?Tr=F8nnes?= <noralf@tronnes.org>
Cc:     Jason Gunthorpe <jgg@ziepe.ca>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Sean Paul <sean@poorly.run>, dri-devel@lists.freedesktop.org,
        daniel.vetter@ffwll.ch, sam@ravnborg.org, hdegoede@redhat.com,
        linux-kernel@vger.kernel.org
Subject: Re: [1/3] drm/tinydrm/Kconfig: Remove menuconfig DRM_TINYDRM
Message-ID: <20191009104531.GW16989@phenom.ffwll.local>
Mail-Followup-To: Noralf =?iso-8859-1?Q?Tr=F8nnes?= <noralf@tronnes.org>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>, Sean Paul <sean@poorly.run>,
        dri-devel@lists.freedesktop.org, sam@ravnborg.org,
        hdegoede@redhat.com, linux-kernel@vger.kernel.org
References: <20190725105132.22545-2-noralf@tronnes.org>
 <20191001123636.GA8351@ziepe.ca>
 <1fffe7b1-a738-a9e3-ea5f-9d696cb98650@tronnes.org>
 <20191001134555.GB22532@ziepe.ca>
 <75055e2d-44f7-0cba-4e41-537097b73c3c@tronnes.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <75055e2d-44f7-0cba-4e41-537097b73c3c@tronnes.org>
X-Operating-System: Linux phenom 5.2.0-2-amd64 
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 01, 2019 at 04:07:38PM +0200, Noralf Trønnes wrote:
> Hi drm-misc maintainers,
> 
> I have just applied a patch to drm-misc-next that as it turns out should
> have been applied to -fixes for this -rc cycle.
> 
> Should I cherry pick it to drm-misc-next-fixes?

Yup, cherry pick and reference the commit that's already in -next (in case
it creates conflicts down the road that reference makes the mess easier to
understand).

> (I know there's a flowchart in the docs but I've never really understood
> it.)

Usually bugfixes for kernel releases should land in drm-misc-next-fixes or
drm-misc-fixes. But cherry-picking over in case of mistakes is ok too.
-Daniel

> 
> Noralf.
> 
> Den 01.10.2019 15.45, skrev Jason Gunthorpe:
> > On Tue, Oct 01, 2019 at 03:28:46PM +0200, Noralf Trønnes wrote:
> >>
> >>
> >> Den 01.10.2019 14.36, skrev Jason Gunthorpe:
> >>> On Thu, Jul 25, 2019 at 12:51:30PM +0200, Noralf Trønnes wrote:
> >>>> This makes the tiny drivers visible by default without having to enable a
> >>>> knob.
> >>>>
> >>>> Signed-off-by: Noralf Trønnes <noralf@tronnes.org>
> >>>> Reviewed-by: Hans de Goede <hdegoede@redhat.com> to it once
> >>>>  drivers/gpu/drm/Makefile        |  2 +-
> >>>>  drivers/gpu/drm/tinydrm/Kconfig | 37 +++++++++++++++++++--------------
> >>>>  2 files changed, 22 insertions(+), 17 deletions(-)
> >>>
> >>> Bisection says this patch (28c47e16ea2a19adb47fe2c182cbd61cb854237c)
> >>> breaks kconfig stuff in v5.4-rc by creating circular
> >>> dependencies. Could someone send a -rc patch to fix this please?
> >>>
> >>> THINKPAD_ACPI (defined at drivers/platform/x86/Kconfig:484), with definition...
> >>> ...depends on FB_SSD1307 (defined at drivers/video/fbdev/Kconfig:2259), with definition...
> >>> ...depends on FB (defined at drivers/video/fbdev/Kconfig:12), with definition...
> >>> ...depends on DRM_KMS_FB_HELPER (defined at drivers/gpu/drm/Kconfig:79), with definition...
> >>> ...depends on DRM_KMS_HELPER (defined at drivers/gpu/drm/Kconfig:73), with definition...
> >>> ...depends on TINYDRM_REPAPER (defined at drivers/gpu/drm/tinydrm/Kconfig:51), with definition...
> >>> ...depends on THERMAL (defined at drivers/thermal/Kconfig:6), with definition...
> >>> ...depends on SENSORS_NPCM7XX (defined at drivers/hwmon/Kconfig:1285), with definition...
> >>> ...depends on HWMON (defined at drivers/hwmon/Kconfig:6), with definition...
> >>> ...depends on THINKPAD_ACPI (defined at drivers/platform/x86/Kconfig:484), with definition...
> >>> ...depends on ACPI_VIDEO (defined at drivers/acpi/Kconfig:193), with definition...
> >>> ...depends on ACER_WMI (defined at drivers/platform/x86/Kconfig:19), with definition...
> >>> ...depends on BACKLIGHT_CLASS_DEVICE (defined at drivers/video/backlight/Kconfig:144), with definition...
> >>> ...depends again on THINKPAD_ACPI (defined at drivers/platform/x86/Kconfig:484)
> >>>
> >>
> >> Would this commit fix this by any chance:
> >>
> >> drm/tiny: Kconfig: Remove always-y THERMAL dep. from TINYDRM_REPAPER
> >> https://cgit.freedesktop.org/drm/drm-misc/commit/?id=dfef959803c728c616ad29b008cd91b3446a993a
> > 
> > Yes, thank you, can someone send this to -rc to unbreak 5.4?
> > 
> > Jason
> > 

-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
