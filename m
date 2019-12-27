Return-Path: <SRS0=GVTe=2R=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 07BDFC2D0DA
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Dec 2019 12:06:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C931A20CC7
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Dec 2019 12:06:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="X98BOIzu"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727072AbfL0MGt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 27 Dec 2019 07:06:49 -0500
Received: from mail-il1-f196.google.com ([209.85.166.196]:37355 "EHLO
        mail-il1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726923AbfL0MGs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Dec 2019 07:06:48 -0500
Received: by mail-il1-f196.google.com with SMTP id t8so22326956iln.4
        for <linux-kernel@vger.kernel.org>; Fri, 27 Dec 2019 04:06:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=WmfgYIlZWxDaZizS0/2PUuLY/qX43M07m582qEI148o=;
        b=X98BOIzumlFPEjdZ9sUuhS3iBBqL1VUK/pjvCrlYXSS/VMjrahfV6GK8V4NLfCKstl
         FcnTl8ezBueGukai4CUwLYopsLt6rhnipVOq02y3UOM+V7ta4pYmlEnbudPT6SoSqQ0Q
         Juv11hh4tpO9NcgZfbm1TSYgDn5hSdsHO8H24=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=WmfgYIlZWxDaZizS0/2PUuLY/qX43M07m582qEI148o=;
        b=COM9PcabyhwubS/J9GU3Pr2lNVKPjGGQZtoIE8OEDq+mpQHCdg4yXx1MLwBxTj99Ok
         kZxm8jVMIM0lt4xWCXeV6DtvjMu6b0gxI4/3MYqHs4faSuvzAlDCeRpL1bPgF2Fo1IxI
         tUL9vMbyfECohFS+hhlGGj+wyu92PB8bnJEfSca0g/tqeTG9C5QO4IHtux4ByedXsQLO
         ijt9b+BiSV3pM2uB0//TlRiSgcpS0LCWncJ/c+J8etWnnsTG56VeT+opLIfSUSOTCWP3
         H+WtYUEghVcBk4zTzkjnFbbtxT6m+Objp0B+sM+XNNmTG4SahrWuQ5VYj6QcpRjaPS4o
         eiRQ==
X-Gm-Message-State: APjAAAXezsBIk04N9+G0NByFDsjI/fycL4Lhy6JHJQfc/3EfD+22n1nD
        Uq4zPO3L1zuYtor3Ft5vhwq6ivcO9rwZkNWfB0uXGQ==
X-Google-Smtp-Source: APXvYqz0avfFPQ7KqEa1gHijLD//RP3wLx7cUiHD8+e66tZOfTYRzPwEjDOnRq8Z7uRAutkXR/PIyTrnPMOIPxZ6x2s=
X-Received: by 2002:a92:860f:: with SMTP id g15mr42716158ild.297.1577448407609;
 Fri, 27 Dec 2019 04:06:47 -0800 (PST)
MIME-Version: 1.0
References: <20191222132229.30276-1-jagan@amarulasolutions.com> <20191226093952.i2jttp7tr5hie6jl@hendrix.home>
In-Reply-To: <20191226093952.i2jttp7tr5hie6jl@hendrix.home>
From:   Jagan Teki <jagan@amarulasolutions.com>
Date:   Fri, 27 Dec 2019 17:36:36 +0530
Message-ID: <CAMty3ZA9VBj6OxaLYE21Qt01nnTYGhsS8c2JHc5esDMeWe0qYw@mail.gmail.com>
Subject: Re: [PATCH v14 0/7] drm/sun4i: Allwinner A64 MIPI-DSI support
To:     Maxime Ripard <mripard@kernel.org>
Cc:     Chen-Yu Tsai <wens@csie.org>, David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Michael Trimarchi <michael@amarulasolutions.com>,
        Icenowy Zheng <icenowy@aosc.io>,
        linux-sunxi <linux-sunxi@googlegroups.com>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        devicetree <devicetree@vger.kernel.org>,
        linux-amarula <linux-amarula@amarulasolutions.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 26, 2019 at 3:08 PM Maxime Ripard <mripard@kernel.org> wrote:
>
> On Sun, Dec 22, 2019 at 06:52:22PM +0530, Jagan Teki wrote:
> > This is v14 version for Allwinner A64 MIPI-DSI support
> > and here is the previous version set[1]
>
> I applied the patches 1 to 6, and fixed checkpatch warnings in the
> patch 5. Make sure to run it before sending patches.

Looks like I missed this time, sorry but usually I would do. Thanks.
