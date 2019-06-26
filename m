Return-Path: <SRS0=hRvo=UZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DF6F2C48BD3
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Jun 2019 17:20:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A949E208E3
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Jun 2019 17:20:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="EeSbNL2D"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726614AbfFZRUy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Jun 2019 13:20:54 -0400
Received: from mail-lj1-f193.google.com ([209.85.208.193]:42882 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726179AbfFZRUy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jun 2019 13:20:54 -0400
Received: by mail-lj1-f193.google.com with SMTP id t28so3013933lje.9
        for <linux-kernel@vger.kernel.org>; Wed, 26 Jun 2019 10:20:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=FqE4LHsGkKEVxaQZwsQWP1LvUupRRHYnoysI8iQOlig=;
        b=EeSbNL2DHmNMRBZwdUCCw378VR05rGZdqNvvcrBIvHDQPcN2pzDeu2Nk9yCwOoEb5b
         VV9KnumlSW+U8yuBbCA/xY86wYLSTndcPLQPSlL346PbE4EjaCqMCAxFfc/PoAZlP7YO
         m9wj/3uVrEw1yfN5hB77xWeBJfGLGpUO4XUsI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=FqE4LHsGkKEVxaQZwsQWP1LvUupRRHYnoysI8iQOlig=;
        b=ZMvGt8U1XWXIlcAfhsxhqtdwK6OeiEz1WQqhf3B88NBJ0I/KUHRfDBgpJ/ewUBOAlz
         9qRcU16dbgy8Hwu3Y7Oj01UfiwEN+VVZXF2MhiKMUrq4osdxUvjJpQ2Tp9JWXS8UFn+8
         HkSH2HLf/cJYpXWtt9KrruQiTP298Hu02r5M7wWUZ+Tap9Mn952L3el0eBc6zGcp+S9k
         1SJASu+OcwgVzThlQlrWmaW9JjUeFI3tjLDsGP3tP956XkoPvYOA9J+JsrfLhecAf6fS
         e+JnctXmRGmDSHPm75Q6Biap5VETNp1zhvUq/JeP5366N1o8AFR+gHuSJW3C4FlMvK3i
         VBhA==
X-Gm-Message-State: APjAAAWskw1Z39XFOFZU4XGs1zq1wGEPHwALHJ54PAtHxMgB/n/Kh+73
        f3iXXx3CQ5Uf4O5rd5fPkkvMIy6uvdA=
X-Google-Smtp-Source: APXvYqx4v76OJPx/4inEXmOLVSfgwVztMyutW36fRDGVuhxpoXC3AlkUeRKZCsIk88ko8KsjfG8A+Q==
X-Received: by 2002:a2e:6d02:: with SMTP id i2mr3622915ljc.124.1561569651910;
        Wed, 26 Jun 2019 10:20:51 -0700 (PDT)
Received: from mail-lj1-f175.google.com (mail-lj1-f175.google.com. [209.85.208.175])
        by smtp.gmail.com with ESMTPSA id k4sm2928126ljg.59.2019.06.26.10.20.49
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
        Wed, 26 Jun 2019 10:20:49 -0700 (PDT)
Received: by mail-lj1-f175.google.com with SMTP id a21so3027599ljh.7
        for <linux-kernel@vger.kernel.org>; Wed, 26 Jun 2019 10:20:49 -0700 (PDT)
X-Received: by 2002:a2e:970d:: with SMTP id r13mr3653860lji.126.1561569648710;
 Wed, 26 Jun 2019 10:20:48 -0700 (PDT)
MIME-Version: 1.0
References: <alpine.DEB.2.21.1906182228350.1766@nanos.tec.linutronix.de>
In-Reply-To: <alpine.DEB.2.21.1906182228350.1766@nanos.tec.linutronix.de>
From:   Evan Green <evgreen@chromium.org>
Date:   Wed, 26 Jun 2019 10:20:12 -0700
X-Gmail-Original-Message-ID: <CAE=gft6=TPF9xYmVbzR2WQJ8LDQjPm_cZ17cyHaPrh-K9UCgHA@mail.gmail.com>
Message-ID: <CAE=gft6=TPF9xYmVbzR2WQJ8LDQjPm_cZ17cyHaPrh-K9UCgHA@mail.gmail.com>
Subject: Re: [PATCH] x86/microcode: Fix the microcode load on CPU hotplug for real
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     LKML <linux-kernel@vger.kernel.org>, x86@kernel.org,
        Borislav Petkov <bp@alien8.de>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 18, 2019 at 1:31 PM Thomas Gleixner <tglx@linutronix.de> wrote:
>
> A recent change moved the microcode loader hotplug callback into the early
> startup phase, which is running with interrupts disabled. It missed that
> the callbacks invoke sysfs functions which might sleep causing nice 'might
> sleep' splats with proper debugging enabled.
>
> Split the callbacks and only load the microcode in the early startup phase
> and move the sysfs handling back into the later threaded and preemptible
> bringup phase where it was before.
>
> Fixes: 78f4e932f776 ("x86/microcode, cpuhotplug: Add a microcode loader CPU hotplug callback")
> Signed-off-by: Thomas Gleixner <tglx@linutronix.de>

I ran into the bug fixed by this. For 4.19:
Tested-by: Evan Green <evgreen@chromium.org>
