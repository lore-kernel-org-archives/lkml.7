Return-Path: <SRS0=c0gK=S7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 07FCEC43219
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Apr 2019 18:40:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CCB2B2087B
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Apr 2019 18:40:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="EuGV0Qng"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729139AbfD2SkQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Apr 2019 14:40:16 -0400
Received: from mail-ot1-f66.google.com ([209.85.210.66]:38644 "EHLO
        mail-ot1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728300AbfD2SkQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Apr 2019 14:40:16 -0400
Received: by mail-ot1-f66.google.com with SMTP id t20so9593958otl.5;
        Mon, 29 Apr 2019 11:40:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=AIxwIgNSfaujQ4GPPqUMnOdn83DSpET9dvXRMl5W0+w=;
        b=EuGV0QngoRp1elwK5NLy2DGZmqBuVLr+Ls3Odv97wQBLYLDBFPEkMfEfA2zyAP2O5F
         0VdGvddl/xHVevEZE6BkE5waIQh4YEM4xV3Ro+42lLI0O22XnJmpSzTNUqufoEKl1Zp/
         7NRTXt5btltp+knmeSLCs6OhZBI3K9QQxf84sUGj2JL9JMlC1GeEuBqlpY9LNAADfURo
         SDUzDON2q6bhZFRCZiRA72vL9fYo6/7KHlV8hdfujg+9ZwAJ9pFjP8hdBmr85Bht1VlQ
         9o0tAYtxpkKaoH19O5+anAHQhPWYwMK4UUSpfWXtaBAHKzLezEWJ7k/C+lD/BKWM+IM7
         bjGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=AIxwIgNSfaujQ4GPPqUMnOdn83DSpET9dvXRMl5W0+w=;
        b=WwckOu5GLZ8Autz4837CSCMlTwoFaw0vldR0V4fRXM+gnkPC5K1UCn1viAXkbrQc7H
         nRWXp+hTKXIQrnUsvJvZc5/AXijoqMI6mNUlQOWnobJ1C07lWWEkLf3Uy+KyrsfRyf6j
         OEsoE0jH9D7efODcaJFF0BZA6cLfude5aUhf8y3P9KsSljt6A5tVDoQxZjOQw4CLK+Ha
         wJ7osETGnGdD5w/zkL8ddf9MmLQ3w9F/Zovkg37JH/D9ocz62tt7AE69CBiszBsvsHTl
         aljj27DBcSo6jDRxHXlrMLYg6KWx1llmk0/39t8QKRlotiPPkigle+pzYgIUrYf8SEHT
         kbSw==
X-Gm-Message-State: APjAAAW9i2au75WGhZb555MZSTh5W36fBb2yRLucuPQJIjBZB0Mv1TPZ
        3wHD/lCriYcrv+yzRy2GC/77D5svkWRO9QQsb1E=
X-Google-Smtp-Source: APXvYqzFzy5rGcPg0FDIYVKVcBPB+ZcZhnT7+rWrK3IOiVig1P7nHguvCnh2+qmYXPpHc45YJrusPP0gkXKMi+QY1Ok=
X-Received: by 2002:a9d:3db4:: with SMTP id l49mr39429758otc.131.1556563215148;
 Mon, 29 Apr 2019 11:40:15 -0700 (PDT)
MIME-Version: 1.0
References: <20190423090235.17244-1-jbrunet@baylibre.com> <CAPDyKFoQyPKERckAdU+kkw3go=161PWc+5GAkz7y=xWMGbq+SQ@mail.gmail.com>
In-Reply-To: <CAPDyKFoQyPKERckAdU+kkw3go=161PWc+5GAkz7y=xWMGbq+SQ@mail.gmail.com>
From:   Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Date:   Mon, 29 Apr 2019 20:40:04 +0200
Message-ID: <CAFBinCBGU53h9063jj8n8q3whT=eZ9y6MPaYYqU_K9UXssK_nw@mail.gmail.com>
Subject: Re: [PATCH v2 0/7] mmc: meson-gx: clean up and tuning update
To:     Ulf Hansson <ulf.hansson@linaro.org>,
        Kevin Hilman <khilman@baylibre.com>
Cc:     Jerome Brunet <jbrunet@baylibre.com>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "open list:ARM/Amlogic Meson..." <linux-amlogic@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Ulf, Hi Kevin,

On Mon, Apr 29, 2019 at 12:45 PM Ulf Hansson <ulf.hansson@linaro.org> wrote:
>
> On Tue, 23 Apr 2019 at 11:02, Jerome Brunet <jbrunet@baylibre.com> wrote:
> >
> > The purpose of this series is too improve reliability of the amlogic mmc
> > driver on new (g12a) and old ones (axg, gxl, gxbb, etc...)
> >
> > * The 3 first patches are just harmless clean ups.
>
> Applied these first three, postponing the the rest until Martin are
> happy with all of them. Thanks!
thank you for taking the first three patches!
I am fine with everything except the patch description of patch 4 and
7 as noted here: [0]

Kevin, can you please also have a look at this series (if you didn't already)?
you reviewed earlier changes to the tuning mechanism in this driver.
it would be great to know that you're happy with these changes as well.


Regards
Martin


[0] http://lists.infradead.org/pipermail/linux-amlogic/2019-April/011488.html
