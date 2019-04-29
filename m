Return-Path: <SRS0=c0gK=S7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F17FCC43219
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Apr 2019 19:12:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BB00C20675
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Apr 2019 19:12:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="VaHFRdDR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729153AbfD2TMt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Apr 2019 15:12:49 -0400
Received: from mail-pf1-f174.google.com ([209.85.210.174]:41602 "EHLO
        mail-pf1-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729015AbfD2TMt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Apr 2019 15:12:49 -0400
Received: by mail-pf1-f174.google.com with SMTP id 188so5793646pfd.8
        for <linux-kernel@vger.kernel.org>; Mon, 29 Apr 2019 12:12:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:in-reply-to:references:date:message-id
         :mime-version;
        bh=I+Vwh+aj8i01Aoc1va0F0AKmwtckh5pIZyNVc/ubEjA=;
        b=VaHFRdDRj6eJOVFiKIr/NRI/A3CmYY51cWuDmljwcipcSkk9RAX15gqcfXiWrJl1Ru
         emAWKKzrlBq+t8cdY6lOPlvKuq3yhDe7dKqtfcJXJG3iys7N7On6QtchJm/gBaigOn8E
         LwY2bdmB7p7Nn3i8xS6ycyXdP/LyEzqyT573AQBm8ONdienOep0ZnsZ6S9qc254wr4f3
         hH0QJ0QYBrYth5M5Q88XC/GrGyd00QjVFh23+P0Fgz/vKAItIGfNfvMtAaiz6J3MFlNT
         QVJhZklgjYiuw1U3U7svnW9w97PB6OBuF77wY8gVWDYpM8mv02iXSi3cLzlhH22xbnC0
         x7Og==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version;
        bh=I+Vwh+aj8i01Aoc1va0F0AKmwtckh5pIZyNVc/ubEjA=;
        b=W+tvHgH+PynNPfAo2t32ki37CA55MKP+j4cZGU6fC4ruUIOdhub+zLTlneTLqfihBC
         t4cwiD5qK5GkotBDrQgawkaJwJKQGf7HH1CtVgb/wVec2VT4nSwVZ1vu9qPLsCoaER6Y
         9/Fowa11iCGdSpBkw3InTvkJyjZNZfg65pTLM0TI9SY5FaYm15iglXtcjJDqVpjYSk+Z
         lZ3bLd5yJ30yO5hw4Kmmm9/nbdLkvdl5ZZ1r6RZfAlUYyFLupLi5sEdV7aSOCv62teN8
         yq3M7TF38mpIF8uKQuPH4/gbjFlRtt4h3v2zxbjS0y8xjXYuSgQUQwHYr8KKolL4TOse
         VchA==
X-Gm-Message-State: APjAAAX8C0DgKCNjjoOolKzDOuqyCWCHXp1pNF6rsp+Ckj4RdV9MfGlx
        sxwT6TLdfLmUKUMDD3zsJQKr2g==
X-Google-Smtp-Source: APXvYqwfpP13ENa3/d3PDzljfX3CD44ZmLJDWwRIZ1vdZggbfqA1LXOkJGHBQJhUusCrVAuzyQhPGw==
X-Received: by 2002:a63:8242:: with SMTP id w63mr12207839pgd.169.1556565168285;
        Mon, 29 Apr 2019 12:12:48 -0700 (PDT)
Received: from localhost ([2601:602:9200:a1a5:f580:39a4:9be7:1974])
        by smtp.googlemail.com with ESMTPSA id q128sm51546066pga.60.2019.04.29.12.12.46
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 29 Apr 2019 12:12:46 -0700 (PDT)
From:   Kevin Hilman <khilman@baylibre.com>
To:     Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        Ulf Hansson <ulf.hansson@linaro.org>
Cc:     Jerome Brunet <jbrunet@baylibre.com>,
        "linux-mmc\@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "open list\:ARM\/Amlogic Meson..." 
        <linux-amlogic@lists.infradead.org>
Subject: Re: [PATCH v2 0/7] mmc: meson-gx: clean up and tuning update
In-Reply-To: <CAFBinCBGU53h9063jj8n8q3whT=eZ9y6MPaYYqU_K9UXssK_nw@mail.gmail.com>
References: <20190423090235.17244-1-jbrunet@baylibre.com> <CAPDyKFoQyPKERckAdU+kkw3go=161PWc+5GAkz7y=xWMGbq+SQ@mail.gmail.com> <CAFBinCBGU53h9063jj8n8q3whT=eZ9y6MPaYYqU_K9UXssK_nw@mail.gmail.com>
Date:   Mon, 29 Apr 2019 12:12:46 -0700
Message-ID: <7hwojcr5g1.fsf@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Martin Blumenstingl <martin.blumenstingl@googlemail.com> writes:

> Hi Ulf, Hi Kevin,
>
> On Mon, Apr 29, 2019 at 12:45 PM Ulf Hansson <ulf.hansson@linaro.org> wrote:
>>
>> On Tue, 23 Apr 2019 at 11:02, Jerome Brunet <jbrunet@baylibre.com> wrote:
>> >
>> > The purpose of this series is too improve reliability of the amlogic mmc
>> > driver on new (g12a) and old ones (axg, gxl, gxbb, etc...)
>> >
>> > * The 3 first patches are just harmless clean ups.
>>
>> Applied these first three, postponing the the rest until Martin are
>> happy with all of them. Thanks!
> thank you for taking the first three patches!
> I am fine with everything except the patch description of patch 4 and
> 7 as noted here: [0]
>
> Kevin, can you please also have a look at this series (if you didn't already)?
> you reviewed earlier changes to the tuning mechanism in this driver.
> it would be great to know that you're happy with these changes as well.

I've reviewed the series, and am happy with it as is, including the
changelogs as is.

Ulf, for the series, feel free to add:

Reviewed-by: Kevin Hilman <khilman@baylibre.com>

Kevin
