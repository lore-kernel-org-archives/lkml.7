Return-Path: <SRS0=Tfva=ZZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 34FAFC432C0
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Dec 2019 19:36:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 01002206DF
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Dec 2019 19:36:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VDs4IfsA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727476AbfLCTge (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Dec 2019 14:36:34 -0500
Received: from mail-pf1-f193.google.com ([209.85.210.193]:36911 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727376AbfLCTge (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Dec 2019 14:36:34 -0500
Received: by mail-pf1-f193.google.com with SMTP id s18so2345939pfm.4
        for <linux-kernel@vger.kernel.org>; Tue, 03 Dec 2019 11:36:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=ImBkBwGZpmPmH6tbvsUiq2gNt6SbxRy0Wfq0GttqIxw=;
        b=VDs4IfsAcHd+PFPQB6HWeiUp+gVdvGdE0+ewTVhg+PamnAq6CocOa6xGAnVYdesdbK
         8/1gxFB8GEOJif8L/7/IgpFUYjEFhiSwQpK8d6r/eMM3VvJ3Wx1gKHDJo961Lmsvu53A
         DBC+YeIz3pO+6nSSQ+q0OUXTcA8kx4+ejcyAK+nb/berHfg9gLOAKu/jbJSOnQMR/nxg
         vCoaLVtaLD+WMERpmAQG38l6WVmO0+HM6pURwijBkvNUmLLdFWMLdOdXTPiRsDJTjUl4
         X51Pe1cNkK+f3YwHDUH/ZmsN4S8mvVDME0gIiBm2HF1er5CzgRmreULwOViwIERnArgJ
         pnBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=ImBkBwGZpmPmH6tbvsUiq2gNt6SbxRy0Wfq0GttqIxw=;
        b=ZC4zm48R0jlTC6qLFEjLRA1veUcPozklqPrThhhGWLO0KJhj4OaKZyEk+7CNOoK4oY
         72liH47ZtvGPfUAYGlD3zGXVFmq6AF/rA257nELpcVdr1tang+mOKa3Fa2rSAWrlTFIS
         +iYJ9O3VYfbSjpvX7goAqvWLsy4OV6pkuFIT6cuLqxRBLW9MJIEwU24O8tf7XwlsK5Sq
         4lmpGhQ7ttGUP0Gye6anSqfWf1TpeNILGNwXMeQimk/HK8TteAqJoArx47vXR7sZiNze
         bSvty0y2zxaWruDPlvqkYzsqfK0cAlQ/rup7Z0jEsmsVlKXIpBOzGMKxp3lY+2dymSsu
         kCqQ==
X-Gm-Message-State: APjAAAVRhRUj2YlkNJk0YA8gvUAIhhXUFqfw0QMmumaundNaqaSH1bFS
        rHhDhAGCZ6wZjtN9gOugvBc=
X-Google-Smtp-Source: APXvYqxt3hAhX2A8YwXedj6bpmagjXVtBdnukYYs03DbWi3z8mJFVPf83FkPpuxxxwzxN3TQrbIu9g==
X-Received: by 2002:a65:6381:: with SMTP id h1mr7228654pgv.332.1575401793238;
        Tue, 03 Dec 2019 11:36:33 -0800 (PST)
Received: from dtor-ws ([2620:15c:202:201:3adc:b08c:7acc:b325])
        by smtp.gmail.com with ESMTPSA id u4sm3767788pjb.31.2019.12.03.11.36.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Dec 2019 11:36:32 -0800 (PST)
Date:   Tue, 3 Dec 2019 11:36:30 -0800
From:   Dmitry Torokhov <dmitry.torokhov@gmail.com>
To:     Stephen Oberholtzer <stevie@qrpff.net>
Cc:     Benson Leung <bleung@chromium.org>, linux-kernel@vger.kernel.org
Subject: Re: [RFC] chromeos_laptop: Make touchscreen work on C720
Message-ID: <20191203193630.GK50317@dtor-ws>
References: <CAD_xR9dGuVLsZf1P3C-x7L8_WVkHHMfQCKdvR_ZRkeBXCOxW_w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAD_xR9dGuVLsZf1P3C-x7L8_WVkHHMfQCKdvR_ZRkeBXCOxW_w@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Stephen,

On Tue, Dec 03, 2019 at 11:03:18AM -0500, Stephen Oberholtzer wrote:
> From 627be71ee77f4fc20cdb55c6e0a06826fb43ca9d Mon Sep 17 00:00:00 2001
> From: Stephen Oberholtzer <stevie@qrpff.net>
> Date: Tue, 3 Dec 2019 02:20:28 -0500
> Subject: [RFC] chromeos_laptop: Make touchscreen work on C720
> 
> I have an old Acer C720 Chromebook reflashed with MrChromebox, running
> Debian.  When I did an upgrade, the touchscreen stopped working; I traced
> it to the kernel.
> 
> After six hours of bisecting -- if anyone can tell me how to make a kernel
> build take less than 2 hours of CPU time while bisecting, I'd greatly
> appreciate it -- I tracked the problem to commit 7cf432bf0586
> ("Input: atmel_mxt_ts - require device properties present when probing").
> 
> Looking at https://lkml.org/lkml/2018/5/3/955, it appears that the idea
> was to reassign the responsibility for setting up ACPI data for
> atmel_mxt_ts into chromeos_laptop, which makes a lot of sense, as that
> would tidy up some potential maintenance issues.
> 
> However, that doesn't actually work.  The chromeos_laptop code appears to
> categorize every Chromebook as exactly one of the following:
> 
> (A) Having I2C devices (declared using DECLARE_CROS_LAPTOP)
> (B) Requiring ACPI munging (declared using DECLARE_ACPI_CROS_LAPTOP)
> 
> There's some stuff about a board_info.properties that looks like it's meant
> to do the job for I2C devices, but it doesn't seem to do anything;
> it *definitely* doesn't do what the atmel_mxt_ts driver is expecting.
> 
> On the other hand, when I apply the following patch to a recent kernel
> (5.2 is the one I tested), my touchscreen works again.
> 
> I'm still not sure if the appropriate solution is to ensure that the
> ACPI properties are set, or if atmel_mxt_ts should be checking both
> ACPI properties and the I2C board_info.properties, however.

Acer C720 did not use ACPI to describe its devices, it relied on static
board support to instantiate touchscreen and trackpad and other devices.
Does the new kernel work with the original firmware (it should as that's
what it's been tested with)?

I see that MrChromebox BIOS declares the peripherals on Peppy via ACPI.
I'd recommend reaching out and ask to update the binding (maybe switch
from ATML0001 to PRP0001 and full OF-style binding to avoid confusion).

Thanks.

-- 
Dmitry
