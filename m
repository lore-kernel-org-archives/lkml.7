Return-Path: <SRS0=5wok=UM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 53064C31E4B
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Jun 2019 15:22:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 36AEF2054F
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Jun 2019 15:22:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388899AbfFMPWN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Jun 2019 11:22:13 -0400
Received: from mail-qk1-f195.google.com ([209.85.222.195]:34414 "EHLO
        mail-qk1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731987AbfFMMnP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Jun 2019 08:43:15 -0400
Received: by mail-qk1-f195.google.com with SMTP id t8so8914930qkt.1
        for <linux-kernel@vger.kernel.org>; Thu, 13 Jun 2019 05:43:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=M1sFURB9VOBy4jtZMrXEnFN+uXQmeakOQ9D7hQoU5Oo=;
        b=T9EmV9kjsYqJ39gPZnIKbdvSuAT+EM3cAcG+cMogn6tPIRJFL3I5TUiZp3KOCvE76P
         +M1XJ/JvC+P77QYrdXQBoEgqs8Cpv0Fkr+1F3eYK+IGXcEwfD8Mh36soHovgSGZyFXyM
         NfVlG4daqbegTiBwC0B9MesxCBNuQLVVwEzq1DQ6aB1ZlMp5e6jDCasatrX3jrrII9x8
         v7QZsjIL80EJHNjXtUB2PmoBx4iqvoYmcoHm4gXvYnlv4M1Ta7bsijabv1ThSRxw6u0B
         UXBiYNEotxbaJ83Gbq+pO6jfxQcVtOicxAH9+U2Cpd8Ocm7dLOQjOCCz1kv+yCt9kKqy
         Sc2g==
X-Gm-Message-State: APjAAAUOcs/UEmcBiMKbSR17b+tzH52MHE7r8hpgHLdWlb/2HKtW6TDL
        hSr0PeZLUufLdeFl9uFpJ56LR1e7dqYzJv2JhcY=
X-Google-Smtp-Source: APXvYqx0GATfAKDHQiQUDbUvb9OL9pOZqSyQ28f3QUXB75XM3Ltr+LckmYh3837y9Za7XbZ5exY75L49164V4buSJ0g=
X-Received: by 2002:a05:620a:16c1:: with SMTP id a1mr27974065qkn.269.1560429794286;
 Thu, 13 Jun 2019 05:43:14 -0700 (PDT)
MIME-Version: 1.0
References: <c2e6af51-5676-3715-6666-c3f18df7b992@free.fr>
In-Reply-To: <c2e6af51-5676-3715-6666-c3f18df7b992@free.fr>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Thu, 13 Jun 2019 14:42:57 +0200
Message-ID: <CAK8P3a1_WvHYW243MR5-NdFm3cSt+cVGM5EJmOM8uiQMQ3vQjQ@mail.gmail.com>
Subject: Re: [PATCH v1] iopoll: Tweak readx_poll_timeout sleep range
To:     Marc Gonzalez <marc.w.gonzalez@free.fr>
Cc:     Matt Wagantall <mattw@codeaurora.org>,
        Mitchel Humpherys <mitchelh@codeaurora.org>,
        Will Deacon <will.deacon@arm.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Bjorn Helgaas <helgaas@kernel.org>,
        Douglas Anderson <dianders@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 13, 2019 at 2:16 PM Marc Gonzalez <marc.w.gonzalez@free.fr> wrote:
>
> Chopping max delay in 4 seems excessive. Let's just cut it in half.
>
> Signed-off-by: Marc Gonzalez <marc.w.gonzalez@free.fr>
> ---
> When max_us=100, old_min was 26 us; new_min would be 50 us
> Was there a good reason for the 1/4th?
> Is new_min=0 a problem? (for max=1)

You normally want a large enough range between min and max. I don't
see anything wrong with a factor of four.

> @@ -47,7 +47,7 @@
>                         break; \
>                 } \
>                 if (__sleep_us) \
> -                       usleep_range((__sleep_us >> 2) + 1, __sleep_us); \
> +                       usleep_range(__sleep_us / 2, __sleep_us); \
>         } \

You are also missing the '+1' now, so this breaks with __sleep_us=1.

        Arnd
