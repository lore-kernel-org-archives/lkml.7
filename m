Return-Path: <SRS0=MEBR=WM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 48C85C3A59C
	for <linux-kernel@archiver.kernel.org>; Fri, 16 Aug 2019 10:07:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 10000206C1
	for <linux-kernel@archiver.kernel.org>; Fri, 16 Aug 2019 10:07:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YzQrFS+f"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727076AbfHPKH2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 16 Aug 2019 06:07:28 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:42893 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726948AbfHPKH2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Aug 2019 06:07:28 -0400
Received: by mail-pg1-f194.google.com with SMTP id p3so2710713pgb.9;
        Fri, 16 Aug 2019 03:07:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=04KU+vp+TtW5D7u8h60nYy+7caTX8b0wR5hO9DSGzTI=;
        b=YzQrFS+fytlAc0uVbBRv6JyaaRVNx6PvPNxKq8G5YWXyr1d8THyZhsxnb38URklet3
         EcEM/xXymuDDSzDDYUT5xp2wSVkoF+gLZnuCI6htSW+PU2PpvLUKdocV7i47hSRdY7AT
         2rzfO3o4N1URBNsC651go8G5Ocmyt9IgOoOFNlRXzBPc9nOH24jRS5IB5iVqi2N3CNd7
         3FC/dx57PWYgVibloijd3J8rfAInrur+1YRjQy/5O0Aylr+ZD9eA3sl/aRPb2BuLW1vf
         /NC4hgdtRuS+KTJAXxvDCh5tTSLu3Sqa4yBRek+ENer8m9rThCRP3f64+27SuxQJNa7B
         SUWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=04KU+vp+TtW5D7u8h60nYy+7caTX8b0wR5hO9DSGzTI=;
        b=X9tPx0RmsoRfmukY7ALGV17pJtA2M+6dkS6/3AHIGARl1RAEOapYHYK/Mz2tLZMerr
         kH/kTDSm0ZMozfBOvSunR5w5/h3jjKHRbrv9IjLMKKE+sl6MmTJOpYZQVc0nWyYamiYf
         tjqWERo6UQv/okf/CjF1Kwvi1MlNuXU+ady1gS+9fNGGZn/cC0I0oh4a45OWg4v7Iupq
         BhOrIf9SCyEb0J6qEqvNVS0lbxHV+IM1L8tiK9mq/YQBAbXuJ7sZBE17iBTJAzziRGI1
         UlNVwwMZsW1gZ+0/gn3dn2vdBmAJuQTE2SaExxShYLH9/2jf1enM3ewGcwC8aH13H28T
         +eaw==
X-Gm-Message-State: APjAAAWRqBb6XGY/dJ9qiJmL2N2b338xB1LOH2dW0LI7LqFHfM3+UGxt
        ahYMUXrYLj57YjwdTqmLtTBkkuJuu60dEdueHJ0c9Ukk
X-Google-Smtp-Source: APXvYqyHmk3MHs6a1rAxuf4xFb+k4ka2Yb+ud2qaN+6lrqc3xtXVgPLNOG2s+KniIgXOEThUO72RMCYMWnezbHPG6vQ=
X-Received: by 2002:aa7:9713:: with SMTP id a19mr10002122pfg.64.1565950047819;
 Fri, 16 Aug 2019 03:07:27 -0700 (PDT)
MIME-Version: 1.0
References: <1564081563-28322-1-git-send-email-info@metux.net>
 <CAHp75Vem8QZVGx6x0p3JgxA6kH3pG+1_zU=cgiDUDSC5p2ODDQ@mail.gmail.com> <0b2802f8-5732-52e9-0a95-b28d23239ecd@metux.net>
In-Reply-To: <0b2802f8-5732-52e9-0a95-b28d23239ecd@metux.net>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Fri, 16 Aug 2019 13:07:16 +0300
Message-ID: <CAHp75Ve2A+PhPYF7oN3LbWn5hb5gXO-6ox4tkDXMwAYJHS0=Kg@mail.gmail.com>
Subject: Re: [PATCH v2] platform/x86/pcengines-apuv2: use KEY_RESTART for
 front button
To:     "Enrico Weigelt, metux IT consult" <lkml@metux.net>
Cc:     "Enrico Weigelt, metux IT consult" <info@metux.net>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Darren Hart <dvhart@infradead.org>,
        Andy Shevchenko <andy@infradead.org>,
        Platform Driver <platform-driver-x86@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 5, 2019 at 3:06 PM Enrico Weigelt, metux IT consult
<lkml@metux.net> wrote:
> On 01.08.19 17:00, Andy Shevchenko wrote:
> > On Thu, Jul 25, 2019 at 10:06 PM Enrico Weigelt, metux IT consult
> > <info@metux.net> wrote:
> >> From: Enrico Weigelt <info@metux.net>

> >> Fixes: f8eb0235f65989fc5521c40c78d1261e7f25cdbe ("x86: pcengines apuv2 gpio/leds/keys platform driver")
> >
> > Please, use allowed minimum (12 nowadays) characters of hash.
>
> hmm, do you happen to know how to configure tig to show the short hash ?

I have configured '--oneline' to show 12.

-- 
With Best Regards,
Andy Shevchenko
