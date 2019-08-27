Return-Path: <SRS0=qJmF=WX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9350AC41514
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Aug 2019 23:59:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6C4A62186A
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Aug 2019 23:59:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="Q5Z5XfDA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726258AbfH0X76 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 27 Aug 2019 19:59:58 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:35412 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725992AbfH0X76 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Aug 2019 19:59:58 -0400
Received: by mail-wm1-f66.google.com with SMTP id l2so866972wmg.0
        for <linux-kernel@vger.kernel.org>; Tue, 27 Aug 2019 16:59:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=W77jTG8bpy693vui4bkkDm6EWrj+wqx5LPjIltQ2Bvg=;
        b=Q5Z5XfDAESAdLfdGE6V4W96CLOS3dePdM2+vmZfW8cm+pb1ZUVhF1J6Rfypeiyc7sJ
         s5q4L+VwYxCn49Ugw6k6/xI0JZcp1AAzgjL5uVV5znv9hy6LsWZSQvoALgfxDNRogtNq
         xZIhQ0yjN9+8TUG96Xzlq4Z4PJNPRgoS8dd6g=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=W77jTG8bpy693vui4bkkDm6EWrj+wqx5LPjIltQ2Bvg=;
        b=MuVfSv9S2nxH8mpKGu1+c+Fv8Mbd3DtuArmKHqrR33WIGV2cZ6rLSpArlqGCQRgMam
         Ib7mCoRkuqHZA3HVgU00PKm0fz1aX3CMuAneJhN0gCvDiultlzYnHy30nYp8paFpwZxj
         R8yXbtUxLiORKH+UYZ0v7akQqCLvXIygliDr+TmhK58d1vPudwIkhRrxr+aUP0iy1Kmc
         8Iewe8tMdHAUvuQFy1cHbWpFx7dZYhVpc8Vmgc2ylPa4zRpFe0hlF4MOZDwUHPZI8NLP
         wFmJUdb8vXtkdX4K7j3PJHqnlOP4neKaBhmomExeI7z8qWZBFVB7PcRjE0DsY9H6X0yf
         qi6A==
X-Gm-Message-State: APjAAAUdezJ309/jk16SuJAKD42yxiRxJlZXiiXiAo+e9kgkDVZXPOQr
        prwKzlmYVYjyKXRdKfyWjCEbW1lRpwEqqVK90dr8iA==
X-Google-Smtp-Source: APXvYqxR32O+zrZRq6UlHyugg3oVxb6uNT8nx9VRWJKKwAsOCnBzaY+cuwdNtMkDLqIR1CU5+OLY5uUIyeUmEnPScAY=
X-Received: by 2002:a7b:ca54:: with SMTP id m20mr1001230wml.102.1566950396022;
 Tue, 27 Aug 2019 16:59:56 -0700 (PDT)
MIME-Version: 1.0
References: <20190827231409.253037-1-jwerner@chromium.org> <CAA6KcBAykS+VkhkcF42PhGyNu8KAEoaYPgA9-ru_HCxKrAEZzg@mail.gmail.com>
In-Reply-To: <CAA6KcBAykS+VkhkcF42PhGyNu8KAEoaYPgA9-ru_HCxKrAEZzg@mail.gmail.com>
From:   Julius Werner <jwerner@chromium.org>
Date:   Tue, 27 Aug 2019 16:59:43 -0700
Message-ID: <CAODwPW-+pPtiBh8Swn-cFs--2YaG6fMDyAzLXRucoweV50hDwA@mail.gmail.com>
Subject: Re: [PATCH] usb: storage: Add ums-cros-aoa driver
To:     Matthew Dharm <mdharm-usb@one-eyed-alien.net>
Cc:     Alan Stern <stern@rowland.harvard.edu>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        LKML <linux-kernel@vger.kernel.org>, linux-usb@vger.kernel.org,
        USB Mass Storage on Linux 
        <usb-storage@lists.one-eyed-alien.net>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> Why not do the mode switch from userspace?  I thought we were trying to move all the mode-switching stuff in that direction.....

I need to tie in to the main USB mass storage driver in a way that I
think would make it too complicated to move the mode switching part to
userspace. See the part I'm adding to initializers.c... that one has
to be in the kernel since it operates on the device after the mode
switch when it is claimed by the normal USB storage driver. But the
mode switch part has to communicate information to it to make sure it
picks up the right device (just relying on the normal USB device
matching isn't enough in this case, because all Android devices in AOA
mode identify themselves with that well-known VID/PID... I don't know
if there's any other kernel driver using this protocol today, but
there may be at some point and then it becomes important to make sure
you really grab the device you meant to grab). Some of that
information (the 'route' field) isn't even directly available from
userspace (I could use the device name string instead and that would
roughly come out to the same thing, but seems less clean to me).

So I could either do the mode switch in userspace and add a big custom
sysfs interface to the usb-storage driver to allow userspace to
configure all this, or I can add a small kernel shim driver like in
this patch. Considering how little code the shim driver actually needs
I expect it would come out to roughly the same amount of kernel code
in both cases, and I feel like this version is much simpler to follow
and fits cleaner in the existing "unusual device" driver
infrastructure.
