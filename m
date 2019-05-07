Return-Path: <SRS0=RyeP=TH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 933B2C004C9
	for <linux-kernel@archiver.kernel.org>; Tue,  7 May 2019 17:59:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 685FF2054F
	for <linux-kernel@archiver.kernel.org>; Tue,  7 May 2019 17:59:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="SJsG8hMi"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727577AbfEGR7r (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 May 2019 13:59:47 -0400
Received: from mail-ua1-f67.google.com ([209.85.222.67]:43206 "EHLO
        mail-ua1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726545AbfEGR7q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 May 2019 13:59:46 -0400
Received: by mail-ua1-f67.google.com with SMTP id 94so4098633uaf.10
        for <linux-kernel@vger.kernel.org>; Tue, 07 May 2019 10:59:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=erYdJxIPox6sV/Bs4ocyYAGH0EzEi1bZw38BN9dh4mg=;
        b=SJsG8hMiPuUX5vZRJ32cUgkrqQGCuurTTXLZTPAVZYgIvxlKCuqCjtqPXXYocJTAYT
         2vTDF00bAW8tEJ5n4KcrBDi5dBuA+rlZ3pB7ovwYwYkHcjj8dct/DcYduXfYd1WatRjH
         UifQVUqQIzvJZWPNo9tkM3Q/cExzJhPKWZfMc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=erYdJxIPox6sV/Bs4ocyYAGH0EzEi1bZw38BN9dh4mg=;
        b=QObJEu+kRiRFnpaR/7QExwukjeXQbJMuLQ9prbL5OxOjDtE0kjzJziBWnR2XEvL8F3
         xDG39ZTdM2/xaHQx5WojH9cVmUTC3DsnftP106RFon+C4GsPT53ueOtI2sAsjJ6Rch6N
         2ElGFCjfKlZx+DxQLaJy41D9KIq+E/UEwm9wB3CYdTQKIQgE0Hpul+xq4nmHZE1T/pRv
         vJg93XU0QRNPRMgthgaojnJvHmMF36srk1iasgAH9/a843tQ5y405CPPXxuAbhQ8fA2S
         2p3AS7vw9kEkVrWRRpoegsqozFjMldu6StM+lucKWsbF31EOAEeFT9p2Rr9JqxFyo05c
         ca+w==
X-Gm-Message-State: APjAAAVWVtYi5Dy4KlJYD5YxmQbU3t7Vu2mlQ3Kxqk62ANDtVuMj33Ce
        5I6uhOlkp5+kxumi+8V57wjRCIOjGJw=
X-Google-Smtp-Source: APXvYqwYu5i7CakzcvIySRdzsop8CRV5pgNIl/xjxDqg1uh4k8l6DqiYODPlPXVKmEwQPKIOSa0hmw==
X-Received: by 2002:ab0:64d2:: with SMTP id j18mr17361059uaq.127.1557251985535;
        Tue, 07 May 2019 10:59:45 -0700 (PDT)
Received: from mail-vs1-f51.google.com (mail-vs1-f51.google.com. [209.85.217.51])
        by smtp.gmail.com with ESMTPSA id 131sm799346vko.44.2019.05.07.10.59.44
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
        Tue, 07 May 2019 10:59:44 -0700 (PDT)
Received: by mail-vs1-f51.google.com with SMTP id w13so10969239vsc.4
        for <linux-kernel@vger.kernel.org>; Tue, 07 May 2019 10:59:44 -0700 (PDT)
X-Received: by 2002:a67:af10:: with SMTP id v16mr11808347vsl.149.1557251984138;
 Tue, 07 May 2019 10:59:44 -0700 (PDT)
MIME-Version: 1.0
References: <20190507044801.250396-1-dianders@chromium.org> <a3573253-e3de-0a82-8af3-6bacea20bd97@gmail.com>
In-Reply-To: <a3573253-e3de-0a82-8af3-6bacea20bd97@gmail.com>
From:   Doug Anderson <dianders@chromium.org>
Date:   Tue, 7 May 2019 10:59:31 -0700
X-Gmail-Original-Message-ID: <CAD=FV=UAFUH12DbA++HML75E55BCttpNBxe9t-VEQvGjGx0=Wg@mail.gmail.com>
Message-ID: <CAD=FV=UAFUH12DbA++HML75E55BCttpNBxe9t-VEQvGjGx0=Wg@mail.gmail.com>
Subject: Re: [PATCH] of: Add dummy for of_node_is_root if not CONFIG_OF
To:     Frank Rowand <frowand.list@gmail.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        "open list:ARM/Rockchip SoC..." <linux-rockchip@lists.infradead.org>,
        Julius Werner <jwerner@chromium.org>,
        Guenter Roeck <groeck@chromium.org>,
        Brian Norris <briannorris@chromium.org>,
        devicetree@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,


On Tue, May 7, 2019 at 10:52 AM Frank Rowand <frowand.list@gmail.com> wrote:
>
> On 5/6/19 9:48 PM, Douglas Anderson wrote:
> > We'll add a dummy to just return false.
>
> A more complete explanation of why this is needed please.
>
> My one guess would be compile testing of arch/sparc/kernel/prom_64.c
> fails???

Ah, sorry.  Needed for:

https://lkml.kernel.org/r/CAD=FV=Vxp-U7mZUNmAAOja5pt-8rZqPryEvwTg_Dv3ChuH_TrA@mail.gmail.com



-Doug
