Return-Path: <SRS0=nTU8=ZV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 49408C432C0
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Nov 2019 04:05:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1A4E92158A
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Nov 2019 04:05:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="Z8aADKxY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726985AbfK2EFZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Nov 2019 23:05:25 -0500
Received: from mail-ed1-f65.google.com ([209.85.208.65]:42850 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726800AbfK2EFZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Nov 2019 23:05:25 -0500
Received: by mail-ed1-f65.google.com with SMTP id e10so4525724edv.9
        for <linux-kernel@vger.kernel.org>; Thu, 28 Nov 2019 20:05:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=kSUVC3ggQB4xLQjsKBDHLkM4F4fy4M5PEtTRPWySnj4=;
        b=Z8aADKxYdIrSSCBHE0WebFG2Y8sksQBDe+gJGDwWDNLDZLLWgUw0NbN/otBEPsWrCB
         ksbD/tyyRmIBAgkLWB/wwjaPhT4CJ4PJdimwooAy6EAGK6ZSqrHsQRBG1+zHdrTLXX0l
         Zo9jhdd2/cn0njSg1cj82rO5mz0+0Ujp8BCCM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=kSUVC3ggQB4xLQjsKBDHLkM4F4fy4M5PEtTRPWySnj4=;
        b=VeHbrnSIeHkjV6GqTq1UKGDxx7NtehuN7fVjU1wzSeJHEiSlGJBbPa2Ky5W2K96lA6
         Sa3lOI/ij09a2HkUx3HRPN6tIyP90yokb+CyOmWUw8FKxa8tGwTljj206cHBSi+OHJb+
         F6j3/Nv718wr/Yq3P9QetrQSoCQzXgzVHvU0AFE98JRPBZLDpxsUxaKKy07WZnMxptVq
         OvBRmabjLt/dzvvxvNUsDYY91EsgFasZGVjztIn1CZKLNdoWnp8OtEWH+6aLuNDUJj9t
         /jc1zGC2xRLbQh6Kyz0um8u4hF5ali3JTTLXSj1JIUGHGIHOhkmYFj9OwdOVyBaEQJX4
         VWkw==
X-Gm-Message-State: APjAAAWCBAKBpQHUo/TweAT96gOLScs3kAcFJNWDTLgEy1GoiDP68DJv
        OEiLMB4l8niXsW4BStcoG/yQV47720d4/+5HJXutEQ==
X-Google-Smtp-Source: APXvYqzJA0oarVNbcMx254Rxgm0ocDOJdIJTZOA0fppCRnNb/55GHaFez2T3pW6EU1cmssT3oMFxhwU7MDDuZHKDUmY=
X-Received: by 2002:a17:906:57c3:: with SMTP id u3mr59264192ejr.254.1575000323169;
 Thu, 28 Nov 2019 20:05:23 -0800 (PST)
MIME-Version: 1.0
References: <20191128033959.87715-1-pihsun@chromium.org> <d02f4eef9aa674cb36c1d90069a13e7bd02b7e40.camel@perches.com>
In-Reply-To: <d02f4eef9aa674cb36c1d90069a13e7bd02b7e40.camel@perches.com>
From:   Pi-Hsun Shih <pihsun@chromium.org>
Date:   Fri, 29 Nov 2019 12:04:47 +0800
Message-ID: <CANdKZ0eYSdPC2y5QxN1B7FshewXumrETQohbXrnvbovXMkSe9Q@mail.gmail.com>
Subject: Re: [PATCH RESEND] wireless: Use offsetof instead of custom macro.
To:     Joe Perches <joe@perches.com>
Cc:     linux-wireless@vger.kernel.org,
        Johannes Berg <johannes@sipsolutions.net>,
        open list <linux-kernel@vger.kernel.org>,
        "open list:CLANG/LLVM BUILD SUPPORT" 
        <clang-built-linux@googlegroups.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 28, 2019 at 11:54 AM Joe Perches <joe@perches.com> wrote:
>
> On Thu, 2019-11-28 at 11:39 +0800, Pi-Hsun Shih wrote:
> > Use offsetof to calculate offset of a field to take advantage of
> > compiler built-in version when possible, and avoid UBSAN warning when
> > compiling with Clang:
> []
> > diff --git a/include/uapi/linux/wireless.h b/include/uapi/linux/wireless.h
> []
> > @@ -1090,8 +1090,7 @@ struct iw_event {
> >  /* iw_point events are special. First, the payload (extra data) come at
> >   * the end of the event, so they are bigger than IW_EV_POINT_LEN. Second,
> >   * we omit the pointer, so start at an offset. */
> > -#define IW_EV_POINT_OFF (((char *) &(((struct iw_point *) NULL)->length)) - \
> > -                       (char *) NULL)
> > +#define IW_EV_POINT_OFF offsetof(struct iw_point, length)
> >  #define IW_EV_POINT_LEN      (IW_EV_LCP_LEN + sizeof(struct iw_point) - \
> >                        IW_EV_POINT_OFF)
>
> This is uapi.  Is offsetof guaranteed to be available?

offsetof is already used in other uapi headers
(include/uapi/linux/fuse.h FUSE_NAME_OFFSET).

Also offsetof is also defined back in C89 standard (in stddef.h), so
it should be widely available and should be fine to use here?
(Should I add a #ifndef __KERNEL__ #include <stddef.h> to the file?)

>
> Perhaps this is better without using another macro
>
> #define IW_EV_POINT_OFF ((size_t)&((struct iw_point *)NULL)->length)

Clang UBSAN would still complain about this, since it's the same
pattern as the original one.

>
