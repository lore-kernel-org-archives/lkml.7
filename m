Return-Path: <SRS0=SjSX=S5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6567BC43219
	for <linux-kernel@archiver.kernel.org>; Sat, 27 Apr 2019 20:02:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 292A12064A
	for <linux-kernel@archiver.kernel.org>; Sat, 27 Apr 2019 20:02:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="QYGEcdnS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726150AbfD0UCh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 27 Apr 2019 16:02:37 -0400
Received: from mail-ot1-f68.google.com ([209.85.210.68]:42455 "EHLO
        mail-ot1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726030AbfD0UCh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 27 Apr 2019 16:02:37 -0400
Received: by mail-ot1-f68.google.com with SMTP id f23so5480708otl.9;
        Sat, 27 Apr 2019 13:02:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=+DipmFp1I1M/+PsE+4WOzewTntx09YJZcDX8IcIeWLI=;
        b=QYGEcdnSBmMm7z7gJVr+Xlwl1NYqmWnEJqZWsU83NADpAN+7o1ub4UeyREQJyr0sjp
         1goWQ0mLzMv1A7cFcDzpiB4mLPf7UtxCA04sWAxw7ztvqPOB5KOyeP8fZXaqb+HsGoOL
         3u+Z0G4GUOtFqTWHnJYgwEtILHsP/2nxmhcxqM0Zsa/aZwwnjO33am1JzGEEDM4WMeD2
         FdPHoEnETQvYYPMEVtccOJ1GXolJNug1KFNqb3gcxWO2WCH9OSUxUMMe16l69FAYxzIb
         atNRN1TGQNUn9MQy2x5Yetr84FBW6FXPNUMuDTq6SPSfvLY+4nZ+EbP7rqob6xtI9c2a
         Ay8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=+DipmFp1I1M/+PsE+4WOzewTntx09YJZcDX8IcIeWLI=;
        b=DUkXoPOvGgwKYPL84SzPQh9RYKwikCVC48CdhtQ9cJvxxwBCCK2CHB9nQFvp2thjq2
         v74lxczHCdeSReZL5teoqQTl08rWOq/rduIJ+otTcbmraBNoUBrqvt/eGda/JEohu8q0
         82tolHqI4Xe/UHXBQFX/ub81IRB9cUzJaYE9il9r21oZKV72BUcd45pNno4NefSRC7Qi
         mRyFsrDXA+TIBNPAh0tHBKg0JRT+9vflYOC69LX3SkDoB048g5Hr+NZi3XoqbefEFFnX
         zGhTfcAoQJOHB7d8v/cvicJtMqOzLzttyT3mfBFMj2Rp6Kmv6sw57eCUWSC8AbMmlLID
         VcIw==
X-Gm-Message-State: APjAAAWhmttrUrHlgLsulU4ZVPFaL7qwZXD7KWuv7PxFehUhL8Fss4g1
        FRm4PmIdnRtX0f9kX+tSFpA02O9Bnbv9zOQMYHo=
X-Google-Smtp-Source: APXvYqyWFBsHpiYMrNgURil0/MoUn5q2xT9KRfhqcd1xxDnVzpyel0AJfWbDBjMiL7yeWZzq/nndt2iC6mceML6bQOo=
X-Received: by 2002:a9d:76d5:: with SMTP id p21mr31464805otl.308.1556395356561;
 Sat, 27 Apr 2019 13:02:36 -0700 (PDT)
MIME-Version: 1.0
References: <20190423090235.17244-1-jbrunet@baylibre.com> <20190423090235.17244-5-jbrunet@baylibre.com>
In-Reply-To: <20190423090235.17244-5-jbrunet@baylibre.com>
From:   Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Date:   Sat, 27 Apr 2019 22:02:25 +0200
Message-ID: <CAFBinCCf8fkBPR5aoPMensjhYKpan_UzG+HCEB5yNaYs+mB8OA@mail.gmail.com>
Subject: Re: [PATCH v2 4/7] mmc: meson-gx: disable HS400
To:     Jerome Brunet <jbrunet@baylibre.com>
Cc:     Ulf Hansson <ulf.hansson@linaro.org>,
        Kevin Hilman <khilman@baylibre.com>,
        linux-amlogic@lists.infradead.org, linux-mmc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jerome,

On Tue, Apr 23, 2019 at 11:03 AM Jerome Brunet <jbrunet@baylibre.com> wrote:
>
> At the moment, all our attempts to enable HS400 on Amlogic chipsets have
> been unsuccessful or unreliable. Until we can figure out how to enable this
> mode safely and reliably, let's force it off.
last year I have seen issues with HS400 on my Khadas VIM2: [0]
have you tested all other patches from this series and HS400 is still
not working for you?

I'm curious because this patch is early in the series and all the
tuning fixes and improvements are after this patch.


Martin


[0] http://lists.infradead.org/pipermail/linux-amlogic/2018-January/006251.html
