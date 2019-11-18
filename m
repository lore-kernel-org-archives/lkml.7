Return-Path: <SRS0=CA45=ZK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9A13C432C0
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Nov 2019 03:23:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 87BE6206D3
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Nov 2019 03:23:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=endlessm-com.20150623.gappssmtp.com header.i=@endlessm-com.20150623.gappssmtp.com header.b="xVzDLpTe"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726690AbfKRDXn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 17 Nov 2019 22:23:43 -0500
Received: from mail-qk1-f194.google.com ([209.85.222.194]:40262 "EHLO
        mail-qk1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726266AbfKRDXn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 17 Nov 2019 22:23:43 -0500
Received: by mail-qk1-f194.google.com with SMTP id z16so13210962qkg.7
        for <linux-kernel@vger.kernel.org>; Sun, 17 Nov 2019 19:23:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=endlessm-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Z/WWVtJiMHUrRDu47kJ1UrISL3WhpKZ+7R1m8ty1A4M=;
        b=xVzDLpTe30ifpZKIstj89kf608mwe33D7oh+AM0D8jmCBvsdc3XKDhdBt0mgdAhbc+
         /U54ACogQkHH2eGNpEaK+E83hB34scLPxk3s/T6SsH1RdlgnXhwRvFDGleslzQeR2ZsT
         PFkWX6UjBr73JvfAoUMI6ZbqETw3ChGLAZNK1ZaJbIXohUUhFX72eqkyTA8ehQq9MwID
         iAm0J8rY8HdpflMWYs+hZn94nEGz2J9dck2Q0yJgOGdzvo/DzK95sL+2jrL1ELB6Mm2Z
         9+92w1uppdmWv6m7/kMWARJRFlTX+9zNBbPSNYKPMAGloorZdIz1BG/BIIIUDKAachb5
         /wZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Z/WWVtJiMHUrRDu47kJ1UrISL3WhpKZ+7R1m8ty1A4M=;
        b=Q3bReOsDXrXYgIekWhow8nWvHtDUIHEDS/WKuyIF7+sFGwVu5rMVZi5z4mUquf5JO4
         7vYwfPqW1gZ64/Yd6Qflpp3823344AqJl7GBPw+1o5Na0RiPe8U/+U/GCMMb5ASTfLjc
         gW2VyuEQvk9wzzfDAtJcizwkFV0IqHzzZGZnMXXo+pJ+QovSKZone6PNSloWOt8p7OSX
         UL6gpQDwFywhEsnQLQQz9HI1HZ7CQPfSp2erXEqYhbiYFeV++5z0SPLAzwmhgh2Tot5Q
         31648u+TSYhV0jw0ZX5HxpS641CjxwjOs4ICWH6Z4Mn1gHvv/VO96ORlBZum6Kqfgdgv
         ouvw==
X-Gm-Message-State: APjAAAU1LBSDT41VNiHWwsnseoeu9+Q7ZgOZYy67pznRaxW7AIK4qHvP
        Ki5TaLzoGyHMv2uNTL2QbLiNcpufzqRjOshkHPr9Wg==
X-Google-Smtp-Source: APXvYqxavYdgZDzCU3SkD+tXQK6wOU0KmNcr0ZNhN+PD+7FZ5HbApP+ux3kn4eUQ4wmdtbLwX9IqDXsPQy6K2cY4Nhs=
X-Received: by 2002:a05:620a:12c3:: with SMTP id e3mr22273021qkl.14.1574047421962;
 Sun, 17 Nov 2019 19:23:41 -0800 (PST)
MIME-Version: 1.0
References: <CAPW-Pu0KuxqbKSQ2JQaxh5AHbdZdNQZJfOgxoe_XZSxow+9e3A@mail.gmail.com>
 <CAPW-Pu2g3yiD8H5yUhAsCCN0vMzojoQ6QOn+4iOKCzHizE4T4A@mail.gmail.com>
In-Reply-To: <CAPW-Pu2g3yiD8H5yUhAsCCN0vMzojoQ6QOn+4iOKCzHizE4T4A@mail.gmail.com>
From:   Daniel Drake <drake@endlessm.com>
Date:   Mon, 18 Nov 2019 11:23:31 +0800
Message-ID: <CAD8Lp46Sx004FiZm+1Lus_KBafCAvP5tdnRpE+NEkoEMWNz+jg@mail.gmail.com>
Subject: Re: [RFC PATCH 2/3] platform/x86: asus_wmi: Support fan boost mode on FX505DY/FX705DY
To:     Leon Maxx <leonmaxx@gmail.com>
Cc:     Linux Kernel <linux-kernel@vger.kernel.org>,
        Platform Driver <platform-driver-x86@vger.kernel.org>,
        acpi4asus-user <acpi4asus-user@lists.sourceforge.net>,
        Andy Shevchenko <andy@infradead.org>,
        Darren Hart <dvhart@infradead.org>,
        Corentin Chary <corentin.chary@gmail.com>,
        Yurii Pavlovskyi <yurii.pavlovskyi@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 4, 2019 at 6:55 PM Leon Maxx <leonmaxx@gmail.com> wrote:
>
> On ASUS FX505DY/FX705DY laptops fan boost mode is same as in other
> TUF laptop models but have different ACPI device ID and different key
> code.

In the spec (which is not publically available, sorry), this
0x00120075 device is described as "Throttle thermal policy" which
takes values 0 for default, 1 for overboost, 2 for silent.

I don't know exactly how this differs from "fan boost" but I suggest
mirroring the spec here, offer this as a separate sysfs control named
according to the spec, separate it from fan boost mode.

Thanks,
Daniel
