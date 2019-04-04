Return-Path: <SRS0=oHH8=SG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AFBBAC4360F
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Apr 2019 09:54:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7F80E206DD
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Apr 2019 09:54:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ffwll.ch header.i=@ffwll.ch header.b="NWfYvLgw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729324AbfDDJyk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Apr 2019 05:54:40 -0400
Received: from mail-it1-f193.google.com ([209.85.166.193]:53836 "EHLO
        mail-it1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729609AbfDDIw1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Apr 2019 04:52:27 -0400
Received: by mail-it1-f193.google.com with SMTP id y204so2525346itf.3
        for <linux-kernel@vger.kernel.org>; Thu, 04 Apr 2019 01:52:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Q5FExhf/vsmloCzHqpnPO3DcxYCE1juO10D9mkCNuis=;
        b=NWfYvLgwZT3uZyxir3kAHmfQNcsOb6NxT4s9RmrTdqR1nI0OUr4gsGNrRfXR8c24jL
         wTVnZk8S/KN46j8nMsUS0ux+BFz4438b7nF9i6zPzaEBiPn8vgdG4t0cd/rwAclWSp0s
         mszsu6307JVFBxWz/IDi+cdO7Sr0V/b9oyD+k=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Q5FExhf/vsmloCzHqpnPO3DcxYCE1juO10D9mkCNuis=;
        b=XJr+JiguVdY2zX7gsqpApJPkEyYUeQs20SeJkCjxKcULJGSoyp78BNAwj4R+CqPaHf
         5/SjYikWqANDFS8ec6++Vpi7z1WQ+nMze/mH2Kr9n971KQfT7yJf5S1B5zRW/lvrnP9I
         9X+fLS6GttWjeywxSvED7wDgxEFAobXgO3LPAvM8vZ7CNjAUcTRX7aS27+ErY/W9h7bG
         xrSZaeRdczNLj2eodA7iq+oQld1tHXzLCB5PqnKFhrq8VDjrPG9K3GtC/Y9yp/slX+dW
         YZZ7ENTyvNF6sc5SInm+nAOL8WhfyO+Eg/2unTgAPy8PjSRJn2HKZPBpYcZ899SGThSa
         GhZg==
X-Gm-Message-State: APjAAAVfFCxDGSHlB62ssZ3mk3vs855r7GtKJejOGtcfwATMr0HcGMpB
        RuygVmpD0dQKf00BR44ED4da0hF/VDFbp/KGVlN+scvC2OI=
X-Google-Smtp-Source: APXvYqzB0ZRITeg/OXi91QQ+Kg7Z3MzeVE/J4oey+nkeBged4BhKVpgU69rIji05cg0GLn3S2j3zpj0slQeuJdFRhDM=
X-Received: by 2002:a24:480e:: with SMTP id p14mr4187938ita.61.1554367946128;
 Thu, 04 Apr 2019 01:52:26 -0700 (PDT)
MIME-Version: 1.0
References: <20190403072318.31507-1-kraxel@redhat.com> <CAMwc25o=DZSVE5Qf5mow6es06Gk3=+6+8offXPY-JPgUkG_Shw@mail.gmail.com>
 <20190404055056.ddc2bdgjbgjj7tby@sirius.home.kraxel.org> <CAKMK7uFbLcziLXrwds9QZBBPFiBDC_O+X9fiuutNjsutaPW+sQ@mail.gmail.com>
 <20190404083034.f7vrvukzqx5v7qju@sirius.home.kraxel.org>
In-Reply-To: <20190404083034.f7vrvukzqx5v7qju@sirius.home.kraxel.org>
From:   Daniel Vetter <daniel@ffwll.ch>
Date:   Thu, 4 Apr 2019 10:52:15 +0200
Message-ID: <CAKMK7uHiWu-kOa6SP0ZRstnrwdYR0MHgtHdHZPLWLXxWaQVPrQ@mail.gmail.com>
Subject: Re: [PATCH] drm/cirrus: rewrite and modernize driver.
To:     Gerd Hoffmann <kraxel@redhat.com>
Cc:     David Airlie <airlied@redhat.com>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        David Airlie <airlied@linux.ie>,
        open list <linux-kernel@vger.kernel.org>,
        "open list:DRM DRIVER FOR QEMU'S CIRRUS DEVICE" 
        <virtualization@lists.linux-foundation.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 4, 2019 at 10:30 AM Gerd Hoffmann <kraxel@redhat.com> wrote:
>
>   Hi,
>
> > > Speaking of wayland:  Seems at least gnome-shell insists on using XR24.
> >
> > Yeah XR24 is pretty much mandatory. Noralf added a few helpers to
> > convert XR24 to other formats, for display not supporting anything
> > else. Because userspace.
>
> Have a pointer to these helpers?  grepping around in drm didn't turn up
> anything so far ...

tinydrm_xrgb8888_to_*

imo these could be put into some drm_format_helpers.c to be shared.
From a quick look the xrgb8888_to_rgb888 is missing, but for a quick
hack you can just use rgb565 to get going.
-Daniel
-- 
Daniel Vetter
Software Engineer, Intel Corporation
+41 (0) 79 365 57 48 - http://blog.ffwll.ch
