Return-Path: <SRS0=6YJq=VW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4DF9AC76190
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Jul 2019 17:58:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2D4E622BE8
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Jul 2019 17:58:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pLWb8Ybf"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728287AbfGYR64 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Jul 2019 13:58:56 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:37743 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726432AbfGYR6z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Jul 2019 13:58:55 -0400
Received: by mail-pf1-f196.google.com with SMTP id 19so23132334pfa.4;
        Thu, 25 Jul 2019 10:58:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=EcbsdgPjPxknJYKkO+mmuPOpVmHnp8WiVb7FywqYwjg=;
        b=pLWb8Ybf6p6AINE/Tdedy/fPEWySwUCrqiOaullsWbXTwPvWJNDPUDuiLyuaeqdPl2
         Tja42m2lpthvgCBUg3vB+siLXguL4TxbnQvCCa9JUzWh3IjkMSu78hir5+dxUQPURUch
         waYSuuhJ/1VaYy1MqDgFGdCeDkmf6BTEeQef/9/5cJCzYyBXYroUgocT5unH1zf/Y+ti
         m97wLUmcz9VC9bWK2EcJ7vDV6S2XFIpURzLpgx8xhKyka35NyR0vqts6PBf+Af/n0feU
         jNqcK035dt+IbCWfOPrmuhX57k+TNyHJKdqCXGFUe6tRVrwYocCmH5EUIiaB1o4tT9EF
         gouA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=EcbsdgPjPxknJYKkO+mmuPOpVmHnp8WiVb7FywqYwjg=;
        b=Ju/RS+OHVaXNh0mY15NFpIMs6o78ilK1YHkHCJ+RrJHYSBOJW+vjs2gjBKPf0IYMwh
         XUL/r/qC+14CuU/gbGsvWcj9qYXMdc3XMbeIwR7JTwJljxIJn0fpYJqnSgiUtwKeSsMI
         r7tlcUntuOwq0JGLtDbmAfT90yWSV+eRxULVkD8FmjRKigJ4VtR3o/c3+cxiUGYqyFMQ
         pg0FMpQL2v/cLYabY0IAcL2ZjbPW5PCzcgcMf9Ym6si+ZSyxevGzvyxq1xk5j+5biSla
         pctYkzSvtjoaalsBosN5/sSk+lg65nbLRMBstUi8PeVK+/QQNcFNhfes4Acj/NFsQ3bh
         ssXw==
X-Gm-Message-State: APjAAAVSPhdDM6xl1eGgag7DFLUVkpGZ9aELrTVFPObGv8RXPfRkR8DZ
        96tnth16SSRH0XKE0Z6xfxVY3B89i9NWGZ+sYZmAh1ky
X-Google-Smtp-Source: APXvYqyN0erH9siXVeIm9awtwpitcLsB2EqG7BsgEEtQTTANapqojgKu6xjwncNfk04+wAhB8I2p5pEvqaS6XOUtIUU=
X-Received: by 2002:a63:e54f:: with SMTP id z15mr87139832pgj.4.1564077534693;
 Thu, 25 Jul 2019 10:58:54 -0700 (PDT)
MIME-Version: 1.0
References: <20190722031158.70311-1-skunberg.kelsey@gmail.com>
In-Reply-To: <20190722031158.70311-1-skunberg.kelsey@gmail.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Thu, 25 Jul 2019 20:58:43 +0300
Message-ID: <CAHp75Vc4qSNs6Kx6BdO163fi=fYNfPNHy+m3XVpO5v755pu2DA@mail.gmail.com>
Subject: Re: [PATCH] platform: x86: Remove acpi_has_method() call in wmi.c
To:     Kelsey Skunberg <skunberg.kelsey@gmail.com>
Cc:     Darren Hart <dvhart@infradead.org>,
        Andy Shevchenko <andy@infradead.org>,
        Platform Driver <platform-driver-x86@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        bjorn@helgaas.com, "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Shuah Khan <skhan@linuxfoundation.org>,
        linux-kernel-mentees@lists.linuxfoundation.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 22, 2019 at 6:13 AM Kelsey Skunberg
<skunberg.kelsey@gmail.com> wrote:
>
> acpi_has_method() is unnecessary within __query_block() and should be
> removed to avoid extra work.
>
> wc_status is initialized to AE_ERROR before the acpi_has_method() call.
> acpi_has_method() and acpi_execute_simple_method() failing due to the
> method not existing will result in the same outcome from __query_block().
>

Pushed to my review and testing queue, thanks!

> Signed-off-by: Kelsey Skunberg <skunberg.kelsey@gmail.com>
> ---
>  drivers/platform/x86/wmi.c | 4 +---
>  1 file changed, 1 insertion(+), 3 deletions(-)
>
> diff --git a/drivers/platform/x86/wmi.c b/drivers/platform/x86/wmi.c
> index 784cea8572c2..59e9aa0f9643 100644
> --- a/drivers/platform/x86/wmi.c
> +++ b/drivers/platform/x86/wmi.c
> @@ -340,9 +340,7 @@ static acpi_status __query_block(struct wmi_block *wblock, u8 instance,
>                  * expensive, but have no corresponding WCxx method. So we
>                  * should not fail if this happens.
>                  */
> -               if (acpi_has_method(handle, wc_method))
> -                       wc_status = acpi_execute_simple_method(handle,
> -                                                               wc_method, 1);
> +               wc_status = acpi_execute_simple_method(handle, wc_method, 1);
>         }
>
>         strcpy(method, "WQ");
> --
> 2.20.1
>


-- 
With Best Regards,
Andy Shevchenko
