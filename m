Return-Path: <SRS0=FxTY=RO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F755C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Mar 2019 16:06:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2BBD72084F
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Mar 2019 16:06:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="uCwizerW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727641AbfCKQGE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Mar 2019 12:06:04 -0400
Received: from mail-lf1-f65.google.com ([209.85.167.65]:43411 "EHLO
        mail-lf1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726000AbfCKQGE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Mar 2019 12:06:04 -0400
Received: by mail-lf1-f65.google.com with SMTP id g7so2820501lfh.10;
        Mon, 11 Mar 2019 09:06:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=JNyhMnlDg9WEdIRIw0umsEvuQCRWeLX+PEwNVwlGL4c=;
        b=uCwizerWNy+yzBhHNvpKIJwYUlepq1+3IvmmtcEwqTitBdz3QcmX8pmW9u/Jv1z16z
         XH72BBfG/bk9LdOSp9zRJ/gKAax6cMAo1GRfFRtKx4G9Befz814r3yXY+a1BZg99NNmm
         8n4eb583vFHtLtnZYQygwKw5CXWM5+H4XCl/fXYtWLrqtzWplHiurBByHQbb0wWXEmfX
         q4HwS1r/g/YyXCta3FevPmGx7CCUN6ixdR2+Wdco3V3Y6xDvMO+DZhisRQlDtJRWjZMp
         2Pc3i1Y4aAExiPvtpD+C9HFMaM7XRGBPVbe27PzmMqTQLLeyFU3049oYss3zjw6cZ2Xc
         xo6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=JNyhMnlDg9WEdIRIw0umsEvuQCRWeLX+PEwNVwlGL4c=;
        b=gR05durq00dVkj/CsqISF2R0E4DOBd4Wu0Xej7GXg92oI8h1LfVTG3nYVLh0BPUbWf
         kouUhPhT9GC5EKNP50W/nRDajWbGamFUl2q4nkcw/7O/9t1KtuV0TRlSK/UI9r2vOoZW
         b/umm3GrNa78FrFj5OJPMWg6sCD/UOJ0MUWQWF072GUF8EEuJgTNgsaJZVTWdb2OD/5Q
         jEC9yZ0bi39YwbIwpt8Q52BD3Bxvs0BPpb4wbawzzLuSrVeHcYf/SZH2+n6q2XFerhsM
         DW4BKsvW+Von6h257V2JoKy1Xnn/IT6u6voWif8XtPhfeEdLJ5W3xPGvaiNEZMjPRBiK
         7yOQ==
X-Gm-Message-State: APjAAAV1qzSUTT8bm2jJzvAnFeD4Is9i3Pqf/9/2yKddfwUEewL1XZz5
        xZEjV8PPwGmI4T9+7mGM2g5PcWoWrRXHQbI1eyg=
X-Google-Smtp-Source: APXvYqzlfpYTidxiZZAcMWrjIDa9kvGdIKKNPa2f4ZKGeUX7rxX+yW01yuCiaJc81ZLKrzmfph5xCwmSIqw0QArREWg=
X-Received: by 2002:a19:2d44:: with SMTP id t4mr17433882lft.90.1552320362100;
 Mon, 11 Mar 2019 09:06:02 -0700 (PDT)
MIME-Version: 1.0
References: <5c8682ef.1c69fb81.5a1ea.2e7f@mx.google.com>
In-Reply-To: <5c8682ef.1c69fb81.5a1ea.2e7f@mx.google.com>
From:   Souptick Joarder <jrdr.linux@gmail.com>
Date:   Mon, 11 Mar 2019 21:35:50 +0530
Message-ID: <CAFqt6zY2uWNke8JmyEiS+yiXLC43ZQA_wpv=YgCj-cHbBPXp0A@mail.gmail.com>
Subject: Re: [PATCH] arch/sh/boards/mach-dreamcast/irq.c: Remove duplicate header
To:     Sabyasachi Gupta <sabyasachi.linux@gmail.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Yoshinori Sato <ysato@users.sourceforge.jp>,
        Rich Felker <dalias@libc.org>, linux-sh@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 11, 2019 at 9:16 PM Sabyasachi Gupta
<sabyasachi.linux@gmail.com> wrote:
>
> Remove  linux/irq.h which is included more than once.
>
> Signed-off-by: Sabyasachi Gupta <sabyasachi.linux@gmail.com>

Acked-by : Souptick Joarder <jrdr.linux@gmail.com>

> ---
>  arch/sh/boards/mach-dreamcast/irq.c | 1 -
>  1 file changed, 1 deletion(-)
>
> diff --git a/arch/sh/boards/mach-dreamcast/irq.c b/arch/sh/boards/mach-dreamcast/irq.c
> index 2789647..69fa91c 100644
> --- a/arch/sh/boards/mach-dreamcast/irq.c
> +++ b/arch/sh/boards/mach-dreamcast/irq.c
> @@ -10,7 +10,6 @@
>   */
>  #include <linux/irq.h>
>  #include <linux/io.h>
> -#include <linux/irq.h>
>  #include <linux/export.h>
>  #include <linux/err.h>
>  #include <mach/sysasic.h>
> --
> 2.7.4
>
