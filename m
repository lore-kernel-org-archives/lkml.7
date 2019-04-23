Return-Path: <SRS0=LehB=SZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0E61C10F11
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Apr 2019 03:06:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BC27A206BA
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Apr 2019 03:06:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=endlessm-com.20150623.gappssmtp.com header.i=@endlessm-com.20150623.gappssmtp.com header.b="YjSoeKBW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731298AbfDWDGt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 22 Apr 2019 23:06:49 -0400
Received: from mail-qt1-f195.google.com ([209.85.160.195]:44878 "EHLO
        mail-qt1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728527AbfDWDGt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Apr 2019 23:06:49 -0400
Received: by mail-qt1-f195.google.com with SMTP id s10so3720397qtc.11
        for <linux-kernel@vger.kernel.org>; Mon, 22 Apr 2019 20:06:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=endlessm-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=iCDEEjaXFN2ttbzzYVmz/c+842djhuXLkuUAp4+5DKk=;
        b=YjSoeKBWJEPWfxHSo+UsMp7qTB0PdsBkOtCvHq4zFY0IrPa5vOPy8ywxS7QSjyShWc
         Ol1vf1qT4sbjel1DHXiEabJQOgcVwR9CkrWr7tCuc8q2HB9voTU/odLAZuCoLd9ou5bO
         3X3b+QPB9Y71pejtNWb6E7QBm5oDbXfnKxy1A8094TMuBg/bzdeHpIIcMvQYkxEfO5Z7
         OPgdZqx7hPVB7sPbMZnQCi8J70GjcpiLIK2mP5WVeOHC6PYwfCjztPOgV+Ui3idkSwP+
         lpG7KbVIFVOFEr1inbqFRgw/wnlVe44B7yVRAuofuPXOclQIWX8xCgfN7nK0wlpRvMSV
         kEZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=iCDEEjaXFN2ttbzzYVmz/c+842djhuXLkuUAp4+5DKk=;
        b=ISvZUDAt/v3A2mazBUmV+uh0jhYf1FopAvfS2OCO+UgfGeF6k/FU0r/aZWKRjy0gxu
         5M2hxtmXnJSj08WdBeX3S0mAZDVk89qHektwoIccJhFBXlM24IZG32voC3QTEkD1m+z7
         FdNElmiBKZuv8TfISUfAJopeOSy25L7u2ObFinxPLo7EfR1nDAlRChp920+v8wWOl2UT
         cBwWbwC2O+56IVT9111foXQBq8vRZh5lCBHQw5x2NE5F5dHjge/0yxUv9VpbjCh7kn1s
         AQZWihBw2eMJQYuF+0CdZlEZbsUqu4IcTYQ6vBrtM3dUno2BTbIRLHOCpkDPHvwHrQnL
         DAsQ==
X-Gm-Message-State: APjAAAXQgbxCchSMDL/heMBtcdyInxGaQrMBR7IlMNzuTCUP/ipwG0zk
        dJI2v83UuYNhlo1pOvoDi5uEDTbE9FD8b65YO8figg==
X-Google-Smtp-Source: APXvYqw3QN4fdcahkmWRd3eiPHDnyQvQxSomciYSxglXJVyK9h8vW7PZoSrjc0BNIged1MRYSKTA4U34in9osD7WdOc=
X-Received: by 2002:a0c:9945:: with SMTP id i5mr18382547qvd.159.1555988807902;
 Mon, 22 Apr 2019 20:06:47 -0700 (PDT)
MIME-Version: 1.0
References: <20190422101526.28415-1-drake@endlessm.com> <20190422101526.28415-2-drake@endlessm.com>
 <20190422120451.GA9499@gmail.com>
In-Reply-To: <20190422120451.GA9499@gmail.com>
From:   Daniel Drake <drake@endlessm.com>
Date:   Tue, 23 Apr 2019 11:06:36 +0800
Message-ID: <CAD8Lp44ZaifPf+809BzbLg=9ijsRsE=7JMVpXkqRenY9radpZA@mail.gmail.com>
Subject: Re: [PATCH 2/2] x86/tsc: set LAPIC timer frequency to crystal clock frequency
To:     Ingo Molnar <mingo@kernel.org>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        hpa@zytor.com, x86@kernel.org,
        Linux Kernel <linux-kernel@vger.kernel.org>,
        Len Brown <len.brown@intel.com>,
        "Wysocki, Rafael J" <rafael.j.wysocki@intel.com>,
        Linux Upstreaming Team <linux@endlessm.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 22, 2019 at 8:04 PM Ingo Molnar <mingo@kernel.org> wrote:
> Minor style nit: the parentheses are unnecessary, integer expressions
> like this are evaluated left to right and multiplication and division has
> the same precedence.

Fair point, although the same could be said for cpu_khz_from_msr().

> But it might also make sense to actually store crystal_mhz instead of
> crystal_khz, because both CPUID 15H and 16H provides MHz values.
>
> That way the above expression would simplify to:
>
>         lapic_timer_frequency = crystal_mhz / HZ;

Wouldn't it be
        lapic_timer_frequency = crystal_mhz * 1000000 / HZ;
?

Thanks
Daniel
