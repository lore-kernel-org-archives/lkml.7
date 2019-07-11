Return-Path: <SRS0=G0tX=VI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40B89C74A4B
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Jul 2019 09:01:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 16BD220872
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Jul 2019 09:01:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ffwll.ch header.i=@ffwll.ch header.b="AyRT3XEN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728198AbfGKJBJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Jul 2019 05:01:09 -0400
Received: from mail-ot1-f66.google.com ([209.85.210.66]:34557 "EHLO
        mail-ot1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726088AbfGKJBI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Jul 2019 05:01:08 -0400
Received: by mail-ot1-f66.google.com with SMTP id n5so5117487otk.1
        for <linux-kernel@vger.kernel.org>; Thu, 11 Jul 2019 02:01:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=oeDZmXjNJ9N7oIVRGzsPot+OviyxnkTNYoPrR8aP9d0=;
        b=AyRT3XENh3voNDIU9ZRTMsgyN3Zo2yZCwY7qigQgaUK9FKGX+35qABr0yhnPDp6BAq
         ZMS0QvIAvXjqXPAhsTcRiA0OJKJAV/5XmwZeWSQsdUXNyXZoessYbmII4RGEXPDrsM06
         p2XUYh0KkwQAC4FEQBfYkTymHANoe85Nv1jTU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=oeDZmXjNJ9N7oIVRGzsPot+OviyxnkTNYoPrR8aP9d0=;
        b=V9eXZOSGGWPS+WIakDLlmZ2AuAEj6vtMXZoW+97Go22OxtWSbi6hi8agMN1bxdM7O9
         AGxMEgBLbkgppW+oJMD6F72jgKY5bVnXqwUabhkyHA+IS+57f1hHDqnffylZNcmMv+Wl
         sZmYLwoT0OjltY8TBdVq+6vE4P253ojj1mrO4XBvkrA+uT+LRNQueASmKucdTtuq8Gxs
         fN9vJE6e+BquJzXcLhSMUDU9UrbcJsHlQuPmC+IbGZwV18XFk1K6KP1rUe191oS/k+ZL
         YOr5Fi+7pDeR2XTAiKsSGRcqhnXs/xNpb2J/tVjPQeEL9W386Kle66PTpRqood7p+nTw
         uFmg==
X-Gm-Message-State: APjAAAWcCm8orvYKKguCycGgvfzS7fmOiyRQrhKWulpRxFeTb+9W9tUa
        kmQ4PoOxSof47hB1puGV/NT3QVals4j/RJMOrNM=
X-Google-Smtp-Source: APXvYqyCe/q3wxFRFcscYkRVe1u6hjZ8HXpR04sDpIEvQ3IpTztAbYS+YIrgCTNiGXnCwyPJ/360DKflCgH4LVh3/HQ=
X-Received: by 2002:a9d:590d:: with SMTP id t13mr2620567oth.281.1562835667563;
 Thu, 11 Jul 2019 02:01:07 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1561491964.git.rodrigosiqueiramelo@gmail.com>
 <ea7e3a0daa4ee502d8ec67a010120d53f88fa06b.1561491964.git.rodrigosiqueiramelo@gmail.com>
 <20190711082105.GI15868@phenom.ffwll.local> <hG3hgN80Bt03njzCaW7h3xaog7ppTTBzmsShC0L5LdCbr5dFkHMJHHxizeYa_IYP7uCwMG-vPJOWMhueq2LirNKFhulkkni2KFf3XA24bb8=@emersion.fr>
In-Reply-To: <hG3hgN80Bt03njzCaW7h3xaog7ppTTBzmsShC0L5LdCbr5dFkHMJHHxizeYa_IYP7uCwMG-vPJOWMhueq2LirNKFhulkkni2KFf3XA24bb8=@emersion.fr>
From:   Daniel Vetter <daniel@ffwll.ch>
Date:   Thu, 11 Jul 2019 11:00:56 +0200
Message-ID: <CAKMK7uHfnOHJS8sQ0fpysSTB-SiJ29ACH+rKQ45rhT+7rBH5pQ@mail.gmail.com>
Subject: Re: [PATCH V3 4/5] drm/vkms: Compute CRC without change input data
To:     Simon Ser <contact@emersion.fr>
Cc:     Rodrigo Siqueira <rodrigosiqueiramelo@gmail.com>,
        Brian Starkey <brian.starkey@arm.com>,
        Liviu Dudau <liviu.dudau@arm.com>,
        Haneen Mohammed <hamohammed.sa@gmail.com>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 11, 2019 at 10:28 AM Simon Ser <contact@emersion.fr> wrote:
>
> On Thursday, July 11, 2019 11:21 AM, Daniel Vetter <daniel@ffwll.ch> wrote:
>
> > On Tue, Jun 25, 2019 at 10:38:31PM -0300, Rodrigo Siqueira wrote:
> >
> > > The compute_crc() function is responsible for calculating the
> > > framebuffer CRC value; due to the XRGB format, this function has to
> > > ignore the alpha channel during the CRC computation. Therefore,
> > > compute_crc() set zero to the alpha channel directly in the input
> > > framebuffer, which is not a problem since this function receives a copy
> > > of the original buffer. However, if we want to use this function in a
> > > context without a buffer copy, it will change the initial value. This
> > > patch makes compute_crc() calculate the CRC value without modifying the
> > > input framebuffer.
> >
> > Uh why? For writeback we're writing the output too, so we can write
> > whatever we want to into the alpha channel. For writeback we should never
> > accept a pixel format where alpha actually matters, that doesn't make
> > sense. You can't see through a real screen either, they are all opaque :-)
>
> I'm not sure about that. See e.g.
> https://en.wikipedia.org/wiki/See-through_display

They have variable opaqueness, independent of the color value?

> Many drivers already accept FBs with alpha channels for the primary
> plane.
> https://drmdb.emersion.fr/formats?plane=1

If you have a background color (we assume it to be black) that makes
sense. Still doesn't mean we render transparent output, we don't.

> Just making sure we aren't painting ourselves into a corner. :P

You can add ARGB to your writeback format support list, there is no
corner here at all to get into (at least in the abstract sense).
-Daniel
-- 
Daniel Vetter
Software Engineer, Intel Corporation
+41 (0) 79 365 57 48 - http://blog.ffwll.ch
