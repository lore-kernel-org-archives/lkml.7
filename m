Return-Path: <SRS0=1LW7=ZA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EED77FC6197
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Nov 2019 20:57:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C3718214DB
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Nov 2019 20:57:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kNF6VvOi"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728734AbfKHU5t (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 Nov 2019 15:57:49 -0500
Received: from mail-il1-f194.google.com ([209.85.166.194]:45416 "EHLO
        mail-il1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726394AbfKHU5t (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Nov 2019 15:57:49 -0500
Received: by mail-il1-f194.google.com with SMTP id o18so6314147ils.12;
        Fri, 08 Nov 2019 12:57:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=sBGIvYhrIEL6RFhCAu69k3QHdinoklQhCRr0O5tcB5A=;
        b=kNF6VvOitftFI3lrymy78Vk7RZhDVPIqAPfq+S6J/gVIGpm6PnpeCxpSB0h9GPNpJ5
         JzOSTN6yAIUDhLPJ7LajUw3Tn0qFGHV0rU/0JpJyLCT/YxHj3jXASfMmIeDMJ9KpyLez
         DfiWmKXuv2UOFbh2Bf1dfVbwZV+zapbDpiNrt4x+a4X9aCjbRWk2zbSlwqPajgszZyAX
         hsSIh/DGhIK7MsoPHk/RGK67XXfSz0krDNYqUFax8gV6UQaFN29UcRYAV+Seppn1ONvP
         CDiWuHoLtGu0X6luewz6tjXjHtKs62YNTNfxTOnYuKKYz0fSf8F/FvUxWnYqsSzS5+/c
         B64w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=sBGIvYhrIEL6RFhCAu69k3QHdinoklQhCRr0O5tcB5A=;
        b=j54GXdt2D5fPV0j6E/gtmp9AeREM3jcRP8/GSys62yQDCHWdEJWL6ixMrni/x8RpXd
         P42OiLcNZNl0PP2TpizSo0Uj0khXB75vM2qAiDz3vt8TlW0w+mpOID4eClkoYGu5IgR8
         5B9+u74gqTh2Fj8nuiJhJ/3UYjvyfQRN3i/EDEd3cktISAxS1IjTz7eX/mRZO0bEbEvY
         cZzmicuS35e5nT1V6MwHOoViDm9TW520Ia3wiFhdWgDhci373u8VKxDvMZmgSMv+GQSD
         LZqhdEfs941pGmmB0bJ9Ldt5Y49vwKZxP+UwGb57XCy1VUWhVIS8dQ+w9OL9YO5TPkQB
         WYwA==
X-Gm-Message-State: APjAAAXN9gCECgj0eG0PY9x2If3RPDjY/hsrUc+DCTD0AWQtKRuy4WIh
        XysNkkG/iXHDsmFloQI2f9Nl2EGuT55U3HbyNmQ=
X-Google-Smtp-Source: APXvYqw7GIabIvTm5tQMYJYQ1dvS+YptRetpY8Yhq1h8okxvRoTIRfgi4z+peKCgPjf2c+bVTSZafjP1oJiwPqsPbN0=
X-Received: by 2002:a92:ca8d:: with SMTP id t13mr14437206ilo.58.1573246668190;
 Fri, 08 Nov 2019 12:57:48 -0800 (PST)
MIME-Version: 1.0
References: <20191108200501.29864-1-aford173@gmail.com> <20191108204531.GN5610@atomide.com>
 <20191108205050.GO5610@atomide.com>
In-Reply-To: <20191108205050.GO5610@atomide.com>
From:   Adam Ford <aford173@gmail.com>
Date:   Fri, 8 Nov 2019 14:57:36 -0600
Message-ID: <CAHCN7xLVWf252Q44vtdBemNF8WXLZ61mfBO9Oc+WFGgVj60cFg@mail.gmail.com>
Subject: Re: [PATCH] thermal: ti-soc-thermal: Enable addition power management
To:     Tony Lindgren <tony@atomide.com>
Cc:     Linux-OMAP <linux-omap@vger.kernel.org>,
        "H. Nikolaus Schaller" <hns@goldelico.com>,
        Adam Ford <adam.ford@logicpd.com>,
        Eduardo Valentin <edubezval@gmail.com>,
        Keerthy <j-keerthy@ti.com>, Zhang Rui <rui.zhang@intel.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Amit Kucheria <amit.kucheria@verdurent.com>,
        linux-pm@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 8, 2019 at 2:50 PM Tony Lindgren <tony@atomide.com> wrote:
>
> * Tony Lindgren <tony@atomide.com> [191108 20:46]:
> > Also, you may want to check if the driver needs to
> > save and restore it's context in the notifier as that
> > might get lost during the off mode depending what
> > domain it's at.
>
> Oh never mind, looks like you already took care of
> saving and restoring the context in the notifier,
> I just missed it.

Great!

Is there any testing you can do and think we need on the OMAP4/5+ or
am33xx?  I don't have any of that hardware.

I'm readying a patch without the RFC shortly.

adam
>
> Thanks,
>
> Tony
